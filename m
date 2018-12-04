Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9D5211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLDN12 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:27:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDN11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:27:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so9416665wmd.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqtlQCd0S/QhYiJrEkVko4QdOzj+nHISlCCYXO7zjCU=;
        b=TGgSAduP5si8cWIj8a5k2oqPL1url0HwzPsP8ApNBBMAyXQ8SdLQArZCMSsRov6oMq
         yrX19Z3hvolUJ4hIjT5dJeeU37DvF6GBCzA+XDw1ImRNteJ5ZE2SPQWUu6uTG1L4+xL2
         vBbvZ0pesbFfOkXheoimEMFHvcENz3xCShl4dPKX2ez6byLS8CWANlFbzp9Pvp9v9V2Q
         OdkABgOcZ+olpQVNXqmUIs7rrDRQ/jGsjSGAD8xorb6cgmvGn0Osfmvq1i5gLFlT6N6V
         pbvLStBeA1VGMTv+dDsJCGW0FxWA9c2o0JOjtUV1zzKf7RBWUxTTcTPAOfEdrfAjtjOG
         EOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqtlQCd0S/QhYiJrEkVko4QdOzj+nHISlCCYXO7zjCU=;
        b=DbVhQY2xPL4fxJVx7pnlSDjfjA6vlYIDi54eVGsogjevsbbQJslyAt9JnyufW7v7M3
         QePapYMLV+E0/jXjmk7O0DtuN63WKwrIb7Gi/Um/iKeEobB5jd+fRRGxkNc3Sa02lJ/I
         kPc2738o82v7qY0LVvUMSqiLgd65IqT5HGdIXBHEocpI1lJZT1tIlAzwBzOaf8YxlGLC
         GrKUcZmGWVv8mtovhRQzOUrF5VkBbhIZnc+X7SERvn6IEJf7pRuclHRqwpQKep0s+fC2
         D3OAN3mVLcyeh3ZL2FuuCXgfoPb9za//9AFtr2RQJKRIQDKpIGJFRPQAD65TfF8S/Bzw
         mqbw==
X-Gm-Message-State: AA+aEWbfmhhpeMpXldN4NOdzoXH3YKaSlKKS0EuHnXFYnx382+14X+B4
        CAgP/8IiNZw0ZRfi2UvoAl8s7Cly
X-Google-Smtp-Source: AFSGD/ULj1O9/wK9Q2WjCLyFeWUfTXvmHhw2+AzPQSwG1CPmjM3VRIvo1P1MnimOlA8TFvPRzrzX6Q==
X-Received: by 2002:a1c:2d0c:: with SMTP id t12-v6mr6034112wmt.99.1543930043828;
        Tue, 04 Dec 2018 05:27:23 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h16sm24588523wrb.62.2018.12.04.05.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 05:27:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] sha1-file: emit error if an alternate looks like a repository
Date:   Tue,  4 Dec 2018 14:27:15 +0100
Message-Id: <20181204132716.19208-3-avarab@gmail.com>
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

Since 26125f6b9b ("detect broken alternates.", 2006-02-22) we've
emitted an error if the alternates directory doesn't exist, but not
for the common misstep of adding a path to another git repository as
an alternate, as opposed to its "objects" directory.

Let's check for this, i.e. whether X/objects or X/.git/objects exists
if the user supplies X and print an error (which as a commit leading
up to this one shows doesn't change the exit code, just "warns").

This check is intentionally not implemented by e.g. requiring that any
of X/?? exists or X/info or X/pack exists. It's a legitimate use-case
to point to an existing alternate that hasn't been populated yet, but
pointing to one where an "X/objects" or "X/.git/objects" directory
exists is definitely a mistake we should warn the user about.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-file.c               | 10 +++++++++-
 t/t5613-info-alternate.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index 5bd11c85bc..f142f81658 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -376,12 +376,20 @@ static int alt_odb_usable(struct raw_object_store *o,
 {
 	struct alternate_object_database *alt;
 
-	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
+		/* Detect cases where alternate disappeared */
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path->buf);
 		return 0;
+	} else if (is_directory(mkpath("%s/objects", path->buf)) ||
+		   is_directory(mkpath("%s/.git/objects", path->buf))) {
+		/* Detect cases where alternate is a git repository */
+		error(_("object directory %s looks like a git repository; "
+			"alternates must point to the 'objects' directory. "
+			"check .git/objects/info/alternates"),
+		      path->buf);
+		return 0;
 	}
 
 	/*
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index d2964c57b7..b959e21421 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -143,4 +143,18 @@ test_expect_success 'print "error" on non-existing alternate' '
 	test_i18ngrep "does not exist; check" stderr
 '
 
+test_expect_success 'print "error" on alternate that looks like a git repository' '
+	git init --bare J &&
+	git init --bare K &&
+
+	# H is bare, G is not
+	echo ../../H >J/objects/info/alternates &&
+	echo ../../G >K/objects/info/alternates &&
+
+	git -C J fsck 2>stderr &&
+	test_i18ngrep "looks like a git repository; alternates must" stderr &&
+	git -C K fsck 2>stderr &&
+	test_i18ngrep "looks like a git repository; alternates must" stderr
+'
+
 test_done
-- 
2.20.0.rc2.403.gdbc3b29805

