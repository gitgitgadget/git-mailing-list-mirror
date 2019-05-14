Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E328E1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENJNg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:13:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJNf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:13:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so7967053plr.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkoybXe5Xk2MpcCdL4PWQAL/xGJBuQx9Akh4VCwFAUE=;
        b=XLD1h61pyXYBguuMzLFQb5c3j7B4II7crMFoUizmMpia1ROoeWPu0SbFJcYk+anCpc
         f2R3BWlJTsnJNIm8830ml/PxzNiLpfQQty50t/bfl35wldL9XEDx5v5LCSSz5H31rtIc
         bNcri8CS5a+W+eznVzBQiMcgH6weVjuLjPYp7pAjGsAzDiXMmmvWvutE9s2MnbPvOU8n
         e1KFAGinSRcBJ0+IPWrAu+M0B6Ln6UnG9BvcWwzPORRZVBTFIVNFG0fARe6SbLq1rcHe
         +fgpVh/5Se1vhyhHfNLxzKXYpFqYrX31T/35B14aNlJXwj4h1w+dqlrc5ryfFlnu8g0X
         g6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkoybXe5Xk2MpcCdL4PWQAL/xGJBuQx9Akh4VCwFAUE=;
        b=SJvI7qMI7dND7mJGAxUOldtJdnmOQLJk3sJ/5te1Ahuw3N3IkCwvKEU3m6PRBifmko
         1QtxDS0hdVxrMumaOHg/kDmIfV6syUs/jM0enHcYoarDigl0L86mOxe49eLIvoXirzFY
         6vY+xAJ6zKVaRNVJpRVYIFT+TXBjha52o7+ua+xe6Pf8xW1tGzpdI/D1NorX9EnAW73j
         yI7gY/cI7C1/Yu2aOChn2k/8+swwmyUcdH7zHAaPs56E0+1AMsJjwXAg6K2fA0pf9s2a
         6lRCiB0NsVWpXfTGAPWk6arLHGAX3lB9xxOK/ImR7y5pph9xg2pwkfeUoSfUzOlGXLel
         Snyg==
X-Gm-Message-State: APjAAAV4yMSlkWzLypZqprHylJ1qjM88dl8GYblH6h1G2BEvuqT7YeM+
        Jm1WOLpRvTkq1VEfck/8STl/BfJf
X-Google-Smtp-Source: APXvYqw8ugJUbYuN+ehMEKbSxnjZ2Q8lbVfiVN2n4G2YpCk9pl1m1rO9MIkviuDkysp/9jZFH8/gng==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3mr37612994plm.305.1557825214901;
        Tue, 14 May 2019 02:13:34 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id x66sm20942077pfb.78.2019.05.14.02.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:13:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 14 May 2019 16:13:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 0/2] nd/merge-quit updates
Date:   Tue, 14 May 2019 16:13:20 +0700
Message-Id: <20190514091322.12427-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190509101028.24656-1-pclouds@gmail.com>
References: <20190509101028.24656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes the test breakage when GPG tests are skipped ('side' branch is
affected by these skipped tests)

Nguyễn Thái Ngọc Duy (2):
  merge: remove drop_save() in favor of remove_merge_branch_state()
  merge: add --quit

 Documentation/git-merge.txt |  4 ++++
 branch.c                    | 11 ++++++++---
 branch.h                    |  6 ++++++
 builtin/merge.c             | 30 ++++++++++++++++++------------
 t/t7600-merge.sh            | 14 ++++++++++++++
 5 files changed, 50 insertions(+), 15 deletions(-)

Range-diff dựa trên v2:
1:  324d237f0c ! 1:  86dd0fd99c merge: add --quit
    @@ -13,7 +13,6 @@
         different UI).
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
      --- a/Documentation/git-merge.txt
    @@ -76,7 +75,7 @@
      '
      
     +test_expect_success 'merge --quit' '
    -+	git reset --hard side &&
    ++	git reset --hard c2 &&
     +	test_must_fail git -c rerere.enabled=true merge master &&
     +	test_path_is_file .git/MERGE_HEAD &&
     +	test_path_is_file .git/MERGE_MODE &&
-- 
2.21.0.1141.gd54ac2cb17

