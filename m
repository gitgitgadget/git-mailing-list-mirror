Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755D321AA
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="j7EvItb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zzqcJXxz"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 36BAE5C0121
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 12:41:56 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 05 Jan 2024 12:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1704476516; x=1704562916; bh=3m
	4qIGioVhdpQGP6lipXtqxaaGwV7QcuJSvGjexFph4=; b=j7EvItb7t/raATXx6f
	/rJK6tznLcRUyVHTdRG1r+kJtbd5fm1U8al2AY8TIm59Fc+SokDGvBK1I+ZAN5pL
	bvsIhij9iI+pF6UqgIUoQ7S20u8KJW9WHrn9QRNEfEWzddrnjvt2PsnK+XdPVXlk
	vOTuwAFlOT47bx4tJL/axi72L+XMK5mIqGrBL5khjyt9i32orhf6ng7+Ea65/e2S
	rajj0p4i3YtcmStNkQqQllocc+bo+wkqNHPAcGr8ie54chYgiU3qa7li3ZqL4WGa
	sLUZHiV5Ca1cZXIvAYXvkW+v8xtxlKkC0421kj1u0eXgsvFmfAySnx2qkr33i1NU
	ZKHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704476516; x=1704562916; bh=3m4qIGioVhdpQGP6lipXtqxaaGwV
	7QcuJSvGjexFph4=; b=zzqcJXxzB5MJy0Xvs2YErO492441ftLmB7CCTvdmiJUE
	LgVlhrdODbKmYxCeHrGYBAuaAuDY6th0GiOc3IYEZ8t391yNA0bqJOO+ER8sZmtd
	ZjihNCW6q6ubC2Hqc1bgUIBDTadu9vsGm8xZGDe8ashxTW2EXfLWL25ox2wYFbuD
	LFZGNtT7lBMf6/2V3Z9dOzpq6K9tzJgkKjAnSI4OSV3mRfuxbCJ7sPVs+7YiBKzR
	RbYV9Cq8pxT9gxw37s6nSLLqF0oLDAyzk1XhA2NYcEY5tWkDnOonV7kStnzVxL6g
	h9yRPgYEbdmVojjqj1Y0PlH8WWEsL28IZV29DblPYA==
X-ME-Sender: <xms:Yz-YZVmZNKSyB5Pt8FxvFFnAvyKPxDOTS0YvchVhYJtJXz_buLDEnaw>
    <xme:Yz-YZQ1dLQAcADR86yAzKXC4xeTiOzf6eH-B0kApbcUX-P8DH1FSh_oLFg3A1xmRG
    lL-d6HNTPVbznohIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeffe
    ehffeltdduveetheeiudeihfejtdfgffegffdutedtffefteevteefvdfhfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ZD-YZbqkRto43HwF3F5Rz5RGoJUFAQOju0PhEVa0dY3Fy-HLrvNy6Q>
    <xmx:ZD-YZVmrbtTFlFGL4gqhoWzUVOzTKLqPVX-JgRhzEdx1cn88eHLtSg>
    <xmx:ZD-YZT2vYEE-EE29b2ZJ_U_e1vYvbaQCtIc6hT-_D7Yf21uFJL92xw>
    <xmx:ZD-YZUB2M9PBtqktlbF9LZB3S14wpeSzEV77-3yofjmB5rfd2BjIbA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DDA6815A0092; Fri,  5 Jan 2024 12:41:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
Date: Fri, 05 Jan 2024 18:41:35 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Subject: [BUG] mv: can trigger assertion failure with three parameters
 (builtin/mv.c:481)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

You can trigger an assertion by giving these arguments to `git mv`:

    <dir>/file <dir> <other dir>

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issu=
e)

```
git config --global --add safe.directory /tmp
dir=3D$(mktemp -d)
cd $dir
git init
mkdir a
touch a/a.txt
git add a/a.txt
git commit -m 'init'
mkdir b
# Assertion triggered
git mv a/a.txt a b
# `.git/index.lock` still lingers after this; commands like `git add
# <file>` will fail
```

The output:

```
git: builtin/mv.c:481: cmd_mv: Assertion `pos >=3D 0' failed.
Aborted (core dumped)
```

Also `.git/index.lock` is still there.

> What did you expect to happen? (Expected behavior)

A normal error message if the command is nonsensical (I don=E2=80=99t kn=
ow; that=E2=80=99s
not the point). Also `.git/index.lock` to be cleaned up.

> What happened instead? (Actual behavior)

An assertion failed. `.git/index.lock` is not cleaned up.

> What's different between what you expected and what actually happened?

See above.

> Anything else you want to add:

Same behavior on `master` (a26002b628 (The fifth batch, 2024-01-02)).

```
./bin-wrappers/git config --global --add safe.directory /tmp
dir=3D$(mktemp -d)
./bin-wrappers/git -C $dir init
mkdir $dir/a
touch $dir/a/a.txt
./bin-wrappers/git -C $dir add $dir/a/a.txt
./bin-wrappers/git -C $dir commit -m 'init'
mkdir $dir/b
# Assertion triggered
./bin-wrappers/git -C $dir mv $dir/a/a.txt $dir/a $dir/b
```

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.2.0-39-generic #40~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu=
 Nov 16 10:53:04 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

--=20
Kristoffer Haugsbakk
