Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF262021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbcHBW32 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:29:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754533AbcHBW30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:29:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 155C933462;
	Tue,  2 Aug 2016 18:28:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xedptgw2bf0puXpOqRpELAr0KtM=; b=jqm0U4
	5CWAPA6wuQNzkPGASAJSMVAErtP+Sc1eV1bRGxGR3gOK8z6339K2e8l05LtjYStB
	aazL5mRtbGg9LvHFfff/hOP2u8SU2tq+jIrPEOm89jFugAa4lSWsxPxg2nPmIvmZ
	99kQ2v1oln/XSZlDH2p6GzP99nC2RM4rt6XB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PeUO9+0w56ex70Ah7rtUP/FKVs5mZtl5
	1Y3vsIyRPMf3KmniEP+rikyPjtehx5VYTwwoH3R80zXZhXra3lhxfHnobpCw+Dv2
	+BK+K1Y+BODWZPRGIsEqUl05DoxmkHR17Vg8TCeqYglEqPsgKuJyDvU6ioJ6Pz2B
	xoGg9p2NEgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BC5733461;
	Tue,  2 Aug 2016 18:28:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EA9033460;
	Tue,  2 Aug 2016 18:28:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
Date:	Tue, 02 Aug 2016 15:28:22 -0700
In-Reply-To: <alpine.DEB.2.20.1608021004080.79248@virtualbox> (Johannes
	Schindelin's message of "Tue, 2 Aug 2016 10:12:29 +0200 (CEST)")
Message-ID: <xmqqd1lqbybd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D0573C4-5900-11E6-8D20-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I tend to think that the underscore is correct: this change is not so much
> about the builtin (which is written with a dash) but about the function
> (written with an underscore, used by more than just merge-recursive, e.g.
> cherry-pick).

Yes, I agree.  "merge-recursive:" prefix is about either the
built-in command, or the machinery as a whole to support that
built-in command.  It is preferrable to use "merge_recursive():"
if we are talking about a single function.

Thanks.
