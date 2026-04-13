Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59603939AF
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124607; cv=none; b=XrmC6Tr8limzIpyGfdH6FyiW4ppsSh4A4IIxJ4e4I6d1yFi3+ePL8GKz5CbGnRqDm0XhMSs70IIX/Pp/MPQ5fdGjV+oMjSKwv1svFN0nGjpb1lpxece1tStc2W5yoH7Zf38XxTQXhFdrEeSuqdjff0CXAzDJQhQrt/rBeiQeI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124607; c=relaxed/simple;
	bh=IBUJZ1klIykPCIXaQAcZLTuiGcLwAvV/YRl+uRy4eJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI/wG/5KxNN0sqtgu4rcW08uxEbmb2TM5oVgkCxALrlD20NAdiZC8EMkru4VO9r2j47gYLAQNeFGHJ7Qaix6T206IGTYZm2IjwIqTSXUkp0WMenc6dYtsUNMV6LOEjwn0+mFjCHGAWH9Lp20gpt8fopQPPYeibRcH5/SUnKkDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aTVA5IRO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aTVA5IRO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso41558877b3.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124605; x=1776729405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gt/A3+McdeAUa/70OC9uE2Tgzm/SMhqbBe1EHBSU79g=;
        b=aTVA5IROFAZUVhvaMdj/OK3IW9UL9zViO0AeumTDZkmKaQx+WHMnHsMSFGOedHE9oR
         w5rv9TEBnBuw9CLN7jHLhgY130xProCYiiY77OTnREtD+hHjp+n78ghqWalH3zQhNj87
         88daSa9QBKsde2bgcIIJQNE7IH0FGVF9iNKQBnyF2w742x4XsjA88ZVxakeML5uaSKnF
         7Lbo6XAM2jBmTcySuDRSeGA+888PnFCKgd+C81dFIH4FxJOW+DAPzkhbeulDCnuFEp35
         ovwlFIua6isRzcih95Jli+y9mA4+KHIVMB55N0nLhjXjouk2gFDbCnP0Xd8VW1kB9ouC
         fzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124605; x=1776729405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/A3+McdeAUa/70OC9uE2Tgzm/SMhqbBe1EHBSU79g=;
        b=V7q52JU9qh2SqX0MlHt2Bmo6K0kfNV6OLt3fROTsASSfYmrwBlFqk1iVZBoeCNsdCq
         qOuzWHBAD/+S73mnea9ZgZOfqON/bYrvDrXyRmP/tgaTWiRVLOiCyDZxgmZ2MFEs1wYL
         EjTjlIm/Zizpy5oJEcu7V/9ODO9EetpnFTeAdrobDSjMtx9nnghkkZcZm9u2LvfN0Lod
         QVx6C+29PosBh1bKUXudjBFzJtCnX/Q550VxwCBlKsULq8TsWr94xYTvJVPwaXzIiriA
         gVulawE1iwnFhTbOMVQMk5UVJnC3zMHPALLVt3FvzQ9WHJHqKrvV6P5xlVZG6walgouS
         D8xA==
X-Gm-Message-State: AOJu0YyWwLWhMSgNM+oohmLC0zIgijUcxp4HwxzwtLNWptbVdACNr1JF
	BVg40KQ9ZGTBje4PAjhfLiPjy/aSUxWGfP34bXuN5JQVoFeILdtQsv3OKa645EzFYPQz7IV5c+Q
	i29b2xHk=
X-Gm-Gg: AeBDiesVw4FmDyKwGbTYizAfaBZanmnPkM3avkzW7hx4lig0QkKoB5nLjsVWez1GagV
	icXv9fhAY6Hotc+Nl68VDd3+gYT7GfC9m0sz1tmbpbVV0pmnBvW+Suw2B1xDTmITFO4s8YGEsyg
	NkwjEHSUT9lcDJhfV80we+9ZUNhIPgkFdajmY0m3Y/jC9pcDhWtKn5PnIqF5pVnFtTt8VcUQawa
	rpw6bmP9sIQ7XIx75dBzvP4m2gpfR1NvCdF+GoHHpCUU6fkan49zZ265iJP8ZRQPILaEm4fXGRE
	u+sJ4GEr/nP/4E7b72oHffEdRsZL2IX6uJ8vMriBnpGM3wyTaq19b5vlT+DY+AwLD4ebVKH2wDB
	f9eHRQV4T2IdKoQXii/B2IM7kfrpIsR+AvZHjcPycs1DKzozbcRRudYDjpVWPRwNzix5jnPL+94
	KzH8DIlEp4hniM5IX5z9CDqYPRCboWFNKU2PY1QNMmuDF6j95eSz8Km4NAGRla57v7oLBb+kjZ1
	SVxRaXKjgGLqt0itdTEiVlyMhdci6X/SPdKpIwNS6CMq19uMockUpMZm1NJycJLFzyaCjtZ1LcS
	RWGddw4KbKPEOfuU8ENP0+v8huA=
