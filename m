Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1870A1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbeKOB24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:28:56 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34607 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOB2z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:55 -0500
Received: by mail-pl1-f180.google.com with SMTP id f12-v6so7957616plo.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=S7/2CWsCFy/ZnSq665Yjj047NY2REI1bO0FewliEcIs=;
        b=su3hB3xc89lYvBtJbn3mk7AA8IJNBorhdYN9yRMDncAKqw7HnFxqtLSkqoJMbswVJ5
         /N6lnzjQt+aFqhDyAXlYAFS0RPpc9N3hNMfj1M92WPlzkxj6bCq4F7fQ1qQp/2euB+Nh
         /y11OR9OqZ6WNJn6LWpuGmKzSng593cgXDLkegDUB0TNN5ccSLta7BtLQmXh2CqNyxEz
         5kgLxOkDS7sFiyRDU49IdtrZ6a0PSqCeuUzzDPO+cIM1//yE71nVelihw4Li5HquIq82
         Lnu45e6fPOw3suhpVg5U9mkKiUoqP2xw7HJt+gKBhKOurg7dCIBfrns2KVS0RFgA2FYo
         Ufbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S7/2CWsCFy/ZnSq665Yjj047NY2REI1bO0FewliEcIs=;
        b=saLKV6wvSvSHW+ImPiqp2OFSCEqudYy/pV2sWdBaDFAiNncEqTetI+DdxTrBXuasB8
         mDaYI1tq0oReFQ5OXrMeEUGnbmFPlX5XTHgOfj+NgFjGJP0dAAu7r2sAmLBHwuPDHaN5
         JKv3HOgn+qBLlTOFLCVcsKFL4HZyWUZa23EY5Lz61CgRsRjVY0a+qKETK+oYbGNym4ny
         qY1Q+c3zvx/AZWeElO9FWKnJHwGbtbftT14YglLiTyuzzzMOb7lhZegnKlddkb7Y7qg+
         hpZiNLBHV8ZeY+YtlevGtZCZoXkw2YiO6Dmlmi1ou0tuFLdbhNgka27CJaxXv3i0FXwy
         9p2g==
X-Gm-Message-State: AGRZ1gJIToDp8nx8iS8jj5vxb3y6bise0IqYs4m0rDUm1PUtFLAkC2Y/
        oaUPFJRKLRALLz002pE/s2eb6xWb
X-Google-Smtp-Source: AJdET5f15R17fNOcCi5hFRBQovTe0RWOORKiC6bnDNDwK1m6RGM9s/JTk4HhvXEJ3rB8W2+HbL/b/Q==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr2297765plh.145.1542209114717;
        Wed, 14 Nov 2018 07:25:14 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id d69sm4037715pfg.168.2018.11.14.07.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:25:13 -0800 (PST)
Date:   Wed, 14 Nov 2018 07:25:13 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 15:25:10 GMT
Message-Id: <pull.79.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.79.git.gitgitgadget@gmail.com>
References: <pull.79.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] bundle: fix issue when bundles would be empty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And yet another patch coming through Git for Windows...

Change since v1:

 * Using a better oneline now.

Gaël Lhez (1):
  bundle: cleanup lock files on error

 bundle.c                | 7 ++++---
 t/t5607-clone-bundle.sh | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-79%2Fdscho%2Fcreate-empty-bundle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-79/dscho/create-empty-bundle-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/79

Range-diff vs v1:

 1:  6276372ad3 ! 1:  c88887f05a bundle: refuse to create empty bundle
     @@ -1,6 +1,6 @@
      Author: Gaël Lhez <gael.lhez@gmail.com>
      
     -    bundle: refuse to create empty bundle
     +    bundle: cleanup lock files on error
      
          When an user tries to create an empty bundle via `git bundle create
          <bundle> <revlist>` where `<revlist>` resolves to an empty list (for

-- 
gitgitgadget
