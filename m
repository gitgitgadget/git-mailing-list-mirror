Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0EB211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeLDN13 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:27:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54022 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDN12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:27:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so9539299wmi.3
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tj5JmRxHr9TefsIYK1CB2jUX3VOiupQ4+7aGkUAQS3w=;
        b=gl08GYBiMtqG1jdjMDiPUWW2qxHdgA0DpskWD6Ts9OaYWn3kYwbAgjC+/VL4IIHTPu
         eRWCiZ8SVxGhkJC2sKJjfcRYImzd6l20+sFDppwJchQox7EE0eq9iCrQEQDt6qi1d2PL
         APCXkTF3rm3MIVVE+EWQB3i6OarM5BnZDCMdgcZMEJuu9jQzoHtT0DzFj8PNYTvZ7VfT
         Sj19NSNWM78B2Vr57G/VyU8GqMFxSWxGovQTGIxbu201iL/tXM+NELKYNPewJjJvKxp9
         CkhCxeU8mB9y9Htt0da3VXnuK7znKifBq7AuML8gTud3e9MmpY7V92jqsqlzf89DA8uA
         XKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tj5JmRxHr9TefsIYK1CB2jUX3VOiupQ4+7aGkUAQS3w=;
        b=MrauaEJ+lT6imjYQDfJKuO4zGVCiE5dEpohx3C+mZuDuAlM1yGQDV8UyMqMw+vroBa
         tJAbBX/YOudzCDdmXtRKhBL5R8pE6acqEkitkAYyvRpvppmXwQiu5Fp/ZztNhkNkGBFg
         ZkXwMZq2w6gPFPk1ZwsQ7vXNmGw7JKHeYNYkUr+IMRfsB78/fO9zJxYesz1AVF1Ckl5G
         kJbO5IWNxjy4IApJ0qxuGJxY0mIvQ1rjcyCUq59ijUsCHXb4xJhw4Mp2NInW9akvhpWb
         gGVMoCuOaydmFu6KlUfDXW2zSjzIuxSGGxCGPAkUayi7uHfLVAOWICn2ChIwn5d3bIP+
         4/FQ==
X-Gm-Message-State: AA+aEWZRrjpPZ82U8lDja6R7q3birBKewChz6gERK5+bt+lroLHTyBYQ
        iFWH7Md1CXH88upX6pgfNkM2aq8a
X-Google-Smtp-Source: AFSGD/Xby2QnSrwl9NxGYOPIIf3Su5cMreaPkdabWGUPvI8ySiO0bhFPRSz6X2PbXVgFYirkmtsSrg==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr12115286wmi.24.1543930045477;
        Tue, 04 Dec 2018 05:27:25 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h16sm24588523wrb.62.2018.12.04.05.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 05:27:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] sha1-file: change alternate "error:" message to "warning:"
Date:   Tue,  4 Dec 2018 14:27:16 +0100
Message-Id: <20181204132716.19208-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805
In-Reply-To: <87tvjtvah0.fsf@evledraar.gmail.com>
References: <87tvjtvah0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "error" message emitted by alt_odb_usable() to be a
"warning" instead. As noted in commits leading up to this one this has
never impacted the exit code ever since the check was initially added
in 26125f6b9b ("detect broken alternates.", 2006-02-22).

It's confusing to emit an "error" when e.g. "git fsck" will exit with
0, so let's emit a "warning:" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index f142f81658..4b9b63bdcb 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -378,17 +378,17 @@ static int alt_odb_usable(struct raw_object_store *o,
 
 	if (!is_directory(path->buf)) {
 		/* Detect cases where alternate disappeared */
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path->buf);
+		warning(_("object directory %s does not exist; "
+			  "check .git/objects/info/alternates"),
+			path->buf);
 		return 0;
 	} else if (is_directory(mkpath("%s/objects", path->buf)) ||
 		   is_directory(mkpath("%s/.git/objects", path->buf))) {
 		/* Detect cases where alternate is a git repository */
-		error(_("object directory %s looks like a git repository; "
-			"alternates must point to the 'objects' directory. "
-			"check .git/objects/info/alternates"),
-		      path->buf);
+		warning(_("object directory %s looks like a git repository; "
+			  "alternates must point to the 'objects' directory. "
+			  "check .git/objects/info/alternates"),
+			path->buf);
 		return 0;
 	}
 
-- 
2.20.0.rc2.403.gdbc3b29805

