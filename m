Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B072741B6
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762244; cv=none; b=F3hG1y4OkXGPvhEVj1Qh6/nvSn95hNZ1aROAzkTVs2uRfK1qvz1h7fW7ic3jwQXEUi3H07hPQ7qLBg1FMAuvD6Rqors3QmzIC/urz07c1b4hcaBNDkMEWDENnKC7LLM3uJOxL0F2QblZyY8MaoNFzO/KD4ApZsdZPT7NjRN+3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762244; c=relaxed/simple;
	bh=xC6UvIBOYPNu/uB7BSnTwk3jBCoJyFIkFBLxvJpuSGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q5og4SeA5Kc0XgJ6JDLAkyjPXVenj79Z01sLiecYAJQZJz2gRvYNc587yG7sjTURAMQV/GppKMDwk/gkXSH6iV/0cM85U9cz5bXYCyRmupIhJWpJXXthFiagh9GJbjRp3YxVgezTxudVTFieHG5FVZ6sz5Kgl9mjlsAx3KOQgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2MzsVkx; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2MzsVkx"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c0433a4b9so3634256c88.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762242; x=1776367042; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Ck2RfiObGXBgBp9HroBozJ/qNPVLcQSmjqrVWko8k=;
        b=q2MzsVkxyWIiPDgt2S4DT/nyKZxDGYJUDrY81CtlLqTT7Ecioc3Ta7HVjmVvEZKvWp
         m5LZK2R2wGRkn89UHEa9SSargd39bPbHtYqJd5RRlNZ8dR5BXOTsvAluX9vyz0jCWjrx
         Sx9KExpesd8gVWCbwBAdSMcOnpSur1w5sUvB7k9+lqnHXbcNDKs41o9IAuzSWyAJTWL8
         R+tR9nMViO/0aA+CjQGdB5hw6PSPzA6oJMVDOqtyJ8vENZ9D0ke+TfBy4wYCIDdadiwe
         Eo1ZciA6cQERttDjwX7K4TTQpFWn228nCM0n+a0eF6s0Crxb6d1V0tMJqG/EaHsE7ug9
         eO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762242; x=1776367042;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8Ck2RfiObGXBgBp9HroBozJ/qNPVLcQSmjqrVWko8k=;
        b=BXQurvKXIjj69iHkyOHKxKKn8OJrY268BhTmnW9iav5AfAKukJNB+7qqKbWxAbpkq2
         B+E2uWeuOG6CjLu+T0bg4Tke2XPM+tEBqoN8hNXc8p6md04800JJ4vf22OAIveLHNmkE
         9bukAz8SLrOYX+/synYtzvn8FH84oxogpLnVw9ycCuOHKHUG/OeWdVhkFzg6z5hiJ1lE
         r7cuF2o8hqRlK/RaDE04Jsig+kMP14zUEc7NZxvrG5hzHOgZNSabcZ8/t74J0KyHtFuW
         r/ZDgl/nHiPpsc5JfNuuxA21uZhKEYDnMw9RTmZtlw7/+XbbA+X+dUTcfY0oiQE+DHm4
         ltJw==
X-Gm-Message-State: AOJu0YwYUpVqrjIvYwjHrexyppo2RXTEKEc+yZ+aCv6+rlApuISsafSe
	TlLprq7B90mNdiPAKHoUHZ4s6ueiZbBFZQ7vV1qFyVVoW3EKTE4LQmBqD1AOBA==
X-Gm-Gg: AeBDieuJC7oh607JiO1OHzB2E8cu8Wa1ifSuP4nmbz9+NfeFAp+SczIoKx0vnp1Kv4A
	62FwaYODo/Gzn6VBy1m/ny3nKa5vBgUbzXWxRJA5OX+8XGYD//9c1NZrYwRyVSnn5eZcpXn/EC8
	OO4M2mL0QyPeanD2bLdmfMIpaMbuzKiokS1g8sBII1sydDsB0iratu2vGQstQTp8Wj51LmDBNgq
	Zwcwm9X/zZ+8W6s6ZMyNJs/Yk5LKZuMHQjfZlXEkMyRQsBIllaJmoTbsYrZm1iH1BejRDa8F3r5
	T/nET5N5RpLFZQZOSQQsIgn4L+i/8I3rUWx3N/F6C2ToxGPdB92j5TBijZKeDIiWZ68aI7kDrlR
	wTo/V/EMbkacAm6A7G+3hYEhqwc8NEAA3w7Y+/Ge6zkq08niBfylDF9ABAkoxuUPljycS+tlNR3
	cFLmEVsqeisreB1NAWezq7+iyyIiEA
X-Received: by 2002:a05:7022:6b82:b0:128:cea1:7e3b with SMTP id a92af1059eb24-12c34ef6a46mr177978c88.23.1775762241620;
        Thu, 09 Apr 2026 12:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm610388c88.3.2026.04.09.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:17:20 -0700 (PDT)
Message-Id: <78300e0e9a8beb7ffb28a38a5e203556b2df9d56.1775762235.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 19:17:14 +0000
Subject: [PATCH v8 3/4] sequencer: teach autostash apply to take optional
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
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index e500a94a59..e28d30ff7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4729,7 +4729,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, 1);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4740,6 +4742,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label_ours)
+			strvec_pushf(&child.args, "--ours-label=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--theirs-label=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--base-label=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4784,7 +4792,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4803,11 +4812,13 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4823,7 +4834,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label_ours, label_theirs, label_base);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4833,12 +4845,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
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
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label_ours, label_theirs, label_base);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 570f804457..2c4ff17c4e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -236,6 +236,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

