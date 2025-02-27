Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE526FA42
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672351; cv=none; b=n+XtK93coilUChbovrz3w7bHMONyUZbYZmMszhEp9Fu2u15+8/Vl2iZbpqQZMM5TJckRAX4MYiMnTCxAEfshuOKq+TQ0kF3j6lLl9BTQXkx2bHlu6ABy+5VLIQCJ4KErhxhz3qNa080pRCf4xNCNxxXz6Xw/kAgvYgzVM5Oik84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672351; c=relaxed/simple;
	bh=NiSz0kFXgj2oW62wBNpIa05qAzJdZQp1gZun8gTT0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqLMdmas4qGG018KJ8cOQbbfwxZzBOFK20El7eGEktiQ8UjlSkJywlO7rYpEK3nuRqq4avODbrA/kmCnrnUXllRvX6PwTFDKlGXqkiE71Pt4nsRAt7HojwnPyKtwyOXtOms0QyMoaVnhNNnJJ9vuqlRSyWpAJBkRNga787eg17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu4nNm3h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu4nNm3h"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2212a930001so29288605ad.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672347; x=1741277147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZWI8TgIs25Erf+1G0IhxEBg80nHgq+9lTGFbSIIC1w=;
        b=Bu4nNm3h8kL8hUhU6Rs8NHpP13LmUUWtqUEOggtIcEF6XUHKrDr1C7DUcPCFzDMsST
         B7f8Xe3EyLicTDqZagggThH88f7OiFeEw6uZtZr0iQ9OJ6YxgKUsQ8dxsRP7JizEkn2Q
         thH/Teei12RsJXw2iOHpF/ZBFcddzhOU7RjAnF+oO3PjKKe4hagk6eQt40wkYqjUCzL9
         EV/AHB3X/kh7oeUiuUqvMeQx2lJepveyKhMNOHwVYFKPEvNe9d4FYhZGAKlLQU1IEWUh
         EcnKpwii6hFeFfDdWF22u+2z3QSd8lorhMHvV9LgqYJDiEajtwU0IKw/Rj9//pVo8KBw
         HXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672347; x=1741277147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZWI8TgIs25Erf+1G0IhxEBg80nHgq+9lTGFbSIIC1w=;
        b=o0YUksJmbr+hj05YS5hIlFj92QdNoF0HDQMo/EhltST+D3vlAGCIa9U+Ku71xWRmBP
         6TvcSVkiNbESm4GV89RPDXX1xigPUjU7GptTgEuHbz1adBGtQ7wzon5dnvs3MOzCda8x
         nH5aa9DSxZPvip7TBBeLQGRSVyKN9QGJiv8tA+fGZfCyuoQNz5srYt4iCjZfEWTsjDgB
         bEK80qsOj8FX/XplN0gIv7j+h8Fkm8kK01fH/GnoDXtJ+cqp3cFUaIQCuwhXyj5pGxmE
         ro7AH0DNbVJXyyE9Tc0X9AVBGCw1ntKBV9iU1rd1iaUc+wIebTupGkGohKG0FMeF7gzs
         Lc2Q==
X-Gm-Message-State: AOJu0Ywbk55B6Hg8jm+fBh2FE96NXBwdrujhjru6pxIXO16374FKToWJ
	Hlez6xdWmrTVVKYyBE3ELRXFm6X4orDi3EYlGQpLrLU4v/CN3b0K/6cSvA==
X-Gm-Gg: ASbGncsn98qDLKaSD58ghH4FgFd4WDaTa83tE+GaZcpEr8pgyI1HljvdvUuvq60L3dH
	h1mtQyhostF03dCazFVezEYEhS/nAkM9ypJjvNI7TgER0bjFR15vuZ+7vrLFMbl2MnUfzZ6J3GB
	ZY14yEUNDII0oKWrK5KEoyCMlwnj3R1gqB0YCifkzR2UujW/WXjnGxMAknCYeONTGP7luoEVpd5
	NtA/4zACsB0vYkOS+VqjkAefR1Oy7Pq53fQKES+bEJ00jchyfMyVMNAJxdaRSCUFIH1sIuyXriA
	H0OWppMLcwAaNBvZnPg7fQ==
