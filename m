Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBE1EA80
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916081; cv=none; b=kb5yqS7kUYxK2qtXQRlftZizXjQAewFJ1ANckoz5TOfpme28ADVykmG6Bmoy6/e1PhpvUQhal0h60E2uvVrf5MSx3EK+fPrGYDs4wdpB5FLUXVjMAdFsoGNYTHXtb+yY4POSP/Yqw9pOa0baZSsbxpY3OSbE4lbBsDADJeKlang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916081; c=relaxed/simple;
	bh=nKt1rvLO6PIIDlrP0+6vKzUW2JvktP28r9Svs/Mf2J8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f0k8+QE/TTmpormAGDOYEiNxy1YXQnF6TS69eh+eRjtWvOORzYNrAX8uej9HWS8xfBAsR5qaob8wR77sg9zx89agj/hiy4aQgfheFIr8ESOqgZougg4FWl2a6GUEbCQx3OjqAkiGKXJIPJvzWkulriEyub1xyvHeJK65BBk5B/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU/rXJO8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU/rXJO8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45024721cbdso39887765e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748916077; x=1749520877; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46HtcTaJ9G1zbJkc3B3lqX+OaVJxqBmUwidkLJdj/2Y=;
        b=KU/rXJO8TkubLPTC49stAtclLPl0qDgyU3pOgiAJHfWimS0OWYUJ1VCkCjpeRIbZr6
         AuiWalSX28CizbcYg2SU80qZnhWCejHYSsfBtsRD+ReoH09TnSruHXN/ACg0Tg6A0+A0
         rtqi2UA/FRiVOoGzN3I18m7ui8t9tXQ/PN9YLyhaetVqC2Akvd4JCjQuaZv6WSafsd6a
         zCoHRdSRlJZckY1ztNaP0SwKp10p4tujjD+fNX3N/ivhVi4wJpHnZGMZPy8nXjkf2chL
         6cudDGMkgPG2ogA54IiZeAJIKCRk2rnsviFNadW9+YEwnYtiYEeCCYmDR1us4Jfq5I3H
         35HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916077; x=1749520877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46HtcTaJ9G1zbJkc3B3lqX+OaVJxqBmUwidkLJdj/2Y=;
        b=B2LffrUGSiqrQ28tPzBUabRepApGYMgPRuNb380BpV04p+qFUb8fHszzTJsLjO/4/A
         IKr35v6Coaue5rkWzVWNkNp1IQLTAK6EESklexeGxAM/IlNSMTJTDNyNl9WLtrI7l3kc
         ZX316xy09j0fn4TxtPf9rhlxvWj5KMprK80OD/lHhiMFodnvzEHvd/quNCWH0hvKQ95u
         jXeAp9emi9ZtcvCNi3gOuUvztzRMCemMaMoLuPLiwHIZr2z5OulIRIDfuKZYQVAn6Tax
         je1kBsL+HfDXwm6765vvzQJPtizsb3Q6EWDUue5qQrvimP0vezWMYwEd76l2z5AnIyra
         OPGg==
X-Gm-Message-State: AOJu0YylCk3+48nql/lBrnFEE5/j+TUfT7Bsu8MGAkYUphWL5xWP40tC
	VJFZrFKe5WjUmSWxw42Yi7f/8Fx/uTiTIGNfhhjiLIDzD9UsNFjXD6mtp7QerQ==
X-Gm-Gg: ASbGnctehJrE48f77rpLzRkLcXPoXsUKbJL+at9mTJCbFlUEnamPjbGfRF+ghRzUWZz
	pB0p0ARoWgb/+I7jZCOaF2MYus43pxLz8wjnTbtk7cYWmsfCBERXasY6abc+0Wsv8hP4/Kipl4p
	m8jxzzOcMkX2Qe4pJ4J8eQlQTy58A+AotqcIAQ0KltZdoNaua1waBxxi7ahUXOXr2jjXaQRK6VY
	MTGLe9SWANqFxtt/1JAl2UG1rv/jvkGPvoFJh12tF0YImNjlAVbdbBjBTf/Q96S5/rnTbJTarOp
	rqpJYT+dHYWgGztG1qz41DCxeWKU9hVJBtYkVFweigSzEOFRHtqF+CaRV6AXfUs=
X-Google-Smtp-Source: AGHT+IGK+M0fx0KMfWlLc7qiQMCK9JsdaZ1xGgJSAhtdevIgivpO0xsezJH8rPjm+/leEKg8WAPWQA==
X-Received: by 2002:a5d:4e84:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a4f7e62b33mr10328862f8f.5.1748916076916;
        Mon, 02 Jun 2025 19:01:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8012adesm143454995e9.36.2025.06.02.19.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 19:01:16 -0700 (PDT)
Message-Id: <9d69c19273be31135eade258b49582bcc6df27c7.1748916074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
	<pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 02:01:14 +0000
Subject: [PATCH v4 2/2] BUG(): remove leading underscore of the format string
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
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

BUG() is not end-user facing but programmer facing, and we do not
use _("...") in them. Replace all `BUG(_("..."))` with `BUG("...")`

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 builtin/mktag.c     | 2 +-
 builtin/worktree.c  | 2 +-
 pack-bitmap-write.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 7ac11c46d53f..1b1dc0263e18 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -41,7 +41,7 @@ static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 		fprintf_ln(stderr, _("error: tag input does not pass fsck: %s"), message);
 		return 1;
 	default:
-		BUG(_("%d (FSCK_IGNORE?) should never trigger this callback"),
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
 		    msg_type);
 	}
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88a36ea9f867..2dceeeed8bd0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -621,7 +621,7 @@ static void print_preparing_worktree_line(int detach,
 		else {
 			struct commit *commit = lookup_commit_reference_by_name(branch);
 			if (!commit)
-				BUG(_("unreachable: invalid reference: %s"), branch);
+				BUG("unreachable: invalid reference: %s", branch);
 			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
 				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 		}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f400ee01213..56960e6ad760 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1087,7 +1087,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 					 oid_access);
 
 		if (commit_pos < 0)
-			BUG(_("trying to write commit not in index"));
+			BUG("trying to write commit not in index");
 		stored->commit_pos = commit_pos + base_objects;
 	}
 
-- 
gitgitgadget
