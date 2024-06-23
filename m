Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8324085D
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179005; cv=none; b=Bzx1AuLmsv3cPgrpH6OvkD8M+bQJjXsWn3JvFQ9BULKB0gi9SXDRhsfi+ee50KA7y/vlQgCSZwNfHzahHh0r4DuzBORe1iY4YU17K7mJYTiF0y1c7OnAOvSO5S/W6M0MKPUWGr3wtZ23NfiFB83t12YnCYMcAdo26f6BaNg1OHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179005; c=relaxed/simple;
	bh=KtDAty4g0+mQlFTV1P9dfgV3Kxd91zjTq5sIkZBz5UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlRGAvIUtKMj+R7KpBx4FL53rbUZ3+sAEMTSy6IIKj3LAs+LxmymkxQEznTaHsSofLT8wbRDJ001zVs7HUPp9ZTUDfxPwMaz0UJB8+4Ghuvu1OYa0PATNKFsSnO+NJ9lUubNcblWFSPr26ZA2CcG6CdborHF1vB+s8n93g2dSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jolAtWwI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jolAtWwI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2e736dfdeso558298a91.1
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719179003; x=1719783803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+6T/YEA7/S2Lzq1+3FDo1N27MYwCbifdIk+epXpUm4=;
        b=jolAtWwI1ctoBnbAdXMaW17ePRb79m3HKtt9LGYZRmGtvVbHhONPuNtDE1EPaHZIoR
         0pMu6DsTy6QAygH2abu0adloz+SnHX2+AKpRITipR82g6fI6D8LAsOZowg8oXjZIC04X
         FyLDS5lJ09RaerGzWWpWDKeIDuNA9fPafbuu80wN96eShL2md91FIlYlEkiE9N+opbpw
         aio/Ql3CROPmwMjo8DSkqzgMfFU1zNAp8+xS6A25OGtGbUqmubppEjBz4DETVp8tL4d1
         rc/YhgP2TVtPke32VM9DHhkZiNPxZcdzdQvDa+ZZ1406TBcIOVc0WafMmUYDE7nGUhR6
         PecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719179003; x=1719783803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+6T/YEA7/S2Lzq1+3FDo1N27MYwCbifdIk+epXpUm4=;
        b=bS2HXSAYyVcGEKWurF/5yQiMIhHZKvQvKgErdJ28mGNNxsV1gfe8ppebmVqJT/MxRI
         TWFT/Udd+TPdZxZGLP2B4XbPN6yJRGCF2AR/rjlIEdiO7hikOzdYMlucIVBhGPhGFjD8
         5ie5KV7pNZddSuQDOUwhkdTMPxNOe7/E23+3YkUDVnXT/OUg8b1DRNScZmbzwjzJIdzX
         YUBzfn8loPJ4X1mKOPj+RdEavs+dPCcmOZMYEflKZsY5w+nYzRWmVuJSexF2cJwTg5l+
         85CsNDfL6S7v/BplaTk8KFEl2df6TQPG0LwPy2vDO4Qbf8F7xMnyXldcn424g1FcD90I
         eGUQ==
X-Gm-Message-State: AOJu0YwgJNPJfiPnoMOe0XrL+Y0rSuGaQ5apKruqUwdmM2fkPZQRRcn2
	cThbySoQ6t9mbzQqlA4oVoi4QNlNdBG5h2MQciwtnw+9JCnA1K1t5vJbNKoM6dA=
X-Google-Smtp-Source: AGHT+IGyn41i84MFmzehjqKfWZ1xdpI/hiGbB/ie1a1bAeupmzpxAVWkqNVH7WcdYjKT5NzzWcYU+Q==
X-Received: by 2002:a17:902:ecc6:b0:1f5:e635:21e9 with SMTP id d9443c01a7336-1fa0d73e4d5mr56091735ad.2.1719179002707;
        Sun, 23 Jun 2024 14:43:22 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:200e:9e9a:d72b:4d57:4251:125d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb4ea7dbsm49666415ad.213.2024.06.23.14.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:43:22 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH] describe: refresh the index when 'broken' flag is used
Date: Mon, 24 Jun 2024 03:12:52 +0530
Message-ID: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty.  Refreshing the
index before running diff-index fixes the problem.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..2b443c155e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -645,6 +645,20 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			struct lock_file index_lock = LOCK_INIT;
+			int fd;
+
+			setup_work_tree();
+			prepare_repo_settings(the_repository);
+			repo_read_index(the_repository);
+			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
+				      NULL, NULL, NULL);
+			fd = repo_hold_locked_index(the_repository,
+						    &index_lock, 0);
+			if (0 <= fd)
+				repo_update_index_if_able(the_repository, &index_lock);
+
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
-- 
2.45.GIT

