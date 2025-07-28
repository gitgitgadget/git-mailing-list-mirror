Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CE13AF2
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732121; cv=none; b=GrjGB3Q1TOJTsmeMhECGso0/n2HIHI5pVO8CGQR/ncRtuHBcVgRI6aUTF+y7LABH5NUoeFepsQMHekvSsWnavEz5mwAhanjfugt96fhsXIsPm3/+/5/S93g96el/Q4fevl1oPD3Stag6vntG2d2rtP2iVK3lQIveRvpsPaQrHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732121; c=relaxed/simple;
	bh=rsqra6uAPLcXvkquxlVwMZRicVNeJ5lrlrLZVGXYbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+ENdlenQB6KqxUKqX5q1ZhN5WV/nXx8NRCwCxAReUxB3brYajNdgUgJqi3q5GSCnolrS1hxixoFi03Jbf3+OJV9zDmD3fGM4X2diJ82aA0wWy30pckU78+5Q7VyCkDXJsJ7dZDaJcHUDvCYx81ZAHStOkZadq/Be/POZjhwq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icTbGuiP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icTbGuiP"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e5e3c6a37so2910413a34.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753732117; x=1754336917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG8rW9skXn6larGMzAXjDFJCyIZyRbga7hNjIaD2/NM=;
        b=icTbGuiPsIr8K+1ZiggA+Ewb2/sxwfR2Q/AG1sPzT7/8dF6yrUhoje3mCpW1o3sqM8
         qtyMPWeegZSlYqUToRBwohi+W8z+DwEBV3jgESpzT49cWWi2WPMg/seM4uxbKCimBfn8
         nPO6dAOFKvusaKYo6SeSE3ihFZszz58Sa2EUvkZoBgJZCheKnRTGJlyyXtmuHQLl+S/Q
         6MrV+SSnXSp+cUOuqsTWa+D8NAQNciBxosVTO1x6FHSJ0qQqxiVa4jBbkQcFUksBTdNL
         +e9vyRqX/4wBSYohxGOSjogHPPyY9aFTzgty/XNPllO7ZkmeX7tMKSo0WdNVkpxMrI9e
         7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753732117; x=1754336917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG8rW9skXn6larGMzAXjDFJCyIZyRbga7hNjIaD2/NM=;
        b=kQ3sDgKjVTP7Aq9tVjKjDCIk2S4WlM2FG8UZ6J3wfxlwam9Q+H11oaM5IdjJM+ndyl
         ySvxUIGpLhxUCK+erJSlCH3rk52EqlReqJWpA3GhedDVuYgjFJPfAOcxuvjF895qGZmS
         QhnrhTVNnwygOGJToUS6arGL3plaONpS/SxKyqTkz8LBeY68PXJeKKCHTKoRbfSqCV2b
         9xp92tuB5VyMWBtG9XwNb86TmsT8r6U7cmEH+YZz8OYKULWRX7wgGh36S8QFctAHy0ms
         jlqSZ9ifqJw6wqOpi8YZHnPnxeIlNeEeEoKCDfr4lHjLngPVvTWohffvbm9rDursf3y+
         POrw==
X-Gm-Message-State: AOJu0YxRnA4dLQX/hb8Ri+kT578Xgd7NJED9vqB9mVYHIaE2J3Uk7TMc
	XsqLkZ2W0oraudyUn9nrkXotFHg/uylz+xXgGaZVSPJRYeamCABksRpw69kZVg==
X-Gm-Gg: ASbGncudQaoYPnLQslj1LPDk9QwKFOKEoPSHzqrIMcsKsPPId/0SupKgUsKONU454Mj
	Vg8R5n8dzgXqm4Hi7WAn1AYuzLPHkjoPQF/+Wf1tvo2zKS4ENzdx2JmWWPhNKtyBJHPBHi9GYrQ
	uYzLvixe6b8I8N780W8lJe6TDQYVSQGlzvP5mTYv3IiqxhI3zYFH2eYJ/P4ryWVCzRdpMTH4FeJ
	PCX92D2ns4QdtNiAp+D/TGwUrLK0ZtL8L5PtQJHpqO+wpIi4662NSHiZO5g+gi2Hwen0ZFRM8ff
	qdGvxZXhgT5dStzVRQS9N/D+vTLxQKAUK9RIL2rE/e2U7QZDrtBIwphvMtWLpAZlRlXjfWyGfQf
	4obJrf1Wzbjd1XCnOmUxolm8cekAw2QnDGew8Cj3L
X-Google-Smtp-Source: AGHT+IF14w3BOBYJzQ6MSrjfqFy5OR87dr8O/QzNB0B/QHcN3fn7XK9ndurM4fcBBJfC1kjHzkUy4Q==
X-Received: by 2002:a05:6830:25c1:b0:73b:1efa:5f6b with SMTP id 46e09a7af769-7413de94ab9mr8455273a34.14.1753732117124;
        Mon, 28 Jul 2025 12:48:37 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74147f4c6c8sm1198119a34.4.2025.07.28.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:48:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] builtin: unmark git-switch and git-restore as experimental
Date: Mon, 28 Jul 2025 14:42:18 -0500
Message-ID: <20250728194218.2379432-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.50.1.214.ga30f80fde9
In-Reply-To: <20250722180818.1043014-1-jltobler@gmail.com>
References: <20250722180818.1043014-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 4e43b7ff (Declare both git-switch and git-restore experimental,
2019-04-25), the newly introduced git-switch(1) and git-restore(1)
commands were marked as experimental. This was done to provide time to
make breaking changes to the interface. It has now been over six years
since these commands were implemented and there hasn't been much change.
Consequently, users have grown to rely on how these commands work and it
is no longer feasible to make any breaking changes.

Let's remove the experimental label for git-switch(1) and
git-restore(1).

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-restore.adoc | 2 --
 Documentation/git-switch.adoc  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 877b7772e66..3763a7f4f43 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 `-s <tree>`::
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 9f62abf9e2b..87707e92652 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
 however if the operation leads to loss of local changes, unless told
 otherwise with `--discard-changes` or `--merge`.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 _<branch>_::
-- 
2.50.1.214.ga30f80fde9

