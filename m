Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1CA4EBAFA
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799664; cv=pass; b=XkuUhzsQk0eBpkmbSAtF6avErvNRUswmSTKA2W4R1qRSjcnq4ebehYrtdVR4YDhbkBZPLjW42UqGtW+cRRf6j3g8J29KqsecaCHI8X9z6GJ7ZeImQDy8tjmKibZNx+JyvktWEakQ+ByQSloiI69UNFjYtxsdr3hXse0TdOPGcZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799664; c=relaxed/simple;
	bh=TAkK4I2fvEhq8zG9Dr95fCLYizK5UwuigR8sUbWWM+g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rWVQueYXALY5rEvzHMDf1l+hVMMhqUm0FgO1JpVGjggsRSHiiqTvWZ3VIAQvGoU6DkDM+EqmOHeOwOmBbbF/TNxss5sbUuz02odbw4zwMNOr5Ph0ZvyTmY4m01MMTUnuRG0reyD0Iz8C86gUjcVvOH59OMJv51vUx4ZgC16AorY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5iE8SQC; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5iE8SQC"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-78fb1fb9508so104860137.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790799659; cv=none;
        d=google.com; s=arc-20260327;
        b=sntoCeUNtsTWwfZo+IntGy9DaG0Tax9XpC/IN5dRPOKJaHbHYvoO1mOf/PpdkXjq8I
         4yA7JyN6HPExFu/h3ji4wHPv7e/eJQZOUCX4alOrBKvn3YFVKy+XPrCjejt5kUChQ26J
         aDPjeXrgqz8xVmmfDw/McgdbXidjqmC82KUCHldkuKjLUkiKSjWGGeEfLCpuEd0irW0o
         RIJw9jr4E/F25rINOFl8ov7PjPOvn/Qjr2NkS83KJRKXh7L4VGnnWQjUyoRyZu6Qc8bW
         1b/+InKWsha6sXWfPwnjjZP2kh+oliuyYkJ2tGmJ3zpW8CarOadpP3ANZXdeM2OWEcqG
         q2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0zTWPI2cEGXTS7wKQrXb8MnKfDRy+9U0myhYeFU3/ig=;
        fh=pihDNu6oyKDa1eFGWTqqwaE1lrY+s5AgYCoAj8UQ/E4=;
        b=nLDj34bG3BjkgVUfQq1Ugdz2k8OCrsdwmkIloaVrE8qvLlrlPKZXf0E61LqZ1BrYxv
         RxgnYu7VfSq1IvDcTDyB+CGkoGR4WW43NkgNkhDABtJuslHe6nsErzCapy2fNs6ua7uS
         lTNRYMk/ew9E2jicultmqWNdrBdjxC7VPQFVGigCtv0rSwZaZvWRiYw6tvOKNv0jXLXs
         2FpO2HBoL81xtGxj+ez90+NuHUYQWb0pa38rbFHlrm0bFE0lkOzbphl+3xxfIym8/GbY
         GF9aHMm34uvyZ08AftGwUULvq9af5ZnZJ18aef9WE8amp1XdlHr6mRsGOWXs93YoKK01
         JHhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790799659; x=1791404459; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zTWPI2cEGXTS7wKQrXb8MnKfDRy+9U0myhYeFU3/ig=;
        b=Q5iE8SQCwf8qowfHhkTFaTfkW8Hbcla67WnbkM0ie6eWfP0sRl94dtEW1q9VdTsgoF
         uCqh1E5lbksRkURQwUqqpzVYWVrt5MgM5LhPnytukBsJNwHVtNfeH6ra6JStJYe2rDYH
         A+NOiaJYuS3ZSheXhJuxRL9GqTWTjQOnUxEBS4/9ZGfanM1xFixKABO94m8bN2JUXMEx
         1bYETMYCbo5IfSYdPQel5bxRC0JmVxt3GKKA2gZARmPp+MSnrazDjdB6fD29uQ6hUoXg
         vOWYVhDiHTeM7u0i3GtP9//g/5BqGDWTU1GQ52iIgpHiJDisZjEuZMXqjezQqmWrNTiL
         FkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799659; x=1791404459;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0zTWPI2cEGXTS7wKQrXb8MnKfDRy+9U0myhYeFU3/ig=;
        b=sw4POaFhkflvk4O5YqLWGrwGkAdokTiOopfXVNAs2515ztEdg4LbCkjbZs6npMeYVQ
         vKOE2vvCzHT71yb0cUCgLSRPMFO0KIQ5Upqdh951kTxIoJdZbIg/5C/C8SKb4sT13Hco
         uAdW922dJzhN2idrFcIWp/I78uB0NzrWjIo6vnJupnSBBhnJGYDZx5A1prDSxyBldaS1
         XvhfZ4/LFyvdVW6HUJmmruS1MMv/OzmqHAE9FXzprPoeIIO4mtd0U119aCXFScgmZisx
         TRwMwDpOzDk2nBiUYZV+b2U6sAkuCONG4nF4fY8JfZKnVgMXEg465KsPyUBM6zrN0wvP
         fhRg==
