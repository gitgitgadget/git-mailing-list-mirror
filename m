Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBCDC433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B5E20723
	for <git@archiver.kernel.org>; Fri, 22 May 2020 22:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GOmm3MOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgEVWJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 18:09:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:55091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731182AbgEVWJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 18:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590185345;
        bh=33AgOmrC0LM0D2kiyiZ8dcxxivry+hpWiEXVRoaesgQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GOmm3MOGS8H+dOQ1IJZzuKnt0TJNOuZFxO32Wx2cfs7LtRjfJaCb7qSrPBUV/KS/Z
         6PR22f+b7N0j1bZHL0ju0CEx4wrnuJTh8Ke/nG+pOwuNnmT8FzxSlj7Qfn6lL3Q1oL
         OzZ591zqpteTcC/4DT+/FnMzGf0hPQNWgUyTpdkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1jMEdT1Mb0-00JJNa; Sat, 23
 May 2020 00:09:05 +0200
Date:   Sat, 23 May 2020 00:09:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Finish converting git bisect to C part 2
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Xsth4JpsnSLTl8loPVYlsvY/nVh0vMW/dviAhP1+rxodIrAT5h
 9b9KUDqq1EdskWSnk5p70++0qiQW64ZF3sIbEWmCErFtJ00UGwwEWah/y/hw9OpXOgaJ9H/
 MEgW+hIzWVfvzmIRISQ+0f45svmls7mTduybHLPPXP9PmNcMqs+DEtNFnW58muLaiKxZxFo
 MxcFDK6hyXZYtX5ff8usA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdgTK42hixg=:4DZWjdrxNAsKUdsxVb59BN
 ASiEt2K/w6Dl6DdaSKxuT3S/lz4nw24rwEUL6TGxlegxIvuvKeyCzl5NjRJrfQoqg5o4Br5Zh
 CfmWvkk+GODzzc9s3vGVhsJwXHhyauY5eaKAranR2HBkoGye4U48cUO2DcSNxgMZzz08S+P6e
 L9plkIstThfIW8fIBwWB1pmQpL2FOOYhkCwxY4IaVvgXBp1tUznmRS+SdD8DZUq0/rQCJ1cqs
 EK3w7fdtGW6KZ6Q+/ez6UtT2G2LYFshnlrd4RgnrLIVO2CDNcftS3R2bAbkJb5nDvREdazm7X
 61AydN9vM5WxJrgQY9Wakoi+pU6Nd6Zp3mWcJrHVp7lFyxaBUORjsdh8rCuityxqOVmmSzt0R
 HENaKeAzjff8s+03r0VsDZd1ppjtRcccK3SNFzJQNZ4EO0g5uTyW55qLe8OAmlp6FOYBLbxa+
 OE39Fhz3qBhw0xCIzUuqCrlqkixk4Nj/AfV+BbdaavDEk+WMrJy1hENFiIl/jI/wnpCYlJqjL
 V6e9kIHlBVxloyVBoZGN9qAHxaaTnEFWYImQuh+xl9Ww7Y3HlXtl6nNJzdXmR8OnV2utPk5yK
 4MNRzW764rVYEW37YI+azx9dKXNPo0QfJ11NZjZFb5/a0WY+87Ux7hKu7vLcsBWs79z48IXPm
 v1fADFH+zE/1yPv1MLtxdRuUJ1YzNHSXDYfC3SbxHHq1vO6LgjW9P+Mrx3yERsHj7k3r3+VVn
 FVaERSSHWQsR76JMse8uvI5i+qypk2WyVNJtHbbmcfa6bP25ZtgPTNjLp5ykTgjTnbiJ9//Sx
 JfpnFP8VTrZSOMKp63wOTQJtgDUtQBcCLNAdTLOHHdHuvc4EpS7O0te0XpsIcEH5PE039Dy6r
 vEDuAhmhfEqdszsXgAVi93zN/YiqV0NYJvbzPWGl1rg00xQdWRrtJ4IJlHaMm7pajewc/rE24
 UUQ+/kk+sfExtofvD7tVgxJWTgrAYdlDmehiQEdur7p9r7HOg/18J1Q9obknYz3FJOktmR02+
 VhDxnmxBdCuG8jS9Wg3bx0szycyGlUjEYQhTLnkGYvh44+rLFicpLCgy+SRHJuKQHRyIbo+mn
 YbX7tZ/bHSzPyMPiE5KBfJ1fU38KnqWl1OtT7J5XzfqcunrWV9TDlKLzvFqLnexFv3Enn4elp
 hXry6HULSTZi4nIIChKGxLe3kkEG4+GeikE1UkQztO9vghlLPKnJqaoZ3CIyygG/8bQtHE7jy
 7Kw/CitsvcJwjsUHF
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> These patches correspond to a second part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v3.
>
> I would like to thank Junio Hamano for reviewing this patch series and
> Christian Couder for his help.
>
> --- Changes since v2 Finish converting git bisect to C part 2 patch seri=
es ---

