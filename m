Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126832070C
	for <e@80x24.org>; Wed,  6 Jul 2016 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbcGFV0b (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 17:26:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755800AbcGFV0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 17:26:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E453C28FC2;
	Wed,  6 Jul 2016 17:26:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYNtVWSAhOOAL9plMloOja8IT20=; b=DFTdze
	k+/bmdNRkOyY6Du7Hx/ykgMsWBf8Cd0LSxuh5NYV4kRMMphxPRnrwxfw7Lj2ecgB
	toPImqt5jnJI8DspXzCKt+cBNT7NDfJs0OatLXZ6UxtnDdjUXyTAM9d4WOXMz6T3
	5c7pvOtK/tTEjxOtwlLqAvPZ6O2P2pFn68+Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhVBT0BzW8NwhabuzuD1EfD6ZmK7yoJ1
	WC4O3i1F4fqybg9w6xbejM2kSGoejqUYHbDT2FfYrvXZE+Y4d5bzOvRCo9WRO9EX
	Vg5VznaXeVwbWzY3edznqm7ZXTn/VWkZRaOgq+7NKItgM63ge08WmDTfFUj3U7eV
	kX6xgElzP3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB9FA28FC1;
	Wed,  6 Jul 2016 17:26:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61A7F28FC0;
	Wed,  6 Jul 2016 17:26:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/17] Use merge_recursive() directly in the builtin am
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<cover.1467717729.git.johannes.schindelin@gmx.de>
Date:	Wed, 06 Jul 2016 14:26:26 -0700
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Tue, 5 Jul 2016 13:22:51 +0200 (CEST)")
Message-ID: <xmqqwpkyqwzh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CECF288-43C0-11E6-938B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is the second iteration of the long-awaited re-roll of the attempt to
> avoid spawning merge-recursive from the builtin am and use merge_recursive()
> directly instead.

I wanted to queue this in 'pu', but an unfortunate series that
changes the convert_to_git() infrastructure has serious conflicts
with the changes in this series.  I am still unsure if these
changes cannot be done without butchering the calling convention
of what leads to convert_to_git(), but in the meantime, this cannot
yet be merged to 'pu'.

