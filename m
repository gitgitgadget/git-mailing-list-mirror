From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 21:32:07 -0700
Message-ID: <xmqq4n0l2hq0.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
	<xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
	<537a75e0a53b7_afee5d300f3@nysa.notmuch>
	<xmqqzjidv1y4.fsf@gitster.dls.corp.google.com>
	<xmqqvbt1uzo0.fsf@gitster.dls.corp.google.com>
	<537ab8a0d1304_2edfa832fc53@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:41:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmbir-0007Cm-JP
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 06:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbaETEcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 00:32:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62522 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbaETEcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 00:32:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7FE61364C;
	Tue, 20 May 2014 00:32:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xFmhHohzj6IuRwUTkb3mC5GSTtU=; b=svFQv6
	BOE4RMnlkD8R5ht0wcjyKcld2Vyfgini4WuzY7/ZzNZEtc0y9wNcBE54JJ7Fj6aO
	mEQ0YKDNHgd9/wPWsPLJGKlbfll/kqf5cFXjuhoHPjpr4k9X8/XQD02GXu/JN0Jm
	m3ozfeA6tO1zzQHVT5uldbqImPD20j0yALpDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrFe86q3SnUYtFBfB/xogOh1mnI6ZbbI
	iGoeuYye30VjT66WZT165GZ4CoeNK/+2reldTWz3vpN1SKMgS0XbQ+xsFWY6WRPd
	HEp4AFYdhVbmIhB76DClmQxtdlZu+/uQWpzfV53p7tUgsT+p1bf1+8+Co4xTNll8
	K68vDCHgN68=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFBDF1364B;
	Tue, 20 May 2014 00:32:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 764A51364A;
	Tue, 20 May 2014 00:32:08 -0400 (EDT)
In-Reply-To: <537ab8a0d1304_2edfa832fc53@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 19 May 2014 21:06:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B42B1DE8-DFD7-11E3-9004-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249653>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >
>> >> We could. Personally I don't see the point of making the warning any
>> >> more annoying....
>> 
>> If we were giving the users a choice of "no thanks, I'll keep using
>> the obsolete one", then trying to be a low key and giving them a way
>> to squelch with an advice.* config might make sense, but if we plan
>> to remove/stub at as early as v2.1, I think annoyance is very much
>> what we want, actually, because it clearly is the case that we do
>> prefer users switching instead of waiting for v2.1.
>> 
>> How does this sound?
>
> The patch below assumes the user has ~/bin in his PATH, which might not
> be the case. Personally I don't see the point of creating extra
> annoyance with instructions that might not work.

Yeah, I would be lying if I said that "that might not work" did not
bother me, but I decided it would be on the good side of the
borderline (it is better to be concise and slightly wrong than
ultra-verbose and precise).  As you may have guessed, they were
stolen from your earlier message that shows what the site says after
all ;-)

I will probably tag -rc4 with the patch applied sometime tomorrow.
