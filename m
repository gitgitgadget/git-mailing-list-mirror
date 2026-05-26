Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C23D6466
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814056; cv=none; b=FdjFJZCSZSoaT/7uYGca6kAu/ihqSFO5z9TyA98PqA3AjpwnqlsiO+sF81DhcutLzY0EXDSIopVmAcBtYq3QUkit30WjpQ7iAZp3RH8JrnZecAmcienSU+DDnHJWEjKMjmYpU50gtZyo35m/uk8dZYZI18Pw3TuAwauFN3XnAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814056; c=relaxed/simple;
	bh=81NjAtKrr8GK8Cx2Su9bZqW2xVfyDyPiDitt5cpMWUI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oPAyprBAn+cAsgLRXGb0UJN4GKVEdhCjKFACS1IRoOBuo3BSWMlwk3ZKop+RLlFpsX5Nk4ZVBdWl9gRCnfLuV3KxI+UBJs3vOYCnDQh3mZ7vRaqorFn/W4oVbRFSFMot9FcGXZNKFoa0XmZ0+E2I2eDZvROwICISo89NM8wmyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpgsJLCV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpgsJLCV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e63771eb0so107587301cf.3
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814053; x=1780418853; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qvt11b/lJ8IJMgzlDkWR5uu3sLv8b4gxpJuu4VMOj4=;
        b=UpgsJLCVpeQo4t50AT/Oq/NoxhMD0NUEhExCCFMK9kcoW4OQJcx5HeVvY7AU0vB/OR
         311PjJTXpbGgecOhj3cLyeNss+Ce8N7xbOlblXEmXEDVAWiKuIkns0m3TWlIPTmeYkR1
         AQU0Ci3Tg6Xa9pEZkF91hsJAc9Owmj5cOOCg4wBWtpLikvhmq3SoHKXn5amLmXxBgxAm
         Ec5+C6+vnOhrMGVCvq9SNsd96fYJOW+KR5jb8AReGZphS337x0pKKeDddDms8CSuHfRy
         igm8KBX8YHOK+L2wCcyVrvgQLqT8fa5XaZThPpB/WFKywtSU6XTvyX6o6N5tHWYpNno3
         5SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814053; x=1780418853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qvt11b/lJ8IJMgzlDkWR5uu3sLv8b4gxpJuu4VMOj4=;
        b=sc433hmo+BNNe/eGLfSGRkBmb+h3yR15QUnvIb8ki4yv44IWWOLhji4GUFYOXsXo7J
         SJ8xz6pLL9kj0UdPqYdOoOc5WFtBuCcvtiEFVk36eUJztD0BNMDrYWxbT0y20CUFyDJ7
         fe9jKy+LdppcRuib2QtrO6dYGe+97FSu5hb5ZF4Ezdrq2H3d4ICLJLULymhqe6YT7pXj
         aVgmvh/4Y/9+gIVjbdEn/l+I9jjGf1qX0UTv8WMti7902foAATLJ80ghR0NOf5RGYYIf
         RvLC1g5AWYST1iLtKE+Y3gFQuVz7dIt0ZQsog7m1bd5VsltqL8tM8tCuSuLSDaaBj4jh
         QASA==
X-Gm-Message-State: AOJu0YxYW+Easto2Y2qLus9b2/KumdgRwh2+DBFFrOL3HWjbiWyPxzrE
	8NURK0aa5lIcoKtCtpu21U+emAWP5a01aVod2ctj2M1CynoaEPvs3kL6wruXRw==
X-Gm-Gg: Acq92OHl3a5kSIdRcdTEdH1wLUpY8HkTY/7dvGOnBX2kxFpUL3ca03YAJZTgy2md+8O
	HJMLtOuZRPbgx9c4q9GfyNgLMF0ioKufH5Xb0cev5KodS3FN5aqtwNSR7EBe+p8MyvOZrng26SY
	5AFdN7PLuK3Ue2ODWQwCI2StHhiPKh8z5bvw5raNESB3DbBSyKJwKRwecZvwesq4pmWFhFsLKEW
	W+I7BFKlcQTD/92f2E8Ma3IwJHTfZDWSTZsqPK0+AzOlEAoEumU+lcIdfNBntGWC994qlmZLAdo
	1DY5AFiO+H8QYQwkWzVUY533+T70gq5HocNyZoDSybnO9o5FGa6YHdrVdVrQrzC80ET4NHKKq7Z
	KlUfuOzIC4OWy9X3s0bY1pa4R+Gm+GdYd2UOEcM7eMBDX5328rzVKlXmcJNHHhTAS4F8YRtTGRx
	ynGaLGRlfBWTIQgzQulFMuVC8=
