Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8A36826F
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039381; cv=pass; b=RBR7ncAwjGjR0kwoP5mTCctiShAoyQm58fIjfF4lMJDqUa1fYADi9S2hGrPEXRUgEjytDZkDXoysLIdL2iFcWVfoVQXg5fgQTmRsu8lTJDp7fEjeIFaLWKIUXIn1rCtEuGunsUHZzAj2JaMM/0+UTfVdkLQ67wvLycUUEo3Aw8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039381; c=relaxed/simple;
	bh=IPqlsUGxo+P15t8tA3BVyYBGJxlImmsf4ihWO1uGQiU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=avAuRYVOdNTGxU8reSJOYHeR/wKCbUXMmIMgU+hP8+vXRjd9l/JFQWccjldOFoLgWswLYJdwkLOcPt8Rv1eby9afTC4YtilpI/6B/7349Dt2DHKltQtbTNqPhukps1W2b0O9GY6xwc/91z54WVr02JPVYxa8Og1KP0iQob2olpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CinrkRnH; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CinrkRnH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso5014035e87.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 05:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770039377; cv=none;
        d=google.com; s=arc-20240605;
        b=ZYA/9H9YiyqnemCyHWsWI0RuoKWohqpvi0qf1N3XCDC/bQQ62MXH/zXf/k0SyStulI
         EfAHqBBnO5EF8QQfovdV2zIS2A7h+S+PZ2CSH4gYZdsismTp1av9jvnw7aD736rgThIA
         ED3IPVgtQyxsqxWgbtYcNBPPNCBh4v4LcRe45ttF33MwbKmEj0CSReM99hFU+kfly84k
         LyXqlxsaPFyk/EobzTReCOnWrLDozhP2ZgNrPjseCTKlF/8DThTYxttqOyHJVIp6ikHo
         NQj8fguWIEoLxc568PVnQgeDfviZIyctsYJdY9cJ3ARO97Q9XmtkKIY2ZDejW0VftJAs
         ugXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ieApjL8A5wnX1+KIGBLVbM8V6Nmv0heR0TjOoF0di8A=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=PsXi+vxgDijWH0N1MZJQYDlsogIlSqbWJ81P8O8ZZKnvIUo2Mep7RFgykxwLTQYDHU
         h7qzk4FpX3ztNmqwb+TbayM8526968wvcQBVxuibuCRIduA8Kgb86TvHBnKTJ5gp69Jz
         huk6EWJFEOJ4t71CmXPlhmC6nt3SAU5c3/hw8TdjHhETiwBGea5+iwpLVDxiqLYvlSDC
         +n4rRWGbxJSpjYy5JmaTMmi3pP++ucPJr/ppiiVigKJcPcOw6FX/f6STFU3SVJ+Zhosn
         guQGqfstfm3YCC5bLhbyB9nClP3BJ8Oh1Cyq2pBOsMC99VkNrRnUpjSZekT68YCDh4R9
         78kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770039377; x=1770644177; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieApjL8A5wnX1+KIGBLVbM8V6Nmv0heR0TjOoF0di8A=;
        b=CinrkRnHzDVj4JftW7z0/hJPXqtIscvI8qxUfkbZAXEYeK/j+yIwPdLnCMZxbnNoiD
         SkZ0gOPwlxe8bZMQdJ/JsEj/qLmMNqGggmwzhjdUthQk78tdtJs2MbtiJ1KR1Y4yU5op
         Jsv+0kEWbaRAS0Ml4aRzXvjlSYPOVkt/ftK6QsMbAleCYSw45GU9Ns1DFj3RQNRS6FP5
         FRQHH5ttoXB326G0Yisfff/G0LTMJ7Kbj9Ox/FmVIZgbocij/P9X/YWttY5juzoSu2x8
         9GC1FzbGStvl60ipML3FWNEQtoIxIQt/2QYFPBi5/l2Nr4GZ0MhIVuvUlqZTWM0telDI
         3kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039377; x=1770644177;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieApjL8A5wnX1+KIGBLVbM8V6Nmv0heR0TjOoF0di8A=;
        b=e2G7CDfgsAu4JezSFxoKgOSdUUANrntKCNBz7r8BiGqRZ2gCoDLQeKuKnYaT2OIVIq
         mEEr3Hm0TXJZZCTyRnJy+gNgR2RZmq3EUMMxeHb43h9faYbo7jZd09Vt4zptXpoYMm2o
         RJNA2ptc+e9BEj76QsP/XP8VmbhyT219XPC/+I1cPD+69GUdO67XAEmnHtxU4R/5d8W9
         +OY3DgCp7/zio+clOoqKuYeQ8fDXenaOHYDM0/kegXzck3DFfMGIsm48JqBpm3Jq+8Zf
         fIQGLImn0p8wpSRm2exHVSoDKjKLQQ0TjsMiVTIldN6aCGrp9wJpPacUsp8sm1Rq4WW3
         STCQ==
