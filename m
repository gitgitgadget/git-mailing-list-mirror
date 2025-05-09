Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45190218584
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800919; cv=none; b=tgreohuL32yNKflZvQLAM5jWdcYkrEQRu3IriLpOQ+GAhe+UL1cyk6R2yC945bGj+eGQ3WD8lGKKz56F0Y9TJkVKiHl2VjiWKqfbCCv0wTcsntG8iEUmcEBwyl5BJDDJkiBRUjA+BeoeaKHF+MEbgUnL0Ns2P50ozbNln/gSij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800919; c=relaxed/simple;
	bh=XxGfbszB1x/CutUHZ78TbyWbJaTOvC+EybOadaBgY/o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mdckiqfylDCxatv0F+0qhN0XzYkUa/aKnnXCFxH6FoKARDeGqFIZyb1N+sekRokoDPwi3ia/8lCwsfR2bSD4N55TGpSFjfkjRg3TqRaC+enejKcqbuYZbQlsmOFQFdScPN14RL4JtsvM6XE9Bvl3ylGybeWRsD36HysOvrtKVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvoCiC9Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvoCiC9Y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0782d787so14832455e9.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746800915; x=1747405715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ITyUGJerBk7rYYy94BgJQNcKVisaT9nf0wn2VzEVi4=;
        b=ZvoCiC9YQh7rptw+qPs+Qrq7cSZjbNBh963zE5ajakfmICoLt21NHOMNTE+OiiYYOv
         u0v/4OeXkWv/zjHkq6vVdrMXPI5ELIBQtVOJPwLNdx7MWJiIqCBv8yJdZmaGbS0H+K37
         8044FDZC6t9zA0otNlYdutqyIy8knmZ8vxC7p1d3bhRw67a3wGtctGfLvAQjOyLFqZ5l
         UBZz9pNfiaO1P0m3C+MqlYiWNgLaOVMP+bEn+ls7fxNu7jRqZvWfeW0H82ktzFynKBCo
         xTmgaOGL9XTreyU2tfW8qhqs3egf++Bsnk2BDfReNZhDkx0EjVLXdNvJPwWdMQHUQQyE
         rO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800915; x=1747405715;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ITyUGJerBk7rYYy94BgJQNcKVisaT9nf0wn2VzEVi4=;
        b=TkrFKd2OSZTajsc7wm2oRRADpVjFbKx46cj6rsVVdmtpPH+kdzg//v/4JWKMAm+CLY
         IhVRgb7hbS3A83TrwsTgqL5F4DdeshCZoyfRuFp2jGOg8R0Fg3jw1yiluVWhUBGkg+hu
         4nrujxnDr85P9lRrThYtKrVgBsV1ELiBqTcWviQtIk7r6Lhcxa1W6C+PWaujUPZUk4iX
         F/qPVuVL3csAt9EWa6C+AcOCafn6udwYPxqZcfvK4K4OkqDxqsWzNDLS8jVQCMfpzmg/
         SVPdPh76gI+w8qBu5L6mR6vmBrSfZFKTt1pGq1XfIhR3GAXogsJEn6y8YxNDHIjFjqar
         ZT9w==
X-Gm-Message-State: AOJu0Yxilqlj9VPe+5egeGDkxNq8Q3g2vvfAFkfwV0xHU+GTaAJntGSi
	VvJaT0gs2D5SlIboRHyWxsY4TUPiGp0sO4rypiBgoViGDYkPg0xGgef/2g==
X-Gm-Gg: ASbGncumcfhiHxzDHBce5mUuO13Jlt+RVUxgcP3B8MjRMwF9B9sYj6Rm87wAfcGGO2i
	5epvYx5YsxTZiK72OtsZAUbECWQeszGoJ39F5+VRWLA1rwSSJqb9T1rHJP4ViUpzfCmZnNQhIyY
	vTtdHVm8qpMZcwvUz7HJMCxe+Kc1G6SClyFo9b2depE1lx2QoCqqL/lJTY8jn9+QpPIKs4n1cyZ
	PV1hUJ+hJl914B/HlB3gam6ZWtM8A/sDP/Gu4xYUyocsJXP8QYhP1gY6x/S5anT+syEH7nGLkwS
	J+uCiCvBillmtlmOm3BugAir5Z+ozzUoGLMLx9UnOA==
X-Google-Smtp-Source: AGHT+IEuRs/BwHQ+rLwPqbvY3xX5QZZJSmMCa3dHFy2oCFEUsIB2YhnZmvYJblPxJPNE/2Bn7cVZFg==
X-Received: by 2002:a05:600c:37c6:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-442d6c39d19mr40459765e9.0.1746800914885;
        Fri, 09 May 2025 07:28:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde6bsm3466844f8f.13.2025.05.09.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:28:34 -0700 (PDT)
Message-Id: <pull.1954.v3.git.git.1746800913128.gitgitgadget@gmail.com>
In-Reply-To: <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
References: <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 14:28:32 +0000
Subject: [PATCH v3] parse-options: fix memory leak when calling
 `parse_options`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

call parse_options twice and occasionally meet unknown option
in the same place would cause memory leak, since the second `xstrdup`
in `parse_options_step` would make the first `xstrdup` unreachable.

One solution is allocate one more magic byte for the unknown option to
indicate that argv[?] stores a heap allocated arg. Assume for all
arg, `*((char *)arg - 1)` is valid, we could put a magic number before
the unknown option. Next time calling "xstrdup" will check the magic
number first, and frees the previous heap allocated memory.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    fix xstrdup leak in parse_short_opt
    
    Pass a user defined strdup-like function in parse_opt_ctx to avoid
    memory leak.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1954%2Fbrandb97%2Ffix-parse-option-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1954/brandb97/fix-parse-option-leak-v3
Pull-Request: https://github.com/git/git/pull/1954

Range-diff vs v2:

 1:  e7b4465b83e < -:  ----------- parse-options: fix xstrdup leak in parse_options_step parse-options:984
 -:  ----------- > 1:  475f7b5b1bd parse-options: fix memory leak when calling `parse_options`


 parse-options.c | 12 +++++++++++-
 parse-options.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef6..84f6ae90c77 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -886,6 +886,8 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
+	char *magic_ptr = NULL;
+	size_t opt_sz = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -981,7 +983,15 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 *
 					 * This is leaky, too bad.
 					 */
-					ctx->argv[0] = xstrdup(ctx->opt - 1);
+					magic_ptr = (char *)ctx->argv[0] - 1;
+					if (*magic_ptr == OPT_MAGIC)
+						free(magic_ptr);
+					opt_sz = strlen(ctx->opt - 1) + 1;
+					magic_ptr = xmalloc(opt_sz + 1);
+					*magic_ptr = OPT_MAGIC;
+					ctx->argv[0] = magic_ptr + 1;
+					memcpy((char *)ctx->argv[0],
+					       ctx->opt - 1, opt_sz);
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
 				case PARSE_OPT_NON_OPTION:
diff --git a/parse-options.h b/parse-options.h
index 91c3e3c29b3..7fdd2e1097a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -477,6 +477,8 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
 		BUG("option callback expects an argument"); \
 } while(0)
 
+#define OPT_MAGIC ((char)(0xee))
+
 /*----- incremental advanced APIs -----*/
 
 struct parse_opt_cmdmode_list;

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
