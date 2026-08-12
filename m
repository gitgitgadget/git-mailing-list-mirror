Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE22ED141
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537909; cv=none; b=Yv/KvP1zBKcyVgeNWt1L1LHDD/qdsrQ7c2/C+kNjP0S7yEd40RwrX+G6RMHSkpSGy/JFtkRDv6q05mOiVOumtk3c4kl0XBKtBLLanqXUK8bXyMaYBzI0c3yzIm/TkBdB/WofzP8v4cMceE7irni9/kLUOSsUZhDhg8VEWOAS2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537909; c=relaxed/simple;
	bh=X9POO+r2NIZ3ERt4xUt+ooxqZGg55OzW7nPXm8pDR2A=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=mRz+bY4TexFdvthNoTZoK1cZOWRYW+CXT7+LVxEa2YDKBAABA7IJ5Br56bOdph832mbtICet0a9IVwnwwxJpIDYm2NuPwxzWyZ0xvhDzJLQafnLMoLDYfo2I///exNQx0UW7LdQqpX4s/37+QxirFxsLmBE7iIXF+AmDwNkdko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWBE0tEt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWBE0tEt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so498021f8f.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537907; x=1787142707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:to:content-language
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLIivRaWRvYZ1F/mlsHL3WjlnuLimmhFXMTSKchfy3A=;
        b=NWBE0tEt8syC0C4peCIijdksL1jml7wpBf4xLaZ6EVQKg1289nrSG9Kk3oc9BP6oei
         5QLlNm5iTYEcPAWldwTUXgsdR5Iegi4AUjHnra0xkV6waK0flYpSbjoq+tKpnSjgfwNy
         LW9vna22oVVTX8WvZfx3OSnTJ1ZN/4+cz4E+YRVRn/2uGIsc6sloQC1ezmmiW4EugVwH
         eK8o4IG/W2Md+4zikgK/ois4l5w46lEIYPs8wsCkiXLJ3VI6PPDyyquCivyShcaahZqt
         Nkcf2VOf/GRuBQDpv8jbpZ0VUQQfGPpZbtm/rGRq6jGfYuWk6+kqUZj9etnOHkQfVEk8
         Nvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537907; x=1787142707;
        h=content-transfer-encoding:content-type:subject:to:content-language
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLIivRaWRvYZ1F/mlsHL3WjlnuLimmhFXMTSKchfy3A=;
        b=UkC96P1LEXQqhlotDL7Sqvv6ph3f0TJaGxxK0NQzZ8beStetZ9iYeWkfbtJecd6gbh
         F/VGuT+97fZNe1safpo18UY6uyiBCWuNa2jaLYBZtAPB9mTiS900jVZLmUAYyqe4tYIy
         wych9bQYS63CO+i4Iwb536VZXwpN1T8UmTCsyXAQClxFiBEKPp/g1quYa/sMpW16ggT3
         aj+CJcywq5ZExQTi2nNHh+8fUoj3qRszaoynxZwnEyF1ACTTN6/wMGQ55auiy2cnTjtS
         Ps8bSLrr8j/b8qP3MmPDRCeoHn+SNb7mmvHj3buKLBXnIBns6OeWnJ3HnNncg6eXH9c6
         L1sA==
X-Gm-Message-State: AOJu0YwBp4YMwa+gqkV3/CVIl3XYqB8IZQEJ5dyeprVJR6PSfobZV45o
	Sy0VnpUppFBOJ3rA4eB+IH62OvNSCfCcvODpuZPBW8PKRXv5eDoNUuW/qNKOvA==
