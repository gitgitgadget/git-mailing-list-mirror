Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81A24B2B
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521165; cv=none; b=kxILbOMlcFxot8ERt9/ISVQiK3RoOqEmK2rcZqPGEEB/LWfDjODGKwgCHPzGjN0fiGq6XKWzQVOWuLIhSCfiQwDkSP7RI1wJi3vOhuvFS05yDDz1LA/ODUhNU5k7L+02QZpnXS+e7vo1Mr2oIQDgNuhXTVDq5/L969biyxgBIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521165; c=relaxed/simple;
	bh=J5bjVRF+NHYuNX+EPpvY5M5mrtGoYUIQTinpKvrZ/vI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=R1VEU4FmJRzafzxDidxt0K9Dr2hZmcV6/N0hf4htJFAo0M9wAjXVr8hPRujg+cbP4lJbv3r2ah90BqaWOAJYYmW0HDw7/oBXmuZvMgi2sDKoAF1V2tcYAuU9wNzQam5fgnfzT7HVom1Gf/Zttuu7gb7SyJ2xeH2LeRPrsxvy2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoqchjIm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoqchjIm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337c962d6b0so19157f8f.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521160; x=1706125960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrLQMrgB7QwTiRahwQ4FZYRHCMt//Q4GbFxCACLPcvI=;
        b=YoqchjImnD6qaH5s0sJH0YErIPk1BeRL2RsKAVJyctDeK0tH09YuzDybyfKDRoCMBr
         v9GcEYSYpv5MGprWZx7VXCLUO+44QXXfFAUEuVWkEE/vpDv+ByQdLLCxQbUi9V7wwr70
         8zNylc9+6sfvI4U5jTtHld6vfB+2xI8dnc2lJpdyZ0Y3e6M7hD+OU2q85EGG7r3hD1Bv
         VXuoT7Dtp1bCRiC0MvprCHMu3nrKtge1OWAIjr6Iar18dcVuROXLr36h4W8bpUC4Zul5
         CKilFDf0e/S0kXpomRnldDBmi3iXyvRwhvlytJVA2I8TWfpaCJ7P0WBXnDqxjXVFu80f
         PUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521160; x=1706125960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrLQMrgB7QwTiRahwQ4FZYRHCMt//Q4GbFxCACLPcvI=;
        b=WO5GBQSqHeA2nzVZMZb+m9L9NL70ONrNSG8O/iFsnhAuqScsaHE/4W1KMKZ63pbMxt
         So2xiOkjyOa8llDoXfWnMG/P2D39ONaHKNEejhWpo8afLXRVbZ4LPp3NZduc3da2TEq3
         5R2GwRjhxCdIIFyz0d9VRiMteSMaaYAxNEoxnRMmae5lBu/Zth2ubfZ9Rk2y2XJfnweH
         nvmPtkOyFjweFZey8weoAKQAVKHcufviu9FQUkqm/3pEdlL95wz5gKC1NI56T9GJPv0d
         e5oMTJkvNBe26nM/jWJCqeO41kwfSCpR6xuoywT8mC0knl4cZf3iS0ZDc2VaN0V1rN5G
         6O8w==
X-Gm-Message-State: AOJu0Yxa/hSFxZTAaUlwFYrg69eDdBbhRbV1Q1qdv4yszirTgI7ypNKQ
	qJObT5kXsj3klZWZI2RkBlE2UXYVSl4=
X-Google-Smtp-Source: AGHT+IFRWTBufN3YRvQQjnuYPew2e2Lfj2EA4GD7pmxRo67dXD/vF8IvZ10jCjk7J0hyJoLLJLlYcw==
X-Received: by 2002:adf:f30b:0:b0:337:5555:e5ea with SMTP id i11-20020adff30b000000b003375555e5eamr4652855wro.38.1705521159837;
        Wed, 17 Jan 2024 11:52:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b00337bb0f370dsm2363428wro.40.2024.01.17.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:39 -0800 (PST)
Message-ID: <0f6fea6d32d242db772fbee0b4aaec044087f53d.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:27 +0000
Subject: [PATCH 04/12] t1404: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

