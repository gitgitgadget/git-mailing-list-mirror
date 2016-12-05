Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C811FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 11:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbcLELqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 06:46:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:55670 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbcLELqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 06:46:24 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh6lB-1c0Ix70OSf-00MLNe; Mon, 05
 Dec 2016 12:46:16 +0100
Date:   Mon, 5 Dec 2016 12:46:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Frank Becker <fb@mooflu.com>, git@vger.kernel.org,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d not populating left correctly when not in git root
In-Reply-To: <20161204223139.kk2ejrfc5elxmsro@gmail.com>
Message-ID: <alpine.DEB.2.20.1612051222560.117539@virtualbox>
References: <68f49f5e-4e71-fd52-cd6f-64e92face962@mooflu.com> <20161204223139.kk2ejrfc5elxmsro@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dBZJRnMpjEMUN0tP/K/jbINQeCPK2XjqKKm3jglW5SQG9yIJUZL
 o/Zb+iX3zSasujPzubdr8zTatfk/kncV0BICP6uQOAhX5Pshcag2hx4ALc2xC11bAwCUoe8
 q3DKr/J26lkAs1RC9pqogC8DdZClZkcpqH3VpuAtlc9M//31z9n5KZAhpJDF1huVzMTi/5w
 G4Ea+Ihz9k4j3gZBbncMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V6BcaGn3Vsk=:+ltSNogocB4n3P4tE1530h
 PDAbMeKmppyJ0ixxiJNuWGypNyFfFNMVaQacXEgZhKYepzSMvYQL4LvLediBE+dCQ/XxgOkQN
 aQxlUXTXGtV7T7A4cjLwiSmu31MlQvnMPPDtrMGDHy+gZS4T/6awJGE+lAhioykD58HG2KPRk
 6ElAVs562Q61KSzm9L+qpTXtDZAaXG7QuCzh+D3TZS2VB8v8nYbSTLjL8G9TfZ/w1DXmgbhKw
 eH1lr/m1Hx3WOG2MYZFjiig9jjsk+8/emUWH1Wfj0MvQeQ/jkOoiNKMH9rSP40i9zpIjCDxz9
 K2+4EeozuWYv6jhy/ZVsNpN1tHbc9s97uBYho+riKuwTbI2thKKPW1FKfE6/nURPRq19nX08B
 GKNB9UMiVSS/QTizxn9wGjZykB2yDc4dkB18DdpnG41qBrf1x19jO0I4BH+ln6uUExYiE+d0l
 Flp7LpnksqX1FngDwJtBF/gtt5LeKkKkRC0hkoaqn6YDIYVOVXN51XZue5tCLI9aEyzVqsXwm
 MMiTShxroE/H6axxfR9TXyn2gxV6aYEuIBrDVk56oNm92Mfv6vNkSo/z8h1zrIVyfrnf0QngY
 ilHjfYSZ+5ZH46FeV9d+fA85JKag+9Oepst1GeKcSMNOVTuS3cTuKI9/IWn0nKE7q1fMrHEob
 pFlIIzWTx8hzJGi3E+luxvXgWbut3MG1fRvodmXh6rwVWsBMHJZk42rqxc1lut7N8L28b/jxY
 W7a9SwvEy4JKlUKsZiSn2nrlun+wCLPF06vQvg4camHv+G/26wW/1rg7mjhROCShQRnNG5ZFO
 ZQb0h6j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Sun, 4 Dec 2016, David Aguilar wrote:

> Date: Sun, 4 Dec 2016 14:27:17 -0800
> Subject: [PATCH] difftool: properly handle being launched from a subdirectory
> 
> 9ec26e797781239b36ebccb87c590e5778358007 corrected how path arguments
> are handled in a subdirectory, but it introduced a regression in how
> entries outside of the subdirectory are handled by the dir-diff.
> 
> When preparing the right-side of the diff we only construct the parts
> that changed.
> 
> When constructing the left side we construct an index, but we were
> constructing it relative to the subdirectory, and thus it ends up empty
> because we are in a subdirectory and the paths are incorrect.
> 
> Teach difftool to chdir to the toplevel of the repository before
> preparing its temporary indexes.  This ensures that all of the
> toplevel-relative paths are valid.
> 
> Add a test case to exercise this use case.
> 
> Reported-by: Frank Becker <fb@mooflu.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>

I applied this to my builtin-difftool branch (which, as per Peff's
suggestion, runs t7800 both with and without the builtin difftool) and the
tests pass:

https://github.com/dscho/git/commit/9b9a69c5ee975a4a2565343ae0a9199a6ac89609

Which means that the builtin difftool already had fixed the bug, more by
coincidence than by design, I have to admit.

Ciao,
Johannes
