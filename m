Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9172C031E
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792540; cv=none; b=KtJHH1MaFpglvGPZkjnlGbdBB0sX5MTNMoYQnmAgHgnOHapZkXVY+uva2c7Rf+JQ7p93FpKphZgOcJlLnLXQOT6SQ9JFskCUI+TwXJEoFwVk7Iegc4foqxgBUs7pKPQfjNvFEKhWpA4/YxXX3YztNJ072s3Zq5t6g2zbQ8qI9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792540; c=relaxed/simple;
	bh=h38ON3X3FXUSWMMB89A1ZOUhGgTmfk8O0fqo/vkasMQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HNlimgEQUwFXnl1RYStuAheAbr+ltmoDIXMgLui3FTp/VEcVvHgWr5N0svSLfy7sStliVk8GL+gXHkNR1ffqo40ZklFFq4u4bqnKSO6pVAM7U9FvvFN0qcYVqy2BbmnvC5uubCuau95gMl1QIeY3E8s7suFK1O/ktlHnucmhPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS9adqnP; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS9adqnP"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44cd237446cso1944869fac.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787792537; x=1788397337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NlBGPNrXN4aLaDSGEbnXONy+aroXs8PdfCqivjDq+mo=;
        b=cS9adqnPSo7nOIllV9i61thADAQ3cmXSa7rt3CcEOAs0Zcwzes5POGwI/YTkcpo7QI
         v51CZHfVc+U+/67DDBRCxWAeAvN2jE8dLFIjF3TII/mBcP7CjelIZYE5y3FG5X93CylB
         W1Tk+py+ewaafhXkIcUdd3QU2PV6DwaZ7LL6dcAynIORQrgsPUlSFjHpGBn77MTLSf6T
         FpiyiWKviNA1XCErbjPOtoi7B95t3kh4T4+5dQu8l/XTxLXRkPOxri8w3y+mt8LWBeMm
         M8trk+mXbFjpveJLVhVOry2cyblGTymVACEtLye3aP7zHzCYNp9gOhRF5iOqCLQueF2/
         55uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787792537; x=1788397337;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlBGPNrXN4aLaDSGEbnXONy+aroXs8PdfCqivjDq+mo=;
        b=bU4cGDztNa/c16LRF2ryRZdOqF/q8Y7MmuqdkpQd9HTC5yszBfW2YaNFEH2tRDsQuP
         Z33Xfz781Z3G4k0x6JNdQPo/OX0kKBgDB2R6WA1epPKhh9j5AaGTkxK8ht0awKun40O9
         sLbaT94hF2bJ3nyRZRoG8UA0VopjtF0WTVdtrpjFrIvpn2iyjkJnce0HZJ3CBjD2BMG1
         0PGbPBp7W8/NXCwYdQ5VVMvSUoky55ynAqOAE5UFmgjOnr+8IYUzSYMpbe4OrbfPNvLm
         KTSoFliR1xjzjNUwdaKhtw8XdtPavi0b8ysw7gyosXgmNAjfbNnnLDQ9IVA9gJKXaf4T
         sRLg==
X-Gm-Message-State: AFuF++kHaiKJ+0EW4YlSCPyCzByBlbVHfAz/q51r0suYUjAi9s3Lfju2
	YeknIVIpgM7FEYZ4hpxDtlfLJjQMVdTPOs+GGSzQKTN6tRvetomXOjLcyp4i1g==
X-Gm-Gg: AR+sD13uS9zjGfZVwC9/HUih0mUUplFu0Y4Xh315hDNMjPBj9N9UmpMSFGYxRSDCmEq
	hgCsnMdQm7Z3K40cQtg6+96IrsAdsH+zDrkFEWIKLdjqxg0vZpSVyhFN/4HKETKbl+sbJ8uslET
	KDJCUAZSQ4R80ufbFeBzqk/pQkJh2oHj2Jm6tFRfd7z0DY0C1gqkJjKQq7ZFxHp617yjCUPRSIk
	NXZtbdCOzBG0SWy2UxaXuvPlYKTfEq5E3SGQ83PV7kzQQVyud46IuJJCjdH1ELfxElr0QGq4ftf
	H88cinebF3zu+mXC9ceeSWd1Ah9d+TyASPNUTWYPxK+X1kSq2rmfNDycpsC1LvoooqLKl2yqy/4
	oZHO8y+A8ZlG6lqTvav29bg9pNmeEj3YJhybx79qB436OhmmDBeJ+sXMubm2/2JCdu2iBRmYAAW
	GR4uzZuiJAWlCTw/l+x5UXnvDnynLxIlwaCvDHafR9qUmAvmsKPYyPb+dskkpxJWc=
X-Received: by 2002:a05:6820:55d8:10b0:6b0:ae64:b307 with SMTP id 006d021491bc7-6b1a0401fb3mr8759619eaf.10.1787792537247;
        Wed, 26 Aug 2026 18:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1b2b74aadsm712075eaf.0.2026.08.26.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:02:16 -0700 (PDT)
Message-Id: <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 01:02:12 +0000
Subject: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When a rebase applies a commit that becomes empty, it stops and asks the
user to decide whether to keep it or drop it.  HEAD still points at the
previously-applied commit at that point, so either amending or creating
a partial commit is refused, with one of the following messages:

    You are in the middle of a rebase -- cannot amend.
    cannot do a partial commit during a rebase.

Neither message hints that the real problem is a commit that became
empty, and "during a rebase" is overly broad besides -- amending and
partial commits are fine at an `edit` or `break` stop.  Reword both to
describe the actual situation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c              | 4 ++--
 t/t3404-rebase-interactive.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..0d908d72bb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -521,7 +521,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
 		else if (is_from_rebase(whence))
-			die(_("cannot do a partial commit during a rebase."));
+			die(_("cannot do a partial commit while resolving a commit that became empty."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
@@ -1334,7 +1334,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
 		else if (whence == FROM_REBASE_PICK)
-			die(_("You are in the middle of a rebase -- cannot amend."));
+			die(_("You are resolving a commit that became empty -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff11abb2f2..1e78dbfd90 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1868,7 +1868,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
 	) &&
 	echo x >file1 &&
 	test_must_fail git commit file1 2>err &&
-	test_grep "cannot do a partial commit during a rebase." err
+	test_grep "cannot do a partial commit while resolving a commit that became empty." err
 '
 
 test_expect_success 'correct error message for commit --amend after empty pick' '
@@ -1881,7 +1881,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	) &&
 	echo x>file1 &&
 	test_must_fail git commit -a --amend 2>err &&
-	test_grep "middle of a rebase -- cannot amend." err
+	test_grep "resolving a commit that became empty -- cannot amend." err
 '
 
 test_expect_success 'todo has correct onto hash' '
-- 
gitgitgadget

