Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8DA19C542
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763807918; cv=none; b=Wn51flt9PP0c9/so6KqpOhvpY2XXbCJVYtWkFpXGkiFmHvRhcrN4RrbmQrByxgvzfIGlH0BgnvpomF1PkNQvN44ZiW1w6xCKg+mLYduWj12R+NGW5levly002mk92H0v1TMA6Qu9wwq5plqrJtb0YgkPBf2k5SzCA9kc+feSHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763807918; c=relaxed/simple;
	bh=tEqCXMcWmU4Fw4/uzB5V926WcY5bSpTyMrK80rG3djc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=koyOHDkFrO+FknENZxNXvsUJSYCXIbsvai3CsfdaNAJVchY60+hOml4JdvZbME4lx4rgNJJh7YJHuCMJN0IkFBzohvrleOvQ/LsLKvRE96NovtV5DLEWsh2HILSczbeY+VxmAfhLI3+gvB3KZHKPeJdEopXYM4Ovh2NCCXdHvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpGoo09a; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpGoo09a"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ed01ba15so247676585a.1
        for <git@vger.kernel.org>; Sat, 22 Nov 2025 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763807915; x=1764412715; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtUX3tstCvA2zlA5JMinxTeDCSiPj9k71ShjpaeYT3A=;
        b=GpGoo09aazzn+O0a/flN2+3UHFdGEzdRyQEa10fpVEOdWm98dXhyHQwKr28MMU1zGH
         e78BH27y2BF7l/Bx1r4EFVh98Eu8sshwGdCsbTFtXnvqbqmAXFViqMBhbep7rUsTFCH2
         o1LXgYgI9WLZHtHtLvzvq/Wdph50QgLx96NFF1jYBEDBMFTw2AJprhQxQ14eFRJPw8zs
         kroxAxrv8rpDgZBQjfuDNsW4MboEqqrisNPpl2Wg+7S+dorrPoo53ovh7sJmASHzgsmm
         q8WJKNFYd8pQVOL+Ws30w1CWv8tNhxVZxtDBMdE8UbQ2kd7UAMYecn9ArdfiFfnlIExo
         Elsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763807915; x=1764412715;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtUX3tstCvA2zlA5JMinxTeDCSiPj9k71ShjpaeYT3A=;
        b=qzVEcdwZ5WFqLcoUF6WfVW/0SOK5PRKPAFekSSa9InGUqsr8J/DWHLdiznrNXLVVqa
         zG4j5zWD65xfFsr3Q7z8YkmSkowQ+6qMCTf29qHjNl4sSJkSl4yRMI1lQb5PqZOzUc2R
         YOYNPhdJxbyrkWb1HEZzrUEykZ8ChGMlmh4Vg+1QvdvsRZ1nK20h5cIScqUfwv37jgXZ
         uGqk1dLtbrMkP3aVZ7LMkGG83QH3efxEUt/lVWUlB+TP+fYZH0m1/EIWq03L4mERhQB5
         xUnq50uO3y+J3UE/jI5OZF7q/B+nqyb/Eg/FHhGOBaXJtenj/IuInDnWQeSJPCCu8KC9
         g4gw==
X-Gm-Message-State: AOJu0Yw0dVYOoiwGS5zzyqbyY+TTmW1z+R3FJ7K510GucTViA3hUgo5u
	kU6INPuj2SqMgxU6wl+tm9GdDmhBoyxFPRA2Aj5MNgGoC5Os18eqiVV1zvOp8w==
X-Gm-Gg: ASbGncuj+3UkIllj2uClIVvN3ZSgI6cxHvVALIzKzu+ZJYnslQl+Ezuvv9u+fVHMaki
	J381rQEgllAFjeXuqzjZqNxLkt3CcOR3w90bewBrWKjibh+YUhs0ZLorjRUm+bvvJDZTopUTZRP
	kZGhz4zacqbITDQuufbOvQIIs6RsCmP916Oh4khs3crvkDZkBcD3rlaXsYcWxDHevW8nHOWKsk3
	D64UWD7+W2559ryn3J9ed+13FkGrh58EA1QiQBuAX5MkN62sewUq7SImU+uJ8y8pdI+/3RHIStQ
	Ln7daspc+CPKKylfyN1SEV2NoqFQKDdAOGFlBMo7VEQ6M6OU0dc9CcPrIyMNhgQ1aI9BRnYkJHS
	KDcwetYUqfMmFC/96VQeStQZimZjf1lqvgY2BNcGhxoKfeTCp4mYb3eva8hfI3CrULaubIgq31q
	UtXhmTseMnrch1
