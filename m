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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F53B1F462
	for <e@80x24.org>; Fri, 31 May 2019 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfEaSh2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:37:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35461 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 14:37:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so7155938wrv.2
        for <git@vger.kernel.org>; Fri, 31 May 2019 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k2JNmXLcgKA85SfuO14ZLsbQlDtFrZXa21wfaZddkXE=;
        b=qWVkgAZJBeUDCrgyj6hwZO3tincUHc4NwszdcrrUgm+sLdwe943Xm5ZkRKDUNV6Feu
         IEJYfQD8Y+bst9NBTwG65+GlP8nRedCg0hgdzpJUipNzzIQ0EgUMBDI/jxjqO1OE7lJE
         yDBNqBw+GC0nTiu24h9zY0OTq0/tiWQr6v4gFhAvpaDJp7glc1Xs85LFVIncpBFh5FGk
         mNLJoTK3ZRWkqU4o/c8LVZ1KzOsBp/FG2zHlndft9ZGK3VIXFw3y+eBjt9YjPC1NuHLh
         IBkuYcMKc4KJBwGaiD0PtW+EbmVUBLqGHxkBto57HNda/vWCTL9SLBnJOYW7kbaUgWNf
         Xl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k2JNmXLcgKA85SfuO14ZLsbQlDtFrZXa21wfaZddkXE=;
        b=O27l+jbkbBT0qW4sF1B4ZQFcPNr1gIzWIGATssQ8LDEpCXvsDrgZShBs/SOczBqTY8
         V8i0IOub7CSfBOwi+90RD/tVYrOon+oj21QQe7q2pHzLvolLC9RMuT+x3kj0gOcILRGB
         HSWIZ3S+NWeVXZ4fikbJ3AZztQIz2uweksfoY6AAaMoGXZSh7Ri6qcneKaJjoC5BMa1S
         ZFc/npQk+ko6r35uVTknTpLg0lnnCyKYfPxlhj/wFnKmFaPwbrmJGKxET5gsQ4Y5iMx4
         Z6z7k3EtNKmrdDnNCl7819miQT+gogsaiOwbrZ6/YT1gFfCp08bxgHpvAQRw0GGHZbd0
         CjDg==
X-Gm-Message-State: APjAAAW5jGk07RjO6uWZIYH5SendbwemgN9qgO0RzDbIpX/B+upI486x
        5iuqHrBJjD4N0O0CqJEJEaXWw5mA
X-Google-Smtp-Source: APXvYqz/5R+5OGB43HQ3Tx3sPGI3Q1jlb1cUG4u1UKRvHpvrIjRGNr+0z84uSnl0KtQo97A4rOZEgQ==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr7433885wrp.325.1559327846104;
        Fri, 31 May 2019 11:37:26 -0700 (PDT)
Received: from localhost.localdomain (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id w10sm10350234wrr.67.2019.05.31.11.37.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 11:37:25 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: [bug?] clean: Demonstrate failure when used with paths
Date:   Fri, 31 May 2019 19:36:51 +0100
Message-Id: <20190531183651.10067-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

Yesterday on #git, an user reported the following behaviour of
git clean:

    $ git init
    $ mkdir foo
    $ touch a.txt b.txt bar.txt foo/qux.txt

    $ git clean -f bar.txt foo/qux.txt
    Removing bar.txt

Where the behaviour they expected would be:

    $ git clean -f bar.txt foo/qux.txt
    Removing bar.txt
    Removing foo/qux.txt

Sending this "patch" as an excuse to not forget this bug report.

 t/t7300-clean.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..eecbd98906 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -92,6 +92,20 @@ test_expect_success 'git clean src/ src/' '
 
 '
 
+test_expect_failure 'git clean a.out docs/manual.tmp' '
+	mkdir -p build docs &&
+	touch a.out b.out docs/manual.txt docs/manual.tmp &&
+	git clean a.out docs/manual.tmp &&
+	test -f Makefile &&
+	test -f README &&
+	test ! -f a.out &&
+	test -f b.out &&
+	test -f docs/manual.txt &&
+	test ! -f docs/manual.tmp &&
+	test -f src/part2.c &&
+	test -f src/part1.c
+'
+
 test_expect_success 'git clean with prefix' '
 
 	mkdir -p build docs src/test &&
-- 
2.21.0