X-Google-Smtp-Source: AGHT+IGL658MJMT2bqjMKo4i81MbBYawc+irPx4wurdN4ACx6zS7xGgOly2vvyr9dRR4LOXnC9OASw==
X-Received: by 2002:a17:902:e851:b0:223:5ada:891a with SMTP id d9443c01a7336-2235ada8d42mr32039815ad.10.1740672346430;
        Thu, 27 Feb 2025 08:05:46 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9d63sm16533825ad.78.2025.02.27.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:05:45 -0800 (PST)
Date: Fri, 28 Feb 2025 00:05:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 1/9] t0602: use subshell to ensure working directory
 unchanged
Message-ID: <Z8CNY140eAG-xCt5@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

For every test, we would execute the command "cd repo" in the first but
we never execute the command "cd .." to restore the working directory.
However, it's either not a good idea use above way. Because if any test
fails between "cd repo" and "cd ..", the "cd .." will never be reached.
And we cannot correctly restore the working directory.

Let's use subshell to ensure that the current working directory could be
restored to the correct path.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t0602-reffiles-fsck.sh | 967 ++++++++++++++++++++-------------------
 1 file changed, 494 insertions(+), 473 deletions(-)

diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index d4a08b823b..cf7a202d0d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -14,222 +14,229 @@ test_expect_success 'ref name should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-
-	git commit --allow-empty -m initial &&
-	git checkout -b default-branch &&
-	git tag default-tag &&
-	git tag multi_hierarchy/default-tag &&
-
-	cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
-	git refs verify 2>err &&
-	test_must_be_empty err &&
-	rm $branch_dir_prefix/@ &&
-
-	cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
-	git refs verify 2>err &&
-	rm $tag_dir_prefix/tag-1.lock &&
-	test_must_be_empty err &&
-
-	cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/tags/.lock: badRefName: invalid refname format
-	EOF
-	rm $tag_dir_prefix/.lock &&
-	test_cmp expect err &&
-
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/$refname: badRefName: invalid refname format
-		EOF
-		rm "$branch_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done &&
+	(
+		cd repo &&
 
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/tags/$refname: badRefName: invalid refname format
-		EOF
-		rm "$tag_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done &&
+		git commit --allow-empty -m initial &&
+		git checkout -b default-branch &&
+		git tag default-tag &&
+		git tag multi_hierarchy/default-tag &&
 
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
-		EOF
-		rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
-		test_cmp expect err || return 1
-	done &&
-
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		mkdir "$branch_dir_prefix/$refname" &&
-		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+		cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+		rm $branch_dir_prefix/@ &&
+
+		cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
+		git refs verify 2>err &&
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_must_be_empty err &&
+
+		cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+		error: refs/tags/.lock: badRefName: invalid refname format
 		EOF
-		rm -r "$branch_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done
+		rm $tag_dir_prefix/.lock &&
+		test_cmp expect err &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/$refname: badRefName: invalid refname format
+			EOF
+			rm "$branch_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/tags/$refname: badRefName: invalid refname format
+			EOF
+			rm "$tag_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
+			EOF
+			rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			mkdir "$branch_dir_prefix/$refname" &&
+			cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+			EOF
+			rm -r "$branch_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	git commit --allow-empty -m initial &&
-	git checkout -b branch-1 &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	git -c fsck.badRefName=warn refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/.branch-1: badRefName: invalid refname format
-	EOF
-	rm $branch_dir_prefix/.branch-1 &&
-	test_cmp expect err &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	git -c fsck.badRefName=ignore refs verify 2>err &&
-	test_must_be_empty err
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err &&
+
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=ignore refs verify 2>err &&
+		test_must_be_empty err
+	)
 '
 
 test_expect_success 'ref name check should work for multiple worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-
-	cd repo &&
-	test_commit initial &&
-	git checkout -b branch-1 &&
-	test_commit second &&
-	git checkout -b branch-2 &&
-	test_commit third &&
-	git checkout -b branch-3 &&
-	git worktree add ./worktree-1 branch-1 &&
-	git worktree add ./worktree-2 branch-2 &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
-	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-3
-	) &&
 	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-3
