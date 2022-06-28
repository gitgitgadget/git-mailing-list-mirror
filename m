Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23313C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiF1Vtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiF1Vtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:49:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55DD1EC72
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:49:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D7521988FA;
        Tue, 28 Jun 2022 17:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j9aq8jOMbYN5aEhBGoOk1p5dFB4kFkGpTTxWKn
        ToKFE=; b=puhupnPlvqskwprjA9Ce/cu594a3yxBcoLxXqwFhGhZAttH7hSeiPF
        b9NxmxT1KLTqM4JH9FSePQOuiKedUQKoGpbabizYPHi8pEfmSLWV6Y9Am54+h7ZP
        wsT9sK4KraLHdHWJuCcfEmXOQszptNriJGv1r8aUzr6hy2IVzv9tc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 452361988F9;
        Tue, 28 Jun 2022 17:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC6931988F7;
        Tue, 28 Jun 2022 17:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
        <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:49:38 -0700
In-Reply-To: <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 28 Jun 2022 20:02:57
        +0000")
Message-ID: <xmqqwnd0h30t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 360E58EC-F72C-11EC-B5F9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -apply backend: When applying a patch, ignore changes in whitespace in
> -context lines. Unfortunately, this means that if the "old" lines being
> -replaced by the patch differ only in whitespace from the existing
> -file, you will get a merge conflict instead of a successful patch
> -application.
> +apply backend:;;

Hmph, I am surprised that you took this, with an extra colon.  Does
it format nicely?

> +	When applying a patch, ignore changes in whitespace in context
> +	lines. Unfortunately, this means that if the "old" lines being
> +	replaced by the patch differ only in whitespace from the existing
> +	file, you will get a merge conflict instead of a successful patch
> +	application.
>  +
> -merge backend: Treat lines with only whitespace changes as unchanged
> -when merging. Unfortunately, this means that any patch hunks that were
> -intended to modify whitespace and nothing else will be dropped, even
> -if the other side had no changes that conflicted.
> +merge backend:;;
> +	Treat lines with only whitespace changes as unchanged when merging.
> +	Unfortunately, this means that any patch hunks that were intended
> +	to modify whitespace and nothing else will be dropped, even if the
> +	other side had no changes that conflicted.
>  
>  --whitespace=<option>::
> -	This flag is passed to the 'git apply' program
> +	This flag is passed to the `git apply` program
>  	(see linkgit:git-apply[1]) that applies the patch.
> -	Implies --apply.
> +	Implies `--apply`.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> @@ -537,7 +539,7 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>  -x <cmd>::
>  --exec <cmd>::
>  	Append "exec <cmd>" after each line creating a commit in the

I thought `exec <cmd>` was an improvement, just like ...

> -If `--autosquash` is used, "exec" lines will not be appended for
> +If `--autosquash` is used, `exec` lines will not be appended for

... this is?

Other than that, looking good.

Thanks.
