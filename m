Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140AC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC8961410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhGAWGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:06:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51586 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:06:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDC64E5852;
        Thu,  1 Jul 2021 18:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLdpVjx5ZtBNoq0W5k8l5rAl9sdqepN4gs/tkY
        7AdQw=; b=VdRTFVPdUuh3DsBTU2t7GYsrUxg7PuG0sQPEqGZz9W8acQ6M/S+17O
        LhNG9LE2hMPaWQiC9CkLd2FsNXNJA1ypttD1Qb1MyvmaqaKincRsqk7AQFPmlvmW
        UjZK1H9W5bHY31qfMD/cqYA/jU1qxpL5oLCe7tOvYE6xowNHLSSx4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4D04E5851;
        Thu,  1 Jul 2021 18:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E48EE5850;
        Thu,  1 Jul 2021 18:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] ci: speed-up the Windows parts of our GitHub workflow
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 15:03:32 -0700
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 23 Jun 2021 15:24:10
        +0000")
Message-ID: <xmqqk0m9r8sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D51188E-DAB8-11EB-8F1C-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series upgrades to newer versions of a couple GitHub Actions we
> use, and also streamlines the Windows jobs using the relatively new
> setup-git-for-windows-sdk Action
> [https://github.com/marketplace/actions/setup-git-for-windows-sdk] (Git for
> Windows is running with this Action for a while now, getting all the kinks
> out).
>
> This patch series should also address the problem where seen was pushed so
> rapidly that the windows-test jobs failed because they no longer checked out
> the identical revision as the windows-build job.

https://github.com/git/git/actions/runs/991636423 is the run on the
real 'seen' for the day, which fails vs-build.  The same 'seen',
with this topic excluded, seems to make everything pass and can be
seen at https://github.com/git/git/actions/runs/991543592

CI/PR(seen) runs in the past few days all include this topic, and all
of them have failed the vs-build job.

Thanks.

