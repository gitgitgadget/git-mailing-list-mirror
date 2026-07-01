Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604073B42DA
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889489; cv=none; b=fhlirp3DLCL+u3Y/l9TT0wl3aNXb0mYsp3vCWtrBf2XH42u9bTlw2dsFjBbyhcyEmbtQn5wrz7hxirHw4HJJq0mFiVXHDIsf3txEgw1O3QJVAqK1FMY926aYjPciBrbFVcNVJ2W4CHxfyIWXVzSJWEm5O47u9RxjnrwhjrlVvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889489; c=relaxed/simple;
	bh=tAlMaw4DD4mgLQrZK7V/HBJwq7ekKVqMzwjaIlh3kAs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qh1M+50U7DlLRaGLacby6c1Xsvp744uqDkzm09G8dkfR2OMIX87G0XMSjlfYMpmEwQgQX+buklTvhqeONGJ1B4YmH31PkpCzXLsaAf4iLQSbuYVTkfi9DliDUgo0gdRwv5BNex8PF2bhaaVabd44QXrBKEqX15u4mTasttlyxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgu7JwsC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgu7JwsC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfe810293so1665371cf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889487; x=1783494287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACQbXzyMFwtcvA5GvYJwKKVQLcA6tTxDOloOK8cPXt0=;
        b=Fgu7JwsC5TyX7iM3pKlRBwCn0t8/9nYdcyTsIqtrzB8W5gnAyPUOLXVicFEIKVGAs1
         qj6sb9iYtroL+WhdUiF7JcX8LKR9VrgK9KT5fTkGvrU2rWuYYiaD186FIYtMWw6qsPdL
         AAvPl0BboDo56hm0pxgWurJ9pmf8O9buNcVy+nyRUnI7DwPhkdkyIoThXZWANr0jSptq
         WuqceqyKRnu4XXZV2aXNJo6mdYF5u9tsrJzpoxhcRuHUfExS+gvUbeujauKMhlelGKzp
         38wTHH16SvoRNJ/x4Dbl70FyouOyiK7Tz/ReMwtNygkovWfw9pKluUh1tGarYlKBH8AW
         d6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889487; x=1783494287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACQbXzyMFwtcvA5GvYJwKKVQLcA6tTxDOloOK8cPXt0=;
        b=rqUlPLTd4B/2665qlZr0zeMcgoOw01gTVN9o31YBwr5uRjv2sy5WRGVlppi+5rw+kE
         kDVz1dVt1YFL0ZbWL5zX/PoapmP+P1A5r5t6ByaCjakMv4PA5/TiumtAflSLabZ5h3id
         dloCfChwtAh/XLVLZETv/6n7Os0+pder2ImEod3+061k0gjaGc/HpONENLmyHJApEaiw
         UVY98tA+pXmmCf90miJ/0PY45q1SSQg2Zp1hCOOfuKLdcW3MKh3w+zUCNLfQ3GB8xQCD
         ZZjxh8YrWhY5gCLCc7bHfLZFmAredqDDHyE4tkWHkpfWfNe4yIv3Q1fo2+rAuv6fCRAe
         Q2xw==
X-Gm-Message-State: AOJu0YzA3yFFUwwm+sXFWRv7MdZMGoqpYhvgMppo7SLGf3+2OBDGiP5A
	GH6ZwwnFFgEq3bbqhRaoH+cyYwsFEDgDYzLDJN3S3oZVLVfGfxwy0eGZFwLZ6uoQ
X-Gm-Gg: AfdE7clYtDB0VWhcmZpX/zCYxpRzhDFeDxthapexV+PIugbQoSNu/Z4v1BDzxBWpJDF
	GlTXf729teOq99zJvehLDd2x3HkR3OvTXOWqv+isu5SdLSFkon+/9UKzfPEQPkdzbIpZhwsJYK8
	UbCLAS/d0g9Naa1+LXMSqLKMFTqlCg1QjDcVBihoneYIVJB9w7lrKkjwU2jLaFjI211BTan2E5w
	7dzDjyUNXnUE02x3l/MCcnJtjot0jCJEqeHyTf/4d0JYKWXx04j8RjjTyw0GczrxHyEFAXPTzYC
	qxmbUy42q34drRjk0P4sULS3fx2AGMfjirffon6ht/Cf3ah8x5or4mp1Wmz9Hq/twbddJzdVZTe
	g34nw0RkxcMgUygKXqU4GIXrJ/2qKNMurRpaplOlACcfCJ7AbT6thnfS+4lc9SA0Nys/XFLqd8Z
	uUY8fCRrgBOSXf