X-Received: by 2002:a05:620a:3191:b0:8ed:11b9:1ecb with SMTP id af79cd13be357-914b491e614mr2882445485a.20.1779814053549;
        Tue, 26 May 2026 09:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm250645285a.34.2026.05.26.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:33 -0700 (PDT)
Message-Id: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:26 +0000
Subject: [PATCH 0/5] git son: add command to create independent child repositories
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
Cc: Evan Haque <evanhaque1@gmail.com>


Motivation
==========

When spinning off a new project that is related to an existing repository,
there is no built-in way to create a child repository that maintains a link
back to its parent without the tight coupling of submodules. Submodules pin
the child to a specific commit and require the parent to track the child in
its index, which is too heavyweight when the child is meant to be fully
independent.

The typical workflow today is manual: git init, git remote add, update
.gitignore — three steps that are easy to forget or get wrong. git son
automates this and establishes a lightweight convention for the parent-child
relationship: a remote named parent in the child, and nothing in the parent
except an ignore rule.


Summary
=======

This series introduces git son, a new porcelain command that creates an
independent child repository inside the current working tree. Unlike a
submodule, the child is not tracked by the parent; instead, its subdirectory
is added to the parent's .gitignore. The child is configured at creation
time with a remote named parent pointing back to the parent repository's
origin URL (or local path if no origin exists), making the lineage explicit
and recoverable via standard Git commands.


Changes
=======

 * git-son.sh: new shell script implementing the command, supporting
   --inherit to fetch parent history at creation time and --branch <branch>
   (requires --inherit) to check out a specific parent branch
 * git-son registered in command-list.txt as mainporcelain
 * git-son.sh added to SCRIPT_SH in Makefile and to scripts_sh in
   meson.build
 * Documentation/git-son.adoc: new man page covering synopsis, option
   descriptions, and worked examples
 * Documentation/meson.build: git-son.adoc added to the manpage build list
 * t/t5151-son.sh: new test script covering basic creation, parent remote
   configuration, .gitignore update, idempotency failure, flag validation,
   and --inherit with a bare remote


Details
=======

The key design property is independence: the child is a fully self-contained
repository with no entry in the parent's index. The parent remote is the
only artifact linking the two, which means git fetch parent and git log
parent/<branch> work as expected from within the child without any special
tooling.

The --branch flag is intentionally restricted to --inherit mode. Without
fetching, there is no remote-tracking branch to check out from, so accepting
--branch alone would be misleading; the command dies with a clear diagnostic
in that case.

When no origin URL is available in the parent, the parent remote is set to
the parent's absolute local path. This covers the common case of
repositories that have never been pushed to a remote.


Testing
=======

t/t5151-son.sh covers the following scenarios:

 * Basic child repository creation (directory exists, .git present)
 * parent remote is correctly recorded in the child
 * Child directory is appended to the parent's .gitignore
 * Child starts with exactly one initial commit when --inherit is not used
 * Command fails without leaving a directory when the target already exists
 * --branch without --inherit is rejected before any filesystem changes
 * --inherit fetches parent history and the remote-tracking branch is
   reachable in the child

Evan Haque (5):
  git-son: add command to create independent child repositories
  git-son: register in Makefile and meson build system
  git-son: add to command list as mainporcelain
  git-son: add documentation
  git-son: add tests

 .gitignore                 |  1 +
 Documentation/git-son.adoc | 64 +++++++++++++++++++++++++
 Documentation/meson.build  |  1 +
 Makefile                   |  1 +
 command-list.txt           |  1 +
 git-son.sh                 | 97 ++++++++++++++++++++++++++++++++++++++
 meson.build                |  1 +
 t/meson.build              |  1 +
 t/t5151-son.sh             | 63 +++++++++++++++++++++++++
 9 files changed, 230 insertions(+)
 create mode 100644 Documentation/git-son.adoc
 create mode 100755 git-son.sh
 create mode 100755 t/t5151-son.sh


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2122%2FEvandabest%2Fgit-son-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2122/Evandabest/git-son-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2122
-- 
gitgitgadget
