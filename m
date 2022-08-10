Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4EFC3F6B0
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiHJVZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiHJVZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:25:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8011816
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:25:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4B1219F71B;
        Wed, 10 Aug 2022 17:25:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ojD08yHyNHbDxMaTY892KED1Pk8kdq65BEvuJO
        3e5ls=; b=Iy5OVvzEGN6srTvZRFdwnILINpoAf0Or4D206NLD7Eh268euX+Ouhx
        WrLCmNP3iUagrKp9M5QnVITgfM7OxTNayMFOj0eBaKJbmbaotg3u5dBG4LAXEjxW
        TcghaXZ6z87UXOP9Z38KCk4sgm5wfXJRE4buy1JDFUAKHMItkdIuo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C29619F71A;
        Wed, 10 Aug 2022 17:25:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D23319F719;
        Wed, 10 Aug 2022 17:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v4] rev-list: support human-readable output for
 `--disk-usage`
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
        <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
        <xmqqlerwm28n.fsf@gitster.g>
        <YvQhHOkjZatIqlFr@coredump.intra.peff.net>
Date:   Wed, 10 Aug 2022 14:25:31 -0700
In-Reply-To: <YvQhHOkjZatIqlFr@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Aug 2022 17:20:28 -0400")
Message-ID: <xmqqbksrkcz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6E926B8-18F2-11ED-8E37-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It was my suggestion to turn it into a helper, because the same code
> needs to be present in two distant spots (the bitmap and non-bitmap
> cases).
> ...
> Keep in mind that we are in try_bitmap_disk_usage() here.

Yeah, both of them I notice in a later parts of the message you are
responding to ;-)
