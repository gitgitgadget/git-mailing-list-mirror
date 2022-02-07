Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C298C433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiBHBFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbiBGX6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:58:32 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20BC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:58:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49CFC162937;
        Mon,  7 Feb 2022 18:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yYIJqpVDxlXbSYmcQwvcKUU5VecjFJbnCoRW+1
        YsX+0=; b=leKRuv0sKqip4v9Ol2FRzqx++7baoAzHTANw5lLeI1vXBmZ2A8PzqE
        BZ4js13bVaisI6BD36mlX9clOwtRe/fWPJLdytN7oCEnDolnz691SXqWMmfaP/3C
        JorKGZjf6Rgd4KuNl4EvaMwn9/MiYjk/s7h+U4HFE2GjEEJuxSVaM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41286162936;
        Mon,  7 Feb 2022 18:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90316162935;
        Mon,  7 Feb 2022 18:58:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] cat-file: rename cmdmode to transform_mode
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <2d9a0b06ce5ab62095ae9a91d8d56441e9bb8c54.1644251611.git.gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 15:58:27 -0800
In-Reply-To: <2d9a0b06ce5ab62095ae9a91d8d56441e9bb8c54.1644251611.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Mon, 07 Feb 2022 16:33:30
        +0000")
Message-ID: <xmqqo83ifcv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D87842F2-8871-11EC-A7EA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> When introducing a new flag --batch-command, we will add a flag on the
> batch_options struct that indicates whether or not an interactive
> command mode will be used that reads commands and arguments off of
> stdin.
>
> An intuitive name for this flag would be "command", which can get
> confusing with the already existing cmdmode.

Is "command" truly an intuitive name for "were we given '--batch-command'
option?" bit?  I dunno.

But I agree that "transform_mode" is much better name than "cmdmode"
for what this member is about.
