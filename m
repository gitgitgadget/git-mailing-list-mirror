Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864733985A
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573566; cv=none; b=nTKTbVPLIw0mt1WcFEi4mIuXGUewy4iVSiv7RmJr+FaOLDN9GBOEkEh2kOvEvmpxULldMImTsX/B8h7+bTS5V3pJP31QNpgkCMD5Breo+FnUxxdY/YUcb9uqznTfTcFyc5EeRfYsNx0/AZ48LqYs6rylp+u+rSDLe1UiCcYxgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573566; c=relaxed/simple;
	bh=+hvHk8lZJZMPLekC/cT2BsghDXTU5VeGTIHVLBnsh2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZhYT/4e4yyKkTrRr9m4hxKtgpyncxI+y12ENlvXa8cEoUYyFXBTTqolX7672v8bAiZsQ2ynGEeOTG4OsrEPoEtaDUE2WKT9+m6u90ASFr3fOTfpfqDJWYWkbNgh/WuSE4VKaiU99IaDoOKcx3ZukEvGZC7KNd8esyZ1bFe6GPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPbA50f5; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPbA50f5"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0b7eda342so394763eec.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773573562; x=1774178362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2PXxXk8VhvWKdh5qbCGPAjYxJFK0r5hKMGsfLg7vY0=;
        b=ZPbA50f5c6vi1sab6SxD2xnt05pl/2XRhpb1jvBE/4L1DXn0FIA1rqUmnhFNzcG60d
         g5hLe2e+PUWHGKgVBe0HGrDYZEiRhUnJ83yBsseBOD7sp4z4voZi9TzFT2TRg1dvv8qK
         VaXPakq7yz/gidizQGUqxckJrpyl7p3zdcjuolB78WxBXTMX9g4+QjusPyeJL8edi+Cl
         UyoUQtvTJztPoBeJ7EQw2gNGTorj+qPd6qZCVffeVxIiVpgkMEwgvINiJSCKcn1ByIPo
         4mHcvIGxVMIywFfJXH+Q7pDogSfkG4XK2YIKUGsFhOB0nJO/LzyN/pNsNLBVLCqBD3iY
         TTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773573562; x=1774178362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2PXxXk8VhvWKdh5qbCGPAjYxJFK0r5hKMGsfLg7vY0=;
        b=rQhg07YXk/qcKQsvKunIIVUg+E5a0+8Da0oNub4+75kSS0aG4gpJ0EOjUWj946TK5o
         YChNseD/cORUV5ysrCJBWB3MpQukHj7MFImXgOLYVwDe7ZKPEc4irfIKZO9hI+gMjQam
         kBfnNHOkSz8Rmp+TKRlxYetyq0nMOj6iIX46Pp+4TG7ShOFAwy0AXPoVIjktuLtaJwyV
         Sr7pXoC3W9y7sf87tk87p/iSabP4Qh5q93ldNqWe9+solaDGvpYLLV7cTh9LJqve8J3Y
         S941VjvN7RkswnIVnLqs9lG037xVt00p2j/eF8HP/ZjY3Nbk5Dfib9LfioUTdBuCccbn
         qNGw==
X-Gm-Message-State: AOJu0YzXZNPEG/SxYPCMd7UshuRLnOj/VmpczKIdg6+P1Ph+LE/WNc8t
	lbj1ykxrvKnBgO9NEMo/AW+bZjTT9w+Wf6/8l2xB0wggJ/kcTsojKRc6LnMFQw==
X-Gm-Gg: ATEYQzz+x+kOyZB9QalD3czNMkHHwV4ikQDvD9/yKtafpwMDiWWmE6p8+Pl32ppYkQt
	2Nz6rdtCvmUMZBnIcwze8MiZywsKPguK/L4p5FHI+iM2km8DGspIhRQs4XY8xMAA5kV3aOzFpDB
	MDhZMm5bs/LGtg/J2L6zIyC4wt3cTChraWduNuv17s6oCzo37bMkIR/qdeDSqpVetM5aZFHtqpx
	oI+acYguNYOEF6vJyg4oKa8ZclIOGxrY0dK+mw71dq0hIKXFwBfnhTPkr6fxjH8E0KY0YpQXhYV
	t8SRP5YRx9IR2Zz/sLFDFjSW6qBJt8k6b00o6ijBk309ABwRzBBhXECec+9RIZ+kQS0AJt5jfyX
	Ylw02XOwW7XH7X1TrcsMDFXFPq+JSamppkLxZq/339wnR+NvksaejjmX1FG9G6fIc0ZZehUxsUr
	Zni24Qvr7pSUqDlif0umKl39IYah4=
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id 5a478bee46e88-2bea573d146mr3794937eec.35.1773573562021;
        Sun, 15 Mar 2026 04:19:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm12538666eec.19.2026.03.15.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:19:21 -0700 (PDT)
Message-Id: <3d6829438a561d79e6b8996297e3b6505f07ac3d.1773573553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
References: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
	<pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 11:19:12 +0000
Subject: [PATCH v5 3/4] sequencer: teach autostash apply to take optional
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label1, label2, and label_ancestor parameters to the autostash
apply machinery so callers can pass custom conflict marker labels
through to "git stash apply --ours-label/--theirs-label/--base-label".
Introduce apply_autostash_ref_with_labels() for callers that want
to pass labels.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 34 +++++++++++++++++++++++++++-------
 sequencer.h |  3 +++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index eebefd731b..080a25820a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4704,7 +4704,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, 1);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4715,6 +4717,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label1)
+			strvec_pushf(&child.args, "--ours-label=%s", label1);
+		if (label2)
+			strvec_pushf(&child.args, "--theirs-label=%s", label2);
+		if (label_ancestor)
+			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4759,7 +4767,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4778,11 +4787,13 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4798,7 +4809,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label1, label2, label_ancestor);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4808,12 +4820,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
 }
 
 int apply_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
+}
+
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label1, label2, label_ancestor);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 0b09d6799b..68b94d86e3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -233,6 +233,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