X-Google-Smtp-Source: AGHT+IHRFUVudZpfcC3FF9UnYcsTtCNiaD+utz0q6IVxj1rvZOTTSWEdS3gY8LRSjuH04Vzcabp85A==
X-Received: by 2002:a05:620a:288a:b0:89f:9693:2522 with SMTP id af79cd13be357-8b33d487080mr607875985a.73.1763807915143;
        Sat, 22 Nov 2025 02:38:35 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b357f0355fsm100756585a.10.2025.11.22.02.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:38:34 -0800 (PST)
Message-Id: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Nov 2025 10:38:34 +0000
Subject: [PATCH] Fixed --shallow-since generating descendant borders
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When shallow cloning based on a date, it happens that a list
of commits is received, where some of the list border commits
actually descend one from another. In such cases borders need
to be expanded by additional parents and excluding the child
as border.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
    Fixed --shallow-since generating descendant borders
    
    When shallow cloning based on a date, it happens that a list of commits
    is received, where some of the list border commits actually descend one
    from another. In such cases borders need to be expanded by additional
    parents and excluding the child as border.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2107%2Fspog%2Ffix-shallow-since-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2107/spog/fix-shallow-since-v1
Pull-Request: https://github.com/git/git/pull/2107

 shallow.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..37079a0bf1 100644
--- a/shallow.c
+++ b/shallow.c
@@ -251,21 +251,50 @@ struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 	 * commit A is processed first, then commit B, whose parent is
 	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
 	 * itself is considered border at step 2, which is incorrect.
+	 * We must also consider that B has multiple parents, some of
+	 * them not being in the not_shallow_list, but must be added
+	 * as border commits to the result.
+	 *
+	 * The general processing goes like this:
+	 * 1. Above we've coloured the whole not_shallow_list of commits
+	 *    with 'not_shallow'.
+	 * 2. For each commit from the not_shallow_list (the code below)
+	 *    we colour 'shallow' the commit and its parents, which are not
+	 *    already coloured 'not_shallow'.
+	 * 3. Commits with all parents being coloured only 'shallow' remain
+	 *    shallow and are being added to result list.
+	 * 4. Commits without all parents being coloured only 'shallow' are
+	 *    being excluded as borders, however their parents coloured only
+	 *    'shallow' are being added to the result borders list.
 	 */
 	for (p = not_shallow_list; p; p = p->next) {
 		struct commit *c = p->item;
 		struct commit_list *parent;
+		int must_not_be_shallow = 0;
 
 		if (repo_parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
 		for (parent = c->parents; parent; parent = parent->next)
-			if (!(parent->item->object.flags & not_shallow_flag)) {
+			if (parent->item->object.flags & not_shallow_flag) {
+				must_not_be_shallow = 1;
+			} else {
 				c->object.flags |= shallow_flag;
-				commit_list_insert(c, &result);
-				break;
+				parent->item->object.flags |= shallow_flag;
 			}
+		if (must_not_be_shallow) {
+			c->object.flags &= ~shallow_flag;
+			for (parent = c->parents; parent; parent = parent->next)
+				if (parent->item->object.flags & shallow_flag) {
+					parent->item->object.flags |= not_shallow_flag;
+					commit_list_insert(parent->item, &result);
+				}
+		} else {
+			for (parent = c->parents; parent; parent = parent->next)
+				parent->item->object.flags &= ~shallow_flag;
+			commit_list_insert(c, &result);
+		}
 	}
 	free_commit_list(not_shallow_list);
 

base-commit: debbc87557487aa9a8ed8a35367d17f8b4081c76
-- 
gitgitgadget