Thank you for this detailed summary!

I reviewed the patches in their entirety, and left a couple of
suggestions, some of them minor.

Hopefully you find them helpful!

Ciao,
Dscho

>
> General changes
> ---------------
>
> * Rebase on master branch: efe3874640 (Sync with v2.26.1, 2020-04-13)
>
> Specific changes
> ----------------
>
> [1/12] bisect--helper: fix `cmd_*()` function switch default return
>
> * Use `BUG()` instead of `return error()` in default switch.
>
> --
>
> [2/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return
>
> * New patch: use '-res' instead of 'abs(res)'.
>
> --
>
> [3/12] bisect--helper: introduce new `write_in_file()` function
>
> * Rename input parameter `filepath` to `path`.
> * Change `error_errno()` to `error()` in mode checking.
> * Change error message when file cannot be opened.
> * Add `fclose()` before error return.
>
> --
>
> [4/12] bisect--helper: reimplement `bisect_autostart` shell function in =
C
>
> * Reorder patch before `reimplement `bisect_next` and `bisect_auto_next`
> shell functions in C` to use `bisect_autostart()` function in
> `bisect_append_log_quoted()`.
>
> --
> `
> [5/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` =
shell
> functions in C
>
> * Amend commit message.
> * Add `clear_commit_marks()` at the end of bisect_next_all() and remove =
it from
> `bisect_rev_setup()`.
> * Fix if condition.
> * Add `bisect_autostart()` in `bisect_append_log_quoted()`.
> * Check `git_path_bisect_head()` with `file_exist()` instead of
> `is_empty_or_missing_file()`.
> * Fix return with BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.
> * Add conversion in `cmd_*()` to BISECT_OK when return is
> BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.
>
> * Note to previous reviewer: suggestion to change `bisect_auto_next()` f=
unction
> to return void cannot be done because errors from `bisect_next()` are no=
t
> ignored.
>
> --
>
> [5/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell
> functions in C
>
> * Check `git_path_bisect_head()` with `file_exist()` instead of
> `is_empty_or_missing_file()`.
>
> --
>
> Miriam Rubio (3):
>   bisect--helper: fix `cmd_*()` function switch default return
>   bisect--helper: use '-res' in 'cmd_bisect__helper' return
>   bisect--helper: introduce new `write_in_file()` function
>
> Pranit Bauva (9):
>   bisect--helper: reimplement `bisect_autostart` shell function in C
>   bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
>     functions in C
>   bisect--helper: finish porting `bisect_start()` to C
>   bisect--helper: retire `--bisect-clean-state` subcommand
>   bisect--helper: retire `--next-all` subcommand
>   bisect--helper: reimplement `bisect_state` & `bisect_head` shell
>     functions in C
>   bisect--helper: retire `--check-expected-revs` subcommand
>   bisect--helper: retire `--write-terms` subcommand
>   bisect--helper: retire `--bisect-autostart` subcommand
>
>  bisect.c                 |   8 +
>  builtin/bisect--helper.c | 383 +++++++++++++++++++++++++++++++++------
>  git-bisect.sh            | 145 +--------------
>  3 files changed, 347 insertions(+), 189 deletions(-)
>
> --
> 2.25.0
>
>
