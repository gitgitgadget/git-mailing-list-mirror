Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F413E9F6E
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391216; cv=none; b=SOcUxDWcH/NrBwDHfyLntEA7NLZ+9LhCNl7EVVyzFLboCC1X9H9Z2xVVznz6uxjvyLSSCHn9+UtHINeFhfRNyP3MCz4CFTcM81BCqI3nM9Nm2aqrzxqORJXv1I994Embang0gZP1RHHJkR6NrudrXF6fcOSqqe40rvrOcoo2WW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391216; c=relaxed/simple;
	bh=bUyk5H/itUq4WJ76MISND2x2BavMyiUyN9nXIo/CjlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ess/f/P1Qdlp2hZXb2y96vFp6xQhBhSCBVzTdhoSLrvjcHZ0Vn2cro4Icfvs8XX+fagNk7AX83TGZkAc2gzWP8LEXeCMJJ1M62f3Mz4V82XFtdwlxoguycI73c3zdhAh9PXBblOsiHieSFOLhUC1LwG6eFynxTAHyRvqmnhnnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht1eS/Hg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht1eS/Hg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354a69b1455so809180a91.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770391215; x=1770996015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqiChtztxgSmkaLVlfvZ01zqXtr4TBIab7kollCKZeU=;
        b=ht1eS/HgOBQoGddOhfIrzXmwZdEcAiSGeV8VZ+PsTacPRPEkLGryicibC/6l/guNNX
         e4pbMcxQWj3sZqQyYDkieOaySU+ow9hLph+iMCRl+JpEZaMi4Dx1uxYvK0WzD9iFg40L
         MebH7mnmUeCGfqSA+0EcR83LBEEDT50/YvK3GrsIXLaH4bTnzCYlE1RUf7FcZd951aFz
         lEYMgp3NWPOzHHoL8ja6Bi8Q0VHPP+aqjrYH4TiUckw1j+Jr4k+uVtfrxXcNPydPUYMR
         MgUlvWoezYlHJeX7CFcKbX1N6j32n7sqjzLOp6aiK0YmVxiqeR3Eq5nYi1gpHU5/qpNT
         6b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391215; x=1770996015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqiChtztxgSmkaLVlfvZ01zqXtr4TBIab7kollCKZeU=;
        b=BQP9Dp5YF0vxNQLNCtXcnzdQmpRM87/KqnVksMW5qSkCCny2C9dcMNyg95Qots0lqO
         mPnr0viLZA60w4w6CSsRyX93NDFCDPrIwv7flc907gJLoyk/JKBW8DmepiCcqXXvCJdN
         RadPha+rGYUB75bz5MXhZeCi9QpIi9+OjSWBbkHl/trjWhIpKdA623Jj07q/YgBPe99B
         dZYJ9Yjk0wqaOXZTHgtZik/AlAAfF6BWSFPPkFluN3ywe1QdPViTteoxq9yqn0+kbitP
         TpDs3NOXQjfTsI/yD76Wgdi0SskpkZwqPkIoUigwiMAc4ERYjqphI/Aa3PSEbhyYqVBV
         jMrA==
X-Gm-Message-State: AOJu0Yx3YUXhiqmU0918vj6DBWlpOuTOYvtbL5e01T+0gpWwQgfyTodK
	vuoxWGRNpOIeHQ1dNqqTGWHMFOG1OwbLAZ7q2OZdejgY5Nk7B675K/3iPECabADV
X-Gm-Gg: AZuq6aIzMTgcYneYnEhjEdARaqosNxyf1L7W6/NHTMoEvEx43tEZyr+BjdiyywuHQdl
	9JqSNJ3eu6Dq2Du2BnA2gGKwzUDnO+xqVWu/P5Kg+sP4Q25aWEjXJGO1jcll20P47IE4r6orsK0
	E2XVq2mthwvm9quEnMnBOT3N6B7ftJ85HbSG/N6fQ7g0dAq4IR2MRBWN1e3Tv/HaAN/vvH3ULEr
	G1JegJdSRX6ioSDsQE6Cl1NW3miytB2Tn3XzVI1HXzhcewMARqMRLuhTb2Yf2jbH2uWLVrz58LW
	zNnGLQGwOmvTzeuz/uvh9N6uG9A2Pbqge9RvXafijkaUPOt+r6ZF+6N11Y+BBcq8Emo2qBSWN0R
	Q06/faFbC4msL6qw/FB85hciVo/jzaKnrFIZHjWQ80CKnIsaGo1IihzfqyMlbtRybPRearzyF3H
	FL1PHzwvmb2ZA0YizmRSfLqYnUUXFQUaI=
X-Received: by 2002:a17:90b:35cc:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-354b3c6d932mr2714634a91.11.1770391214891;
        Fri, 06 Feb 2026 07:20:14 -0800 (PST)
Received: from AyushJha ([2409:40e4:9:a13a:caf:c2b6:5dc8:e5cd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb4fb24dsm2202078a12.7.2026.02.06.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:20:14 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [PATCH] [RFC][GSoC 2026] builtin/repo: avoid global state in get_layout_bare
Date: Fri,  6 Feb 2026 20:50:02 +0530
Message-ID: <20260206152002.1244-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_layout_bare() function accepts a struct repository *repo
argument but marks it UNUSED and instead relies on
is_bare_repository(), which depends on global state.

As bareness is a per-repository property, this causes the function
to always report the status of the global repository, even when a
specific repository instance is provided.

This change computes the bare status using the passed-in repository
instance (based on core.bare and the absence of a worktree),
thereby removing the dependency on global state.

This patch is sent as an RFC to solicit feedback on whether using
repository-local state here is the preferred approach.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 builtin/repo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..b2619cc77c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -35,9 +35,12 @@ struct field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repository *repo, struct strbuf *buf)
 {
-	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	int is_bare_cfg = -1;
+	repo_config_get_bool(repo, "core.bare", &is_bare_cfg);
+
+	strbuf_addstr(buf, is_bare_cfg && !repo_get_work_tree(repo) ? "true" : "false");
 	return 0;
 }
 
-- 
2.53.0.windows.1

