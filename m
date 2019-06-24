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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAFE1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfFXNDa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35154 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbfFXNDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so6877338plo.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2S5IpLFhEb9dDLUGXjl2/30oMiqG8v3lcU0Yp/u58U=;
        b=iEvjogis4OKDD8VipTR72e24JlmDpGZnduzslo5UAuShg6Mke/yDwGSHaVII3FViQ0
         Xmq4SY4S91cPeH0UkNG744MqvbT5Avzhp/bu/M3lQ6X969nGO/QN30DRfxEu1d1RSRdm
         aro5d3nGfqxwE+TJ6ennrzr5eQnQPrd9hTi9Z3BJQCKh7tKF+c7D5VEAJy61KTMseVeS
         eZbMks0p8Ip6HwGe6LDJhYCAp1zubFvjkoHhIAoP4lqAliBH/GFyubY9diz6+pBbclMl
         LRsk9mpsja6NwK7HN6wxypSnIkJOGSb2le68RuRNF6yt7RtUBntAU52ACXVNWG/e+GoJ
         97yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2S5IpLFhEb9dDLUGXjl2/30oMiqG8v3lcU0Yp/u58U=;
        b=WIH6ERQ9L0WdUqrNHNmVI/b0ELSCOEWZOHGmlhLi+vzD0J2YsCeF7K58beNHh7acQp
         SG6wchOK9ghdO54IofsK0BPGvo3bHwq2xCoIpPHoAEKUBLcDaJm1p4m2KUUE0u+2iUpz
         CSgPceCrk9W1NE55iYKSfu5ZFGlVIC8eutOQx0/0GDIVMDqxuO1IufmZS2+LphbPAJ8E
         S6i6+x1EWJsnEdj1NL8XJo/ZRN0Ca5i81KrpD010td8QNfy13XhC3vDWRzYc0ZtyFB9e
         AwHC3f/XokfqjaTRFwdaoJlbU4SylIP0N0ucwPBYIoXroT9lB6FKEg+E+rDi7EWNZjXE
         c2lQ==
X-Gm-Message-State: APjAAAW2XSwEKrLPr8rcv39VQPerLRHcJwslMOLrDnpVgMFJvxblwmzu
        QunI4C3kl6tURXfxH1edvf9Po/kQ
X-Google-Smtp-Source: APXvYqzOWNuNye5lgJgHX8iN9MlqqTsX4FGmh2OHpk8lnKxtaQxE31OuCnvOKHwP1z1NriJi55Ne3Q==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr78458885pla.213.1561381409415;
        Mon, 24 Jun 2019 06:03:29 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id g2sm10682433pgi.92.2019.06.24.06.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/10] read-cache.c: dump "EOIE" extension as json
Date:   Mon, 24 Jun 2019 20:02:24 +0700
Message-Id: <20190624130226.17293-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c             |  8 ++++
 t/t3011-ls-files-json.sh | 13 ++++++
 t/t3011/eoie (new)       | 96 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh            |  4 ++
 4 files changed, 121 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index e5183636fc..37491dd03d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1731,6 +1731,14 @@ static int read_index_extension(struct index_state *istate,
 		read_fsmonitor_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_ENDOFINDEXENTRIES:
+		if (istate->jw) {
+			/* must be synchronized with read_eoie_extension() */
+			jw_object_intmax(istate->jw, "offset", get_be32(data));
+			jw_object_string(istate->jw, "oid",
+					 hash_to_hex((const unsigned char*)data + sizeof(uint32_t)));
+		}
+		/* already handled in do_read_index() */
+		break;
 	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
 		/* already handled in do_read_index() */
 		break;
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index dc57138f5b..9f4ad4c9cf 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -90,4 +90,17 @@ test_expect_success 'ls-files --json, rerere extension' '
 	)
 '
 
+test_expect_success !SINGLE_CPU 'ls-files --json and multicore extensions' '
+	git init eoie &&
+	(
+		cd eoie &&
+		git config index.threads 2 &&
+		touch one two three four &&
+		git add . &&
+		cp ../filter.sed . &&
+		strip_number offset &&
+		compare_json eoie
+	)
+'
+
 test_done
diff --git a/t/t3011/eoie b/t/t3011/eoie
new file mode 100644
index 0000000000..85ec61517b
--- /dev/null
+++ b/t/t3011/eoie
@@ -0,0 +1,96 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "four",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 1,
+      "name": "one",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 2,
+      "name": "three",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 0
+      },
+      "file_offset": <number>
+    },
+    {
+      "id": 3,
+      "name": "two",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 0
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "IEOT": {
+      "file_offset": <number>,
+      "ext_size": <number>
+    },
+    "EOIE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "offset": <number>,
+      "oid": <string>
+    }
+  }
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4b346467df..9d5b273b40 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1611,3 +1611,7 @@ test_lazy_prereq REBASE_P '
 test_lazy_prereq FAIL_PREREQS '
 	test -n "$GIT_TEST_FAIL_PREREQS"
 '
+
+test_lazy_prereq SINGLE_CPU '
+	test "$(test-tool online-cpus)" -eq 1
+'
-- 
2.22.0.rc0.322.g2b0371e29a

