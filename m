Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9E1991D4
	for <git@vger.kernel.org>; Fri, 22 May 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435939; cv=pass; b=M+vLdUzlYLHTftk+tCtwZThyJ9at85M2PguldndNqwvViacH2cyC56leK1Q1AQdVA0CApAhQFwoCowwMJ+EmsomwjDWT3KLQujfXEJBYgs5pLKl4ESd3hcVHnYo4/GkRamimlRv3ECrzP51QfCGl1QVW4cjV0eJKjlgUTY62AOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435939; c=relaxed/simple;
	bh=FfGaAPMUMr8x6KyHzXzW8NvrpkfV+q0M11oF89qGTho=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qtvKwLBABxaiKudu+9IJP3tyTYddV+2cEx25v+i9a7/lQaMHoTH79buroR4jWybG7KpeCECwcxVYtEIXiHs2skAH1HDCDhxuQT3R11zhnyKX1mYKX72Pwj4tUjjXcuJ6a3Gd4K0urfYakmyGXdO8Exg0Nyp5UknTZgnUYs5mQXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePrUImcU; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePrUImcU"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dca5f64e86so5734136a34.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 00:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779435937; cv=none;
        d=google.com; s=arc-20240605;
        b=J9+TnDm9VKg0CzKBRZlMuvYutYaWW2ebJjEtCTjJBdVtcl3KdMTYA3AkSkpj/QeJZ7
         GXzb6W17y+qeZ9tag+8TiXhvxum5g5sNaG9/VVwEW//b2FTHFAedayUmPHxnWG5ZPOZG
         YJ4AZ1hgtxSw90Mi4ktp1/zss5LHiFbI2gcxv84I67pR0DQtCsPNduMYecDe/+LIFZU+
         O32dgkvHVt64I7kNnqn5DjuDPOYA5qy4qyrg+mYrZOWolpSwyGxCIVYS2Dn8B/Bwqarc
         Sau98tDOUHPviznfrcXMSkVnZIWBLLxec0sApdwjDcCbhqNxxDl9bNDrZuc8x8Nt92KA
         BCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FfGaAPMUMr8x6KyHzXzW8NvrpkfV+q0M11oF89qGTho=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=am5RvUSq/3ezupbyrMfPDLuHrzmqqPzOjLuJqIeyc3tC+HLwe1zr7GpVJVJqksjuXB
         o5+nao614FcaMuDISw29Ne7RwnF7xmGRZ5fWR9QPM4qLf5omHoJ86nBhCs0yszT2+ZFQ
         JBfXUdIAxS41PvAc4hjIPosoU0ioambo+E8DvRu0JIIitl6Zei7KtzWbzCG0Alo9VkOy
         AAoKG3iQmIaLqTFtXMIJi/d+XcyBY8jIDP6uPBPP0ds1elyvpbFSCYnhLYA4/pVhy0+O
         A4RdZGkp+A7zm7z+B7ruVZxnyHVQpf5IFICsywjKzrhmAO+GWeWnMsUDM3QCIn9Jf+eM
         IWug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435937; x=1780040737; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfGaAPMUMr8x6KyHzXzW8NvrpkfV+q0M11oF89qGTho=;
        b=ePrUImcU30bYiY2lD7anItewJV/pGdmNuotorAFMH90MDjAvEVCUoVQBwvKdKn5MQF
         z7mpQo8slyode2oBc4/x+Q+jmu9/rrhxOhV18CZNVXLqwR1y2W0t7l46ruFE3B+W2N5B
         5w/1OGjUyW8kZT3teF2KbKjfJa9YpwUJJjJV2rwdlxu5QjJTm3un7pFl77rnJXzCrc6G
         pxKzupgfAc2VwsnLU/gLEeUff+VXoURwx5BdycgYCGrlntUQOvFCoSHK7TrXcqye6xHt
         fku0kQhIDmdvzV3AH3/leXOPWS5oRWbh1v6g0c02kfVSxdTM96suMgfXcbyHDP1XUlsj
         G3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435937; x=1780040737;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfGaAPMUMr8x6KyHzXzW8NvrpkfV+q0M11oF89qGTho=;
        b=gGmTfS2yfTeJmXRdVRNd1zblbc6FYZns+rZneCbIOvRkoBx8J4iy1+pdAHrv4DeMYK
         6wu+pMPMKT+Mqh95Ixaq8j5TkxCYE7COcxbYUutDMlRFT2UQGkR9Ixpkmv1s2eq1mAeJ
         QNJWszE112gCGJ9oBRScNHQyAu5Ooh7lqb6JdwSmdYpcBXA4Kq+420yA44RZsU2I/0t4
         F3uGNPU/Fh7OsZ1dpv2l8RqfPLjTjzr+pMQJVUpSdIv32NoSU64E8lfewYeFqWX80cGG
         fulMLplyEFBeCY75DD2ESpL3uGnI2lPllSnz7vCm4EN9MN5gJXG929Pc98QkgWwGaxFh
         yP5g==
