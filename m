Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0592C203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 06:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbcGZGrG (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:47:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753564AbcGZGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:47:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DE132CD92;
	Tue, 26 Jul 2016 02:47:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lkb8tBSWds974qRlNotAjE/IB0U=; b=C59ADJ
	L++KnU+0uA0buk2e8ns75jeW3CZYnoSaFwCypjKbMNuYJQNg2ybUw2cbJEc9JdBc
	6gLYZNGZ8Cgls1aBg9nEKcHKcTcx1tAQGkZ/2gkFEInao4E5IAoyfM3WLZDfgWjv
	c+jJKCAWvPsLzNn03Kvp/SkHFmm0WZozOD28o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXQv6S+g5oo4Yd77MUaWP0MjIFr04mV8
	DwCcd58CqRgYNOqrdFvwq9KnP6sxG0D5lCPrn8H+ZXDkV7GTPBScwZH0vwDbZ0J0
	d5eCgPXTgWRKrZPU1+ECoS139KYME7x8RtYOSUqRohJ0JKYQv+2lVfy0vg5iSHYt
	Hq/vuZKi5gg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 349342CD91;
	Tue, 26 Jul 2016 02:47:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFA532CD8C;
	Tue, 26 Jul 2016 02:47:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
References: <20160725162125.15734-1-pclouds@gmail.com>
	<CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
	<CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
	<xmqqinvt610x.fsf@gitster.mtv.corp.google.com>
	<20160725203316.GA32053@starla>
	<xmqqoa5l4fh0.fsf@gitster.mtv.corp.google.com>
	<20160726061854.GA13334@starla>
Date:	Mon, 25 Jul 2016 23:47:00 -0700
In-Reply-To: <20160726061854.GA13334@starla> (Eric Wong's message of "Tue, 26
	Jul 2016 06:18:54 +0000")
Message-ID: <xmqq8two3nh7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C25A8012-52FC-11E6-86EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I dug around the freebsd history (git://github.com/freebsd/freebsd.git)
> (~1.5G) and the 3.x and 4.x releases with perl in base still contained
> many references to /usr/local/bin/perl
>
> It also seems FreeBSD 2.x releases were also perl-less in base;
> so yes, I'm alright with Duy's patch :)

Thanks for a quick digging to converge to the simplest solution.

Will replace and merge to 'next' soonish.

