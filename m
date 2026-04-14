Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28603D5230
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163831; cv=none; b=Cwgt+k4QDc1WniQ5TrpBWQRZfvqD7SS0arV0gR+OyeUSKL2liXPUn4jitx0ko67+32tlwk2X7wyq00S4mPbnFXEPa+x9NNYCu9MAiXo3AEiwh5XvSuIRkdnFCiuyq8Uj9bAJqQZH6L6fykKoxKr0ig71ZGGWwbvzri74wL80cW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163831; c=relaxed/simple;
	bh=peanzqg3po14Yua69PGEov2w2AAfB6azaIxtlsXqF7c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eOAIDVJS1zvjFn4TOJVFD4BSDRtzdCgljWG/OZOyuo7oy1FS+mTD4xoezQ1RWPWobaRvJHcCGWYIMgW8jLnw08awVSK9qrkdDwYVIlwp8h2DCZVNwYdqiYUObp8xdpkZyDsRA7ZYp9e5hlZFQ27j//16e5M+wj9rE9Il/qYurdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJ7XX3Lo; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ7XX3Lo"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1fcce8f8so10238707c88.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163826; x=1776768626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=oJ7XX3Lop3Onp85wcxzjfZ1m4K+o0G/iijXuo8WdIlzPSzlEkJo5tmU17vFThrlWWJ
         MzwnnVCODLZttNkFvopbyGy6ks6jRR0b2t8OUIeFC9nSOAuRoRqWISFsNtGqlZ7g7MJH
         +eHmdAhAmRg5HiaLs3iizeeRZuWeTGnVOwkrYN0s7OZFjoSCI73ZOcMQXNlfNzWrNgsl
         qAsj7Yo6hBeR4vgWCY0V3znPXPmEtyFRYgoru/ExV/O4r62Lc3HspDHlh89O5L9NzWZl
         qmvjzP5SgnAzEPWB3mzugoQVEhvb+HBbgh5z4sz+h50hXxB71ApdY9W2po2cIW+OsRbA
         7ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163826; x=1776768626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ/ml1zRMn65NodJaD/o5ZolwQZNSyaDlFABD9M5TSk=;
        b=XZcfywXNPKDABt+jd25yf7JvtCL/Itc/+O2arFrFEQw5thBwnmf0M9t7P1rMx1+tnT
         0Gxk/YJmYJmDKw2cD6SJbNG/j4JkPLnX7Uf0sd0i6aaERYgL7nTTXZEsEH3C4KKGMsUC
         qlPNEH4wL9c09C/BPQu56ptg0WY2QxSasAeQ0wJz8vXvFqS/JDmj+f0WuklwiSTfbX5k
         E1VxMnyBUZEf9X0FAbjaqTyiAfQB7NxNlsJxWn3s2xpq1XTsMrjSuyjJqyzzhts8u8mq
         hY+Y1hRazGZI5ag1f0iSszdjPoNo5bcOMFmwsAaiM+V6+3bqMZEVxghjQMv9tL/OkRp1
         RQmg==
X-Gm-Message-State: AOJu0YzLvr63WIkYAydsyGs19EUeNXc20R+9SkayH6LJ90W5xwSsmixW
	YmjKrmTgw/S9CI4dioospL77xMB0zRVhU7pjfiRSWrdehLqR01pM9FKtxJNiyQ==
X-Gm-Gg: AeBDies6NK1qpPe4qxskPHHehJeru5C5qWN0eR3q9gsbwKA/mwxnW8gIcB8VEgP3n2x
	P8nZf2lIhAL6I86kW5Bfu8DUxNEbH8geHti+y1uBRSr+8yAg83hitDnynAmXcwEIzVkofjXpje/
	qoWEiuS4M8fPL5BusLaSC9/eGbCCb/wdw4/qf0QUiWCEQ5xPyrSd7H8o7j68BequdciwAaFAjy6
	HdIAY5fLuWMwXyX2aQS3rbhFigtkOYumpHy4ISaqoQ+60Z3ysKcyQARgfWz1tMShq9ey2oznJxy
	7+LpD0AGTfULEnVpHGoJkwn4uBZ+bwmHqgmXdTdXmrz+u6WyCeOZKWyknrWTFOo+xTVKbjVEH1n
	j5AbP5U2H6Pmr8wD7BNuN8ewb7k308k6Smvw5Ta4VKxowCPvRpgCj64OfcXKMNTSUBHuD6iWH1x
	PL08izF1arNxJPWmUi8ULd9Kf4qK5o
X-Received: by 2002:a05:7300:ed0d:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-2dd69377af7mr651868eec.5.1776163826154;
        Tue, 14 Apr 2026 03:50:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d944769298sm8166056eec.5.2026.04.14.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:50:25 -0700 (PDT)
Message-Id: <3242fd32613426cecc248cd19cd0e5cd176e87d2.1776163819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
References: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
	<pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 10:50:18 +0000
Subject: [PATCH v11 3/4] sequencer: teach autostash apply to take optional
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
 sequencer.c | 34 +++++++++++++++++++++++++++-------
 sequencer.h |  3 +++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1197d7d8a0..913be115f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4729,7 +4729,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, true);
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
+			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--label-base=%s", label_base);
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

