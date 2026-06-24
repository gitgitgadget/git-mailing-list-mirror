Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DD373BEC
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338121; cv=none; b=dGE0VFPd9xTBMjTc9/CGZOPuUj0qhZaBpArbS6aBcjLDS9MUkRKH5a4kMS4D8IG3sdyVkuBfWzGriFK8xLtgk7nEZ6UFKE0uIN+0apLyZgxu146cfoKWD5DBpZgVqzrwzww7CVM0oXEYlD6pyePo6bjmI+w9JlTtZ4zQ+cSb4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338121; c=relaxed/simple;
	bh=SMmoWWk/OGDVeQ0f9WkNki8oAg6xXIIW5VYkmo3uaB0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lYtgIyEwVPBs7NO8jz7jPzJnsdaadhKNM4O86gJyhloIk6V4aLrWRXE1+FduJdfQDMmgNCn5V7TKwIgOf3zSDg9Yz1T5fQn6CUfn4wGnSNgVHCQ7GdkIBGRNf9AlOHt+d3z8rpbRgwB3RjiuNyY4+mIwxfqVFb1nw4qPUiiGoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpWYwZQT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpWYwZQT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5178a42caa3so2879831cf.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338120; x=1782942920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBDjgLEeckrJ8qzVeIyoFxQlMpH9ZCg6lZ5BpmWnnv0=;
        b=fpWYwZQTVa+2FGmKs89rGWArDj0SlkUQBoPYINsXzIxmYwGM55HyMzv9NgpEeumAlF
         gJBBsrat1v+OSh3HVN4J6L4EdfHRCP0rFSe0lFzHjPgfT7WpH5qhheAbAQId6sBpJ/AQ
         cicwki6NxocsM1iBDessu3pvz38DSNfdDwdqrRMDoTp5jCYxJSVkJvJwxpemCTtpJFfw
         TL84GXIPUQmZr2AnLDUIF5dS84NudLuHPgc+0mr1tDcjVSYwh52ZuRlW8xya47s514HO
         SJp4fK15G1fFJBYfbsWuNug/QE7K/DqumfgjQKZg6jxN0D0CgObwgVlJwgpRCJxtRyGr
         0Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338120; x=1782942920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBDjgLEeckrJ8qzVeIyoFxQlMpH9ZCg6lZ5BpmWnnv0=;
        b=fEzh2i0vG7zg64FXtFkjm1Mn1/Z1ACoCTloXqZTHXeojs3f5yVeMoznnR33eEq1D8M
         FrMdAsxk/IbO3zESPHcyKS5yWcr21mzZjJ6raPKCYvjNd1CFC16XdswXizIfsnHW0Lsv
         THHcfJaU0VR2d98MWGW2OB/WkUEA9i2eiqceWM+zDNkh/UxgbGv0hZYzQiLqTGSBSKtL
         pwJVx7dQATbUS4IxmsbkrPd+4LCVEjn8TJM+DRsh+Kb5zIW4QD5880m+QFmfuoXi7HF7
         q6eaLgGekMNHxBZtqerxtF4NB01hV9m+//+htRlm/BnRwPLEWq4FyIZtHWXvad09mex1
         HQRA==
X-Gm-Message-State: AOJu0Yy3o4OEfThYcjLB+NH76iKhqSZBiHRbLLYc/2ulQdpk919WtWSU
	tnlgoYBiHAqOIPMpI7DB+J7nFWeMqRBJ/zI1E1diZLMl8Fw7n2C5yBxjJlQgKQ==
X-Gm-Gg: AfdE7cmvwNs/f4fDG+xvwpjt2b9imphQiqfFOIKc+zAvaohfEYDjkMhiYccHiF7dBZX
	eskn/VRUsUd2J2LvrcUGPrpZvcistRAlKRqofclEyHeNTo3KgaxC8W93xFMguHTriXd7yRGpxLp
	q7/ZD2E3M85meHMG+Xkp66uSMjnH74YMM9MbDDJIPxpk9UGB3mNv7qpIiTjP/kmGMFMstufule3
	ohES+IvaomEYKB5dImQcqx/Apc+NZkRhvKYzSwyavJzBahSoa4wQ3Mqkk9ZcSniJmVQ5DkCZzK5
	WEWmf0H6YNNHI264A54mg+BFC9o1UzLgQwwziQxwDzyvEsYOkN1jS0u/MtPvKRqCzQbEGYQaB+N
	FdRskiQRtUTzIrs0Ovi+tlPzDUi4f8MVqANu8TvxpNlP0tdNJgu5Qlz1PVDsPz4HG5sCOZJmBFd
	QOs1xu40hKRbEbvFg=
X-Received: by 2002:a05:622a:1e90:b0:517:8ed5:417 with SMTP id d75a77b69052e-51a51b6d02bmr137656441cf.29.1782338119590;
        Wed, 24 Jun 2026 14:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae9505sm61145261cf.26.2026.06.24.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:18 -0700 (PDT)
Message-Id: <49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:14 +0000
Subject: [PATCH v2 2/2] push: suggest <remote> <branch> for a slash slip
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
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When pushing the 'main' branch to the remote 'origin', i.e.,

    $ git push origin main

it is easy to mistakenly write

    $ git push origin/main

