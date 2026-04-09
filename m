Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95692D7D27
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710780; cv=none; b=YdFWK+a+2P1oK6Tlb7J3YgfkeEspM7ymhYkeFEjQB4DQRiyacEgMTfE3wHy2ppHA8YS8sSt6YL48Vo6XI9YxK6RCvYpi4Zu+HSfskc21oSKQRqVzmo7nJW9r12bT0swbcx06V+BvpaiwN81DxJZiLLAHl+gk6Y8pWSzUpR+mX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710780; c=relaxed/simple;
	bh=+0VeIHqwzwZmptq94LAw7RIKI8hY/dS2wdaSgzM96nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N5YKOyOP9mbp4nXlEPyvMv/2XbotKUecODg24xN/RpBsQO7nTc3wF/6bXWgAIIdVyywjsfUVGc2oiQB8+6bE8uEEnfh+8juqE8JG5dS2YGylYhoNL3gp7gdQ2+CQsC/axMJ+vwN2N+xZVCSpRbxQDMA7TypBe4oUT8KpbSsiddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNYoVze+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNYoVze+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a58057d7baso6016656d6.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710777; x=1776315577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6J2UP+JFyOl8pGid9gElHAR0aN/3eruWN5LN76LVLk=;
        b=eNYoVze+Cu2TIajAcuNbGhHfjq6L2G0sQvUuoFM2yP7iQnBeRZmdDBddsVHBKJC/GC
         ZxPgLUvaOHCts19m6klw5H5zhpoLGfrQC8INYXSnzhLp+Ez3QykXsbj/F2Hh2JVBeKWr
         Bz4HzMzL1WZ/j1xm60WPaaYHT+iDI/sQY0k6dV84XxSYUn8Dfxb779mwPFx9UVLo4DGi
         yPk+HsqOc4ezWzDiC334sBfCFaqdr89ULTxnYiAdq1DlSKFPLK7OULb/3BKtfKboHsW2
         RdUeGJWe9OM+eE1mf/oy3Xl5rKs2DKo10x4GIX+lWzGb4KB5gmlyW/bvK45nUM6G9ssJ
         v5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710777; x=1776315577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6J2UP+JFyOl8pGid9gElHAR0aN/3eruWN5LN76LVLk=;
        b=ejsSGtITYP80wodCbgdubJ3EMp5FEma8ryy79V31PORtOcl0LHif5TyuLCGQQI8HnJ
         Ef6QQEAF+XFWpfPpJTLf0DLELyeMlM9BbbfnmJq1lM4U1FGeRn1jHea1A5dOF3EynWtV
         +drtVPdTb8c2ZIUcoOIQyD+uJadbmI9m7BXO0xOgdERwauNNYk0+ELl2KDd9Wcm+X/Cd
         U97nsa+ucDc5gzZPNeYLkYGynZPwCgbeoSJe5ZKYdgA/FvAs5MyxquTKQh9lDbD+3mhg
         LvFklCl1RkCvXM8h9a0SwJojq3H9L8nIMrTiiBcfSwU7lqKxoMaZIuvYdN+34KwAkImQ
         iEnw==
X-Gm-Message-State: AOJu0Yw7FM1rjA3o7mq4BYSKLDjjDat8mmpd6pqHSoPC2I9b3qvcTdhd
	yYej8ujcx8f2WoUSuAnHPL6TIDFfAO6LsBIUzXpO/DNHOkfwcsqL1X+fcbRrUA==
X-Gm-Gg: AeBDieusR8opqgd2jppP2v2EZIW+JTiqFAMkfdqq57kdnbB/lgrmXHOn416whbPVM1e
	SNrae1LlFPm55MHQbLIHuwIbQ205TuVVICOpVg5RLHQ8l++GmB/2KdMtciV7O5DWAIEney5Pxop
	sSAE97Y5nrEUbwf7obsif+0l2lo/QL6q/1SFb90TOPf1ff6MyejKMctLkw0ja3DW/vMwZ83I2r1
	RGAzRXkg5NdSpwtPSp171pP6tXdiseqz7EMAYQv6cGuMJLA/AaxTrET8ZpTuCFCtKSRwqFati1a
	rPRxSwkojg2Nez2uQpX6vv+mVCBye3tgWHvKi5QPI3hNmchEkKQmOYUNZpuYTIBIaVTBFCEx3pX
	LRM5x7PMZvZYzYhDsknTyzIH3D55HC0natwbTs31WI0yLaFdVmtaXNSKqKrI2ZZPppMpwvT6QIK
	PFo5lAnomSZS0Ycao3pF0qOkdjOjY=
X-Received: by 2002:a05:6214:27ee:b0:89f:6757:aa6e with SMTP id 6a1803df08f44-8ac7421d426mr39482346d6.44.1775710777303;
        Wed, 08 Apr 2026 21:59:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593330593sm211183196d6.3.2026.04.08.21.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:36 -0700 (PDT)
Message-Id: <721a95142337db84209fdfe76b2fe34c98ed34ee.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:23 +0000
Subject: [PATCH v14 01/13] t9210, t9211: disable GIT_TEST_SPLIT_INDEX for
 scalar clone tests
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

index.skipHash (Scalar default) and split-index are incompatible:
the shared index gets a null OID when skipHash skips computing the
hash, and the null OID causes the shared index to not be loaded on
re-read.  This triggers a BUG assertion in fsmonitor when the
fsmonitor_dirty bitmap references more entries than the (now empty)
index has.

Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
this: tests 12, 13, and 22 in t9210 (matching the existing
workaround in test 16), and all of t9211 (every test does scalar
clone).

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 t/t9210-scalar.sh       | 6 ++++++
 t/t9211-scalar-clone.sh | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..f2a6df77ce 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -152,6 +152,10 @@ test_expect_success 'set up repository to clone' '
 '
 
 test_expect_success 'scalar clone' '
+	# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+	# incompatible: the shared index gets a null OID and fails to
+	# load on re-read.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -182,6 +186,7 @@ test_expect_success 'scalar clone' '
 '
 
 test_expect_success 'scalar clone --no-... opts' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	# Note: redirect stderr always to avoid having a verbose test
 	# run result in a difference in the --[no-]progress option.
 	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
@@ -307,6 +312,7 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index bfbf22a462..2043f48a1a 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -8,6 +8,11 @@ test_description='test the `scalar clone` subcommand'
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
 
+# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+# incompatible: the shared index gets a null OID and fails to
+# load on re-read.  Every test here uses scalar clone.
+sane_unset GIT_TEST_SPLIT_INDEX
+
 test_expect_success 'set up repository to clone' '
 	rm -rf .git &&
 	git init to-clone &&
-- 
gitgitgadget

