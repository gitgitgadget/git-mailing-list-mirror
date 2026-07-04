Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E86271456
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155129; cv=none; b=bF+H4Gk1kPg8Frhdtjp+sfYIwp/BsF+/iqSB9E9gZRa2LdeIyFB8MiTZ3gY+WKY5rj/aNurthTQwnssi6weqa50lyjyfqovIjrqQTHYG7YoFIyVasxQrhGsSTjsYFjqCBXnfiTQhmrnXzvheNtelaOx8lXxfd1Mua09rTEvXk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155129; c=relaxed/simple;
	bh=y8vTgndMss32QwFzlXM6ge+USVPA0JyluvD3zSxUjhk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M/7QjQPNphAW8BF/4zFArdWYJTZYwrYznqyjWKi4mhxtvEOfDwyvhFI+dWxkRWenRQo10Bzh/ivAeBOkB+EH5/Z4SjzP5rrUirdyCrdf/Ur97hF44TJ1sRp1itGzBcV9SmdvaHxIieT1Qk12iZS8av1o5MD4kGaWK8DCm4fXktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO8Kh0rl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO8Kh0rl"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c21495722so7055351cf.3
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783155127; x=1783759927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI6tL+CdYGSEMuTQ6KkfdTufz/4dvxNfdULEaaO0/Gw=;
        b=XO8Kh0rl69Cxlwh6VqTQxRt0ow31Y/6sklWuijQqSK5RNiJ1vfF0C3vwQcalUYG9/u
         h2Ba8k5qX5cYLr0oCRjdipPXVN3/VZ6HCSQvPFwPrzmYf1HW45HXP0nYdAtkVY0H0z3x
         aQkIi5YTttNamLoARYzvL7NopZV+TTs/MsIBM4erSIBMmZuAQqF+j1DXCDZzp8p6aB+z
         mVl2TkLWdoWuLRfAkGYq3dm2AlKHnFD2mSduDPIVy5RZwJFOVJM5fuUPRojVcozfDB/0
         PTwvZZFSsY7siNa2zozTMzQpTJiy8HUd74rUVPW7otsP4QkwC4xexkiZYH18Q2TXrA8c
         w/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783155127; x=1783759927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI6tL+CdYGSEMuTQ6KkfdTufz/4dvxNfdULEaaO0/Gw=;
        b=sz4FYVkIosdUv6CgDKM75+uhIF53e4IQDxMplNDOJQ+Ifpf+/oyMkqKZWGj0MjOxvo
         LoAHaKrK1hMhQRadaptRCintKZiwLoqUyPeegg64Hn6IMCTQX9PiwniGPrimO2SuZXsQ
         qNgcHRpmIi01QvIKLGn4AKUh6kDtL1cbfE+CFbRLtEdSfB2nBOnFxKZ62wm0UM/l849L
         aTLs2WHJrruf02I7+8ot/6yepJvwN3wC+9YZIe7jTiXS7iAcX1bDdsk852RbScVNQS1p
         m2DDycDrguPhnSaWGas4nCrvZmzYLdxLSuxcZKxnHo9SL5vOHtMQGsq6FL2AEsGbPFqN
         gyfw==
X-Gm-Message-State: AOJu0YyDir3hpbq7jdZGcaR7aFpzYksM/+/851uVFvwbtxNUEklI3Vxn
	lJWYiqIm8+RhORXn5kb7kRwxo78AmLNguVl6uK2tK1bN9fnpIh+nxSeGQq90lnLq
X-Gm-Gg: AfdE7cmo/9HcXEfIdHNW5z+MMj8Thipasf/au/IjzvvmWn9hrV3DmY1LUsKedhBJ8R6
	w5DRU4icw+Xh+fZqTzPtr5OPM25hn/8JWgtMpWvtpdQdQSbVTU3PKiidelansyTVvROs84fwx73
	41D4I0nW5/pvlo8xY6JDKkFRl/d3nU8OTwvw4wK+Ycb958SdKfR8dZ4DkcnRabWvViQc+RS5nku
	GF0dPOwY/M4ey3jKRhH8sIZNg2waoCnU5vWYTmc3F1J27G6tIywCWDuRIecENi07PDKuRswT6Yw
	al/rL/PhfTjxDoHSnjUCKQeEBknKu9sURkqzn57CfkI1/tpKHWcORTOMb2lUULjM8Oyns5HVmHy
	QMutazo0tSRuD/E49B979qtdv/RCCfcO/h4SP1Hj1fqzyxNfo51CUAQoXSLhDMhj3lXFutbso49
	D2UB2BoFXNJR4Qc8kIgQJb4T6gm5E=
X-Received: by 2002:a05:622a:1115:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-51c4c3511bemr41970271cf.65.1783155127146;
        Sat, 04 Jul 2026 01:52:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.119.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d7eb26sm36505791cf.21.2026.07.04.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 01:52:05 -0700 (PDT)
Message-Id: <pull.2164.v2.git.1783155124926.gitgitgadget@gmail.com>
In-Reply-To: <pull.2164.git.1782889484346.gitgitgadget@gmail.com>
References: <pull.2164.git.1782889484346.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 08:52:04 +0000
Subject: [PATCH v2] ci(dockerized): raise the PID limit for private
 repositories
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
    
    Changes since v1:
    
     * Reworded the commit message's title to reflect the actual intent.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2164%2Fdscho%2Fraise-pid-limit-in-private-repositories-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2164/dscho/raise-pid-limit-in-private-repositories-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2164

Range-diff vs v1:

 1:  77aa18442c ! 1:  671d03ad33 ci(dockerized): reduce the PID limit for private repositories
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    ci(dockerized): reduce the PID limit for private repositories
     +    ci(dockerized): raise the PID limit for private repositories
      
          Every once in a while I need to verify that Microsoft Git's test suite
          passes for changes that are not yet meant for public consumption, and


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
