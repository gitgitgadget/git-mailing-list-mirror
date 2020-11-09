Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9861C5517A
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EC6206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRd6h1qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKIVCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:02:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64674 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:02:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAFF2FE528;
        Mon,  9 Nov 2020 16:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+DtuMhBYFS1I0TygEg6b2L3MqhU=; b=NRd6h1
        qVQUDgTYDqT2u5LyCDd/D3p7ltv7QiCS+VSJatGtBGUbPPwccfaB1e2ImDz5U/fX
        0gYzq5rnsHiWVjqGSAUPUHGPttllLSwN4yA8zx+GmVHZol7Ksdq7wjWpygRhUliS
        6UCbqvrqK9WGT/xrEkGuStNtJl2deSCSs9cbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PWAhheGG2DjeQUtw0/tQzMCpqmdiW2v3
        WOfFv6VKbf/d+P5YzOYC54sT2oC2IM4nVO+z5f/B8nwo4vKPSqntC1uyHek5xdju
        hUt+sIM9Cl3FI4PmYw+PIUARKI8v7RObv/vSX8VsZxusvCnTkCYcKUmwZFtFfFWP
        BexH/vTWu9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2B81FE527;
        Mon,  9 Nov 2020 16:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E943EFE525;
        Mon,  9 Nov 2020 16:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] p4: respect init.defaultBranch
References: <pull.782.git.1604824911359.gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 13:02:05 -0800
In-Reply-To: <pull.782.git.1604824911359.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sun, 08 Nov 2020 08:41:51
        +0000")
Message-ID: <xmqqd00mb5wy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D35E9E42-22CE-11EB-A39F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In `git p4 clone`, we hard-code the branch name `master` instead of
> looking what the _actual_ initial branch name is. Let's fix that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Makes sense.  Will queue.  Thanks.

>     p4: respect init.defaultBranch
>     
>     Just something I noticed while working on the big master -> main rename
>     in the test suite.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-782%2Fdscho%2Fgit-p4-and-init.defaultBranch-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-782/dscho/git-p4-and-init.defaultBranch-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/782
>
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 4433ca53de..52ddb1d7b2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4186,7 +4186,7 @@ def run(self, args):
>  
>          # create a master branch and check out a work tree
>          if gitBranchExists(self.branch):
> -            system([ "git", "branch", "master", self.branch ])
> +            system([ "git", "branch", currentGitBranch(), self.branch ])
>              if not self.cloneBare:
>                  system([ "git", "checkout", "-f" ])
>          else:
>
> base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
