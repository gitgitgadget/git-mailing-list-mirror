Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C90DC433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 09:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiAOJ5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 04:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiAOJ5g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 04:57:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D71C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 01:57:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so12021272wmo.5
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CePz3H632UnRp6gmd/uYmbVXyewA0UB2HoHE5zIQDUo=;
        b=MI28LcAlO0d7tduDOP0arfciZiI/80lOfWY1GtTi8zHk7DU5+EsH174j5DO77ZgoAq
         glaEyyjAQrNV2aAe59KqKQYTFRA7LObPBC35ejvtaG+WoxQyuvXtxnJXxYW8KEBaSB5a
         syRVtSiUfxxoCejJQvaZ2S4Prh4LUMlh2reSb9qtIyZM3OyY0QLKezJC6L5+G2r8h6M0
         M6vsgwsYhb+CJj8pHvUeN40FisjwwMDt/xhCMXmmF0No164uVtM6OfuaAMp1GkCGaNZ8
         IM/TtyW0Rmn//5bJBh/6dpJxZWV5VNR7VaBooIhg3OrqxneKGumlyH5bmxLiO26h0T/d
         igdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CePz3H632UnRp6gmd/uYmbVXyewA0UB2HoHE5zIQDUo=;
        b=fGn7z38jKfjSZft8luXUmyDmfFsxH1qmNzdikA/ZUYER9gwhWMyvtstvzgQQ6QL+HX
         2ywOganfe7w+FsTU0z9etu9ziSCL1I+alEhSasL8V8sv0WKs/KwbJffiD9r1zFo2zDGu
         cE63gfkQ86qBBNtLgw00ppu8XQfJWmnhiJhAvz5BzmE3RXe/PoLcFj5ONh+vLw+UDfPM
         +M+mwbCCIXTud2bs6TfZQw4tpa1BB5DOx2L3ts7fyqIciHQCm358VuUin5fcStlz5Qyj
         3DKiarxxxmwYi6C+cLzwsLM+bnNFh43COYDYd0mU7QgCW91MN6TuwrY6eFLvIZ9aAhT7
         ONzg==
X-Gm-Message-State: AOAM532JUHprfcG5hnjsdP6sjjeqPJZCPh64W+BbSub+VOA2R6XQNvk+
        7QqvOU364KscgpqzTft2O2w=
X-Google-Smtp-Source: ABdhPJy+Mz1G7pV6pxKFCqwo1c7ESZOkSFmeS2ReU68/J5zaCtM57RBrNpjdx/CETCGW79idM+DHIw==
X-Received: by 2002:a05:600c:1e0e:: with SMTP id ay14mr11481799wmb.86.1642240654152;
        Sat, 15 Jan 2022 01:57:34 -0800 (PST)
Received: from szeder.dev (94-21-146-106.pool.digikabel.hu. [94.21.146.106])
        by smtp.gmail.com with ESMTPSA id i10sm9753109wmq.45.2022.01.15.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 01:57:33 -0800 (PST)
Date:   Sat, 15 Jan 2022 10:57:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Message-ID: <20220115095725.GA1738@szeder.dev>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 06:59:51PM +0000, Lessley Dennington via GitGitGadget wrote:
> Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion

None of these patches touch sparse-checkout, but only the completion
script and its tests.  Therefore "completion:" would be a better
matching area prefix.

> Fix custom tab completion for sparse-checkout command. This will ensure:
> 
> 1. The full list of subcommands is provided when users enter git
> sparse-checkout <TAB>.
> 2. The --help option is tab-completable.

This is inconsistent with the rest of the completion script, because
it doesn't list '--help' for any commands or subcommand (with the sole
exception of 'git --<TAB>').

> 3. Subcommand options are tab-completable.
> 4. A list of directories (but not files) is provided when users enter git
> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.

Why limit completion only to directories?  Both of those subcommands
accept files, and I think 'git sparse-checkout set README.md' is a
perfectly reasonable command.

> It is
> important to note that this will apply for both cone mode and non-cone
> mode (even though non-cone mode matches on patterns rather than
> directories).
> 
> Failing tests that were added in the previous commit to verify these
> scenarios are now passing with these updates.
> 
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
>  t/t9902-completion.sh                  |  8 +++---
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c82ccaebcc7..f478883f51c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2986,24 +2986,38 @@ _git_show_branch ()
>  	__git_complete_revlist
>  }
>  
> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
> +
>  _git_sparse_checkout ()
>  {
> -	local subcommands="list init set disable"
> +	local subcommands="list init set disable add reapply"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +
>  	if [ -z "$subcommand" ]; then
> -		__gitcomp "$subcommands"
> -		return
> +		case "$cur" in
> +			--*)
> +				__gitcomp "--help"
> +				;;
> +			*)
> +				__gitcomp "$subcommands"
> +				;;
> +		esac
>  	fi
>  
> -	case "$subcommand,$cur" in
> -	init,--*)
> -		__gitcomp "--cone"
> -		;;
> -	set,--*)
> -		__gitcomp "--stdin"
> -		;;
> -	*)
> -		;;
> +	case "$subcommand" in
> +		set)
> +			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"

Oh, a hard-coded list of --options is so old school :)

All subcommands of 'git sparse-checkout' use parse-options (even those
that don't have any --options at the moment), so their options can be
completed programmatically, and then we wouldn't have to worry about
updating the list of options in the completion script ever again.  It
would also make several tests added in the previous patch unnecessary.

You could use the completion function of 'git notes' for inspiration
on how to do that.

> +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"

This will have troubles with unusual characters in pathnames:

  - If a pathname contains a space (or any other IFS character), then
    the shell will split that into multiple words.  

  - If a pathname contains a special character, e.g. double quote or
    backslash, then 'git ls-tree' will quote that path.  Furthermore,
    by default it will quote pathnames containing e.g. UTF-8
    characters as well.

  - The shell has its own special characteers that have to be
    quoted/escaped on the command line to strip them from their
    special meaning, that quoting/escaping will interfere with listing
    only paths matching the current word to be completed.

You should use the __git_complete_index_file() helper function
instead, which takes care of most of this.

Furthermore, these two subsequent __gitcomp() calls will offer both
options and paths for 'git sparse-checkout set <TAB>', which is
inconsistent with the rest of the completion script.  Usually it lists
--options only after e.g. 'git rm --<TAB>' or 'git log --<TAB>', but
after 'git rm <TAB>' and 'git log <TAB>' it lists only files and refs,
respectively.

> +			;;
> +		add)
> +			__gitcomp "--stdin"
> +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"

Likewise.

> +			;;
> +		init|reapply)
> +			__gitcomp "$__git_sparse_checkout_subcommand_opts"
> +			;;
> +		*)
> +			;;
>  	esac
>  }
>  
