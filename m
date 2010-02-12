From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr` configuration
 variable.
Date: Fri, 12 Feb 2010 14:00:22 -0800
Message-ID: <7vocjum7wp.fsf@alter.siamese.dyndns.org>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
 <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de>
 <7vhbpnqrxr.fsf@alter.siamese.dyndns.org> <20100212210336.GB32018@pille.home>
 <7vr5oqnmzr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3Z9-0007BG-2S
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab0BLWAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:00:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab0BLWAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:00:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B4E09762A;
	Fri, 12 Feb 2010 17:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZulmM9JEqve9havekihPDOyYt28=; b=CAHte+
	5clobULMTZ1Jze6ClIz3gt1boto9/ZTwIBF/ftwMxFXNeFOW1fycho0HYmFKd2t0
	/dt9yu4qCtoth9AFRG1sS07p7OMPIPFxSVJ+dhyh/BU/6NqfXJJIGy+3KXEYUDDk
	HgwyEz9VfhBBuHJV3wu00qp+khexLdS7bKHPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0CrAj0J8LigPOwIxzEgcmNwwR6ZNinc
	062kc0y2WkNWE+RLfW/fRKP0Jfcgp/7rtGeR48mCFfFYOFptypWaI7gidRupRJwE
	GCAhhMTP0B2fmyl7tIQ8iS4z2DXwio3lN69YcL24/JVe4WPHpiZUAU8Nq9Gm58TQ
	mKMW4P8/J7g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D84B897629;
	Fri, 12 Feb 2010 17:00:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0EF297628; Fri, 12 Feb
 2010 17:00:23 -0500 (EST)
In-Reply-To: <7vr5oqnmzr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 12 Feb 2010 13\:49\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 078509CC-1822-11DF-B611-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139754>

Junio C Hamano <gitster@pobox.com> writes:

> "Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:
>
>> But perhaps it will be a better aproach to make such a configuration
>> available for git-am. I will make a patch for this soon.
>
> If a configuration is desired, I think that is probably a saner place to
> put it.
>
> Regardless of where the configuration goes between am and mailsplit, you
> need to think about the interaction between rebase and am.  You might set
> the configuration for am---should that automatically and always kick in
> when you run rebase?  Do we need some way to override it per invocation
> when running rebase?

Nah, I wasn't thinking straight.  There is no reason to turn it off while
rebase is running.  That means under --rebasing mode, am should ignore the
configuration and always do keep-cr, even when am.keepcr is set to false.

Sorry about the noise.
