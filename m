Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F108613F
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977961; cv=none; b=IwM4aqfCRLzkfnFMI67UbuUwS5Joc2DSNQXPJSwCqFEyPguNXA7nqiRL7NA80/319unyRHIP8IygBXDlm5ijqbyrkSseQzIuU1FCSSAcBRSSPN/6EfuYrbfSjZzXUIQshP0dMdNDT81jrj4owLiegX5I5ZpPRPuAoKws7knGoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977961; c=relaxed/simple;
	bh=KNaPKvmdBshX5hFe92IAta1D0x75ADuM6czHijEQRto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnZ/foKJukf2C5SXLyj0RdS++qoMVlhXjgjRITohoH4DXhTPIy7m7p7vO15qb3v7Jcop9WpPyrAnD3hZVoUZGhcJ3CMwOqyAvC5NUpke7KCx5Jdahzee1a4zGBDQlejW/RlugOou8lxw1dqT4oNAD9TsSAEci76EnUQPV2eE7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYMQVKVa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYMQVKVa"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a16114b69so45185385a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977958; x=1711582758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR5+S3hJ6zjSmrEffBraeCyJManzdF4Am+lGe5uct0U=;
        b=cYMQVKVakj0J3tXNKieCDfEWbapVOD8us/7PW0rcp3KSDVpTRMZZOk+HuIFJc0NNn0
         sSMoWFTgz3XdeO2m72R6tjS5ykKJh+8aBarZgkucKvrKaNylm4QNLHH9q8XNrOyYBt77
         8hn9DLSLtjx3yaylVsnLf0XdF/lknjElXKbtEn04ge0F1KKnJg8CMg1suyhs6HOLTiBy
         cElNmO75/wZLimty+FgdDuTPsDg5ptZIJxAC9LRcBnNU/NThWyOSXdTohfZBkAOezFE9
         14HiEgaXt+2Iq46pzmROVY2lho+fvzOg0gHBnbTb3oHQi21Kt25V9IR3MJ8f47MpAPng
         8OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977958; x=1711582758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR5+S3hJ6zjSmrEffBraeCyJManzdF4Am+lGe5uct0U=;
        b=nZW89goZw+QA9A6z+O3zHFKeZVzL7xrNxQV/9W7iWehyY2PxjsSUapt7oVJWTUpRH8
         pwKrX1EvSs3XLw773ab6b0UIIPbiNVIwQHNMs8UpsiOmPmyZRIxZ/UoWFeiDPurA/zfd
         5/WuLuBwVH5QAufbUMzUKyVoCoxahfVJWEBKx+g3m7qmKBaoGOu2SbZCdBWr/lLB7XeM
         HYI09kAU+jAf4ZHrZZTthTItQUV24XtVG58qQiR1oTJFW8Wud75hm9wpSVNLfr12MPCW
         Vd7sllCto2uAJYnE94wuuul/oWc4RY5j5gUudJOx7PgUqZNd3B/FbnaSDwm2m9NEeDll
         ACtA==
X-Gm-Message-State: AOJu0YxE2VCiz1X0aXPeT+bxUmmLQv1l0IZZ+/IG2/dEFGvv1JT0ovsu
	3Iz0iQmb1q4i1WzFCY7WdXC+lS3prpaaYYZ4rzSxRMYrLmG9pDYPrgxcfPvI2Rg=
X-Google-Smtp-Source: AGHT+IF5KtN+C4Q/xnBAMoWHVrWaBiUSsFhH4rY93+E0mb/nw8ykr0QLoJg9GBldA6pg0QVT83CwWA==
X-Received: by 2002:a05:620a:880f:b0:78a:2fee:3bcf with SMTP id qj15-20020a05620a880f00b0078a2fee3bcfmr158942qkn.29.1710977958330;
        Wed, 20 Mar 2024 16:39:18 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:17 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 5/7] sequencer: do not require `allow_empty` for redundant commit options
Date: Wed, 20 Mar 2024 18:37:00 -0500
Message-ID: <20240320233724.214369-6-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A consumer of the sequencer that wishes to take advantage of either the
`keep_redundant_commits` or `drop_redundant_commits` feature must also
specify `allow_empty`. However, these refer to two distinct types of
empty commits:

- `allow_empty` refers specifically to commits which start empty
- `keep_redundant_commits` refers specifically to commits that do not
  start empty, but become empty due to the content already existing in
  the target history

Conceptually, there is no reason that the behavior for handling one of
these should be entangled with the other. It is particularly unintuitive
to require `allow_empty` in order for `drop_redundant_commits` to have
an effect: in order to prevent redundant commits automatically,
initially-empty commits would need to be kept automatically as well.

Instead, rewrite the `allow_empty()` logic to remove the over-arching
requirement that `allow_empty` be specified in order to reach any of the
keep/drop behaviors. Only if the commit was originally empty will
`allow_empty` have an effect.

Note that no behavioral changes should result from this commit -- it
merely sets the stage for future commits. In one such future commit, an
`--empty` option will be added to git-cherry-pick(1), meaning that
`drop_redundant_commits` will be used by that command.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 sequencer.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f31d71ebad..b8d8f15e65 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1730,34 +1730,25 @@ static int allow_empty(struct repository *r,
 	int index_unchanged, originally_empty;
 
 	/*
-	 * Four cases:
+	 * For a commit that is initially empty, allow_empty determines if it
+	 * should be kept or not
 	 *
-	 * (1) we do not allow empty at all and error out.
-	 *
-	 * (2) we allow ones that were initially empty, and
-	 *     just drop the ones that become empty
-	 *
-	 * (3) we allow ones that were initially empty, but
-	 *     halt for the ones that become empty;
-	 *
-	 * (4) we allow both.
+	 * For a commit that becomes empty, keep_redundant_commits and
+	 * drop_redundant_commits determine whether the commit should be kept or
+	 * dropped. If neither is specified, halt.
 	 */
-	if (!opts->allow_empty)
-		return 0; /* let "git commit" barf as necessary */
-
 	index_unchanged = is_index_unchanged(r);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
-	if (opts->keep_redundant_commits)
-		return 1;
-
 	originally_empty = is_original_commit_empty(commit);
 	if (originally_empty < 0)
 		return originally_empty;
 	if (originally_empty)
+		return opts->allow_empty;
+	else if (opts->keep_redundant_commits)
 		return 1;
 	else if (opts->drop_redundant_commits)
 		return 2;
-- 
2.43.2

