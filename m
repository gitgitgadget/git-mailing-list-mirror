Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BD13BC0E
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491430; cv=none; b=EA/PKT0mmru/IbRnoQMCzMUMX/4MsZ6A01evC4yaJHpFjy2N75d3WvbWRhLbz37naLIFzvfPMAsQu+hLC41FjQzNW4tgI8/OMETsVQPxJRgGa0HQp/DGFGQi5Yb0IuBghSL6hKXnfukqPSavO98qwIRGId3xGzX8/GA/wuB2iIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491430; c=relaxed/simple;
	bh=lYCT3aaTjOJ5XOWI3lhePIn7IJ8+djjyd+xKanTq2Jk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M5ELyV8ZJ6eSSHaVDYW3CYuJB4BqeHoEwGsRoFyOzYutpw0UyX43gph1veh1hz3NMDjzlqYE31RKvs6AwtUXkk3bNDrYHubMOAqWpZg6NH1CnA/faC7rpKKZnbN0APJjHbrTf9Lvewfpk5qBAvVDJ0l9UBI8SfJ5pRmAykJ6/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krewGnV5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krewGnV5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43626213fffso1654075e9.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491424; x=1735096224; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6b6ESWDxMEreYjSSFJhi0rHRk12UHtA9RRI4GcbXl0=;
        b=krewGnV5qTe1wP57ns2InFMei5ZD1QJAw66eyCBGWq6dN1mzETqmVhzABsn2pOM3P3
         KXh9ovDPZp1/H1/XlVthrh1ujLG4UMxjy3f4GHUo2OoeOU75rpaMy9rSdzQHfFP5tcc7
         Xx7Ou5duG3aSMpzi4DBpiIMPrzZQBzEBcfYkd1hw1qWuHhiDIMjUmf2J4rYLm/lwwkxx
         4c9gYXcDeN3QKmovD7vsPYpPs8z/NmP9qfgfFL9jMvgrF0NO0t21avQROy1xqypVAjgF
         gv7wKYuC3YHQMcGZt2V2OaTWQYoAr8TsBOnFnBnJOtp3B+crJoxQcG+tSeVKYatdEWDH
         s/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491424; x=1735096224;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6b6ESWDxMEreYjSSFJhi0rHRk12UHtA9RRI4GcbXl0=;
        b=TI/zWasSU3qYoUco8fwdv1cXebOw7AoHfZRqk9wFRUXQdjiNczfNDU+4dchc2bOidu
         1ATwUbnNYb6ZTTk17HNl3YNFbI2bM0vwEevr04g3mhuFVXiFsCheqp2yD+u+579qJMC1
         mIX4T2nAOYcyOTVQ6NbyfVa2UFBNNMyVfIWt2yoLieogFHfMsrBtW/0BT+RKM9Bkot/v
         bZt8L/TQ01HyWaP9zTUXaLygt8kNqTqiAWpI6QjPGjIKpLS6jMghyfd6dSR9eTdugmj6
         snGKLZuWKlaOzLg3YsghxplOyx37q5ifSzAD0EhWJ3pF0q7LxxG8PdcPNHjBaqpnesI0
         5/Cw==
X-Gm-Message-State: AOJu0YxOvCEZReC7/XJc3lmFcH1SXZWDNEwWcq7bjjmgnMeksto0cFoH
	kGKLXw+a5d2hO+gG3tpXC+VupY9oUMcHG7zlcvrjcJk980GaQNB0FHOIYg==
X-Gm-Gg: ASbGncuMvuJSWXjmfN126p8q2QYWwEf2XDpPwqM3SJYCFA0+72mzb0QsK1J1cZNbXZu
	O9QETSwDK11ONpamxYpfQWPEzTdrtzdBZ2anQ2QMuCrFs12cV2DBHNgWA1Szkdc6itRDmhxP7Nd
	CRwJTfBexnJ4XiiIPgtaKLQHu9kR2d8qSU1560xYJOoFINgsVm1tdBwBmyjSOoWbqCO3nkMPyEw
	4Kxiya6DDe8hZgv/mEy73i9D52+HQTggQCoklOyWYma9GRGCdK0RumJ8Q==
X-Google-Smtp-Source: AGHT+IFMCRwvl1DoQNLge+/Rp+lSAXbiBvrOgcrotG/JCEEXH+oeQPtyoslecC03vVKAXvjJBOuS9g==
X-Received: by 2002:a05:6000:1869:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-388db29e5efmr4629575f8f.29.1734491423889;
        Tue, 17 Dec 2024 19:10:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01c88sm5513835e9.17.2024.12.17.19.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:10:23 -0800 (PST)
Message-Id: <pull.1843.v3.git.git.1734491422385.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.v2.git.git.1734485729135.gitgitgadget@gmail.com>
References: <pull.1843.v2.git.git.1734485729135.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 03:10:22 +0000
Subject: [PATCH v3] git: use signed loop counters when comparing with signed
 vars
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

The compiler (at least LLVM) treats them better anyway
because of the C standard not defining signed overflow.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use signed loop counters when comparing with signed vars
    
    The compiler (at least LLVM) treats them better anyway because of the C
    standard not defining signed overflow.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1843%2FAreaZR%2Fone-more-time-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1843/AreaZR/one-more-time-v3
Pull-Request: https://github.com/git/git/pull/1843

Range-diff vs v2:

 1:  c8552548fe9 = 1:  754e4a60ff6 git: use signed loop counters when comparing with signed vars


 add-interactive.c | 2 +-
 bloom.c           | 2 +-
 git.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 49042b30261..12c23fa10ba 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -848,7 +848,7 @@ static int get_untracked_files(struct repository *r,
 			       const struct pathspec *ps)
 {
 	struct dir_struct dir = { 0 };
-	size_t i;
+	int i;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (repo_read_index(r) < 0)
diff --git a/bloom.c b/bloom.c
index c4286341059..42db509bea9 100644
--- a/bloom.c
+++ b/bloom.c
@@ -314,7 +314,7 @@ static int has_entries_with_high_bit(struct repository *r, struct tree *t)
 
 		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
 		while (tree_entry(&desc, &entry)) {
-			size_t i;
+			int i;
 			for (i = 0; i < entry.pathlen; i++) {
 				if (entry.path[i] & 0x80) {
 					t->object.flags |= HIGH_BITS;
diff --git a/git.c b/git.c
index 46b3c740c5d..86f7112f4bf 100644
--- a/git.c
+++ b/git.c
@@ -946,7 +946,7 @@ int cmd_main(int argc, const char **argv)
 	 */
 	setup_path();
 
-	for (size_t i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
 
 	while (1) {

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