X-Gm-Message-State: AOJu0Yx243CNVI5dAYefhTn/5cY5h3r7wUYE+Nz8J1LRVO8sYvHE9WG5
	CKSoU7KZDukbZkzoQMJQXzSQXEh/5v6JVEvrT28ck3xcfoT8vHFYMiQoXfOfFdpBRxZq+wf0NjS
	GXR6cnAyhI9n2nmn6G8yj/GDrVV3NIok2hAPjeLc=
X-Gm-Gg: AZuq6aKR9RgHj7KBtK69kNSGyetsDs1zXO1pX8zvcAR/lRxYOYUiQJJW9jXaP6ao89G
	+0y/to9xIPcR6+PdkZsaJQzg5a67g5uXmbj4c2cc1L8Y/mIZQyF65cpRw7yXxligAapjEPLKSrn
	7IazDGebIQnhJFEDMGNZOJTNJ0rIAS4mG2VVit6HQxu+ae6ocPTcGoaAao1deWJc9OxSc5XdrLg
	Wo/yrMEV4gmLfAB9KTV+Wpx8pOoJLRpaV8roO/S0ETNSV4GUXI/FP/EIotv3tZEZ6kyZ1tr
X-Received: by 2002:ac2:51c2:0:b0:59d:f545:f2e0 with SMTP id
 2adb3069b0e04-59e163f56d9mr3403016e87.6.1770039377267; Mon, 02 Feb 2026
 05:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hoda Salim <hoda.s.salim@gmail.com>
Date: Mon, 2 Feb 2026 15:36:04 +0200
X-Gm-Features: AZwV_QgP078X29WU9hgjK8M0-ThnAdJtazDlOiXzF6fly0-kx__cCkaulrPTY3w
Message-ID: <CAAGT0iKRA++yUcCxyRLZN14jLV0xNVSXcKr=F5vJ48dXVEn6PQ@mail.gmail.com>
Subject: Re: [PATCH] [GSoC][PATCH] t9160:modernize test path checking
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm Hoda, and I'm interested in contributing to Git through GSoC 2026.
This is my first patch to the project (my microproject), and I'd
appreciate any feedback on it. The patch modernizes path checks in
t9160 by replacing `test -f`, `test -d`, and `test -s` with Git's
dedicated test helpers for better error messages and consistency. I'm
happy to make any changes if needed!

Thanks,
Hoda
---
Replace old-style path checks with Git's dedicated test helpers:
- test -f =E2=86=92 test_path_is_file
- test -d =E2=86=92 test_path_is_dir
- test -s =E2=86=92 test_file_not_empty

Found using: git grep "test -[efd]" t/

This improves test readability and provides better error messages
when path checks fail.

Signed-off-by: HodaSalim <hoda.s.salim@gmail.com>
---
    [GSoC][PATCH] t9160:modernize test path checking

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2160%=
2FHodaSalim%2Fmicroproject%2Fmodernize-t9160-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
pr-git-2160/HodaSalim/microproject/modernize-t9160-v1
Pull-Request: https://github.com/git/git/pull/2160

 t/t9160-git-svn-preserve-empty-dirs.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh
