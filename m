Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEC7710A
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488121; cv=none; b=NT8mzHpuDscUVcfERIhTmeytZ4fyXZBQMYoYfA1OwQ+j4EHU/n/Jp4zhfoUM5cxngx8CtqxRuIvD7955Y+GYPp0rmfXkqXglOtlzyAaQpJTbq8Jryu0E8krfMMSNKiju+eP75oH09qGk0wNla1J9l/whJ3f8UD1z72RmcZv7UrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488121; c=relaxed/simple;
	bh=QGyQv8DIsuACYsGMZovFY8qx387/7YtC6W5LDBEuBGo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PFYlYrwwrJlF2cUHAS9iKrfbIH2rqCmib7lK0vmv4NlZonpAOLcAB/wurbpjz8AEuf8zWBoht6ThKOra8hxk2x0PFG6839jH56IyG5HCt3u8vX95HWRcHXrQQ9cZimigZVS+iSqkzdsifa6XHH6VWYAsdeJ/ePcc7AIJ4LusWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijUy8WfO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijUy8WfO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so29684075e9.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488117; x=1715092917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWVLsWeO0AB/BXWWyYpJ9MgKeVXfbbpj0PKJL4AsbRs=;
        b=ijUy8WfO1zY4FxPhj8UyAsjHRB9vMdMUc3t7/kXb0adQYujiM5SLAICAkBJ6EGi5tY
         JKyo8YnfoWIpyH5t65KL6ke/VX93ebo8eCCgFo1CosMmvEMGiPNkNLHaJI5AVDzzu+x9
         daoGcifoqOoWifnSN+FBtDKEVhhdUMGSvAy++67t8XygH6Wsza2eUumGI+wAco7/0dPG
         bxl/qeWa/TFW3ijl2/22z0ClJW4M2DVqQg4C6Mgyi34oto1KEJtzmvvBxpS2obet5hMY
         cJP7aO0rk5UfAa4ONv29cNTUqcbn8LWF3CrjeQY5crWs0h0ATmdd2RrFM1c0M0m7tT9y
         p2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488117; x=1715092917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWVLsWeO0AB/BXWWyYpJ9MgKeVXfbbpj0PKJL4AsbRs=;
        b=NBFvpxMQ0+8pcliSEf5yXfEDFQ2b7UFdqDszBgupx0ED6NVUchce8ZBndtssJR24x3
         i6Cg3f5ifJCk5/mc/W3crWbl50O7QVbaR1qskIL7kR6dnA969KhfjZbU5EdqonPBQY38
         h1xrrVY07AZ7H/rFc8IXKShnDUHKANlu9+MiReMjvTz7gOHHU8J3BLQQmXQU4XLT81ei
         zmfYPD0vcSLya8wALL71L/Q/Fnvb6Ra6Wzst7cY2U9z+jM84r7aUV7oPilr/zrr+86KA
         +J1v1rGSmYhew6zhHnEsaARiv8PLnR8+rr6iIbfCbcHI/fICAxe8LybGoFkSuicFzI5V
         c4ZA==
X-Gm-Message-State: AOJu0YyygjH3/YkKTwTPnCIcqUcgDftAJpjlaxpMbXozOS6vzo4tIBde
	h7Hw5C+fBOe0UaKejxiaFeXT2H0z/ZLGM1zzWxihGeFi6xqUQVb4S+54Ew==
X-Google-Smtp-Source: AGHT+IEkPsgCT3lyyWNeviamh2jb0N53mFPtdzeMJp5vzZSzhUy/gVSuB1LeM40yRGCiXvVmoLggRw==
X-Received: by 2002:a05:600c:4e0b:b0:41c:2313:d966 with SMTP id b11-20020a05600c4e0b00b0041c2313d966mr5077861wmq.1.1714488117551;
        Tue, 30 Apr 2024 07:41:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fm18-20020a05600c0c1200b0041b5500e438sm19634742wmb.23.2024.04.30.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:41:57 -0700 (PDT)
Message-Id: <8f53a54bbfe9a952ae5e86216681eef2a2e916eb.1714488111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 14:41:50 +0000
Subject: [PATCH v4 2/3] builtin/commit.c: refactor --trailer logic
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
 trailer.c        | 11 +++++++++++
 trailer.h        |  9 +++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

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
index c72ae687099..ae0597d919e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1170,3 +1170,14 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
+
+int amend_file_with_trailers(const char *path, const struct strvec *trailer_args) {
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

