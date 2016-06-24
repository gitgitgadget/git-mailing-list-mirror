Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F672018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbcFXTpL (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:45:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbcFXTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:45:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D16E25696;
	Fri, 24 Jun 2016 15:45:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8KxgaFghxlVQbmIc6yJc1oAcBZM=; b=axeATv
	6bgMoYwu0SdoIP+/DfKi/W4fLPIdKOiQJ93mQ0rjkj9BszISDv2xnikhqviTEdrS
	2STqaDb6IW0z/hE70hl73h945Vp443JJdIUCRkHH5k778dO3c3tvbavv5APj3uvO
	Akkrs0fnxMroZ2kzXTl0Ywwid1dPWeEVFVvxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVD7/yQwwBPguwqmRrdnAf/5+kX31ux5
	hUOBk/Ican1vw1LqvGG7Ek2TwdFtZNNUL4ZzWXdX8xB9ypvMoounTT2kduKml0Xe
	F5bEVyfIeW0ekb9zuc5Xb8J4nssFVYRVRV+YrQoqoe0mwJlRk5wx0SGccrDyTB0P
	IXsEbsCXPto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92B3725695;
	Fri, 24 Jun 2016 15:45:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F4E625694;
	Fri, 24 Jun 2016 15:45:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 2/4] archive-tar: write extended headers for file sizes >= 8GB
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232104.GB3668@sigill.intra.peff.net>
	<xmqqwplefm2r.fsf@gitster.mtv.corp.google.com>
	<20160624191044.GB32118@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 12:45:05 -0700
In-Reply-To: <20160624191044.GB32118@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 15:10:44 -0400")
Message-ID: <xmqqfus2fk1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2735D9C2-3A44-11E6-A615-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So if anything, I would put a comment here, explaining that ustar cannot
> handle anything larger than this, and POSIX mandates it (but I didn't
> because the commit message already goes into much more detail).

That sounds like a good thing to do.  Not everybody runs "blame" to
find the commit whose log message she must read before touching a
line.