-	) &&
-
-	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
-	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
-	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err &&
-
-	for worktree in "worktree-1" "worktree-2"
-	do
+		cd repo &&
+		test_commit initial &&
+		git checkout -b branch-1 &&
+		test_commit second &&
+		git checkout -b branch-2 &&
+		test_commit third &&
+		git checkout -b branch-3 &&
+		git worktree add ./worktree-1 branch-1 &&
+		git worktree add ./worktree-2 branch-2 &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
 		(
-			cd $worktree &&
-			test_must_fail git refs verify 2>err &&
-			cat >expect <<-EOF &&
-			error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
-			error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
-			EOF
-			sort err >sorted_err &&
-			test_cmp expect sorted_err || return 1
-		)
-	done
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-3
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-3
+		) &&
+
+		cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
+		cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err &&
+
+		for worktree in "worktree-1" "worktree-2"
+		do
+			(
+				cd $worktree &&
+				test_must_fail git refs verify 2>err &&
+				cat >expect <<-EOF &&
+				error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+				error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+				EOF
+				sort err >sorted_err &&
+				test_cmp expect sorted_err || return 1
+			)
+		done
+	)
 '
 
 test_expect_success 'regular ref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
 
-	git refs verify 2>err &&
-	test_must_be_empty err &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
 
-	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/branch-bad: badRefContent: $bad_content
-		EOF
-		rm $branch_dir_prefix/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
+		for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/branch-bad: badRefContent: $bad_content
+			EOF
+			rm $branch_dir_prefix/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
 
-	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
-		EOF
-		rm $branch_dir_prefix/a/b/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $branch_dir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	for trailing_content in " garbage" "    more garbage"
-	do
-		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+		for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
+			EOF
+			rm $branch_dir_prefix/a/b/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
+
+		printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
 		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 		EOF
-		rm $branch_dir_prefix/branch-garbage &&
-		test_cmp expect err || return 1
-	done &&
+		rm $branch_dir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
 
+		printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
 
-	'\''
-	EOF
-	rm $branch_dir_prefix/branch-garbage-special &&
-	test_cmp expect err &&
 
-	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+		'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage-special &&
+		test_cmp expect err &&
+
+		printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
 
 
-	  garbage'\''
-	EOF
-	rm $branch_dir_prefix/branch-garbage-special &&
-	test_cmp expect err
+		  garbage'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage-special &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success 'regular ref content should be checked (aggregate)' '
@@ -237,99 +244,103 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	bad_content_1=$(git rev-parse main)x &&
-	bad_content_2=xfsazqfxcadas &&
-	bad_content_3=Xfsazqfxcadas &&
-	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
-	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
-	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
-	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
-	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
-	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
-	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
-	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		bad_content_1=$(git rev-parse main)x &&
+		bad_content_2=xfsazqfxcadas &&
+		bad_content_3=Xfsazqfxcadas &&
+		printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
+		printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
+		printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+		printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+		printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+		error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
+		error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
 '
 
 test_expect_success 'textual symref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		for good_referent in "refs/heads/branch" "HEAD"
+		do
+			printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+			git refs verify 2>err &&
+			rm $branch_dir_prefix/branch-good &&
+			test_must_be_empty err || return 1
+		done &&
+
+		for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
+		do
+			printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
+			EOF
+			rm $branch_dir_prefix/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
 
-	for good_referent in "refs/heads/branch" "HEAD"
-	do
-		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+		printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
 		git refs verify 2>err &&
-		rm $branch_dir_prefix/branch-good &&
-		test_must_be_empty err || return 1
-	done &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+		EOF
+		rm $branch_dir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
-	do
-		printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
-		test_must_fail git refs verify 2>err &&
+		printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
+		warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
 		EOF
-		rm $branch_dir_prefix/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $branch_dir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-complicated &&
-	test_cmp expect err
+		rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-complicated &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success 'textual symref content should be checked (aggregate)' '
@@ -337,32 +348,34 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
-	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
-	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
-	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
-	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
-	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
-	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
-	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
-	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+		printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
+		printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+		printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+		printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+		printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+		printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+		printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
+		warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
 '
 
 test_expect_success 'the target of the textual symref should be checked' '