These tests modify loose refs manually and are specific to the reffiles
backend. Move these to t0600 to be part of a test suite of reffiles
specific tests.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh  | 398 +++++++++++++++++++++++++++++++++++
 t/t1404-update-ref-errors.sh | 378 ---------------------------------
 2 files changed, 398 insertions(+), 378 deletions(-)
 create mode 100755 t/t0600-reffiles-backend.sh

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
new file mode 100755
index 00000000000..332c8cbc004
--- /dev/null
+++ b/t/t0600-reffiles-backend.sh
@@ -0,0 +1,398 @@
+#!/bin/sh
+
+test_description='Test reffiles backend'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# Test adding and deleting D/F-conflicting references in a single
+# transaction.
+df_test() {
+	prefix="$1"
+	pack=: symadd=false symdel=false add_del=false addref= delref=
+	shift
+	while test $# -gt 0
+	do
+		case "$1" in
+		--pack)
+			pack="git pack-refs --all"
+			shift
+			;;
+		--sym-add)
+			# Perform the add via a symbolic reference
+			symadd=true
+			shift
+			;;
+		--sym-del)
+			# Perform the del via a symbolic reference
+			symdel=true
+			shift
+			;;
+		--del-add)
+			# Delete first reference then add second
+			add_del=false
+			delref="$prefix/r/$2"
+			addref="$prefix/r/$3"
+			shift 3
+			;;
+		--add-del)
+			# Add first reference then delete second
+			add_del=true
+			addref="$prefix/r/$2"
+			delref="$prefix/r/$3"
+			shift 3
+			;;
+		*)
+			echo 1>&2 "Extra args to df_test: $*"
+			return 1
+			;;
+		esac
+	done
+	git update-ref "$delref" $C &&
+	if $symadd
+	then
+		addname="$prefix/s/symadd" &&
+		git symbolic-ref "$addname" "$addref"
+	else
+		addname="$addref"
+	fi &&
+	if $symdel
+	then
+		delname="$prefix/s/symdel" &&
+		git symbolic-ref "$delname" "$delref"
+	else
+		delname="$delref"
+	fi &&
+	cat >expected-err <<-EOF &&
+	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
+	EOF
+	$pack &&
+	if $add_del
+	then
+		printf "%s\n" "create $addname $D" "delete $delname"
+	else
+		printf "%s\n" "delete $delname" "create $addname $D"
+	fi >commands &&
+	test_must_fail git update-ref --stdin <commands 2>output.err &&
+	test_cmp expected-err output.err &&
+	printf "%s\n" "$C $delref" >expected-refs &&
+	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
+	test_cmp expected-refs actual-refs
+}
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m Initial &&
+	C=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Second &&
+	D=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Third &&
+	E=$(git rev-parse HEAD)
+'
+
+test_expect_success 'empty directory should not fool rev-parse' '
+	prefix=refs/e-rev-parse &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	echo "$C" >expected &&
+	git rev-parse $prefix/foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool for-each-ref' '
+	prefix=refs/e-for-each-ref &&
+	git update-ref $prefix/foo $C &&
+	git for-each-ref $prefix >expected &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	git for-each-ref $prefix >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool create' '
+	prefix=refs/e-create &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "create %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool verify' '
+	prefix=refs/e-verify &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "verify %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg update' '
+	prefix=refs/e-update-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 2-arg update' '
+	prefix=refs/e-update-2 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 0-arg delete' '
+	prefix=refs/e-delete-0 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg delete' '
+	prefix=refs/e-delete-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'D/F conflict prevents add long + delete short' '
+	df_test refs/df-al-ds --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add short + delete long' '
+	df_test refs/df-as-dl --add-del foo foo/bar
+'
+
+test_expect_success 'D/F conflict prevents delete long + add short' '
+	df_test refs/df-dl-as --del-add foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents delete short + add long' '
+	df_test refs/df-ds-al --del-add foo foo/bar
+'
+
+test_expect_success 'D/F conflict prevents add long + delete short packed' '
+	df_test refs/df-al-dsp --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add short + delete long packed' '
+	df_test refs/df-as-dlp --pack --add-del foo foo/bar
+'
+
+test_expect_success 'D/F conflict prevents delete long packed + add short' '
+	df_test refs/df-dlp-as --pack --del-add foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents delete short packed + add long' '
+	df_test refs/df-dsp-al --pack --del-add foo foo/bar
+'
+
+# Try some combinations involving symbolic refs...
+
+test_expect_success 'D/F conflict prevents indirect add long + delete short' '
+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
+	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
+	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
+'
+
+test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
+	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
+	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
+	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
+	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
+'
+
+test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
+	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
+'
+
+test_expect_success 'non-empty directory blocks create' '
+	prefix=refs/ne-create &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks create' '
+	prefix=refs/broken-create &&
+	mkdir -p .git/$prefix &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks indirect create' '
+	prefix=refs/ne-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks indirect create' '
+	prefix=refs/broken-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'no bogus intermediate values during delete' '
+	prefix=refs/slow-transaction &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	# Now try to update the reference, but hold the `packed-refs` lock
+	# for a while to see what happens while the process is blocked:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	{
+		# Note: the following command is intentionally run in the
+		# background. We increase the timeout so that `update-ref`
+		# attempts to acquire the `packed-refs` lock for much longer
+		# than it takes for us to do the check then delete it:
+		git -c core.packedrefstimeout=30000 update-ref -d $prefix/foo &
+	} &&
+	pid2=$! &&
+	# Give update-ref plenty of time to get to the point where it tries
+	# to lock packed-refs:
+	sleep 1 &&
+	# Make sure that update-ref did not complete despite the lock:
+	kill -0 $pid2 &&
+	# Verify that the reference still has its old value:
+	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
+	case "$sha1" in
+	$D)
+		# This is what we hope for; it means that nothing
+		# user-visible has changed yet.
+		: ;;
+	undefined)
+		# This is not correct; it means the deletion has happened
+		# already even though update-ref should not have been
+		# able to acquire the lock yet.
+		echo "$prefix/foo deleted prematurely" &&
+		break
+		;;
+	$C)
+		# This value should never be seen. Probably the loose
+		# reference has been deleted but the packed reference
+		# is still there:
+		echo "$prefix/foo incorrectly observed to be C" &&
+		break
+		;;
+	*)
+		# WTF?
+		echo "unexpected value observed for $prefix/foo: $sha1" &&
+		break
+		;;
+	esac >out &&
+	rm -f .git/packed-refs.lock &&
+	wait $pid2 &&
+	test_must_be_empty out &&
+	test_must_fail git rev-parse --verify --quiet $prefix/foo
+'
+
+test_expect_success 'delete fails cleanly if packed-refs file is locked' '
+	prefix=refs/locked-packed-refs &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to delete it while the `packed-refs` lock is held:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
+	git for-each-ref $prefix >actual &&
+	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
+	test_cmp unchanged actual
+'
+
+test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
+	# Setup and expectations are similar to the test above.
+	prefix=refs/failed-packed-refs &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# This should not happen in practice, but it is an easy way to get a
+	# reliable error (we open with create_tempfile(), which uses O_EXCL).
+	: >.git/packed-refs.new &&
+	test_when_finished "rm -f .git/packed-refs.new" &&
+	test_must_fail git update-ref -d $prefix/foo &&
+	git for-each-ref $prefix >actual &&
+	test_cmp unchanged actual
+'
+
+test_done
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 0369beea33b..6edf3dca9d5 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -34,81 +34,6 @@ test_update_rejected () {
 	test_cmp unchanged actual
 }
 
