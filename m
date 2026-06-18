Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174434D389
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810738; cv=none; b=Xt6EwPm3Pa0O+IaO5jrYsOiSqzXenk0BhKPT+MQb1kHd5nCXEQNxHm9TlW/OxsO2ZZaQE87Syg0O1ORa6C0X2wPXGTkVZZyyW/983+CGqlfGfOQSOIWStk5Zd8V1EI1r+pOz2yG6bJYrtXgd7JIGB/y43+I1t45DYaf6ZzJ+jQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810738; c=relaxed/simple;
	bh=R722YYMFCNumLlRbEZd8gEj3tzLydkg6rygOUVW/jyc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LyV/4/8V1zFLTFbkoliwTFHHmgYqojmjj8njexrnav0KCAlPLzKycSGFor5D7y2LRRy8s0xqe03GTL3S26XeksczXV6Wl+tonV8bNIZL56kkrA5PUeZtBR66cdZpVJHfjg9922IfvtcUQ4/0Z+08DE89FsCmoVJbI/fLNAjAZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXcj4hg5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXcj4hg5"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cceaacd07bso12865916d6.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810736; x=1782415536; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFF88vgzgWTjwLRD7PrCaWM6puVWHCydg6dfHxEVo2g=;
        b=CXcj4hg5drUAAuzjCDDBfkIc9BAZUjx49c5Hmx7ImJy7bybGEzHk51myDFkOPldSK6
         qRfKUKqf/Oz3h4hMwjnUnToGgFoouNj2xQJJgPAzTDYFK8MkGFdIlOgpKdkYeYedlnU/
         rOh6HdKiIf3Ak1YvVbckkd10W89ruVJisOgkXsY95eMoMcX8LHFW0A2NlzrOds3nBhQ0
         tDUbP6ddfWgGHaCErmK+8HW4WniQJCGWa7iA9TWFifktsLES87We3Tj5Q8JFaN9wTyFk
         blrMOkLFX4zcidebL7eRetmKAuEaJB88Mkf46KngGT31qji9xIcakx4YD6jlpoU+bU/R
         9n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810736; x=1782415536;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFF88vgzgWTjwLRD7PrCaWM6puVWHCydg6dfHxEVo2g=;
        b=bp6z3xv65xTbOKTyyRl5IbZXgzjqh5xUFoKpOB1fdozaw0DcLyWl1dtYJrQTb7P45v
         h3yI7/oXhwjSw+xsfjHg0Br590Bpizn1UlTy3hNEDMhk24+9J+4KaLjt9PKvcVnnzI6W
         g+ZnpptY0rXp1Al0qWErCftHiC50J+V2ny6DhDonC7wDaIOlWe9s5ocFsz1ujUINJz7f
         Daej/8xV74Wf3lqK87+bX+PNgRLusj18KWTLve2F4Pts6DKZomTqCuBQKiNs88SzmCke
         Ybqplki7xddB/VI9kEW1zsgz5ABvSxxsoxWY8hRi7wfPRc0cmf252XHYNkvOZJqw1rYQ
         /ZaQ==
X-Gm-Message-State: AOJu0Yz3gzNI6GEjXprdCKXI6lgO9LaE4rBF4HP0X4BV8mdbqggEa6+C
	tRv4Tl4pqKiRTOB4i4zv61bmBoKo3hOvKxGnp4HVcirbMAeSB94Qiu+RYaPj+Q==
X-Gm-Gg: AfdE7ckPaTXQzJMa2SVkUn1BAxq4Os2zDXHSZdCXNDtslMaUXfsMPu7/zBf0BvcKnNL
	elBqmZihm1r7qSdSQXJ1O1eebaZXr8hcTbsSUaZZwkxOKrnaksz2IGycp9WTquYGxgKAZumt3HV
	VQ/3nqRm1790aX3uUeO9OGL53gF0d2KFzQ4IChZHdgi5l+9ZHKaZnu1FY4ESDIN24Yzzu3uYIyO
	90Ilj8rRi5ueOJpofe/GEBpmmtSQsccWF8Uv7EZ0lX745dJFCmQg9p49CpS9T40n9BEpQuqZtGR
	Nl+Cuu9VftkqfoxfiHEb9ADEC0vyg825r7tJii7X041pFAB53nuxNVc/3CxWIxXw+m7A74ldwuQ
	qJLvvFxzAXqBlPD7K+Js8USCR0ZUuXZFUGZ2zRsQ0JnIBqJhNc7EAIlMn/w4qU5sYwFV2SPG6B3
	GKDNlUwZXs2xYOTC0=
X-Received: by 2002:a0c:f09c:0:b0:8db:e533:bfdb with SMTP id 6a1803df08f44-8de42e2e78fmr7137876d6.30.1781810736234;
        Thu, 18 Jun 2026 12:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e808f89sm573086d6.12.2026.06.18.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:35 -0700 (PDT)
Message-Id: <b1ecd38fe37119ed2b067fb9cf0ec936fcc23081.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:26 +0000
Subject: [PATCH v16 4/7] branch: prepare delete_branches for a bulk caller
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Teach delete_branches() two new modes for the upcoming
--delete-merged: one that asks only whether a branch is merged into
its upstream, without falling back to HEAD when there is no
upstream, and one that rehearses the deletions without removing any
ref. Existing callers keep their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c569d056a..1d3f28e4cb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,8 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -241,6 +246,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -268,7 +275,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	force = flags & DELETE_BRANCH_FORCE;
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -339,13 +346,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
-- 
gitgitgadget

