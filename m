Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356AA1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbcHASmN (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:42:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754284AbcHASmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:42:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4AFE316B7;
	Mon,  1 Aug 2016 14:41:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RmesKT/bbWzD+4Lgy7iMtYGMSwg=; b=B/G1QQ
	zsufu4XY7QynzyNvPkBwQitX3x79i8+gTwQsPjVikxi5ynkyV6WjQwDmn4pxUK2P
	72cjCgvO4xhJqhXoU2lyyoQj/DksaOWB4lL+HxfgN4n8Av42vheCfaq3Vgzq6Qr6
	++GtPzfZyY0xDZqgy5BDj3GKmTxi5N6XP+utg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hbpb0MhxkDpd8dUuQHajmHVEVV6tQqv3
	4eIlkiANNJ9Ewn9WLdsMMwBFLsLU0fbTbewvhNjG7L7N/6HPmIiOroos71PaKeCM
	dQVx7NRAFofUF/NGYeHKens93sOJc9myH7SxrSm+N2k7wW3X+VwTbWhsk/1WltTm
	S5oFhtwnjIU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B03B316B6;
	Mon,  1 Aug 2016 14:41:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18482316B5;
	Mon,  1 Aug 2016 14:41:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
Date:	Mon, 01 Aug 2016 11:41:33 -0700
In-Reply-To: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:13 +0200
	(CEST)")
Message-ID: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93659600-5817-11E6-9A54-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors

s/merge_/merge-/; for this one alone.

> There are a couple of places where return values never indicated errors
> before, as wie simply died instead of returning.

s/wie/we/;
