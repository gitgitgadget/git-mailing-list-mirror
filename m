Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4938C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E2F6113E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhIKVlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 17:41:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61705 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIKVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 17:41:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEB0BEF277;
        Sat, 11 Sep 2021 17:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hGGjfytwOeAEe6Q5dCLoDJR69BS6svbwkxRyTK
        21JPk=; b=kafJpAEEygE9sICJNsysivqz+x6uAnNOCHHO+MuJ2vqIgR6DiYuDHt
        1GhRyOYjmhWR0s7cAcOgN1EO1OO0quu+omIYgNkxIqsm1h6V6cqf6hpKDg82JVhd
        Nsa3yMhrYM6xV7h6wMw2jKOFFfKwYLAMHvdn/u0vWmkE9qBpoof9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A581CEF276;
        Sat, 11 Sep 2021 17:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30D89EF275;
        Sat, 11 Sep 2021 17:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 2/5] http: drop support for curl < 7.16.0
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <patch-v4-2.5-fb308258e2b-20210730T175650Z-avarab@gmail.com>
        <1b18309a-93e8-60cc-1bd3-61857b1da819@gmail.com>
        <YTy+GH0I2KPnBCUY@coredump.intra.peff.net>
Date:   Sat, 11 Sep 2021 14:39:53 -0700
In-Reply-To: <YTy+GH0I2KPnBCUY@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 11 Sep 2021 10:32:56 -0400")
Message-ID: <xmqqzgsilrkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD2838F6-1348-11EC-9079-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So the patch is indeed wrong, but the series overall ends up correct.

I guess that bisectability in a documentation topic does not matter,
so we can take the end result ;-)