X-Received: by 2002:a05:690c:6609:b0:7a0:afb5:6876 with SMTP id 00721157ae682-7af70f92567mr158861317b3.31.1776124604721;
        Mon, 13 Apr 2026 16:56:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d0c6967sm57957197b3.18.2026.04.13.16.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:44 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/8] t5333: demonstrate various pseudo-merge bugs
Message-ID: <f4899b668e229069a10d7fc627835dbdc12d7b39.1776124588.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

Using the test helper introduced via the previous commit, add various
failing tests demonstrating bugs in the pseudo-merge implementation.

These are all marked as failing with one exception. The "sampleRate=0"
test describes a latent bug, which is only reachable through a code path
that is itself masked by a separate bug. A future commit will fix that
bug, and, in turn, cause the aforementioned test to fail. Accordingly,
that commit will mark the test as failing, and it will be re-marked as
passing in a separate commit which fixes the once-latent bug.

For the rest: the following commits will explain and fix the underlying
bugs in detail.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5333-pseudo-merge-bitmaps.sh | 198 ++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 1f7a5d82ee4..20e77ab4390 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -462,4 +462,202 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 	)
 '
 
+test_expect_failure 'apply pseudo-merges during fill-in traversal' '
+	git init pseudo-merge-fill-in-traversal &&
+	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
+	(
+		cd pseudo-merge-fill-in-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/tags/ &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 1 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+	git init pseudo-merge-fill-in-multi &&
+	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
+	(
+		cd pseudo-merge-fill-in-multi &&
+
+		test_commit base &&
+		base=$(git rev-parse HEAD) &&
+
+		for side in left right
+		do
+			git checkout -B $side base &&
+
+			test_commit_bulk --id=$side 64 &&
+			git rev-list --no-object-names HEAD --not $base >in &&
+			while read oid
+			do
+				echo "create refs/group-$side/$oid $oid" || return 1
+			done <in | git update-ref --stdin || return 1
+		done &&
+
+		git checkout left &&
+		git merge right &&
+		git repack -ad &&
+
+		git config bitmapPseudoMerge.left.pattern "refs/group-left/" &&
+		git config bitmapPseudoMerge.left.maxMerges 1 &&
+		git config bitmapPseudoMerge.left.stableThreshold never &&
+
+		git config bitmapPseudoMerge.right.pattern "refs/group-right/" &&
+		git config bitmapPseudoMerge.right.maxMerges 1 &&
+		git config bitmapPseudoMerge.right.stableThreshold never &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+		git rev-parse "$base" >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges with overlapping groups during fill-in' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-overlap" &&
+	git init pseudo-merge-fill-in-overlap &&
+	(
+		cd pseudo-merge-fill-in-overlap &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Use two pseudo-merge group patterns that both match
+		# refs/tags/, so every tagged commit belongs to both
+		# groups. This exercises the extended lookup table
+		# path in apply_pseudo_merges_for_commit().
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+
+		git config bitmapPseudoMerge.tags.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.tags.maxMerges 1 &&
+		git config bitmapPseudoMerge.tags.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+	git init pseudo-merge-date-classification &&
+	test_when_finished "rm -fr pseudo-merge-date-classification" &&
+	(
+		cd pseudo-merge-date-classification &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Configure two pseudo-merge groups: one that only
+		# matches "stable" refs (older than one month), and one
+		# that matches all refs. With 64 freshly-created tags
+		# (all younger than one month) the stable group should
+		# have zero pseudo-merges and the catch-all group should
+		# have one.
+		#
+		# Use GIT_TEST_DATE_NOW to align "now" (and therefore
+		# "1.month.ago") with the test_tick timestamps so that
+		# the commits are within the last month.
+		#
+		# This exercises the date-based classification in
+		# find_pseudo_merge_group_for_ref(), which requires
+		# that commits are parsed before inspecting their date.
+		git config bitmapPseudoMerge.stable.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.stable.maxMerges 64 &&
+		git config bitmapPseudoMerge.stable.stableThreshold never &&
+		git config bitmapPseudoMerge.stable.threshold 1.month.ago &&
+
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+		git config bitmapPseudoMerge.all.threshold now &&
+
+		git rev-parse HEAD~63 >in &&
+		GIT_TEST_DATE_NOW=$test_tick \
+			test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
+test_expect_success 'sampleRate=0 does not cause division by zero' '
+	git init pseudo-merge-sample-rate-zero &&
+	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
+	(
+		cd pseudo-merge-sample-rate-zero &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.sampleRate 0 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in
+	)
+'
+
 test_done
-- 
2.54.0.rc1.73.g8f4e0170952

