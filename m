Received: from impout002.msg.chrl.nc.charter.net (impout002aa.msg.chrl.nc.charter.net [47.43.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA224C07F
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633903; cv=none; b=auDzfzytGUnPpgtMJPKBWxixQ5yBXPzTJZ8RPn8W9AAEWP87Ok3fSnsRXcynna7tBopAHJz+J8T1nSdWduKL0AIIYf+tq4GM2P81DVdZHJpeUGi8chUtmM1fjaz+P8CRHfixzJngtT3jIEigUMhgm6n7BebA4KLGveofCRRoXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633903; c=relaxed/simple;
	bh=3chi9e6xJB0zd5vBQm99ikeZkzOAoKeHQMHx6L2ffAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGTSg+XoB5znW1ng0teJyn3jFHcjpYSCPJD4ja3pLfFbhUpE8tfNEcGZjUk/JGRLmx+IHAq4VC8bAL+R5Gp5s9i7EzJfhe/5lthINxVH9rdB/rxvmyCEv3BTZvdhWZsZG6foTFH9YM2YItkKNHeB8Tm4yvWaYzZSwde9MRvcmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=q6Kvwo0f; arc=none smtp.client-ip=47.43.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="q6Kvwo0f"
Received: from [10.11.12.100] ([97.71.114.58])
	by cmsmtp with ESMTPA
	id oSYFuxAa7CFiYoSYFuuFVw; Tue, 19 Aug 2025 20:03:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1755633804;
	bh=3chi9e6xJB0zd5vBQm99ikeZkzOAoKeHQMHx6L2ffAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=q6Kvwo0fsJdCkYIfQoNoxLwDUkLRt5uaEhjuWqnq68xLXgCH+NrM9N7yBUCGrTL+H
	 fYUoaBYJI7J0SHfEPguC1ykWSQexP6iqH8pzLvgTe4UW+AkBHYzrPvHfauSYd6onXp
	 B894QeYracvS8M6AGTPcmDvxPxoUC2lY42CHVtrB8qkiNbTgMC19kFTkfnLu6rGDzE
	 e3dPrmw42yQqg9oV/kCnrbi31QNJGXJEMrRyXYLte5hwv/eSa8RlcdIuwXs+QMLcic
	 cxWhN9PFxLd9wW96VNSAC4+Uwo8nNvfxptyd/L9FrphOr8Z0ealFiMb8ZccbOac+ZU
	 py0v/a7If6UeQ==
Authentication-Results: charter.net; auth=pass (PLAIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=NpfXcddJ c=1 sm=1 tr=0 ts=68a4d88c
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=BCjA09oAAAAA:8 a=uiAi2Z2ZVnHh0jW_w3wA:9
 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22 a=jYKBPJSq9nmHKCndOPe9:22
Message-ID: <8797c495-8277-4f65-845b-167542b82949@charter.net>
Date: Tue, 19 Aug 2025 16:03:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] t5510: make confusing config cleanup more explicit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192455.GA1059295@coredump.intra.peff.net>
Content-Language: en-US
From: Eric Sunshine <ericsunshine@charter.net>
In-Reply-To: <20250819192455.GA1059295@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEKa/OzkGepEIZ3OPjL7iZww3YCXpvbDjtFL9dDQbbmRCdm1b9H5+HGPGP2xRIjGysyzcadN0jsFXdTn70auYrqMyW2uSkUURkU52yi0ESqe3WhifACc
 3gpYeNVQBSo5sSaAdGfx470X6HIihuOiAue0YRdCYiFljiBM8Jd5zWlVzH3DWmBcuWRQwePVWMeY2vKQKKztN/kSavSkUwKmeV4zcr2ON27oqPzAmNeoyWAv

On 8/19/25 3:24 PM, Jeff King wrote:
> Several tests set a config variable in a sub-repo we chdir into via a
> subshell, like this:
> 
>    (
> 	cd "$D" &&
> 	cd two &&
> 	git config foo.bar baz
>    )
> 
> But they also clean up the variable with a when_finished directive
> outside of the subshell, like this:
> 
>    test_when_finished "git config unset foo.bar"
> 
> At first glance, this shouldn't work! The cleanup clause cannot be run
> from the subshell (since environment changes there are lost by the time
> the test snippet finishes). But since the cleanup command runs outside
> the subshell, our working directory will not have been switched into
> "two".
> 
> But it does work. Why?
> 
> The answer is that an earlier test does a "cd two" that moves the whole
> test's working directory out of $TRASH_DIRECTORY and into "two". So the
> subshell is a bit of a red herring; we are already in the right
> directory! That's why we need the "cd $D" at the top of the shell, to
> put us back to a known spot.
> 
> Let's make this cleanup code more explicitly specify where we expect the
> config command to run. That makes the script more robust against running
> a subset of the tests, and ultimately will make it easier to refactor
> the script to avoid these top-level chdirs.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -119,7 +119,7 @@ test_expect_success "fetch test remote HEAD change" '
> -	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
> +	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&

For what it's worth, I have an unsent patch from a much larger unsent 
series which cleans up the t5510 messiness differently. (The below patch 
is probably whitespace damaged by the MUA.)


From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 20 Nov 2022 00:48:00 -0500
Subject: [PATCH 17/41] t5510: stop invoking `cd` outside of subshell

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
  t/t5510-fetch.sh | 123 ++++++++++++++++++-----------------------------
  1 file changed, 47 insertions(+), 76 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c0b745e33b..051af8d3f7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -8,8 +8,6 @@ test_description='Per branch config variables affects 
"git fetch".
  . ./test-lib.sh
  . "$TEST_DIRECTORY"/lib-bundle.sh

-D=$(pwd)
-
  test_expect_success setup '
  	echo >file original &&
  	git add file &&
@@ -48,19 +46,20 @@ test_expect_success "clone and setup child repos" '
  '

  test_expect_success "fetch test" '
-	cd "$D" &&
  	echo >file updated by origin &&
  	git commit -a -m "updated by origin" &&
+	(
  	cd two &&
  	git fetch &&
  	git rev-parse --verify refs/heads/one &&
  	mine=$(git rev-parse refs/heads/one) &&
  	his=$(cd ../one && git rev-parse refs/heads/main) &&
  	test "z$mine" = "z$his"
+	)
  '

  test_expect_success "fetch test for-merge" '
-	cd "$D" &&
+	(
  	cd three &&
  	git fetch &&
  	git rev-parse --verify refs/heads/two &&
@@ -72,41 +71,46 @@ test_expect_success "fetch test for-merge" '
  		echo "$main_in_two	not-for-merge"
  	} >expected &&
  	cut -f -2 .git/FETCH_HEAD >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+	)
+'

  test_expect_success 'fetch --prune on its own works as expected' '
-	cd "$D" &&
  	git clone . prune &&
+	(
  	cd prune &&
  	git update-ref refs/remotes/origin/extrabranch main &&

  	git fetch --prune origin &&
  	test_must_fail git rev-parse origin/extrabranch
+	)
  '

  test_expect_success 'fetch --prune with a branch name keeps branches' '
-	cd "$D" &&
  	git clone . prune-branch &&
+	(
  	cd prune-branch &&
  	git update-ref refs/remotes/origin/extrabranch main &&

  	git fetch --prune origin main &&
  	git rev-parse origin/extrabranch
+	)
  '

  test_expect_success 'fetch --prune with a namespace keeps other 
namespaces' '
-	cd "$D" &&
  	git clone . prune-namespace &&
+	(
  	cd prune-namespace &&

  	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
  	git rev-parse origin/main
+	)
  '

  test_expect_success 'fetch --prune handles overlapping refspecs' '
-	cd "$D" &&
  	git update-ref refs/pull/42/head main &&
  	git clone . prune-overlapping &&
+	(
  	cd prune-overlapping &&
  	git config --add remote.origin.fetch 
refs/pull/*/head:refs/remotes/origin/pr/* &&

@@ -121,11 +125,12 @@ test_expect_success 'fetch --prune handles 
overlapping refspecs' '
  	git fetch --prune origin &&
  	git rev-parse origin/main &&
  	git rev-parse origin/pr/42
+	)
  '

  test_expect_success 'fetch --prune --tags prunes branches but not tags' '
-	cd "$D" &&
  	git clone . prune-tags &&
+	(
  	cd prune-tags &&
  	git tag sometag main &&
  	# Create what looks like a remote-tracking branch from an earlier
@@ -136,11 +141,12 @@ test_expect_success 'fetch --prune --tags prunes 
branches but not tags' '
  	git rev-parse origin/main &&
  	test_must_fail git rev-parse origin/fake-remote &&
  	git rev-parse sometag
+	)
  '

  test_expect_success 'fetch --prune --tags with branch does not prune 
other things' '
-	cd "$D" &&
  	git clone . prune-tags-branch &&
+	(
  	cd prune-tags-branch &&
  	git tag sometag main &&
  	git update-ref refs/remotes/origin/extrabranch main &&
@@ -148,11 +154,12 @@ test_expect_success 'fetch --prune --tags with 
branch does not prune other thing
  	git fetch --prune --tags origin main &&
  	git rev-parse origin/extrabranch &&
  	git rev-parse sometag
+	)
  '

  test_expect_success 'fetch --prune --tags with refspec prunes based on 
refspec' '
-	cd "$D" &&
  	git clone . prune-tags-refspec &&
+	(
  	cd prune-tags-refspec &&
  	git tag sometag main &&
  	git update-ref refs/remotes/origin/foo/otherbranch main &&
@@ -162,23 +169,24 @@ test_expect_success 'fetch --prune --tags with 
refspec prunes based on refspec'
  	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
  	git rev-parse origin/extrabranch &&
  	git rev-parse sometag
+	)
  '

  test_expect_success REFFILES 'fetch --prune fails to delete branches' '
-	cd "$D" &&
  	git clone . prune-fail &&
+	(
  	cd prune-fail &&
  	git update-ref refs/remotes/origin/extrabranch main &&
  	: this will prevent --prune from locking packed-refs for deleting 
refs, but adding loose refs still succeeds  &&
  	>.git/packed-refs.new &&

  	test_must_fail git fetch --prune origin
+	)
  '

  test_expect_success 'fetch --atomic works with a single branch' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	git branch atomic-branch &&
  	oid=$(git rev-parse atomic-branch) &&
@@ -191,9 +199,8 @@ test_expect_success 'fetch --atomic works with a 
single branch' '
  '

  test_expect_success 'fetch --atomic works with multiple branches' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	git branch atomic-branch-1 &&
  	git branch atomic-branch-2 &&
@@ -206,9 +213,8 @@ test_expect_success 'fetch --atomic works with 
multiple branches' '
  '

  test_expect_success 'fetch --atomic works with mixed branches and tags' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	git branch atomic-mixed-branch &&
  	git tag atomic-mixed-tag &&
@@ -220,9 +226,8 @@ test_expect_success 'fetch --atomic works with mixed 
branches and tags' '
  '

  test_expect_success 'fetch --atomic prunes references' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git branch atomic-prune-delete &&
  	git clone . atomic &&
  	git branch --delete atomic-prune-delete &&
@@ -236,9 +241,8 @@ test_expect_success 'fetch --atomic prunes references' '
  '

  test_expect_success 'fetch --atomic aborts with non-fast-forward update' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git branch atomic-non-ff &&
  	git clone . atomic &&
  	git rev-parse HEAD >actual &&
@@ -255,9 +259,8 @@ test_expect_success 'fetch --atomic aborts with 
non-fast-forward update' '
  '

  test_expect_success 'fetch --atomic executes a single reference 
transaction only' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	git branch atomic-hooks-1 &&
  	git branch atomic-hooks-2 &&
@@ -282,9 +285,8 @@ test_expect_success 'fetch --atomic executes a 
single reference transaction only
  '

  test_expect_success 'fetch --atomic aborts all reference updates if 
hook aborts' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	git branch atomic-hooks-abort-1 &&
  	git branch atomic-hooks-abort-2 &&
@@ -319,9 +321,8 @@ test_expect_success 'fetch --atomic aborts all 
reference updates if hook aborts'
  '

  test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&

-	cd "$D" &&
  	git clone . atomic &&
  	oid=$(git rev-parse HEAD) &&

@@ -344,8 +345,7 @@ test_expect_success 'fetch --atomic --append appends 
to FETCH_HEAD' '
  '

  test_expect_success '--refmap="" ignores configured refspec' '
-	cd "$TRASH_DIRECTORY" &&
-	git clone "$D" remote-refs &&
+	git clone . remote-refs &&
  	git -C remote-refs rev-parse remotes/origin/main >old &&
  	git -C remote-refs update-ref refs/remotes/origin/main main~1 &&
  	git -C remote-refs rev-parse remotes/origin/main >new &&
@@ -368,35 +368,31 @@ test_expect_success '--refmap="" and --prune' '
  '

  test_expect_success 'fetch tags when there is no tags' '
-
-    cd "$D" &&
-
      mkdir notags &&
+    (
      cd notags &&
      git init &&

      git fetch -t ..
-
+    )
  '

  test_expect_success 'fetch following tags' '
-
-	cd "$D" &&
  	git tag -a -m "annotated" anno HEAD &&
  	git tag light HEAD &&

  	mkdir four &&
+	(
  	cd four &&
  	git init &&

  	git fetch .. :track &&
  	git show-ref --verify refs/tags/anno &&
  	git show-ref --verify refs/tags/light
-
+	)
  '

  test_expect_success 'fetch uses remote ref names to describe new refs' '
-	cd "$D" &&
  	git init descriptive &&
  	(
  		cd descriptive &&
@@ -423,31 +419,28 @@ test_expect_success 'fetch uses remote ref names 
to describe new refs' '
  '

  test_expect_success 'fetch must not resolve short tag name' '
-
-	cd "$D" &&
-
  	mkdir five &&
+	(
  	cd five &&
  	git init &&

  	test_must_fail git fetch .. anno:five
-
+	)
  '

  test_expect_success 'fetch can now resolve short remote name' '
-
-	cd "$D" &&
  	git update-ref refs/remotes/six/HEAD HEAD &&

  	mkdir six &&
+	(
  	cd six &&
  	git init &&

  	git fetch .. six:six
+	)
  '

  test_expect_success 'create bundle 1' '
-	cd "$D" &&
  	echo >file updated again by origin &&
  	git commit -a -m "tip" &&
  	git bundle create --version=3 bundle1 main^..main
@@ -461,35 +454,30 @@ test_expect_success 'header of bundle looks right' '
  	OID refs/heads/main

  	EOF
-	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
+	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$(pwd)"/bundle1 >actual &&
  	test_cmp expect actual
  '

  test_expect_success 'create bundle 2' '
-	cd "$D" &&
  	git bundle create bundle2 main~2..main
  '

  test_expect_success 'unbundle 1' '
-	cd "$D/bundle" &&
-	git checkout -b some-branch &&
-	test_must_fail git fetch "$D/bundle1" main:main
+	git -C bundle checkout -b some-branch &&
+	test_must_fail git -C bundle fetch "../bundle1" main:main
  '


  test_expect_success 'bundle 1 has only 3 files ' '
-	cd "$D" &&
  	test_bundle_object_count bundle1 3
  '

  test_expect_success 'unbundle 2' '
-	cd "$D/bundle" &&
-	git fetch ../bundle2 main:main &&
-	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
+	git -C bundle fetch ../bundle2 main:main &&
+	test "tip" = "$(git -C bundle log -1 --pretty=oneline main | cut -d" " 
-f2)"
  '

  test_expect_success 'bundle does not prerequisite objects' '
-	cd "$D" &&
  	touch file2 &&
  	git add file2 &&
  	git commit -m add.file2 file2 &&
@@ -498,11 +486,8 @@ test_expect_success 'bundle does not prerequisite 
objects' '
  '

  test_expect_success 'bundle should be able to create a full history' '
-
-	cd "$D" &&
  	git tag -a -m "1.0" v1.0 main &&
  	git bundle create bundle4 v1.0
-
  '

  test_expect_success 'fetch with a non-applying branch.<name>.merge' '
@@ -553,7 +538,6 @@ test_expect_success 'quoting of a strangely named 
repo' '

  test_expect_success 'bundle should record HEAD correctly' '

-	cd "$D" &&
  	git bundle create bundle5 HEAD main &&
  	git bundle list-heads bundle5 >actual &&
  	for h in HEAD refs/heads/main
@@ -573,7 +557,6 @@ test_expect_success 'mark initial state of 
origin/main' '

  test_expect_success 'explicit fetch should update tracking' '

-	cd "$D" &&
  	git branch -f side &&
  	(
  		cd three &&
@@ -588,7 +571,6 @@ test_expect_success 'explicit fetch should update 
tracking' '

  test_expect_success 'explicit pull should update tracking' '

-	cd "$D" &&
  	git branch -f side &&
  	(
  		cd three &&
@@ -602,7 +584,6 @@ test_expect_success 'explicit pull should update 
tracking' '
  '

  test_expect_success 'explicit --refmap is allowed only with 
command-line refspec' '
-	cd "$D" &&
  	(
  		cd three &&
  		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
@@ -610,7 +591,6 @@ test_expect_success 'explicit --refmap is allowed 
only with command-line refspec
  '

  test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
-	cd "$D" &&
  	git branch -f side &&
  	(
  		cd three &&
@@ -625,7 +605,6 @@ test_expect_success 'explicit --refmap option 
overrides remote.*.fetch' '
  '

  test_expect_success 'explicitly empty --refmap option disables 
remote.*.fetch' '
-	cd "$D" &&
  	git branch -f side &&
  	(
  		cd three &&
@@ -639,8 +618,6 @@ test_expect_success 'explicitly empty --refmap 
option disables remote.*.fetch' '
  '

  test_expect_success 'configured fetch updates tracking' '
-
-	cd "$D" &&
  	git branch -f side &&
  	(
  		cd three &&
@@ -654,7 +631,6 @@ test_expect_success 'configured fetch updates 
tracking' '
  '

  test_expect_success 'non-matching refspecs do not confuse tracking 
update' '
-	cd "$D" &&
  	git update-ref refs/odd/location HEAD &&
  	(
  		cd three &&
@@ -670,15 +646,10 @@ test_expect_success 'non-matching refspecs do not 
confuse tracking update' '
  '

  test_expect_success 'pushing nonexistent branch by mistake should not 
segv' '
-
-	cd "$D" &&
  	test_must_fail git push seven no:no
-
  '

  test_expect_success 'auto tag following fetches minimum' '
-
-	cd "$D" &&
  	git clone .git follow &&
  	git checkout HEAD^0 &&
  	(
@@ -1063,7 +1034,7 @@ test_expect_success 'fetch --prune prints the 
remotes url' '
  		cd only-prunes &&
  		git fetch --prune origin 2>&1 | head -n1 >../actual
  	) &&
-	echo "From ${D}/." >expect &&
+	echo "From $(pwd)/." >expect &&
  	test_cmp expect actual
  '

@@ -1097,14 +1068,14 @@ test_expect_success 'fetching with auto-gc does 
not lock up' '
  	echo "$*" &&
  	false
  	EOF
-	git clone "file://$D" auto-gc &&
+	git clone "file://$(pwd)" auto-gc &&
  	test_commit test2 &&
  	(
  		cd auto-gc &&
  		git config fetch.unpackLimit 1 &&
  		git config gc.autoPackLimit 1 &&
  		git config gc.autoDetach false &&
-		GIT_ASK_YESNO="$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
+		GIT_ASK_YESNO="$(pwd)/askyesno" git fetch --verbose >fetch.out 2>&1 &&
  		test_i18ngrep "Auto packing the repository" fetch.out &&
  		! grep "Should I try again" fetch.out
  	)
-- 
2.39.0.152.ga5737674b6

