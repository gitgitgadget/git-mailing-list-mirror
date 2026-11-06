Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969480;
	b=1l4rKA1uwBPP5J8k+zOIi0ZFdjX6jOW8ohPQqXiihRrGIMt9TGpMuhOqfKL576kSq311
	 gmn/UXIgaThfPFKVn+QQai6xAmZJ/nd5uInjdntBdX75f9wUXSGjd2jWiY3kA5vsyHOzR
	 c7KLn0BQvQjpMe7AI+f+7anUKbFru/tgqUp4VdGji4/tfXTg+WkaLFLTuGuguAYCsKVsP
	 h7L2bTrp7Saye302QaZsdZGGPRXl1QUjntQpaUSzh7BVkugtAY4xt3BIWfaiR5BwR0ZhY
	 zzSa5FyC9Sfsha3Z+irhtudQjN9/ftktKy7/TmPkAgBe+k67s8bbgNYDZZIQPhC2QTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XveudT9Sng61F4uI1BHGYoX2inGsUSwNWkJBhio50JY=;
	b=WFQsW0h4YyDahGnny4lpKnc0eJa9BY9xBdowFF+qfSLFteZ+kQDEYnmCVbcuKnQ4mUX/
	 D7k2L9LX8cJSl2mABzpMcmI5p/9xIlUe1okJ6s02L+sW+vijuMnfpOAFLev83bIJkOnxp
	 bXtp3BkDB+4rgKDfYIV61+NLKTAc3aDyXL7PwF32yffzCzhYjiPCcESeuaSyAlxeJOtqS
	 0359PcgSm7TRGoXn1TWTQP5m0iv6EX6BIMbrfNGx6hRmjCK/FRgI3f8l4u1/c9nLX1Gud
	 CQt599hXHpLMQONjtnaxJF4IQ/8K2bIVSxFTEwbENQ6gudE9i8Ih32tUziLfJ7a8nUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=beQUmZoI;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CC606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677CC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=beQUmZoI
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c162febb9so5950886d6.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 04:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969479; x=1794574279; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XveudT9Sng61F4uI1BHGYoX2inGsUSwNWkJBhio50JY=;
        b=beQUmZoIJdOkRVYYczV6OwZNKG2t8//6MjqtjfP65DDANtVXMZ7oEF+w6BAhaJpW2a
         DQ7tSfh/rjirrAFw4nfFWFQFRXUDnKDZuYvPfh4vOxRw2BbouuvrxkUe3crJrpqc0c9+
         Z0Kbn1rphhKKIORhlGR73HFcskjX9bzK5JFwKhG7patNnLGowdcwxFwce3j2vp/rHF/S
         wLTzwOFgz4JvKrnJ7wUPayPTiWEqwQvzVmKcqo2YYNxFKrJ6VGGwn2Nq/DdhErdUwyMd
         mufAs9ytgIKKbzXqnR9roByH56DdFbCHXE/5IytgagAu0+/Ymc67VG7uY25rjhwHdk71
         UiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969479; x=1794574279;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XveudT9Sng61F4uI1BHGYoX2inGsUSwNWkJBhio50JY=;
        b=jfoxDAH9xZG5T3b+jr1dGf+M3y39Ff4mnv7RUQkSQAOiy7V47W71F59IJfW6z0ObYy
         FNm8D9zehueb0HDsvCiYQoPLcHT/8daDNmHshKgqG1fed+71+1HUiGFarik7vXNS1wpu
         nd986rvlmYnhgXUXqCfmV3zSvArFHQKH4GL/AgZUcQYe3PjjtNoVcCXns04wInOrkLb9
         QrYFq9HWu4PtsBrlz6uDEdMhu7LvT5yg5c93MZUysuqsD6s3EgoAcxBqWvzqN5QJbifd
         nMNrdnS/HidAjc+ASyyfs/K0456yqw58yKJsWP1lOo8N96hsSX2V8cqgItOBarCTtUl1
         9x+A==
X-Gm-Message-State: APuU4Z/herErByn3wzg2jdCyoFW0RWAPmw14AM3YBMmTs6SAq0HLl9D3
	8yKxfvShv70s5/JuzObzHlHJGfAE9Wp4skOZV8khp6BHDwLOh9fmFtLvMLgda+VP