X-Received: by 2002:ac8:5ad6:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-51c26a3bf1bmr6539191cf.15.1782889487179;
        Wed, 01 Jul 2026 00:04:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.10.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d149sm42461771cf.1.2026.07.01.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:45 -0700 (PDT)
Message-Id: <pull.2164.git.1782889484346.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:43 +0000
Subject: [PATCH] ci(dockerized): reduce the PID limit for private repositories
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Every once in a while I need to verify that Microsoft Git's test suite
passes for changes that are not yet meant for public consumption, and
since it was (made) too difficult to keep up a working Azure Pipeline
definition, I have to use GitHub Actions in a private GitHub repository
for that purpose.

In these tests, basically all Dockerized CI jobs fail consistently. The
symptom is something like:

  error: cannot create async thread: Resource temporarily unavailable

in the middle of a test, typically in the t5xxx-t6xxx range. The first
such error is immediately followed by plenty more of these errors, and
not a single test succeeds afterwards.

At first, I thought that maybe the massive parallelism I enjoy there is
the problem, and I thought that the cgroups limits might be shared
between the many containers that run on essentially the same physical
machine. But even reducing the matrix to just a single of those
Dockerized jobs runs into the very same problems.

The underlying reason seems to be a substantial difference in the hosted
runners that execute these Dockerized jobs: forcing the PID limit of the
container to a high number lets the jobs pass, even when running the
complete matrix of all 13 Dockerized jobs concurrently. But that's not
the only difference: The jobs seem to take a lot longer in these
containers than, say, in the containers made available to
https://github.com/git/git.

When forcing a PID limit of 64k in that private repository, the jobs
completed successfully, but they also took a lot longer, between 2x to
2.5x longer, i.e. painfully much longer. Reducing the PID limit to 16k,
the CI jobs still passed, but took an equally long amount of time.
Reducing the PID limit to 8k caused the errors to reappear.

Here are the numbers from three example runs, the first one forcing the
PID and nproc limit to 65536, the second one to 16384, the third run is
from the public git/git repository:

Job                           | 64k     | 16k     | reference
------------------------------|---------|---------|---------
almalinux-8                   | 19m 3s  | 16m 0s  | 9m 36s
debian-11                     | 20m 31s | 20m 3s  | 8m 5s
fedora-breaking-changes-meson | 16m 29s | 19m 19s | 9m 40s
linux-asan-ubsan              | 1h 10m  | 1h 11m  | 34m 36s
linux-breaking-changes        | 25m 39s | 25m 58s | 13m 15s
linux-leaks                   | 1h 9m   | 1h 10m  | 33m 30s
linux-meson                   | 28m 9s  | 27m 4s  | 13m 45s
linux-musl-meson              | 16m 32s | 13m 39s | 8m 6s
linux-reftable-leaks          | 1h 13m  | 1h 13m  | 34m 34s
linux-reftable                | 26m 2s  | 25m 48s | 13m 31s
linux-sha256                  | 26m 12s | 26m 3s  | 12m 36s
linux-TEST-vars               | 26m 5s  | 25m 21s | 13m 25s
linux32                       | 21m 16s | 19m 57s | 10m 44s

It does not look as if the PID limit is the reason for the longer
runtime, seeing as the 64k vs 16k timings deviate no more than as is
usual with GitHub workflows. So let's go for 16k.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(dockerized): reduce the PID limit for private repositories
    
    I needed to craft this patch while developing fixes for vulnerabilities
    which eventually were published as Git for Windows v2.53.0(3).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2164%2Fdscho%2Fraise-pid-limit-in-private-repositories-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2164/dscho/raise-pid-limit-in-private-repositories-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2164

 .github/workflows/main.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cf341d74db..85cfedf5b0 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -420,7 +420,9 @@ jobs:
       CI_JOB_IMAGE: ${{matrix.vector.image}}
       CUSTOM_PATH: /custom
     runs-on: ubuntu-latest
-    container: ${{matrix.vector.image}}
+    container:
+      image: ${{ matrix.vector.image }}
+      options: ${{ github.repository_visibility == 'private' && '--pids-limit 16384 --ulimit nproc=16384:16384 --ulimit nofile=32768:32768' || '' }}
     steps:
     - name: prepare libc6 for actions
       if: matrix.vector.jobname == 'linux32'

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
