Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7841F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeK1HME (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:12:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39756 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeK1HME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:12:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so20115264edt.6
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2KydrYqX3dEEC5+KaiXu/Y0yo9n3R+A7pgswqMdYF8=;
        b=F5gqNW4i8bJP+vCdym7JWmCyyxpW9XrSAxd0n8dygQeK59OOzlEuG4nntm+s8U5BY3
         h3J8e9SZ2UBK1oyelnvGvP/Sb9rjkn9SqiCSk8yffH9/rJv04zzz/qNmhOvTnAFa+sS2
         /S4VFuZudNrL8SPjloTPGCGsS55rPU2OCFexUbrFPv7jew8K+Y0v4J+bsCkqIMdIF73n
         0mwtiTEa9TzgNLOIoakx114+gj68HgYRk5vVu9i1JmX+nZgbI3quoFExBTsPeCkP962g
         CoaOjGzct4G6cVYyGKXL691a3+YEGMEFR6t3eKdi5/wKa0840cX/Kd4w3HsAQEAzFCRT
         q6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2KydrYqX3dEEC5+KaiXu/Y0yo9n3R+A7pgswqMdYF8=;
        b=WHeUAAohEgjnEjetIfMzYm40PKt3JjaffPSguMdnoVz+/Atwfm1Ee5dp69s7E5YZJ/
         InEEW8KrSAa6D7EvWvsjv98T5RM12OLbD3sBlgm+BIPTE8L7IyQ7s6HOzjhKYzEV1NHm
         EBAiacejAgc5QuLChp2jGkd9oB2la0bHOiNnQnbZJOGlZXfSj9UPAd5MZ2lVKFGeg1xH
         9peXjsI9hlbtMsO6v/5+bBK67ZTnd8hVd0+qmh5vt62EJsYufYmT77YrmMgznXdHdQIq
         51Hb/l7OsjmJhst1j9UhVvCXzQn+zFcxk57Te+dJHU+Eq8752mASRRc0ELS+yqlYNc05
         SWag==
X-Gm-Message-State: AA+aEWb18K3BGB1ZM7nhwB2RSCSNvayZSciz/h80DwpgyAsUm97SWw4f
        yEy4t7HIBpymdgXLfcqjSk1xIrrY
X-Google-Smtp-Source: AFSGD/W6Zz4f8U+UMUilbah0nVN0tNOlSzBNiT51jb9BJiUmUIUu3wLRZ4vv7znqkKSizQMvnoB2yw==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr23436060edc.71.1543349580277;
        Tue, 27 Nov 2018 12:13:00 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm1158152edt.6.2018.11.27.12.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:12:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] advice: don't pointlessly suggest --convert-graft-file
Date:   Tue, 27 Nov 2018 21:12:55 +0100
Message-Id: <20181127201255.3529-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <82ccde9ed8a390133852a5d9e07ef471f94db263.1524955439.git.johannes.schindelin@gmx.de>
References: <82ccde9ed8a390133852a5d9e07ef471f94db263.1524955439.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advice to run 'git replace --convert-graft-file' added in
f9f99b3f7d ("Deprecate support for .git/info/grafts", 2018-04-29)
didn't add an exception for the 'git replace --convert-graft-file'
codepath itself.

As a result we'd suggest running --convert-graft-file while the user
was running --convert-graft-file, which makes no sense. Before:

    $ git replace --convert-graft-file
    hint: Support for <GIT_DIR>/info/grafts is deprecated
    hint: and will be removed in a future Git version.
    hint:
    hint: Please use "git replace --convert-graft-file"
    hint: to convert the grafts into replace refs.
    hint:
    hint: Turn this message off by running
    hint: "git config advice.graftFileDeprecated false"

Add a check for that case and skip printing the advice while the user
is busy following our advice.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/replace.c  | 1 +
 t/t6050-replace.sh | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index a58b9c6d13..affcdfb416 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -495,6 +495,7 @@ static int convert_graft_file(int force)
 	if (!fp)
 		return -1;
 
+	advice_graft_file_deprecated = 0;
 	while (strbuf_getline(&buf, fp) != EOF) {
 		if (*buf.buf == '#')
 			continue;
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 86374a9c52..5d6d3184ac 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -461,7 +461,10 @@ test_expect_success '--convert-graft-file' '
 	printf "%s\n%s %s\n\n# comment\n%s\n" \
 		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
 		>.git/info/grafts &&
-	git replace --convert-graft-file &&
+	git status 2>stderr &&
+	test_i18ngrep "hint:.*grafts is deprecated" stderr &&
+	git replace --convert-graft-file 2>stderr &&
+	test_i18ngrep ! "hint:.*grafts is deprecated" stderr &&
 	test_path_is_missing .git/info/grafts &&
 
 	: verify that the history is now "grafted" &&
-- 
2.20.0.rc1.379.g1dd7ef354c

