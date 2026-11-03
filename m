Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717803;
	b=131yYb3gDvVGyIvZT9Um7O7LMu9YnfAT/pUJIvA9m+30WcnNc+knM8+nrWZ6YPMSOQJW
	 nph0jyT+Fv7QKYroFBPruzRvBBTg053hPRwg0hEOgF/07xNIwoxiHf8WTKREpMbKdaBMS
	 gjyTUG6MpzgI2No2SRkFt3oxEEpi4bvHwZtX2upLMUUkn92l871wXgYr+GWyq9mlGjNLf
	 hey0behJfC7sor3gAA1Uz4YDXhUm1AjYeoB+vl9M/S/6Y2vfUyBEv+yH6OeEIqo/kOeS0
	 9biOSTGCzUhRVK4ESS4iHuDNl6VEisVaAzzoyzl3IR5nU2qryoHqqp5m3Rp0phxFDCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=XaJsglCJUtiu3AlCalyz17XFivAYwY9bfyLi1YuZGPE=;
	b=TAXQlEzgDl/wBEgkWS/CcgDLlDpr3UTjDbWDL98ldaEVYtyub5vchq4ijRjsijVZDEhU
	 X+YZmkanI3gA7ISCkyOKIuwVy1WTvFKZlWobwggJYftB4glZzvWt3fRyrakTzcBR7cj9S
	 zuLFVPZuGUEyS/tc7m2qDRvwvjSat3Hr1IQx4ivirIv451iPPNcDe/MxFLLRkIMeDMake
	 JvS3F2wMpwtO15VMHF/5TgJ0Z8UdVgFJsd7WwY/ovcW78CgLCw0ogXCn26OOHASPYcF3h
	 DzAxXI81BOi+NzwLUrWPo0Z4vrxGG/xn0Ye55KvhneVKSlnzGB7UitBsQuz8gHb6sTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MArtgNJ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20760606B240
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20760606B240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MArtgNJ2
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b305e10ac7so2289587b3.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 06:56:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717802; cv=none;
        d=google.com; s=arc-20260327;
        b=Pl1/4SLvvnzabCFDjuz6tR44jBp1wEFGEOsDmAO01s5oQybZPRKiyrgLyRjATRVMcB
         fUtNjpH11jYoC2hpTrjmfiXjgcx8YqDzKF61tATOlYAqx5MCuB3GyNF5j4htZSFf1gAX
         GyQ3leTpeKJafqal6EJLnur4/koNtvd8TT3LtF8IDPoaOI6psGRZhcKv91cYFbuB8oKA
         6EQ3OJ4z6fdUYnrTgMyio7LNrfLp296BE25buDoKnqdqogaDu3DnW36Bi9Yk4AVuvS9T
         XH1Q8i0GXDv7fmxnYnfw889y4R9ylelw/PZ9d8horS+DJM/d1RoGPvLcN9b4Aro+xCJM
         +buQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XaJsglCJUtiu3AlCalyz17XFivAYwY9bfyLi1YuZGPE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HJZcKWyOOXvNw02vQlfFxlxNAKdLrF0Dwyvc26jiwuGKSdFUTMKW1YMC+57axaPVgG
         kWhRT6dl7ShPaSIaK6+z7dXE50AT0BaoNoDbTFud1lozw/3i/FhR1Q2sDspyviNzHvbS
         dXhKCnuZpHEPaAqxiY/00XzzyFB7rZaEkRukB0ZrIla09WGxseCViS3i0e8Htu0oBEt2
         pxQMzv/oy/QhI00nK7n/OJSObdphYrBU5NMiP+XF9t8O6/yyFPZTNhndHNUKkE94Ncx8
         7qx2dEzrOKbu/C9hN/yoxGZ81uXS8kI9bjM9v53fsNdK1Zuwq9goyZ0gzUzLCelICnAg
         tE+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717802; x=1794322602; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XaJsglCJUtiu3AlCalyz17XFivAYwY9bfyLi1YuZGPE=;
        b=MArtgNJ2w06BTK3ksXyOsJD630y37sNwRjomglJ2hVRJsaJiYFS2ZUUzTcgVAYDegu
         2txN5PlZIakrhGhCbJChEPgq3Jbe/r0qBujeDiac1EoCXlxJViHj1QL/ivxdmqgiRKGR
         AkCcyY5/e62jDvgTiyk+4FTpolTbFenoYC3AjesXGAXv7wozEDxJxYLQYPzL6PWaaC9z
         8J/RjX1mxyMiH/bPCix5WfUpDz3tnVNZDLbd9zaZ246UEEBIY9kNCffrDoYV3dEnec3W
         bkGgjc2TtwlvJlNpx+ZSQqydBQ7+67zA/MPgTPWaadzdeUggmwduASSK0vfYr/nbg7aj
         mcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717802; x=1794322602;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaJsglCJUtiu3AlCalyz17XFivAYwY9bfyLi1YuZGPE=;
        b=JznWwpTOJJMvf9Uv6Gs4wS/uv/AYp97MRCpx7fGpG4VAdrSyQ9b8VsWGpXjgQlQTU6
         TXDONSUO36zE2UH0HaGhTJ84SAuc56gPa7+iADGK40HctzCkuZvWXTn5z9P3a1JxYJjn
         v3ubQJS7th3C/00LUuG9EDhye6LSZuvhUM8CTJCdLXr36ArjHs8HmBvjl8purnkJVLEE
         H24YSMWjZUlaVG7+MldW6MQlhDTwxZzOUwNscqghDRIzpMrMrgdyKz6TB7WUGyW8pF3m
         rRd/OqgttePL8IK/MkKw2AZDw40hFbsfrs6Bix6fmMXfqM+0WZHwzLvPJg0HlWIpbP+b
         QgGg==
