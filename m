Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A645FBBE
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608135; cv=none; b=GoJzOWrHALt3UosjJoSKShY2+hC7LbNIzm+hOTyzTUk4MennX8faozIhwG74vEEh0Ful8YCH+U891sR4uD7HwfgLWnwcW02/fi8ow2fOh9TIFc9rIbrhgu5abwphFrxgpubcEmcgcI/FM4n2WSsjpVL8nb4/ahn8kQCDnsCYv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608135; c=relaxed/simple;
	bh=EY16GqLA4scVYmp4SAo/eSxzT/GmGQyK2rAEmXb6QfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ho7uMemXSkM+Ktm+Ke686zumiksxneAtTlAs6oDYOEhKwY0Ndd/qdQFLQA9vY4dTFZStGGQijr7m+T82CM3lfB1ejFLM9qo9/jVTR69T4jU29T5etNJWcbr51eDLluxbJ6ldqp5G0y+1S4Rhpm4JhUPE6UF6VoAkoiouaC3HgFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZBZgw7S; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZBZgw7S"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7838af983c1so170369685a.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707608132; x=1708212932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+pjtfTaydBfkgCpQ/iQ5oTS/23jjSjL83Sm3nokqb8=;
        b=aZBZgw7SkENeiwoEAvbsj41bVcgeDP/FEj+e6nGnHAQ/14aBAf1ipxeTUlrkHNWnZQ
         0F8F5IYHq2RRosOsOVmzg4O3xqanDFz7+EoMLOr3BXpMvpR2eVPSe7D5G1EtMbi21uoT
         yq7pw2T6lQ6kf2eBiekJY3i5coD7DiOCLgbr8QZOzWjE9qfkaunFehkY+MJtwFqOHJ+g
         RcC44ngOgf5Txn1R1pAy4RQwjb51oKq+OdC2Vy31OUjaD8Y8GTE4Tn4n9zcXD+qV+0+I
         RnHBhytqhlwoGo8FgxGOUjsty03G1Nt/CR/PsCMCiBCOqR/9fQG8QbfxpjHyH+81JoC+
         SsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707608132; x=1708212932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+pjtfTaydBfkgCpQ/iQ5oTS/23jjSjL83Sm3nokqb8=;
        b=LmpPL53ojZu81sfifZ4nnON0m2vT+xSNVxPFz9Bt4DDtg5oxo7XIhyyzdlVbMMcTkZ
         1H3mrbfWcw67j3ukptxjCL0bs1xpOHyfZ1XuoOu+BhOOxE26aiaGRqawd+aRuneM+3tL
         TzRTvA4yCGeMOMxCmQEProptysNH2I/Xf8iQhztmx+CQlBeGEAxtKlH4z0F4fj3Yy3Xa
         W/8/hBnu73IffMQtBbL4jXzSTMyLH0Db3zC/8FRIsrBb9nEbIT108UZ8z0Rg6nuW297X
         k0BsqgyY30rp+I467651bu2qE3IDXgyYQPpFQAgMtSg6MA6nDVAf+zmmcR0CT+ueVsIN
         N5TA==
X-Gm-Message-State: AOJu0YwvWPDDUhfVcUb1QBww59n4qiKKjcfaJhq8XOS+P8kMK9mEnthJ
	b4cCwDSPkg2GiqTBT0DhPlMLsBIMuFGLgOA4SpS0MDlK7iGynAKn