That is parsed as the repository to push to, and since 'origin/main'
is neither a configured remote nor a path it dies with:

    fatal: 'origin/main' does not appear to be a git repository

Often 'origin/main' does not exist as a repository, so the command
fails without doing any harm, but it gives no hint that a space was
meant instead of a slash and can leave the user puzzled.

When the argument is not an existing path or configured remote but
its part before the first slash names one, suggest the intended
'<remote> <branch>' form:

    $ git push origin main

The suggestion is shown as advice so it can be silenced with
advice.pushRepoLooksLikeRef.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 31 ++++++++++++++++++++++++++++++-
 t/t5529-push-errors.sh           | 31 +++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..fa77a5110e 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -90,6 +90,11 @@ all advice messages.
 		Shown when linkgit:git-push[1] rejects a forced update of
 		a branch when its remote-tracking ref has updates that we
 		do not have locally.
+	pushRepoLooksLikeRef::
+		Shown when the repository given to linkgit:git-push[1] is not
+		a configured remote but looks like a `<remote>/<branch>` ref,
+		suggesting that the remote and branch be given as separate
+		arguments.
 	pushUnqualifiedRefname::
 		Shown when linkgit:git-push[1] gives up trying to
 		guess based on the source and destination refs what
diff --git a/advice.c b/advice.c
index 0018501b7b..63bf8b0c5f 100644
--- a/advice.c
+++ b/advice.c
@@ -69,6 +69,7 @@ static struct {
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent" },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
 	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
+	[ADVICE_PUSH_REPO_LOOKS_LIKE_REF]		= { "pushRepoLooksLikeRef" },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
diff --git a/advice.h b/advice.h
index 8def280688..66f6cd6a77 100644
--- a/advice.h
+++ b/advice.h
@@ -36,6 +36,7 @@ enum advice_type {
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
+	ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
diff --git a/builtin/push.c b/builtin/push.c
index 6021b71d66..255556b44d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -8,6 +8,7 @@
 #include "advice.h"
 #include "branch.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -662,6 +663,29 @@ static int push_multiple(struct string_list *list,
 	return result;
 }
 
+static void die_if_repo_looks_like_ref(const char *repo)
+{
+	const char *slash = strchr(repo, '/');
+	struct strbuf name = STRBUF_INIT;
+	int code;
+
+	if (!slash || !slash[1] || file_exists(repo))
+		return;
+
+	strbuf_add(&name, repo, slash - repo);
+	if (!remote_is_configured(remote_get(name.buf), 0)) {
+		strbuf_release(&name);
+		return;
+	}
+
+	code = die_message(_("'%s' is not a valid push target"), repo);
+	advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
+			  _("Did you mean to use: git push %s %s?"),
+			  name.buf, slash + 1);
+	strbuf_release(&name);
+	exit(code);
+}
+
 int cmd_push(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -744,6 +768,11 @@ int cmd_push(int argc,
 
 	if (repo) {
 		if (!add_remote_or_group(repo, &remote_group)) {
+			struct remote *r;
+
+			if (advice_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF))
+				die_if_repo_looks_like_ref(repo);
+
 			/*
 			 * Not a configured remote name or group name.
 			 * Try treating it as a direct URL or path, e.g.
@@ -753,7 +782,7 @@ int cmd_push(int argc,
 			 * from the URL so the loop below can handle it
 			 * identically to a named remote.
 			 */
-			struct remote *r = pushremote_get(repo);
+			r = pushremote_get(repo);
 			if (!r)
 				die(_("bad repository '%s'"), repo);
 			string_list_append(&remote_group, r->name);
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 80b06a0cd2..cfb294305d 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -54,6 +54,37 @@ test_expect_success 'detect empty remote with targeted refspec' '
 	grep "fatal: bad repository ${SQ}${SQ}" stderr
 '
 
+test_expect_success 'suggest <remote> <branch> for a <remote>/<branch> slip' '
+	test_must_fail git push origin/main 2>stderr &&
+	grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
+	grep "hint: Did you mean to use: git push origin main?" stderr &&
+	test_must_fail git -c advice.pushRepoLooksLikeRef=false push origin/main 2>stderr &&
+	! grep "Did you mean" stderr
+'
+
+test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
+	test_must_fail git push origin/feature/x 2>stderr &&
+	grep "hint: Did you mean to use: git push origin feature/x?" stderr
+'
+
+test_expect_success 'no suggestion when prefix is not a configured remote' '
+	test_must_fail git push not-a-remote/main 2>stderr &&
+	! grep "Did you mean" stderr
+'
+
+test_expect_success 'no suggestion for a trailing slash with no branch' '
+	test_must_fail git push origin/ 2>stderr &&
+	! grep "Did you mean" stderr
+'
+
+test_expect_success 'no suggestion when the argument is an existing path' '
+	test_when_finished "rm -rf origin" &&
+	git init --bare origin/main &&
+	git push origin/main HEAD:refs/heads/pushed 2>stderr &&
+	! grep "Did you mean" stderr &&
+	git -C origin/main rev-parse --verify refs/heads/pushed
+'
+
 test_expect_success 'detect ambiguous refs early' '
 	git branch foo &&
 	git tag foo &&
-- 
gitgitgadget
