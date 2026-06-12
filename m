Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E488345731
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262624; cv=none; b=ONRObbiEnRf5dGyny28fh5vpxCX1MfmU3E/aluGSmcf+SSiaaYRnb+Zfdqog5gXnefrugTJ68+9X0Nd+jyRAfvm6UeCFQpL6VHjivwrRR5R2ihJcor4Q3qIbCYcbsZBmKrZQkenXINf4hWL/EXLDwAHzQrLcm/Dog43Bp8j4Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262624; c=relaxed/simple;
	bh=kTemSIrrLSRRd1Kn3SUmXY6EdJ6mAQCP5C2sHlOZ5EM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ltBc1nJW3XWIHPR9ZIq9B4L690hjt2MbZV8aMCes37sNhPOLDApRHNKNaGEej23UMZAx03+UK/VTuIRGmZHViBWHd/uVC+BegQ9nf1FnOMYdlklR0mB6uXVyAXEZWn/obhqjdRDDYyImwnfWOS3lUv4mO4YZwO9QbZImlDAM8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSM8+1L7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSM8+1L7"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915d64fead9so205643485a.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781262622; x=1781867422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXzaJSyF5EKCWJ7qFspRFfeQ6j25MwSSEewcVok8F9M=;
        b=RSM8+1L7OuVAkbYwWbNA2o3sTFnQ4/RRIF6fjz5Ms0zmMJxR76kerNQUYTDnaz3hkb
         Fq1m6KDaz4FhmMkUhBocvCRNp/zRe7KtRiwmtitRC/9dP0JvXm3nXUAmrqL1xIohuXIH
         yv4S0gTk1VyX2TMWw85MBeQ8bRgjl0PzwWM7Ymagg8c2TK22CvYfElBn5lgC370MgBH7
         y3kScyQ8W9JCUcd4XlH4ZiOSQaY9xS24fk1IZnxRJgB+2F+j0TV7emHxUDX4qsDmqH+X
         RMwugokVkCuSJ6sWS3tCNdwsH735Eb13Hf7j5Gs3hRgayAdszxjObKAFRUbSGqEHlIED
         h+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262622; x=1781867422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXzaJSyF5EKCWJ7qFspRFfeQ6j25MwSSEewcVok8F9M=;
        b=YSLh+wicnybrF7P3LaPK/8IxuX2orT66ZSoi+ZxWGSBbCZS5NEnvjmdzIqh44rpthU
         9ev4dW7mPYtaYVNXMLViX8EETuBOjq75DYCceag3c3jjoTxl63cCfelBUxXfqNvLpJGh
         PSIHC4t6fEuKlZDcLhWMMZUIhb3vMJw8D32UYqv0gsl0ZdB80Jl6sBpXp7LsX9DmWr1x
         N6yjtAJTSSSHwL3RhwGRFvofAaQR8dS/fx0B0SIgvlQ1HyNfYcgGf8ufPsLdfMQpBiIp
         1OoaQGJaXbYtwKdcx1WGJakDVHTKcpcuau5Uk17sgCNxh7FuybRmYJaQptvRZzGgKsMB
         eRVg==
X-Gm-Message-State: AOJu0Yzcru1MqshvCdw++HBvKxMx8mL9jTHK5q/RmggdjrNyOmCgN+kJ
	iiEIJCf73sbaeFuMDwIp6WVmGcNRdFNAqPyOEiQ3TfMUyYnacwucjwu1B/oZ1Q==
X-Gm-Gg: Acq92OGTLnq1IjefptFHa/BnsDfoygYPJi8Dy1iPJQTlXhDMZubtkrF9c+oIVlCDlP9
	LnpuFN7JIZfE9TnJowZz0CZXUhDzrCg4J6QB49mi3hOFHxusWIFJQOkOJvvkBUZ+O7fopyfF7VG
	ziYBqx4XaHB1F3kgbmE063+593pzN06N8pxueZQaieuizaBmOjXqI0b5mXeJJYIpS+ugW0qlUwc
	P0hG/IrISbOKfDl6SEE1KNcmtWMvgN+Hz8Fj5xOQHS9ysFYdHKtdXJYyu5jE7GcLnNfnqsDl1sX
	s8CfPggcIRIt+XTptqMTn9MulIf9VksZlu8h5tKDpOlnPJppkdDD70uxNg1VHG2mYN/ZQEQrANG
	kOTpXUtBaOhpPFi16SlRDKcr2NNC9mom0tPxcAmQwScYwBHo0q7b/lujDQ/uGh3apx2VLR914Vd
	D/g4SKhJSRIKc3/MpxbmX4bEnHchVJgPZThhAk
X-Received: by 2002:a05:620a:4102:b0:915:9f30:23cb with SMTP id af79cd13be357-9161bade3femr212168185a.0.1781262622201;
        Fri, 12 Jun 2026 04:10:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.45.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a06367dsm175634685a.43.2026.06.12.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:10:21 -0700 (PDT)
Message-Id: <ea1412b1107f485cf52c953e387a513d95d82b53.1781262619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jun 2026 11:10:19 +0000
Subject: [PATCH 2/2] push: suggest <remote> <branch> for a slash slip
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

"git push origin/main" is treated as a repository and dies with
"'origin/main' does not appear to be a git repository", with no hint
that a space was meant instead of a slash.

When the argument is not an existing path or configured remote but its
part before the first slash names one, suggest the intended
"git push <remote> <branch>" form. The suggestion is shown as advice so
it can be silenced with advice.pushRepoLooksLikeRef.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 26 +++++++++++++++++++++++++-
 t/t5529-push-errors.sh           | 31 +++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

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
index 6021b71d66..c21febadbe 100644
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
@@ -744,6 +745,29 @@ int cmd_push(int argc,
 
 	if (repo) {
 		if (!add_remote_or_group(repo, &remote_group)) {
+			const char *slash = strchr(repo, '/');
+			struct remote *r;
+
+			/*
+			 * A "<remote>/<branch>" argument that does not name
+			 * a path is likely a slip for the separate
+			 * "<remote> <branch>" form, so suggest that instead.
+			 */
+			if (slash && slash[1] && !file_exists(repo)) {
+				struct strbuf name = STRBUF_INIT;
+
+				strbuf_add(&name, repo, slash - repo);
+				if (remote_is_configured(remote_get(name.buf), 0)) {
+					int code = die_message(_("'%s' is not a valid push target"), repo);
+					advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
+							  _("Did you mean to use: git push %s %s?"),
+							  name.buf, slash + 1);
+					strbuf_release(&name);
+					exit(code);
+				}
+				strbuf_release(&name);
+			}
+
 			/*
 			 * Not a configured remote name or group name.
 			 * Try treating it as a direct URL or path, e.g.
@@ -753,7 +777,7 @@ int cmd_push(int argc,
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
