Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD8C2D0E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB9E20658
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HqzgNVHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgICUeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:34:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:35309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgICUeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 16:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599165244;
        bh=ukdIrx1RUHaLmu+6mi2yIn8Xr7pjfF9uENfR/63b1UM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HqzgNVHSInLiPbPcU8jHWVe6OJm3sBs3zqHAHR8CAUrUf/pal0Awxhvxm5vofZEHH
         /S+J2gsvG5/42XIHAmrM0wgsVqyujaFe6jPPv4jqueIvgBiPq/4Gz95I8X0YBh/Nlc
         dF7cnSzNxNjkruDjqZDFTRTqzQnUehk2AQND8Vc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1kjxHv1XTI-00etJz; Thu, 03
 Sep 2020 22:29:03 +0200
Date:   Thu, 3 Sep 2020 14:04:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FfOpf/ucpyNa7o9xK2xmn87sj/HJLa7o/niIeCB/3PpAiSmvdZZ
 2JLQjFrd3p5f4I/lFon7MKpUvO7xmRahem2rrvbAQlK5Q1YjrpdG5I3FvswREKf1p3nApSy
 M6LI34fxILPCvNFycsUicF41+uAKxfUXrYiqj0RqZNJGElBAt60tFCRY3saItr6D6WuTXBL
 CQYzarwvX/y6Me2l8qn2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y/ja4T3W+Q8=:VB0Anm3f/pdGlkI0IJRKHz
 wX+UIgVfABV7k6/8tNx2gtSkwt07YpVT/yk3HSA/jp+Tg6anAq/JNUjX1wumopQLrpiTbFaxp
 ZnBfwk9Jtquvfl6lZsaXSlM33r4sCbdV6LboOdj5IeZHDA2cuuJ3j7s3q5L5fsqhpw48I/xBf
 cGSf1wMPDjUlBWTLFHKw9F8tqhCa1W5oMP8oL0TwQG4gPyw5A6cQAIs8FHrDKClr9eJy5Wgi9
 o8NU10+X/GZZ00l7A3uvT8DLT+0FpYDfoP6yAQe3M//WrAXI4JIJM0C26Y9b7J+zdUngvFK2f
 xf4a+BZgAd+xgW5UNjVw+jNK0mT2mfBbEh3QJiacZLKC+LH4ZbGCDlOe6sfgsz3XKyFun4VAD
 2T5eNrM+eb2R/EVu1XSTt/i6E2PsrVjfqdT2n/+PP6YTYWW7TFaMvGeV7zeMZKpsrXSvtC6ZV
 4SdcUkyFCmOzaNxi4Qej9oZhIyguKB8B0Im98hTAoztTJyJkm3oPfaugCQI28EvQ4Johi16U8
 LTyrUMktllYfi+4MSvmvA03Uj/2lrXiUbCGTd/kroaZ63wWKOQJcF3KeItWJd/3MZp6pmdrzs
 eaaBWHTAETo9K2PX0WQsf9ZWCNNRcRkUKICWImegSQkvD1EjfmC+UVgER0kVFh2GDJKXpt1vW
 UbDC+snfxTO6HQSe0VET66eNbcy9/vToOjQlg93LQCApPL3xJzNNGyRZ2txrmROgWb328aw6J
 bHznyKwRC7V4A2itOkFdxzAsySTRAO0r84cffL6m0tK2sTyIRXGBi0zuEXW8Baim+ji1b6Qd+
 wM9lX1s7tU3h/gjoMGvBbxfgmD2i1P4RPLaRxg5dsHCbAkK6ejGEVOF0AKMqCqZQaHeEXnuUg
 vULPQU34GnKryohold1Egu2KDKqls7CHPUvKXadFk91Zj8Qu48lKjqMue6g8Mctl0DLmnS3f/
 rrWButFuaKgUUnhPOdgZM8/3bEIejBdQ7nL1CBlh04Sdj0kexi76KRY71Cq5NnueBYn1MeqAY
 v8HdBOkfAH3KygiLV0N5qfZvddNCj/C0Ctv7Ft2Te0tc1Z2Pc3SHda1TxU/Icu+tGelIISGx4
 dM9gOhahn7wnNci4V9KObekShRmCaPx5IQ2rXnVgwlynBd+oBqPPpmJO348sdJwrkwLUqaQL+
 z741b05/Fpy5meYiS9FwmHqEBR1SABSr7NpTTkzRcIOLB+5AOrR0rOuJSQWhe6T/l4NLZUNHM
 H50ye7QWrLKcH+cWDydG9iGYYerVVbbqNMPBL4Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,


On Mon, 31 Aug 2020, Miriam Rubio wrote:

> These patches correspond to a second part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v7.

Excellent progress, and thank you for your patience and diligence working
on this patch series. I think we are _really_ close to being ready for
`next`.

Thanks!
Johannes

>
> I would like to thank Junio Hamano for reviewing this patch series.
>
> General changes
> ---------------
>
> * Rebased on e9b77c84a0 (Tenth batch, 2020-08-24), to build on the
>   strvec API (instead of argv_array) and adjust to the codebase
>   after the "--first-parent" feature was added.
>
>
> Specific changes
> ----------------
>
> [1/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
>
> * Amend commit message.
> * Remove casting to int.
>
> ---
>
> [2/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
>
> * Amend commit message.
>
> ---
>
> [3/13] bisect--helper: introduce new `write_in_file()` function
>
> * Use saved_errno variable.
>
> ---
>
> [5/13] bisect--helper: reimplement `bisect_autostart` shell function in =
C
>
> * Fix bug using empty_strvec instead of NULL in a `bisect_start()` call.
>
> ---
>
>
> [6/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` =
shell
>  functions in C
>
> * Remove unused `no-checkout` variable.
> * Move a comment to more appropriate place.
>
> ---
>
> .iriam Rubio (4):
>   bisect--helper: BUG() in cmd_*() on invalid subcommand
>   bisect--helper: use '-res' in 'cmd_bisect__helper' return
>   bisect--helper: introduce new `write_in_file()` function
>   bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
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
>  bisect.c                 |  13 +-
>  builtin/bisect--helper.c | 442 ++++++++++++++++++++++++++++++++-------
>  git-bisect.sh            | 145 +------------
>  3 files changed, 380 insertions(+), 220 deletions(-)
>
> --
> 2.25.0
>
>
