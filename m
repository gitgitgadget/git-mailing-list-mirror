Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAA3AC11
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFiMTuay"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1D1B6
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9c4ae201e0so1195054276.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698344557; x=1698949357; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6LMH7BWP8BaLcBZuxSA09sRbhe59IkPJxDU8ARQW80=;
        b=WFiMTuayTGHGf9farlxlIBUqB4ZTNrbSISxrl1A8HWr9MuBwuIfY4fICNzSa9hi65m
         kXHW/lcJBcsCzr+RmxKYuaba5C3OqxjPfksVbB4KMoWqFqTlvOV25Qxsid2/NrG+wU+m
         vt5I28KbTqzieVJbo3HtgV8dicULHKpHrW8J2LVQSHkoWoa6Edb9HO+M2iVlyl/pa4pd
         8YWb1YSrFco6oPwqqSY2GRBZdc4bBmEobdVBkgwj1khKqYWCCEINpFWmCLE2aZLBFETy
         LLqPo/fOvJEPICum8aRG+5ugoTU/e69fQ091oyIKBXhQGOvsDO/tP9K8nqRmyIYt44cb
         GmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344557; x=1698949357;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6LMH7BWP8BaLcBZuxSA09sRbhe59IkPJxDU8ARQW80=;
        b=j5tZlX5e7FlmCOThLCgMye49GjCRw8RFebR9YtokMBx53xv0b9M0aAJHmKsDOxeybJ
         pjwikaQNPkZxQBtNGH9Akz07wAONwSTUE8QFMRWLm1Xtu23CetezSPsFwauVWP+Nw/62
         +tKcEHJy1Gd84ae/BUKyGHBr/EJ7CbeTPodgHFvxj4zTNYbROzcGHgmrLPUYrOEqGxBV
         9JMpADUY8o1/8ShLM8g+/6yAx1qzpp/7B9rIBXmdTvM8Iy+bRkldDKhmsc/9fp5OR3V9
         uR87/iHbr8di1wN2ynNk/Ua30NJ60x61kmDrvO19IIn27MSoLEzAv1xXXFYHEg0rDG6R
         CtcQ==
X-Gm-Message-State: AOJu0YyjB8aVbYau9KHMJQELeANZCDe/JZozuweJGmlp2qcku23FYcrb
	rB1QDDmhYO/cA4aCgpgwPpbXy+PWrv5CuIgGoNI+ThpHjjyLDdXy2pkhxWNcNkjkl4wxrFuW1DF
	Om4tggiFxOD9g6D0LOsnM83vmkqrU1m5zHlamZE5t8RWD2BdKNmYtcmjz6VwDdEHLPkeG6zxxqg
	==
X-Google-Smtp-Source: AGHT+IF3UVKOuf6W/ska8kF3Ei8Wj3N5UF2IcXjKeautoA/6/y6XXbuhYIXsBo/HcxXWl3HJ/KUe98W06/1fAYzeXVs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:98d:0:b0:d9a:ca20:1911 with SMTP
 id c13-20020a5b098d000000b00d9aca201911mr96947ybq.4.1698344557575; Thu, 26
 Oct 2023 11:22:37 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:22:30 -0700
In-Reply-To: <20231026155459.2234929-1-nasamuffin@google.com>
Message-Id: <20231026182231.3369370-2-nasamuffin@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026155459.2234929-1-nasamuffin@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Subject: [PATCH v4 1/2] t0091-bugreport: stop using i18ngrep
From: emilyshaffer@google.com
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Emily Shaffer <nasamuffin@google.com>

Since e6545201ad (Merge branch 'ab/detox-config-gettext', 2021-04-13),
test_i18ngrep is no longer required. Quit using it in the bugreport
tests, since it's setting a bad example for tests added later.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
 t/t0091-bugreport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f6998269be..e1588f71b7 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -65,7 +65,7 @@ test_expect_success '--output-directory puts the report in the provided dir' '
 
 test_expect_success 'incorrect arguments abort with usage' '
 	test_must_fail git bugreport --false 2>output &&
-	test_i18ngrep usage output &&
+	grep usage output &&
 	test_path_is_missing git-bugreport-*
 '
 
-- 
2.42.0.820.g83a721a137-goog

