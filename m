Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDD2EEE9F
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782583351; cv=none; b=ucHNMVBmW8QB5cYxGM3/S82AicVG3coF9/VMCTowECWZMDdsTrXdmRHnt/yMd41gWPTVVhp6JAISA8Ao7kibk21KKLVeZTNm2j/tpaXLbTLBHZifbr9RxJvQ0aRJZoWYXo1DxavICi9T90Klns+MC8B1Md0jUzOEdJzFHMDzPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782583351; c=relaxed/simple;
	bh=DChTd6ZBigdXSZeWA49b3G6aZys+ZQUVo+yiZDqzw9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IXfIFmx9ifaJ4Vw9zaYGwe06mHunhX6YdLcjDaA4GIvi+jId/MdsFAwgemFqnWjd3LiNzsjnV/IjHxSzQ+LVJ90SlvgW7lSM2hV25wO60rFCbImRCnnCETp/XDaY64kTcsdcWx7ebVMYkyg7uFyJO3IS9xfEUL0QMuewuCzwkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4VswUN+; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4VswUN+"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30ca1b4b278so3104551eec.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782583349; x=1783188149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmUvuVXsYpWApv4PZ99b62+d149N5pQmllbD+BNHzRU=;
        b=J4VswUN+gwwBshSVOh4pyPiWO/oLWUResKt8vr4Q+WQ4IA15dQCIRyg67iyA+dPJTm
         kcX9l+TQkO34zDw5/i5TP/C8duhdZbPIEtRSQrnNfQRU8URr+rrlLuqQCZo9I912uZmn
         qKJ5LBQnjRpb8VX8HX+8EEjDFvYjA+83GfAOB/dCH7nWShYqSWhBZ5hrLMZCXl3KS5pF
         PupbewM7nhopz1R0ezwdGXr9hvJIggI/kgVYnHAZUjO65UuXolSfRcaCH5GYeCQJge+0
         jgSLJeUlfWmzDhhtnZ9V+p0FvKnGvIKCKQxPGxpR1xbWVIxJEZJIZHthfFhd17lYV9oe
         RhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782583349; x=1783188149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmUvuVXsYpWApv4PZ99b62+d149N5pQmllbD+BNHzRU=;
        b=LA06AE8+6nJaMFDRmNmLBT/9P0593RoEJB19Vt94KHFwvMk4da0P3sP4yXNcqKG1Br
         q4kmPL/EtkHzlP5bmkq91UqpFEeg5QncIJEsMS6sjbehYCuc+iNVbkcCRsbTAP4JvefO
         beyLuwvHTa8v7ifXEkJuXFXrC5vbxeO00fgqTBJWDJHKwNp7kN4roPxLWxBRHQnaLVbw
         d5MttK/viSIvmKZKgDP78nhfsF8S+Hx7fQGGjOWJ7bPfU6PPtGAPemtFXsYzd2oC5eDo
         e0YJI+dTlMpw7XpCX223nUZ0xRNjaEgS5Tps8KrmONOvwt7hR0rJOOUT4T2bdPhsbJ0V
         W0Yw==
X-Gm-Message-State: AOJu0Yw+oFAa9h1scUxybRh96XrpjNIRdzv0GIQoY3exIV/8NHjRIjZ6
	l/h/3/pM5K1S8j0m+vHHH9rWiCce+uy7VE/qlN6+a0IffsFLWM32zv/z9GqXkQ==
