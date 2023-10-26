Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708715C3
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yljWxAz2"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB74136
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 17:55:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso5055487b3.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698281758; x=1698886558; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa6UdDw066Es3JPwGhf9j63zEeuN/hkmQgIhzP8/jLY=;
        b=yljWxAz2ljf4T620VEYiZZJplDzmZ+N0V7tXDe0UvqEM/AQDytGDXNbgNuJqVKqA/I
         BGSXzwj5cRs9kV9dz5JaK6n2QR5s5CbBvJKnbvcTcC/+wl+rw90/wRMcMkgSZORrNToq
         UECvfVV8aaiRRK561uYYyEGlrqOr/TipG8INwYyNgdkcQET7Co2hbL4jrEoL89dx5xBm
         K0kvGi9Ki4pgTFMZ/jkFvFKGLLvyAvps8YLRkgaQJscFTQxq/DJpXnJFYrC6trjJz3dC
         fjRCDCLOuPpkJVMRwjD3H9gPuI60cvIyts0SoGB6O5u47tEZQtY8SATxIBgKXznNTfXC
         HtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698281758; x=1698886558;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa6UdDw066Es3JPwGhf9j63zEeuN/hkmQgIhzP8/jLY=;
        b=DuHOqclgYcYx2kV3hMgG1UJCXGj/wMPB0AFEolWAG4ZDz/YTfAE/xbLCuGeodhVwCe
         B5soep9N+TLkHMeG0AE/774A9CUYGk8ydJy2Y7RAah4fA0NbdqiX9hZB5N3wtQEHaOLU
         mvJSxZJlxJqgQMwJ7ChasQ3VO/NnO8qqyy2LpQPi9zTdRREmEqSCaAgRQU7xd9JvWw8E
         85nUnMDAvHKhmBBdJ0OJXuNeNtA+aDvUJ6j1imQ8+QINZI1TFubC3BCjwfamxlt9/0Fe
         vR06ckLlRIgAd63kj1GKmd5x1eA2TOWs7/tvT9dLzUj4LQcNPelWvDFhDn+kUzBQ5EgQ
         lJ9w==
X-Gm-Message-State: AOJu0Yy35+Omiv8RxC93Dpzwm/BnVEYzy9E76tqX1KPYWo+WfFZxyqB0
	IW8JyWGp1eEYsB3f+7HWvZzO1klYDbt4VZDsbeo4ViCHxbl7hDE3jF8mE0RbXN78+7f+3978ywr
	Q2X7RnN1KSThTf5n1Fg5BATqL6WKRubACP/FKGpO3JDkiWcZ3zCk4LPbgTF2mP2g222lpAmcsgQ
	==
X-Google-Smtp-Source: AGHT+IFRwH0zijfqNoOXaasVCIsON6obg6rZS3opAN5mfmq7q1FRHHfvtyA73ZJcs9ea6Xkbv/QTb2bTYXYFbtAQ/sw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
 (user=emilyshaffer job=sendgmr) by 2002:a0d:eb55:0:b0:59b:ccba:1249 with SMTP
 id u82-20020a0deb55000000b0059bccba1249mr367605ywe.10.1698281757883; Wed, 25
 Oct 2023 17:55:57 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:55:41 -0700
In-Reply-To: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
Message-Id: <20231026005542.872301-1-nasamuffin@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v2] bugreport: reject positional arguments
From: emilyshaffer@google.com
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Sheik <sahibzone@gmail.com>
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
Per Eric's suggestion, added a citation of the first positional arg
found. I don't think it's necessary to unroll the entire argv array
here, though.

 - Emily

 builtin/bugreport.c  | 6 ++++++
 t/t0091-bugreport.sh | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..8a69a23397 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -126,6 +126,12 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (argc) {
+		if (argv[0])
+			error(_("unknown argument `%s'"), argv[0]);
+		usage(bugreport_usage[0]);
+	}
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f6998269be..5b1b3e8d07 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -69,6 +69,13 @@ test_expect_success 'incorrect arguments abort with usage' '
 	test_path_is_missing git-bugreport-*
 '
 
+test_expect_success 'incorrect positional arguments abort with usage and hint' '
+	test_must_fail git bugreport false 2>output &&
+	test_i18ngrep usage output &&
+	test_i18ngrep false output &&
+	test_path_is_missing git-bugreport-*
+'
+
 test_expect_success 'runs outside of a git dir' '
 	test_when_finished rm non-repo/git-bugreport-* &&
 	nongit git bugreport
-- 
2.42.0.758.gaed0368e0e-goog

