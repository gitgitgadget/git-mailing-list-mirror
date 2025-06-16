Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6735972
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082881; cv=none; b=UZKXA+hlbUti7W1op9XxYXdaXlaxbLfhLljahwyNMzSh8Crebi7Dnm4AJUGXIGOmMVq18uVg1Stk9gzWD4K1M+4MU5pwX0Ti2SXNVoKzeDy2tjCp9lWqEy+sXh6XD0rWE6a4SK7qUhTHz6IyDsIWJw8XceROJlE8GErfKV52UF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082881; c=relaxed/simple;
	bh=pirDlZSBNRGRTVbSWf3/5J53LD433hfJeZSqs++RW5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/qIQiwNqQFFt/QaL0/MN+XzuW/zhamxVbOl16oQ2409FJ1MBkVyXHnYTImm3mwtGv/eZY1Sj9e0tizlLqKpwRq0akAtCAJXxXMw1mglyWdtZF7JXRBsQQFPfR7XO6maFAwCXuwNRagnZOBkFXuP6htBAFh8KMto6kJK2tZ9t/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8vJ5/XO; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8vJ5/XO"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e82596e88c4so629991276.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750082878; x=1750687678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+A7Jar4zoKrJxSHfKJc9dWwvTsSuDJ1Z3FyYJ2m4To=;
        b=i8vJ5/XOeiJCUFzaDfsgq+h9wMlXvkNWAzBNdA5mBrQ8D9L/Yznpf4crsLWzzqwKTg
         1h8d0q7GNfRLI7KxMk3fdPZqYf5QwzZyH7hbq+dT15XNio98Ypy6rTiqlGGv4MI009lk
         8QOKGo4O2ZHhAzKa+PACjjXD+9vDQSYFzNNV1TX6dKrrC4FmS8WDAEXmBrfPai0z83OC
         AZz3fSW0JSVzZSSh9WbQSSeReI4+MAGu/dZkFzrPiBqoH68mOVThxGrZW7pzdcC1Jzjj
         JHRZfZIKauqQ/mmiczDRjJV5k09VJ/2nBxwd8ES+okN0KP0zCI7XVlWXWwklObcGWldS
         AtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082878; x=1750687678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+A7Jar4zoKrJxSHfKJc9dWwvTsSuDJ1Z3FyYJ2m4To=;
        b=iIrd/zMzvcGg5REUgd0cLfCXstQzXs6+1YKlfC3AHmFwgrSP1YhXALjmuU7bQBAzSg
         it/6gBmHWzkYdmMt48u3aH81YO72UAbDEe7pC6+MlpoiLaNHn+x+9vxjOaASLY+Ajt87
         lYQX8GoCG6G5IS3/8dzbSQWpwRDVdtjnqic2bUPpOmwy19190G4LoucP4vwtmxIuxUxC
         RCIcbWVZSYQ7WiBphgOr/0pldcRuteJ3EPL6bxvTuQQztf3laTSppQBKzUe7QScCD0sB
         AwbkcYb3ibTEkjRpTE6CRS0WBXC6Dj5BO7smWS7pOcxkXGSV6yAGBcKiZWD1x3HvaeTX
         jl9g==
X-Gm-Message-State: AOJu0YyyYXOJU29FLl07YX9s/I6UJx/pNv6gg5J3WnDnm3PtIVX+hh6X
	MElZuE+st9VMsRm8JY/TPcTFnHuwgdByr9QtYJWLSARZVGY6AvuS3XQ0DzLkTQ0U
X-Gm-Gg: ASbGncvUiXAkNF6soRRIWCU33YrUxu8vD5BlgJF0yWR9NnT/0Ecc3togF8dlo8c3WBS
	1KOssgafwl8P1jQQyQyITHVne1GsYzYCr6rLukSK0NBAPzUHy7IDg4OoMSl5PxK5f7u7PUkmC4U
	kq/BXS25V/0qrV3rhJFU7FY/v+a914QdS0msKKRaKcUcuVRjpHGpDtGIuAxo0d9vhzAMSqCUdIO
	asSy8lp06a/bD1IXmVpj74mxBGMl7Uw2vTm2pCyedIu5vhMSDAVd9tJX+iMps0GtUupzj69YRU9
	iteWPyiWUjKRdgz8qJEVIkY5ZPtV2W7uJPnKdlUKZfq028zrQVq0XO+6czqU5E5JSyNc1bX7oKG
	653SPnaR2FA==
