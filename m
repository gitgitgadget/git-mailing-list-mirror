Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE4DF55
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713695352; cv=none; b=BTN5HKTXTqBfO7VQ647Ee4xnGKs9wpMk+tebsOOZ+7dcDFUhitTzALXLNYA99CX72pIgd/a3BGUGIid7ld/bF+/uj4XhZAW0LbVD9Yj10GrmL+hZHie3V5no45oBnV1C7YZD+VuZNYq7Q1kE2M4bem53ZVQRw/CAGZIkcn2Mou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713695352; c=relaxed/simple;
	bh=MhKIfkMZ7+uq/eLgZuuSOL+TEqUSDvMN0l7FwtvOibo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jAcyYViXcTuWsfiXsuAzNbRmt8HQPzTRBWbCAEG3Epy0gXJSRRQaGcFsKf84nWUToJq9aw+2HzB1tZ/FUZ5hO5fJsJfS8pvas01/MJ7Y3piW7HDkMmgcskqTv2hT0UHFKY95mMD1nDrssJXODNKaln/VKLDjxc1FVHPRjudUhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWIQ/OyN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWIQ/OyN"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso2451987f8f.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713695348; x=1714300148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTyAD4nrqXUTF0NKc2JwQEYv+kVRtUAID4yUsg2Utjo=;
        b=RWIQ/OyN4ovF9RolNX6MA3K1pZFTTNuU7SAIi55zxko44UVXpuy/sPrP100ctj6pcb
         LWYQD8RM95RHAth5BexDkVGKrz2b0GHM8W3ddtUiNRixx2yl4PHPDu2PfuWbddZ8bBlg
         P3etvWa9pLJ1jen0Lerh1HU9gBdscVbC6hCFfPNwk5zGHCrKQoWLMRWWUR9SaRQLUFpN
         GT6fww3AOrVZQ6yrdW8Kk7TggaQfkjU6pFbp9i30CuiTfG8nB5aWVAXcw/RVePTCZ9Bu
         lkxo+X6bDnKXfccUH0VSBN4ThXSDvy92ZpsyF3WCi/N3M6w+Z1KHkd5AlPqi+TqqTLsD
         yBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695348; x=1714300148;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTyAD4nrqXUTF0NKc2JwQEYv+kVRtUAID4yUsg2Utjo=;
        b=T3RBJyueTBvyJbBMaTu4EZePgCrdR9I1jJ+O2T9lzh2xBVY85/HttocJhNLHAW0PCc
         sGtpdducu324AvWw8O17YkhPzJd5JLef8QKtWZDShzA68Tv1nbtrQPBfTieaPIwy0Csb
         9Wpnjawua0tDyZKO0uJnvLZVOnRwsiIO2Lt6MyXQdiuFx/6D9jSNZNrdCH8y/Nd9OblE
         ApO64fuTaWYi+oGrlrBGutfizaqZFJsjF9tAjRIjMaGr9XkPJ7NdiwoVxMz1IGg6ZNOn
         UDiMyM2eBqSjy3/1inPfFjeZhuMd/nI4naGTIgqGiFl5U1tpqe0ZZyR9KHWWWu0QuqGt
         wljQ==
X-Gm-Message-State: AOJu0YynIrXqFbdtOcebRsi6v5koBSR+SN46KIHYnOjegh1aEMVQrpw9
	12aANxJW6/LcPmDtARWCKQXifb0yDBM1buJD0hTZcko1JhPWSwKMdF9gAw==
X-Google-Smtp-Source: AGHT+IH6uYidvPFItbYFZ3re8Dfy2k2uknEB/RgwEULp4xpZBUCW3WkU8fiQytE1mLuNBVto8+pJ9g==
X-Received: by 2002:a05:6000:25b:b0:34a:572b:3e15 with SMTP id m27-20020a056000025b00b0034a572b3e15mr3739701wrz.25.1713695348597;
        Sun, 21 Apr 2024 03:29:08 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d434b000000b0034a2d0b9a4fsm7854367wrr.17.2024.04.21.03.29.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:29:08 -0700 (PDT)
Message-ID: <a886c086-4b2e-4d41-ad40-b3fca20de42a@gmail.com>
Date: Sun, 21 Apr 2024 12:29:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] add: plug a leak on interactive_add
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since 5a76aff1a6 (add: convert to use
parse_pathspec, 2013-07-14).

This leak can be triggered with:
    $ git add -p anything

Fixing this leak allows us to mark as leak-free the following tests:

    + t3701-add-interactive.sh
    + t7514-commit-patch.sh

Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
promply any new leak that may be introduced and triggered by them in the
future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c              | 9 ++++++---
 t/t3701-add-interactive.sh | 1 +
 t/t7514-commit-patch.sh    | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae723bc85e..b7d3ff1e28 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -150,7 +150,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 int interactive_add(const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
-	int unused;
+	int unused, ret;
 
 	if (!git_config_get_bool("add.interactive.usebuiltin", &unused))
 		warning(_("the add.interactive.useBuiltin setting has been removed!\n"
@@ -163,9 +163,12 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 		       prefix, argv);
 
 	if (patch)
-		return !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
+		ret = !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
 	else
-		return !!run_add_i(the_repository, &pathspec);
+		ret = !!run_add_i(the_repository, &pathspec);
+
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a..04d8333373 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,6 +4,7 @@ test_description='add -i basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index b4de10a5dd..03ba0c0e73 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='hunk edit with "commit -p -m"'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (initial)' '
-- 
2.45.0.rc0.4.g08f77eb516
