Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968D14A4C6
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252421; cv=none; b=ujaHFEfA3S6gYEcLjoa7U8npjyyJgQ7KqdgyULGnOaChEjY4YfPuWaW/So1i/NdPcyqR4Uwb+qUDqYdgf/3PR9W4w/jWUiDtBPLXULln8jLdh4s0QTnPpcktIwjXPqXphUNn7hwdbS0D5mR0uCrHXw3L+K8miKaRfrqfGq5Vyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252421; c=relaxed/simple;
	bh=43A7NGtKlP6KbXiN+qMR9+HF7Pp08wMfPX4fMM3Sm5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuZlS4MF9Dtnkt/xbejep/zsW8po+KK67CKvebUawfYHB/zncmSAhPksxrev9O8or0/sVXgJ8w0HWdckpvE17tqeNlSPvSTfY4xK4g4/spuzMJqwu3YfUbq924EgtLNsX8tRRlZkVZ7IEnxZ3IE3gzOQxxYwDePp3sVOO97rllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OdtXZUPT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OdtXZUPT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c56321b22cso509541385a.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252418; x=1742857218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLBmvjU4HjUgiBFZ3WorYsYR47/baowBM/NikWq7mF4=;
        b=OdtXZUPT6VrQm8omtAkcKs1QuGO/CtTvi9FhvPauZSIP0TEg+IBH9lQ5mBuCux6BkT
         0YyA6xgjwDEu06E0496AR7PdFjc0LYgTFUSlFiXE/8d78xhpjg0JoG8dQL0OcJi/XA1g
         XVlSDM+syMpLgmCWyfJkBQsrm/k7l4eDw2hR/jpRnAYfnydWqoKyFEER4JhPu0Jy/msL
         t0ZlqaiqgIUc7GpWLlUGU6otOzNxZksdAwbnmNJqtU51IzGl6hzh2SqtDdXfQvYGRSry
         dHjvRpjAOu8fI4lg3RVNfG8PW0RR4aPYpUoqepLzBIq+VJB6x81ZE/VDPC9EksvJ5Vew
         wdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252418; x=1742857218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLBmvjU4HjUgiBFZ3WorYsYR47/baowBM/NikWq7mF4=;
        b=PSwCQsoK7Vge503C7OpbxD7nu1Dr3yDt1IsIy6CYWhDQ8jsBP7lZpfhk3MuphJS13I
         2M0Ba4IS2o3EgsY02mV81QUVBh24aZBNs/+e3d1VXgb2p1wnAlV8eeyux0+nZMP3Jd8H
         8+2bkRAMGs1c4RfltHBayE0yncixu+cUaeM/VmCyBeWuHKSpkjpxqa93siFd4bFJcUOM
         GB+AisH5sGFV49tM0lYQdL7/HjCnxqq2MsRGMt4J8lTBHVP7H9WERoq43xZxssvz8O3E
         BkgXTXWO8ydGR4Y2r0EZvlT25h076vI/C/PuOtetwRmfpYw3/2uNRy/fBa6nc/+nItaI
         XWhA==
X-Gm-Message-State: AOJu0YzdNi3ftnm+AyJUZqTUSGXpiY0i347Gdt4Rv+2Sn+oT6NfI+7AA
	uMsuiMKGNjw+Uc8WaCpd+589YqammRIbRa7gbnfJAlpsnxrmW1TIgoxWQjeOwezlJuVIfWMjohp
	SstE=
X-Gm-Gg: ASbGncuvYdnZBPfN7hWWFZo0Pxl8tCP2P0izFrsFnQQucOam5wnrGraI+bNuV4S4gJB
	7oBbKA5IvNeqjxneHCEwLcLJ4jMN386NJmLrZDk2kPQfFX1EL4kYairJJhOp0YD50XMsedI0iqG
	ZSnUsGh7KkKrrqJVuvmgUgWtRd54KaL7N3MgwHDr77jb+5dVLh1nxXfpE595wAlDN8VUO2BRT5J
	GYUKg7+LDRx8P2BV5fPiHEy7vpe43Or3XQ70QO5BsCTRU8wyhOao+vErZxq6Gk9R8eNzW8l6rV9
	aDfXI4uvaJ0TkkDT3N/a2bePGBHUhHiEA4zRhOJFImI15yRDX5LdE3OR61+1rCCtwZ9qGizVA1n
	YgDLT3oElWrkYkxET
