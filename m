Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E35375AC4
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939900; cv=none; b=PwV6hNrCH/4QdVjqSrfQMt9j50SWydCVq2UqVeCp6H3rPf+uO/MF0moS/h9QC9cO4Azm9+2d51NIOs1Sh8xCYdEMZF37GmN2fANlYJuEzZXDWCmIGOr9GZkKXujZrUfccfbINt2DDd7RD6mOn+eg1D96LioszXiyv98cVaNHVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939900; c=relaxed/simple;
	bh=oZxcyKEgebUOznRHTj26KqhhWGf5WTO8oXdFz8wKzC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L3q6jaNcFYaUjkkRlxsWtdGoqVKdqG77OgsiTSPWhwmLFcsvQ6J6dwFgO0qlI0Mj9QSK25Ip0MQxGrrRyoTWjByPpOpt858rKyijtnsA7RzDeAgWm02c1ORRVdslVCpjd3R+/o2FpIRIhSn0PBV4XGN+cFqewheUIJBwwiqDJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOlpf99U; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOlpf99U"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1760855b3a.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939887; x=1786544687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8qQ7Ma5tZlqfL2G15c1hQMz6FCWNR1N6tn/tZhDRzE=;
        b=bOlpf99Up6FyB+6lh8o1v3Z1Hhwrf0j7elOWbn3H9GSpFy9yZQYdeVAP1Up1Hh2Zvn
         vDMNUYLWsyLl8jRhqQdVtk0kuVnL8k9l7jSAiUY/LP7pjHcNpe1pMZsZpOalonOH37aJ
         XRLmv0v1i5LJlFV2jTC9NfqfHDbNt522AY+UuI3Rh8oSE6uX5mYjnEqkmUsq6SHuoyec
         rs3mNJuSk5qFZ220IQ+CJ3JaL95b4gwCWfe816vehu3l5TYMRAETlB10XoSqLme8ChXa
         Zm8sbNbrmhF1bXF+q9azW2m/RrFcg0fHucu3MhSA6NP3d6Ue+XxAvV3No4nkJij3k+FY
         XvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939887; x=1786544687;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8qQ7Ma5tZlqfL2G15c1hQMz6FCWNR1N6tn/tZhDRzE=;
        b=UUsKwUNM+4y52st03Pqj0Vwyj3DYt1l/aCD0So/syVWo+LiZxXaooqxtyGZbwFyeZb
         MLOxvZhZ1UtuxZNnnVnK4+nfIUhzovgh7RqteRBWTslsmK6riHeK6NyXyEhJ9ROMuIzV
         M116yIib3hc0eJ44H1KdsEg0afj4CdZtayHOr9KGKTccpRCwrh1rVaVAYz5+omnmr4TB
         j0L+2zrPN1TfRxzNJYlkJelwLdMC+xnBsxF2f4CJ3Q4wXa3w8QKZvrn+CCwUezYYfun2
         yH6DOeF3FuruwHpKlQQQoDlgleCiAwzI6Ci0DZtGH2UiDNBeslvWZZrYAvikvpeaQmlO
         JpyQ==
X-Gm-Message-State: AOJu0YxDJkjIgm8MHWiqb0uU3lKuxC3HmoazZQ069KwupoM0J7MP6n46
	gB+MhS+Avna6BsKb8Lbu9/ic+lloCe83cXiPLMqD7li3QJ6Pzdpnhbdzwiyb4g==
X-Gm-Gg: AR+sD10ZTVH8oNKbgTGQFwDDtuXLoQyDKu1dMgPTSSTlQO9lK4UC3B+1zASHGloYG9I
	PQ8D7P+ji7cwCVGnD32/DSruPaoZfDa8SfK2i78yb5cGLikynBaRM8g0v+hLuk/GgSET1C2qz/B
	ja4GZT0T2AX2KxaV+ahk73N2BOgWAiFG42GIa79whhDckAVKKYSEJNwd3mEe2p/g2/ZKjcgWdYK
	DQfwMiK0XciC9N1Cq7KktAlhXxaJfGvq/awQVD+zbeCZD1Tf8CUOim90BK4P7GP9dSngrDaNC0i
	OUfK1+0jWNS9gOHYq6osOgmgd+QKKqxqziGVRnwV90K5neW3aRANZXt64PnpqD+//wZ2nNlfuLy
	zKY6KShXeFhqeQCsEzkBAqG819z8jXC2cSw5NtLCA8RGyVElLxh5XxZAoH88EYaQUPQkfBBpGmX
	0j9jo+Jv5XLdd4m693WavNqSFYcZmkceimuBm1NZWE0s0O+QPmIJRIuCCbcboc6GHGiA==
X-Received: by 2002:a05:6300:2209:b0:3c3:80bc:1540 with SMTP id adf61e73a8af0-3cb6c75303emr14389949637.3.1785939887172;
        Wed, 05 Aug 2026 07:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673b7b2sm17424673eec.19.2026.08.05.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:46 -0700 (PDT)
Message-Id: <83cc3fd6a5e4da6204f1b97e76d33dd431abc5af.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:34 +0000
Subject: [PATCH v25 4/7] branch: prepare delete_branches for a bulk caller
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

Teach delete_branches() a new mode for the upcoming --delete-merged
caller that checks whether a branch is merged into its upstream without
falling back to HEAD when there is no upstream. Existing callers keep
their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c44f710a48..7b0aa68572 100644
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
@@ -193,6 +196,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -262,7 +266,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!(flags & DELETE_BRANCH_FORCE))
+	if (!(flags & DELETE_BRANCH_FORCE) &&
+	    !(flags & DELETE_BRANCH_NO_HEAD_FALLBACK))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
-- 
gitgitgadget

