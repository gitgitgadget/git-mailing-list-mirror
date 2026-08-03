Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38694379960
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750645; cv=none; b=orMoKu8BUrx3jxH3TzwHQBzheBwc0UiXCxBAt8tfNvuBYityxykiJxDAoN8DxqbBgVe/LRUe/gUDJftUiGxQwIb+2jvHuh9617u/a6QUjPafTs62RCJ5ezf+0wDUmtAuOf+kDBaGUAvOfgpTE1Os0qPoqNII7av8EdmmT44U4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750645; c=relaxed/simple;
	bh=y9uF7jIXW7l7VI+TgXZVVCYY3bKAkMsKJ11Bs5ZYMVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAAX+fpNox0CJkLTJAt/B7IFN8ZiD7DquoNl9YrW7LOO7FjTwQmTBy4sVdlTk/Kqf1phPnJl09LzPUyELxB1dHfzXJFecu1QKCni0MZHDm/jWVowq2fE1nWxr0nZ59bxFTga4WAQ65SU3efLzUgKh4Ii+7aA19YFMAnEBRdvAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJYXFQd6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJYXFQd6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso8145315e9.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750642; x=1786355442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEAwYVNlcfmoiQSGIEzSrUNGYdWYGwEauM3KcRCaN20=;
        b=kJYXFQd6qB9Jak2QZaArWkND/LZIxGFHL64ml6nOXMcykjl/boFM5/YOj2AKB5eZlE
         U0mX+Y0rXMDyNwNN1pAi7k8SX/IgYxXnOy9ik8EUC063whwFzeNjYxsnGgHbFgLfDoKv
         OcYKMtr700xqzoJMlJff5rcd+yQeNtuQ87IdM82E+lhJ9YrWf/hGje/nQwEP8bdOsclF
         18pj2unKRKpdUN+H2zUplUEcubK4mhOpVmWJE/CCx3zc+coyGyBBRdigjq63z8yEDeOK
         5iGun+8AEskELV/DPEjHzWlJ0+tI4CG3onsnRcFqOIi38q4Zpmm/+DnZOjTGH967s3VZ
         qrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750642; x=1786355442;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEAwYVNlcfmoiQSGIEzSrUNGYdWYGwEauM3KcRCaN20=;
        b=X0tVS3VdYjlOZP09FXmcX81QUsmAHx2xvGpCs3eLev4vuoymabRzFaIokdbE7fUn+6
         pXK+GDv79RYVMMKSyZo2zr54cpzHMmsi6nC+nBqaGmpGLAekEu394ppPeNn36eb2JnyW
         pMXI8N47dSkmLN6tHMFOac5JU23Mb7dtXRD2zTFb5052WQqYYXa0kRuYvlICePBak1GR
         UJO/3SX1vTI1MBpiT1k0cfWih88vb5G8aURyRHb9lwG3dzTI2zsSXxYvsWER+QYFNjuZ
         U6JsS5yfI4mEBIBZe+PKtVUA5LkGC6zqetBhKFArwRR5uv8ObfwScPnpvjeYmd/KPiRI
         FKaw==
X-Gm-Message-State: AOJu0YyNbjY2kfyA8mXOE3ilAMEh0YmuZpuPhCDoMRMjGP9yAcM5l7P4
	EIdqxaa1a9h9owUa8zEX93+dXeSoLjKqdNWaTnCFNxgmXZeoAGd++L4VwBg3Hg==
X-Gm-Gg: AR+sD1104hyUxI74CjEreuETX/aZwywegOrYnGg5S4iyFa4zgluJOvC0Ugx9C6nR5DU
	V5h42Nfn+G75NS3jddeSHmkEOGPUnAumd9nhSuqPTJYg1zfMQuG1y4FILTtbSK3n2qfUeqvING7
	s8Y1BrRp5T/vkfqg9gUXAMdJ6KCzHvQbhNdJFUlT+5wcwWDiBp0nBlMFAr7vDnv2RQ6zIrKrvxo
	hVrktco7pfiJoWlr3VizJMtLFaNhbReuG7M+YY1lYvNDFLt8aBR2Xk/V8YmAcU8AxP7y/NDi8BG
	g9R2fOxAPAiBUnLZ6Z2BdtaiK8FIRxgMHsxffH+9UvWjk2tADagKtyG+dE1OFF8JKd3nS6tod0t
	DBc5A2ol4xuVlCCYNr2YrIdI1fCanLOanInyHdQ270sKnuRM3+VnZsVv++14PHcc5WoEHJlYAOY
	ur9jXfFVXud9Pe9zgOP1z5v+kwSa9rgLFUJMEWH/ntaTS+9/rxr9ggh2p14TwbmXRQknHRd0fKy
	xaH
X-Received: by 2002:a05:600c:190f:b0:495:39aa:1359 with SMTP id 5b1f17b1804b1-4980c66b43fmr159096595e9.3.1785750642289;
        Mon, 03 Aug 2026 02:50:42 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:41 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.3/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:23 +0100
Message-ID: <9513165effed465acb633eb0152f98dd870b7bf2.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

reject root commits

We do not support squashing down to the root commit yet (we should
probably require explicit confirmation if we ever do support it to avoid
nasty surprises) so error out if we see a commit with no parents. As
explained in the test, because we use --ancestry-path it is not
straight forward to trick it into walking back to the root commit.
---
 builtin/history.c         |  4 ++++
 t/t3455-history-squash.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/history.c b/builtin/history.c
index 64c9914c2f..4dcfdb109d 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1087,6 +1087,10 @@ static int resolve_squash_range(struct repository *repo,
 		if (commit->object.flags & BOUNDARY) {
 			commit_list_insert(commit, &boundaries);
 			continue;
+		}
+		if (!commit->parents) {
+			ret = error(_("cannot squash down to root commit"));
+			goto out;
 		}
 		if (!oldest)
 			oldest = commit;
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 9c362f3094..b181f93892 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -64,6 +64,18 @@ test_expect_success 'errors on a range holding a single commit' '
 	test_must_fail git history squash "HEAD^!" 2>err &&
 	test_grep "single commit; nothing to squash" err &&
 	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'rejects root commit' '
+	# create a disconnected root commit
+	oid=$(git commit-tree -m root three^{tree}) &&
+	# because we pass --ancestry-path when calling setup_revs() it the
+	# revision walk will only include commits decended from $oid so
+	# we need to give it another --ancestry-path commit to actually walk
+	# any commits.
+	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
+	echo "error: cannot squash down to root commit" >expect &&
+	test_cmp expect err
 '
 
 test_expect_success 'accepts multiple revision arguments with an exclusion' '
-- 
2.54.0.200.gfd8d68259e3

