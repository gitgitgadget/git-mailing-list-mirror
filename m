Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494ED1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHXSzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41589 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXSzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so7789124wrb.8
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bek+ADgiK+VBh5A0DOkt+rUD/8rca6qLqmg3fzvIiio=;
        b=c8NvGAk6ysCBxDGr3c3qzMtFgpMWz6nRyGBp/E08rQgxsT2Sf3Gp5CS87TnAnfplgs
         BteGEeIBEVEG25HLePEiQch8wbXOKcJbG2ZNE9CrHxGKeOehwoUxlRq4TZwZyDWN7cuL
         VaMruoULWk9HwyaYyPzvtlUiNlORYhtTTXwUdLGlhqaP5fIuVtGUKeaCRwiesBcYDP4v
         2HENOduEJE3FCZMKCgmZ+DfQdd5LbL9sN7b86pN0T+7LVQl22TUnVhvNsSiqw67TWGbP
         6+LuzYdSEycBlnI52YoGnSR9dCXoIUYRiVBy6PB6HfSirz54xS0J3LBMm6xbUIFMW8ju
         WVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bek+ADgiK+VBh5A0DOkt+rUD/8rca6qLqmg3fzvIiio=;
        b=OEjJXetwvklnjO5TqLFNdiF5yj0AJ0g1reKwQ4C8T7w2hkBGAv0GaQ68siV30LvLJb
         kQohOS5E2bCBbU4A25KwtmyHyVfSp5agObsawz24XXHWWDqsyCFcPX3A+ftS32NtJsqS
         T9qYM2ELQKGRZKO52wRWUBBlbKCxIgyqdQR+gtn3yClL82yjHcMblPdr7v21UV/LDLyY
         tf/9igySZ/Wl4nCDk3xMA9fd+GRAB6oeaynS/DzRNaPkm1FeNsDEpEgX0PL6FkWScq7H
         26NMt5Bkwp9+NIO5Mps/54wKGAkfA30119lB0SsT1HQMLtyCpgBvSsv4TN8aigi/ljSR
         dAOg==
X-Gm-Message-State: APzg51Dogxc6N7t1BBQ0GvrvgSkB2CWxIXo5CeSPqri/iRYkLNy6/Q6/
        A61a5ER2qYsK0+pRMPRX0gDnHI46KSo=
X-Google-Smtp-Source: ANB0VdbvtXbU1boM2cj7BXqPvJpDqLeo2HJZGuodVJcLBnm3gglXtJu3tarUKSFFA67yZ7xTzrKkFQ==
X-Received: by 2002:adf:9ab7:: with SMTP id a52-v6mr1451911wrc.75.1535124037575;
        Fri, 24 Aug 2018 08:20:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] tests: fix and add lint for non-portable grep --file
Date:   Fri, 24 Aug 2018 15:20:16 +0000
Message-Id: <20180824152016.20286-7-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --file option to grep isn't in POSIX[1], but -f is[1]. Let's check
for that in the future, and fix the portability regression in
f237c8b6fe ("commit-graph: implement git-commit-graph write",
2018-04-02) that broke e.g. AIX.

1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 t/t5318-commit-graph.sh       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 75f38298d7..b45bdac688 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -43,6 +43,7 @@ sub err {
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
+	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3c1ffad491..0c500f7ca2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -134,7 +134,7 @@ test_expect_success 'Add one more commit' '
 	git branch commits/8 &&
 	ls $objdir/pack | grep idx >existing-idx &&
 	git repack &&
-	ls $objdir/pack| grep idx | grep -v --file=existing-idx >new-idx
+	ls $objdir/pack| grep idx | grep -v -f existing-idx >new-idx
 '
 
 # Current graph structure:
-- 
2.18.0.865.gffc8e1a3cd6

