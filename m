Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9F4C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 16:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiFCQ4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiFCQ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 12:56:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA529515B5
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 09:56:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F9E1185E7D;
        Fri,  3 Jun 2022 12:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t822YxWhCTCXtMCaTjmpya1hfBH+84lnxakLIg
        HicZg=; b=oJFGVTGwJgGtqRhp+U+LeM2pSfrhzLlMPsOgT78xe6szIxxhEJJ+5p
        p+hqdFBBfLABxY0gv+idTJkQd/rjTZg18M2l+b1OPR5zC8OrDHf79pjFH3zIc1cz
        J+cYm/NQRiQV8aL6j+vV5/hVvYzQpzOYz6CRzISUHM+mesjugUiC8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57DDF185E7B;
        Fri,  3 Jun 2022 12:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06E72185E7A;
        Fri,  3 Jun 2022 12:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 09:56:24 -0700
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Fri, 03 Jun 2022 13:37:48 +0000")
Message-ID: <xmqqpmjpheiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AF65564-E35E-11EC-ABB9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a feature I've wanted for quite a while. When working on the sparse
> index topic, I created a long RFC that actually broke into three topics for
> full review upstream. These topics were sequential, so any feedback on an
> earlier one required updates to the later ones. I would work on the full
> feature and use interactive rebase to update the full list of commits.
> However, I would need to update the branches pointing to those sub-topics.
>
> This series adds a new --update-refs option to 'git rebase' (along with a
> rebase.updateRefs config option) that adds 'git update-ref' commands into
> the TODO list. This is powered by the commit decoration machinery.

;-)
