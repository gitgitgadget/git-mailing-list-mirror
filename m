From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use test_expect_success for test setups
Date: Sat, 20 Mar 2010 08:42:27 -0700
Message-ID: <7v7hp7ov8c.fsf@alter.siamese.dyndns.org>
References: <1269073751-64588-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0ox-0001ib-KK
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0CTPme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:42:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab0CTPme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:42:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CF3A2E2B;
	Sat, 20 Mar 2010 11:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTwFFgk/4GZp1FjCUHCrMvfRt/0=; b=FkhNcI
	ejamIWvYy3KnLGLo5cLjzvG74P8feQi1cqDdLh3Dgau8CLxBz0xjoiI0eXU4bCee
	BFVR790KbKGgdDZqF7BTJW9XL7HaVXINgmUcnb5HARS75KtPDARfDHCX3FK/zUsv
	xtusYqiU6CKpBw2onHy84wwQ22BcSDEtcYl8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oVmp/KA2cf70Mky+CBoS7JGlcJXySEfl
	kxyzcaK8OfKUzFtFnaHhRFlIxqhqmMGm5aubg/yp7uOoC5S+UskjT1yzlR7SiZVC
	s4BS2wHXHT/QO6ipUoYtuMo8HqxzEPIT2dAV57+mG9CLUAr5R2xOF9ZO2+/Z7Cue
	u0d0OR4g+7U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A71E9A2E29;
	Sat, 20 Mar 2010 11:42:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2000BA2E27; Sat, 20 Mar
 2010 11:42:28 -0400 (EDT)
In-Reply-To: <1269073751-64588-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sat\, 20 Mar 2010 04\:29\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32532428-3437-11DF-94BC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142718>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> Several tests did not use test_expect_success for their setup
> commands.  Putting these start commands into the testing framework
> means both that errors during setup will be caught quickly and that
> non-error text will be suppressed without -v.

Nice.  Should the one in 4103 be three separate tests?  They seem to be
preparing the set of test input files and are not expected to fail (unless
of course you are futzing with diff-tree, but for that we have t4013).
