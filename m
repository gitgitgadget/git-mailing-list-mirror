Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA521F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbdAaWSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:18:50 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36484 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdAaWSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:18:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1321290wmd.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w3D95Wyp12dBggnUF6j2Vzg3joAL8sSjUVjnQRmLyiE=;
        b=QjiNu7RUXRdBbFTy0E+p89hPRvkfzi48WNpYhfvzwl9dTlEhDIX2eSx2gVn1RNiaTI
         3e2EUD8lfDoge47yxT0Z5h3CGYIVHFSMe5oArg2fDGqnXJ3ddH1mEipuNkDKkBJJCTl/
         PJNs4V5Zyc9vNCGt+bp0BJ91hVQZeu0kqoeOdFqo+AdfTAkKQWcgEn4DSTiEJYTJlPmc
         Tb275gOk+IW2mfqyFP9Kk6EbTURmuXrfZhZXpdw2eWE3z4lFl8iC0yRADUimAZLqdWAj
         izw9w6RLO6PlepIwDSfffrHdkrD7Th2fUcENY+tMezRdqmxiNQ3stuqPPbX15O3pfiOA
         op0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w3D95Wyp12dBggnUF6j2Vzg3joAL8sSjUVjnQRmLyiE=;
        b=YHCJbV2xpqk3mlLaQ+05go+70M4BuFKSn15/tsPCV2G2bL6nAfnAWb6SZE1fsQhjd0
         xn2aVGskuDgMWWMCnQE6lRvl+RdEFMVt/5MWz68Rjvjl6OQmgVnHCN1z2dkFLEJK4n0X
         L/hf/f7rHUk5jHvbRIWwRff4MTkAVNZzKGYU+n5Fkj6gNXLwm4XlBhytxWzD0ETnEna2
         4cYL0xyxDG1PGA5WAQJMDReoiqlnaZLqnUWwjbB9+CiDNYBheo+8ZEz2pRqgkE1K/3Qi
         fgiPKk3VRRHUPsXO5l3J9Rrfo0umTqB3Tzni96PIowx2lofC5+PioEqOkEpTWRQ+L5Gd
         Hn1w==
X-Gm-Message-State: AIkVDXJEdPj08oEch4IyC+K9Bwl3jVZSICsm7iI//LXMzPuadi0wSGbLwRWdUnUPkWG1L1rwHknCvJeU5IMmRQ==
X-Received: by 10.28.213.142 with SMTP id m136mr102660wmg.90.1485901071292;
 Tue, 31 Jan 2017 14:17:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Tue, 31 Jan 2017 14:17:50 -0800 (PST)
In-Reply-To: <20170127211703.24910-2-cornelius.weig@tngtech.com>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <20170127211703.24910-1-cornelius.weig@tngtech.com> <20170127211703.24910-2-cornelius.weig@tngtech.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 31 Jan 2017 23:17:50 +0100
Message-ID: <CAM0VKj=Ein4yrKG2aZnN7JU80ctZBQromcR6BEu-TyMLenLFCg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] completion: recognize more long-options
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     j6t@kdbg.org, spearce@spearce.org, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 10:17 PM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Recognize several new long-options for bash completion in the following
> commands:

Adding more long options that git commands learn along the way is
always an improvement.  However, seeing "_several_ new long options"
(or "some long options" in one of the other patches in the series)
makes the reader wonder: are these the only new long options missing
or are there more?  If there are more, why only these are added?  If
there aren't any more missing long options left, then please say so,
e.g. "Add all missing long options, except the potentially
desctructive ones, for the following commands: ...."


>  - apply: --recount --directory=
>  - archive: --output
>  - branch: --column --no-column --sort= --points-at
>  - clone: --no-single-branch --shallow-submodules
>  - commit: --patch --short --date --allow-empty
>  - describe: --first-parent
>  - fetch, pull: --unshallow --update-shallow
>  - fsck: --name-objects
>  - grep: --break --heading --show-function --function-context
>          --untracked --no-index
>  - mergetool: --prompt --no-prompt
>  - reset: --keep
>  - revert: --strategy= --strategy-option=
>  - rm: --force

'--force' is a potentially destructive option, too.

