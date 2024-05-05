Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2C5CDD0
	for <git@vger.kernel.org>; Sun,  5 May 2024 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934958; cv=none; b=LRToq2kZ3vps99apQgp0T7H6lEgpTb1tnXqT9Troz9Z2qr/MGVlKtrtqnCJf5Glf842Iw22PbEmud1w26beQLIIPXspQzLc1JBvRg0DBCd7r/JOyxenKewPvTjM9t6MkJaF/QH27mOeLnh3g64lRSul4uR0mUyGyoEtOZJ70AzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934958; c=relaxed/simple;
	bh=3fGxmYysPqcjv7xKBtDFgJfOXVE0AMuDpRMlpbMXXpg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NUgpullM5HpVVNXqRyMTYsggBCLEwa+rw/ivjpFqG6vv+0XamUZFWIVq1HnPJe1695c+yqYSTOQCxbi20Hgh+qxBdVEC8ARDkNT9i3lEB+MDoY+QSIfxShv1wnvkwiObXuzPCMR+4p1sdeRLU8C21qzDPbOnRlLMYMfMN2XO0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL8ghEBY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL8ghEBY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so8146895e9.3
        for <git@vger.kernel.org>; Sun, 05 May 2024 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714934955; x=1715539755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBm6oxPeCoNnW1L+QveNHU22NEffJtQvwuNSrI9Hc6w=;
        b=iL8ghEBY9Ck5T0lYzIA246bgamn5Q8oD1ICSgC6ZuaW/LyBVCXaEdhs1/fAiiE8DRg
         MTMI9fq02l7wkIecmDbAhJxk27quCaRDOrvOH7R0pfDEPihR4p/M5dclMkJLnHqOPgWP
         qRrhCOJDL8kIc50THVJ0ttdcr9tcBgLJAtlXtF+EAnw+m42fo/Fu8qkf1ZfxAcaKOz3Q
         aJXPadnZgkWAWN9l1uaTmUPhBFEpzHQt9O6eAMRLaHB0gqz95Z9AMveCk3yOSBKSfyYr
         32w8Nnl5v0B8z7yYaKD5qxpBTPpkXTyBpgG1vM3jjpQ3scYyckQOLRzRJPu51EB1c/9P
         5OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934955; x=1715539755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBm6oxPeCoNnW1L+QveNHU22NEffJtQvwuNSrI9Hc6w=;
        b=QOQbAq+REqqaNQjHasUrNQYmU3ZPmla0rjvT6mElmOa+BovCE9lrU0aFruE/tE6wrW
         CUw5vtY0YdtfZlVDz6bHNRa6NxfReciFo6V7gtCLILXUxv8C3i/L+BLnxNhKwiVCTCrh
         bv0JECOmrR3TC69R6hvLayY7w/gEQNWfwmAHneYWadxl2EWq3309VJqh/Vrs2b12u+ZN
         HUIARDTe0/W0yYAzVog8IOBWo5rivwTqmNj0uq7RpEhcO6SRw1EGERHYkydHlC2/P3Qi
         xj8JkJUaHV92skHnNvX20pY3QZaHtaJNurUU8ZDFp4mPPiGZ8oMLrGz+wFRiBhcAqrdq
         Hv8Q==
X-Gm-Message-State: AOJu0YzC18Uo9APPdbPemPWkvTqtykMJwNu0/gZpW9eg4ZQxPxZkfI4i
	GpM5wopecyfvoltcSAOGLopqnmOwo8w5+y3eqJ++lYtH9PstXn4ZixYo+w==
X-Google-Smtp-Source: AGHT+IE9vLrOgTnpxYGkj66X3f1bW2qM5s0pnsYOADHVfPDNlGoJZRePRjUNI+Cxc6JYfDPmgTfe0g==
X-Received: by 2002:a05:600c:a01:b0:41b:13a3:6183 with SMTP id z1-20020a05600c0a0100b0041b13a36183mr6679073wmp.24.1714934954602;
        Sun, 05 May 2024 11:49:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b0041906397ab7sm13482088wmq.3.2024.05.05.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:49:13 -0700 (PDT)
Message-Id: <75bb5cc0e8a8eac71983a5471d78f913550a21dd.1714934950.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
	<pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 May 2024 18:49:09 +0000
Subject: [PATCH v5 2/3] builtin/commit: refactor --trailer logic
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

git-commit adds user trailers to the commit message by passing its
`--trailer` arguments to a child process running `git-interpret-trailers
--in-place`. This logic is broadly useful, not just for git-commit but
for other commands constructing message bodies (e.g. git-tag).

Let's move this logic from git-commit to a new function in the trailer
API, so that it can be re-used in other commands.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 builtin/commit.c | 10 ++--------
 trailer.c        | 12 ++++++++++++
 trailer.h        |  9 +++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5a3248370db..63cd090b6f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -38,6 +38,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "pretty.h"
+#include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
@@ -1030,14 +1031,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	fclose(s->fp);
 
 	if (trailer_args.nr) {
-		struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-		strvec_pushl(&run_trailer.args, "interpret-trailers",
-			     "--in-place", "--no-divider",
-			     git_path_commit_editmsg(), NULL);
-		strvec_pushv(&run_trailer.args, trailer_args.v);
-		run_trailer.git_cmd = 1;
-		if (run_command(&run_trailer))
+		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
 			die(_("unable to pass trailers to --trailers"));
 		strvec_clear(&trailer_args);
 	}
diff --git a/trailer.c b/trailer.c
index c72ae687099..724cb78be5f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1170,3 +1170,15 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
+
+int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
+{
+	struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+	run_trailer.git_cmd = 1;
+	strvec_pushl(&run_trailer.args, "interpret-trailers",
+		     "--in-place", "--no-divider",
+		     path, NULL);
+	strvec_pushv(&run_trailer.args, trailer_args->v);
+	return run_command(&run_trailer);
+}
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..c364405267a 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,6 +4,8 @@
 #include "list.h"
 #include "strbuf.h"
 
+struct strvec;
+
 enum trailer_where {
 	WHERE_DEFAULT,
 	WHERE_END,
@@ -158,4 +160,11 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+/*
+ * Augment a file to add trailers to it by running git-interpret-trailers.
+ * This calls run_command() and its return value is the same (i.e. 0 for
+ * success, various non-zero for other errors). See run-command.h.
+ */
+int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
+
 #endif /* TRAILER_H */
-- 
gitgitgadget

