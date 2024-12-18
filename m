Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8243179
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489546; cv=none; b=cnpBe4eGFRXJhuKpJCpt31E9YrOOlPtO31PZ0a3NvwfNiippnalQYAGHfAWq/qJWZTbA/GhGSTZ+fn7jG8YsTt6CgL74wYq/9CXE1d6bv7VvyZPJxXwS2C85Afc6Bx7qbkr0yPBd6QokOW5HOj/azA5OvJP/tOK5FBDaB1LvWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489546; c=relaxed/simple;
	bh=FxnjK7/Z8WA7SYXwD5PEl6NuxC7iUtcXe3/XFiWU3V8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PYNyph9b8kNPqxLNzn1E+zoGk94fIt2P5SFmVfngopvpLQ0uT7RbAhcjWlBIXgJfdOThQEK3qxGHvKoi+AHAvn8mX1QB/UdADZpBaJdF+a4ZbUwakEDLH38r9cpoyYuT1wgdejS9C5MStlokDFTEWYifl0Zg4HSD7w0PxmCKi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k28hFmV5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k28hFmV5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso64652945e9.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 18:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734489542; x=1735094342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+RkArDq8GTEJuO+MfPeTFK1Q2QcVOYz31niP5hkWyA=;
        b=k28hFmV5dBLXgoqXwWIKVb2uFOVgmJwAidX+N9LZcIvGuFtnArRJUGtJ0v9AoLPUvJ
         0Mok8pT+QVkIjyP0H9xfAsthAjL69iu9i2j2xwpf8NscXaU+QkrgentAgmpcp5iE54HK
         8Y7QWzn4eFt5qLEtoTYjnLllIfwJIu4n8NeOfCcj8eF4GyNVs/MjEBgJTlKgyTsaxJHi
         PBsdlSyAM8jj+0f8XdYJ7BnonOsHo3LhFjTJwar0TO2TLMJYjEVjEo4sIrgAIGwbAfUH
         psFdlF5xO8ylMknLICHwPbR5ZnKWb5v8Zy8JVRARy5tS/A1Z617TmbTYNg12itZKvwp1
         tf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734489542; x=1735094342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+RkArDq8GTEJuO+MfPeTFK1Q2QcVOYz31niP5hkWyA=;
        b=uVMkSXJ+LSYqvN8qOmhCatRX8+YE6YvTNPzf2SgqECZ6i2+WT6AGuqNKylZXF0WSDa
         xv2f2xqK1EcPQTtER75q6nA6IDKmfc+AapXfKxe+9ulryqoqor4C1vj8J17qT1EoObbK
         hZSyhQ2IcMZ2LHoyB677w/xMYDMfeXWb+YAquYrIVKKLt5KVo7mK8qHSYSuSH8HjiB1O
         i+sjVdt8DMkbmu4XHTsDADHaThP+vdspxA+c4tOqxNFm6xTcEGdwEIN60GhNxSMSrF8R
         xq5hbfY4kNGbqPL8p3pD1+q6cdE0gfjbkO59WmBwXoP/a6MuKligS+UzI7GCjPaLO6rc
         MaDA==
X-Gm-Message-State: AOJu0Yx+YB07lo2kFjiABXbPs1hZK6AH1bXS5C1JnG5LvkkEWqZ/dryU
	n7Ek+ldBAf9pmR72ySguCPHem/ka7ldPhj9dDKtuqLJ9f5a83WHtosGBTw==
X-Gm-Gg: ASbGncuP0VwVc0z7sbysjf9COzw5BzTa/O5hpDG4Ie54XmNpiYvDL18HSNfvxuMzepX
	LS8FpnugMDaxtXyoByrzB4xZUxbY0GzIAR4qyTob7fZzSST3yAr+A1Bi06XsDZ2//pT+c6Uhz+v
	G+PL12ZYj4AXufWyPPjHUmXz5gXtLiRj0UkRjZKjz3LctIRZcTtZuDwFkJoTMhq1407pNY2CDUi
	dSdezaCu0XTHhwfFmS17b5Rx7E1GA8JDtM+hdNRNge8nvNn3ZP2EgzH2A==
X-Google-Smtp-Source: AGHT+IFdU4002KAVyS8AughEb1nt341b7PHvpKkDm+r/wFyA0NGCMJmlY56UWv0jvJvZxDwAOmPKgA==
X-Received: by 2002:a05:600c:3c83:b0:434:edcf:7474 with SMTP id 5b1f17b1804b1-43655406304mr6165615e9.33.1734489541815;
        Tue, 17 Dec 2024 18:39:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm35575325e9.0.2024.12.17.18.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:39:01 -0800 (PST)
Message-Id: <pull.1620.v4.git.git.1734489540328.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.v3.git.git.1734482536998.gitgitgadget@gmail.com>
References: <pull.1620.v3.git.git.1734482536998.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 02:38:59 +0000
Subject: [PATCH v4] git: use ^=1 to toggle between 0 and 1
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
Cc: Dragan Simic <dsimic@manjaro.org>,
    Jeff King <peff@peff.net>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
doing an exclusive or to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use ^=1 to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAreaZR%2Fbuffer-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AreaZR/buffer-v4
Pull-Request: https://github.com/git/git/pull/1620

Range-diff vs v3:

 1:  f6e75d8eff0 ! 1:  db1f0b1a323 git: use ^=1 to toggle between 0 and 1
     @@ Commit message
          doing an exclusive or to switch instead of a
          modulus makes more sense and is more efficient.
      
     -    Signed-off-by: Seija <doremylover123@gmail.com>
     +    Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## diff.c ##
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,


 diff.c                     | 2 +-
 t/helper/test-path-utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 266ddf18e73..5c2ac8d6fd1 100644
--- a/diff.c
+++ b/diff.c
@@ -1231,7 +1231,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block ^= 1;
 			else
 				flipped_block = 0;
 
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 3129aa28fd2..0810647c722 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -188,7 +188,7 @@ static int check_dotfile(const char *x, const char **argv,
 	int res = 0, expect = 1;
 	for (; *argv; argv++) {
 		if (!strcmp("--not", *argv))
-			expect = !expect;
+			expect ^= 1;
 		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
 			res = error("'%s' is %s.git%s", *argv,
 				    expect ? "not " : "", x);

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
