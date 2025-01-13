Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEB23315D
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778229; cv=none; b=Xwu9smS3OdBUfRaNIkVw/BgbhWT8Z/aAX8XCKud8jtfIHgsp6GIETpTo1uehbReLCwMYRsdf+QSwVNns17Nqb4L2RfR+JQ6c2Jc47CppxHH6TkdIBpZyYaGLBrnR2Ke+4AbrjGJf2pPOmlDkpZDgUuQskhGI5BqoYIh+99+8/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778229; c=relaxed/simple;
	bh=EVfpwqXNZSlKY+6IVpmtytJYUrWthx/AqItsiVLWuxU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=OWlWVOdX16zZgFgx6mCERculIPvnISzZyC14JtgUASBlo9hFAQ0IHSO0/F64gNVF07VcVyEKSYofaDr7n9xhhV3gAnRj7lQ9em8u9WaVRlE6QB6qSivryFifgVInT/s3ChL4OXVwd7ybwqfFXIHG/HxI+Sm4YZ7OccDm7khIzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2DkQejY; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2DkQejY"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29f88004a92so2597312fac.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778227; x=1737383027; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvwXW0n2HxvB0A3WF6Zxp2NmOgYbbJQa6w0IuNsoOjM=;
        b=H2DkQejYtJl2jWfSOztPcRYhUmNfUAxmOxe58TTzW0g1uTZ98O9bxLceq7Fv0e1K4n
         gAZZ3lWO3TzYAbYojEfwaXu19lp+sNsLoZ/w+OYPb8CyZHVPpC8B5/ZCuWsxSXhIyg00
         y5T5yDYEu24OWbGlSbDTQ436BeLr+QC7W50aCbcP4Z0ZVRh1PTyrNK0YziMMPL1UVHox
         zR90G6yjM02UezpPT2g+Eavb/CS+OI6RhcxjuW3Th3kHGgI8PQlkLld8GNY0vN7gW6ld
         iVTrsPL5RkYRBRrlwq0XNVw4dmYPG/IAfkHccgMuqJhahHd3+gH/0xW3zjOO4zHj8DZ8
         yYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778227; x=1737383027;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvwXW0n2HxvB0A3WF6Zxp2NmOgYbbJQa6w0IuNsoOjM=;
        b=X6ysRHcQ4CQIn4UNKVDiW1SOo3mRJ4j4g2nzda58oeXDvwCSD9qdqPDC8bbobZJG3F
         zeiy17cjA7DB7zWu4ghOATEuVEfo2Evsa/TD15kCLXTgIC8lD8bwpzklsu4MFWXyPMyf
         +3rs9QuKTkpYVDsjbZYEIdGP12483b9HBcGbS0wRLonIWh0Kb4UC3zhRTA+CjJMyBasr
         RDJSo0fgFI7rLMqO55IzmOQNrOBmsHeujLg2fgnJQjQtwB3As4MKS63I9kioJLxuQnQG
         nOxRUtU+da23CDOub2WYVMd3vil0J9xc5gMigL/S4NZ99DjXOvM0Q+Ia28k5DNhd/NuW
         PCzw==
X-Gm-Message-State: AOJu0Yzq74OyemvzNGHM2l4qcMaINu0yM5P2G8LElu1OsRyf7doQvu47
	ummjUSX0rSYo59mLKmw1JQN4HOPx4YYyyjacyfmQdZH9jgKiE8kzW4DlOw==
X-Gm-Gg: ASbGnctQ4Sle/irmY9gqYaFZnbyqIyOSbW9De5M2MeucBbmWLG+39QF48wHDSreByOk
	/djCt06CXqKIccljqeV2KQGlfuEDHjr+jAZNABhuIKBVJlipQyWPdTve5Jw7KMIvtWxcBy2LgwV
	ROa2sN/21nYonLKXu9HMBzyduOl9e1fkBewJlwYFs0XwmVMV8KN7dYbab8t0p13KXAMIAVFhJrr
	JVX2cJZO3l8POAB7kHf4tZ5fpmV2m5U+zlhZxc2WTQxvRs4+HAe/a8LaOlyn6h0PeAI8davZEae
	ZX8E
X-Google-Smtp-Source: AGHT+IHtHyOkS3RjQcsWRkCu8WGlm4PlY7imOnMfPRdPreH4rq/sbMuTZdwmAx8cGQx64JPl08kblg==
X-Received: by 2002:a05:6870:9c8f:b0:29e:5e83:150e with SMTP id 586e51a60fabf-2aa069a90e2mr11770314fac.27.1736778226686;
        Mon, 13 Jan 2025 06:23:46 -0800 (PST)
Received: from smtpclient.apple ([189.122.187.57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad804af5desm3846232fac.1.2025.01.13.06.23.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2025 06:23:46 -0800 (PST)
From: =?utf-8?Q?Andr=C3=A9_de_Castro?= <aramosdecastro@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Bug report - Apple git
Message-Id: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
Date: Mon, 13 Jan 2025 11:23:33 -0300
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.3)

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Checked out a branch, ran "git diff --merge-base <some-annotated-tag> =
HEAD".

What did you expect to happen? (Expected behavior)
To see a normal git diff output.

What happened instead? (Actual behavior)
Didn't get a diff output. Got the following error instead:
"fatal: --merge-base only works with commits"

What's different between what you expected and what actually happened?
I didn't get the expected diff output and got an error message instead.

Anything else you want to add:
Seems it happens when I use a tag as one of the commits for git diff
--merge-base. This is on a macOS, with apple git.
On Windows, with Git Bash, it works as expected.

I can get this to work with "git diff --merge-base $(git rev-list -n 1
<some-annotated-tag>) HEAD".

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.5 (Apple Git-154)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 24.2.0 Darwin Kernel Version 24.2.0: Fri Dec  6 18:56:34 =
PST 2024; root:xnu-11215.61.5~2/RELEASE_ARM64_T6020 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-push

