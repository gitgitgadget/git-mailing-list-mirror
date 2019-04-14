Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1226220248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDNVTa (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:19:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42639 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfDNVTa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:19:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id x61so12906362edc.9
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XebphK4sPQB+sagcb7Heu5GqYxhG7GuixAA7fyzbO7A=;
        b=ubB9uWzThVZUiSAOkeKxZFVFXPSGitKMvA/jKk50zyhkTY8jzgXmPRFLlQ+Zq4JuxT
         S2MroM4GgR2gziq4dCLqgOt2RM6TBQK7D50zJdYFz3nkNvj8VI1bFmC2tOHbglAwEjVy
         CvfbmGlYpXGojQOTG9xoNA+yd9u9JAhllYanWTRK1aSR4P60q/mUnPAAMCXHICcO9zez
         0djILb7aHuz1gFiFI7TNLp/K+SNr5N6UtUdRWCKfh0+UmJDC849vue9F5mAdQSizH2gH
         l9Zz1m1wm93wuusX1HvNg+17RHWNmD+dxgc2cMMV/Vzr8FcqNY3tcgWx6vZU8ZQulFWg
         3IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XebphK4sPQB+sagcb7Heu5GqYxhG7GuixAA7fyzbO7A=;
        b=s+8l/+x8r7QDuZUOiLzWX++f5D5BF7jnmQM3tyLfIxQDK5O/w5SlxdEQ7OwHRKRhPV
         pdjIdtXFS0G/jUAoWGukUv2B9ZP4rlDVSmGKfmL9E8oUtUg7PM4xUifuV9BQ9TxPtdMU
         CbAmaUejtPGWI5GqTcd5k4NceNUQO8hFigO3qQ96YJe53M4LgZFRxaN+atqVhyPvpEmR
         rMQFh1zagDAp12ybryW9PlQiYad23z69CmkXwYopo7UgC/KHFiXymI4Uk3PWBarAUMFZ
         asa8ObZq+l8IaMOi8FM6O275kMWh2XZeVcL1o5o5OpaBbxjm6GmcCrzhyH59fizm4yD+
         4beQ==
X-Gm-Message-State: APjAAAX4zFimSaWEwFaWw27C0yaRSRNlHQbacQveQ2NIXATWx5ylNQrB
        d1p81CJ3Sa3m9vakahc3wuQN478y
X-Google-Smtp-Source: APXvYqzSDIG8L544bK5ihvsZl5/5VAgoHUzpuPmRvNky+ORKAqPCeBBoon5vEHBELSKYUhijseU/VA==
X-Received: by 2002:a05:6402:1359:: with SMTP id y25mr1731983edw.18.1555276768845;
        Sun, 14 Apr 2019 14:19:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by8sm8909596ejb.68.2019.04.14.14.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 14:19:28 -0700 (PDT)
Date:   Sun, 14 Apr 2019 14:19:28 -0700 (PDT)
X-Google-Original-Date: Sun, 14 Apr 2019 21:19:25 GMT
Message-Id: <pull.179.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.179.git.gitgitgadget@gmail.com>
References: <pull.179.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Prepare our git-p4 tests for running on APFS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yesterday, the macOS agents of Azure Pipelines were upgraded to Mojave, and
since that does not support HFS+ anymore, everything will be upgraded to
APFS.

As I just found yesterday, we have one test that fails on that filesystem
(t9822, which is only run if Perforce's p4d is available).

The first patch adds a workaround, as I failed to find any way to finagle
APFS into accepting that ISO-8859-1 encoded file name.

The second patch is a fix to make things compile on Mojave again, apparently
Homebrew changed and the /usr/local/ directories need to be added to the
compiler and linker flags explicitly. Maybe this is a gcc-8 only thing, as
it seems to have affected only the osx-gcc job, not the osx-clang job.

Changes since v1:

 * Fix the tyop in the oneline of the first patch where it should talk about
   ISO-8859-1.

Johannes Schindelin (2):
  t9822: skip tests if file names cannot be ISO-8859-1 encoded
  macOS: make sure that gettext is found

 config.mak.uname                | 2 ++
 t/t9822-git-p4-path-encoding.sh | 7 +++++++
 2 files changed, 9 insertions(+)


base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-179%2Fdscho%2Fskip-t9822-on-apfs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-179/dscho/skip-t9822-on-apfs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/179

Range-diff vs v1:

 1:  52681aee0a ! 1:  6161c76702 t9822: skip tests if file names cannot be ISO-8895-1 encoded
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    t9822: skip tests if file names cannot be ISO-8895-1 encoded
     +    t9822: skip tests if file names cannot be ISO-8859-1 encoded
      
          Most notably, it seems that macOS' APFS does not allow that.
      
 2:  f006524f78 = 2:  25be67b1b7 macOS: make sure that gettext is found

-- 
gitgitgadget
