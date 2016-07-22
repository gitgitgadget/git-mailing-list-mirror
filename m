Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798D7203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbcGVT1I (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:27:08 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37093 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbcGVT1H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2016 15:27:07 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so55589210ith.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 12:27:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J1GyrJAGTEn3FC6QpjjTliqBSTgffM91Ce5Tn4ERxyg=;
        b=og/we8BGVdZ4f8jkpgmnBg1WvoF+feSluxJqa922ZQEI25ea7gTi5j4E6nFxbK2WP3
         VrhoSC2uPhwOC4laTjJhyMMlM57WxnSoA1tn2F/Mu5DIa0uOnEzGuUDIVowRHMigmqbf
         VoRkMRurrS78zYEI/17kaLAsk0yOEYsS9qKU4PewCtOHuiYcqYQRZLHcEJVDOkGN4pLr
         c5rd68S1hJfU6iB19HlHH6uZ6cp7DsiZtNyJXUZQDGzazzDJVZJQKxuzZ5ar889OrhEu
         pGZUgogv1Yr5zZXIQ7OSXYTkeoqJ2zlKDEAuWM8qsz1p0/ke3THCjTAooO730MB6/9yW
         8/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J1GyrJAGTEn3FC6QpjjTliqBSTgffM91Ce5Tn4ERxyg=;
        b=YtiGwtNrkCuBVoAiAzeJhyf8Zl7GdZxQDXCVOUGnysHRRXzOwxkHDATiKKQXfGfNvf
         aTV7OPkHDSq9rCAqtQwZrRTvdqrQVjaO9ekpaXO0ybyKiMsDdjGZbuPeFnclpFAjvxeo
         kAeVXFq9cleSQ6SLOW5eTn7ca5yndkXOzo0tXXd1AKvBhrFSw14SEq44Ng+tjND355ZL
         hOXNRCfERA35BojcKGQNp5VBnqlyW46Y3DG3oZ4+T4U0Xn0Uz5xMfTaNg205+RsCWhiY
         cMdNrxe5gE0x1jnxNc7oTq7MgiPglZXrTM4GA0IMM+B0wlIcbLRGDAs0HvJ5Q1hqZIIg
         LvlQ==
X-Gm-Message-State: AEkooutbDma9dy16ZfrTp/13fggRr1neV/xVpU4n8ZoaqNr/AlQEfHxVeuOkJRUQmlgDt2CzYPeEBSHkIw2Qqanv
X-Received: by 10.36.127.7 with SMTP id r7mr6167793itc.49.1469215624900; Fri,
 22 Jul 2016 12:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 12:27:04 -0700 (PDT)
In-Reply-To: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 12:27:04 -0700
Message-ID: <CAGZ79ka0K6bFPt8gYNeKvA_B-ggHHETD=EtwRYj7F_5XTJ+n8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-submodule: forward exit code of
 git-submodule--helper more faithfully
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:14 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> git-submodule--helper is invoked as the upstream of a pipe in several
> places. Usually, the failure of a program in this position is not
> detected by the shell. For this reason, the code inserts a token in the
> output stream when git-submodule--helper fails that is detected
> downstream, where the shell script is quit with exit code 1.
>
> There happens to be a bug in git-submodule--helper that leads to a
> segmentation fault. The test suite triggers the crash in several places,
> all of which are protected by 'test_must_fail'. But due to the inspecific
> exit code 1, the crash remains undiagnosed.
>
> Extend the failure protocol such that git-submodule--helper's exit code
> is passed downstream (only in the case of failure). This enables the
> downstream to use it as its own exit code, and 'test_must_fail' to
> identify the segmentation fault as an unexpected failure.
>
> The bug itself is fixed in the next commit.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> When you run ./t7400-submodule-basic.sh -v, you will notice this output:
>
> fatal: destination path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' already exists and is not an empty directory.
> fatal: clone of './.subrepo' into submodule path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' failed
> Failed to clone 'init'. Retry scheduled
> fatal: destination path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' already exists and is not an empty directory.
> fatal: clone of './.subrepo' into submodule path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' failed
> /home/jsixt/Src/git/git/git-submodule: line 494: 21757 Segmentation fault      git submodule--helper update-clone ${GIT_QUIET:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} ${prefix:+--recursive-prefix "$prefix"} ${update:+--update "$update"} ${reference:+--reference "$reference"} ${depth:+--depth "$depth"} ${recommend_shallow:+"$recommend_shallow"} ${jobs:+$jobs} "$@"
> ok 32 - update should fail when path is used by a file
>
> Note the segmentation fault. This mini-series addresses the issue.

The segfault has been addressed in
http://thread.gmane.org/gmane.comp.version-control.git/299995
but received no attention yet.
The propagation of the exit code makes sense nevertheless.

Thanks!


>
> Noticed on Windows because it "visualizes" segfaults even for
> command line programs.
>
>  git-submodule.sh            | 22 +++++++++++-----------
>  t/t5815-submodule-protos.sh |  4 ++--
>  t/t7400-submodule-basic.sh  |  4 ++--
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 4ec7546..0a0e12d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -49,7 +49,7 @@ die_if_unmatched ()
>  {
>         if test "$1" = "#unmatched"
>         then
> -               exit 1
> +               exit ${2:-1}
>         fi
>  }
>
> @@ -312,11 +312,11 @@ cmd_foreach()
>
>         {
>                 git submodule--helper list --prefix "$wt_prefix" ||
> -               echo "#unmatched"
> +               echo "#unmatched" $?
>         } |
>         while read mode sha1 stage sm_path
>         do
> -               die_if_unmatched "$mode"
> +               die_if_unmatched "$mode" "$sha1"
>                 if test -e "$sm_path"/.git
>                 then
>                         displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> @@ -423,11 +423,11 @@ cmd_deinit()
>
>         {
>                 git submodule--helper list --prefix "$wt_prefix" "$@" ||
> -               echo "#unmatched"
> +               echo "#unmatched" $?
>         } |
>         while read mode sha1 stage sm_path
>         do
> -               die_if_unmatched "$mode"
> +               die_if_unmatched "$mode" "$sha1"
>                 name=$(git submodule--helper name "$sm_path") || exit
>
>                 displaypath=$(git submodule--helper relative-path "$sm_path" "$wt_prefix")
> @@ -581,12 +581,12 @@ cmd_update()
>                 ${depth:+--depth "$depth"} \
>                 ${recommend_shallow:+"$recommend_shallow"} \
>                 ${jobs:+$jobs} \
> -               "$@" || echo "#unmatched"
> +               "$@" || echo "#unmatched" $?
>         } | {
>         err=
>         while read mode sha1 stage just_cloned sm_path
>         do
> -               die_if_unmatched "$mode"
> +               die_if_unmatched "$mode" "$sha1"
>
>                 name=$(git submodule--helper name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
> @@ -994,11 +994,11 @@ cmd_status()
>
>         {
>                 git submodule--helper list --prefix "$wt_prefix" "$@" ||
> -               echo "#unmatched"
> +               echo "#unmatched" $?
>         } |
>         while read mode sha1 stage sm_path
>         do
> -               die_if_unmatched "$mode"
> +               die_if_unmatched "$mode" "$sha1"
>                 name=$(git submodule--helper name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
>                 displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> @@ -1075,11 +1075,11 @@ cmd_sync()
>         cd_to_toplevel
>         {
>                 git submodule--helper list --prefix "$wt_prefix" "$@" ||
> -               echo "#unmatched"
> +               echo "#unmatched" $?
>         } |
>         while read mode sha1 stage sm_path
>         do
> -               die_if_unmatched "$mode"
> +               die_if_unmatched "$mode" "$sha1"
>                 name=$(git submodule--helper name "$sm_path")
>                 url=$(git config -f .gitmodules --get submodule."$name".url)
>
> diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
> index 06f55a1..112cf40 100755
> --- a/t/t5815-submodule-protos.sh
> +++ b/t/t5815-submodule-protos.sh
> @@ -18,7 +18,7 @@ test_expect_success 'setup repository with submodules' '
>         git commit -m "add submodules"
>  '
>
> -test_expect_success 'clone with recurse-submodules fails' '
> +test_expect_failure 'clone with recurse-submodules fails' '
>         test_must_fail git clone --recurse-submodules . dst
>  '
>
> @@ -32,7 +32,7 @@ test_expect_success 'update of ssh allowed' '
>         git -C dst submodule update ssh-module
>  '
>
> -test_expect_success 'update of ext not allowed' '
> +test_expect_failure 'update of ext not allowed' '
>         test_must_fail git -C dst submodule update ext-module
>  '
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index b77cce8..7c8b90b 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -352,7 +352,7 @@ test_expect_success 'sync should fail with unknown submodule' '
>         test_failure_with_unknown_submodule sync
>  '
>
> -test_expect_success 'update should fail when path is used by a file' '
> +test_expect_failure 'update should fail when path is used by a file' '
>         echo hello >expect &&
>
>         echo "hello" >init &&
> @@ -361,7 +361,7 @@ test_expect_success 'update should fail when path is used by a file' '
>         test_cmp expect init
>  '
>
> -test_expect_success 'update should fail when path is used by a nonempty directory' '
> +test_expect_failure 'update should fail when path is used by a nonempty directory' '
>         echo hello >expect &&
>
>         rm -fr init &&
> --
> 2.9.0.443.ga8520ad
