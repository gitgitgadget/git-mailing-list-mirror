Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23DF20196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbcGNUeI (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:34:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbcGNUeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:34:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F31902AB2C;
	Thu, 14 Jul 2016 16:34:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XiSwJZQqW5L2w8+ePbbvOVwDQto=; b=WpYhx9
	/ZJj1h0IcnYpnz36LZI+SDrrR8GuE4oaTvXCDNwjyAGSOjihzkS7YnuE//W4deYV
	KoFTU1QyfrcwOxqgUp5XAK24Vf503dFkazR9FmCcNTTfquK59ET/ykljECqFyAe3
	32aFD8JqMhvAe2dhqVFVeJKRJmQBW2c5AKY1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKpG6SoyxMmBHDUi9T8hVuMraDZYZsUo
	YJLxrQ0UyPyGV7IjFXzKymaOeVV/bQsjnKDHH3ssPENRXWYZUaurepWU1n4b/r/C
	EkvWuchXzHD/eO8R63LxU8GR1gwC0RTVhHjPno/3bPP+lD5sJi+ONFoiTcBhRpsY
	AAQqUl3l598=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA89B2AB29;
	Thu, 14 Jul 2016 16:34:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E5582AB28;
	Thu, 14 Jul 2016 16:34:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<20160714182108.GB16497@sigill.intra.peff.net>
	<xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
	<20160714201018.GA18372@sigill.intra.peff.net>
	<xmqqbn20otqu.fsf@gitster.mtv.corp.google.com>
	<20160714202727.GA19101@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 13:34:02 -0700
In-Reply-To: <20160714202727.GA19101@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 16:27:27 -0400")
Message-ID: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E40B014-4A02-11E6-9726-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, that is what I was trying to get at, but you stated it much more
> clearly. LONG_IS_64BIT is good. I wonder if the "git version
> --build-options" should be "sizeof-long", too. It's shorter, and
> indicates our assumption that we are talking about all longs, not just
> unsigned ones.

OK, I'll do a final reroll and then wait for Europeans ;-)