-# Test adding and deleting D/F-conflicting references in a single
-# transaction.
-df_test() {
-	prefix="$1"
-	pack=: symadd=false symdel=false add_del=false addref= delref=
-	shift
-	while test $# -gt 0
-	do
-		case "$1" in
-		--pack)
-			pack="git pack-refs --all"
-			shift
-			;;
-		--sym-add)
-			# Perform the add via a symbolic reference
-			symadd=true
-			shift
-			;;
-		--sym-del)
-			# Perform the del via a symbolic reference
-			symdel=true
-			shift
-			;;
-		--del-add)
-			# Delete first reference then add second
-			add_del=false
-			delref="$prefix/r/$2"
-			addref="$prefix/r/$3"
-			shift 3
-			;;
-		--add-del)
-			# Add first reference then delete second
-			add_del=true
-			addref="$prefix/r/$2"
-			delref="$prefix/r/$3"
-			shift 3
-			;;
-		*)
-			echo 1>&2 "Extra args to df_test: $*"
-			return 1
-			;;
-		esac
-	done
-	git update-ref "$delref" $C &&
-	if $symadd
-	then
-		addname="$prefix/s/symadd" &&
-		git symbolic-ref "$addname" "$addref"
-	else
-		addname="$addref"
-	fi &&
-	if $symdel
-	then
-		delname="$prefix/s/symdel" &&
-		git symbolic-ref "$delname" "$delref"
-	else
-		delname="$delref"
-	fi &&
-	cat >expected-err <<-EOF &&
-	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
-	EOF
-	$pack &&
-	if $add_del
-	then
-		printf "%s\n" "create $addname $D" "delete $delname"
-	else
-		printf "%s\n" "delete $delname" "create $addname $D"
-	fi >commands &&
-	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
-	printf "%s\n" "$C $delref" >expected-refs &&
-	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
-	test_cmp expected-refs actual-refs
-}
-
 test_expect_success 'setup' '
 
 	git commit --allow-empty -m Initial &&
