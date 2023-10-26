Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419F20FC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="yfJ/+jyO"
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5910AB
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:46:49 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id C38B4FBF94C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698317207;
	s=s1; d=tutanota.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=lMdcA0z5o9uFmqCmSNAGbPSnX6qsrZH8k65DL+1g7JE=;
	b=yfJ/+jyOWGw0ueSzldCvUQKYMbgIhH13RlzRTx1HQicFrKMnbODlaIixEiZOVDFx
	x/UC5186sPiJx6+SUN3ZMBes3txe/PWfny360il6FCCQtQbrX8Jnj/UwSHvsYMpnsmL
	6z3XomQnWj94Gzb3cq9iNnINp2nzaXr57XCDM0aS14uQejy4e/K/xzo8gpULOocsub+
	pFKdqbcOGzygBtzBmt/9JApMlG7TSOaHgH8f1yn/5Pm2vFcU3gIsOUBjGWTptBjj1zh
	EJhWcgpLDgsrCPIZp2+kHk1U8V4m+69mnTlNEMmW7CHuM8i4qZHJA3M53qlPcyxc/5C
	t/atgjavAg==
Date: Thu, 26 Oct 2023 12:46:47 +0200 (CEST)
From: triallax@tutanota.com
To: Git <git@vger.kernel.org>
Message-ID: <Nhfa-Qv--F-9@tutanota.com>
Subject: git grep --no-index fails when given an absolute path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
- Run `git grep --no-index -r -- -- /usr/share/fish/completions/`

What did you expect to happen? (Expected behavior)

The command executes the search successfully.

What happened instead? (Actual behavior)

This happens:

triallax@satoru ~> git grep --no-index -r -- -- /usr/share/fish/completions=
/
BUG: environment.c:213: git environment hasn't been setup
fish: Job 1, 'git grep --no-index -r -- -- /u=E2=80=A6' terminated by signa=
l SIGABRT (Abort)

What's different between what you expected and what actually happened?

One of them is an error, and the other is a successful execution.

Anything else you want to add:

Interestingly enough, this seems to be happening only with absolute paths f=
rom
my testing, and it happens even when the directory that's passed is a Git r=
epo.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.8_1 #1 SMP PREEMPT_DYNAMIC Fri Oct 20 13:35:41 UTC 2023 x8=
6_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/dash


[Enabled Hooks]
not run from a git repository - no hooks to show

