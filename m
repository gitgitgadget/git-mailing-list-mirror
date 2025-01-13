Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085C235C07
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760830; cv=none; b=YWcH5KhX2eJcMqbsMR/+e2dEF4pdlI5UAK3ve/mMhj8qtsZFRrec6N7vdbdN7iLs4JHxFYFgwCjFFy0bSiZQv1I4IroKudWDM00ygFDUdtu55z5Gs08fJ/ICvcjEkiG3/GQ+N2gVa58wN/6WtiHBbseoSrSGRHLYVuoIFpmS8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760830; c=relaxed/simple;
	bh=F3+1s17x5rLi5kRJJCS6bJpdGh67ebMWLGD5WsIhaKU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FCYObsDy0NwztMLve+krSp5ZeViDu/3IAOem1END7sp2zj5Q0Dhcv21Ms7IqhXccCbwBlpKw/Ead+bHd8WwmDo3AWyXH+QDt638Ls8KnHSxsvW/FTj3z6Wgmr6xJ3rEomGT2lEl8h7FwDxmt1bHDXb/XCJ1ZoJd8LH26LGflz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJXCbXVA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJXCbXVA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43623f0c574so28484395e9.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736760826; x=1737365626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxiKSTL8vv6VzI54RqShrSMbJT/75SJ/YTTVPJb4qh4=;
        b=KJXCbXVAFMQSLpk3iApQx38t+LkxxljcLtJfBf+N54pTnePxCUfHRdV4pj/4Wx2iLP
         Zm6FVUp+kq9eQvJESvFtq2gMhgT9n2UCKPqhmttBwM5qduVtsvp6WGBt3qMpsvAUhJSH
         rRY2x1uEp3OxDNu6yQi6KkqpynydgysUfHepIiK4XKrPEWmRbBO0mNi1zlKLcXFgp+0v
         VeJmw+DOWWXIRDavgMTclzQVk2MnCzLdLyzRlcy+J7b2OHqAkBYAEmDxkTDC/ptik9vE
         e7Bb8Ib4C0lUo5ZdaZyi/PRTZ6MWoSC06g7yLbtGycLzBj/O5nYNeAU/14avMgiOC97c
         /Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760826; x=1737365626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxiKSTL8vv6VzI54RqShrSMbJT/75SJ/YTTVPJb4qh4=;
        b=L82YJAvFtTgyhJaBf5ouKc2LuygjSTt8gXn0ckzSRumejz7vv7fLb//NMAcGz7Mq1x
         vjKzQ8gE6MmG6zw0zaBu2sL+lkJPengtFW8FGC4nU0xQJR9Gu1N5kcCg9smnInDgEEIi
         F4tjXtd3ZFqW6DjlBBHiTiFF+1Zch5t3TfZKxBB0KY/PBhPyXLAGWoeYQ2sE44oug8a2
         q+Rh48gcIuI6XUdVVPt/81OL2d+oZMQTf+nfS2cqwaoq+5ZGtIcwsq5M2maslSWNba4r
         kcj6YEbuQ+pBhXm12c8r8Dl3cdWMMJRvbl8b3tD7bMQCy47Mu3xI33aSTmJtJ7GC+pHS
         c6Ng==
X-Gm-Message-State: AOJu0YxPbVcZ/8EFGI+TUUQvOX7R7jg915xKLNJJ1DbH8Fq+F8TfbgxI
	8v/VVohSDh3yeJjIb7hKjoeitYG8wspus6/dC4oZXL13/p2n/aGe4DSNvg==
X-Gm-Gg: ASbGncv2xXYWIU1uhQ6c79kSsD6GnCfTfRm7TsIkerEsjvBFFxU5RAt1JTi6QbkEJh5
	Q1+PLmBIQWnmG9bpOKZJ5LJETgWmAfMmiIIifo/6qK6wtVep8xkvcl6xvNyVd4Qo9aP2DCreEKh
	IcXhyIefP9HXbxtsaAt1WRivE7eckBV+y/3m6k4SjujzLS35tM08BvHDnPHr7kMgKbHZ7+xjYzs
	2wQIsEQOa8idIJey1g/yKhgAsXS0Cfap0WfG44DkpG/PxC3DUjsFL5PDA==
X-Google-Smtp-Source: AGHT+IGGB1A3T/2JAUClk9IRI8X0hDU3H3s6+0CRh0oB5q/jAZQulMGz4Jcg1gfZIEb93CvqMecQHA==
X-Received: by 2002:a05:6000:4011:b0:385:f47b:1501 with SMTP id ffacd0b85a97d-38a87312d58mr15927963f8f.32.1736760825633;
        Mon, 13 Jan 2025 01:33:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d111sm11963324f8f.18.2025.01.13.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:33:45 -0800 (PST)
