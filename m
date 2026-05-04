Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B73E0251
	for <git@vger.kernel.org>; Mon,  4 May 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908457; cv=pass; b=uS851SilLJfMLO+svZz3imcX6NIPFrGbZ9Q2F+zAIWuSDALlMjRLncDbq8kTwOwndLTlOifFWaWPjzyKSFJ1y1xjZKHwR/2cSqoDeCM/O9HXO993kEJCpQcBqg0EVnj22ZWVnnfhjmcz1DJYxkz6Is6JT8rx1zZhbN8Zd6+UAn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908457; c=relaxed/simple;
	bh=7EwGzQCfHpNghxXOugpRuwwgnz4qtuQ42MrdPvtW9tk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=D/pSnNzFCxj6tCRG6OZMRgZDsJxlhcIOm9/ZL/Ko7L0WbZm7Q7s5crGFlIu49AnRpYyJnzkizzKuNKn6HcRiYpbCJro03ZlSv4I+dcnjv3hH+JEotqcvflQ+B+jt7S8fOW+B3Yp0zFPLwjYzWeJ5BwbGcpFKIroYZzlsMsEules=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/UDDRHh; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/UDDRHh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9358bc9c50so644159566b.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 08:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777908454; cv=none;
        d=google.com; s=arc-20240605;
        b=K4zN0KwP0NLc4n+XBAmFDoU+sBr2prA4LGO8Hg8YrWwj+2y15/RDTjoQTht21RuqQ4
         WIfOmFiFFZEH9TU9/gEipejZ7nY7l+19peHh+w4VPRvcD65TZKAdTRFs1NI5yYk1mO6s
         xLVgbEo8SIEjTjorIp2c9KXZJ3h0GsIP2GDRexCOntldf5bGl1+c97B6eHuEV9JZPtO6
         Z1V1ZnxK0UKaxeF91fT3u95+I2TU+mAadivILJlvC8NawgiqjXPMkb3z130jsQgj9ovC
         jsiMo6wYx2HUL3mSM3oxOpXw3kmnG0d8yw4CspHhRs3I/9T2ETNaa2sLyDDUwekTdKUc
         VEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0JgN4jML4AYx6PgxPNmOz61c8biLIkMNQjL2WeUCuEk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=gIrcvyNeGoRGIRZEVXuuFjOFDEvht6SEhUFOu+gAKpXfrFygwDg19oiX+ZA2AIfi2q
         XIBnxeDqRoPNhM6NMN+JG1ongM1EN+SUnbmhCTC+Sob00WdiYMaytAbVU1fN/r1J4psC
         Hm861VgB783hrys8zfJtMHxacaCaIEu2NG+ktdVHc23wdQ2ixA/y3mbFWp4IG6o1hjhL
         AuGdDoacA0R6yUZYl+MFNLwmcX/I8k0heoj7C87vCZMpVl/I0bRFV/nU0QdzwjUIy21/
         CDGrQnjVg/sjJof+1QPdQol8NIvVPdb4pQR+ZYDBiHnmVeRSuBaVzGUcdyIJo68squ6r
         GICQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908454; x=1778513254; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0JgN4jML4AYx6PgxPNmOz61c8biLIkMNQjL2WeUCuEk=;
        b=U/UDDRHhRz40+pHbvaFlqd+KXvpS+H2lZ8CjgkD6uJCfrO2Z58qXkidPmCmoRpuItO
         /Njw7X/Sb5AbwLNNfVLXY2Wai70OnjG1mKuqrdbLlqpuj+rVQuaoFiwgeloB0v1+sm3J
         AK/v6kZBPfhsZjohGNbt8uAriFWwaMeoCYtwW1z0WjBzKg4qz3EngM3zJdIGcAXRUdut
         KP2rXzfJ0uvlPNJXIkOPhJBNVSJ5b0jCJhU250bAtVCHz+dtUVWXCurZDUx8kWl097J3
         7cOdXL1/+YXTbUqXa9E00VmAnMHDBCS26AFRekkvMlOrUDYbMd6jJK+LG+Xds4NEPui9
         QeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908454; x=1778513254;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JgN4jML4AYx6PgxPNmOz61c8biLIkMNQjL2WeUCuEk=;
        b=r6AwYsTgHR/EuLfSXjB281jzW/7pKTEIg/zHohdU72y6xPCt4fvA3eGrin3JmS5YhO
         ojMoCKKwdBV6iejR2keKXKbXAJVZD1W5vrFlUo43jy89YJ3RKQYBs18wFoYqCEOgWGo+
         +8zBK+ZT0VysElonl6dr6M/sdVr07/7XD9R10OOBpF2lKOmCZj3NOvP9spN6kci1WhY7
         6j2nkhQiO/NbQzRfs2LuufntwFsr+gwXIi3FLkcufDVFTh5N1emvphQ3A88uJ74wFUn8
         VUcAw6xDZ+nTR1bDOMZOjFoCpcsN8KIRT7NGo7BOAdtJkngT7UaBu4+DZKfy0fmkKoI3
         0usw==
