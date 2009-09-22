From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square
 brackets in subject
Date: Tue, 22 Sep 2009 09:15:56 -0700
Message-ID: <7vocp3t0oz.fsf@alter.siamese.dyndns.org>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
 <1246310220-16909-1-git-send-email-rleigh@debian.org>
 <87hbuv5km2.fsf@janet.wally>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neil Roberts <bpeeluk@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq82F-0000ac-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbZIVQQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbZIVQQA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:16:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZIVQP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:15:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0463C290;
	Tue, 22 Sep 2009 12:16:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rnAVoTJfDzvG1Ot4i/rV5mmBxTI=; b=vCmIzJ
	2dkPiLjTnuMprpNBVYUDN+MQ+j0TZmqvin5JPFygBEoHMc48qLNJxBEHTlgCb38D
	9esk0T3bCD1jGb8vXP9X11rauBqDsnLl/OMYeYcKvkpt9GTZccnwJ0uRugE0e3q4
	T3zIfqtnlnjdASqffTjBsB8q+vCPGvjwrLixA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHhBNbNTRC9duuc9mJofiRqnmn3oPFxy
	xY/SCW9X/383EjqPJ8w7A7awsGBuIp7NHh6MW1MnkAYZMFgK9rsipVKQqE/OtL/z
	DgBMMSx65wiM7uekypbDBDmOAsA8nKif6srQthF2vuwFT7nQwx3KomCDBBqMzBCR
	L26R8qiPYwg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D27B3C28E;
	Tue, 22 Sep 2009 12:16:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2B603C28C; Tue, 22 Sep
 2009 12:15:57 -0400 (EDT)
In-Reply-To: <87hbuv5km2.fsf@janet.wally> (Neil Roberts's message of "Tue\,
 22 Sep 2009 11\:39\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37BC2936-A793-11DE-86EB-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128946>

Neil Roberts <bpeeluk@yahoo.co.uk> writes:

> Roger Leigh <rleigh@debian.org> writes:
>
>> Use a regular expression to match text after "Re:" or any text in the
>> first pair of square brackets such as "[PATCH n/m]".  This replaces
>> the complex hairy string munging with a simple single pattern match.
>
> Is this patch going to get applied?

I do not think it is likely to happen for a patch without much comments
nor progress after this long blank period, without a refresher discussion.

It definitely won't be applied silently in its original form, especially
because the final comment in the old discussion on the patch in question
began with "One could _update_ ..." from the author of the patch, and then
nothing happened.

    http://thread.gmane.org/gmane.comp.version-control.git/122418/focus=122466

I actually liked the much simpler one by Andreas in the original thread,
but if you really want to use a regexp (which we didn't have to) we should
make it configurable.  See the neighbouring discussion here as well.

    http://thread.gmane.org/gmane.comp.version-control.git/123322

I think we all agree that the behaviour should be improved, but I think
neither Roger's patch nor Andreas's one was the solution..  People who
care need to carry discussions and proposed patches forward to help us
agree on an acceptable solution.