Message-Id: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
In-Reply-To: <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
References: <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 09:33:44 +0000
Subject: [PATCH v4] help: interpret boolean string values for help.autocorrect
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Yongmin <yewon@revi.email>,
    Jeff King <peff@peff.net>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

A help.autocorrect value of 1 is currently interpreted as "wait 1
decisecond", which can be confusing to users who believe they are setting a
boolean value to turn the autocorrect feature on.

Interpret the value of help.autocorrect as either one of the accepted list
of special values ("never", "immediate", ...), a boolean or an integer. If
the value is 1, it is no longer interpreted as a decisecond value of 0.1s
but as a true boolean, the equivalent of "immediate". If the value is 2 or
more, continue treating it as a decisecond wait time.

False boolean string values ("off", "false", "no") are now equivalent to
"never", meaning that guessed values are still shown but nothing is
executed. True boolean string values are interpreted as "immediate".

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
    help: interpret boolean string values for help.autocorrect
    
    Just updating the docs with Peff's suggestion.
    
    Changes since v3:
    
     * docs update to group "immediate" in with the true bools

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1869%2Fschacon%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1869/schacon/master-v4
Pull-Request: https://github.com/git/git/pull/1869

Range-diff vs v3:

 1:  4ce7652d19e ! 1:  64482b5249b help: interpret boolean string values for help.autocorrect
     @@ Documentation/config/help.txt: help.autoCorrect::
      -	 - 0 (default): show the suggested command.
      -	 - positive number: run the suggested command after specified
      +	 - 0: show the suggested command (default).
     -+	 - 1, "true", "on", "yes": run the suggested command immediately.
     ++	 - 1, "true", "on", "yes", "immediate": run the suggested command
     ++immediately.
      +	 - positive number > 1: run the suggested command after specified
       deciseconds (0.1 sec).
     - 	 - "immediate": run the suggested command immediately.
     +-	 - "immediate": run the suggested command immediately.
     ++	 - "false", "off", "no", "never": don't run or show any suggested command.
       	 - "prompt": show the suggestion and prompt for confirmation to run
       the command.
      -	 - "never": don't run or show any suggested command.
     -+	 - "false", "off", "no", "never": don't run or show any suggested command.
       
       help.htmlPath::
       	Specify the path where the HTML documentation resides. File system paths


 Documentation/config/help.txt |  9 ++++----
 help.c                        | 42 +++++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 610701f9a37..a4c6079af81 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,13 +11,14 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0 (default): show the suggested command.
-	 - positive number: run the suggested command after specified
+	 - 0: show the suggested command (default).
+	 - 1, "true", "on", "yes", "immediate": run the suggested command
+immediately.
+	 - positive number > 1: run the suggested command after specified
 deciseconds (0.1 sec).
-	 - "immediate": run the suggested command immediately.
+	 - "false", "off", "no", "never": don't run or show any suggested command.
 	 - "prompt": show the suggestion and prompt for confirmation to run
 the command.
-	 - "never": don't run or show any suggested command.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 5483ea8fd29..7148963e468 100644
--- a/help.c
+++ b/help.c
@@ -556,6 +556,27 @@ struct help_unknown_cmd_config {
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
+static int parse_autocorrect(const char *value)
+{
+	switch (git_parse_maybe_bool_text(value)) {
+		case 1:
+			return AUTOCORRECT_IMMEDIATELY;
+		case 0:
+			return AUTOCORRECT_NEVER;
+		default: /* other random text */
+			break;
+	}
+
+	if (!strcmp(value, "prompt"))
+		return AUTOCORRECT_PROMPT;
+	if (!strcmp(value, "never"))
+		return AUTOCORRECT_NEVER;
+	if (!strcmp(value, "immediate"))
+		return AUTOCORRECT_IMMEDIATELY;
+
+	return 0;
+}
+
 static int git_unknown_cmd_config(const char *var, const char *value,
 				  const struct config_context *ctx,
 				  void *cb)
@@ -564,20 +585,17 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	const char *p;
 
 	if (!strcmp(var, "help.autocorrect")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcmp(value, "never")) {
-			cfg->autocorrect = AUTOCORRECT_NEVER;
-		} else if (!strcmp(value, "immediate")) {
-			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
-		} else if (!strcmp(value, "prompt")) {
-			cfg->autocorrect = AUTOCORRECT_PROMPT;
-		} else {
-			int v = git_config_int(var, value, ctx->kvi);
-			cfg->autocorrect = (v < 0)
-				? AUTOCORRECT_IMMEDIATELY : v;
+		int v = parse_autocorrect(value);
+
+		if (!v) {
+			v = git_config_int(var, value, ctx->kvi);
+			if (v < 0 || v == 1)
+				v = AUTOCORRECT_IMMEDIATELY;
 		}
+
+		cfg->autocorrect = v;
 	}
+
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&cfg->aliases, p, strlen(p));

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
