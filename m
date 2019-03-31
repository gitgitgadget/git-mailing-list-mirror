Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD9720248
	for <e@80x24.org>; Sun, 31 Mar 2019 22:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfCaWHI (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 18:07:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWHH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 18:07:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so9353086wra.12
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L3Fd/uMUhX8132eERasXEHvcVZem9hNilL9TnVBrd+I=;
        b=P/roD8fnKKn58JdGortav/yP4AbyFTwv9Nj5M2QY9eTknXW99v0OAJT48hl9LHC1HM
         mJJ8Di69J2Bv9RezeFt+ZyUmKpygB9195x/zAo3kgC/w/bWbFzUsO+UWmI2y980ioVHB
         9TQTXh+QGyjd2JVunrmlri+jHUmQRV+RytHbeisHzHxvRfTby0lh9AVMDOsqPgu/XTSu
         CiDxO7uTNAkcISwq6s3Rus6oq7+17GbJgzJ5L99AH7GngYVoDz0vrPm1QAJD7AhYapKI
         I36Cjy8zkA75/LOrC8x3Fb91L+Cx06vPmBwX+KxS3Q033MV6DuOfFpvji/gZp+1qgECT
         gXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3Fd/uMUhX8132eERasXEHvcVZem9hNilL9TnVBrd+I=;
        b=pG5PjXvgTWe7j7l52hTaj7imnndFLddpw77tWriwo9IUrp8SWeNXSoqJPC7IjNLH9d
         ntSr5FJ3yOTx00+X2w00vcp2psBQt043q1hdokvP/jNHU233kFHdPN+M4N+yRUk9E2hU
         v8ZJRgitBY7mc8Do5uqIbiqZUn3Kov5PNMlE24dOwyPwDdlzmyilyBFMOV8bXZnUt7pc
         mL4S9oulWo51rq9QxfwaHP5aNDZjNhv8ajG5nRzdy0lLfbRgfRkIwkaV5+nA74K4XcN2
         FPioUaFJKD97rprj1x8WG/zQrSXMwt/kPTWkC2HUFaD37VsY3zClhZClfHMZd/bywRqG
         kVCA==
X-Gm-Message-State: APjAAAVYCiJEYjlGxAdw7xod0ttU7ie/iTE/DR3RkpX3uWzgv2gALDQO
        cHVWSNLeS8mnBMPga2c/8pBwf+Us
X-Google-Smtp-Source: APXvYqyQTC6184pm5PY6lr8S1G0hQSwKK3eEsgrUOHVgnbAwN2bWsfA0mW+O2PLanxG0L2CVCMcFAw==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr38848665wrs.166.1554070025756;
        Sun, 31 Mar 2019 15:07:05 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id a11sm7513963wmm.35.2019.03.31.15.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 15:07:04 -0700 (PDT)
Date:   Sun, 31 Mar 2019 23:07:03 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git stash --snapshot
Message-ID: <20190331220703.GY32487@hank.intra.tgummerer.com>
References: <002101d4e039$a7cd8a10$f7689e30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002101d4e039$a7cd8a10$f7689e30$@nexbridge.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Randall S. Becker wrote:
> About two weeks ago there was a discussion about building an undo stack. 
> https://public-inbox.org/git/000401d4d6c8$f68bb020$e3a31060$@nexbridge.com/
> 
> it had me thinking about whether a stash --snapshot might be useful. Below
> is a conceptual change - by no means even close to complete. This would
> allow scripting to wrap critical commands with a "git stash push --snapshot"
> without changing the working directory.

I'm not sure I understand this proposal correctly.  Since you mention
this being used in scripting, would it be any different than using
'git stash push && git stash apply'?  The former is a bit more
expensive of course, but conceptually it would do the same thing, I
think.

I could see this as somewhat useful, but I don't think stash supports
all the necessary operations yet.  E.g. what if you are in the middle
of resolving a merge conflict.  But maybe a bit more of a description of your problem would
help convince me.

For the undo stack discussion, I think I prefer something like Duy's
backup-log [*1*] proposal, that is built into git, rather than
scripting my own solution, even if it's supported by 'git stash'.

I meant to review those patches, but unfortunately never got around to
that.  But if it's something that interests you as well, reviewing the
patches is probably the best way to get support for this into git.

*1*: https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.com/

>                                          For symmetry, a "git stash pop
> --force" is needed if --include-untracked were used to stash everything in
> the first place.

What exactly is the force option meant to do?  Apply the stash anyway,
and discard current changes?  Wouldn't that lead to loosing data
again, just in a different way?

>                   It might be more useful also to wait until stash is
> converted to C, I suppose.

Yes please, any changes should ideally also apply to the stash-in-C
topic, unless they are actual bug fixes.

>                            I'm wondering whether to pursue this or drop it.
> Thoughts? (and I beg forgiveness for what my mailer might do to the wrapping
> of this patch, and I already know the indent is wrong between 329 and 370,
> and that the granularity of the --force option is wrong).
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 789ce2f41d..7741192980 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -5,12 +5,13 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="list [<options>]
>     or: $dashless show [<stash>]
>     or: $dashless drop [-q|--quiet] [<stash>]
> -   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
> +   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [-f|--force]
> [<stash>]
>     or: $dashless branch <branchname> [<stash>]
>     or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
>                       [-u|--include-untracked] [-a|--all] [<message>]
>     or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
>                        [-u|--include-untracked] [-a|--all] [-m <message>]
> +                      [--snapshot]
>                        [-- <pathspec>...]]
>     or: $dashless clear"
> 
> @@ -252,6 +253,7 @@ push_stash () {
>         patch_mode=
>         untracked=
>         stash_msg=
> +       snapshot=
>         while test $# != 0
>         do
>                 case "$1" in
> @@ -286,6 +288,9 @@ push_stash () {
>                 --message=*)
>                         stash_msg=${1#--message=}
>                         ;;
> +               --snapshot)
> +                       snapshot=t
> +                       ;;
>                 --help)
>                         show_help
>                         ;;
> @@ -329,6 +334,8 @@ push_stash () {
>         die "$(gettext "Cannot save the current status")"
>         say "$(eval_gettext "Saved working directory and index state
> \$stash_msg")"
> 
> +       if test -z "$snapshot"
> +       then
>         if test -z "$patch_mode"
>         then
>                 test "$untracked" = "all" && CLEAN_X_OPTION=-x ||
> CLEAN_X_OPTION=
> @@ -363,6 +370,7 @@ push_stash () {
>                         git reset -q -- "$@"
>                 fi
>         fi
> +       fi
>  }
> 
>  save_stash () {
> @@ -490,6 +498,7 @@ parse_flags_and_rev()
> 
>         FLAGS=
>         REV=
> +       FORCE_OPTION=
>         for opt
>         do
>                 case "$opt" in
> @@ -499,6 +508,9 @@ parse_flags_and_rev()
>                         --index)
>                                 INDEX_OPTION=--index
>                         ;;
> +                       -f|--force)
> +                               FORCE_OPTION=--force
> +                       ;;
>                         --help)
>                                 show_help
>                         ;;
> @@ -607,7 +619,7 @@ apply_stash () {
>         if test -n "$u_tree"
>         then
>                 GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
> -               GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
> +               GIT_INDEX_FILE="$TMPindex" git checkout-index --all
> $FORCE_OPTION &&
>                 rm -f "$TMPindex" ||
>                 die "$(gettext "Could not restore untracked files from stash
> entry")"
>         fi
> @@ -688,7 +700,7 @@ apply_to_branch () {
>         set -- --index "$@"
>         assert_stash_like "$@"
> 
> -       git checkout -b $branch $REV^ &&
> +       git checkout -b $branch $FORCE_OPTION $REV^ &&
>         apply_stash "$@" && {
>                 test -z "$IS_STASH_REF" || drop_stash "$@"
>         }
> 
> Regards,
> Randall
> 
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
> 
> 
> 