X-Gm-Message-State: AOJu0YzFttecmlHDZpFiUp4KfORATPsoaWI+gWbNBBpjv49aA124+re9
	DZdnSinJh/k6FyCDkiRGEKlt7LP6R805ZQvN9XFK3c5TEpT4dHfBHcywxW4XP+61FZ19K2htVXy
	6smnkgbYNQl1lphUYwHo7h3/ftVisGt2S6w10
X-Gm-Gg: AeBDietb6sgBNEeZulYUvvzzBY4n4tk1d9lCSH+DWIeZzPsxm9M+rpIqqSFcMxzMWyr
	aqPEB2497jaa9dtkHUijCdo03R9OAV1DVguT2cG3iwaPfuovpF0MGmTwN9aFzdHquYtw8Rymi6R
	YStSLEx0Kyy+lXgnxmsU09nutFs0n+ajIW3TTTerZTemxb+BUuwCvFkKqJgwjdWVBf0F6x42GFc
	xlg5O3Zt3i/R0q9zeVfCfn76t595revUo9FBkKbz3NoRZ6aVnLcSIR0lGSr4jttLNNhsa9J6w+e
	RhzEYhRMxIcyhH1zow==
X-Received: by 2002:a17:907:5c2:b0:ba2:4338:e9fb with SMTP id
 a640c23a62f3a-bbffb846e76mr537085966b.32.1777908454155; Mon, 04 May 2026
 08:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jean-christophe manciot <actionmystique@gmail.com>
Date: Mon, 4 May 2026 17:27:21 +0200
X-Gm-Features: AVHnY4J9WrSUGPXXkQLrfc2CaZnggTBDuQ81g3px_TurmdaPdNoniB1bZfaWefU
Message-ID: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
Subject: git hogs the CPU, RAM and storage despite its config
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

many:
git add -v --force -- "${file_path}/${file_name}"
git commit -v -m "${full_commit_message}" -o -- "${file_path}/${file_name}"

What did you expect to happen? (Expected behavior)

I expected git to respect the configuration (.git/config):
[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    fsmonitor = true
    untrackedcache = true
[remote "origin"]
    url = git@examle.com:ppa
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch]
    autosetuprebase = always
[branch "main"]
    remote = origin
    merge = refs/heads/main
    rebase = true
[feature]
    manyFiles = true
[fetch]
    writeCommitGraph = true
[gc]
    auto = 0
[pack]
    threads = 1
    windowMemory = 1g

I expected git to use maximum one thread for packing and I'm surprised
it even tried to perform packing as gc.auto was disabled.

What happened instead? (Actual behavior)

Instead, it used all the threads it could find (28 out of 32),
depriving the whole server of CPU, RAM and storage as the tmp files
kept piling up.

What's different between what you expected and what actually happened?

Uncontrollable use of CPU threads, RAM and storage

Anything else you want to add:

All the threads were running:
git pack-objects --local --delta-base-offset --honor-pack-keep
.git/objects/pack/.tmp-<number>-pack

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.51.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.14.1
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.17.0-23-generic #23-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr
11 23:29:57 UTC 2026 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Jean-Christophe
