Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB322A4F1
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941509; cv=none; b=UyzP54jrZTTOC80zY5TAfCQPBQBY6oypV2EPhj+/TmM8Z5+PI6Rkwu8Ek1ETjwBvYgXvDm6fzqHzhcYRB//vP3PU8LJ82Ynb0E1In9bDlxxbKmmOTv726ro6DI9Zg+F9kCIBVvPi5dV93DFr7YIMYubm4gCEscmuJ+zmPem2EkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941509; c=relaxed/simple;
	bh=+8/VtSkOIaB22QPl1liVtXzx3b5TTTXxUxe6bFixuJk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=L9rmTyltbOpcFzJzCdkmiey4CyCY0UvBQ3lYJf8RzAYLvC6DI9FJyhMBxakF05mhlCz5bfgUrjxWwHnU0ghvSwcOBilv2Q02GhRh/dtLPdJe6CBOR9f5z9ePWket2TGiPglcNm+wQ7wBJhWu5esMcXhoIBknRZuMfIDJW+xH4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaOo/Jye; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaOo/Jye"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0dfba946so4536655f8f.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941505; x=1746546305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QtDZkc88tLQNUufYh59jfP5v87UtxA4ti2mo3Drcuj0=;
        b=XaOo/JyeEwaXTcRXa9UGa7gWlGKFdaZAgw02UhKfNdNTJoH1Ra3MINoZEzePwP1Bch
         oIZx6hFZW3JY+UUTBGJbTi2oEzkde43PL8hmrD18FUnjbGL7l2roeQ887nESbgEoAaE0
         QJ4oue+wN5mjZWe3cfRpG+6Q8x8Jm1ZT8aDb0s4COa6IVFvvKHuLTbLC0odVzSJmqf4u
         8nKJ6xbIPt8fY+IrjlGNZck705sY+e+Yqgch7aTI/BTkV9Fnms2jq2uSyKQI4CKaVEsr
         4R7dGVmoXkYwAqp/liGCv8ae/HA85JEHKz/xmV3J4vhsohjgvJIqvzGPr8Vjohel5DCl
         35Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941505; x=1746546305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtDZkc88tLQNUufYh59jfP5v87UtxA4ti2mo3Drcuj0=;
        b=mzpgzpKAsK34cyUcDHgohEUsRz3yuBwoq1WbQ7dGGVsgAPtkH3GLH0FXUUSsKtxIfp
         uFQ3KmlgTgsBUEK6OwhMoX2oUImPp9HKIgB260AY9T9F2vgAswfezcniAYNbS4Syq+yn
         w0OWrjTwyN4bAIWkoBFfmuhMeHU+bFUzFYtgcaCrfiow7g4AP7dmRiUmd5zUzVmPwbFc
         9rudNnVkLy+471di67pzsjWRwBrxRcMdJBDm4J+8UXmdvfV32HhMgPlMT+qYNv6HlJBC
         De9afVjETL7wOTgh8xVYWwj1JAUu8C0ga6EScCj4ffvXjZtpIxENzLTIc+3Uob1MnKQi
         e/7w==
X-Gm-Message-State: AOJu0Yz+ECxt8K1Bqcnai93ymRZOhHuKxAnZUUobW9Obw7aUoD4mtYvi
	dtcXuL5XcCXsYaZNFDn4SH2HvUWSXOw6EKtUzNBCvx/MGRKHxgiZ2unj+A==
X-Gm-Gg: ASbGncuTgAOEoAEz02c3QASKs5chBW/Y/Wc1D0OxakshTWTIRkouYBfMIHZVaGcozFR
	h1chpqN4uo/6YH++tDIhdlUUqoHVF8NegrfxPc8QY2YQTve5q2eQB9wSMMS8FcQVNaBoOTaiPeX
	k2NqyBP29xFAf1RLLvhniPEKHQfEHQ1uWSLEpywrMAeszk9YK21WpMLr8qTAnFcb9biQopZR1PW
	8SGle5RZCAGM7lkOxppKLFqcPn2nfMj17Up1P0vYdLLyWUqqj4OVR0nVRlJrv1luX4JgTMQlg09
	jw3Apuofq5+OH/t3e04xGHAcxWc4QW1XfCGjNOI9WXlZ4qZjnLVv
X-Google-Smtp-Source: AGHT+IE0lfuXhN+I8PnqR22JDlupQbRXEF0R/J/p0US9n5in+oJOl1f/7iI5ffbf8YE2hOpKIqff6A==
X-Received: by 2002:a05:6000:2902:b0:3a0:88e5:dbb2 with SMTP id ffacd0b85a97d-3a088e5dc64mr3702340f8f.11.1745941505021;
        Tue, 29 Apr 2025 08:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8154sm191885115e9.30.2025.04.29.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:45:04 -0700 (PDT)
Message-Id: <pull.1912.git.1745941503913.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 15:45:03 +0000
Subject: [PATCH] tree-walk.h: fix incorrect API comment
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When commit 50ddb089ff68 (tree-walk.c: remove the_repo from
get_tree_entry(), 2019-06-27) added an extra parameter to
get_tree_entry(), it did not fix the ordering comment about the meaning
of the parameters.  Rather than just changing "third"->"fourth" and
"fourth"->"fifth", give the paramemters meaningful names (or actually,
just take the existing names from the get_tree_entry() definition in the
tree-walk.c file) and strike the comment.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    tree-walk.h: fix incorrect API comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1912%2Fnewren%2Ffix-tree-walk-api-comment-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1912/newren/fix-tree-walk-api-comment-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1912

 tree-walk.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index aaea689f9ae..226b535f085 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -177,10 +177,11 @@ struct traverse_info {
 
 /**
  * Find an entry in a tree given a pathname and the sha1 of a tree to
- * search. Returns 0 if the entry is found and -1 otherwise. The third
- * and fourth parameters are set to the entry's sha1 and mode respectively.
+ * search. Returns 0 if the entry is found and -1 otherwise.
  */
-int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
+int get_tree_entry(struct repository *repo, const struct object_id *tree_oid,
+		   const char *name, struct object_id *oid,
+		   unsigned short *mode);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
