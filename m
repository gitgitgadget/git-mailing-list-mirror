Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF619202A2
	for <e@80x24.org>; Wed, 18 Oct 2017 08:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757256AbdJRIFd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 04:05:33 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:43959 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdJRIFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 04:05:31 -0400
Received: by mail-vk0-f53.google.com with SMTP id t203so2766720vke.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=P5HeBQsC09VF7FHU2Sn+EA10hXohh7dyNKuMOxhBYm8=;
        b=NSXwexNDBcTlwQZ2PoeS/X3QDR2H+HTJAZXa4WrmKIl32EbFppH7Lzi2db+IuIM6Xa
         FycFNFLXQfjoUN6v8J7xTUacw7Zjxm6QujZGMNxOAKTGGDP+Pr/aVFFwmN4HaNXV++Zh
         t+p24/YRURXwURyhwoZEt+vIUxRRp3drX+SLxqvSXSDlj48HOViLCstwCddbk7FWESvl
         c3jojwLWrzXggTsY1+wm8TXeTPJMb+U06nDP41PXkrFYJR3fWzrUZVO5BeuiWcy5UNIW
         12iWBHNGH/vQaNARZUb2uwCLNo5lbX2O7WeI9sWq18fMsizzpmOKriHE3mza+0SJqe3W
         2/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P5HeBQsC09VF7FHU2Sn+EA10hXohh7dyNKuMOxhBYm8=;
        b=JtOHShLRg+eqRkB6QGFXfHGNnO0NYWYZIngQ+MOGlsRzF8hTKg79adpFYdWDLTDpAO
         YzmJdSu0nDvVTlrgyA4qkHsyNJHgpuSZBjE2Ena+uRKMjvNufQjEm9g/hG+51h1MuzUT
         gHUCtyqQqdxTDiyEpjYcC8So6ASVstzM9vdHtgTXbxdra7CiqVhfRGfV013WzLpBtfSc
         7mgLDiSWFfdkcmKwQm8pjnMCjYLxroZI3UXHrX3ZJgJJT4/0Sxlu50DL4YGep5vHaHhG
         N9tvVY4RB7nlVhPSzC8aEcAsU9VITGLBSte4yGc+hFGcnhjlmyAkjKfRRdld0QHHT9Fu
         sSwg==
X-Gm-Message-State: AMCzsaUQFMTJY2n4SnA6JiwcaCGk1X/w5P+qr2gUjBvCSVeGWUTkqw6U
        OUP7fBsk4+j0ag0pRB4WuwHAR1QTId0uU30TXpDl1A==
X-Google-Smtp-Source: ABhQp+SVvHQUm4jhLQ3cej0rEPL+ZWtrrmd+i1TRagIMwkFuKmkGb9qVGfC8ZPoA95ZEiqCuJJkyX8UVD3wd7FRzU7g=
X-Received: by 10.31.150.73 with SMTP id y70mr4778499vkd.183.1508313929977;
 Wed, 18 Oct 2017 01:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Wed, 18 Oct 2017 01:05:29 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Wed, 18 Oct 2017 11:05:29 +0300
Message-ID: <CAGHpTBKF=zuxkihnzW26y2Bp4iEJmv5SoACLTZZxA5SjGoLoEA@mail.gmail.com>
Subject: Lightweight tags are still not considered on git describe --contains
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There was an issue with lightweight tags that was supposed to be fixed
in Git 2.14 (by branch jc/name-rev-lw-tag).

I also proposed a patch[1], but that was too late, after the other fix
was already in master.

Anyway, I still have the same issue with git 2.14.2.windows.3.

My repository has both annotated and lightweight tags, and git
describe on old commits that's supposed to show an old (lightweight)
tags always shows the first annotated tag.

I rebased my patch on top of master. I'll post it later today.

- Orgad

[1] http://lists-archives.com/git/898695-name-rev-fix-tag-lookup-on-repository-with-mixed-types-of-tags.html
