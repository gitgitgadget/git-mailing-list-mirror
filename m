Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E89158D99
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128509; cv=none; b=SiuxUYEIWj5Z/iOH+M2iUtHVPAasUBNo8YcqdfNdkPXne2fmXVOUcfWW5d8nQ9IVq6GHLq5ZBfpwD5LZmWsuvFQ2hdryQNF4KFtafn4PH6INvYtPExGl/zIElGQMzcEoXbwJTYPQZ+funqJA/9xGKnYOk/eEZ0ECIovc8jEEj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128509; c=relaxed/simple;
	bh=GR9NxrziFxDCJqYOzslF37bSHAB+oguJ/kCJz++Apuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqIPJxmHZofGJEKXl6lQhsVrBbGjLTXxOSTswgT1FQbXL6jpKLLt4cqHsNpJbbqrnWsJqvvWdQiAPpBO+J5MYonpQ2f39Z681hulTJla1tigt8jq6nduiqk5R7xlXA4Ol9+NGkQhjAZNKkPSb2zOiiJw/8rAWQl8+DtIQQVoDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiWhtxwN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiWhtxwN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6900f479e3cso25393196d6.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 05:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128506; x=1709733306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GhcVD01gDVAruHKpHzbKGpvaJTb9p+Wc7Oa865t0m0=;
        b=HiWhtxwNuAB1tKibuzD6ZaQXP67Z8urvPLqmEME5q0+xC7zLPeIleE68OzcqihyKaQ
         x06K7WqLSNWAP/ymUyHTPzk7y1SY2FKsGH+eTBE9amIL5nl3mZYAO9e4Hj40EEKU1n7I
         4Xg8CHG2nxe3RcAM/+X9gz+/zxbtaVRNeWdKQr4EFPG03OH4fGhO0p70nXJgUchZJQry
         wjf1lHh8HZIwoZXyOQDoLccWT5brs5lFSaKlH4xB1SBzZvs28GDnTfZch6IrSd1SnBrm
         yjD7hYwGnQ/KbamCQbUICoDY8C33ap9KwXGzMzY7KAn5zTkkDy+0ZMLARBwZzMVyaMn7
         d11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128506; x=1709733306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GhcVD01gDVAruHKpHzbKGpvaJTb9p+Wc7Oa865t0m0=;
        b=S3fb9k6UizuQMUV3SDYo3Sw+5op9sPEXhRU7j2uTd2oUoAV2VTdQuho9JPYhcVgOb6
         +f7n5gEmqnGj7Ys53wLb2eVhrSRGoav0lOPCkaEyoKGZDKQo7e9CrQpoJRP39/r1sA3Z
         CctSA4AUMdHZOeBQXZu8FT0B0zQWluaZvzAKIOrvU8BbF3EDF3Ah9lEyU2HOB7ZGw1/U
         Jq7oW3xl1keBk/JLJX7WgbtuxEL/Dyff/FAHYJt5P/mOnM5uP4FO8cDgDuBibQjj02hV
         x+5MK/Ge+gtv6YxYLuXpwXoZf4PLrIrIIBqjFXjW1UYXjraPsT2DXC4V5k9MqBnRajRN
         FGyQ==
X-Gm-Message-State: AOJu0YwxQeEOs07ne7j5j/JMODMvGZnh/SXG3RA3UNA1HnTDL6VZlJ4u
	M2cD2BuaXMD5cWwN3qm3Lm+qOoEuDO85K7cXq+T350Tx87SB8yLa
X-Google-Smtp-Source: AGHT+IHt+inqHHQlQJqi6irnn+jlHgv4xbC/aZxfrRorTz1pIqq7sMVYsV3wrGK/NGbwU2erm2/AjA==
X-Received: by 2002:a0c:e28c:0:b0:68f:f9aa:f502 with SMTP id r12-20020a0ce28c000000b0068ff9aaf502mr5536977qvl.25.1709128506377;
        Wed, 28 Feb 2024 05:55:06 -0800 (PST)
Received: from [127.0.0.1] ([2606:6d00:11:ff90:f134:2d0a:620a:ef80])
        by smtp.gmail.com with ESMTPSA id jh15-20020a0562141fcf00b0068fa78ccef7sm5247839qvb.116.2024.02.28.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:06 -0800 (PST)
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Wed, 28 Feb 2024 08:54:54 -0500
Subject: [PATCH v6 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-2-8ec34c052b39@gmail.com>
References: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
In-Reply-To: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>, 
 Michael Lohmann <mial.lohmann@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Michael Lohmann <mi.al.lohmann@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: b4 0.14-dev

From: Michael Lohmann <mi.al.lohmann@gmail.com>

'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
2006-07-03) to show commits touching conflicted files in the range
HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
rev-list's option --merge, 2006-08-04).

It can be useful to look at the commit history to understand what lead
to merge conflicts also for other mergy operations besides merges, like
cherry-pick, revert and rebase.

For rebases and cherry-picks, an interesting range to look at is
HEAD...{REBASE_HEAD,CHERRY_PICK_HEAD}, since even if all the commits
included in that range are not directly part of the 3-way merge,
conflicts encountered during these operations can indeed be caused by
changes introduced in preceding commits on both sides of the history.

For revert, as we are (most likely) reversing changes from a previous
commit, an appropriate range is REVERT_HEAD..HEAD, which is equivalent
to REVERT_HEAD...HEAD and to HEAD...REVERT_HEAD, if we keep HEAD and its
parents on the left side of the range.

As such, adjust the code in prepare_show_merge so it constructs the
range HEAD...$OTHER for OTHER={MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD
or REBASE_HEAD}. Note that we try these pseudorefs in order, so keep
REBASE_HEAD last since the three other operations can be performed
during a rebase. Note also that in the uncommon case where $OTHER and
HEAD do not share a common ancestor, this will show the complete
histories of both sides since their root commits, which is the same
behaviour as currently happens in that case for HEAD and MERGE_HEAD.

Adjust the documentation of this option accordingly.

Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
[jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/rev-list-options.txt |  7 +++++--
 revision.c                         | 31 +++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a583b52c61..29e7b50bcf 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -341,8 +341,11 @@ See also linkgit:git-reflog[1].
 Under `--pretty=reference`, this information will not be shown at all.
 
 --merge::
-	After a failed merge, show refs that touch files having a
-	conflict and don't exist on all heads to merge.
+	Show commits touching conflicted paths in the range `HEAD...<other>`,
+	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
+	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	when the index has unmerged entries. This option can be used to show
+	relevant commits when resolving conflicts from a 3-way merge.
 
 --boundary::
 	Output excluded boundary commits. Boundary commits are
diff --git a/revision.c b/revision.c
index df775f74d0..d2ebdd045a 100644
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
+				die(_("%s exists but is a symbolic ref"), other_head[i]);
+			return other_head[i];
+		}
+
+	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
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
-		die(_("MERGE_HEAD exists but is a symbolic ref"));
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

