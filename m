Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3808CEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFZUpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFZUpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 16:45:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F85E75
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 13:45:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 682AF19599D;
        Mon, 26 Jun 2023 16:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vyL16MRDpM2aE5zlaXg/BSSryfylScS30qAQ/r
        CObA4=; b=L82gbd+3SWg5YrmborskGcMDv9DBV0M8c0CONBdvgz75OiHco0IRvk
        slypsGpVU2jYd/nPjOemQZWLHOV3BPUQKHXLtq+ZM3TDtZB+88fsfgjPYG2sUIaz
        mBOwQ3hHUufobIv0TGUnBF9PjOe4wAomlG9s53uKdGh+NEDzR6f84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BB0919599B;
        Mon, 26 Jun 2023 16:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B57BF19599A;
        Mon, 26 Jun 2023 16:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v4 00/12] config: remove global state from config iteration
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 13:45:20 -0700
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 26 Jun 2023 18:11:11 +0000")
Message-ID: <xmqqleg63qcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E5E2CBA-1462-11EE-A36F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I also tested these patches on top of 'seen', and the only conflict I found was
> with en/header-split-cache-h-part-3, where ll-merge.c got renamed to merge-ll.c,
> so we need to apply the config refactor there (should work with .cocci).

Both recursive and ort merge strategies should be able to deal with
ll-merge.c <-> merge-ll.c, I think.

Thanks.