X-Google-Smtp-Source: AGHT+IG27kSjDOcMBcs7RYRRmKwFhaWxP/XesqpKheX2hv/CKJqGTX/jiGb/dTBQ94CAMP3LoS90Dg==
X-Received: by 2002:a05:620a:1a83:b0:7c5:95cb:59ac with SMTP id af79cd13be357-7c59b88b89dmr212128585a.28.1742252417871;
        Mon, 17 Mar 2025 16:00:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d9250asm636392985a.113.2025.03.17.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:17 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/5] t/t5329-pack-objects-cruft.sh: evict 'repack'-related
 tests
Message-ID: <0aa8aa65c130fd62d38b4944c1ce2a97451b0064.1742252411.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742252411.git.me@ttaylorr.com>

The cruft pack feature has two primary test scripts which exercise
various parts of it, which are:

  - t5329-pack-objects-cruft.sh
  - t7704-repack-cruft.sh

The former is designed to test low-level pack generation mechanics at
the 'git pack-objects --cruft'-level, which is plumbing. The latter, on
the other hand, is designed to test the user-facing behavior through
'git repack --cruft', which is porcelain (under the "ancillary
manipulators" sub-section).

At some point a handful of tests which should have been added to the
latter script were instead written to the former. This isn't a huge
deal, but rectifying it is straightforward. Move a handful of
'repack'-related tests out of t5329 and into their rightful home in
t7704.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5329-pack-objects-cruft.sh | 250 ----------------------------------
 t/t7704-repack-cruft.sh       | 250 ++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+), 250 deletions(-)

diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index b71a0aef40..60dac8312d 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -360,43 +360,6 @@ test_expect_success 'expired objects are pruned' '
 	)
 '
 
-test_expect_success 'repack --cruft generates a cruft pack' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit reachable &&
-		git branch -M main &&
-		git checkout --orphan other &&
-		test_commit unreachable &&
-
-		git checkout main &&
-		git branch -D other &&
-		git tag -d unreachable &&
-		# objects are not cruft if they are contained in the reflogs
-		git reflog expire --all --expire=all &&
-
-		git rev-list --objects --all --no-object-names >reachable.raw &&
-		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
-		sort <reachable.raw >reachable &&
-		comm -13 reachable objects >unreachable &&
-
-		git repack --cruft -d &&
-
-		cruft=$(basename $(ls $packdir/pack-*.mtimes) .mtimes) &&
-		pack=$(basename $(ls $packdir/pack-*.pack | grep -v $cruft) .pack) &&
-
-		git show-index <$packdir/$pack.idx >actual.raw &&
-		cut -f2 -d" " actual.raw | sort >actual &&
-		test_cmp reachable actual &&
-
-		git show-index <$packdir/$cruft.idx >actual.raw &&
-		cut -f2 -d" " actual.raw | sort >actual &&
-		test_cmp unreachable actual
-	)
-'
-
 test_expect_success 'loose objects mtimes upsert others' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
@@ -470,219 +433,6 @@ test_expect_success 'expiring cruft objects with git gc' '
 	)
 '
 
