Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DC46521
	for <git@vger.kernel.org>; Thu, 30 May 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090689; cv=none; b=TVpfpHBnbmXgLg1ul3sSRwfpvxejgW7o9ATeU9nbi4YmzttpI0KO5gDmANMaQ1E2hw40r2Nvg/IIPdWHrtmOsgX8UC7ka2Oa3Bva/kp4dDucekNZGnOAxbl7HWg5VTI9WSYoQDghR8a8pQt/eqIwvczJ3RgRvldR6GeDmYuffkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090689; c=relaxed/simple;
	bh=48TDzSmOs48/FFOTyQx6cABJJHvNKQiOkgE801YoUH8=;
	h=Message-ID:Subject:From:To:Content-Type:MIME-Version:Date; b=p+FhoR+JprWiVAJIfyykRAANRDoQr6BP3bU2v7hnMDp0k0Y8jg+kgqvTdJjiG7KBHX2+WYkoj6iaFdWffKYQTJr0QPADglQiRLrIavpL0GcqtKdsgaJxTN2nKUh4cceRV5I4uvFMa6CUUeQQcBkG010PPZZ6uDz+FphZFrB9x94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNdTuedv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNdTuedv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354dfe54738so729273f8f.3
        for <git@vger.kernel.org>; Thu, 30 May 2024 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717090686; x=1717695486; darn=vger.kernel.org;
        h=user-agent:date:mime-version:content-transfer-encoding:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48TDzSmOs48/FFOTyQx6cABJJHvNKQiOkgE801YoUH8=;
        b=MNdTuedvLiZoUbgP1Fow0CxyLwQ6DfvKpSCgK0eZiN1hIvsJrq2RaVX49OqFsEjKMX
         f0eI7e5IeEwNzqk/dqbaT7YdMF4bTCweBNeNPW29/vbwY9K4bNFmTq7mQhQyWZTScIxg
         HNONHvW36XDsEycwN/fa8tHB8jZ+q3tLMwfTYBblQvGjPNyU78WRkptm+DFeCCaWZBnm
         IiakNd3hzCeczZpLrjutdDErr2vVDQytYf0StXyPKxnV8Uk2Q1aRcPmSqDRyqddwLZ/c
         7qlbvaWZEIdt1XEPa0acFRSGd2eL37cK/tA6m3KPIT+07SNHaAOfm3Va6BXyFb/42U9N
         Fjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090686; x=1717695486;
        h=user-agent:date:mime-version:content-transfer-encoding:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48TDzSmOs48/FFOTyQx6cABJJHvNKQiOkgE801YoUH8=;
        b=b8dX7zXA6ZpUdRWeWOli9Qz6Bftn0OV6C4gOBZq+hOArqquFUpcKosIj0nFT4SwN3Q
         +uIp2AH0XI+ypp7myUBMyUhDANCQNX64Iu7IOdu86ykkmPuxhh3nk7+9U4VT6+kZZyio
         3vngaTjPgl9PiUbW745uNSFCGOReGOq/Mn605Kajn0Wx1t/KZtowwfbYHA6z7426TcR8
         35WKlMAFFwnu3j1bzFBRAO5W+ml7o3AIZXqfLg4sz5Za0X9rPLNX0KkK/6dyeGSDE+4y
         qt7iw5SxkQ8kNB4qbIPWeuoDfosiXFK8s7ce2LsFOQ16MWXmxWgYQSoSnWFKshUPqq3p
         l+zg==
X-Gm-Message-State: AOJu0YwQS0tAKKXUpYJkd9ZV3gEvTWFjWIHsYSC6TI0k3Y5asZU1b9KD
	aATKMw9DCxmpKPxKLTZ1Lhzc92skIr+ytTgp16lvPMzstw5X7w4g0a5Q0g==
X-Google-Smtp-Source: AGHT+IFGo9AIUXHkohOvLpVFAPNbIfFNdLWENuXHLhli5WvTahqqI8+J1Y7GOHeEzi2YNS1l6UEo+w==
X-Received: by 2002:adf:f145:0:b0:359:6f2a:3912 with SMTP id ffacd0b85a97d-35dc0090d06mr1759216f8f.18.1717090686036;
        Thu, 30 May 2024 10:38:06 -0700 (PDT)
Received: from [192.168.0.203] (046074010202.atmpu0001.highway.a1.net. [46.74.10.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c1113sm45811f8f.16.2024.05.30.10.38.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:38:05 -0700 (PDT)
Message-ID: <51363037334634e27580664f104886d5eaa9b4fb.camel@gmail.com>
Subject: git fetch from additional remote fails with a treeless clone
From: Christoph Reiter <reiter.christoph@gmail.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 May 2024 19:37:44 +0200
User-Agent: Evolution 3.52.0-1build2 

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your
issue)

(I tried to come up with dummy repos with a similar relationship but
failed to reproduce the issue there, and --filter doesn't work for
local repos, so I gave up and I'm just using the repos where the issue
occured instead)

This does a treeless clone of an outdated fork, then adds the upstream
and fetches from it.

rm -Rf MINGW-packages
git clone --filter=3Dtree:0 https://github.com/lazka/MINGW-packages
cd MINGW-packages
git remote add upstream https://github.com/msys2/MINGW-packages
git fetch upstream

What did you expect to happen? (Expected behavior)

fetching in the treeless clone works as with a non-treeless clone

What happened instead? (Actual behavior)

fatal: bad revision 'e346057a67cffe54493cf87e24498229b8a370cc'
error: https://github.com/lazka/MINGW-packages did not send all
necessary objects

fatal: could not fetch e346057a67cffe54493cf87e24498229b8a370cc from
promisor remote
fatal: fetch-pack: invalid index-pack output

What's different between what you expected and what actually happened?

The treeless clone does not work as the non-treeless clone when
fetching.

Anything else you want to add:

Also reproduced on cygwin git 2.45.1

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-31-generic #31-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr 20
00:40:06 UTC 2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh

[Enabled Hooks]
not run from a git repository - no hooks to show

