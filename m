Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0B27A107
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869337; cv=none; b=kOdAGYKO6Z9ZvVG5kvRgvtO/2iYLuN2zf2Sf5HdeMoWbXogrylqhWLUQVL4qZTVrQSiET7iALvLnoGtwtXgqKHgrXJRdrPKRuasSGS/1SP89Vp5yJeQFW43wnaTpu03nxw8P328QVnyEXozW3nVB/UvlSlr6nvmoVL7+P1nu0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869337; c=relaxed/simple;
	bh=99lkuQRfIAFnXT4B8F5zYqbxeE+I01+yZGybWYaJ7WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=naudMYzKKZRTv+V7wQRu3grqmYT83i9twIjUW2KEGLjmDek6e+K+8OXEKxSl7floaQCN/mtbVMYdWu/xcLUusN6ZpVAfsipFedE0UtEFsY5NmfpNWteXCp5gEl6+j7MWDSO1iCXmwVNFtje4uZcWsArnXg0TjqCAJy6wOF5J3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VkxPjC/L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmlQKjIu; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VkxPjC/L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmlQKjIu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DE261140259;
	Mon, 28 Apr 2025 15:42:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 28 Apr 2025 15:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm2; t=1745869333; x=
	1745955733; bh=SYUPydMPeqbedAquVXnSI32OOjvymIWls85XsFd2FT4=; b=V
	kxPjC/LoSd+DfZqEukw/Hi6gonlIyOHvBkwY9rgiA8j4lGNYtKEd7x1bGVdz+bK6
	Lrdo9pY3PS45Y3xhuxa73hUJsq4POO9lXSpXs2goA5zeXPwBsv/6aUcsiFxLXpYX
	7DHTreLu/t+mH8GT8kFjIrDXIOR/swjhnv/AikxbjD4X1JUBAYFlFXgTJ3YLXO8Z
	vAtwD1rDd2QQECDq5h16odO83HBv1eKu9Jq4U0OD8elXR4lTMCpT98H3CRNNKPGx
	G4JApJsARzFnEkZpASzx/fSZWO7AJm1RmXrBZjJnD662xP1RMqwKNwzg3Q7JzI0J
	iNQeJRZJtoNpafE0xBe0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1745869333; x=1745955733; bh=SYUPydMPeqbedAquVXnSI32OOjvy
	mIWls85XsFd2FT4=; b=EmlQKjIuRK3C9J38e4c3HMuH/aIbuJEn4+21ltCC+Lxe
	n52p4xWncgaZU20XEZtaIKrXkXmqvEsSopcLaSBURVwoidjRpshK8jppcC+i7k1H
	jMCF/vIGlhVV0bN8DhoKfJib4vbLFSoVosbDghjXPmQ+wkgupVA8fYaafHmQ0lGf
	NDYZSSUtzAmDOTUy/squUEgHyPZemb8oFyG82rMOOSNiljWNy8zzD3EB3eW5Xt8i
	ysAKC7qjpmyqO7CL2IbaVzWRPowfTSlbFsZF2Z8jPq7GSsQLrh6v3r8pRDDXnVpz
	PFpTJy6KyMskyeP6/VJExgBQob8ayninWxUcju8oKw==
X-ME-Sender: <xms:FdoPaBvPoF8ulwBSYNOcbgf8Zn7VOxLZ_dWTJQHe6u8OIxfeNDziUzs>
    <xme:FdoPaKeMZNB5ewBCWhkcx-glyBzWmIgHGAElQySIl8ot3lCEWqv6ag_uweiQiwsuE
    wiPQ20Tw9LwjHArUg>
X-ME-Received: <xmr:FdoPaExFgoRkKnQeoz9B1tWP1KWsq6cWo4bFgpz39UJkxhgV81gO3_b5OVgESJ7OlYSuDr82NPGSQFwlIYq_8VrihCwv6AD0Ug4rU0G6U3Qazk-sWMUFVRVNyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffogggtgfesthekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpefgvdehgfffkefgieehiedvteffleekhfehiedtjefhlefhhfekvedu
    hfelkedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FdoPaIM1rYSt5x2UHx7R3VkIVIqOxWvKlXLwJjoNkh7HIEtN_9xLlQ>
    <xmx:FdoPaB8_20Z4kRAGcU9GgkHI22kqTahl6o0K6mGZRiTnaHsh0K5k4Q>
    <xmx:FdoPaIVWirm-CurwfPJvEC5j2jhVAAcz4EqzpZ8l6JAWwhZIv8j4TA>
    <xmx:FdoPaCfm29RjzxCRnuQfv9uyG9-KGXAzmV9WW0sFyA2YbQYJpOqZ7g>
    <xmx:FdoPaCKvmKERKcfYYkvGdPbnZoyBxWvkKer8kVAauhB-PKHwHoZyG_Jz>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 15:42:11 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	code@khaugsbakk.name
