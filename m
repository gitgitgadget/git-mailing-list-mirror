Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2B20DD66
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933820; cv=none; b=e/xJN4KsDe8DmxnZjoszpEu4d8IhDxco5HPVD5kW6insvVmO748B8Ku11V1C6bGFV0EEKpdaTe8SZ2fs1AP/MdCi6Q1/x+K/oQsfkeRJerGLR3x7Rwewbjwfx+SHN9Sc0+7+4itWJxSpIakyBKwpl3rG78EpHR1KxnphCGYi/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933820; c=relaxed/simple;
	bh=6TFbbvkxNDRxW3ll63d+p31maV9eWikndEEKhsZL+pQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lwssKNzR+FLhe78l9P+XDxddr+VXjkuYWwaVnK7lRIW4cc7nnx/TYPr5BKUS1QR3+y+dUJW4tRPD6jHUIZMxqaYPlayh+u/2/XGkLEr9uRRqTTlu/NsvjvjDJFeuXhzHudARKSFKehvRpc/pbIclgqW0YgPbgn+a+St12AEAuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTHhDY/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTHhDY/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436281c8a38so45982445e9.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 01:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736933816; x=1737538616; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSGgEwaqspdNVm+E7WiE9oYtz5b+HVuTDE1YoZ/z6mo=;
        b=hLTHhDY/btrcdYv1UxGFJ3f0CtcUArTfIfpzB4zbLzUtEgjNGpHLhbJC5ssBC5QGr0
         yDtUKjNlelmnaQupQ+1sQkZj6a/mks5iRsKJzcrSIw9KC1LByrtGnJToCCIJVTOL/RMq
         GuY6khHL/TtfG0eNCphiX31w2Wla7aw3H1APfyMuAtS2xbV7eVh/kYNmzLTDotlCkasd
         YR9O1xFW0luLEOrlw3mO9lcLWU1/oo48cNtnzONphnybYEsvrqOdAWCkaEWsAIr8mG+7
         bNknGKcRnrStBb15A/67woPi2Se+yg6j4Cz5VVK2p1eWtqb9bHk66Aj768SOPTEDTRr/
         2C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736933816; x=1737538616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSGgEwaqspdNVm+E7WiE9oYtz5b+HVuTDE1YoZ/z6mo=;
        b=E5BECWe1ZVZ/mrLCvQnpAu7IECI5pJGpFg9udEEavW2r4NWFp1k88BF9tUHCfgGxwP
         RN1VzMK5acXBMEA6wu7TLK8h+nRVISGwoKsN6aOEjEwEcYJqV2CKmYd0Cm45rpP7z9RE
         LIPuDeN7NLRwQhTbXgq8yFftn7n40byMPN0FQvb4aHzyrJbNnMTr1aHdE7NW9KBItfVq
         Ua7V08a2wEDQZnIXkG3GnYZiks49nSyzQ2QCxfytI++gberGSJGZyoY0Cc/wVxKKeO1L
         GxpI/BOnZ6GvVOd8NJog1zK39zDmixgKodL/8DrHje/h/994X+pjTZGjxQVv7cJzONvc
         DOjA==
X-Gm-Message-State: AOJu0YyGeSvfkEjhJ/fAlioCwCkBnMcxA8WCKAYiF/5HjX8NNSa7oXqP
	zfo9t8dNN3YAoplnqaDN8e6Pp43PYqqcRDL7nrjCNUjNnCCtsMEK8+2A9A==
X-Gm-Gg: ASbGncuJxGO7MeCKhWgNUwivpJVbCOehAEPnrVngXppIOgGj77yxSVGv+Mc3tK7Ltlm
	OQqnwpc0eZMWojUThvbOe76u34Una/wxdMPeex+KftV5IG7pmUR0Gv7piJH7ZRtvEakA04Qc0WQ
	dZU7siaq15lQZztV/lHwH2UGFb2g4aHXq4dCszeQ+V3nuesXAuZ+8LMgJ+JHf9Nuvgo0L2fQSXO
	OIC5D09tmf/2hyJ8R8Gt5Fv2CkK/oaA/B0tHyjDKeUAtPst+Jj00oGpxQ==
