Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401147;
	b=drZjyYMHznVk8JKl0qtiOmiNzZIM7ogK8JjprO2QF64/b75cH9qg7A5EmQSMS/PIwtSC
	 27BWfkwH20OCJ7eopbVipfRe2XwjpkPUVlr+LTtd2qfQToA/4JYlt4PFJay/cd6OIYfO3
	 2CBKN5dI/efW20U+qFPJXGArVuTTr8dEWgv1YYPE6SP3+2c7BwZi347vfMRea4TsZ4hey
	 uiHFq2YnoyRqHY4YSJKnlJv9zO10wc+bv7V0wgsSwdgiAvWQhZ0aljKM12jM3Se9Kkh95
	 HoKP6xMir8HgL7i+wQMthJ4SbcJUGvM84ZUkbrHALQA6nd77w8AJwa2mnSBs8EhugCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NnEWPh1/qdxgHc5f2fMFnwobvBIT82Dh1o1JDwQX8QE=;
	b=4DBorhU38hxzT1joDC0KSiTZEuSiam34CkQ90j/TPIR26ez9CO7L3jI7KpAxneDP1hTu
	 MvmPBnIMM7V8fRic4PW3X11ZGITJbwwPhtXnU0G4Wx2X8UCqMZLrowBQzNqkhx5DPw5oO
	 4NnBWommJA9OhkYEP8N4UcpuRNc95jxC+VoF0XAMW0DpiYlrufto2dbr7WjiXyJopurGQ
	 4j5qgNdrPKjpCtBkXwNpQ4ouMyYY79OXvhkqvZWWrQJskSW2VOYLXYBSJgCET+SThjGwD
	 03AP/0aXmQUKxVcw0IdepaFDKAvknSLIzxxaQFSNrpH8ZP3E2wlvwDt24se0aO+kImQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI6jaAw4;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16F606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC16F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XI6jaAw4
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-85c1135c286so2088930a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 04:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401145; x=1795005945; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NnEWPh1/qdxgHc5f2fMFnwobvBIT82Dh1o1JDwQX8QE=;
        b=XI6jaAw4Fw5cA+c7OEoQ5gZRt3eb6bddnx+II3EG6UnV8iyyLiNDgv0iWzEQJjtM/7
         hezeeNqkOAJrPxhHrRl5p5+HR8y6uzKR7xHKr3vZnSSWkeThNnz/O+7eHCVngE6bSWDW
         Oz9aMwvN8EsCSkqHc17lJobjyt+hwL4BZe9HJJXCIoAoC58aLB6nuI0acz5t6hkLqJx9
         cwd/41htZYk7P62RYD4Eg1+aFl2FuHFGWEyENUnDwmFC+BbaZ1TRP3VrxN5D0BOfu79p
         0oMDjX6AWw6rYI7IRCXjBrUpFuTST/w/Ca5+PMiZTl34kohrnloJKa47gBcA9AwmTN/S
         +Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401145; x=1795005945;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnEWPh1/qdxgHc5f2fMFnwobvBIT82Dh1o1JDwQX8QE=;
        b=XjO2yCRWzyxV76zx1NhOfl+w7cA4CCtaO6zvzHeLUqIt1CRvDze7Bi9kY/RdD15BV0
         5MFk2iEvM1VuJKmuPqYxk9C3ZPn2Y7B30yf0lJw9cFKW5I66NSkAEzYO1a0WYQS318Fq
         FiJ/dQHQ5bnkFZgMauL1dbNV/leUX2eOvrgBSKuYiUF+wjHaa8dqIAa9e17/a4NgVA/P
         hfuf8tK+OhHfjzIIKRycrqwP+Q+CngbfHtS1lxyz823TVWIl0hjUcm9UiG0e/40LEdYK
         Is7fw6EWoPp+U0wJbwL8fli6ww2BvZyBC/FoR5eqNzA0nY7ZndbdB3roTmBjrUrMVc7t
         d3cA==
X-Gm-Message-State: APuU4Z+LXqWzCh1/16cWlbwWLl3/n1Jyfq1oe0mTMAsE+1qVQ7j8kNbr
	F36wDjH+hsMDvxb+8HdY/k0MqonVwGRwcVf5MC8sqkhhPXu6Ish+gNKYFeQDvQ==
X-Gm-Gg: AYBFou1ZBgIB7F5nX2nTToY9DS2Lp88fglYn8ygpWWSsUhPPB34m4iEXPCkT8DajCn/
	LKz9XUQiIG/9eThr/qm9fNRinP/lUZ1U6adudt2wErdNqMo5J/KdPC0sXB0NHFrZ7UWjRVbuo0S
	JsxyxWraxXREa3nyT166k2uTn3o/xzSVeth+o3EeLM3epoyHQKo4aKtB+ZXW7G4DllC8kXXwLvv
	kTwJNBBhrmp2zx7wtn+9DkE5QMhY7RADCmyV/t+P1m8q7HgNu5k7WI+PjBK+Y+a5d18sO6xiypV
	LdI487WDUuHP4wsdkGbWjtCxRz8K+TfFVj4nFxrOybAO1iaWy10Zpc7bn6ALsTHV+rwN7APdnZp
	BS1ikz+w9usCfwKcOlf71h5xrEG3dFqlS0def7d7nwfWM96LGMkmbALkaZI8N5CDslHQcQHsRAd
	f8S9u9G5tP/JLvCfIJ07rTJQGmnhU3Uk/wuvuOpYW7W/wZ+jDTkIYCf//+XU1SQgbC0Q1nElSxi
	NO7wWPwgnEtyCAI0AnhpTTrJCfZZ1BxY6MR4ev/Knkckyjzd9GscrO/zfCBuDJ6DEVGLiDsjh0Q
	qTlCSG1jKuvVGPHoBnSDyMaS5FoUw04=
X-Received: by 2002:a05:6830:7189:b0:85d:6045:52cf with SMTP id 46e09a7af769-860f28a81afmr1931551a34.12.1794401145525;
        Wed, 11 Nov 2026 04:45:45 -0800 (PST)
Received: from [127.0.0.1] ([20.83.54.193])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm3253962a34.12.2026.11.11.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:45:44 -0800 (PST)
Message-Id: <pull.2305.v5.git.1794401142594.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 12:45:42 +0000
Subject: [PATCH v5] archive-tar: add comments explaining configuration
 precedence
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Document the initialization order in init_tar_archiver() to clarify
that built-in default filters are registered before repo_config() is
called, ensuring user configuration correctly overrides defaults.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from
    archival modules
    
    Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files
    to use explicit struct repository *repo pointers instead of global
    repository variables.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2305%2Fpoojarysrujith%2Farchive-libification-refactor-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2305/poojarysrujith/archive-libification-refactor-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2305

Range-diff vs v4:

 1:  29130b6eb2 ! 1:  47172b861b archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     +    archive-tar: add comments explaining configuration precedence
      
     -    Refactor archive-tar.c and builtin/archive.c to clean up archiver
     -    initialization order and header dependencies.
     +    Document the initialization order in init_tar_archiver() to clarify
     +    that built-in default filters are registered before repo_config() is
     +    called, ensuring user configuration correctly overrides defaults.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


 archive-tar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..1b376d048a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -531,11 +531,15 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);
 
+	/* Set built-in defaults first so user config can override them */
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
+
+	/* Load repository config so user settings override the defaults above */
 	repo_config(the_repository, git_tar_config, NULL);
+
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