X-Gm-Gg: AR+sD10WcQ7oyM6a7BRXKVtDN77D1/+uPP7DfHxQQ9dWYLIExGz1R9ymv1rXO+Wd3rf
	rvsmtf3jwVZGxGZuAtas0pMJjS1a3S1HQGamgpO0VQmv/Xetm+YkHrIyJi1LBJ07q37MOHAh05X
	FykdMLkS02IpQ1oIWXziW1rOzSkGTeRyaIvbRP2ssDYU9cvY6umzI5yMZg4z8Q1iMEHaBnOKz92
	89E2aFXGZvEy84daVo/dBssU0ptrRCTxjtDoY7WExl4QHzwJ6BXJtqap59KYRe9L2PnmrPwxVWK
	pRVAFxXWqJXQn3nT5N4eukhc0Ac6ckCQjAjHWhsV/gHK8R11S83ZaJR/2wU+dXoAObEpa0QtDMV
	ZNlyk1un9r82Y8N2ZjWA4V28OW/bTCGGTuKEQvzBXmLSqmO9oxgeWLpp+d0S+sC75eO3jPY4fhT
	oXB4AUeyDjPHjlChD8F+NpsRCFWzYr39vFjzWoG0xGSO+CsXzdfo7bWymfyUfgmwYe6LNHRBPaX
	jQ23BZw9iFxE3iu
X-Received: by 2002:a05:6000:29d2:b0:481:568e:d6ed with SMTP id ffacd0b85a97d-481568ed7b7mr1438645f8f.15.1786537906580;
        Wed, 12 Aug 2026 05:31:46 -0700 (PDT)
Received: from [10.0.1.15] (85-71-82-202.rce.o2.cz. [85.71.82.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d72141sm7200574f8f.36.2026.08.12.05.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:31:46 -0700 (PDT)
Message-ID: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
Date: Wed, 12 Aug 2026 14:31:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Content-Language: en-US, cs, en-GB
To: git@vger.kernel.org
Subject: Bugreport
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

What did you do before the bug happened? (Steps to reproduce your issue)
I called `git lg` command to display git graph log in my terminal. The 
command is defined in my
general gitconfig file as follows:

# double liner with hash, time, branches and tags on first line and the 
message on second
lg = "!f() { num=15; if [ \"$1\" != \"\" ] && ( echo \"$1\" | grep -q 
\"^[0-9]\\\\+\\$\" ) ; then num=\"$1\" ; shift ; fi ; [ $num -eq 0 ] && 
num=999999999 ; git \"$@\" log -n \"$num\" --graph --abbrev-commit 
--decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold 
cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold 
yellow)%d%C(reset)%n'' %C(white)%s%C(reset)' --all; }; f"

What did you expect to happen? (Expected behavior)
I expected to see git graph log with the project commits.

What happened instead? (Actual behavior)
On top of the project commits were added these four pseudo-commits made 
by some Git component(s).

* f7b611ce - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
|  Notes added by 'git notes append' - rewrite-analytics
* 1a7605bb - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
|  Notes added by 'git notes append' - rewrite-analytics
* c2a05d79 - Wed, 12 Aug 2026 09:25:03 +0200 (5 hours ago)
|  Notes added by 'git notes append' - rewrite-analytics
  \
   * 01c630e0 - Wed, 12 Aug 2026 09:13:00 +0200 (5 hours ago)
      chatter: initialize notes ref - chatter

They are not graphically connected with the actual commits, they just 
sit there over them. No other graphical
tool (Sublime Merge, IntelliJ Idea) displays them.
Originally, when I opened the project, only the first (chronologically) 
commit (by chatter) appeared,
and those by rewrite-analytics seem to be added with actual commits in 
branches, each for one branch.
Sometimes after more commits or merges they disappear and after removing 
(`git reset --hard`) those new
commits/merges they re-appear (I played with it a little).
They are not always on top, sometimes when a new commit in a branch is 
made it gets on top and these
pseudo-commits sit beside (to the right) of the graph log, still 
unconnected.

What's different between what you expected and what actually happened?
Those pseudo-commits.

Anything else you want to add: The terminal is tmux running on 
mate-terminal.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.55.0.559.g11c6700f10
cpu: x86_64
built from commit: 11c6700f10234578d10523faf35656ca491425c9
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.21.0
OpenSSL: OpenSSL 3.6.3 9 Jun 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.1.6-1-MANJARO #1 SMP PREEMPT_DYNAMIC Mon, 03 Aug 2026 
10:34:01 +0000 x86_64
compiler info: gnuc: 16.1
libc info: glibc: 2.44
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

