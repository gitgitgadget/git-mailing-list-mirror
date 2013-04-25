From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 14:11:17 -0700
Message-ID: <7v1u9y2u4q.fsf@alter.siamese.dyndns.org>
References: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
	<87haiu7jgn.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTRu-0002Cb-P9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759318Ab3DYVLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:11:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759250Ab3DYVLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:11:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDCA91971E;
	Thu, 25 Apr 2013 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZtP3zfXfzpHLuzWCeMRB2QJflmI=; b=aR1k2/
	KHhy81zNRHuP1Hylxiyi57xT6tdM9SlGeZI9FUeZSkHjX7fghG/RV8ngYIkmazUk
	589IilZ3HYZCoD3dL/5B5dOR1fNnc6G7UQbKLiZmvll4BeMbDWCvKHI7AmDn44WW
	EeWarbFR50Mpx7hXzvvYbLqDTIxAB9wfzQ6wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vxdk18R2W3+A7IvAX05MmsS8gSfuwofV
	Zy+hUL5icnThIwzuPMC+tVKwkjzi50XrSeAjIdrWAr+tNIPYBd8STX8ePtOBDOIU
	rsdCQwJE8T4nNdhhCkK/elK9M5ogfpSxXYIQLKpiF5PZp6S2RWS0sgTlQwCAvR9O
	zJ6CawBL0dE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52841971C;
	Thu, 25 Apr 2013 21:11:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05CB61971A;
	Thu, 25 Apr 2013 21:11:18 +0000 (UTC)
In-Reply-To: <87haiu7jgn.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 25 Apr 2013 16:50:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC5F5EE4-ADEC-11E2-A35E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222449>

Thomas Rast <trast@inf.ethz.ch> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Not just randomly synchronize the revisions with no checks at all. This
>> is the way bazaar's UI does it.
>>
>> Also, add a non-ff check.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> This patch should probably go to maint, as the results of pushing the way we
>> currently push are not really understood. Perhaps it's similar to a 'git push
>>  --force', or perhaps it can potentially screw the repository.
>>
>> It's better to be safe and just do what bazaar does.
>
> Other than "this patch should probably go to maint", this should be in
> the commit message.

Hmph, should it?

I do not quite understand what "... are not really understood.
Perhaps..." wants to say.  Understood by whom?  By the author of the
patch?  By the author of the original code?

The log would end up saying "Doing the same as bazaar should be the
right thing to do(TM), but don't ask me why.  I do not know what I
am doing, or why checking is better than not checking, but it seems
to work".  That _could_ be the truth, but it won't help people who
are reading the code later, will it?
