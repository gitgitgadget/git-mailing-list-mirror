Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0635FC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 20:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJLUhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJLUhK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 16:37:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184A102517
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 13:37:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1591B155D89;
        Wed, 12 Oct 2022 16:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=C9BPswZX+5FA/BJogjI8+8gjjB9XWBC7uqPXUjjNAw0=; b=kGGu
        fB+xWNp2M9Lufl4nz2zYwpycYG+1Fk57puc568jJ24xU4XvkClcLtTl0Y4QBXaKW
        ZhAC0+XwsRMjJEWURmmqEkzw9KSGtc7nOEAMuXvTDwgIMuAr5APQJVLXHWaUI54D
        cSh7Qk+n9CaOryhqEfp3AlxPVLMYPk/NQQAEH/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02F16155D88;
        Wed, 12 Oct 2022 16:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 797FF155D86;
        Wed, 12 Oct 2022 16:37:04 -0400 (EDT)
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
Subject: Re: [PATCH v3 0/8] rebase: make reflog messages independent of the
 backend
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 13:37:03 -0700
Message-ID: <xmqq7d14lqxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1D2D3F2-4A6D-11ED-93D1-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes some bugs in the reflog messages when rebasing and changes
> the reflog messages of "rebase --apply" to match "rebase --merge" with the
> aim of making the reflog easier to parse.
>
> Thanks to everyone who commented on V2, I've added the review club
> participants that I've got address for to the cc list. I've rebased onto
> pw/rebase-keep-base-fixes.

Thanks for identifying the base clearly.

If "What's cooking" is correct, the base topic is waiting for an
update?  I'd prefer to see us build new stuff on top of solidified
ground.