>  - shortlog: --email
>  - tag: --merged --no-merged --create-reflog
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  contrib/completion/git-completion.bash | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0e09519..933bb6e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -936,6 +936,7 @@ _git_apply ()
>                         --apply --no-add --exclude=
>                         --ignore-whitespace --ignore-space-change
>                         --whitespace= --inaccurate-eof --verbose
> +                       --recount --directory=
>                         "
>                 return
>         esac
> @@ -974,7 +975,7 @@ _git_archive ()
>         --*)
>                 __gitcomp "
>                         --format= --list --verbose
> -                       --prefix= --remote= --exec=
> +                       --prefix= --remote= --exec= --output
>                         "
>                 return
>                 ;;
> @@ -1029,6 +1030,7 @@ _git_branch ()
>                         --track --no-track --contains --merged --no-merged
>                         --set-upstream-to= --edit-description --list
>                         --unset-upstream --delete --move --remotes
> +                       --column --no-column --sort= --points-at
>                         "
>                 ;;
>         *)
> @@ -1142,6 +1144,8 @@ _git_clone ()
>                         --single-branch
>                         --branch
>                         --recurse-submodules
> +                       --no-single-branch
> +                       --shallow-submodules
>                         "
>                 return
>                 ;;
> @@ -1183,6 +1187,7 @@ _git_commit ()
>                         --reset-author --file= --message= --template=
>                         --cleanup= --untracked-files --untracked-files=
>                         --verbose --quiet --fixup= --squash=
> +                       --patch --short --date --allow-empty
>                         "
>                 return
>         esac
> @@ -1201,7 +1206,7 @@ _git_describe ()
>         --*)
>                 __gitcomp "
>                         --all --tags --contains --abbrev= --candidates=
> -                       --exact-match --debug --long --match --always
> +                       --exact-match --debug --long --match --always --first-parent
>                         "
>                 return
>         esac
> @@ -1284,6 +1289,7 @@ __git_fetch_recurse_submodules="yes on-demand no"
>  __git_fetch_options="
>         --quiet --verbose --append --upload-pack --force --keep --depth=
>         --tags --no-tags --all --prune --dry-run --recurse-submodules=
> +       --unshallow --update-shallow
>  "
>
>  _git_fetch ()
> @@ -1333,7 +1339,7 @@ _git_fsck ()
>         --*)
>                 __gitcomp "
>                         --tags --root --unreachable --cache --no-reflogs --full
> -                       --strict --verbose --lost-found
> +                       --strict --verbose --lost-found --name-objects
>                         "
>                 return
>                 ;;
> @@ -1377,6 +1383,8 @@ _git_grep ()
>                         --max-depth
>                         --count
>                         --and --or --not --all-match
> +                       --break --heading --show-function --function-context
> +                       --untracked --no-index
>                         "
>                 return
>                 ;;
> @@ -1576,7 +1584,7 @@ _git_mergetool ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "--tool="
> +               __gitcomp "--tool= --prompt --no-prompt"
>                 return
>                 ;;
>         esac
> @@ -2456,7 +2464,7 @@ _git_reset ()
>
>         case "$cur" in
>         --*)
> -               __gitcomp "--merge --mixed --hard --soft --patch"
> +               __gitcomp "--merge --mixed --hard --soft --patch --keep"
>                 return
>                 ;;
>         esac
> @@ -2472,7 +2480,10 @@ _git_revert ()
>         fi
>         case "$cur" in
>         --*)
> -               __gitcomp "--edit --mainline --no-edit --no-commit --signoff"
> +               __gitcomp "
> +                       --edit --mainline --no-edit --no-commit --signoff
> +                       --strategy= --strategy-option=
> +                       "
>                 return
>                 ;;
>         esac
> @@ -2483,7 +2494,7 @@ _git_rm ()
>  {
>         case "$cur" in
>         --*)
> -               __gitcomp "--cached --dry-run --ignore-unmatch --quiet"
> +               __gitcomp "--cached --dry-run --ignore-unmatch --quiet --force"
>                 return
>                 ;;
>         esac
> @@ -2500,7 +2511,7 @@ _git_shortlog ()
>                 __gitcomp "
>                         $__git_log_common_options
>                         $__git_log_shortlog_options
> -                       --numbered --summary
> +                       --numbered --summary --email
>                         "
>                 return
>                 ;;
> @@ -2778,8 +2789,8 @@ _git_tag ()
>         --*)
>                 __gitcomp "
>                         --list --delete --verify --annotate --message --file
> -                       --sign --cleanup --local-user --force --column --sort
> -                       --contains --points-at
> +                       --sign --cleanup --local-user --force --column --sort=
> +                       --contains --points-at --merged --no-merged --create-reflog
>                         "
>                 ;;
>         esac
> --
> 2.10.2
>
