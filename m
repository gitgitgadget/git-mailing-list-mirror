Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779113;
	b=K7sErwUmUok89DxjID/1DPQLPC8zizVDrdOmZhCLYUlA8pQWzrBZOZYhPAW72ecFgWZw
	 BI2vFswTTJ09JD1PGRTPFHPxqgM7HYZ7zl/MmMYPiiuuQDtO94Tu0qg2SQhuAeDiL7U90
	 baHeAIGL2kBrVB2lLLtxMBFrenT0vIgH/Bj8EfRGC/mGNHD2RET/OxbWxr9caACFPpfIS
	 cpvkcfbDahVUujXqORVZbuNBNlTiSCgfooEYlXixRsa6jytClue++3npWlZss9eZZmON5
	 IU7uC9YcpC5CsKUwYcAzGybmam/9oU+6Kg8UZ9E/ZIq6oky/ZAYSOogInIcCJSNrlhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779113;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Subject:Message-ID:Content-Type:Content-Transfer-Encoding;
	bh=N9DVQFuq8YyVtlb90m56F5+0wiHtMf0Ng+7/J9B3GjI=;
	b=pttRM3jVl4mgpVkh8IRZ8AFiFckeyf+XuHG2fsiT+ZbIxvfS1VbTTCVBZvq8MBdHWOWh
	 1LwTAPwHiTB2xwVs0UhkNawotgIyqH+xV8uRKNOiKB/87iOTZ+kuOs6r522EYf8qyYaiZ
	 OyXAZw3fjfTX4ITmQCJ9NWquZmsNlyqE/rSIPwiy0EDrur/xTmMvtmWOHa6BfZm0s+exl
	 L4tVC1dGz6j1XBLgPcXiCfBgKayCWXYWGOo8WhksSqSiPgO8fQ8ucwzk6G7FysM0s+Qar
	 YY/GErHhESWkUAgzLnWZoRfkBKGdilpT5ynnXgBwxhVg5bCD0bMC5qInLaFvIS0uKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=hKp1wmWx;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50A606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA50A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=hKp1wmWx
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5B7F4240101
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 08:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1793779105;
	bh=N9DVQFuq8YyVtlb90m56F5+0wiHtMf0Ng+7/J9B3GjI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=hKp1wmWxVx6pJ6DXOSCh98TLfWULPn/0P1M+fF2h4jgXdFCj+25EPe1cKPNQlzAgx
	 eYMA3uAvIVTiC4c99FnfO0uaBcWqpptvHmllwRZIa29ieutFOK/l73oxYct05+ZCSl
	 RYFtkL0pg8hXQMqF9I/03yMV4YpvQ7j3NXO8lzNdfvyTpN2ii7IdKw031kGfOZcckj
	 H+dWz4gbdEnT9ZeH2ILZPI+h2GG1tUNmSRN8zI963ickBTDFQfwhm0uvv5DWWBMkjI
	 o3mHs+qNYC6IsQznbdUBhyOLVl+mjmITkz8CpM4Ua1Ax6vEygHT02bh9FYMojAuU10
	 hQ0gVBSFHqi3A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKHr10FBrz9rxK
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 08:58:25 +0100 (CET)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 07:58:25 +0000
From: b.murauer@posteo.de
To: git@vger.kernel.org
Subject: bugreport: performance regression on git log --follow
Message-ID: <1491d49cdb1a96698e5572d9de3ac280@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I ran git log --follow on a single file in a repository with about 30k 
commits
and 27k tracked files:

     git log --follow --oneline -- path/to/file.ts >/dev/null

VS Code's Timeline view runs a similar command automatically:

     git log --no-ext-diff --no-textconv --format=<format> -z -n551 
--shortstat \
         --follow -- path/to/file.ts

We regularly merge older maintenance branches forward into main. The 
affected
file was added on main and does not exist on those branches, so many 
merges have
a parent that lacks it. The following command reports 692 commits for 
this file:

     git log --full-history -m --diff-filter=A --format=%h -- 
path/to/file.ts |
         sort -u | wc -l

What did you expect to happen? (Expected behavior)

I expected the command to finish in a time comparable to earlier Git 
versions.
With Git 2.43 on the same history, it takes about 1 second.

What happened instead? (Actual behavior)

With Git 2.56, the command takes around 10 minutes. It uses one CPU core
for the whole run, with very little system time, and output appears 
slowly.

Bisecting between v2.43.0 and v2.56.0 identified this commit:

     304812ed33 (log: improve --follow following renames for non-linear 
history)

What's different between what you expected and what actually happened?

The command is around 600 times slower than with Git 2.43 and is 
effectively
unusable for this file. The output of the newer version may also 
legitimately
differ on non-linear history, but the slowdown is the problem being 
reported.

Anything else you want to add:

perf report for a 20-second sample with Git 2.56:

     24.67%  hash_chars
     10.37%  spanhash_cmp
      9.91%  0x0000000000043558
      4.90%  zng_inflate
      2.89%  bsearch_hash
      1.86%  dowild
      1.45%  diffcore_count_changes

This points to rename detection. My understanding is that the commit now 
runs a
follow-enabled diff against each parent of a merge. If that parent lacks 
the
file, Git looks for a rename source across that parent's tree. This 
happens at
every such merge, so the cost grows with the number of forward merges 
and the
size of the tree.

Things I ruled out:
- The repository is a full clone, not shallow or partial, with no 
missing objects.
- It is freshly packed: 0 loose objects, 2 packs, about 1.37M objects, 
543 MiB.
- Disabling the commit-graph with core.commitGraph=false does not help.
- Ignoring global and system config does not help.
- Git LFS is not involved: GIT_TRACE shows no external processes being 
launched.
- Setting diff.renameLimit=1 does not fix it: the command still takes 
over a minute.

I have a bash script that reproduces the issue, if needed. I'm not sure 
if
such things should be shared via this channel.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.56.0
cpu: x86_64
built from commit: a018953688f1b10bddf91bff8747068f5f4746a4
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.22.0
OpenSSL: OpenSSL 3.6.4 25 Aug 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.2.14-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 30 Oct 2026 
14:32:40 +0000 x86_64
compiler info: gnuc: 16.2
libc info: glibc: 2.44
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
not run from a git repository - no hooks to show