X-Gm-Message-State: AFq9FYJk/K1hOX6shhw84VvDfOoWlVdvGN2y+UzlDsKH/aLKsg8lnsQ1
	kRa03KwvKwola+wXEodB3FgTKTzXFIRzfBhg7oGCSiPyQBn/CF2uUQUC2zTFqM5Yl1P0GG3TyD1
	KPXld2OU9mjn/6Xc2MsoWaIbRGZ121K86k5RI
X-Gm-Gg: AYBFou1nGC6E7MmH/4uo6xiSnLSFyOCxN/mBeEFJSdJvXpGx9cVtkr5UlGSA92yBbeQ
	FXdUnx/sacftDNl1FP0WIn+lE6dUAsO/+hEApbUbMDCP/8E8ZYfy5JSasR7CkZXGOYNCW6uC9IA
	35gpxYTV9duQvOJMIL1b0gvokhfU6n8rk9UETUQMcuNf7MNgtU4XHG5kR5leVwZEvzrI7nsM9Du
	WbZKgbh/G/Ri21R/XmRaTHCdJ04TBbd7kuLga0oZPD8nE0XKm4Wx+o8XwiWjAQRZpMrCMJw+eaU
	sQT6AtcmW4pJ/C2dS8su9Zgf+LZwUuUvsvV9wqeogYMDPUxWkE/Mdu7+zOjlIwmpJkM=
X-Received: by 2002:a05:6102:2233:b0:7bc:ce17:aa76 with SMTP id
 ada2fe7eead31-7bf847a09b8mr201131137.36.1790799659585; Wed, 30 Sep 2026
 13:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Webstrand <webstrand@gmail.com>
Date: Wed, 30 Sep 2026 16:20:48 -0400
X-Gm-Features: AclHuK_zbraJuluGxfX5tYixHJS4P712Xm2ONFQ0vSYhX8AFQEfBB2REZTc_BIY
Message-ID: <CACm1TQd5b9tX368LrsD26Q6tm_mzdi1nwGtGd2V1jwYW+r2c1A@mail.gmail.com>
Subject: [BUG] sparse-checkout: checkout clobbers untracked in-cone file
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

    git init --initial-branch=locus repo
    cd repo
    mkdir src docs
    echo "tracked" >src/tracked.txt
    echo "tracked" >docs/tracked.txt
    git add .
    git commit --message="initial"
    git sparse-checkout set src
    git branch some-feature-branch
    git checkout some-feature-branch
    echo "incoming" >src/new.txt
    git add src/new.txt
    git commit --message="add src/new.txt"
    git checkout locus
    echo "local" >src/new.txt # conflicting untracked file
    git checkout some-feature-branch
    echo $?
    cat src/new.txt

What did you expect to happen? (Expected behavior)

The checkout operation should be aborted as a whole:

 1. No files in the working tree should be updated.
 2. HEAD should not be moved and should continue to reference locus.
 3. src/new.txt must be unmodified, preserving the untracked content
    "local".
 4. git should exit with status 1 and print the following error:

    error: The following untracked working tree files would be
overwritten by checkout:
        src/new.txt
    Please move or remove them before you switch branches.
    Aborting

Sparse checkouts should have the same behavior as non-sparse checkouts
of the same commits.

What happened instead? (Actual behavior)

The checkout operation clobbered untracked files:

 1. Files in the working tree were updated.
 2. HEAD was moved to reference some-feature-branch.
 3. src/new.txt was overwritten with the content "incoming", clobbering
    it.
 4. git exited with status 0 and printed the following warning:

    warning: The following paths were already present and thus not
updated despite sparse patterns:
        src/new.txt

    After fixing the above paths, you may want to run `git
sparse-checkout reapply`.
    Switched to branch 'some-feature-branch'

Additionally, the produced warning is incorrect and misleading.

What's different between what you expected and what actually happened?

The checkout completed instead of being aborted, src/new.txt was
clobbered instead of preserved, and the conflict was reported as a
warning instead of an error, and the warning was incorrect and
misleading. As a result, the untracked content of src/new.txt was
destroyed.

Anything else you want to add:

The behavior is present from v2.27.0, the first release to contain
681c637b4a, through the tip of master (a018953688).

The behavior was introduced by

681c637b4a unpack-trees: failure to set SKIP_WORKTREE bits always just a warning

Prior to 681c6, git refused the sparse checkout, producing the same
error as the non-sparse checkout, with the same behavior as in "Expected
behavior". src/new.txt was not clobbered. Starting with 681c6, git
completes the sparse checkout with the warning shown in "Actual
behavior", and src/new.txt is clobbered.

[System Info]
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
OpenSSL: OpenSSL 3.5.3 16 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.2.7-1-default #1 SMP PREEMPT_DYNAMIC Tue Sep 22
08:00:24 UTC 2026 (e601a2d) x86_64
compiler info: gnuc: 16.2
libc info: glibc: 2.44
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
