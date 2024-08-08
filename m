Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743214A33
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123256; cv=none; b=byLRQuOSFAAtIRU5HPP9pvUVroERYbwzZjvDebFkyJsTtk4PrIUvGZ334IMVaocXLHBOxBdL22PhYnr4VRo+6rq4zL8/Urq31CRr79KgG//RIaDppkMufSn0KjhGmhS8GL+RTLCO8B05aPuCd0Qo0fApeT+4bQmxpbHC9QoxsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123256; c=relaxed/simple;
	bh=Eb6QDCzeojSEixRwPngBGjnpg+A4uEG2JsHCtUzGnNg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=p/YIGEFaank8ckQk4NlYQ4DWcrro71dZgFMQMJuBn25iB7HulENpIpuH+L9JczUiLKlNIl5aZJULfDMoqmgp9YtKEeQbNiMMG9GipkAuGKJwsmPE1JJTm49SU4QrpI6/ht2C0Ltip7jUnevOKlg4xhKD22Coitz4wsKex57apC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuoKSzmS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuoKSzmS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e1915e18so6372145e9.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123252; x=1723728052; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3fYYip6fNI6FyHUaHz6eunHe/oSKXbdltumUiJxw9Sc=;
        b=fuoKSzmSBgeINTwoGvbz/wPuEykcddr2KPnvUsgTiugg9BF7RdfEg9VB7dFad6B4Mk
         i1hs+BalmqYJaMw1G2Psw/df2ITdvegRh6DAPv1Q1P0YJZ2At4fJo3aBsb3HapNUHLrU
         KLUDObSoKbu9a/ST9wCM53Un99RrvVG+x07S+AJNVDcsJSHpom/clSfm6deqS+WnGwoF
         /x6tiaYwczpmiRa1T1tCd2qfJo6EABoHE4ejeWuzftOqY1RCbIl99JivwaGKoqrnGHAb
         wYeyyBgMonXe/8TcO6/giBma52a1PpgSCD/JJGxeIaTooKcEQJt/tBzWOfJYnFB6VyqN
         5iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123252; x=1723728052;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fYYip6fNI6FyHUaHz6eunHe/oSKXbdltumUiJxw9Sc=;
        b=MmZTTYHZojb1Ju2loNhS/bc6qY4dCzdZjdu1AJXapWaPaflSjWYpYnrv371TZcirsj
         xtDtS0/NDaelGSpJVp+K2iEfOGhiorbOnmUKD5rQjaiom3r6a3X7h0QWZanlJnb4VL9h
         xFTCHxXoaXHZBRP1GvoOnRuek1l9V3vRGfA5uWqu8H2cCpdjWJBp3Jfv/gSxA+WxRFEa
         tTiSc8JSZpmIdfddYbf6esp5ilD84rt22HnahdXil2dEy5IReX4764dvDwu7mIRlT4Pt
         plxrxkCT3NRTHWIBT9sX3i645eQtR74N9N46Gijgi0/nwpIIm46kThACGDUZ9i+HeT3z
         3a4Q==
X-Gm-Message-State: AOJu0YyNKfykqRBtANMGZQz/5pwK//ixNu2f9rN266dOaRHTEn9V02oj
	tNU9kVnJ4MPpHrH5/S13k4Y4yTO9TR+xSX4V/7MZ0YOE6Kh6g42hon/UBw==
X-Google-Smtp-Source: AGHT+IE254ZAE+zGuVcERXC+Qg7TEIrd5mVcfQhW2cUt8ryvA5Bk5L5gQBM1hRX4A00LmLdFzBi6Eg==
X-Received: by 2002:a05:600c:358e:b0:428:f650:6a4e with SMTP id 5b1f17b1804b1-4290af3b617mr16962195e9.23.1723123252030;
        Thu, 08 Aug 2024 06:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059a8912sm77266225e9.38.2024.08.08.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:20:51 -0700 (PDT)
Message-Id: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Aug 2024 13:20:50 +0000
Subject: [PATCH] diff-tree: fix crash when used with --remerge-diff
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
Cc: Elijah Newren <newren@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

When using "git-diff-tree" to get the tree diff for merge commits with
the diff format set to `remerge`, a bug is triggered as shown below:

    $ git diff-tree -r --remerge-diff 363337e6eb
    363337e6eb812d0c0d785ed4261544f35559ff8b
    BUG: log-tree.c:1006: did a remerge diff without remerge_objdir?!?

This bug is reported by `log-tree.c:do_remerge_diff`, where a bug check
added in commit 7b90ab467a (log: clean unneeded objects during log
--remerge-diff, 2022-02-02) detects the absence of `remerge_objdir` when
attempting to clean up temporary objects generated during the remerge
process.

After some further digging, I find that the remerge-related diff options
were introduced in db757e8b8d (show, log: provide a --remerge-diff
capability, 2022-02-02), which also affect the setup of `rev_info` for
"git-diff-tree", but were not accounted for in the original
implementation (inferred from the commit message).

This commit fixes the bug by adding initialization logic for
`remerge_objdir` in `builtin/diff-tree.c`, mirroring the logic in
`builtin/log.c:cmd_log_walk_no_free`. A final cleanup for
`remerge_objdir` is also included.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    diff-tree: fix crash when used with --remerge-diff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1771%2Fblanet%2Fxx%2Ffix-diff-tree-crash-on-remerge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1771/blanet/xx/fix-diff-tree-crash-on-remerge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1771

 builtin/diff-tree.c     | 13 +++++++++++++
 t/t4069-remerge-diff.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d3c611aac0..813be486dad 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -9,6 +9,7 @@
 #include "repository.h"
 #include "revision.h"
 #include "tree.h"
+#include "tmp-objdir.h"
 
 static struct rev_info log_tree_opt;
 
@@ -166,6 +167,13 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	opt->diffopt.rotate_to_strict = 1;
 
+	if (opt->remerge_diff) {
+		opt->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!opt->remerge_objdir)
+			die(_("unable to create temporary object directory"));
+		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
+	}
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
@@ -230,5 +238,10 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		diff_free(&opt->diffopt);
 	}
 
+	if (opt->remerge_diff) {
+		tmp_objdir_destroy(opt->remerge_objdir);
+		opt->remerge_objdir = NULL;
+	}
+
 	return diff_result_code(&opt->diffopt);
 }
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe0..ca8f999caba 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -110,6 +110,41 @@ test_expect_success 'can filter out additional headers with pickaxe' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'remerge-diff also works for git-diff-tree' '
+	# With a clean merge
+	git diff-tree -r -p --remerge-diff --no-commit-id bc_resolution >actual &&
+	test_must_be_empty actual &&
+
+	# With both a resolved conflict and an unrelated change
+	cat <<-EOF >tmp &&
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
+	index a1fb731..6875544 100644
+	--- a/numbers
+	+++ b/numbers
+	@@ -1,13 +1,9 @@
+	 1
+	 2
+	-<<<<<<< b0ed5cb (change_a)
+	-three
+	-=======
+	-tres
+	->>>>>>> 6cd3f82 (change_b)
+	+drei
+	 4
+	 5
+	 6
+	 7
+	-eight
+	+acht
+	 9
+	EOF
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+	git diff-tree -r -p --remerge-diff --no-commit-id ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup non-content conflicts' '
 	git switch --orphan base &&
 

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
gitgitgadget
