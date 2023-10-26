Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6A3AC12
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIDJrfeA"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C40D40
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81a80097fso9946337b3.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698344559; x=1698949359; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMEjNYeE5EZuCNkc7Q5rRdAGlP3I9c97g/Sz3tWFwEc=;
        b=lIDJrfeA1bGeZWjOm6PMQHmtVlkKDJ3CYy/8iOjiMKGBsJnlt3Ny7ppIuPheTepn8v
         cXEWuSnhpFTyuws1lalNS6tq0Y7oZUWqk63inkZbdr00c3xQlDhxiwA1yTYvlJnhLpGX
         0J/+L2ixN8RZTJ16pwmi5464HTTWrdOXgn0BxCL5qmxr4jy73B4Cyb9jq36/+KDW+R4Z
         GBzOXMZ99Kt7PE9WAE1hM4UTgHwV74IoPaWV2CAifuQm09kOh7WBah18q/t+pBCx+lkC
         zH0F3fVIHyniowDrn1teq1xAomLlLqciQ1XXTfu1TxFzlYI5FQI0ZEJZwL9vFH8KsncE
         02iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344559; x=1698949359;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMEjNYeE5EZuCNkc7Q5rRdAGlP3I9c97g/Sz3tWFwEc=;
        b=ZF1PVkSzSyy473CLRQXkjliOy9trtpgRgFvnzhTvdT5KlxIcN6EnXiD5ZT2mnC8hz2
         D8kNuFdfbT4qsLSPcajwZlyuY50YEMQcFTDpJaMBJHKFwR2I9li/AKBW9z9UBKfky9WX
         CQfQ640VX0oNwDGci9repqgyvHhIGDPqGcxCtfaHyKLwMm9iWTCTNuDi3WYmQQqugY6G
         edPKlGmFV35XP59R9V/R7I141qwtc4he6Siat2HbisZECFhnltD26EzFhKEhw62tWMfV
         0S1VhLmk9a8GMPOIirrVG+ac0UqofpWXTiB5lRLwhIAACsyGb8YYprrrOe4xohqmbbeD
         9xbQ==
X-Gm-Message-State: AOJu0Yxx2Ud8KyFvKCXVBMJs0Jj8lsp9TGfYvv4c7FYCw2rtSZs+VKKx
	kMOjWX/WTdYmWIszBhqnH8ypSlmUtQpaNWOu760rAU11vnbZuUfom4pO6MJJQuk4zn83WY8LNmk
	MAUqHqJxb4BPQKeP1ZQlJBbtsHiov8En3+2f7DdZZTLs7cJr5HA5zeFI0tCGDdDVI7PNPsY/VyA
	==
X-Google-Smtp-Source: AGHT+IEAl39BbwhxbVfiOAksPyXlERvupLlPGGv80mrdaAlLnI2hMKw3oyerzSR25KjV8yIQiThVZhuWaHARpbQyClw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
 (user=emilyshaffer job=sendgmr) by 2002:a25:238c:0:b0:d9a:ca58:b32c with SMTP
 id j134-20020a25238c000000b00d9aca58b32cmr3623ybj.1.1698344559490; Thu, 26
 Oct 2023 11:22:39 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:22:31 -0700
In-Reply-To: <20231026155459.2234929-1-nasamuffin@google.com>
Message-Id: <20231026182231.3369370-3-nasamuffin@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026155459.2234929-1-nasamuffin@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Subject: [PATCH v4 2/2] bugreport: reject positional arguments
From: emilyshaffer@google.com
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Emily Shaffer <nasamuffin@google.com>

git-bugreport already rejected unrecognized flag arguments, like
`--diaggnose`, but this doesn't help if the user's mistake was to forget
the `--` in front of the argument. This can result in a user's intended
argument not being parsed with no indication to the user that something
went wrong. Since git-bugreport presently doesn't take any positionals
at all, let's reject all positionals and give the user a usage hint.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
 builtin/bugreport.c  | 5 +++++
 t/t0091-bugreport.sh | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..3106e56a13 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -126,6 +126,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (argc) {
+		error(_("unknown argument `%s'"), argv[0]);
+		usage(bugreport_usage[0]);
+	}
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index e1588f71b7..ae5b7dc31f 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -69,6 +69,13 @@ test_expect_success 'incorrect arguments abort with usage' '
 	test_path_is_missing git-bugreport-*
 '
 
+test_expect_success 'incorrect positional arguments abort with usage and hint' '
+	test_must_fail git bugreport false 2>output &&
+	grep usage output &&
+	grep false output &&
+	test_path_is_missing git-bugreport-*
+'
+
 test_expect_success 'runs outside of a git dir' '
 	test_when_finished rm non-repo/git-bugreport-* &&
 	nongit git bugreport
-- 
2.42.0.820.g83a721a137-goog

