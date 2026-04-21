Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E67260F
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749649; cv=none; b=ZtiRwSlDM1pQP+Vv87+jcJvmTwn781NCGHlobIHtkFWJ9bLfPfXZY7wjsmOqA9s3zdb5eizi+5l3l6cGZ+ji+BciRbCVXJoXYueZa1zUxOWvR/kBeivvZMtxsYWKT+ePyL1uSSZ3FFzsG5qinDH7vZnkQyqe/sw6JRLIz7qee9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749649; c=relaxed/simple;
	bh=t4SAiHXAnKPI6fDfByIf/+FadUj2WQV09lmy4KKu+NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBqF0cPDjSS+Bm/cuk9JLVUI3BshNZsLuiNQyz0EDDz3NDg4uygcOFL3y5BqL9h9/FWV1z7os3Xk0VSWSOQfOxPPS6116kLy65pmcpFN+BfvsUoWUYg1C+pJSZdmQm2AutdWIpSfSZQ5XRbr5/jlKXADoKf92Wn5DWslCDWTRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiyDd0n2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiyDd0n2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2539094a91.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776749647; x=1777354447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vvy6UWyOIkxMUcSKKB54WuggSt+eQXt1lfKricpRdw=;
        b=GiyDd0n2yxLGtRF8pJZYTyxq8W+ahIHkZI/3hPCi/XqiwUGHWOdAaR3nX3eVQRUWmC
         em7H2FFyxpRz2rsANHbyc4HHH+8suLGd3iV7B6DMs5y7qjVYyDJCqb2a6l98NqvmNCeq
         k6OYtzNtk8rZ9zVO1jamGxwjy/l4rSSTFmEt+HFyyFXP5OLLYEM9Dcm5OdGvaaATM720
         bCFuK3HGz0vbTquITIvLUEaSVJeQ9RmfWrk69vjhySiz2G0aFTyajPKsLrrbckM+m67v
         hlQe3AamEoE/qYb+QpfEDuar1kFVvRdXKsTAnLb59MyY0YKhEaKr8gYDF7v4xQeth7w3
         Ba7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749647; x=1777354447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Vvy6UWyOIkxMUcSKKB54WuggSt+eQXt1lfKricpRdw=;
        b=Zt/P5Vh9ELJnMKSxVu6LS2m1BhkHlmizg3V897WRFkRqc6F8/56dAQ076ULkwu8dAq
         uAm+fMqPLRpa0faBYTo0jsHYW4UFzZDvl1a/vMqC8VaVBErdNRhRLI15SF51RW/ABZLy
         zpiILO1AuIvUIP+Vt5w1QsKgNOl9/M92HyjZ6LeQzT75SvbGohxebAfAEWunxSJZFbIK
         hIvDGFynbkqC0VY2lWgD+JCxS49j283xkxTr1s7xH3M3A8KsircYvmAEsh5xKxfEieFV
         tV/B1BFx3Xbn1KCtEwl9mLhUatBoyhe15ftflI7KDQ664OvRpZU1lbHk37ZsWlAH82n7
         o2ZA==
X-Gm-Message-State: AOJu0YyNKJvvilacS1pc20JGKM2+XGmAsGR5T4iW116Ufrh9ArqlyaTp
	n8bpm3NFfcjlDPP/4xOjyIsuIRPYH5WheH/sOm7jcEpBeioYCyTK5835XvXC/A==
