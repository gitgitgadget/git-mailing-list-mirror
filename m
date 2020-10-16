Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A85C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB17F20874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WDdcfsAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409798AbgJPPLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:11:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:42329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406926AbgJPPLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 11:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602861065;
        bh=q+x7rSCa/4j7zJe+wU8Us0dEMpb2am54iJPjStctpCk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WDdcfsALbcc5GpgQhqD1ZDHDrkD9eWYzzWUIZaORGbxkibI37Ns4zGSRgGpl/vRtp
         vbFocuMbJ95NFFLqkeBmF4KaIWW4ecrjm5pUf8pOhqjAYYIyKhs4NiiZQ/uWHW/wln
         oEXOxlCff8GErTmgQ6WteYjVcT0sPNM87IyraKwQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.47]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1kAOay37iX-00uYOA; Fri, 16
 Oct 2020 17:11:05 +0200
Date:   Fri, 16 Oct 2020 12:00:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff: add -I<regex> that ignores matching
 changes
In-Reply-To: <20201015072406.4506-1-michal@isc.org>
Message-ID: <nycvar.QRO.7.76.6.2010161200090.56@tvgsbejvaqbjf.bet>
References: <20201012091751.19594-1-michal@isc.org> <20201015072406.4506-1-michal@isc.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-760345371-1602842457=:56"
X-Provags-ID: V03:K1:KHMhU4AEnN95XHHPhOTu2jMwRA0CP1EtHhR0dCsEC/6hWs0Jrv9
 1Oc3N4lHGdUAs7RSYIAzoXRpO/YtfHv+KKGADQmtKt2dC6VqVvtJM3TL/EprdHjKuqPPW/j
 LGNpe/3HQmMCWxwjxJ4P6/UQ90wKvbZeaJ4p3qTpx3pabDz6Zvz3tRDw9Z2rt04itdlfEj2
 vTXweDOelif+TXc6MaB4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNOKbSSDaOs=:H4fP+prQ/5/oTPgjSYIX+J
 dAaKf8RyNF0BfonxvLjymysK4ES9qphJbIyHL2zcYzGMrTHsfQ9u2+klYE9nKCu21wSj9xhn7
 NIzvTsJ8qV4NMYpJpfD3hn5Q70pBnuguM1TJVAeklCMYlnyBQ4u1nGbcXBLkx0DBpVNRvbJ55
 bes0rtGofFi1+poTjqExIaWuF8Iamt9hYoiKuXmEoYRvcX8vb6x/pFKjNN4cGIoM4NbY7o9CO
 dY/e2PHPtALvTGt6CAIUFuauT4prd+imTdF9YDa8m5cps+Yu9ABMybdHOomTgEUhLW06RYOXW
 HlA/AbWbbLYU9+ItnNVaEQNEeKexzlYwOPVaNbbt/yN3/gkh15TpntdOzHcTSdYpkgMJnVV8m
 YppC8EW99thWpaYBghkRR0WwH10fTTzuH2pNnCONQiWcANpe2/NpGCXX/bfQ7KU59QmbU0DHu
 C2D9RFslvNTT1r8N6ssvmL7fvOYmGyhCzA4RWri3tMMAvZWQ4BL50rKVC8SaevEJLzo75KJHP
 Aq90+ZkCv3qcOkfiGLRFnB2i0X7T+lPm6ZG0INMOcO289WAfFDuBKUqrZnukUVIgl+Pj84ocY
 HL4HY23gAiQh8s8Yb5e2YKotQwpJqZazijwwRSHHCMKzI91/9PG4zKSt6uiLeQsCdAYsUN6Hk
 ktw5xrEkDV8e3mUOC5s7u/EdV5OX5/sMKC1aZ9tYM5vfHppPx7N7VGNJ3RtT/2jzcgxQZKww3
 cC24wvmnxNgRPSL4+cmyHaVMjFCrrxT2Ozk9ZCJPbBIit02QgiK5ROQ2ziKZuryiLPX7JW6mZ
 fQzezyUEvOYiZzFvY6tiSfZqSAipUFJ6Kg/wXydwJ9HX1f6OgDa7Dxg6JUioByowYLQ745C80
 Azee78N4D4FZO6QEGTmD+ZBTYps23vRPrRZNkP0Ss=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-760345371-1602842457=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Thu, 15 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> This patch series adds a new diff option that enables ignoring changes
> whose all lines (changed, removed, and added) match a given regular
> expression.  This is similar to the -I/--ignore-matching-lines option in
> standalone diff utilities and can be used e.g. to ignore changes which
> only affect code comments or to look for unrelated changes in commits
> containing a large number of automatically applied modifications (e.g. a
> tree-wide string replacement).  The difference between -G/-S and the new
> -I option is that the latter filters output on a per-change basis.
>
> Changes from v2:
>
>   - Add a long option for -I (--ignore-matching-lines) as it is
>     commonplace in standalone diff utilities.  Update documentation and
>     commit log messages accordingly.
>
>   - Use xmalloc() instead of xcalloc() for allocating regex_t
>     structures in diff_opt_ignore_regex().
>
>   - Ensure the memory allocated in diff_opt_ignore_regex() gets
>     released.
>
>   - Use "return error(...)" instead of die() in the -I option callback.
>     Make the relevant error message localizable.
>
>   - Drastically reduce the number of -I<regex> tests due to excessive
>     run time of t/t4069-diff-ignore-regex.sh from v1/v2 on some
>     platforms (notably Windows).  Use a tweaked version of a test
>     suggested by Johannes Schindelin (thanks!).  Given its reduction in
>     size, squash patch 3 (which contained the tests) into patch 2.
>
>   - Replace "see Documentation/diff-options.txt" with "-I<regex>" in the
>     comments for the added structure fields, in order to make these
>     comments more useful.

Thank you for this diligent work! I looked over the patches and like them
a lot!

Thanks,
Dscho

--8323328-760345371-1602842457=:56--
