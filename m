Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025C3E6DC9
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171594; cv=none; b=iBF11mvjoYuy6m9kzKf1PryxiYoylPmqMRB1chJzc19vpTENBp5oKi7DThodAYWqV249RM928uvmLoPCyQdNciGo7hpcm3C7xLZ/c9PI3Ku25OWudqYiyf3mglbTgxy2xYmtqUyu4jktzP9FYzDz5ELlk56ArliZH5d2Ps0x6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171594; c=relaxed/simple;
	bh=B/XN6NZYwAPvSbhAZNVp2c05DvnR31sEfHcdzza067g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wt4cCTkwS0ktQKZmXnBTflm8cF9AUl1q6ChwuxH1WsGsl7pY+MYUfC+9JhCIOvx3ZAE0ihx+5b42Gih3p/acC3t4TnI7dT1WjM9VZrZbolR8E1Fz9rNB1jPeLOGdJ7JSsbY0GwPZETLzQS5YkJImMkY3N9AUm505YiMpqO0QPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJNq0CVO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJNq0CVO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfd122d78fso768722785a.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171592; x=1776776392; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoK87/X0egknwKSNwBPuIe/AlMBRwOepDI0BLGEJkAk=;
        b=RJNq0CVOmc9+KtMIifYg0hmI4hBFi17FG5qw6wcma+3KMNN8Bouomzo7fA5z6i6Dtu
         CrglvBvH/qD6DWIf+m0Zx/zuvrb+5ty4X4H77sjTl3cCLI3IajRIq30K7O7EqQImsBK+
         f0Hg7n7J4ftPJMJdC51LpCgQ/rl/Pw/GS6+lk7fo7q7n3fckk2HvsIJ+MBxvQNfRIBQS
         fhOvE8cKEifL6cB2st41exJ9uJtDCMF/CFYn0Iblna6hCy9JolsliKzymS1DzP3Qvp7b
         L/pVQdSpPfgr5Z1s2j5I+59kM792ivBoauZMq6hkYmzQdFVsosoOcn2qmByYrSLuEcuW
         yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171592; x=1776776392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoK87/X0egknwKSNwBPuIe/AlMBRwOepDI0BLGEJkAk=;
        b=l2kYn0qH9HMC0XWbp8sKmGvKZ4r89sFmhCdm5nUsVacB+NoZzE80CLdc8WfLVv/j2J
         IqFWgly0ER0Me8PnjEapTsmzBsK9Dyawxbl2ISUeCrQMd4WbCzHM616dT9GBrPmRPQdj
         eHIyyXMPtMgASuCB8ySXeNsBEGGPQBrBxmQGmcOoMriHKeEEWCaJ2ALeteydWEw3LRdN
         Gd2tSkY7wJTKFfJj1wo+b5jdujZuvS6M172+l6GTfs7gPXRecXYEyQTzgIf29tPZOu3S
         ia3sz1lDO/ldPX08Yb77cX2GNVUyggid3A1j3LFApW8TxqWkJMzoXGF7CkypdVpOF9uV
         qrQw==
X-Gm-Message-State: AOJu0Yx4BklRMnQOUEt7Pp8+LBH3lx3Bg/WqA/P/5Zm9eDQrppoVuE03
	AJxF46LOAUzSdUMTaryFY4x2MRcDa/rXvZ+GbNi/8t65oXodr+brNdL/3RwWIQ==
X-Gm-Gg: AeBDietIUY/knRGaQIj4WQOfHGqRS/I8lRlWZLednoUL6DZZlNOrmTm34qG6FNbLWY1
	D47H/ZQKSOMyBXK+S1vkoiwJMUUDU5ccx7q013Y1i7ycEpxBceAHZPa/6dEzbRc7Gn3zt/PqR0r
	GWcDfRCATVpt6ZVrFMzw451yMUB0VZ2y1IA5YwixnNWmOPQcRkN/3Ls6l/6vTmevFjXNaWyuaO8
	6UhsDRxIMrMY8eBu+Cl0+1xycYIXP/ZD0IJ9A0m1G9KL6o5IruPkFozDF3sQuZzWzmofvYcBsFi
	LbvON2FRuhiQGfE97v32+yhEUmdkCXG1Y5ne+ivBBRQnV40OYX7RD6nGrCQqu+FGRY+cjexOufp
	ESmcVjwqoQCVpZBqvOUByACW5jXywrTbjTdETqEf8ndXS67m5D8qgikG8nCZSLwXfbkTetfmKXJ
	XKeLcOKPvfvY8OvHEIJzSbzAAh9gtczvbHGLl7tw==
X-Received: by 2002:a05:620a:290a:b0:8cd:9b4c:1470 with SMTP id af79cd13be357-8ddd00a6fe6mr2673881285a.60.1776171591741;
        Tue, 14 Apr 2026 05:59:51 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de94216e90sm933863485a.1.2026.04.14.05.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:59:51 -0700 (PDT)
Message-Id: <4593745e90d7c897463fcb4835ecfac70a088b8e.1776171585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
	<pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 12:59:44 +0000
Subject: [PATCH v12 3/4] sequencer: teach autostash apply to take optional
 conflict marker labels
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label_ours, label_theirs, and label_base parameters to the autostash
apply machinery so callers can pass custom conflict marker labels
through to "git stash apply --label-ours/--label-theirs/--label-base".
Introduce apply_autostash_ref_with_labels() for callers that want
to pass labels.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 43 +++++++++++++++++++++++++++++++++++--------
 sequencer.h |  4 ++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 780628aab4..c2516000bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4732,7 +4732,10 @@ void create_autostash_ref_with_msg_silent(struct repository *r, const char *refn
 	create_autostash_internal(r, NULL, refname, message, true);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4743,6 +4746,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label_ours)
+			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4756,7 +4765,7 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		strvec_push(&store.args, "stash");
 		strvec_push(&store.args, "store");
 		strvec_push(&store.args, "-m");
-		strvec_push(&store.args, "autostash");
+		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
 		strvec_push(&store.args, "-q");
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
@@ -4787,7 +4796,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4806,11 +4816,14 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4826,7 +4839,9 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label_ours, label_theirs, label_base,
+				       stash_msg);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4836,12 +4851,24 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0,
+					NULL, NULL, NULL, NULL);
 }
 
 int apply_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1,
+					NULL, NULL, NULL, NULL);
+}
+
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label_ours, label_theirs, label_base,
+					stash_msg);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 5d3bc83314..b0c891d3b6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -237,6 +237,10 @@ int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