@@ -370,28 +383,30 @@ test_expect_success 'the target of the textual symref should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
-	do
-		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
-		git refs verify 2>err &&
-		rm $branch_dir_prefix/branch-good &&
-		test_must_be_empty err || return 1
-	done &&
-
-	for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
-	do
-		printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
-		git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
-		EOF
-		rm $branch_dir_prefix/branch-bad-1 &&
-		test_cmp expect err || return 1
-	done
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
+		do
+			printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+			git refs verify 2>err &&
+			rm $branch_dir_prefix/branch-good &&
+			test_must_be_empty err || return 1
+		done &&
+
+		for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
+		do
+			printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
+			EOF
+			rm $branch_dir_prefix/branch-bad-1 &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success SYMLINKS 'symlink symref content should be checked' '
@@ -399,201 +414,207 @@ test_expect_success SYMLINKS 'symlink symref content should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
-	warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
-	EOF
-	rm $branch_dir_prefix/branch-symbolic &&
-	test_cmp expect err &&
-
-	ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-bad &&
-	test_cmp expect err &&
-
-	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
-	error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
-	EOF
-	rm $tag_dir_prefix/tag-symbolic-1 &&
-	test_cmp expect err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+		EOF
+		rm $branch_dir_prefix/branch-symbolic-good &&
+		test_cmp expect err &&
+
+		ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+		warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+		EOF
+		rm $branch_dir_prefix/branch-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+		error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
+		EOF
+		rm $branch_dir_prefix/branch-symbolic-bad &&
+		test_cmp expect err &&
+
+		ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+		error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
+		EOF
+		rm $tag_dir_prefix/tag-symbolic-1 &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success SYMLINKS 'symlink symref content should be checked (worktree)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	cd repo &&
-	test_commit default &&
-	git branch branch-1 &&
-	git branch branch-2 &&
-	git branch branch-3 &&
-	git worktree add ./worktree-1 branch-2 &&
-	git worktree add ./worktree-2 branch-3 &&
-	main_worktree_refdir_prefix=.git/refs/heads &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
 	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-
-	ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $worktree1_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $worktree2_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $main_worktree_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
-	EOF
-	rm $worktree1_refdir_prefix/branch-symbolic &&
-	test_cmp expect err &&
-
-	for bad_referent_name in ".tag" "branch   "
-	do
-		ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git worktree add ./worktree-1 branch-2 &&
+		git worktree add ./worktree-2 branch-3 &&
+		main_worktree_refdir_prefix=.git/refs/heads &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+		(
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+
+		ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree1_refdir_prefix/bad-symbolic &&
+		rm $worktree1_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree1_refdir_prefix/bad-symbolic &&
+		rm $worktree2_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+		warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree2_refdir_prefix/bad-symbolic &&
+		rm $main_worktree_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
 		EOF
-		rm $worktree2_refdir_prefix/bad-symbolic &&
-		test_cmp expect err || return 1
-	done
+		rm $worktree1_refdir_prefix/branch-symbolic &&
+		test_cmp expect err &&
+
+		for bad_referent_name in ".tag" "branch   "
+		do
+			ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+			EOF
+			rm $worktree1_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+			EOF
+			rm $worktree1_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+			EOF
+			rm $worktree2_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+			EOF
+			rm $worktree2_refdir_prefix/bad-symbolic &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	cd repo &&
-	test_commit default &&
-	git branch branch-1 &&
-	git branch branch-2 &&
-	git branch branch-3 &&
-	git worktree add ./worktree-1 branch-2 &&
-	git worktree add ./worktree-2 branch-3 &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
 	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git worktree add ./worktree-1 branch-2 &&
+		git worktree add ./worktree-2 branch-3 &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
 
-	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
-		test_must_fail git refs verify 2>err &&
+		(
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+
+		for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
+			EOF
+			rm $worktree1_refdir_prefix/bad-branch-1 &&
+			test_cmp expect err || return 1
+		done &&
+
+		for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
+			EOF
+			rm $worktree2_refdir_prefix/bad-branch-2 &&
+			test_cmp expect err || return 1
+		done &&
+
+		printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
+		warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
 		EOF
-		rm $worktree1_refdir_prefix/bad-branch-1 &&
-		test_cmp expect err || return 1
-	done &&
+		rm $worktree1_refdir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
-		test_must_fail git refs verify 2>err &&
+		printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
+		warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
 		EOF
-		rm $worktree2_refdir_prefix/bad-branch-2 &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $worktree1_refdir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
-	EOF
-	rm $worktree1_refdir_prefix/branch-garbage &&
-	test_cmp expect err
+		rm $worktree1_refdir_prefix/branch-garbage &&
+		test_cmp expect err
+	)
 '
 
 test_done
-- 
2.48.1