X-Gm-Message-State: APuU4Z8lbPp16WXGklP/1Q7HNHUSCie1q62ozBjqnuG0z0t4pTG0c0ea
	aLQ2ncQICodVY6XYQjBYffZ+uQ9Zu5OeiBFePPJeYIyzXUM3dXDz2hlMGyoN7WQsg8b2k774J3I
	Vle3HMqPRtw5JewvR0TG05o4DZFoE4gklenwI7wQ=
X-Gm-Gg: AYBFou1aw/Qfwu9v6t2GuB61+DhuRK+wBS7nrEC9qB+ynzgk9mrtXLZh6D5ebEh3svL
	mCICmGmTmMyJOAkA1TwoRhZlLV5QYIQU6V05nighSbeRPy1TclSPXwHfRe74zwza9FJO5pDVl0U
	Ey4nmp7D+T4JlbY2jqzRwlHnlxgczBeCWdeDkD9c04tiqztKff+YAEmqaeSUc3tDZK5+e0eq53L
	ukN9Yq+t0TOWOts7QaQ1yxGKuiz9N3oZDVs5NLTUvFQT7AMIOXdB6USnj7lxKPlluJ13LOLRKeY
	7jcT2bXtz12LlmOy2KbMk/m0JcGgCgnKvC4+I0iVYF9PIZAIwXqJqcf3ZJN7Ec7NBo0bhaap/4l
	L76ChzP0L+nbcpiuO0cp8u1EpLO4lmjZfMKIV
X-Received: by 2002:a05:690c:e204:10b0:8b0:ac08:d6f7 with SMTP id
 00721157ae682-8b2b671012dmr65011027b3.18.1793717802129; Tue, 03 Nov 2026
 06:56:42 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Patrick_Pero=C5=A1a?= <pa3ck.perosa@gmail.com>
Date: Tue, 3 Nov 2026 15:56:29 +0100
X-Gm-Features: AclHuK_di-CkuygNWWfjMOqrnSa4ZpEHljoT6NZEqXOYqChK_6pPCTkevg8Zdkc
Message-ID: <CAByu3etmpxF+zNqDQ0VJ5DZs_qxdnvQxxmeaMcGRGf36+8Oqww@mail.gmail.com>
Subject: [bug] push: bare --force-with-lease ignored on remote groups
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

