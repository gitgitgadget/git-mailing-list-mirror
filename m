Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDC5EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFUVqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFUVqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 17:46:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00079B
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 14:46:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EAD5198512;
        Wed, 21 Jun 2023 17:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mHrTHEtuR+NZF16pM2eeUcKEl3wPIczkFqc+qk
        gOEn4=; b=h+pPjdlL6GE/QlSBVHLS0SJ0/+68Lt7+Jv5o9SV3hW0W0wTMbv+Lb9
        Uotl+tsyU4iNRvi5QmKsHkb/uMo+/dv/48fZqLAxFcCVtvrVSgYhvC7P/xu+JtkE
        9zjXIeujDd7fvMIQlYq3KA8VpB+gHk5ZIFafCR2E6wrs+0+FSjCCk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36629198511;
        Wed, 21 Jun 2023 17:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72F86198510;
        Wed, 21 Jun 2023 17:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 00/12] config: remove global state from config iteration
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 14:46:32 -0700
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:39 +0000")
Message-ID: <xmqqr0q4fpzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16D26C5A-107D-11EE-A6CE-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Junio: I rebased this onto a newer "master". I assume this is a noop for
> you - I noticed that the RFC versions weren't applied anyway (good).

It would be a noop only if I do not queue this iteration.

I've reviewed them in its current shape, but it seems to cause too
many conflicts even when merged to 'next', let alone 'seen', with
interactions with topics in flight:

 * ds/add-i-color-configuration-fix (easy)
 * ps/fetch-cleanups (easy but messy)
 * vd/worktree-config-is-per-repository (moderately messy)

some of which may have graduated to 'master' in the meantime, so it
might not be a bad idea to rebase on a more recent 'master' after
you collect and adjust for review comments on v3.

Thanks.

