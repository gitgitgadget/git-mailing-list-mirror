Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59493EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 20:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFTUjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFTUjU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 16:39:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3F19B
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:39:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F0E1953E9;
        Tue, 20 Jun 2023 16:39:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xl66GtSW4eswWGUDpmGcioAeMhUVIhglEqGUXR
        b1SUo=; b=wSJnzaNXabiMuxV4x0N/WuoIFTIBRmFON+AGYgx0Bc54pT2hGv/vTU
        3aW0sedPBkBMggP9M7nLRSz+dX/vmwpibuh3mFj0XNo4QhtzEMzrgMnXZ/cBUefN
        0dRxgqGSu7Ip94KMeERe/GfWeOhJPGlbEj9YvWI7FPSoBzBCojKnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA981953E8;
        Tue, 20 Jun 2023 16:39:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F074D1953E5;
        Tue, 20 Jun 2023 16:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] packfile: delete .idx files before .pack files
References: <pull.1547.git.1687287675248.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 13:39:16 -0700
In-Reply-To: <pull.1547.git.1687287675248.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 20 Jun 2023 19:01:15
        +0000")
Message-ID: <xmqqwmzxlvgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87112D18-0FAA-11EE-8BFD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> However, when we delete packfiles, we do not do this in the reverse
> order as we should. The unlink_pack_path() method deletes the .pack
> followed by the .idx.

Makes sense.
