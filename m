Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C09FA373E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJURjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJURjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:39:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD237F8A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:39:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C32215A8B0;
        Fri, 21 Oct 2022 13:39:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ew2G5Nfjp7mibDXTxWGwA2qrn8/3y9B8PYcjWA
        HH7NQ=; b=J6TsloyBlVv6h20Bc7MoG8oPDxt6fTSPin2JCfNB2YlEG035mywXvB
        63EvdA5yWg3Y1wqBJFAxCaIKTF8BWCib4BbzIFKvhZyFN8HULjhd7f3oPu02dZGR
        owyholJid/gGCHfIGpVuj5v11VWgvWgpupif63cuZxJ9/N2ke2yzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8357B15A8AF;
        Fri, 21 Oct 2022 13:39:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC7C215A8AE;
        Fri, 21 Oct 2022 13:39:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 6/8] rebase --apply: make reflog messages match
 rebase --merge
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <3f6b2e39f4091e891f3ab83da7944a0c497ec300.1666344108.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 10:39:34 -0700
In-Reply-To: <3f6b2e39f4091e891f3ab83da7944a0c497ec300.1666344108.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 09:21:46
        +0000")
Message-ID: <xmqqbkq5m5yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 547C00A0-5167-11ED-B165-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The apply backend creates slightly different reflog messages to the
> merge backend when starting or finishing a rebase and when picking
> commits. ...
> There are existing tests for the messages from both backends which are
> adjusted to ensure that they do not get out of sync in the future.

Nice.