X-Gm-Message-State: AOJu0Yy0fpW9UKdkKtSUzQ2q2p41S+0KEqR6uR6z8sMvWfzpVwJqGv3n
	SvJKyvrpUhrAP5Ja/+hC8pZStlr9dwftwtXcmaU7d+SDSLtfbuXnp7MyFmpEO6B+/Sf2Y+hDUDg
	RyphBG72VJr9fuY4xLTSPHn2/wYc40sz1Icy11NU=
X-Gm-Gg: Acq92OFOVErtOHKH/OkbVEQ4JSvnLwxAowTXwOcMh/KoZCNSa507fnCQ0D/pUEf97r9
	cQvjT8P2NztxDEQHJCUegs9TIl6kcomLPmkt5ijVP1FvtXQaJtEV8F1MPdAy1yaDFthO1wzZlZU
	EgMBvcSbaZEG84P07KKDAGMxQ/btxOQ0I3GyavndsgrIs2LzcKb+G55oVTCn6xh96SOXAJ/Wet/
	jqZslEcS+S5WTggHveWatZE1JWXkxgUO7EHVUm8INQ/hVjSHAZvLH+ZJ83Gd0/jai0+tc4MvtB/
	ChOI3vit
X-Received: by 2002:a05:6820:1909:b0:694:a4a6:7273 with SMTP id
 006d021491bc7-69d7ec28341mr1225862eaf.29.1779435936806; Fri, 22 May 2026
 00:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SURA <surak8806@gmail.com>
Date: Fri, 22 May 2026 15:45:25 +0800
X-Gm-Features: AVHnY4IQzhYsiAfreI42XJiCuvII9EoBfnkjhnQW7zLCZF6xj6RuE1bcz4ax4rg
Message-ID: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
Subject: I discovered a minor issue with `git fetch`.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone

The child processes spawned by `git fetch` can become zombie processes.
In most scenarios, these zombie processes are reaped by Process 1, so
this typically doesn't cause any problems.

However, within a Docker container, the application service itself is
sometimes designated as Process 1 (for instance, a service written in
Go). Since these application services lack the capability to reap
zombie processes, the zombies will gradually exhaust the available PID
resources.

Here are the simple steps to reproduce this issue:
1. `git clone https://github.com/SURA907/pid-1.git`
2. `cd pid-1`
3. `docker build -t pid-1 .`
4. `docker run -d --name pid-1 pid-1:latest`
5. `docker exec -it pid-1 /bin/bash`
6. `mkdir repo && cd repo && git init --bare`
7. `ps -ef`
------
UID PID PPID C STIME TTY TIME CMD
root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
root 29 7 0 07:17 pts/0 00:00:00 ps -ef
------

8. `git fetch https://github.com/git/git.git`
9. `ps -ef` (Run this command from a separate terminal session
connected to the container)
------
UID PID PPID C STIME TTY TIME CMD
root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
root 30 13 1 07:17 pts/1 00:00:00 git fetch https://github.com/git/git.git
root 31 30 0 07:17 pts/1 00:00:00 /usr/local/libexec/git-core/git
remote-https https://github.com/git/git.git
https://github.com/git/git.git
root 32 31 2 07:17 pts/1 00:00:00
/usr/local/libexec/git-core/git-remote-https
https://github.com/git/git.git https://github.com/git/git.git
root 36 30 30 07:17 pts/1 00:00:00 /usr/local/libexec/git-core/git
index-pack --stdin -v --fix-thin --keep=fetch-pack 30 on sura-pc
--pack_header=2,399455
root 38 7 0 07:17 pts/0 00:00:00 ps -ef
------

10. ps -ef (after fetch ends)
------
UID PID PPID C STIME TTY TIME CMD
root 1 0 0 07:16 ? 00:00:00 tail -f /dev/null
root 7 0 0 07:16 pts/0 00:00:00 /bin/bash
root 13 0 0 07:16 pts/1 00:00:00 /bin/bash
root 52 1 0 07:19 ? 00:00:00 [git] <defunct>
root 53 7 0 07:19 pts/0 00:00:00 ps -ef
------

A zombie process has appeared. It appears to originate from a `fetch`
subprocess that terminates very quickly; despite several attempts, I
have been unable to successfully capture it.

This issue was discovered within a legacy service. A few days after
upgrading to Git 2.53.0, the system's PID resources were exhausted by
zombie processes. This is likely the result of recent changes, as this
problem did not exist in earlier versions (2.4x).

To be honest, this is not an urgent matter; I have already deployed
`tini` as the init process (PID 1) to prevent the service from
becoming unavailable.