@@ -191,144 +116,6 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
-test_expect_success REFFILES 'empty directory should not fool rev-parse' '
-	prefix=refs/e-rev-parse &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	echo "$C" >expected &&
-	git rev-parse $prefix/foo >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success REFFILES 'empty directory should not fool for-each-ref' '
-	prefix=refs/e-for-each-ref &&
-	git update-ref $prefix/foo $C &&
-	git for-each-ref $prefix >expected &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	git for-each-ref $prefix >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success REFFILES 'empty directory should not fool create' '
-	prefix=refs/e-create &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "create %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool verify' '
-	prefix=refs/e-verify &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "verify %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 1-arg update' '
-	prefix=refs/e-update-1 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "update %s $D\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 2-arg update' '
-	prefix=refs/e-update-2 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "update %s $D $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 0-arg delete' '
-	prefix=refs/e-delete-0 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "delete %s\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
-	prefix=refs/e-delete-1 &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	mkdir -p .git/$prefix/foo/bar/baz &&
-	printf "delete %s $C\n" $prefix/foo |
-	git update-ref --stdin
-'
-
-test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
-	df_test refs/df-al-ds --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents add short + delete long' '
-	df_test refs/df-as-dl --add-del foo foo/bar
-'
-
-test_expect_success REFFILES 'D/F conflict prevents delete long + add short' '
-	df_test refs/df-dl-as --del-add foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents delete short + add long' '
-	df_test refs/df-ds-al --del-add foo foo/bar
-'
-
-test_expect_success REFFILES 'D/F conflict prevents add long + delete short packed' '
-	df_test refs/df-al-dsp --pack --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents add short + delete long packed' '
-	df_test refs/df-as-dlp --pack --add-del foo foo/bar
-'
-
-test_expect_success REFFILES 'D/F conflict prevents delete long packed + add short' '
-	df_test refs/df-dlp-as --pack --del-add foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents delete short packed + add long' '
-	df_test refs/df-dsp-al --pack --del-add foo foo/bar
-'
-
-# Try some combinations involving symbolic refs...
-
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
-	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short' '
-	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect add short + indirect delete long' '
-	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long + indirect add short' '
-	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short packed' '
-	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short packed' '
-	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents add long + indirect delete short packed' '
-	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
-'
-
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long packed + indirect add short' '
-	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
-'
-
 # Test various errors when reading the old values of references...
 
 test_expect_success 'missing old value blocks update' '
@@ -468,169 +255,4 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	test_cmp expected output.err
 '
 
