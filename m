Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A0440C
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274565; cv=none; b=Wn3PfrY5nyZAe2gcPr3H2fLSgiux0wjgoHBXu52IZvG5TP1s5o6JR2Z6xfubNQeDqKyKOkFiYjvND+mCHT3hVR7yhbn3eW8O2MzRKTh9EfmnngoIZ4s/wmJUAZMS4B6smPld6WNXN68E8iJCLdVJ4JnFZyHremccDQZ23S9yMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274565; c=relaxed/simple;
	bh=7eAFZi/B74Q9+774rbwVvuPTPnGgEh7UiwFuTOMeppo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LVEDawQokVzJKBJ+rxXR0VZSPeVvi8ZqEZhwT51IJuvO/EUxkRLy/V/1GZjHwsFE5uz5D5hvdOuAXfaaTyLFaQn7Kj9CUbjQ6T1CvB3vNIVHLpxMQu+LPt1juCRlYAriD+UQcXf3P+xAerzfSrtOgY7c6gsZMZ/fsGHA3uEk4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByxF0QJS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByxF0QJS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d446adf6eso180435466b.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726274562; x=1726879362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vjoo8BrOluBVpm65K5csVXuxnL7vaHHGqyaOhp/LcwI=;
        b=ByxF0QJSlu0QBbW/OsMmmNaOvw9Vyqds+2UoA5KveSKMXRHOwRqXmQkwS81qrsBl4Z
         fq1p+94a6cq2t/pOlKhvo5Qez+ffWGoUZxw9T7D/66B69ugel35I9CrMaTVaOsMH+SGw
         ZtcbA3S306xHpJ4J1UY/QHaTQQZMj1GZnxxOJ5schCftoOorsQPDHgZLsSXg1CXXNySr
         sV2AsI6fF4Het3Cw74McE3/4dcamZEOyBlDWzvrvw6Avmy+TQrAvE+mvBDBAN7ZRpOLe
         +1U17N59AkRjdTQvMCZXQlKwJoMcrxXUQuDAHa8icg787bjpqlnQu5DNCIkRe85IdrtX
         ChAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726274562; x=1726879362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjoo8BrOluBVpm65K5csVXuxnL7vaHHGqyaOhp/LcwI=;
        b=cJknO+aKrkXs07cdAq1t4jS9uKkbUFRzV83db5PcDGRx+M51jifww5N1bSTCcO2CEL
         Jj9Z4Fe8oPEVqCT6I2aSz82qlSPbRwIBC7rYtVqSeAWHoG4AlF0gKPFjEJbt7lCnbdlh
         tfd+08UiIkyaMCvETsD9seE0yUTR06v7pA+DBobqAZVTLYUWaDxSDVMy0Owt8wpULtvn
         Zwfq/euxjVRh7UhO1ofH4VkuYbEMObi1PBah+k/iKPLPqUhBy/JVCvxn8GUBLORMLeqq
         MFIL9S1OLcsHjINpcqPhhWs5g1hllODwuoYP9mNGI+6NnCt19QkAhu/p0NM0AmXRI/sZ
         sfkw==
X-Gm-Message-State: AOJu0Ywv/Ls4nisqXR/mANjAS71hxxrZe+mDh68U1eEPt2znOhnC4wCh
	EVnRd+RfO50Q8QnkzwAisufBxB0ga8XnPDsUesU0ytR1gpp3N6R5nFkt/g==
X-Google-Smtp-Source: AGHT+IGkr1Citk1/0FzcvCqvJ8CgUw54wf4Zrmr4bacuu7SJNvTYBvj7gZcPShd2Z0Lkwt6aN0xyAg==
X-Received: by 2002:a17:907:3d91:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a9048044a21mr373083666b.46.1726274561287;
        Fri, 13 Sep 2024 17:42:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f42e6sm16038866b.78.2024.09.13.17.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:42:40 -0700 (PDT)
Message-Id: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Sep 2024 00:42:39 +0000
Subject: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
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
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In February 2023, older `actions/upload-artifact` were deprecated:
https://github.blog/changelog/2024-02-13-deprecation-notice-v1-and-v2-of-the-artifact-actions/
This was recently followed by brown-outs.

However, the `linux32` job relied on those, as there are well-documented
problems (see https://github.com/actions/runner/issues/2115 for example)
running modern, Javascript-based Actions in 32-bit only containers.

To get the CI builds to work again, a work-around was implemented in
https://lore.kernel.org/git/20240912094841.GD589828@coredump.intra.peff.net
to let the 32-bit container make use of the 64-bit node 20 provided by
the Actions runner.

This, however, runs the risk of using 64-bit executables when we
purposefully chose a Docker image that only contains 32-bit bits and
pieces so that accidental use of 64-bit libraries or executables would
not happen.

Let's go about this the other way round instead, by overriding the amd64
version of node 20 the Actions runner provides with an x86 one (which is
"officially unofficial" by virtue of being hosted on
unofficial-builds.nodejs.org).

This allows us to stop using the now-deprecated versions of
`actions/checkout` and `actions/upload-artifact` before these Actions
became Javascript-based Actions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(linux32): do make Javascript Actions work
    
    I propose this alternative to 9c261856c91 (ci: use regular action
    versions for linux32 job, 2024-09-12), keeping the updates to Javascript
    Actions.
    
    The benefit is that it keeps the 32-bit container used in the linux32
    job clean of any 64-bit libraries so that we don't accidentally end up
    testing 64-bit stuff without wanting it.
    
    For good measure, I also reported this problem with that deprecation at
    https://github.com/actions/upload-artifact/issues/616 even though I know
    that the GitHub Actions team saw a headcount-losing reorg recently and
    therefore I do not really expect that they have any bandwidth to help
    with this. So this work-around is the best we can do for now, I believe.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1790%2Fdscho%2Fuse-x86-node-in-linux32-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1790/dscho/use-x86-node-in-linux32-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1790

 .github/workflows/main.yml | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 97f9b063109..25a5f5f0e29 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -348,19 +348,27 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.distro}}
     runs-on: ubuntu-latest
-    container: ${{matrix.vector.image}}
+    container:
+      image: ${{matrix.vector.image}}
+      volumes:
+        # override /__e/node20 on 32-bit because it is 64-bit
+        - /tmp:/__e${{matrix.vector.jobname != 'linux32' && '-x86' || ''}}/node20
     steps:
-    - uses: actions/checkout@v4
-      if: matrix.vector.jobname != 'linux32'
-    - uses: actions/checkout@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
+    - name: prepare x86 variant of node20
       if: matrix.vector.jobname == 'linux32'
+      run: |
+        apt -q update && apt -q -y install curl &&
+        NODE_URL=https://unofficial-builds.nodejs.org/download/release/v20.17.0/node-v20.17.0-linux-x86.tar.gz &&
+        curl -Lo /tmp/node.tar.gz $NODE_URL &&
+        tar -C /__e/node20 -x --strip-components=1 -f /tmp/node.tar.gz
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}

base-commit: 87dc3914693da5febad427161fc6bdfeed3426c7
-- 
gitgitgadget