-test_expect_success 'cruft packs are not included in geometric repack' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit reachable &&
-		git repack -Ad &&
-		git branch -M main &&
-
-		git checkout --orphan other &&
-		test_commit cruft &&
-		git repack -d &&
-
-		git checkout main &&
-		git branch -D other &&
-		git tag -d cruft &&
-		git reflog expire --all --expire=all &&
-
-		git repack --cruft &&
-
-		find $packdir -type f | sort >before &&
-		git repack --geometric=2 -d &&
-		find $packdir -type f | sort >after &&
-
-		test_cmp before after
-	)
-'
-
-test_expect_success 'repack --geometric collects once-cruft objects' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit reachable &&
-		git repack -Ad &&
-		git branch -M main &&
-
-		git checkout --orphan other &&
-		git rm -rf . &&
-		test_commit --no-tag cruft &&
-		cruft="$(git rev-parse HEAD)" &&
-
-		git checkout main &&
-		git branch -D other &&
-		git reflog expire --all --expire=all &&
-
-		# Pack the objects created in the previous step into a cruft
-		# pack. Intentionally leave loose copies of those objects
-		# around so we can pick them up in a subsequent --geometric
-		# reapack.
-		git repack --cruft &&
-
-		# Now make those objects reachable, and ensure that they are
-		# packed into the new pack created via a --geometric repack.
-		git update-ref refs/heads/other $cruft &&
-
-		# Without this object, the set of unpacked objects is exactly
-		# the set of objects already in the cruft pack. Tweak that set
-		# to ensure we do not overwrite the cruft pack entirely.
-		test_commit reachable2 &&
-
-		find $packdir -name "pack-*.idx" | sort >before &&
-		git repack --geometric=2 -d &&
-		find $packdir -name "pack-*.idx" | sort >after &&
-
-		{
-			git rev-list --objects --no-object-names $cruft &&
-			git rev-list --objects --no-object-names reachable..reachable2
-		} >want.raw &&
-		sort want.raw >want &&
-
-		pack=$(comm -13 before after) &&
-		git show-index <$pack >objects.raw &&
-
-		cut -d" " -f2 objects.raw | sort >got &&
-
-		test_cmp want got
-	)
-'
-
-test_expect_success 'cruft repack with no reachable objects' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit base &&
-		git repack -ad &&
-
-		base="$(git rev-parse base)" &&
-
-		git for-each-ref --format="delete %(refname)" >in &&
-		git update-ref --stdin <in &&
-		git reflog expire --all --expire=all &&
-		rm -fr .git/index &&
-
-		git repack --cruft -d &&
-
-		git cat-file -t $base
-	)
-'
-
-write_blob () {
-	test-tool genrandom "$@" >in &&
-	git hash-object -w -t blob in
-}
-
-find_pack () {
-	for idx in $(ls $packdir/pack-*.idx)
-	do
-		git show-index <$idx >out &&
-		if grep -q "$1" out
-		then
-			echo $idx
-		fi || return 1
-	done
-}
-
-test_expect_success 'cruft repack with --max-pack-size' '
-	git init max-pack-size &&
-	(
-		cd max-pack-size &&
-		test_commit base &&
-
-		# two cruft objects which exceed the maximum pack size
-		foo=$(write_blob foo 1048576) &&
-		bar=$(write_blob bar 1048576) &&
-		test-tool chmtime --get -1000 \
-			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
-		test-tool chmtime --get -2000 \
-			"$objdir/$(test_oid_to_path $bar)" >bar.mtime &&
-		git repack --cruft --max-pack-size=1M &&
-		find $packdir -name "*.mtimes" >cruft &&
-		test_line_count = 2 cruft &&
-
-		foo_mtimes="$(basename $(find_pack $foo) .idx).mtimes" &&
-		bar_mtimes="$(basename $(find_pack $bar) .idx).mtimes" &&
-		test-tool pack-mtimes $foo_mtimes >foo.actual &&
-		test-tool pack-mtimes $bar_mtimes >bar.actual &&
-
-		echo "$foo $(cat foo.mtime)" >foo.expect &&
-		echo "$bar $(cat bar.mtime)" >bar.expect &&
-
-		test_cmp foo.expect foo.actual &&
-		test_cmp bar.expect bar.actual &&
-		test "$foo_mtimes" != "$bar_mtimes"
-	)
-'
-
-test_expect_success 'cruft repack with pack.packSizeLimit' '
-	(
-		cd max-pack-size &&
-		# repack everything back together to remove the existing cruft
-		# pack (but to keep its objects)
-		git repack -adk &&
-		git -c pack.packSizeLimit=1M repack --cruft &&
-		# ensure the same post condition is met when --max-pack-size
-		# would otherwise be inferred from the configuration
-		find $packdir -name "*.mtimes" >cruft &&
-		test_line_count = 2 cruft &&
-		for pack in $(cat cruft)
-		do
-			test-tool pack-mtimes "$(basename $pack)" >objects &&
-			test_line_count = 1 objects || return 1
-		done
-	)
-'
-
-test_expect_success 'cruft repack respects repack.cruftWindow' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit base &&
-
-		GIT_TRACE2_EVENT=$(pwd)/event.trace \
-		git -c pack.window=1 -c repack.cruftWindow=2 repack \
-		       --cruft --window=3 &&
-
-		grep "pack-objects.*--window=2.*--cruft" event.trace
-	)
-'
-
-test_expect_success 'cruft repack respects --window by default' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit base &&
-
-		GIT_TRACE2_EVENT=$(pwd)/event.trace \
-		git -c pack.window=2 repack --cruft --window=3 &&
-
-		grep "pack-objects.*--window=3.*--cruft" event.trace
-	)
-'
-
-test_expect_success 'cruft repack respects --quiet' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit base &&
-		GIT_PROGRESS_DELAY=0 git repack --cruft --quiet 2>err &&
-		test_must_be_empty err
-	)
-'
-
 test_expect_success 'cruft --local drops unreachable objects' '
 	git init alternate &&
 	git init repo &&
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 43d2947d28..cd452040ea 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -477,4 +477,254 @@ test_expect_success 'reachable packs are preferred over cruft ones' '
 	)
 '
 