-test_expect_success REFFILES 'non-empty directory blocks create' '
-	prefix=refs/ne-create &&
-	mkdir -p .git/$prefix/foo/bar &&
-	: >.git/$prefix/foo/bar/baz.lock &&
-	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'broken reference blocks create' '
-	prefix=refs/broken-create &&
-	mkdir -p .git/$prefix &&
-	echo "gobbledigook" >.git/$prefix/foo &&
-	test_when_finished "rm -f .git/$prefix/foo" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/foo $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/foo $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'non-empty directory blocks indirect create' '
-	prefix=refs/ne-indirect-create &&
-	git symbolic-ref $prefix/symref $prefix/foo &&
-	mkdir -p .git/$prefix/foo/bar &&
-	: >.git/$prefix/foo/bar/baz.lock &&
-	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
-	EOF
-	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'broken reference blocks indirect create' '
-	prefix=refs/broken-indirect-create &&
-	git symbolic-ref $prefix/symref $prefix/foo &&
-	echo "gobbledigook" >.git/$prefix/foo &&
-	test_when_finished "rm -f .git/$prefix/foo" &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/symref $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err &&
-	cat >expected <<-EOF &&
-	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
-	EOF
-	printf "%s\n" "update $prefix/symref $D $C" |
-	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
-'
-
-test_expect_success REFFILES 'no bogus intermediate values during delete' '
-	prefix=refs/slow-transaction &&
-	# Set up a reference with differing loose and packed versions:
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	# Now try to update the reference, but hold the `packed-refs` lock
-	# for a while to see what happens while the process is blocked:
-	: >.git/packed-refs.lock &&
-	test_when_finished "rm -f .git/packed-refs.lock" &&
-	{
-		# Note: the following command is intentionally run in the
-		# background. We increase the timeout so that `update-ref`
-		# attempts to acquire the `packed-refs` lock for much longer
-		# than it takes for us to do the check then delete it:
-		git -c core.packedrefstimeout=30000 update-ref -d $prefix/foo &
-	} &&
-	pid2=$! &&
-	# Give update-ref plenty of time to get to the point where it tries
-	# to lock packed-refs:
-	sleep 1 &&
-	# Make sure that update-ref did not complete despite the lock:
-	kill -0 $pid2 &&
-	# Verify that the reference still has its old value:
-	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
-	case "$sha1" in
-	$D)
-		# This is what we hope for; it means that nothing
-		# user-visible has changed yet.
-		: ;;
-	undefined)
-		# This is not correct; it means the deletion has happened
-		# already even though update-ref should not have been
-		# able to acquire the lock yet.
-		echo "$prefix/foo deleted prematurely" &&
-		break
-		;;
-	$C)
-		# This value should never be seen. Probably the loose
-		# reference has been deleted but the packed reference
-		# is still there:
-		echo "$prefix/foo incorrectly observed to be C" &&
-		break
-		;;
-	*)
-		# WTF?
-		echo "unexpected value observed for $prefix/foo: $sha1" &&
-		break
-		;;
-	esac >out &&
-	rm -f .git/packed-refs.lock &&
-	wait $pid2 &&
-	test_must_be_empty out &&
-	test_must_fail git rev-parse --verify --quiet $prefix/foo
-'
-
-test_expect_success REFFILES 'delete fails cleanly if packed-refs file is locked' '
-	prefix=refs/locked-packed-refs &&
-	# Set up a reference with differing loose and packed versions:
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
-	# Now try to delete it while the `packed-refs` lock is held:
-	: >.git/packed-refs.lock &&
-	test_when_finished "rm -f .git/packed-refs.lock" &&
-	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
-	git for-each-ref $prefix >actual &&
-	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
-	test_cmp unchanged actual
-'
-
-test_expect_success REFFILES 'delete fails cleanly if packed-refs.new write fails' '
-	# Setup and expectations are similar to the test above.
-	prefix=refs/failed-packed-refs &&
-	git update-ref $prefix/foo $C &&
-	git pack-refs --all &&
-	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
-	# This should not happen in practice, but it is an easy way to get a
-	# reliable error (we open with create_tempfile(), which uses O_EXCL).
-	: >.git/packed-refs.new &&
-	test_when_finished "rm -f .git/packed-refs.new" &&
-	test_must_fail git update-ref -d $prefix/foo &&
-	git for-each-ref $prefix >actual &&
-	test_cmp unchanged actual
-'
-
 test_done
-- 
gitgitgadget

