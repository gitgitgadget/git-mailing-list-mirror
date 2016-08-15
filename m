Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9FB1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbcHOUtY (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:49:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932115AbcHOUtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:49:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 757FB3499C;
	Mon, 15 Aug 2016 16:49:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oGhy81mHB1eUYK3wz+oYcn3T5+s=; b=qwNzt8
	ezSZvds8izAmTe7FSU25lzsCuLg6DRO1DHps8fIdV6SxcrDSeOukNKviQZL0y0jS
	fxn2EZ1tHlpAoaTJYRSn+QM0dMw8cRiClo76N21d00D20SCW39E3egy0tYJwcNJi
	EIvPInKo+qOh5l4+2UZL5b9Nltatu4rqS4iJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyp4i4uZlfRo5bOX4ODR8XfuYfI/nxs8
	XH5OJZBJaMm7D6zL8CAc1/OMWIM9szgEug4J1/I65PEGdNV5NY6aYGhRwvEZxUgL
	VomaAu3zM3C/4EFs1PWY+mK49ljlnCKoP1qpP7x50V/aZzfA+7M4qqGnhz4nJXj5
	NkhwUseVDs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CB6A3499B;
	Mon, 15 Aug 2016 16:49:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E840F3499A;
	Mon, 15 Aug 2016 16:49:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
	<20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
	<8737m63phh.fsf@linux-m68k.org>
	<20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
	<xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
	<20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
Date:	Mon, 15 Aug 2016 13:49:19 -0700
In-Reply-To: <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 14:55:01 -0400")
Message-ID: <xmqqshu5g3lc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE57D914-6329-11E6-96C5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> So a comment outside [section "name"] is tricky; it needs some
>> mechanism (or convention) to tell us if it is about the particular
>> section, or it is about the location in the configuration file.
>
> Keep in mind that even "outside" is hard, because sections do not
> explicitly close.

Yes, that was what I wanted to say.  We'd be deep in the
"convention" territory.
