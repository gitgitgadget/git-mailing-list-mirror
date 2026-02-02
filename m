Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC726366DC5
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038575; cv=none; b=SEDpuiNm/rmc+0n2HqzbH1/POzQpnY6k3NDSEESSr3F6lC+7KXmBV6T3AipsEZCi47CcFWLTzWLLYIk1MDYzL0jfurIJdtL9BrcZNjBAEp/Kh0asWYkNMINmIlPL8xkzNE4/apgDAZlwsjy1wOujDqfHcx1Hv4zktyoZtvEex74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038575; c=relaxed/simple;
	bh=yKqhJbL5CsqjmQZF9AJootYqnJDyKTDXd2JwgBAkuhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIMcR1hrs4QJvoGdaFHSqfo13qZNfZHCba5Ht+Or3zsXZ03mlCanw/pehywac+QNYfcdz3MDlWWTHQt8rvzFcb2/l3oQQfIBxCsuBZt2wSlap1sZ/0EE6PYgBWilQe4ofoo+gz1X/6STT7vq/pbF2sgOawmgoMOAxNsUbFP9sLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYxjTMgU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYxjTMgU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f30233d8aso28235045ad.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770038573; x=1770643373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5KA6sX4YWxGdZ9yr7wNCYDt8HFJP+sep/n/2scEDa0=;
        b=CYxjTMgUEN7/1LvirwuMDzKrhq3b23eeOv9F1Nj4o0/ottMRVZJoiqG+hUC4quM8yD
         6nE4gzCAfwSiy7saC5of3NG7hIv9Wm0cDvU3hrCAINLbGlOnMu92Ta8RXuusNBcAqpAA
         H0ObelWq1mafFKgZWhaQZE/5JqK11sSntK4hMeta6kq4VI43kECbb1iWRuD6gjAGQqYR
         4W+ETu3gS5Af0Ii3Hxdn6qyh1wqSBeQQqiX5GzStha1ijldjMRNCuH1CU9XFyuEzd6nV
         VV/ghRbKVbhMzzdhroYBY25O0cygXh9w+0ojeyz45XLhrAA+MdjhYo93FiH95y8m8pXh
         JbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038573; x=1770643373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5KA6sX4YWxGdZ9yr7wNCYDt8HFJP+sep/n/2scEDa0=;
        b=KTLMRg8DMkWcWDBVnknwteHPBwe+zDRoqXDycWVwdaKI+l+oH0ZQwK7BFk09+Lh41C
         BhqDI9IDKb8+Huxei7h9hbPFn3z3Z+VvbEFSEsiW2Jz9wvAm8/SjvfgdUVXoRQvFFoet
         LdV311bF9JHaVwUZzNohf2LQ1N6GdZ58vsiDViaBEvm/3MwnwJczDldUAMqCyiHyDWmK
         2Oo2gGnh6yzJ4AJJZB+hrZ44Tm5nSNwF20qxs5ZihqzttiMejdhmR36aVggrn6QdZWrS
         B9A9Qr9vQ8iJYhIAWbSpCGVX9JhofMsm2BwKC2odF+s+RiyQtYCy9z3IO6az/1AYIJnA
         TNJw==
X-Gm-Message-State: AOJu0YzlS0l+uA+hx5NCll7k8ysxfv+MvuK31khKBG/ntvUhLPlrwyv/
	VKM7HqkHBlc33hBEOF2rJXySC77PFBJGz3nkO2fAcKRsVQgL9wsJC7T104WWHQDW
X-Gm-Gg: AZuq6aKmUCERM5WmPHoVRhGl+z8mKWXSoUBpM5GLJGkZqnWqScqFDsdhPwNJ39RQB0D
	HbYbSHeV4j6eUinL0YQNE9pNYf3s0QnJcha33NeidvbQf5TE6K/r/LB6RPsKiKEEPRQGZUCgAU9
	jo1yjnrQ2Qioe30wTnuuFmgI02IoHl8aFJOm8922qCJO9WlYYQHZLj/oTpd9vqR6F57nxjh75F/
	hDFOYSwx2nUBSoxJgrk9yzkKdwzT2iZHSEsvagOO0sho8iydBEIdWpNSe9YrnNKMczkXmyL7tu5
	pxdAhS9XqKpctcPrp/bbY5nOgT0+TU1Wy1Tn6+eyx98ECt14PxPH69bZWzKJHYy407WVDcnkScz
	OZ67e3cFwhDPsYqTq9304qLHFi1NTPFSJCPHkWDQxTy8sFF+ImulEjQLJwVBD/FYRQSNiagCSV3
	6UQ2nuCmJqXzD6K50SPr4YF6q7rjIPwOm9M1cVPNMdty0=
X-Received: by 2002:a17:902:ebc1:b0:2a7:7872:8f52 with SMTP id d9443c01a7336-2a8d7ee6a5dmr106399975ad.26.1770038572959;
        Mon, 02 Feb 2026 05:22:52 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40a8sm179222465ad.51.2026.02.02.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:22:52 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] stash: honor --no-overwrite-ignore when updating index
Date: Mon,  2 Feb 2026 13:19:22 +0000
Message-ID: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stash code unconditionally cleared opts.preserve_ignored when
updating the index, leaving a FIXME suggesting this should depend on
an overwrite_ignore flag.

Introduce overwrite_ignore plumbing for git stash push/save and use it
to control preserve_ignored during reset_tree(). Add a test to verify
that --no-overwrite-ignore preserves ignored files.

This removes the long-standing FIXME and aligns stash behavior with
checkout/reset/merge.
---
 builtin/stash.c                    | 11 ++++++++++-
 t/t3905-stash-include-untracked.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 193e3ea47a..82d10520fe 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -150,6 +150,7 @@ static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
 static int use_index;
+static int overwrite_ignore = 1;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -360,7 +361,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.update = update;
 	if (update)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+		opts.preserve_ignored = !overwrite_ignore;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
@@ -1856,6 +1857,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("include untracked files in stash")),
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
+		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
+			N_("update ignored files (default)")),
+		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
+			N_("do not update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -1959,6 +1964,10 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("include untracked files in stash")),
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
+		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
+				N_("update ignored files (default)")),
+		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
+				N_("do not update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, "message",
 			   N_("stash message")),
 		OPT_END()
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 7704709054..9c5421cd76 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -427,4 +427,17 @@ test_expect_success 'stash -u ignores sub-repository' '
 	git stash -u
 '
 
+test_expect_success 'stash push --no-overwrite-ignore preserves ignored files' '
+	echo ignored.txt >>.gitignore &&
+	echo before >ignored.txt &&
+	git add .gitignore &&
+	git commit -m "add ignore" &&
+
+	echo after >ignored.txt &&
+	git stash push --no-overwrite-ignore &&
+
+	test_path_is_file ignored.txt &&
+	grep after ignored.txt
+'
+
 test_done
-- 
2.43.0