X-Gm-Gg: AYBFou3Jqdrf9W0UI3AXTuAa03meE+9RcVbqZEiLwW8GMEKSE3xVJNZN+zaKi+/YYPL
	yU+x6jNjM1b3JxzKjZd60U0FT3Dnl44g4zujcqV4XnVf3VnSHTgtrKIETY2jGkeCzZx0BPJTkUs
	RjEiKvRtwBw1we5Q1gcWrHnTVDm9WVdcPUk0eTc2wtSR9vejypofVQNp0HD1qM7/jhvysOAoA9U
	T+00uhuBxHjWDtMR0/aAif/oo6P2JFGyJqcsl2Xk5nD/4O4z3bRg6CG2KnzgZyzqUE2adGBoepu
	9/S+D6jOmU+Nu+7l1gqA1EHtsGE1vLSohyzgOze9n+MyGfAPL4MGiNyREHRJ4SBnEgjij6fR4rI
	Z3KQ3MqoZ4fCRxwm9GdP3Vw2pa7ywl5DV6I0Y2oLOglHjpUT8wcvbmD+H6SbSLeFdEDaVedDXie
	UNEPEfuGuBNgS7vabnFf4FqJf+XiB/0io4e9fSZbDudPCdvadbB0XAXf3p8a5BR+PEnTiR+9FOn
	YvPIMgSGgvOUUNuVaQyQG8I3sYd7OUANkrG4kSSEji3YnA0v62HM5KvEv+7fnKD3DdJZ5hTM/47
	i4am6AE9Qdgp3RHhRvg9K+V4pfogZMnuMsAKgQ7F8o/cCHYQeXHL
X-Received: by 2002:a05:6214:3011:b0:91b:98fe:d2ca with SMTP id 6a1803df08f44-91ea96a69d4mr30503396d6.23.1793969479240;
        Fri, 06 Nov 2026 04:51:19 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a887c0sm19789886d6.29.2026.11.06.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:51:18 -0800 (PST)
Message-Id: <6c6abee65cb3987978b982e69f227e408c0bf408.1793969476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
References: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 12:51:16 +0000
Subject: [PATCH 2/2] t5608: assert that the packs involved really are that
 large
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

t5608 was added in ca31f0b5c2 (Add an (optional, since expensive) test
for >2gb clones, 2009-03-06) to construct a repository larger than 2GB
and clone it.  It already anticipated that the setup might stop doing
what it is meant to do: "Should that break in the future, e.g. when
pack v4 becomes default, there is a commented-out call to
test-genrandom which can be substituted".

It did break, silently, with d9545c7f46 (fast-import: implement unpack
limit, 2016-04-25).  The setup writes only 24 objects, which is below
the default fastimport.unpackLimit of 100, so fast-import does not
keep its pack but turns it into loose objects.  Since the blobs
compress very well, the repository has less than 10MB of loose
objects, and the bare clone merely copies those.  Only the file://
clone still deals with a pack larger than 2GB, because the sending
side generates a new pack from the loose objects.

The ">4GB object" tests added in 4b220cafbe (t5608: add regression
test for >4GB object clone, 2026-05-08) have a similar problem.  They
are meant to cover a fix in both index-pack and unpack-objects, but
"git clone" always keeps the received pack, so setting
fetch.unpackLimit in the unpack-objects variant has no effect, and
both tests use index-pack.

Nothing noticed any of this, because the tests only check that the
commands succeed.  Add assertions on what each test relies on, so
that it fails when its setup no longer does what it is meant to:

 - the pack created by the setup, and the packs of both clones, are
   larger than 2GB;

 - the synthesized pack with the >4GB object, and the pack written by
   the index-pack clone, are larger than 4GB;

 - the unpack-objects variant really runs unpack-objects, as seen in
   its trace2 output.

Some of these assertions fail with the tests as they are, so fix them:

 - Set fastimport.unpackLimit=0 in the setup.  fast-import then
   keeps its pack regardless of how few objects it contains, so the
   repository, and the bare clone that copies it, have a pack larger
   than 2GB again.

 - In the unpack-objects variant, use "git fetch" into an empty
   repository instead of "git clone".  Unlike clone, fetch honors
   fetch.unpackLimit, so with five objects and a limit of 100 the
   received pack really is passed to unpack-objects.

As a bonus, keeping the fast-import pack also makes the test cheaper,
because unpack-objects no longer hashes and compresses all of the 2GB
of data a second time.  Locally, the time spent in the setup is
roughly reduced from 80 to 40 seconds.  The test runs in all CI jobs
via GIT_TEST_CLONE_2GB, and is among the slowest tests there.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t5608-clone-2gb.sh | 54 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 5d56debf1c..9d7152486e 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -9,12 +9,28 @@ then
 	test_done
 fi
 
