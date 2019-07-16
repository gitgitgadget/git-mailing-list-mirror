Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7611F4B6
	for <e@80x24.org>; Tue, 16 Jul 2019 14:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfGPOEZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:04:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPOEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:04:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so18774056wme.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z2Ez/E0gYnFWIgNM5FNoQ2zbD18QSzVC6b4mtGKT+Cg=;
        b=b3OMhrPq50k/x/eRDtpaG5SHilQA3zkn8hTGY5I5iGwkgTLRifS/4Z1eP1dOqs+D26
         QnaqCo5CYw4wBXeJZLBVVV4/rr8GP6bqXJ46+6Q3F6M/ST8xfx0EyRNultcjO4JxHDia
         VR+lq7F6QEoqm1ceyCbCCD7r4+uZfOLbWriPF7LpWrKScJarEO5XYjlnhat+kI7ZxC+G
         OmkJ2tsZ3GDzhACQnoT3+Cu9O6GPQH/oqCqnA78hTkvh5I7mI0UCaOfd2QRKL0WQ4SBX
         PBQe3w6UpatKwnlKF68dw+ozT+9oskenj0dOXqfwUCVn38EnZsHrvtb0Wp3mIMGl+H6k
         tNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z2Ez/E0gYnFWIgNM5FNoQ2zbD18QSzVC6b4mtGKT+Cg=;
        b=klYYGhg6taoRaj3Otj1h0cvFlQe/yNG/ep4Z5VXlQuGWssLwjX2pVYZyOUI9+BnUVV
         d+dBwyK+Pbn4smlDqWe+dIku3RXqFfrPTNOOVO7WxgumtCBylDdLzVvSh1R+YW1+mmt7
         jgojn8jB4Es5FAdhOxuRvenpUy5UW2nJ0gJKd/rlAHe5z9DOIQB4HsHe/UkUCjXHKPNf
         5mHKF1uAbtHypSzb+uqXgYSWI0TQ8T/jZc2hMfNcMFga45aXUEDN3WnkFr0m+YaQWaz7
         WKOMV++sZB41Mk5k6tbH1P/qBu576wUwR4+VbnBGEG9Afk86Y5R7lcZ7q6v+lHxAdnCq
         Vfpg==
X-Gm-Message-State: APjAAAWbBFpq5roWCQTUgog2mF+5pRhhsTM5aZaTPmxiHXGGUIioSIN2
        ijLAaV3al9a334kTdYELr04bQCW3
X-Google-Smtp-Source: APXvYqy8uhD7nCrvEaq9JwLnKZZFWOwrX+axhEkELZoWCn/HNmK9XEs8jN8psPh8z+jbY5GXQxbGWQ==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr28657953wmg.159.1563285863493;
        Tue, 16 Jul 2019 07:04:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm15274946wrq.48.2019.07.16.07.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:04:23 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:04:23 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:04:21 GMT
Message-Id: <pull.219.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Show an error if too-long paths are seen by git clean -dfx
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

This is particularly important on Windows, where PATH_MAX is very small
compared to Unix/Linux.

Johannes Schindelin (1):
  clean: show an error message when the path is too long

 builtin/clean.c  |  3 ++-
 t/t7300-clean.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-219%2Fdscho%2Fclean-long-paths-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-219/dscho/clean-long-paths-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/219
-- 
gitgitgadget
