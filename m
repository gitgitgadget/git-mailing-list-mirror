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
	by dcvr.yhbt.net (Postfix) with ESMTP id F02F41F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfJBV0S (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:26:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41994 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJBV0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:26:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so497935ede.9
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5d3WAgvtWIHP/Xc+rMKVjApDfq4O2I6zUMY1bIpZ/4=;
        b=VjueydXfwK9x6zEZsTCl3Z+zzTXrg5YJm23HGhIYBmGFNdEE8wbInVngDJ1d79/JOJ
         XSu/3eguBtn1y9/Llg8a9FTp/JRrDQnXHxZ6DOtqQXbS2wESMvqlqa74thrdZQfRppll
         gIqAR7bOF89g4S7BwY11/W2qNRNPvRmRdMW/TJkEtIKCnWlJlidEJ/7LXAVPUDszEUY1
         1+Wx7ayVNbnVvR2Yjt3pSwkKetetMT5VE4MKghoPZCuu89I6Q+cVovNP61CuAjDEXVml
         jJOtocROnoLvHsTr9GCpdrHDpLoV/tIzHgvQ9D1dChlmHz8UtlQcHidkFjjKg/r2zlQl
         Iq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5d3WAgvtWIHP/Xc+rMKVjApDfq4O2I6zUMY1bIpZ/4=;
        b=aaiH8PIKvTSORo8lL4y9TSv1+O4XhKSqS+akv7Ql972kci75v9lojgKKZgetqWHmvt
         cR1or+ulK2KsVw8QfnC8+XhtGOruJj/sxon5bxt3YL24kfqNmsDRXOXXsoe7QjAvWV3M
         ZgXCR6FkbnjF/hEUzDRs9+AQycvIGZYWsxqRslJTBdfjAxZ+Pz1hqOeNve+93TXxyewn
         yqR4kYlrngwroyLq0DL/pv2AqwVcgIluN6cYegV/RDAsydtwuY8wbuEJi9nbIYXcBPgw
         oogmLatIhw8ZCb7u3Fr0LffxXaRK7tC1AGB3vNkiJkpNQM3oylxC8Oh2EbFpgGCERQ5s
         VAIg==
X-Gm-Message-State: APjAAAUjD4aqE5C5I01DEc7h/pX0oiVNr3vBAAEbxLSO0CCT5AneHbP7
        2l/jJPr1D2CUk2S8VTA=
X-Google-Smtp-Source: APXvYqyW79GrthgPIGQFlJNqKFCgve23SsR2soZoiBk8kzKyYyAC1KWYmdBu7CNCVJ5X+0TOiR0Kig==
X-Received: by 2002:a50:fa09:: with SMTP id b9mr6139691edq.165.1570051574683;
        Wed, 02 Oct 2019 14:26:14 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id t4sm63674edq.35.2019.10.02.14.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 14:26:14 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/3] format-patch: document and exercise that -o does only create the trailing directory
Date:   Wed,  2 Oct 2019 23:26:11 +0200
Message-Id: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/config/format.txt    |  3 ++-
 Documentation/git-format-patch.txt |  4 +++-
 t/t4014-format-patch.sh            | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..e17c5d6b0f 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -80,7 +80,8 @@ format.coverLetter::
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-	current working directory.
+	current working directory. Only the trailing directory will be created
+	though.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b9b97e63ae..fe7492353e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -66,7 +66,9 @@ they are created in the current working directory. The default path
 can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
-`format.outputDirectory` points elsewhere, use `-o .`.
+`format.outputDirectory` points elsewhere, use `-o .`. Note that only
+the trailing directory will be created by Git, leading directories must
+already exists.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca7debf1d4..bf2715a503 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1632,6 +1632,22 @@ test_expect_success 'From line has expected format' '
 	test_cmp from filtered
 '
 
+test_expect_success 'format-patch -o with no leading directories' '
+	rm -fr patches &&
+	git format-patch -o patches master..side &&
+	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+'
+
+test_expect_success 'format-patch -o with leading existing directories' '
+	git format-patch -o patches/side master..side &&
+	test $(git rev-list master..side | wc -l) -eq $(ls patches/side | wc -l)
+'
+
+test_expect_failure 'format-patch -o with leading non-existing directories' '
+	rm -fr patches &&
+	git format-patch -o patches/side master..side
+'
+
 test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
-- 
2.23.0.11.g242cf7f110

