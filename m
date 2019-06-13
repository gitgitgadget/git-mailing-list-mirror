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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA951F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfFMP0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:26:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfFMLtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 07:49:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so30791473edv.6
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vmYVIIMgPFZWhjpRW2VI1Hc570ref6Hk4M8zWRr9VuI=;
        b=g8/ZQt9n9Nrg61++ynY/n5/EYSPVqjX9R/kVDvE+iw04VwObQATBOeepsC55URtW/d
         KxWOiJWOlnZ+vwzGHqA9lui6sKFwoN4kR5TXjouOBvD0EMyg7aLBslEmdUld2ycMrJLh
         aepZTfvyxBfKbiRF1J5EVlckk0FZDm3J5oeD1Qrj0u0x6k7zKEdFSiRo9MCb9RvdVMR6
         CE/H9+Xi3DoqCFfYDByyOo3e4gGOAPJEsv7kWGCXmv3BmUSM2KWkxkaRE20upyvQYlF3
         C1dDJFWb1u1evwL8TmwOwvTdE7RpY5TeJgZiLpLJPuAPNXa59oUycmwK4rUEjafQEoz/
         wR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vmYVIIMgPFZWhjpRW2VI1Hc570ref6Hk4M8zWRr9VuI=;
        b=fSlNikQtJRnu2ahXqjSBMElPwjIDbAN67tEjlOILcW429+hRXqAWjZNkulRJxEXmWE
         kuc5F7jHeb3ZnrGHV+ahFQzUN5ROps7rrjb6xhldXTY+vYMA+wqvZuBgGJeWCRCYsfnW
         fZbggb6x1PLOl+Za6ujkNhcSV79Vt0/181fEE9TCChcKAJ8UrzmMWxMeX4iPNYgUNcmb
         0Gw5yIWVtnouWZm0JguNLhL5OJsVRBMe+R58NaC0bQKrJ08DZlaMi6ym7JlcVzupSdlA
         7IHEj/uLA9S7/xMrEJc9J4mXbfW5ceG3rcuAVELe9hSlUKIJo4BGJmDg4mg51ROmsPPN
         kIZw==
X-Gm-Message-State: APjAAAXpkZZvzi+WIhZgPaiK7JcvNRz5foTN3r9azQGpwE5C1ZGMr6D5
        7BSUzWg3LktQ9UKKWmB7tu71HD19
X-Google-Smtp-Source: APXvYqytRDAlzEa0NnwG4TtRroyb7tO/GIo5UdPvgqCpYMyGsesJktq6NCcAW9oCciqmPNyFKeYCuQ==
X-Received: by 2002:a17:906:524b:: with SMTP id y11mr31010733ejm.303.1560426584015;
        Thu, 13 Jun 2019 04:49:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm518171ejb.7.2019.06.13.04.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:49:43 -0700 (PDT)
Date:   Thu, 13 Jun 2019 04:49:43 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 11:49:37 GMT
Message-Id: <pull.265.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] Support building with GCC v8.x/v9.x
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed a while ago that I could not build Git's master in Git for
Windows' SDK when using GCC v8.x. This became a much less pressing problem
when I discovered a serious bug that would not let us compile with ASLR/DEP
enabled (the resulting executables would just throw segmentation faults left
and right), so I put these patches on the backburner for a while.

But now GCC v8.x is fixed, and MSYS2 even switched to GCC v9.x (which found
yet another problem that I fix in patch 4/4 of this patch series). So it is
time to get Git's master ready.

Johannes Schindelin (4):
  poll (mingw): allow compiling with GCC 8 and DEVELOPER=1
  kwset: allow building with GCC 8
  winansi: simplify loading the GetCurrentConsoleFontEx() function
  config: avoid calling `labs()` on too-large data type

 compat/poll/poll.c |  2 +-
 compat/winansi.c   | 14 +++++---------
 config.c           |  4 ++--
 kwset.c            |  8 +++++++-
 4 files changed, 15 insertions(+), 13 deletions(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-265%2Fdscho%2Fgcc-8-and-9-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-265/dscho/gcc-8-and-9-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/265
-- 
gitgitgadget
