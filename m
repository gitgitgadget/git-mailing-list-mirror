Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DDFC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiIZTX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZTX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:23:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA369E0F0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:23:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35519143CE9;
        Mon, 26 Sep 2022 15:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6z04n1TeGSTxFnHdEINV/mRD71K4futBN5f9Gs
        Lwars=; b=WuAVpPe2JL3tGWf5Rc/jyqgFk2bjO2xu8WqBDaaiuP6cDqMZ3eQOu2
        HzBIyu8Ip/pW8158eY83vYS4Oe1ESHj+G634tG+AkpFPwpwdUbIuErf6AV9TKWG2
        pjo3GczG0h91OzesoWtr4roLVb5/5crMVjCsM0lqi9SMkNDYtTXmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C0D3143CE7;
        Mon, 26 Sep 2022 15:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82FBB143CE6;
        Mon, 26 Sep 2022 15:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 12:23:24 -0700
In-Reply-To: <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 26 Sep 2022
        18:48:04 +0000")
Message-ID: <xmqq7d1qndn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B14EEACC-3DD0-11ED-8DC6-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git maintenance' run [<options>]
>  'git maintenance' start [--scheduler=<scheduler>]
> -'git maintenance' (stop|register|unregister)
> +'git maintenance' (stop|register|unregister) [<options>]

An unrelated tangent, but should register complain when given in a
repository that is already registered as well?  Just being curious.
