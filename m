Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57D371876
	for <git@vger.kernel.org>; Fri, 22 May 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462619; cv=none; b=Sy4QsDKNldZp/6aQOHS/UQ4oN8ktsYDq6IwCjnustMAZwoff8/teGlOpskesXOuovXls84/RyDNAJUBH+jwc1D6fQBGk1ALm7vK4ng7hO/m5bDfO+osTdAW37yQrm5C3PIrAI9BCG8cIkBFbXstAV2xk2cTDWcsj2Uwg5asIwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462619; c=relaxed/simple;
	bh=+sU9ASQ+S6Vki8rNXZGx9lgmx9cTgoq8TS98EFp/ZQE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jb9PtrnBag4wKdUe9cW65a5RJYY3WBH7TRS2/ln4kkcV0QpBzEWaGUF46n4SpXw0Ca2fawmCl6sqro5AKmc5hd1rmTMi9rKu4ODkAQ2hFHtZofA8My4X90mU018i4D5Awn12ttb3lePjXgxmfou/fXiIQPJxVp6DnINMNGN7eps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Mt4CmK/z; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Mt4CmK/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779462611;
	bh=V/s/970yPnPkyvAv9iAZZzq2BliRIvMKn8bosfMbHME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mt4CmK/zkO1y4EBBT4mQfnJa+jm7QaHV2SAxFLVGhvYXtEH9R4ntaWI+iZMh8V1qh
	 sDyw/UkaO9pTwFzVmqytTAXMqnHkuYM4LsATT+hDLmWmOmTpZaxV1px6R8lUUoRmlS
	 3YNHdoGzhoB/I11zW680jzNw6b3f+t6m85xWQZ7s=
Received: from localhost.localdomain ([121.224.209.33])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 287B22AC; Fri, 22 May 2026 23:10:07 +0800
X-QQ-mid: xmsmtpt1779462607tly9kjiyd
Message-ID: <tencent_9FA5CF10A1D7CAC770366E84AD5CA9A2D107@qq.com>
X-QQ-XMAILINFO: M0vdiI0AC4YkMjEm5KUnhm2cseRivqGEFw+5djUcSwdXhrIsSmPrWpgFIIUsEs
	 PbqhWbxzBridwlr7onBR9hbOWM6ZFpJc2DyLFD0Oc5dOS2UTfIZrsfOmL3i1CVwr+Da6fkBtu8mM
	 lV4kMIdmt+e9FQ/i6uIDkAcB3h2rx3NEf5ND74yCoti6Dvyq80bjZuyWtyzFGPP0hO+Xsq6mkf52
	 f7L/6BUcBbWOmGVFJzhcq53jJQQerddC3drQ/QG/f3yME0eujselXh3rTcpLqHjo5jQffxZP/kN/
	 1szxxrl7KNcdB6iTwcwQNjwvixUtb+Huip3b7lTTnv869qzHcnBpRHqJvzwN2fHzGLULI/v8Shb3
	 qL4skd2LPUejZ4JT5MjFxQiXWfATRxsBO2YB7LseMgzkC4nHspVblLw6sUgYEkTkPvmJ6SYJFOC2
	 pjuEfzuo0K4CtXAJy/t0p9v83rNXwr7ujcr21g9K5KAKpPRjNHCLsgDXwdePoLrR2QNhP3JjB1Uh
	 jpcDTbqDYawOzDiKuWpcjJz60nb+j8Yep1IOMoS8if+5k0XpLE3yCVcnEmYO9Cp+gwTBs0V4vDTx
	 gqYJNjml5zI4Rf47hLgdgYShcXernzQ7NKe4lEeMB9mxc1NJ2RYuilbLaz352qDCvhFyIlHehpqM
	 fBOudbCghCa5Fp/TXNWDyQbHVA4PtKmmUo9+llBYSO8e8hK7eQZIa+uE0mfKiJBRvuoBmLoL+iHG
	 9+PUEnUgB9eNcidD5i8x7DSefIZk9H+9f5nFcdycxuUvqltlqnzKG9amZKSWiJsIzzsPPyGYzQ2J
	 YIjiNVKn/6EE5AM7WUR2i2TNlhK7l3RdJVLSa+nYnx8r5qe4buQm3dXT8ysbe8/bE/YG65pf7FCn
	 343nchstkYuz20BFcFz5ftfMio5L3t6DTrFcCZyUx69y07XOrJbC7znnkXj4td23mBNDwvSU/QfK
	 WQ8+Qw6vE0J27YSNA6/LIIXS9Z1VHwoJHFQlR7evmv+BNL4pCGjgb2YH/0s7g2r1qK28NJHmPuwF
	 Co5m4mN7S/nCwlbPZk3IilOnP4ydsAvzfwmDaa2S8zVMBS1nyFmpZatrcGAopq2gAgPB9Z2w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Aina Boot <bootaina702@gmail.com>
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
Date: Fri, 22 May 2026 23:09:26 +0800
X-OQ-MSGID: <20260522150929.1949-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <780a52d9-7119-4870-990a-16280005503d@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/22/26 1:45 AM, Mark Levedahl wrote:
> >
> > Additionally, [file exists {gitdir}] checks for the gitdir file in 
> > the current working directory. Since the function has not yet 
> > switched to $_gitdir when this check runs, it is almost impossible 
> > to find the file. Consequently, this logic never triggers, preventing 
> > linked worktrees from being recognized. 
> >
> > Maybe the identification of linked worktree should not directly look 
> > for the gitdir file, but should check whether there is a.git file and 
> > its content points to... /.git/worktrees/... ? Anyways, using the 
> > literal {gitdir} to search in the current directory lead to risks. 
> >
> > Shroom
> >
> We cannot get to this code if not inside the gitdir, and if the user set GIT_DIR and/or
> GIT_WORK_TREE to do something clever, that either worked or the code already threw an
> error. git, without GIT_WORK_TREE set, uses the current directory as the worktree, or the
> parent directory containing .git. So, we must be inside the gitdir if this code path gets hit.
> 
> Mark

The relative path issue with {gitdir} is indeed difficult to trigger 
in practice. To trigger this problem, the following conditions must 
be met simultaneously: 
- git rev-parse --absolute-git-dir succeeds (the repository is valid). 
- git rev-parse --show-toplevel fails (the working tree is 
undetectable).
- The current directory is not $_gitdir.
- A gitdir file exists under $_gitdir (i.e., the gitdir of a linked 
worktree). 

Unluckily, this occurs in:

```MINGW64 Shell
# Firstly, enter a test folder
mkdir test-main
cd test-main

git init

echo main > file.txt
git add file.txt
git commit -m "initial"

# In feature branch
git branch feature

# Add worktree
git worktree add ../test-feature feature

cd ../
cd test-feature
cat .git

cd ../

mkdir outside
cd outside

export GIT_DIR="/(PREVIOUSPATH)/test-main/.git/worktrees/feature"
unset GIT_WORK_TREE
git gui blame HEAD file.txt --trace
```

```Wish
puts $_gitworktree
```

The current directory is "outside", not the expected linked worktree. 
[file exists {gitdir}] in find_worktree_from_gitdir searched in the 
current directory but failed, resulting in the inability to identify 
linked worktree. The blame mode can still work without worktree. 

Shroom

