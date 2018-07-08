Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28B51F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeGHVPL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:15:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:37653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933261AbeGHVPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 17:15:09 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0cs6-1fwfvB3msI-00urOD; Sun, 08
 Jul 2018 23:15:00 +0200
Date:   Sun, 8 Jul 2018 23:14:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
Subject: Re: [GSoC] [PATCH v4 0/4] rebase: rewrite rebase in C
In-Reply-To: <20180708180104.17921-1-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807082311540.75@tvgsbejvaqbjf.bet>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180708180104.17921-1-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KSLhM922jBiZOEmXzeuxEk2/csjSUyU1VuesKXowrB3mGgdXJH4
 5O5lpWGB7ugUYHpvgMRT3R8UJNQ+tmlcfIpiMgTFIuMaaEc+CHUTl6B1J/7KNJIWo5DQXT4
 YLoJ9ohMYFwcsWsEyQ/40yQQ4Upx4Un0qrKfXvhTIhCOMTdByQH9j31BUJIFjcIUwiOojAO
 yetc2ALIC0nxA3UAws8lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s+fkvQh3vlE=:4j8B/hFKkbtX3D8QOwknRR
 L35Tst2hhxWGf60BovCumT/HXXLPDEJNqDzC0N+sRVMxjqVwjNVT95PT+5JiHhG6xd4t6ncxx
 8LrOFLs0/SOnxfkn7BBQVUK8CN66SHMgFwvujV6pshysbmoWUi5OlypAUVpLbDUT6ysokJwFb
 ldn3LoJOleWw+zrVe2tCzijJL//cuUmFKLF7idaVDeucSqIy7xmyplFgdgdwPMrk+luNaquEc
 vC+9LFVbColb3Kdd/MxyH01762Ln75bg7Rwt959prEmZpxSwDyAwvEDKrXtkcBaSEnt8hvoBh
 pK+Bv4i36b7uOsMXItitDiu0OHcOFeZchA9NWSJQkoogxYzAtpnVi8XBVnBRAXcNDaK2bT+Ma
 W/4UmHtgURVbi7tVXE1UFlNxckrI46bm7gn+gshXqpPhy7ArHUJj9LbxeDfYyhYlfQdvNtsyC
 OcL+B1CTOFbsP6jAUdw2+o52uL3Dcn9IOPjE07h7Sd1tSDkLF7sFjzbr39o5B96qPp0Aul0Zk
 tBS2wIyWJBt248vicYr/IJ0Rok5Qmsar570vv4SqXvMuZoqHf7RYCxrchIOZpjjFvKS4xqanQ
 n7reLfOnGKj+oyI0stBaEDfpgixUaEtDWja2ETseDJEfKOYhwhUFywCdpVqOuzfHDFVzjCbx+
 Spu04l1rX3vtw//Zq/6PrHoLd9LRvgS7NpK5tmkLCCiQeBpPPjbBOEyM1J3qfJy1lNo9R7mUD
 HYftQV7qVWFqyQkG0fO0G8Nk7J0BojOpOayWh9Bg3Ba6lVhjSLI4ArefUVPMhPvl2jOWL0CN4
 jnNg/Tf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Sun, 8 Jul 2018, Pratik Karki wrote:

> As a GSoC project, I have been working on the builtin rebase.
> 
> The motivation behind the rewrite of rebase i.e. from shell script to C
> are for following reasons:
> 
> 1.  Writing shell scripts and getting it to production is much faster
>     than doing the equivalent in C but lacks in performance and extra
>     workarounds are needed for non-POSIX platforms.
> 
> 2.  Git for Windows is at loss as the installer size increases due to
>     addition of extra dependencies for the shell scripts which are usually
>     available in POSIX compliant platforms.
> 
> This series of patches serves to demonstrate a minimal builtin rebase
> which supports running `git rebase <upstream>` and also serves to ask for
> reviews.
> 
> Changes since v3:
> 
>   -  Fix commit message of `rebase: start implementing it as a builtin`.
> 
>   -  Acknowledge Junio's style reviews.
> 
>   -  Acknowledge Johannes Schindelin's review.

The range-diff looks like this (and makes sense to me; you might want to
fix the typo s/retun/return/, but that's all for now):

-- snipsnap --
 1:  7baec70f219 !  1:  42778b20edf rebase: start implementing it as a builtin
    @@ -13,6 +13,12 @@
         be able to conveniently test new features by configuring
         `rebase.useBuiltin`.

    +    In the original difftool conversion, if sane_execvp() that attempts to
    +    run the legacy scripted version returned with non-negative status, the
    +    command silently exited without doing anything with success, but
    +    sane_execvp() should not retun with non-negative status in the first
    +    place, so we use die() to notice such an abnormal case.
    +
         We intentionally avoid reading the config directly to avoid
         messing up the GIT_* environment variables when we need to fall back to
         exec()ing the shell script. The test of builtin rebase can be done by
 2:  f385f42dc56 !  2:  a28be7308e6 rebase: refactor common shell functions into their own file
    @@ -45,6 +45,20 @@
     diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
     --- a/git-legacy-rebase.sh
     +++ b/git-legacy-rebase.sh
    +@@
    + LF='
    + '
    + ok_to_skip_pre_rebase=
    +-resolvemsg="
    +-$(gettext 'Resolve all conflicts manually, mark them as resolved with
    +-"git add/rm <conflicted_files>", then run "git rebase --continue".
    +-You can instead skip this commit: run "git rebase --skip".
    +-To abort and get back to the state before "git rebase", run "git rebase --abort".')
    +-"
    ++
    + squash_onto=
    + unset onto
    + unset restrict_revision
     @@
      true)     gpg_sign_opt=-S ;;
      *)        gpg_sign_opt= ;;
    @@ -128,6 +142,13 @@
     +++ b/git-rebase--common.sh
     @@
     +
    ++resolvemsg="
    ++$(gettext 'Resolve all conflicts manually, mark them as resolved with
    ++"git add/rm <conflicted_files>", then run "git rebase --continue".
    ++You can instead skip this commit: run "git rebase --skip".
    ++To abort and get back to the state before "git rebase", run "git rebase --abort".')
    ++"
    ++
     +write_basic_state () {
     +  echo "$head_name" > "$state_dir"/head-name &&
     +  echo "$onto" > "$state_dir"/onto &&
 3:  147699bd195 =  3:  7591098c4d1 sequencer: refactor the code to detach HEAD to checkout.c
 4:  bbaa4264caa !  4:  f8429e950a4 builtin/rebase: support running "git rebase <upstream>"
    @@ -232,13 +232,14 @@
     +  }
     +
     +  /*
    -+  * If the branch to rebase is given, that is the branch we will rebase
    -+  * branch_name -- branch/commit being rebased, or HEAD (already detached)
    -+  * orig_head -- commit object name of tip of the branch before rebasing
    -+  * head_name -- refs/heads/<that-branch> or "detached HEAD"
    -+  */
    ++   * If the branch to rebase is given, that is the branch we will rebase
    ++   * branch_name -- branch/commit being rebased, or
    ++   *                HEAD (already detached)
    ++   * orig_head -- commit object name of tip of the branch before rebasing
    ++   * head_name -- refs/heads/<that-branch> or "detached HEAD"
    ++   */
     +  if (argc > 1)
    -+           die ("TODO: handle switch_to");
    ++           die("TODO: handle switch_to");
     +  else {
     +          /* Do not need to switch branches, we are already on it.  */
     +          options.head_name =