X-Google-Smtp-Source: AGHT+IGSsu0+biv8VypdrOAoX2LEYXhqhEjhNiXgFle+5sb5Z1yLxX6A55wGizRMhR/4v8idUpD27w==
X-Received: by 2002:a5d:5988:0:b0:38a:9f7d:9339 with SMTP id ffacd0b85a97d-38a9f7d98bdmr14916193f8f.28.1736933816115;
        Wed, 15 Jan 2025 01:36:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1ce5sm17373492f8f.94.2025.01.15.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:36:55 -0800 (PST)
Message-Id: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
From: "Chris Howlett via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 09:36:55 +0000
Subject: [PATCH] help: add prompt-yes setting for autocorrect
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
Cc: Chris Howlett <chowlett09@gmail.com>,
    Chris Howlett <chowlett09@gmail.com>

From: Chris Howlett <chowlett09@gmail.com>

The help.autocorrect functionality is really useful, saving frustration
when a dev fat-fingers a command, and git has a pretty good idea what
was originally intended. The config settings are a nice selection, with
"prompt" asking the user to confirm that they want to run the assumed
command.

However, with "prompt", the choice defaults to "No" - that is, hitting
return will _not_ run the command. For me at least, if git is confident
it knows which command I wanted, it's usually right, and the golden path
would be to run the command.

Therefore this patch adds "prompt-yes" as a counterpart config setting
for help.autocorrect, which does the same as "prompt", but defaults to
"Yes" - hitting return will run the assumed command.

I have not added any tests because the test suite doesn't have any tests
(that I could find) for the "prompt" behaviour - I'm assuming this is
because it's hard/impossible to simulate the interactive terminal prompt

Signed-off-by: Chris Howlett <chowlett09@gmail.com>
---
    Add prompt-yes config setting for help.autocorrect
    
    This is my first patch request to git - please do let me know if I
    should be doing something differently!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1852%2Fasilano%2Fautocorrect-allow-prompt-default-yes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1852/asilano/autocorrect-allow-prompt-default-yes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1852

 Documentation/config/help.txt |  4 +++-
 help.c                        | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 610701f9a37..50ce57892cb 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -16,7 +16,9 @@ help.autoCorrect::
 deciseconds (0.1 sec).
 	 - "immediate": run the suggested command immediately.
 	 - "prompt": show the suggestion and prompt for confirmation to run
-the command.
+the command. The default choice at the prompt is "No"
+	 - "prompt-yes": show the suggestion and prompt for confirmation to run
+the command. The default choice at the prompt is "Yes"
 	 - "never": don't run or show any suggested command.
 
 help.htmlPath::
diff --git a/help.c b/help.c
index 5483ea8fd29..6a28011cb50 100644
--- a/help.c
+++ b/help.c
@@ -552,6 +552,7 @@ struct help_unknown_cmd_config {
 	struct cmdnames aliases;
 };
 
+#define AUTOCORRECT_PROMPT_YES (-4)
 #define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
@@ -572,6 +573,8 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
 		} else if (!strcmp(value, "prompt")) {
 			cfg->autocorrect = AUTOCORRECT_PROMPT;
+		} else if (!strcmp(value, "prompt-yes")) {
+			cfg->autocorrect = AUTOCORRECT_PROMPT_YES;
 		} else {
 			int v = git_config_int(var, value, ctx->kvi);
 			cfg->autocorrect = (v < 0)
@@ -629,6 +632,9 @@ char *help_unknown_cmd(const char *cmd)
 	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
 		cfg.autocorrect = AUTOCORRECT_NEVER;
 
+	if ((cfg.autocorrect == AUTOCORRECT_PROMPT_YES) && (!isatty(0) || !isatty(2)))
+		cfg.autocorrect = AUTOCORRECT_IMMEDIATELY;
+
 	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
@@ -716,6 +722,15 @@ char *help_unknown_cmd(const char *cmd)
 			if (!(starts_with(answer, "y") ||
 			      starts_with(answer, "Y")))
 				exit(1);
+		} else if (cfg.autocorrect == AUTOCORRECT_PROMPT_YES) {
+			char *answer;
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, _("Run '%s' instead [Y/n]? "), assumed);
+			answer = git_prompt(msg.buf, PROMPT_ECHO);
+			strbuf_release(&msg);
+			if (starts_with(answer, "n") ||
+			      starts_with(answer, "N"))
+				exit(1);
 		} else {
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
