Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7741F731
	for <e@80x24.org>; Fri,  2 Aug 2019 03:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfHBDsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 23:48:53 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:41691 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730701AbfHBDsx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Aug 2019 23:48:53 -0400
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 7AC03940018;
        Fri,  2 Aug 2019 06:48:50 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id KTjGOJL42y-mmB0iqRc;
        Fri, 02 Aug 2019 06:48:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564717729;
        bh=nSTf/LMMfvO6PE0hkez4y4R5RMSOtavNm/C503nVUyE=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=ZDWeR9TjMEjphFTb/A4AEEC1paWPgAHVogPOSr0T3UJuT3Io8lqZuPuBtUCL9v67P
         6tEHuLD+/sfDt812fAwSU0u2uCPIGja+7AWN8Uv5P1K+e/KrnEo5HCWbwPxTuJB9Cp
         LVrz0ol2xUIX3bSZdiIs9Cooxr5e6uDoUXZxUJ2k=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva1-44bdf084ee9e.qloud-c.yandex.net with HTTP;
        Fri, 02 Aug 2019 06:48:48 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, luke <luke@diamand.org>
In-Reply-To: <pull.303.git.gitgitgadget@gmail.com>
References: <pull.303.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/1] git-p4: auto-delete named temporary file
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 01 Aug 2019 23:48:48 -0400
Message-Id: <28840571564717728@iva1-44bdf084ee9e.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



01.08.2019, 17:39, "Philip McGraw via GitGitGadget" <gitgitgadget@gmail.com>:
> Take new approach using the NamedTemporaryFile() file-like object as input
> to the ZipFile() which auto-deletes after implicit close leaving with scope.
>
> Original code produced double-open problems on Windows platform from using
> already open NamedTemporaryFile() generated filename instead of object.
>
> Thanks to Andrey for patiently suggesting several iterations on this change
> for avoiding exceptions!
>
> Also print error details after resulting IOError to make debugging cause of
> exception less mysterious when it has nothing to do with "git version recent
> enough."
>
> Signed-off-by: Philip.McGraw Philip.McGraw@bentley.com
> [Philip.McGraw@bentley.com]
>
> Philip.McGraw (1):
>   git-p4: auto-delete named temporary file
>
>  git-p4.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-303%2Fphilip-mcgraw%2Fgit-p4-auto-delete-named-temporary-file-v3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-303/philip-mcgraw/git-p4-auto-delete-named-temporary-file-v3-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/303
> --
> gitgitgadget

Looks good to me!
Reviewed-by: Andrey Mazo <ahippo@yandex.com>


-- 
Andrey.

