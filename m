Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB734C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJUJdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJUJdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:33:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC3F25475F
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:33:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CC88157E5A;
        Fri, 21 Oct 2022 05:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NEYqrZiMmTxBPukUBtCwdta6R4vULeL/2bDPZxL3vIc=; b=xS74
        fm8Xq/anq1L2/jfbq2Q28yiifnoPjs5R10NO7vn11EoKz3lei17E4VRIHuHrT07h
        KRaxAL3VlfjCfw8jJ57iIVHzV+BDfvhILeTlqZB32WDmGAvnG+PrVRQu3gYxHYZ8
        Q6+CE2d9ZtHLEfU1oHQMRf5vYGicR9XR3Yy0iY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24DAB157E59;
        Fri, 21 Oct 2022 05:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 820B2157E58;
        Fri, 21 Oct 2022 05:33:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v4 6/6] builtin: patch-id: remove unused diff-tree prefix
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <dcdfac7a1539103926dd46e8c3d5c10fe640c0f3.1666307815.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 02:33:16 -0700
Message-ID: <xmqqh6zxo71f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D18A40-5123-11ED-B46D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jerry Zhang <Jerry@skydio.com>
>
> From a "git grep" of the repo, no command, including diff-tree itself,
> produces diff output with "diff-tree " prefixed in the header.
>
> Thus remove its handling in "patch-id".

There is a bit of leap in the logic flow here, in that the current
state alone does not justify such a removal of the code that is not
hurting anybody.  I thought I did the necessary homework the last
time to help you update the proposed log message for this step with
necessary due diligence, like when we stopped producing it
ourselves.  The lack of third-party tools still relying on the code
we are removing here is not something we can prove easily, so
documenting that we go by faith there would not hurt, either.
