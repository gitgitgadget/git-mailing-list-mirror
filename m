Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773513;
	b=TNaUTr6XsuXZzmSe9NPhf4AZuVxukua7sSncwIOZxNVQ2JCiD6qZRE7WuAiJCUEgN3ZB
	 x0CRJDu2HcaS7TfaaWtKX3UhoBzx71wppdGU0UdqK9qjPwO+FgcHvv+OrpNFwYuUDKbQB
	 VzzMETckBJm/HdRRSy86BaTFsPkV2P2iJo8mAmRY7+Rs8gGcIwR15S6URRe6rAcpElpYe
	 RtxtbwBHcdbQ2tv2FM3z80SEyDhCFJ0NIHuGaw6du7s0CvlNCJnr8eAqFvsmY2LYwvZVj
	 bx9VMRPbpYxiSdsBXbRnj+JfcagipCAnPOy+W6gxFKTMh7//oVv6aYipF5R7gNzFpNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=E0BQ3n5SjNEHgY9KjbdUuWCgezonseVvi8YbQj9/Fy0=;
	b=YTuxu0ZX58iF6V/sH49YPTO7LVObW+/g/DBtDbbuSMedZkz8A1g+HpyDASrg/fB8JTq3
	 pWTHKU/VnQIWnQM+XhZ05CZx89tojiD5/SoYSNGcMjKsqZUTGGA7LfVIav9T09PLiiWnQ
	 u7T8YoixSa1ByRUQqXgcBx74DbOuSq62xuU1J8wx9W069IPcAFGrzoJmYAYaAAez4cM8S
	 vIUZYrjVG/DQaQHrkbr3RIoC1R3TtefQDxXUPVF8rr6vlftDa+8nROtzQO6FTg5CjPmww
	 D75vkDJ0VdOTuAlQHCAIoDywhcY7zyu49lbGTqovnJxQ81LDyFGhUMCVuoDtAhYSGqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Acmo12mf;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEC606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EEC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Acmo12mf
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e503815adso112656885a.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792773512; x=1793378312; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0BQ3n5SjNEHgY9KjbdUuWCgezonseVvi8YbQj9/Fy0=;
        b=Acmo12mf4KGmKX9ksEQ2Qa0aWDfYOGRK+NDHVgBDvWMsc4EKM3XB+lGxwfymPUTkTT
         2AC5hiqj3mX3ijMwdskRX1YAyL7v5inTB4aXlkY+p0MRaF1C7wZlqN67gVmlgrPzyvf7
         7HqT30fb8cxTX+OH8L14QJLw++pujb1fLnUNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773512; x=1793378312;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0BQ3n5SjNEHgY9KjbdUuWCgezonseVvi8YbQj9/Fy0=;
        b=N3Qa/RiuT20wkRWltBgz19dZVmHqKzr3ZUJaEGWnf6vNPweBHp3ejf7tLwpmBcZ40C
         OLpehofoMz1XWox1EqwlDLynOrlFRkEyUBnPY7ShOMVE2sYkwNl2P//rMHCfsJ9Otq1F
         8dWlA5O9UxKPgxi47DwVsSHv9AWIzhOyT75xkRfdju9PyAy4GUUr9G28QG9TGXyCcIVq
         fIAQB+u7EPppAzZG8WEgsm10QVaQsKhLiBe0EzRQG2mkFmwJKCXQ6o/S3wOKAwWETZq+
         kbEEkcS0gbqZx1d0vMz+BjlBsNNmzVhDTyZtudsLIoXuLhKcdQgHFbYmGErzXxgp/8ea
         iGJA==
X-Gm-Message-State: AFq9FYJI/T8jE5wuIFmGZxgKeyw9xRIxPJUktpGDzj+amt+r3Lb5D7vk
	J6Qd6zMpGWXjqbQo9ki08brD1hdQmunULtvo5lB+ItvRYzYBrFiMiWqzHsTd3J3xQbtAXMSLeOd
	1w8uzr1s=
X-Gm-Gg: AYBFou34x/9KKmuxOsbXXXD+qGbkiEsENQQq/OSiSCnWXEB/rjMyL4n4xAXPyJPCQqv
	oz2LR+TxkFaSEthTS6hknAzGC0qEONKIFve1bWm/CUdlTArR8z25W68zV3+FTdejuT7Ai5pGl8k
	Hl5gPPBwqvGR+6ta/WGvQlN9JFkOF5nKVzcpam8P5NHv6bsIvcgKGlJTIv0Ye9Mdr1NyKbz7oIf
	IzBCLcz36rb4P2G/qg7iINuDrFc2micDRn3A9P/hVqgaQ7FhG1uMohxQjwqv5mD62brc1/iscDZ
	IBKawP3egnDkR/ICESZBufwQXOWg0LOuzzgP0vJVbEB8QZuIKRMwIMDBZofnBhpo2YyIve5cMwl
	WQiPDQCAmCFUmoTF1/VxzhaT5uXt2GWbztWdW8Ots9yBhBwG89T2J3CfrTwBbumUiwM0H23AjKk
	RcyXmd6N7+XZZgqfQOjrga6y0c8SMyTR66m9aR1YEnoeg/i72jNGEsbFMpIZIwbBvCa1YMPTLg3
	zTz7CX8ZKEGLSmXlWkUnQSsEp6fYtGR/QXRxL1wIhFo7yLLvSZtJqsr4ZUVwmaoQz+XGW+7jvYF
	4UVPT4CZGPG2lA3xyqLKt6QEQCOjNTMsAyGuUbjVRLwh2GOMAPQmBqak/EgWHAy1PU+l