b/t/t9160-git-svn-preserve-empty-dirs.sh
index 36c6b1a12f..b89c1cb93a 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -61,15 +61,15 @@ test_expect_success 'clone svn repo with
--preserve-empty-dirs' '

 # "$GIT_REPO"/1 should only contain the placeholder file.
 test_expect_success 'directory empty from inception' '
- test -f "$GIT_REPO"/1/.gitignore &&
+ test_path_is_file "$GIT_REPO"/1/.gitignore &&
  test $(find "$GIT_REPO"/1 -type f | wc -l) =3D "1"
 '

 # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file=
.
 test_expect_success 'directory empty from subsequent svn commit' '
- test -f "$GIT_REPO"/2/.gitignore &&
+ test_path_is_file "$GIT_REPO"/2/.gitignore &&
  test $(find "$GIT_REPO"/2 -type f | wc -l) =3D "1" &&
- test -f "$GIT_REPO"/3/.gitignore &&
+ test_path_is_file "$GIT_REPO"/3/.gitignore &&
  test $(find "$GIT_REPO"/3 -type f | wc -l) =3D "1"
 '

@@ -77,7 +77,7 @@ test_expect_success 'directory empty from subsequent
svn commit' '
 # generated for every sub-directory at some point in the repo's history.
 test_expect_success 'add entry to previously empty directory' '
  test $(find "$GIT_REPO"/4 -type f | wc -l) =3D "1" &&
- test -f "$GIT_REPO"/4/a/b/c/foo
+ test_path_is_file "$GIT_REPO"/4/a/b/c/foo
 '

 # The HEAD~2 commit should not have introduced .gitignore placeholder file=
s.
@@ -102,14 +102,14 @@ test_expect_success 'clone svn repo with
--placeholder-file specified' '

 # "$GIT_REPO"/5/.placeholder should be a file, and non-empty.
 test_expect_success 'placeholder namespace conflict with file' '
- test -s "$GIT_REPO"/5/.placeholder
+ test_file_not_empty "$GIT_REPO"/5/.placeholder
 '

 # "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO"/6 =
tree
 # should only contain one file: the placeholder.
 test_expect_success 'placeholder namespace conflict with directory' '
- test -d "$GIT_REPO"/6/.placeholder &&
- test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
+ test_path_is_dir "$GIT_REPO"/6/.placeholder &&
+ test_path_is_file "$GIT_REPO"/6/.placeholder/.placeholder &&
  test $(find "$GIT_REPO"/6 -type f | wc -l) =3D "1"
 '

@@ -134,18 +134,18 @@ test_expect_success 'second set of svn commits
and rebase' '
 # Check that --preserve-empty-dirs and --placeholder-file flag state
 # stays persistent over multiple invocations.
 test_expect_success 'flag persistence during subsqeuent rebase' '
- test -f "$GIT_REPO"/7/.placeholder &&
+ test_path_is_file "$GIT_REPO"/7/.placeholder &&
  test $(find "$GIT_REPO"/7 -type f | wc -l) =3D "1"
 '

 # Check that placeholder files are properly removed when unnecessary,
 # even across multiple invocations.
 test_expect_success 'placeholder list persistence during subsqeuent rebase=
' '
- test -f "$GIT_REPO"/1/file1.txt &&
+ test_path_is_file "$GIT_REPO"/1/file1.txt &&
  test $(find "$GIT_REPO"/1 -type f | wc -l) =3D "1" &&

- test -f "$GIT_REPO"/5/file1.txt &&
- test -f "$GIT_REPO"/5/.placeholder &&
+ test_path_is_file "$GIT_REPO"/5/file1.txt &&
+ test_path_is_file "$GIT_REPO"/5/.placeholder &&
  test $(find "$GIT_REPO"/5 -type f | wc -l) =3D "2"
 '


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
