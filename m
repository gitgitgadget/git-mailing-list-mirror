From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1509: update prepare script to be able to run t1509 in chroot again
Date: Sat, 11 Apr 2015 12:58:58 -0700
Message-ID: <xmqqr3rqa131.fsf@gitster.dls.corp.google.com>
References: <20150331191420.GE22844@google.com>
	<1428055737-8943-1-git-send-email-pclouds@gmail.com>
	<20150403120109.GB22170@peff.net>
	<CACsJy8D3Rk51JVvwivj8BwTjprhYC7aEbfY4vF+4Mo-cn5taLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:59:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh1Yf-0006S7-B1
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 21:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbbDKT7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 15:59:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755511AbbDKT7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 15:59:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D3C456B4;
	Sat, 11 Apr 2015 15:59:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KKTZFp2BsPm9ZNBFZixQ7Ysjl48=; b=LMwmQL
	0r0ywa6XQb7Xxd4nkBpwiA7ebtEH5JLdNAIpH49erTNb4OJV3hP44VSF+ywj8l6q
	N2sTL5IeOrJztEkj48dsNRYncgI7c7NEEma3CkgzDz0QdsJ7TYbzQFX/KZ1kn0v6
	hDQjvD3rAdOopWfrOOMFikcKGXW26wqrLlNfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LUTipslxRaskQxeLc9MXlK4Tx3kOhNjf
	2qBjIBvXtmQtLoHjMUcsdstjCf2xrJsdBmbA5Rk60TWvwpv3w739vjyISBYgKouM
	JJsTVUyESvCy5zxgzofmTXVAdBFPuHjfoJepJfUnDV7BT68iiDetrt3fnalA+Fmm
	hycsCdDbv/E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08845456B3;
	Sat, 11 Apr 2015 15:59:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DC5F456B0;
	Sat, 11 Apr 2015 15:58:59 -0400 (EDT)
In-Reply-To: <CACsJy8D3Rk51JVvwivj8BwTjprhYC7aEbfY4vF+4Mo-cn5taLw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 3 Apr 2015 19:14:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 318E5DC8-E085-11E4-AFE2-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267030>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Apr 3, 2015 at 7:01 PM, Jeff King <peff@peff.net> wrote:
>> Aside from the nits above, I did get it to run t1509 with this. I can't
>> say I'm incredibly excited about the whole thing, if only because it is
>> clear that nobody is going to run it regularly (so regressions will
>> likely go unnoticed, which is the whole point of the test script).  But
>> perhaps it is better than nothing, and it is not hurting anyone to sit
>> there and bitrot again. ;)
>
> To be honest, I didn't run it often in the last 5 years. The code it
> protects seems not broken during this time and probably so for a
> foreseeable future. So I don't mind if you just kill t1509 and related
> scripts.

Yeah, but as long as you two worked out to make it run again on at
least two systems (i.e. yours), it would be good not to let that
effort go to waste. Care to throw a v2 at me with $(id -u) and other
changes Peff mentioned?

Thanks.