X-Received: by 2002:a05:620a:4514:b0:93f:35fc:524e with SMTP id af79cd13be357-93f6f7963e4mr527607085a.35.1792773512036;
        Fri, 23 Oct 2026 09:38:32 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940478113f4sm59236185a.19.2026.10.23.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:38:31 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:38:23 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] ci: pin actions in the main workflow to full commit IDs
Message-ID: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Some forks are hosted by organizations that restrict which GitHub
Actions may run, including requiring actions to be pinned to full
commit IDs. Our main CI workflow refers to actions by version tags or
branches, which prevents it from running under such a policy.

Pin those actions to full commit IDs, retaining the version names in
comments to make future updates easier to review.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
This is based on a merge of 'ps/ci-housekeeping-and-modernizations'
and 'jk/http-curl-strip-creds'. The latter is needed for the HTTP
auth tests to pass with the curl versions in current CI.

 .github/workflows/main.yml | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fe8155772ab..ba0b5ffb634 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -65,7 +65,7 @@ jobs:
           echo "skip_concurrent=$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v9
+        uses: actions/github-script@3a2844b7e9c422d3c10d287c895573f7108da1b3 # v9
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
@@ -114,8 +114,8 @@ jobs:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
-    - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
+    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680b81584a72a1a4807401f0 # v2
     - name: Install GCC-compatible Rust target
       shell: bash
       run: |
@@ -149,7 +149,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: windows-artifacts
         path: artifacts
@@ -166,14 +166,14 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v8
+      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680b81584a72a1a4807401f0 # v2
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
@@ -183,7 +183,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: failed-tests-windows-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -199,20 +199,20 @@ jobs:
       group: vs-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
-    - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
+    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680b81584a72a1a4807401f0 # v2
     - name: initialize vcpkg
-      uses: actions/checkout@v6
+      uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
       with:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
     - name: download vcpkg artifacts
-      uses: git-for-windows/get-azure-pipelines-artifact@v0
+      uses: git-for-windows/get-azure-pipelines-artifact@2e424b98e1251b725d6064c5f1a9f854a33e5b88 # v0
       with:
         repository: git/git
         definitionId: 9
     - name: add msbuild to PATH
-      uses: microsoft/setup-msbuild@v3
+      uses: microsoft/setup-msbuild@30375c66a4eea26614e0d39710365f22f8b0af57 # v3
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
@@ -234,7 +234,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: vs-artifacts
         path: artifacts
@@ -250,9 +250,9 @@ jobs:
       group: vs-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680b81584a72a1a4807401f0 # v2
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v8
+      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -270,7 +270,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -284,8 +284,8 @@ jobs:
       group: windows-meson-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
-    - uses: actions/setup-python@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
+    - uses: actions/setup-python@ece7cb06caefa5fff74198d8649806c4678c61a1 # v6
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
@@ -296,7 +296,7 @@ jobs:
       shell: pwsh
       run: meson compile -C build
     - name: Upload build artifacts
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: windows-meson-artifacts
         path: build
@@ -312,13 +312,13 @@ jobs:
       group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
-    - uses: actions/setup-python@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
+    - uses: actions/setup-python@ece7cb06caefa5fff74198d8649806c4678c61a1 # v6
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
     - name: Download build artifacts
-      uses: actions/download-artifact@v8
+      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8
       with:
         name: windows-meson-artifacts
         path: build
@@ -331,7 +331,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: failed-tests-windows-meson-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -367,7 +367,7 @@ jobs:
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -375,7 +375,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -388,7 +388,7 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-minimal-fuzzers.sh
   dockerized:
@@ -464,7 +464,7 @@ jobs:
         else
           apt-get -q update && apt-get -q -y install git
         fi
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
@@ -474,7 +474,7 @@ jobs:
       run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v7
+      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -489,7 +489,7 @@ jobs:
       group: static-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -505,7 +505,7 @@ jobs:
       group: rust-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: ci/run-rust-checks.sh
   sparse:
@@ -519,7 +519,7 @@ jobs:
       group: sparse-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -535,6 +535,6 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v6
+    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh

base-commit: d46921825429c74931372567941eaf98d4483210
--
2.56.0.187.g9e9ae442333