X-Google-Smtp-Source: AGHT+IGrtZOtke8EjnDeBAFchMc903tbooPvbrz446rxHHyfa2Rr7r1TyHVG7LFOUSRsPLSmbc6okw==
X-Received: by 2002:a05:620a:13d3:b0:785:6018:a5 with SMTP id g19-20020a05620a13d300b00785601800a5mr3184383qkl.4.1707608132188;
        Sat, 10 Feb 2024 15:35:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7hjSCNzhi68Ysj/vZrTJBZINs7vTXuGxR8ROrRUPva7z6eveL37kbI/b+bleV86O6hFBAFPxpw7nfMPml/m5yPKHzaVUKyIJ6v8/jlY46vROR+EtXUNbHk6G7b6iylpFoAZETRsWgC4WhxApPzFBzh5YFgMvAzCSI4Zk2aVukHpBZuz516+B24H+INpHNw/cWCtN1Ir0HPe8FLWp7Mnqd/R6vgj97VNXsoDrmvZ70VSf212JF06loFW51pi5WOOwPwJ+XJxHaPp6r
Received: from [127.0.0.1] ([2606:6d00:17:3855:d82e:7889:6cb3:5f])
        by smtp.gmail.com with ESMTPSA id qp9-20020a05620a388900b00785c9ea7974sm571942qkn.79.2024.02.10.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:35:31 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Sat, 10 Feb 2024 18:35:13 -0500
Subject: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.13-dev-71c1b

From: Michael Lohmann <mi.al.lohmann@gmail.com>

'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
2006-07-03) to show commits touching conflicted files in the range
HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
rev-list's option --merge, 2006-08-04).

It can be useful to look at the commit history to understand what lead
to merge conflicts also for other mergy operations besides merges, like
cherry-pick, revert and rebase.

For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
since the conflicts are usually caused by how the code changed
differently on HEAD since REBASE_HEAD forked from it.

For cherry-picks and revert, it is less clear that
HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
ranges, since these commands are about applying or unapplying a single
(or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
encountered during these operations can indeed be caused by changes
introduced in preceding commits on both sides of the history.

Adjust the code in prepare_show_merge so it constructs the range
HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
so keep REBASE_HEAD last since the three other operations can be
performed during a rebase. Note also that in the uncommon case where
$OTHER and HEAD do not share a common ancestor, this will show the
complete histories of both sides since their root commits, which is the
same behaviour as currently happens in that case for HEAD and
MERGE_HEAD.

Adjust the documentation of this option accordingly.

Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
[jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitk.txt             |  8 ++++----
 Documentation/rev-list-options.txt |  6 ++++--
 revision.c                         | 31 +++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c2213bb77b..80ff4e149a 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -63,10 +63,10 @@ linkgit:git-rev-list[1] for a complete list.
 
 --merge::
 
-	After an attempt to merge stops with conflicts, show the commits on
-	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
-	that modify the conflicted files and do not exist on all the heads
-	being merged.
+	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
+	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
+	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	when the index has unmerged entries.
 
 --left-right::
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2bf239ff03..5b4672c346 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -341,8 +341,10 @@ See also linkgit:git-reflog[1].
 Under `--pretty=reference`, this information will not be shown at all.
 
 --merge::
-	After a failed merge, show refs that touch files having a
-	conflict and don't exist on all heads to merge.
+	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
+	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
+	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	when the index has unmerged entries.
 
 --boundary::
 	Output excluded boundary commits. Boundary commits are
diff --git a/revision.c b/revision.c
index aa4c4dc778..36dc2f94f7 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static const char *lookup_other_head(struct object_id *oid)
+{
+	int i;
+	static const char *const other_head[] = {
+		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(other_head); i++)
+		if (!read_ref_full(other_head[i],
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				oid, NULL)) {
+			if (is_null_oid(oid))
+				die("%s is a symbolic ref???", other_head[i]);
+			return other_head[i];
+		}
+
+	die("--merge without MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD?");
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
+	const char *other_name;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
@@ -1973,15 +1993,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (read_ref_full("MERGE_HEAD",
-			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			&oid, NULL))
-		die("--merge without MERGE_HEAD?");
-	if (is_null_oid(&oid))
-		die("MERGE_HEAD is a symbolic ref???");
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	other_name = lookup_other_head(&oid);
+	other = lookup_commit_or_die(&oid, other_name);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, other_name);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);

-- 
2.39.1