X-Google-Smtp-Source: AGHT+IGidy/46ve3uJpn7SZu2ahRH6LurLbeATvCkUM+/1VF7V4oOtyTqxljdbFyzNUki8HuayeHxg==
X-Received: by 2002:a05:6902:140d:b0:e79:fa4:1439 with SMTP id 3f1490d57ef6-e822acab548mr11642140276.9.1750082878211;
        Mon, 16 Jun 2025 07:07:58 -0700 (PDT)
Received: from APOLO.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e099598sm2957214276.21.2025.06.16.07.07.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Jun 2025 07:07:57 -0700 (PDT)
From: Rodrigo Michelassi <rodmichelassi@gmail.com>
To: git@vger.kernel.org
Cc: icaselli@usp.br,
	rodrigocmichelassi <rodmichelassi@gmail.com>
Subject: [PATCH v2] replace 't2400: test -[efd]' with 'test_path_is_*'
Date: Mon, 16 Jun 2025 11:07:54 -0300
Message-ID: <20250616140754.17815-1-rodmichelassi@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.48.gf1ca98f609.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: rodrigocmichelassi <rodmichelassi@gmail.com>

'test_path_is_file', 'test_path_is_dir' and 'test_file_is_missing'
are modern path checking methods in Git's development, that emit
useful diagnostic information when detect a failing condition, while
test -[efd] does not.
Replace the basic shell commands 'test -f', 'test -d' and 'test -e',
with this modern path checking approach.

Co-authored-by: Isabella Caselli <icaselli@usp.br>
Signed-off-by: Isabella Caselli <icaselli@usp.br>
Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
---
 t/t2400-worktree-add.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 90638fa886..023e1301c8 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -42,8 +42,8 @@ test_expect_success '"add" using - shorthand' '
 
 test_expect_success '"add" refuses to checkout locked branch' '
 	test_must_fail git worktree add zere main &&
-	! test -d zere &&
-	! test -d .git/worktrees/zere
+	test_path_is_missing zere &&
+	test_path_is_missing .git/worktrees/zere
 '
 
 test_expect_success 'checking out paths not complaining about linked checkouts' '
@@ -70,14 +70,14 @@ test_expect_success '"add" worktree' '
 test_expect_success '"add" worktree with lock' '
 	git worktree add --detach --lock here-with-lock main &&
 	test_when_finished "git worktree unlock here-with-lock || :" &&
-	test -f .git/worktrees/here-with-lock/locked
+	test_path_is_file .git/worktrees/here-with-lock/locked
 '
 
 test_expect_success '"add" worktree with lock and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
 	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
-	test -f .git/worktrees/here-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/here-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/here-with-lock-reason/locked
 '
@@ -412,14 +412,14 @@ test_expect_success '"add --orphan" with empty repository' '
 test_expect_success '"add" worktree with orphan branch and lock' '
 	git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
 	test_when_finished "git worktree unlock orphan-with-lock || :" &&
-	test -f .git/worktrees/orphan-with-lock/locked
+	test_path_is_file .git/worktrees/orphan-with-lock/locked
 '
 
 test_expect_success '"add" worktree with orphan branch, lock, and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
 	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
-	test -f .git/worktrees/orphan-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/orphan-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '
@@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
 
 test_expect_success '"add" worktree with --no-checkout' '
 	git worktree add --no-checkout -b swamp swamp &&
-	! test -e swamp/init.t &&
+	test_path_is_missing swamp/init.t &&
 	git -C swamp reset --hard &&
 	test_cmp init.t swamp/init.t
 '
@@ -497,7 +497,7 @@ test_expect_success 'put a worktree under rebase' '
 
 test_expect_success 'add a worktree, checking out a rebased branch' '
 	test_must_fail git worktree add new-rebase under-rebase &&
-	! test -d new-rebase
+	test_path_is_missing new-rebase
 '
 
 test_expect_success 'checking out a rebased branch from another worktree' '
@@ -535,7 +535,7 @@ test_expect_success 'checkout a branch under bisect' '
 		git worktree list >actual &&
 		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
-		! test -d new-bisect
+		test_path_is_missing new-bisect
 	)
 '
 
@@ -1165,7 +1165,7 @@ test_expect_success '"add" not tripped up by magic worktree matching"' '
 
 test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
 	git worktree add --detach ".  weird*..?.lock.lock" &&
-	test -d .git/worktrees/---weird-.-
+	test_path_is_dir .git/worktrees/---weird-.-
 '
 
 test_expect_success '"add" should not fail because of another bad worktree' '
-- 
2.50.0.rc2.48.gf1ca98f609.dirty

