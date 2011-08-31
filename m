From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Tue, 30 Aug 2011 17:18:22 -0700
Message-ID: <7vr542zb5d.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com>
 <7v1uw36fgb.fsf@alter.siamese.dyndns.org>
 <CA+55aFz9givAWhP5_SfnneY6x_0ekcN2U9HrKr+NTgY=Ot=6TQ@mail.gmail.com>
 <7vfwkj4wff.fsf@alter.siamese.dyndns.org>
 <loom.20110830T081442-547@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 02:18:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyYVl-0004mb-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1HaAS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 20:18:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab1HaAS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 20:18:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97868421C;
	Tue, 30 Aug 2011 20:18:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPPrcVczMrskpR0mPMTVK4l8gQU=; b=eqFoh0
	bK5alg6Cn0pGdQhc8z3f5cBpEG0449nRMlVmRFN/mL+zw6mmmNGq/JGU2kudpC9l
	FdiZVkLFjw8w0YUf3hEtCeLGmBppx+o5wPnS73kJxqlIKSigvlt6E8/SedCvPcrI
	tdpAIbSo5dGZ0XsBua1BjEGF7HW9U88T8zuJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/mAGLv+Eeo9nNfolPTJIZ9cUoFvK9T/
	JAql3rg2lnjuWhPyOpaHoju7q1U8UxGakrRpWE6C3Tv7VBk9gtAEl0YayYksjRoV
	5cIk0Ogh/H3CRAf3xyT7U5s5EDtKxTUyZTMaN23JMTVZLyYWfobiNgjLFgjtArWI
	QRZBHKVUMCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F35C421B;
	Tue, 30 Aug 2011 20:18:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 257B6421A; Tue, 30 Aug 2011
 20:18:24 -0400 (EDT)
In-Reply-To: <loom.20110830T081442-547@post.gmane.org> (Marat Radchenko's
 message of "Tue, 30 Aug 2011 06:16:04 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD911796-D366-11E0-BA9F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180449>

Marat Radchenko <marat@slonopotamus.org> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>> Marat, if/when you have a chance could you try a patched git on your
>> original use case and see if it produces correct output with shorter
>> amount of time?
>
> 30s without patch and 0.3s with it.

Thanks.
