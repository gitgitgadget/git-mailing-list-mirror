Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF7AC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiEWUhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEWUhq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:37:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D12BC2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:37:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E72811DCAC;
        Mon, 23 May 2022 16:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x4P8Uc514HWaFBd50GzW2h8p2tcGMWgP9olDqa
        8o9d8=; b=xzVVgSMXAGJ7xlOEqUk9MH/btIr9Rpfbx44omdufW5n5n/dTdVgjp0
        N9uC6hQV4Rnza2Q+2Mu0VgsiFK3GjzI9yeFQuq8rTn42GVjJEpA5rTgdmBSH/H5A
        o2tboBC+ClH/GZdJvsgWaDKaUPGK6WBZg5tgRgge53ztqDPiWW4uo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4364311DCAB;
        Mon, 23 May 2022 16:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABCC111DCAA;
        Mon, 23 May 2022 16:37:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <xmqqr14kqdag.fsf@gitster.g>
Date:   Mon, 23 May 2022 13:37:42 -0700
In-Reply-To: <xmqqr14kqdag.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        23 May 2022 12:06:31 -0700")
Message-ID: <xmqqwnecoui1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3288378A-DAD8-11EC-AC4A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It sounds more like "pass" than "ignore", the latter of which can be
> read as "strip" instead of "pass it as-is".

Or "allow" (which I prefer over "pass").

> The name "warn", and its stronger form "die", both sound right.