Pushed a non-fast-forward update to a remote group using the bare
--force-with-lease option (no <refname>[:<expect>] argument).

Minimal reproduction with two file-based remotes grouped as "both":

    git init --bare RemoteA.git
    git init --bare RemoteB.git
    git init -b main work && cd work
    git remote add RemoteA ../RemoteA.git
    git remote add RemoteB ../RemoteB.git
    git config remotes.both "RemoteA RemoteB"
    echo 1 >f && git add f && git commit -m one
    echo 2 >>f && git commit -am two
    git push RemoteA main && git push RemoteB main
    git fetch --all
    git reset --hard HEAD~1
    echo 3 >>f && git commit -am three

    GIT_TRACE=1 git push --force-with-lease --dry-run both main

What did you expect to happen? (Expected behavior)

The --force-with-lease non fast forward push to happen to both remotes.
     + d30bde7...c21af72 main -> main (forced update)

The same as would happen if the pushes were done individually

What happened instead? (Actual behavior)

Both pushes are rejected as non-fast-forward and the command exits 1:

     ! [rejected]        main -> main (non-fast-forward)

What's different between what you expected and what actually happened?

Both pushes failed, seemingly not receiving the --force-with-lease flag

Anything else you want to add:

GIT_TRACE showed that a bare --force-with-lease does not forward the
flag to the child processes that are spawned to execute the push on
each remote.

12:10:42.376196 git.c:506               trace: built-in: git push
--force-with-lease --dry-run both main
12:10:42.376772 run-command.c:673       trace: run_command: git push
--dry-run RemoteA main
Pushing to RemoteA
12:10:42.377701 run-command.c:765       trace: start_command:
/root/git-builds/next/libexec/git-core/git push --dry-run RemoteA main
12:10:42.380551 git.c:506               trace: built-in: git push
--dry-run RemoteA main

The issue does not happen when an explicit <refname> is specified

12:10:42.420633 git.c:506               trace: built-in: git push
--force-with-lease=main --dry-run both main
12:10:42.421239 run-command.c:673       trace: run_command: git push
--dry-run --force-with-lease=main RemoteA main
Pushing to RemoteA
12:10:42.421423 run-command.c:765       trace: start_command:
/root/git-builds/next/libexec/git-core/git push --dry-run
--force-with-lease=main RemoteA main

The issue also does not impact the normal --force flag

12:10:42.437825 git.c:506               trace: built-in: git push
--force --dry-run both main
12:10:42.438310 run-command.c:673       trace: run_command: git push
--force --dry-run RemoteA main
Pushing to RemoteA
12:10:42.438508 run-command.c:765       trace: start_command:
/root/git-builds/next/libexec/git-core/git push --force --dry-run
RemoteA main
12:10:42.439223 git.c:506               trace: built-in: git push
--force --dry-run RemoteA main

Reproduced on:
  - git 2.56.0.windows.4 (Git for Windows, where I first spotted the bug)
  - git 2.56.0 (built from source on Linux/WSL2)
  - git 2.56.0.341.gebdc087dc9 (master, built from source on Linux/WSL2)
  - git 2.56.0.506.g506a7eabc5 (next, built from source on Linux/WSL2)

--dry-run is used above only to make the reproduction repeatable; the
same rejection happens without it.

[System Info]
git version:
git version 2.56.0.506.g506a7eabc5
cpu: x86_64
built from commit: 506a7eabc523d0811286b66193419658da95cda5
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
libcurl: 8.18.0
OpenSSL: OpenSSL 3.5.5 27 Jan 2026
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-storage-format: files
default-hash: sha1
uname: Linux 6.6.87.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC
Thu Jun  5 18:30:46 UTC 2025 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
