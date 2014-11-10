From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Mon, 10 Nov 2014 11:58:49 -0800
Message-ID: <xmqqy4ri969y.fsf@gitster.dls.corp.google.com>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
	<20141109092344.4864.88180.chriscool@tuxfamily.org>
	<xmqqbnof9c9d.fsf@gitster.dls.corp.google.com>
	<20141110.200502.1295000903783079007.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johan@herland.net, tr@thomasrast.ch,
	mhagger@alum.mit.edu, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnv72-0000rF-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 20:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaKJT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 14:58:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607AbaKJT6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 14:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C1FF1C53D;
	Mon, 10 Nov 2014 14:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h5uKt1lGGn8ypQGOsftXmH51woU=; b=AhleC1
	IHhBxcyzx4YAL25ic+e/f2wfTfWyPLXTIORSwe2tRoyNDLQQIRyTcMtrbYslHonW
	RKfn2rqqYP0sEDs9P/sMG6CIfvRRiU+0KSby+Mk3OQAENQeO2zFgXIlqykFWmY8Z
	zx7ZTH60dxOLHaqgXdbkETbY5D9OIBPN69tXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F5ehiPeC1J561iUtTXWGJxna4HO2jvhL
	Kn9aihYqOiXAb6LiU+ixWl40P6Mwm3P93H+t2B1vM60H4KbRLL+fGWOPmnqvziKQ
	4XTayfmG0YSufJG9qPQ45CdymeWwg2jb9qMEuXQXVN84l1s4sHzCpDbgoR4w0Pkr
	BsdPAJz7bCs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 927D61C53C;
	Mon, 10 Nov 2014 14:58:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA71C1C53B;
	Mon, 10 Nov 2014 14:58:50 -0500 (EST)
In-Reply-To: <20141110.200502.1295000903783079007.chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 10 Nov 2014 20:05:02 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDAC8B12-6913-11E4-A778-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
> Date: Mon, 10 Nov 2014 09:49:34 -0800
>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> 
>>> Make sure we look for trailers before any conflict line
>>> by reusing the ignore_non_trailer() function.
>>>
>>> Helped-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>> 
>> It makes sense to unify the logic to decide where the trailer block
>> is, I would think.  I however don't think I helped this change in
>> any way, not more than "maintained the codebase as a solid
>> foundation to build new features on", but at that point it would
>> apply to any other change and not worth mentioning ;-).
>
> Do you want me to resend the series with only the Helped-by removed?

Nah, I've already removed it.  You have better things to spend your
time on ;-)
