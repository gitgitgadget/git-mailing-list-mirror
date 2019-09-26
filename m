Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F161F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfIZRna (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:43:30 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43239 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfIZRn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:43:29 -0400
Received: by mail-lf1-f47.google.com with SMTP id u3so2332707lfl.10
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uRVVqLMLIS3A+KEZxWwEPlBL0xMHK5I5Za2e4ScL8wI=;
        b=DZj4d2baohf13kmkdstop6dRV9kG+1x0vS8q7IyCMrS7PGLjR68FYrRPnqVyO5vPev
         ZFDbnmHDOGCHiYUInaro4HSd9cLFWlPU+baJXwEoIcTDxyOToTnIxXWhKT4rBBKnExC7
         0/HP1io5h8cwkeTzb1K7p7ooEDh3zdd5ZnNJ45ivLoGf788Jsb8GMivkaGGi87p0y3Bd
         W5NoFkZKv28sYBoFH7iZXNrXIanIWLq5mdmWuoIz4XoCC8ALE+uc3sp7D+eWfeNohYVr
         NA6dkSWPTpxL8WX+a1hK2Oiuc/+V5XELsCp3O7YkIW+DM6hRokmzn/W5pLH7RWWAi88A
         1PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uRVVqLMLIS3A+KEZxWwEPlBL0xMHK5I5Za2e4ScL8wI=;
        b=RSmlcSXCuwYEvBiNdqSfLlOzFB8jBe9fkrj0/Y8+nUf2DsIhzgmT2zrHbJmFQxG2WY
         qrwRQt/VxJUIx2JolYGtiYz0PbUAOQX8H4oklaOcZQS4JI52W4XIKpYUx7yRsmiUU8x7
         89SZig1QkGPFisBTDDySqMRwdJdoeocJQK650ghPG6jwhssoIJPGg3q+aneS9131jxmz
         cb8HGjJfAS8EUs7mewHQeMwnH35wp0/lg0ZirL7iiS8UCBpMxg/p2BR1EkZXGB/nIGIF
         qqwWDqbAR/e8N0/prPWqMMRYFIeJhikVNA1l84PZoI5h3NYm7C6lbbdH6CzXbr9GxKSZ
         SLZA==
X-Gm-Message-State: APjAAAWx2VcMKUT81kfUugghF4wuviJm00DD0Oka8rw29yvGMwng9+ix
        /LQ5jCK0rDHfbV/iG/cjLDxpL1mw
X-Google-Smtp-Source: APXvYqw7BnRyCQo0WYWdts5PjfUvc55pQTWODMZnVHcFjLOAVen6/IP/8UpcJCPtWUJaXIlXaviGNA==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr3051921lfa.189.1569519805909;
        Thu, 26 Sep 2019 10:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3sm617912ljm.103.2019.09.26.10.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:43:25 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:43:25 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 17:43:23 GMT
Message-Id: <pull.359.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git gui: fix staging a second line to a 1-line file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yet another patch that is carried in Git for Windows for quite a long time.
This fixes https://github.com/git-for-windows/git/issues/515.

This commit was contributed as https://github.com/patthoyts/git/gui/pull/7 
which was ignored for almost three years, and then as 
https://github.com/prati0100/git-gui/pull/1 which was rejected in favor of a
mailing list-centric workflow.

The patch is based on Git GUI's master branch at 
https://github.com/prati0100/git-gui/.

Johannes Schindelin (1):
  git gui: fix staging a second line to a 1-line file

 lib/diff.tcl | 1 +
 1 file changed, 1 insertion(+)


base-commit: 12d29c326551a6570594db525bea42ad9cea8028
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-359%2Fdscho%2Fgit-gui-stage-line-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-359/dscho/git-gui-stage-line-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/359
-- 
gitgitgadget