X-Gm-Gg: AeBDieuq/EcdseHlhlQNzOi+gfyw5dmvNgVHCpeLkCl3+zyo+9yp8lCVI9khRZEIX88
	5UgpZ4qruC1yidS1CGZVprScE4AFSU3lYqSM0+7BYDLmpz0/YAab5C/+2xWukfZoK1JV79JCswT
	TzwN94RG/uy/8mkM4S+6DGeahFzcUkkoon3tRm6dCLdIngWm615GG+soEX2BLZCaiATYBGulzvr
	EpYSrdnawq2919oV594uaHw3bMRgBps6frwe4qvA5T/mPJbK9ylprAW9OhRcAhSm0hLPvpQqt66
	Ds/72jdjOvcD6AJJraGUOnC+05bPga7AQaAMt9ve5Nk6LhR274nq5ai374yEzgBsek8yE0Wjfyn
	+iRQ3S71bNt6Q9c7JqykwOzsCrTkqlilgOtInmSpxT2AU29HDYzDbzt8y0dkRbwyE+4jPzwQeM2
	9i60FOZR85I4KLoGXJRcwPoEOlDYZllTJKTUQ4oUcu9Vsr3kmQVGa5JD92fp6PTrxMTeF9fp16+
	uM/3LcF848bhncjjtfX0/XvdQnzpSr7ez3/VH04c2QSPAm+cjgFxbs7QHNwAiUKDnkfSfk+E1Ah
	ivo=
X-Received: by 2002:a17:90b:2686:b0:35d:a3b4:2ef6 with SMTP id 98e67ed59e1d1-36140494b8amr16769107a91.21.1776749647301;
        Mon, 20 Apr 2026 22:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0a5:e9e6:3079:1553:266:991])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa91d31sm6454484a91.2.2026.04.20.22.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Apr 2026 22:34:07 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	abdobngad@gmail.com,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2 3/3] t7004: avoid subshells to capture git exit codes
Date: Tue, 21 Apr 2026 11:03:34 +0530
Message-ID: <20260421053334.5414-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
 <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tests in t7004 use the 'test$(git ...) = ...' or the '! (git ...)'
subshell pattern. This swallows git's exit code. If git crashes
(e.g. segmentation fault) the crash would go undetected, and the test
would fail due to a mismatch or an inverted exit code.

Modernize these tests by directly writing output to files(actual) and
verifying them with 'test_cmp' or 'test_grep'. Replace subshell
negations with 'test_must_fail'. This way, if git crashes, the test
fails immediately and clearly instead of hiding the error behind a
string mismatch.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index bef7618da2..d918005dd9 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -155,8 +155,10 @@ test_expect_success 'Multiple -l or --list options are equivalent to one -l opti
 '
 
 test_expect_success 'listing all tags if one exists should output that tag' '
-	test $(git tag -l) = mytag &&
-	test $(git tag) = mytag
+	git tag -l >actual &&
+	test_grep "^mytag$" actual &&
+	git tag >actual &&
+	test_grep "^mytag$" actual
 '
 
 # pattern matching:
@@ -166,11 +168,15 @@ test_expect_success 'listing a tag using a matching pattern should succeed' '
 '
 
 test_expect_success 'listing a tag with --ignore-case' '
-	test $(git tag -l --ignore-case MYTAG) = mytag
+	echo mytag >expect &&
+	git tag -l --ignore-case MYTAG >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'listing a tag using a matching pattern should output that tag' '
-	test $(git tag -l mytag) = mytag
+	echo mytag >expect &&
+	git tag -l mytag >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'listing tags using a non-matching pattern should succeed' '
@@ -430,8 +436,12 @@ test_expect_success 'listing tags -n in column with column.ui ignored' '
 
 test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
-	test $(git cat-file -t non-annotated-tag) = commit &&
-	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
+	echo commit >expect &&
+	git cat-file -t non-annotated-tag >actual &&
+	test_cmp expect actual &&
+	git rev-parse HEAD >expect &&
+	git rev-parse non-annotated-tag >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'trying to verify an unknown tag should fail' '
@@ -1520,11 +1530,11 @@ test_expect_success GPG 'verify signed tag fails when public key is not present'
 '
 
 test_expect_success 'git tag -a fails if tag annotation is empty' '
-	! (GIT_EDITOR=cat git tag -a initial-comment)
+	test_must_fail env GIT_EDITOR=cat git tag -a initial-comment
 '
 
 test_expect_success 'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
+	test_must_fail env GIT_EDITOR=cat git tag -a initial-comment >actual
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
-- 
2.51.2

