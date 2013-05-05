From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 05 May 2013 13:58:09 -0700
Message-ID: <7vzjw9ta8u.fsf@alter.siamese.dyndns.org>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
	<CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
	<7v4nehuu3o.fsf@alter.siamese.dyndns.org>
	<CAMP44s3JtLzE0vne5VH+bHrLvSuOwaWwuGa7DFggjEOt6ixgTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 22:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ60g-0006lT-Kx
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 22:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab3EEU6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 16:58:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab3EEU6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 16:58:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 223401C70F;
	Sun,  5 May 2013 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XKATj/YRMC8l9TzK6En2vAdjTHY=; b=e9Nvev
	9Tnydo817IYF7WczU26g921pA+k7AOMa/oGiq3srMo58aBZAm1AeugjvlID+rk94
	GCPDIJwYWgvwh43Uh/MQh1K+rLNBWng5Qzu0BH5CvEzbRXWZb5nYQPEeT6uDRJKT
	/5uh6IiColhHBTaTTcdR+mt/XmI52TW4N3ofI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GT6EuEkKIzzLbqPqTkMCKYQ511jmq+Du
	Mo9uA2Tz2qpvo7jK9829Yk1WuUTLm1Q7pngPrUmZv3sKFp4SyPWNMr8yvoGoeN6m
	PQKTZ8NzFBDVpOwx4B6+COhwBg2RMTBo5ntazaNYh4DZPGc0fqkE9ennBCMDkj1h
	7HeBxTq93Ok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 171E71C70E;
	Sun,  5 May 2013 20:58:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BAE1C70B;
	Sun,  5 May 2013 20:58:11 +0000 (UTC)
In-Reply-To: <CAMP44s3JtLzE0vne5VH+bHrLvSuOwaWwuGa7DFggjEOt6ixgTA@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 5 May 2013 15:24:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F1884D8-B5C6-11E2-B95A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223417>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> So do you want to queue these on top of the "massive" in 'next', not
>> directly on 'master'?
>
> If they apply on master, master. But I'm confused, are the massive
> changes not going to graduate to master? Because if not, I should
> cherry-pick the safest changes, as there's a lot of good stuff there.

I think we discussed and agreed that we would ship it in 1.8.3 if we
hear positive feedback from Emacs folks, and my understanding is
that I was waiting for you to give me a go-ahead once that happens.

It is entirely up to you to add these two on top of that "massive"
stuff, their fate decided by feedback from Emacs folks, or apply
these as "much safer than those we need to hear from them; we can
verify their validity and safety ourselves without knowing the real
world projects that use the program" patches.

The impression I was getting from your response "I hear it breaks
for some of them without the patch but I haven't seen the breakage
myself" is that it is safer to group 2/2 as part of the rest of the
series, but as I heard in the same message that you heard Emacs
folks are happy with the entire series, so it wouldn't make much of
a difference either way.

Will apply these two to the tip of the "massive" stuff, and merge
the result before the next -rc.

Thanks.
