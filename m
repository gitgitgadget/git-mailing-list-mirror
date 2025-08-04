Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB024503B
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302041; cv=none; b=bt3wj5TA411XK/2bBetBKzajrI9cvRcztnTnSYMbFgg0E+9i8Pc7vk9ewHLMV6MhfPeH+Q2wbodjEpOVrQVndbqPiw8lfC9I8dZwDNhycFWGzDgrT5PIrB+esRPXxyjQLrO9JFqaZjyVYx7EZLlGc+sIGmv/OEybDQ42aZz5CDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302041; c=relaxed/simple;
	bh=5j5r4rYGwQ+oGdV5iYtZut93ADLQ54cYHJGpTKC7Tws=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SPYmx1eo7ACJnHqy6+4L3d4W1HjFdc25vM7mW2l7ILa0HRQ+5R+aFTYMWZgdgGyMz/0iaO/FSqq4opXcxVjO51KUy6s/M8udxSMzFiwXCENYSfDSlgoZg+LX309ReAgCcZs8b+dgH5f8lXNeyIdvluGIuxNGGUowcgevygZ/hf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH0OIrk9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH0OIrk9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2400b3008e8so6406855ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754302038; x=1754906838; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQ3tBr+jp1kcgd5zspx7Hc2T9E3y8omtkCc8VbQIZWc=;
        b=XH0OIrk9xFhjZsZsJ2i0tB5uiB0MGg036bt5A4aR1s4M3vhFox56YIkXQFeUc7PAsS
         7ZRmdDyjM1GQU9mK1qUEeHV7xp4mtrzLvTAZ5D33JLNaEgUUt6NXtuKEpdlbdC2PiDhO
         q91+RF8vPFNgtQ41NjUMikHbg/sDpv+mm+enf3U6KVK/O0fME7GRnWYLOZlDNjXTp6kO
         aoBpHK5FDkCfpyRpYJrr34/+pC04dCVisIWRuvW6xf8WHygcsLKb8nlfr4LiOtYXuDLc
         xc9r3g/lWb+i9tfnxuUMXMUBiNuRxANQUPts+t2FbD4TOnXMX4KcjTXNKdSMq7iGbLdC
         o95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302038; x=1754906838;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ3tBr+jp1kcgd5zspx7Hc2T9E3y8omtkCc8VbQIZWc=;
        b=YlRguWIiL/82pU0be6+FKJ0LhgHWk7GsNx6aI+vIeTi8K5FOY64sgWHO0W09iQyud/
         DMNUwRzN0T33IXMrzF4hNgVWGT52PytlHVX84e28/fAG1pXqELH8z9zFo8tEiZit0BM9
         ZGfNa/p9QnE52uXwt8dLX7VJOlwnQ0NrtFgYgli3XrqFb8Qw2zEoQRVxxRzY8HTCET6g
         w8vf25LbC+pgMRKI3Aamig+TSW0lcv4mQm8f5JQFbg739SFfXTbbpBjX/aBb7Yppf3W0
         P7XvyZlArFDl6RL/TDy/5Kw2Pm48RENk+c0pbEqAE9G0bsiQ7tI2Jef5cNM9nylZNl5h
         AAaw==
X-Gm-Message-State: AOJu0YyTvhJEafdJ3fuSekFEMPgpXn/qyTXoh8yhxfTkxrisKQWGVrpa
	mbnAb4ZOYQpeNuIWo432Ugx/x+qYjZPlES+o/h1ENKOSWkB8U61ZPOHG5CzEMg==
X-Gm-Gg: ASbGncvPDbb6upUdCgS+IBKDp10XF35trHdATvKU+9TkYWPHfCVEgxZyWKfav8xJARt
	8zJQLdD+Yxut1IOHZbh4dEVRjJhv9UccrJsbblA46GRAGecVq26bJOb57Ern5c4a6sqE8+llLOC
	kRdqy51a4nhcrOmeITfcDKEXfvtbvOTwD1yS3OVids8K3ehbbLRkHFVidN9EDv3DA/3VlxoUMxz
	B5ataNrA9zanHCAoq686JsDbw9vjtxBpQ7bw1lLrEHTjB2Os5BXPkPPjfJOwe1N8A3O91U7RvHw
	x3aBHJBeKAtKo75QAuT5sLJC+5emilOeslODg5ZU3hfTGl/NnGjovyHbqgwHHcr9uQrOPPyG+AL
	8NmRGu6nRM2wRb06uxyeIscIV6rT3xQ==
X-Google-Smtp-Source: AGHT+IHo319yO8mCQLb+/bVLJ17WiibhljTr+cukf+EcFpEB5GH8EkMvN/KQjiO8MFIVpX8EHg5cRg==
X-Received: by 2002:a17:902:e543:b0:240:9ab5:4cae with SMTP id d9443c01a7336-24246f2cbc1mr52113285ad.1.1754302038286;
        Mon, 04 Aug 2025 03:07:18 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f101e1sm104947065ad.58.2025.08.04.03.07.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:07:17 -0700 (PDT)
Date: Mon, 4 Aug 2025 03:07:15 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] fix -Wmaybe-uninitialized with -Og
Message-ID: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When building with -Og on gcc 15.1.1, the build produces two warnings.
Even though in practice, these codepaths can't actually be hit while the
variables are uninitialized, satisfy the compiler by initializing the
variables.

This also acts as defensive programming since these codepaths are a
little bit spaghetti. If someone in the future makes a mistake and
causes the branch with the uninitialized variable to be hit, at least we
won't experience undefined behaviour.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/remote.c         | 2 +-
 t/unit-tests/clar/clar.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..cc462677e1 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1463,7 +1463,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
-	struct remote *remote;
+	struct remote *remote = NULL;
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index d54e455367..03a3aa8e87 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -350,7 +350,7 @@ static void
 clar_run_suite(const struct clar_suite *suite, const char *filter)
 {
 	const struct clar_func *test = suite->tests;
-	size_t i, matchlen;
+	size_t i, matchlen = 0;
 	struct clar_report *report;
 	int exact = 0;
 
-- 
2.50.1