X-Gm-Gg: AfdE7cnGoJQjGJrUJscTDnTMBbCWJ5ovRUJOpd0zufryT/9f8WAWotQlzb1dopEnO4+
	cCJiTYNeb9afBD6w8VSjFyt7YVSgUUq/q6lcNYMRmw11Eg8Q9ai2TKzAoT2g892rnJu6yHZfIrS
	mB/RcW7MsJhGcIuApOh2XZUuAq6j50hGorxZr+zDEW2YPckNFReTth5Ey5O0C4kwqwM17m1G1es
	vWmsa5d2mR7eUIvsJeMPXhSjzTCgckNt7rP1rhSStJiQzLuYcvWGIWuc/7prlegBrJVyJ0Dvgvi
	iasEixx4W3ojo9PgPxWwHgcPI9xEiHkGQ+faLbyokc7HEpLroo2yKj6DWQ4cOnZZm1cRVZIpBdA
	lck7uf5z5iLAu4fxNk7cS4rwH8M1IYqB/BKPIq/BykSX+6DzrryDIUKsXWUsqitAI/iDyrtKmjk
	pg4AVg4BA0CdiqErAy
X-Received: by 2002:a05:7300:231a:b0:30c:ab4d:3830 with SMTP id 5a478bee46e88-30cab4d3e6fmr4918410eec.39.1782583349335;
        Sat, 27 Jun 2026 11:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.213.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4c691dsm28956382eec.5.2026.06.27.11.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 11:02:28 -0700 (PDT)
Message-Id: <dbe4dbc346024eedaaa08472d4cf451b56ee90bf.1782583345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
References: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 18:02:25 +0000
Subject: [PATCH v3 2/2] push: suggest <remote> <branch> for a slash slip
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
 builtin/push.c                   | 37 +++++++++++++++++++++++++++++++-
 t/t5529-push-errors.sh           | 31 ++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

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
index 6021b71d66..1b2ad3b8df 100644
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
@@ -744,6 +768,17 @@ int cmd_push(int argc,
 
 	if (repo) {
 		if (!add_remote_or_group(repo, &remote_group)) {
+			struct remote *r;
+
+			/*
+			 * Check the advice up front to avoid the remote
+			 * lookup when the hint is off. The helper still
+			 * calls advise_if_enabled() so the hint carries the
+			 * standard "disable this message" instructions.
+			 */
+			if (advice_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF))
+				die_if_repo_looks_like_ref(repo);
+
 			/*
 			 * Not a configured remote name or group name.
 			 * Try treating it as a direct URL or path, e.g.
@@ -753,7 +788,7 @@ int cmd_push(int argc,
 			 * from the URL so the loop below can handle it
 			 * identically to a named remote.
 			 */
-			struct remote *r = pushremote_get(repo);
+			r = pushremote_get(repo);
 			if (!r)
 				die(_("bad repository '%s'"), repo);
 			string_list_append(&remote_group, r->name);
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 80b06a0cd2..2294645902 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -54,6 +54,37 @@ test_expect_success 'detect empty remote with targeted refspec' '
 	grep "fatal: bad repository ${SQ}${SQ}" stderr
 '
 
+test_expect_success 'suggest <remote> <branch> for a <remote>/<branch> slip' '
+	test_must_fail git push origin/main 2>stderr &&
+	test_grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
+	test_grep "hint: Did you mean to use: git push origin main?" stderr &&
+	test_must_fail git -c advice.pushRepoLooksLikeRef=false push origin/main 2>stderr &&
+	test_grep ! "Did you mean" stderr
+'
+
+test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
+	test_must_fail git push origin/feature/x 2>stderr &&
+	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
+'
+
+test_expect_success 'no suggestion when prefix is not a configured remote' '
+	test_must_fail git push not-a-remote/main 2>stderr &&
+	test_grep ! "Did you mean" stderr
+'
+
+test_expect_success 'no suggestion for a trailing slash with no branch' '
+	test_must_fail git push origin/ 2>stderr &&
+	test_grep ! "Did you mean" stderr
+'
+
+test_expect_success 'no suggestion when the argument is an existing path' '
+	test_when_finished "rm -rf origin" &&
+	git init --bare origin/main &&
+	git push origin/main HEAD:refs/heads/pushed 2>stderr &&
+	test_grep ! "Did you mean" stderr &&
+	git -C origin/main rev-parse --verify refs/heads/pushed
+'
+
 test_expect_success 'detect ambiguous refs early' '
 	git branch foo &&
 	git tag foo &&
-- 
gitgitgadget
