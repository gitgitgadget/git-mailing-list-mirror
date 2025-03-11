Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2E179BC
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652503; cv=none; b=U0VanmMYXLl3pYk6QNa4gZn7g16uUPrbV5AZFHABdjh/SNFJXM0tqjVLEyrMDXR9WABgeWo6PGaypmk05214u15fErqYHCmqohMjsN+JKw5huNQdRRArYxx5R0KXBoyDL1eR+OcZzfAhoSQj9DQLmBse+92DMwYg9ySm9W2m+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652503; c=relaxed/simple;
	bh=rIBsKr88pxftvTcrVDxBAvCPoBL79q/QOzWUCS72mFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG4hVC0G+OyzZRMltO3GYVr7xHanchROQaHcb8pS39XnZTZwD8gGxEywzTy0P9T0EsgH6FMtO+9+8/WzNt0hn0jVEtt8Er6CbWLGTz2NhjhdyxvSkDl1189B7a/tADekniu7Lqra8wdYB9XU0TmNiJxEXgtPYBOkWo19zDjYhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b9paoJy0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b9paoJy0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f74b78df93so46249177b3.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652499; x=1742257299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHVSVCPi+hJd6oqrXiriDYr1pbJ8YTi54728iCiXQd8=;
        b=b9paoJy0rgxIKEgH6hI/kwF2pkA8t6jnDxPgP6HSD172eDt4W6SR3Su1GPill9DXBN
         9k0ZMxBd2FxKtAvE7swQbR7eRLpA3YHmfeOej8v0KDdCDNiVvEESraRn/NrNvsf9Jkwa
         6XjKoMEUSGnbLNepT45CQfhvaIrLiA3dcxB15qy506fCQyk8xY6HCZj7XyNkhJDPyynA
         pm2SYdAAFOU51UkdpiyusANh0vqh7pjxoLZlCIteQDejRH+Ir02rI3fr1PZbF2gkrJOM
         kEijBoyZDcHzH99S25k2/vCc/2phGgVHpJaTWk05wPZ3EUm/WsiWvliaxAUTUOl9eehb
         NL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652499; x=1742257299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHVSVCPi+hJd6oqrXiriDYr1pbJ8YTi54728iCiXQd8=;
        b=OO7HuNOfWFOQFZITw7SSIOxux5snw1sNXp/tdjWflzF/H7lPKnxgxK2j6LkRnfg0Dy
         pdLJlz8L3SbMOvwM+6pvk9EFWKX74NG1fAuhAplU4r3lUeepDpXAR65L0TGJUy5aHupV
         FhJZ55yJVnWr27MDI1WVbBebUYlPiieVVW57bbVXKpK7QQmwdN5CX4xn53mM4ztl0dSI
         6JjmofVCoYo60+MfmtI97z6Mi4s3j2fyRCrh6aFf70YY3JM1ZbbdPL57Bywz1P/MC219
         ZyFLJmK1EPQAODrCNuCillszfPROaXpjADzfxSR1c7r+MO3Hfv/P7nNSYsGRubcrkewG
         Rugw==
X-Gm-Message-State: AOJu0YzAnuTgz2OBEuiRvSaS8v836zwtCYRMQMz52om+pnx0i8V9s2cb
	mj4aqK7A+bFKqJQc9NfatGZJZqUanYEoTDvtNFWaGBg/hpniWJoCxFEwbYY4l/MSGU0Jf/svRxv
	2Quw=
X-Gm-Gg: ASbGncvlcMpZOZqd/fVvflWmWjDYy78BWBM2mzZK3aib06DeJEwG1za/Fqr+7T7Incl
	Jr+SdodeJ/xh2ALzJnXQ4B7Y9s0cyk1Qo6jOSC++yH5BCWNxYbsWOZmP7c5XjFEMPPEbM/Yyc8n
	qQwKZAulLsWhDxvU/RpHtxAlW3yZF03+ZvaReihLv6kQTQjYaTnFKI/5u23Teaile1UHKQgfGF2
	Ca5Z7QYhZsUEL+PKeulNDVECyate22/SUm8UY8dk0TYs/5KI2onuztFBiHHHfxsdywE4Ij7hY/n
	WIHjZwNqnPDAAJ8NkHS64m4PLN1IIuBI+WF6Cil0SNWHjDB0v+roiuIuYkIL001FxPBy8Z6vl0g
	QkJ1Q+kDzx2BAcjlV
X-Google-Smtp-Source: AGHT+IF47GkjUffkCEaAwA0BZKMlBbiIzXNA6cwZBIYqWCH3YgT/tZdSQ/UuKYT/7hzd1RWbvG/GfQ==
X-Received: by 2002:a05:690c:46c9:b0:6fd:41d5:de11 with SMTP id 00721157ae682-6febf3836e2mr212152687b3.23.1741652499553;
        Mon, 10 Mar 2025 17:21:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c64eb2sm23951187b3.121.2025.03.10.17.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:39 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/6] t/t5329-pack-objects-cruft.sh: evict 'repack'-related
 tests
Message-ID: <390c3a6d85b287b9d141167a9cce9ce555e5509d.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com>

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
index 959e6e2648..aa5d8913ae 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -411,4 +411,254 @@ test_expect_success 'reachable packs are preferred over cruft ones' '
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
2.49.0.rc2.6.g9a1eecd400

