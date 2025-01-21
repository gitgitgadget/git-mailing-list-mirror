Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3C1F4E44
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474932; cv=none; b=SfWtEOvg2N+o3CTfcrPX9dxUVxArjWWjGYGEcBJilfmPZ218dQmmFk4fBO2tEe/b8si0Hhi4ny9S5iG54ziAAnI97rpixYs1moCL7VktO3dU1Su+x47Pi+9sWZpJ8lIIWDrVs/65oIVL013/jhxENe2WUOhASUz8kMXAaQ2hRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474932; c=relaxed/simple;
	bh=4OwR9EEX+YDGJGV2mXAGOqaJGN4Z8ys4Hf9xMS50ukk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=tVlBNpbowJVJka3z3RdjdCDN6Y5IKsec3U61YJ3FPnHdGS1D1MKGSqERr9G8sQBa0JPYjVpjACx32rtoUzMqXAMB0m3jXsKPq+Gvc3ODJRrT8Tpf8V1Vc5FcxbLjO223vaqOyU3pIcOmZ6iJn3OVrZqw5m/pFR7Vv6VuWrsfpm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gregoire.de; spf=pass smtp.mailfrom=gregoire.de; dkim=pass (2048-bit key) header.d=gregoire.de header.i=m+dev@gregoire.de header.b=QhEyhiUP; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gregoire.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoire.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoire.de header.i=m+dev@gregoire.de header.b="QhEyhiUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoire.de;
	s=s1-ionos; t=1737474921; x=1738079721; i=m+dev@gregoire.de;
	bh=mMiDTfNdZH9Kr8qgZQTeFEr1QMQ+nIyZQxhIuAuJFqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QhEyhiUPDAY0xGXkunCHAo1kzESLdp+Bn8eNiWeXwQoTcFlh/XXA8IMRmjTrS1nX
	 FZunLz5qcJrQgL1JG3syX1KfNgsXLd2ArD4zG330V8c5nwvyJiBN35vc0q320NYLo
	 daduRCm61hyHxCToa0lVu23ltIGORokDiUq9GYRQUZIAepRBXS3OpwmvvOSYp36+F
	 IKdx+CDn/0MSg1PclFiMW+lGnt3LV8U2Y1czCtdKPKGmAjQfN4qnoUFUNK8YJhxoz
	 gWtBIJv6qvjxI8RPycsHHluCMpxCGmM2xnKXJ49LeraUjYcZWhIqmcOJQrZK3whGd
	 mmaeipnqgDCKBb3NAA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.42.51] ([86.103.35.92]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhUQ7-1t4WLq2CUl-00j7jC for <git@vger.kernel.org>; Tue, 21 Jan 2025 16:55:21
 +0100
Message-ID: <874ebe66-ad52-43fe-b6c6-3ec5143b5401@gregoire.de>
Date: Tue, 21 Jan 2025 16:55:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
From: Martin <m+dev@gregoire.de>
To: git@vger.kernel.org
Subject: git stash pop fails in specific git repository
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LqqfJPlmr+/FYacK9Am/bZ06J/ZYS73xRrz2SWWBHq3+NQMXMUD
 yq8gwCL5sd3z31ryy95g3BDDnl+xkRGW+shj4XA9I/g6QkO8EuyN6FOZyTs1T2sal7s8vL2
 T8JOxeD7uXmDzF3vwbkzN0UDkUc2IfLhMuvsZ+pdr6wlGi0toWAhbNrCfLwu43An0WJcqTY
 k+BoeJGEq/ExRU/WmQ62Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OyzfiM7i7I8=;DsG10pPgCTFoyNrpuEEBSIRT6kg
 +RubgOkWiuVhZdjnX1OTwwAnNi7VHafdw9JoOuhIsenJPirXKPzKIruIZOxzcXajerFR2exHZ
 vGlyAjrM3R1IpkWeyExpj09cIWfVd0J1NOBktQw5AzwmEKaRgc4RFszK6Y7NfP+T4z/Yvr+Hf
 ty3r8a1uZGqmhFAdjcVsPLuaPn9J4SiRj85u/XfgCHXIf7SdK8qEmX9g9HY8chQu6rlBIBeUV
 nlcr8r1Ak73MXqAT7Vcdqii2NP4PkonSUiVPkPTCybZwKHQGZSRrkK2E/yLGxNGAk27reBqZA
 r3dJ4Y4cRXXqkup1ZFvp2Oo1VnTOK4QRQn3f02zZTvas7HwfBci9faekWJlNhdk0iqPwtbRpr
 OWYpxhJ6ZueTqiuYumzbLuTo+95VLm2wE5p5/NfF7AU96QruaPTL2+PsiENuFpW09n2JtTQP2
 dAGdk2hhir+UrUXO+QUZOf9ILvT5VppagtT18Ax8jW++qxGX3usqveBqGANuvKo7Za1nBK0mm
 9JwSHxPQIalpWsQ9VcAz0v1x8a+F8bhQGEuj15tm+wLr5WxEpEKBAKjIn/IgZYKxm2jdgb9Ax
 4YYXp7TcNwv/WNNO8VxIcLkxaLoiFXp+Vji27UH5NlzYYK7OyZ7iKAlAo05YJWD5uAo/VPguS
 wBSymCIK5wyYvrYII2eJRPIO6TqgUCY4Ytax05LhopMGjDKhGQHnuVRE3RdWMvf4moJScpoqY
 35WpGbTDl0ClSH6du64sS22ghGZ2LHKJNFDF9jw3d1XGSdKUWIJJHDJRBAUwex1p3Pr/K0aww
 jRn4HhEtQk/cy5W9ovEaOOxRiNWNSzoN8tSLUOeASZ+iQTaD9D487oKR4MnDSLnTG4/WwjyJh
 IgWFqVuOZnhF0fjT53cTwXgT4rVKBS4IC1zluwk+FcaxreawhNzu1jfyp2GKHDx/AMuIHC0LL
 JbkxJgkY9qD3+OmRV/0Tu9vnDCju6XFnqqMiljaiolsFJLG3ii72a3mjx2FYetdsTD9w5TP1u
 TdVXoLYdAT9VVAAzdkLzJMKs3z7SEs5K9UIM3hgxBfp3FywX7pac/aH1TfpngFiOrk/Vs/AzE
 Eeqg26UNoeCVOguAi8WQajYvHEFEUxQs2mMcWVgkgcn3p9eWO+ZsL6ZgsdMDC6viFd51CNBjK
 I2O8FaJk7LldNhRIFRhQSMpDHQ8SlPewbXO6IrdbTbw==

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Tried to pop a stash by running `git stash pop 'stash@{0}'`.
Please note that I'm using "stash@{0}" as a reference here.
When using "0", or omitting the reference, `git stash pop` succeeds.
Details below.

What did you expect to happen? (Expected behavior)

The most recent stash to be applied, then dropped.

What happened instead? (Actual behavior)

The stash was not applied or dropped.
An exit code of 1 was returned, with no error message.

Anything else you want to add:

This only happens in a specific git repository, but is reproducible there.
The issue does *not* happen in a fresh git repository.

An example of a fresh git repository and the expected behavior:

```shell
# setup
$ git init
Initialized empty Git repository in /home/user/tmp/new/.git/
$ echo hello >> README.md
$ git add .
$ git commit -m "Init"
[main (root-commit) 3fb3ed1] Init
  1 file changed, 1 insertion(+)
  create mode 100644 README.md

# stash creation
$ echo world >> README.md
$ git stash push
Saved working directory and index state WIP on main: 3fb3ed1 Init

# stash pop succeeds
$ git stash pop 'stash@{0}'
On branch main
Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
   modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
Dropped stash@{0} (272c93ac3fe3cf69380a61ccaba0d90509e306f0)
```

This is what happens in the git repository that shows this issue:

```shell
# setup
$ git clone git@github.com:some/thing.git
$ cd thing
$ git status
On branch production
Your branch is up to date with 'origin/production'.

nothing to commit, working tree clean

# stash creation
$ echo something >> README.md
$ git status
On branch production
Your branch is up to date with 'origin/production'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
   modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
$ git stash push
Saved working directory and index state WIP on production: abcd1234
Merge pull request #1234 from some/feature/branch
$ git --no-pager stash list
stash@{0}: WIP on production: abcd1234 Merge pull request #1234 from
some/feature/branch

# stash pop fails
$ git stash pop 'stash@{0}' # no output from this command
$ echo $?
1
```

The same error happens when using these commands:

```shell
$ git stash pop "stash@{0}"
$ git stash pop stash@{0}
```

The error does *not* happen when popping the stash like this:

```shell
$ git stash pop 0 # or "git stash pop" without any ref
On branch production
Your branch is up to date with 'origin/production'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
   modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (3f0ed5a45d2eab357cfc47a9ff8a4f86faabf66c)
```

I added some trace environment variables, maybe this helps:

```shell
$ GIT_TRACE=3D2 GIT_TRACE_PACK_ACCESS=3D2 GIT_TRACE_PACKET=3D2
GIT_TRACE_PACKFILE=3D2 GIT_TRACE_SETUP=3D2 GIT_TRACE_SHALLOW=3D2 git stash=
 pop
'stash@{0}'
16:02:21.941329 trace.c:387             setup: git_dir: .git
16:02:21.941358 trace.c:388             setup: git_common_dir: .git
16:02:21.941362 trace.c:389             setup: worktree:
/home/user/tmp/thing
16:02:21.941365 trace.c:390             setup: cwd: /home/user/tmp/thing
16:02:21.941367 trace.c:391             setup: prefix: (null)
16:02:21.941373 chdir-notify.c:65       setup: chdir from
'/home/user/tmp/thing' to '/home/user/tmp/thing'
16:02:21.941379 git.c:455               trace: built-in: git stash pop
'stash@{0}'
error: stash@{0} is not a valid reference
```

Here we see an error message for the first time.
I do not know why this is not shown by the previous commands, maybe
that's related to my shell.
The same error message is shown when running the commands with stderr
redirection:

```shell
$ git stash pop 'stash@{0}' 2>&1
error: stash@{0} is not a valid reference
$ git stash pop "stash@{0}" 2>&1
error: stash@{0} is not a valid reference
$ git stash pop stash@{0} 2>&1
error: stash@{0} is not a valid reference
```

I do not understand this error message, as the reference "stash@{0}"
matches the one from the `git --no-pager stash list` command.

How can I debug the affected git repository to find out more? The
repository is private, so unfortunately I cannot share it.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-130-generic #140-Ubuntu SMP Wed Dec 18 17:59:53 UTC
2024 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh

Note: I also compiled git version 2.48.1 from source (using `NO_CURL=3D1
make`), the issue is the same.

Note: switching from zsh to bash does not help, the issue is the same.

[Enabled Hooks]
