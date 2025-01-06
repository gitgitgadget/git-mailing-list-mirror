Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80F1DF961
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190628; cv=pass; b=RHUJwyQ5P8yshai9QJwD3Ecz34Xt4DWwBF84j/uJIhKyCUUL6nBd6LELvoaC3MZJo34gUj+QLx8SiXnC+BTte4VkSznmJXr2z8zraSM7z0HP0OrLMMUb8rs88Udac13ABY6MqZTsBH1W5G15RNxsiqIj3Uw3ZrWVaIcle03iOoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190628; c=relaxed/simple;
	bh=0ur6zZdJzJ7WQfsKIJLQiKdfeAuu4JS7Olfb9zRheEk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ll2N3eSGAymNGD39MdW1+HPVf8W4BFEg8vd7qmF1Chk2BBKK7/ttH0eBqnNIztbHZB43LYRxfGXk64QJXTYRe5E7s6iI1YbHlknp0+n6pgqDIr2VFg4+Cj88GSSKAPHOX78VpGnzyarMKejwe4nGAg1yaLtQdSev3RHKT6W84UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=braunis.de; spf=none smtp.mailfrom=braunis.de; dkim=pass (2048-bit key) header.d=braunis.de header.i=@braunis.de header.b=stSCC4D1; dkim=permerror (0-bit key) header.d=braunis.de header.i=@braunis.de header.b=LWBb3cWq; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=braunis.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=braunis.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braunis.de header.i=@braunis.de header.b="stSCC4D1";
	dkim=permerror (0-bit key) header.d=braunis.de header.i=@braunis.de header.b="LWBb3cWq"
ARC-Seal: i=1; a=rsa-sha256; t=1736190434; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zl8IOoZJ/4ibINBqFNuENNA0SXskhijuxfm+JCXkr8/y59BeFeJKjXGdBfa9Qqom3K
    dCUE7m3ms9oOzRyFsQhRvnG/5PD4CBX3uFihw6RQRvBV991qG3EjCGxfNJrw5nmuDyVd
    p08oG6FEGBNd894/H/BRToYmWMzQMABgIigTwSqCoouXNisDNf/MFHG6Drd/KSQNejvL
    nYoqlHwfKodvF9rPL/+gW5wXsUX+SPoSChNpgHEYVMR2gmvsMvMpujRDez60+vqapoHf
    Psawhk/RSeNINh5GaLnZyAG/8M0UNfkKW77itLjvMtPSCqH0MgLcurLyUjretK80zAh5
    fSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1736190434;
    s=strato-dkim-0002; d=strato.com;
    h=To:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=isvUYtdZzoydjJUmIF5Ac1QSrTB8zSUTz3TBdfC7VcU=;
    b=YLSo7UEPLM2QJfT/YsyvnqlBOx3FRrJWQGxrxTslu0Es2y/Tpx1iEiObWB14tI6zTJ
    abMkaHQFt1eIUKgDO/SG/sLVPtDpjRM6w50qWIQ36Tl415Z6SLoXiNhJKPW5CFDZzgwq
    Fd0dyBGaMSCWT+KVSuyxtabEof1/zSV9HknSkJRzBgM8QqVgi+6tMQhkD0eK9+GJu6LN
    TwlLjCnpSCoBqIVp5qeMg24d5e9H4WlPUSdut3AOIPq3f9ZEy9wADxM3JO2q4ZAQUirc
    pTHqA55VXPHl1xxu5OIv2EtDeG5aFOiMXN+gFTrDut50pbGvZpY5hZkts/j1dfIUACkd
    rxYA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1736190434;
    s=strato-dkim-0002; d=braunis.de;
    h=To:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=isvUYtdZzoydjJUmIF5Ac1QSrTB8zSUTz3TBdfC7VcU=;
    b=stSCC4D1DtFPMPPgcq++1Deomi+amS8dXWN2iD9Qjk1Jux4dJa1y+4wT7tOIZfT2sr
    O1iTiR4UkAOh/9w7tBNlXKSQC2Jjo+2cS5kXvZU3MfcHZjzbhYcYmnB10FC/s0URYxj0
    X2kHN6OatgKHLItcr4C/8jCLk8CwlRTgxUgGXaVQx0SLd4OMy0WlITEn89CFohhk/sKe
    JaTFVOG9qVvSqgIdEjyX8QYny9JmFo6vhyTvwJ80ShD8ro6yhnJ+Vd60LMtm3rNt6dQv
    jMUacSeaGZkvLX+KeQg8RgavFPUyDJxEVfcilfds8JEBAEGLhAEwvTiKvY567sQLTu76
    2XDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1736190434;
    s=strato-dkim-0003; d=braunis.de;
    h=To:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=isvUYtdZzoydjJUmIF5Ac1QSrTB8zSUTz3TBdfC7VcU=;
    b=LWBb3cWq4qENKolha6XGayl5y1tGNIs4Ufvkp4IJWBIw63uw2TOtjXs/3k983C6kTK
    0Oxyy8ZIlNGNHaYLNpDQ==
X-RZG-AUTH: ":IW0Qb0WIee3a21CBOtQF9AagGrTpdQbKPSX42fXTEDPuXTelIxqFqblING52fS3Uaw=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.16 AUTH)
    with ESMTPSA id K87de7106J7Deq2
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate)
    for <git@vger.kernel.org>;
    Mon, 6 Jan 2025 20:07:13 +0100 (CET)
From: Matthias Braun <matze@braunis.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: bug: Removing branch and creating branch-directory with same name
 breaks
Message-Id: <25913110-E42E-4028-B39D-44045623FDC4@braunis.de>
Date: Mon, 6 Jan 2025 11:07:01 -0800
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.200.121)

(Note that I also tried this with latest git-2.47.1 after creating the =
repro script and it still fails there).

What did you do before the bug happened? (Steps to reproduce your issue)
- Removed remote branch. Created new directory (for branch names)
  with same name directory name as the previously used branch name.
  After that `git fetch` fails.

Reproduction script for your convenience:
```
#!/bin/bash

mkdir -p repro
git init repro/remote.git
git clone repro/remote.git repro/cloned
pushd repro/cloned
echo "hello" > hello.txt
git add hello.txt
git commit -m "test commit"
git branch mystuff
git push origin mystuff
popd

git clone repro/remote.git repro/clone2

pushd repro/cloned
git branch -D mystuff
git push -d origin mystuff
git branch mystuff/branch_in_subdir
git push origin mystuff/branch_in_subdir
popd

pushd repro/clone2
git fetch    #  This fails as branch turned into directory
popd
```

What did you expect to happen? (Expected behavior)

`git fetch` should work...

What happened instead? (Actual behavior)

`git fetch origin`
error: cannot lock ref 'refs/remotes/origin/mystuff/branch_in_subdir': =
'refs/remotes/origin/mystuff' exists; cannot create =
'refs/remotes/origin/mystuff/branch_in_subdir'

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.0-0_fbk12_hardened_11583_g0bef9520ca2b #1 SMP Fri Feb =
2 17:56:12 PST 2024 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show=