+test_expect_success 'repack --cruft generates a cruft pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git branch -M main &&
+		git checkout --orphan other &&
+		test_commit unreachable &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d unreachable &&
+		# objects are not cruft if they are contained in the reflogs
+		git reflog expire --all --expire=all &&
+
+		git rev-list --objects --all --no-object-names >reachable.raw &&
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
+		sort <reachable.raw >reachable &&
+		comm -13 reachable objects >unreachable &&
+
+		git repack --cruft -d &&
+
+		cruft=$(basename $(ls $packdir/pack-*.mtimes) .mtimes) &&
+		pack=$(basename $(ls $packdir/pack-*.pack | grep -v $cruft) .pack) &&
+
+		git show-index <$packdir/$pack.idx >actual.raw &&
+		cut -f2 -d" " actual.raw | sort >actual &&
+		test_cmp reachable actual &&
+
+		git show-index <$packdir/$cruft.idx >actual.raw &&
+		cut -f2 -d" " actual.raw | sort >actual &&
+		test_cmp unreachable actual
+	)
+'
+
+test_expect_success 'cruft packs are not included in geometric repack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git repack -Ad &&
+		git branch -M main &&
+
+		git checkout --orphan other &&
+		test_commit cruft &&
+		git repack -d &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d cruft &&
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft &&
+
+		find $packdir -type f | sort >before &&
+		git repack --geometric=2 -d &&
+		find $packdir -type f | sort >after &&
+
+		test_cmp before after
+	)
+'
+
+test_expect_success 'repack --geometric collects once-cruft objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git repack -Ad &&
+		git branch -M main &&
+
+		git checkout --orphan other &&
+		git rm -rf . &&
+		test_commit --no-tag cruft &&
+		cruft="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D other &&
+		git reflog expire --all --expire=all &&
+
+		# Pack the objects created in the previous step into a cruft
+		# pack. Intentionally leave loose copies of those objects
+		# around so we can pick them up in a subsequent --geometric
+		# reapack.
+		git repack --cruft &&
+
+		# Now make those objects reachable, and ensure that they are
+		# packed into the new pack created via a --geometric repack.
+		git update-ref refs/heads/other $cruft &&
+
+		# Without this object, the set of unpacked objects is exactly
+		# the set of objects already in the cruft pack. Tweak that set
+		# to ensure we do not overwrite the cruft pack entirely.
+		test_commit reachable2 &&
+
+		find $packdir -name "pack-*.idx" | sort >before &&
+		git repack --geometric=2 -d &&
+		find $packdir -name "pack-*.idx" | sort >after &&
+
+		{
+			git rev-list --objects --no-object-names $cruft &&
+			git rev-list --objects --no-object-names reachable..reachable2
+		} >want.raw &&
+		sort want.raw >want &&
+
+		pack=$(comm -13 before after) &&
+		git show-index <$pack >objects.raw &&
+
+		cut -d" " -f2 objects.raw | sort >got &&
+
+		test_cmp want got
+	)
+'
+
+test_expect_success 'cruft repack with no reachable objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		base="$(git rev-parse base)" &&
+
+		git for-each-ref --format="delete %(refname)" >in &&
+		git update-ref --stdin <in &&
+		git reflog expire --all --expire=all &&
+		rm -fr .git/index &&
+
+		git repack --cruft -d &&
+
+		git cat-file -t $base
+	)
+'
+
+write_blob () {
+	test-tool genrandom "$@" >in &&
+	git hash-object -w -t blob in
+}
+
+find_pack () {
+	for idx in $(ls $packdir/pack-*.idx)
+	do
+		git show-index <$idx >out &&
+		if grep -q "$1" out
+		then
+			echo $idx
+		fi || return 1
+	done
+}
+
+test_expect_success 'cruft repack with --max-pack-size' '
+	git init max-pack-size &&
+	(
+		cd max-pack-size &&
+		test_commit base &&
+
+		# two cruft objects which exceed the maximum pack size
+		foo=$(write_blob foo 1048576) &&
+		bar=$(write_blob bar 1048576) &&
+		test-tool chmtime --get -1000 \
+			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
+		test-tool chmtime --get -2000 \
+			"$objdir/$(test_oid_to_path $bar)" >bar.mtime &&
+		git repack --cruft --max-pack-size=1M &&
+		find $packdir -name "*.mtimes" >cruft &&
+		test_line_count = 2 cruft &&
+
+		foo_mtimes="$(basename $(find_pack $foo) .idx).mtimes" &&
+		bar_mtimes="$(basename $(find_pack $bar) .idx).mtimes" &&
+		test-tool pack-mtimes $foo_mtimes >foo.actual &&
+		test-tool pack-mtimes $bar_mtimes >bar.actual &&
+
+		echo "$foo $(cat foo.mtime)" >foo.expect &&
+		echo "$bar $(cat bar.mtime)" >bar.expect &&
+
+		test_cmp foo.expect foo.actual &&
+		test_cmp bar.expect bar.actual &&
+		test "$foo_mtimes" != "$bar_mtimes"
+	)
+'
+
+test_expect_success 'cruft repack with pack.packSizeLimit' '
+	(
+		cd max-pack-size &&
+		# repack everything back together to remove the existing cruft
+		# pack (but to keep its objects)
+		git repack -adk &&
+		git -c pack.packSizeLimit=1M repack --cruft &&
+		# ensure the same post condition is met when --max-pack-size
+		# would otherwise be inferred from the configuration
+		find $packdir -name "*.mtimes" >cruft &&
+		test_line_count = 2 cruft &&
+		for pack in $(cat cruft)
+		do
+			test-tool pack-mtimes "$(basename $pack)" >objects &&
+			test_line_count = 1 objects || return 1
+		done
+	)
+'
+
+test_expect_success 'cruft repack respects repack.cruftWindow' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		GIT_TRACE2_EVENT=$(pwd)/event.trace \
+		git -c pack.window=1 -c repack.cruftWindow=2 repack \
+		       --cruft --window=3 &&
+
+		grep "pack-objects.*--window=2.*--cruft" event.trace
+	)
+'
+
+test_expect_success 'cruft repack respects --window by default' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		GIT_TRACE2_EVENT=$(pwd)/event.trace \
+		git -c pack.window=2 repack --cruft --window=3 &&
+
+		grep "pack-objects.*--window=3.*--cruft" event.trace
+	)
+'
+
+test_expect_success 'cruft repack respects --quiet' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		GIT_PROGRESS_DELAY=0 git repack --cruft --quiet 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.49.0.rc0.6.g7f120c35e9