Subject: [BUG] rebase: can write reflog with uninit. `action` string
Date: Mon, 28 Apr 2025 21:40:43 +0200
Message-ID: <20250428194048.149348-1-code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.459.gf65182a99e5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: code@khaugsbakk.name

We did `git rebase --rebase-merges` on a branch with merge commits.  Including
back merges.  The reflog after that showed some weird symbols for
certain merge commits (only merges):

    e9c962f2ea0 HEAD@{8}: <binary>�: Merged in <branch> (pull request #4441)

Some merge commits were normal.

No backmerges were affected.

We have a main branch.  This other branch was created from the main
branch.  It had been kept up to date with backmerges.  Then someone did
a rebase on it once it was supposed to go into the main branch soonish.

It looks like the string is uninit.  The values are different each time.

§ Bisection

Bisects to d188a60d722 (sequencer: stop exporting GIT_REFLOG_ACTION,
2022-11-09).

§ Reproduction on latest code

Reproduced on `master`, on f65182a99e5 (The ninth batch, 2025-04-24).

§ Gdb

This is the backtrace when I get the apparently uninit. string:

```
#0  run_git_commit (defmsg=0x555555babe70 "<repo path>/MERGE_MSG", opts=0x7fffffffc070, flags=0) at sequencer.c:1158
#1  0x00005555558740d9 in do_merge (r=0x555555a67020 <the_repo>, commit=0x555555b75cb0,
    arg=0x555555b2164d "<branch stuff> # Merged in <branch> { (pull request #4464)\nlabel branch-point-9\npick 4026b5ced849724bd3857283b6ad50c8609b6d33 only sh"..., arg_len=125, flags=0, check_todo=0x7fffffffb1e0, opts=0x7fffffffc070) at sequencer.c:4380
#2  0x0000555555876629 in pick_commits (r=0x555555a67020 <the_repo>, todo_list=0x7fffffffbf50, opts=0x7fffffffc070) at sequencer.c:5048
#3  0x0000555555877eeb in sequencer_continue (r=0x555555a67020 <the_repo>, opts=0x7fffffffc070) at sequencer.c:5480
#4  0x000055555563a491 in run_sequencer_rebase (opts=0x7fffffffc330) at builtin/rebase.c:369
#5  0x000055555563bc74 in run_specific_rebase (opts=0x7fffffffc330) at builtin/rebase.c:746
#6  0x000055555563fe2a in cmd_rebase (argc=0, argv=0x555555a73890, prefix=0x0, repo=0x555555a67020 <the_repo>) at builtin/rebase.c:1878
#7  0x0000555555574c0d in run_builtin (p=0x555555a34908 <commands+2280>, argc=2, argv=0x555555a73890, repo=0x555555a67020 <the_repo>) at git.c:480
#8  0x00005555555750ca in handle_builtin (args=0x7fffffffd8a0) at git.c:743
#9  0x000055555557538c in run_argv (args=0x7fffffffd8a0) at git.c:810
#10 0x00005555555759e2 in cmd_main (argc=2, argv=0x7fffffffda30) at git.c:950
#11 0x000055555569b0c3 in main (argc=5, argv=0x7fffffffda18) at common-main.c:9
```

§ No reproduction script

I was unable to reproduce with a simple repo. setup.  I tried:

1. Creating a side branch which had a merge
2. The side branch conflicted with the other branch
3. Rebased with `--rebase-merges`

-----

Normal bugreport questionaire follows.

-----

    Thank you for filling out a Git bug report!
    Please answer the following questions to help us understand your issue.

    What did you do before the bug happened? (Steps to reproduce your issue)

`git rebase --rebase-merges` on a branch with merge commits.  Including
back merges.

    What did you expect to happen? (Expected behavior)

Normal “action” string for the reflog like for example `continue`:

    3f90f6ab14d (HEAD -> <branch>) HEAD@{1}: rebase (continue): Merged in <branch> (pull request #4507)

What happened instead? (Actual behavior)

The “action” (or whatever it is) string is arbitrary bytes.  Like some
uninit. memory.

```
e9c962f2ea0 HEAD@{8}: <binary>�: Merged in <branch> (pull request #4441)
```

    What's different between what you expected and what actually happened?

Apparently uninit. string.

     Anything else you want to add:

     Please review the rest of the bug report below.
     You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0.459.gf65182a99e5
cpu: x86_64
built from commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Linux 6.8.0-58-generic #60~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Mar 28 16:09:21 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
