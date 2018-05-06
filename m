Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E051200B9
	for <e@80x24.org>; Sun,  6 May 2018 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEFNgo (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 09:36:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35703 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeEFNgm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 09:36:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id i14-v6so22162555wre.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXRIQ13OJ/quAhJLZCWIv4WS5wqbZsgy/XNqtMhZV+E=;
        b=oJsZsT/3p38o4Ji2Z+OL+NIozy8JUvdn8W3cB4s0j4tJ+UWALKKorYicJtWHkepmT1
         w8C4dZZqFuzTJzQhINRkwEWPpg4wToYZmXCmOD9zl8Dpjq+vcp6qjoaJ157UFEn+rkPg
         fJCPUaDOU2ITk49mn4hhDm/3+hpSACjSZJzKtU5vqRg4tZ/ql+Pf5rG7jsDSvXOQCF60
         ze4yA5TX69JC5KezjixKGQ1wrfBL3NLK2tyhcHa3Wyc6mOxg6Q2qrmnnfWiOskZdt7g+
         jyHG8XUoODR4tH2gNmPOnsdSonxsHv6vjbI2KRW+vE1JnGfYNO4lDFMKJutUE4+NdT4j
         H8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXRIQ13OJ/quAhJLZCWIv4WS5wqbZsgy/XNqtMhZV+E=;
        b=IWqX+R2UKaJp9tCTCiV+XG5OisuVnlCf+Ct50QNWX4Cvxhpa+2IU0aCgCIFTZPJigd
         cbwBD1oHDlhWfP+ciPG5glqEDjNRJw5hMtHQXkkKUJCiGPhL1E9nHV4egKbIGRQgcJyM
         CQgDzumxNlMrMVTdPcWRMjMJhSw10dMAbpwIeyyuYl02kagqjBERTDP5+Lgk9aeIgAFE
         qM9wpVIIVGJarJX4thg1ZDVNyK8K9YxBpyRkfVaymgeul3fbVOgVv+7M3CNsH0Kr7e1m
         lpbs6HYgSn5Gtc0cJ0JJuQDvfgnEBQLN+sE+uMpUie/RBRWQAb7WtSpziTS4ZOsLM9RH
         pMNQ==
X-Gm-Message-State: ALQs6tClmXw1TOUyHgchsYR6k9J4GCtqFd5+EgkQA0ligT+Xowhx8jIn
        8fOhxynJSmrgSilkxcgceorbWkj6
X-Google-Smtp-Source: AB8JxZowL7yls/thZqs7TK33vulWvQ3mca2Rc6bj/1a/OXxRxcePfEtQDugE9/PORtg69O6XtzFiAQ==
X-Received: by 2002:adf:8756:: with SMTP id 22-v6mr24590094wrz.117.1525613801761;
        Sun, 06 May 2018 06:36:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 47-v6sm18120974wrw.40.2018.05.06.06.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 06:36:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] refs: handle null-oid for pseudorefs
Date:   Sun,  6 May 2018 15:35:49 +0200
Message-Id: <20180506133549.8536-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
References: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the documentation on `git update-ref`, it is possible to
"specify 40 '0' or an empty string as <oldvalue> to make sure that the
ref you are creating does not exist." But in the code for pseudorefs, we
do not implement this. If we fail to read the old ref, we immediately
die. A failure to read would actually be a good thing if we have been
given the null-oid.

With the null-oid, allow -- and even require -- the ref-reading to fail.
This implements the "make sure that the ref ... does not exist" part of
the documentation.

Since we have a `strbuf err` for collecting errors, let's use it and
signal an error to the caller instead of dying hard.

Reported-by: Rafael Ascensão <rafa.almas@gmail.com>
Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
(David's twopensource-address bounced, so I'm trying instead the one he
most recently posted from.)

 t/t1400-update-ref.sh |  7 +++++++
 refs.c                | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 664a3a4e4e..bd41f86f22 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -457,6 +457,13 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 	test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")
 '
 
+test_expect_success 'create pseudoref with old oid null, but do not overwrite' '
+	git update-ref PSEUDOREF $A $Z &&
+	test_when_finished "git update-ref -d PSEUDOREF" &&
+	test $A = $(cat .git/PSEUDOREF) &&
+	test_must_fail git update-ref PSEUDOREF $A $Z
+'
+
 a=refs/heads/a
 b=refs/heads/b
 c=refs/heads/c
diff --git a/refs.c b/refs.c
index 8b7a77fe5e..3669190499 100644
--- a/refs.c
+++ b/refs.c
@@ -666,10 +666,21 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	if (old_oid) {
 		struct object_id actual_old_oid;
 
-		if (read_ref(pseudoref, &actual_old_oid))
-			die("could not read ref '%s'", pseudoref);
-		if (oidcmp(&actual_old_oid, old_oid)) {
-			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
+		if (read_ref(pseudoref, &actual_old_oid)) {
+			if (!is_null_oid(old_oid)) {
+				strbuf_addf(err, "could not read ref '%s'",
+					    pseudoref);
+				rollback_lock_file(&lock);
+				goto done;
+			}
+		} else if (is_null_oid(old_oid)) {
+			strbuf_addf(err, "ref '%s' already exists",
+				    pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		} else if (oidcmp(&actual_old_oid, old_oid)) {
+			strbuf_addf(err, "unexpected sha1 when writing '%s'",
+				    pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
-- 
2.17.0.411.g9fd64c8e46