+size_2gb=2147483648
+size_4gb=4294967296
+
+# The tests below are only meaningful if the packs involved really are
+# that large, so check it explicitly instead of trusting the setup.
+test_has_pack_larger_than () {
+	max=$(test-tool path-utils file-size "$1"/*.pack | sort -n | tail -n 1) &&
+	max=${max:-0} &&
+	if test "$max" -le "$2"
+	then
+		echo >&2 "largest pack in '$1' is $max bytes, expected more than $2" &&
+		return 1
+	fi
+}
+
 test_expect_success 'setup' '
 	git init 2gb-repo &&
 	(
 		cd 2gb-repo &&
 		git config pack.compression 0 &&
 		git config pack.depth 0 &&
+		git config fastimport.unpackLimit 0 &&
 		blobsize=$((100*1024*1024)) &&
 		blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
 		i=1 &&
@@ -39,14 +55,20 @@ test_expect_success 'setup' '
 	)
 '
 
+test_expect_success 'setup produces a pack larger than 2GB' '
+	test_has_pack_larger_than 2gb-repo/.git/objects/pack $size_2gb
+'
+
 test_expect_success 'clone - bare' '
 	test_when_finished rm -rf clone-bare &&
-	git clone --bare --no-hardlinks 2gb-repo clone-bare
+	git clone --bare --no-hardlinks 2gb-repo clone-bare &&
+	test_has_pack_larger_than clone-bare/objects/pack $size_2gb
 '
 
 test_expect_success 'clone - with worktree, file:// protocol' '
 	test_when_finished rm -rf clone-wt &&
-	git clone "file://$(pwd)/2gb-repo" clone-wt
+	git clone "file://$(pwd)/2gb-repo" clone-wt &&
+	test_has_pack_larger_than clone-wt/.git/objects/pack $size_2gb
 '
 
 rm -rf 2gb-repo 2>/dev/null
@@ -59,24 +81,29 @@ test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
 		4gb-repo/objects/pack/test.pack) &&
 	git -C 4gb-repo index-pack objects/pack/test.pack &&
 	git -C 4gb-repo update-ref refs/heads/main $head_oid &&
-	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
+	git -C 4gb-repo symbolic-ref HEAD refs/heads/main &&
+	test_has_pack_larger_than 4gb-repo/objects/pack $size_4gb
 '
 
-test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-objects' '
-	test_when_finished rm -rf 4gb-clone-unpack &&
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'fetch >4GB object via unpack-objects' '
+	test_when_finished rm -rf 4gb-fetch-unpack &&
 	# The synthesized pack has five objects, so a large unpack limit keeps
-	# fetch-pack on the unpack-objects path.
-	git -c fetch.unpackLimit=100 clone --bare \
-		"file://$(pwd)/4gb-repo" 4gb-clone-unpack &&
+	# fetch-pack on the unpack-objects path.  This needs "fetch", as
+	# "clone" always keeps the received pack.
+	git init --bare 4gb-fetch-unpack &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-unpack" \
+		git -C 4gb-fetch-unpack -c fetch.unpackLimit=100 fetch \
+		"file://$(pwd)/4gb-repo" main:refs/heads/main &&
+	test_subcommand_flex git unpack-objects <trace-unpack &&
 
-	# Verify the large blob survived the clone by comparing its OID
-	# between source and clone.  We cannot use "cat-file -s" because
+	# Verify the large blob survived the fetch by comparing its OID
+	# between source and destination.  We cannot use "cat-file -s" because
 	# object_info.sizep is still unsigned long, which truncates >4GB
 	# sizes on Windows.  OID equality proves content integrity since
-	# the clone already verified checksums via index-pack/unpack-objects.
+	# the fetch already verified checksums via unpack-objects.
 	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
-	clone_blob=$(git -C 4gb-clone-unpack rev-parse main^:file) &&
-	test "$source_blob" = "$clone_blob"
+	fetched_blob=$(git -C 4gb-fetch-unpack rev-parse main^:file) &&
+	test "$source_blob" = "$fetched_blob"
 '
 
 test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone with >4GB object via index-pack' '
@@ -84,6 +111,7 @@ test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone with >4GB object via index-
 	# Force fetch-pack to hand the pack to index-pack instead.
 	git -c fetch.unpackLimit=1 clone --bare \
 		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
+	test_has_pack_larger_than 4gb-clone-index/objects/pack $size_4gb &&
 
 	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
 	clone_blob=$(git -C 4gb-clone-index rev-parse main^:file) &&
-- 
gitgitgadget
