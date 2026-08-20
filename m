Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006337BE64
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259846; cv=none; b=o8vlH8L5Q8I7cvBomIsaQUIt1RnExBXD1xIiXQDgimxGKDynjYxGQ9OBUA030g60bDZaofaezNMFDyq7KqEfgsXrS0crCRd/5EhFBUB6FTBp4JQi7izu5r/8hUagURRsQeJBHYUJ58OdsqDRjo/WZX9kC46rofhZhf/xmWIwPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259846; c=relaxed/simple;
	bh=aBLP51XP0sn8jJhMxH2j+jldAWIuobCJSnW0+0SUwLY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rRx8dmI7ZwvWL4qQ8yGCOzcLqoqIgZtMv1m0nN0txg4bdcj07yUlR+NE+7yKus5gUn5sT38eQkfJIBqJEcA8avuA3LG9o36SzNmKsNLQs5hJ/+DHBB58zABXKRsfUCOAxViqH/aWqV/EUznxnNA3mF36A08RprGhYhq2SeItJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZoI1+F4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZoI1+F4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccf2360620so2980295ad.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259844; x=1787864644; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rz/BA7S5Vxl3YZ0VSDu4KexoSxFWvnKXK379qnPW/4s=;
        b=FZoI1+F48JsmSlHPyOtSDI6mUJsXK7lvT4Vmc3pU4FhxlJt6I31IKqvd+otqVIDSEj
         FI9OzJolBrmwMAvN3q3clV/v0/YAEfh4XqrEYz3wHlh6B3QnP4u1lORJUbkJoii3DauX
         t8ZDvhTStS1WWjs56IaRJU3d+gMAYGy8J774xA40IuUeDrh4pOjXOeI2wyAtu/HZONmk
         t3ySb18JOV+SMQE7fKiDpLFgjn3IVG7acbBAOvKlxTBgfv+dB8OY0hYB8adm8T9cw6Ca
         uXAnw5lJJmcobXomkuU4NluZjkvfllY7klwWDSspmr69I9aTDvMlp4v+Lnv254kCl4YW
         QNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259844; x=1787864644;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rz/BA7S5Vxl3YZ0VSDu4KexoSxFWvnKXK379qnPW/4s=;
        b=o+LhdDiDdOPo5HWGS1OVUasiOJxj0O7e0CHzgqbBVAIfRp1LrFkTOSLO7qjLWwJaIa
         ZarpZpdEIhEj31ect89ejh68IcUPcUiw4QT/bGWXLNHu6sQ+GX4UVx9LezQKJCWLvNcU
         9UOE/1PJj3QOHB9W61Nn5cuLGnNIrwyaI6rFbs54xFRrEvCAGpwcaFTfHU0upIEGKWTv
         58x+vDHb1aQzQwT/PYkE1NGbBK3QWGm67G/XayyeSW269BqB71/n6KcWWtCwSs1uv0Sp
         PtasW7CPosg9m1mTWDtP3Pxgne4PaG4+SNdglfC0Idn6OZ3eAoLkAcnNdkRb4ecxBy8+
         CWRA==
X-Gm-Message-State: AFuF++lMwgHRgNpwJgfflO/Eb3kDU/NS0HfOUhk97/UHoWOs5cs816cg
	6f9U0+CW9jSraTpXZ6rmWQUI8jgO3xhj5r6nMYu9vWCxIk9aedzmPIN0uOw4MeUc
X-Gm-Gg: AR+sD11AlkQ7S8A+P3NR0LRn+GccniZ//drRrsGJxRz+fgRH6FQf3RyDk2yIxXIhb/z
	W2Mk8VAhtegZgH0TfAIT3J613oaa5mby2v9y/VGSWBUD7IXd1nBNle32Tz2IIuKc9Aer3t8+qEL
	XgiQLZcKmPU1QVjB81X4LKP/i+VAnFMIMaCNed/4xb21ze5gC5Z0J4KeB7drMGhwrKGVAVApRzU
	vUrbUgHSL6MfrmaqPdHsBVrb/tCJMgme7scQyeB24tKIMSmyHu10Q03+h8T18gnIrm0bwOzcf/s
	V7u93ac4mzxb208WEXnQn+rip1wAG+t2+gUoJFSzPkyIgyMCaKjujzLPm5OpTYBCjSXEWmXV2Ug
	ZLfJuqibSFjwgIR9DznJ5+gb+4xUAzSGjQmTr9CWgiBeBfUxL8xZUpod+zMCcpBNh40G183HX4F
	6B//HTj3NJLhmGzh3ZULN1KQDoOJWwqBtYNjZeCgQLGf3WcRhb1X+f4TGpg1Wq5YZw3U0yBwA=
X-Received: by 2002:a17:90b:5646:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-395c36fb278mr2349479a91.9.1787259843887;
        Thu, 20 Aug 2026 14:04:03 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf13f4bdsm20110706eec.20.2026.08.20.14.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:04:03 -0700 (PDT)
Message-Id: <dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 21:03:58 +0000
Subject: [PATCH v6 3/3] worktree add: improve message for ambiguous remote
 branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' command
that does not exactly say which remote they want to work with, and
there is no local branch named bar-topic, we try to guess which remote
by passing bar-topic then create a new branch named bar-topic which
tracks the remote branch.

If there are multiple remotes that have branch named bar-topic, we
silently gave up, leaving the variable 'branch' intact.  Then we
entered the conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered "invalid
reference" error.  This error message did not contain enough
information to resolve the issue where the remote could not be
guessed.

To improve the situation, we display a hint and a descriptive error
message and die immediately when multiple matching branches are found.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 35 +++++++++++++++++++++++++++++++++--
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..8286c283e0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branches with the same name appears in multiple remotes:"));
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static int add(int ac, const char **av, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -900,15 +919,27 @@ static int add(int ac, const char **av, const char *prefix,
 	} else if (ac == 2) {
 		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_disambiguating_remotes(path, branch,
+								      &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget
