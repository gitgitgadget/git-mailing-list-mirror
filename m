Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778713;
	b=XaF0ILcnhAuOJw8wlphn91JX+hvkVz+F3FC3eDBrxAsB6icFYQfF0xUwgfPpgUDr7ySB
	 7jZrwbFt93nfdMiQ2JFQSMx6/n/yD+o0aFUzD9ftI+pd/9lSMmDA/+duJ8ByvlItZxwcg
	 zU0KkQtTmW8j/jg2l0sgfxg5hJNvJW6HDRdRSw3pCOBfIwxVYGcO0W9cPx9/YnRIiJwsp
	 96/EZPg7Ckt3Ggquowc5VCDjtsSDtnPb3jmw1pA34VxaXP6bl/Qi2mJqn65I1t2jGD8QE
	 cI+7ka7DLlQjfmZDBb3XICuQgHB12DKLX5D4snFL/ohzSxDD+DVv5P+VPO8fVk8Zhqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=V4nWN55YOvn7upM79v/Fc1tAVpnv3ctfjripJJUOeuQ=;
	b=N8d0UiyCHQv7ogDzNgFVdR9Muy31AFaHRC+75Q6jULEccsFFGX+U/c+WHAu91/m/gT8m
	 33wkMkPJmLSXvLXAFsr/YkgowUr2w+d7GLdy4D3JfQbsY/lYzyeFM0ALjo8voH2u3radh
	 K8fpu3WIVdRR8KKJhB3rcsGBaL8BQJi1wRcrPt6XB/WJCFg4IPSe/1DzmGTCIXRiCyjQZ
	 yq956ExhgsjupBNXF4DIBvzjUoMncD3gFA5dz2BH4VucQFd3xdgt55+lFx5QTDp7J5ucm
	 EeUSPLo7/KKkvOiE0DNsGbjRNLSSb/cQHQMJLRMUIWRIFizBtoF+XKD7WkmnVdpun3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yb74GrLU;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B30606A32D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B30606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yb74GrLU
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-675617e81f9so1164396d50.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778712; x=1793383512; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4nWN55YOvn7upM79v/Fc1tAVpnv3ctfjripJJUOeuQ=;
        b=Yb74GrLUWs/p1c0MxOEvb+TVpKIkX0zmI/fDh7ErOFylpCuLLPriYDJiSeIV4R3p9s
         jDt+Ijm8gP85aes7TjnM8Sis32XqoBJFbbEttmZyz0FR8eQBuZf4aWfJqtafobGvuKsF
         If4LQ3RaIQqFGYoCzy9jHy2l3kP5I+u1pBImg+dkGvwZaarkhWVMLZu3VBmeSm6bjbDl
         8Ni+Rr+1C0e0UEBXLjizu0tzdDzIJiBGlQa/A05tSL4N3qtT24ED5XjFVotbCyi4+zLO
         vv6KMJV8ijkb4hSM9FQX/pVWtwynj2xZm+pyvp/4PRW7xCPF6MZRq9+d5WwSh/uYa0qM
         HpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778712; x=1793383512;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4nWN55YOvn7upM79v/Fc1tAVpnv3ctfjripJJUOeuQ=;
        b=P6xlTk8snbDkfKr05omqcsDM5OpscPFpG3yDf6U/K1tSmXGZhULKfhXIK2iCJMTAOD
         ygTR/FtpW6MUHcCseP1Vu9wD2cGinbZyLw/GAb+ffFBlj+EJWGNhBXTB0QYvSivSohpc
         IIpBKm06GCqzjbyIYt7FmEjda62IB9YObXAnYnHb1vIsPI/XK3ion0eMQ5lDso0W1XXB
         90GFdrZKJ7Y5F5zFDJLYr6PUOsr4LgWJ94eZaZ/Zcvr+Dp6FK6B14VFSNsiQjhOx4Xpb
         K3YgMib34u0bGCfxpkTVJr3jULJX+31ogSF1GM18Qke4VU2U8PfHvcvapwVCXRQYB2aA
         2o/g==
X-Gm-Message-State: AFq9FYKP8x21jRLjuLbKuHqhumPj/TuPz7EUPpBoyhOZ6xaSJxqjwGlJ
	798C7onIgGXT4oyqn1ffFPf/+s2DZk/ahYPv+3mHOHSkAVAZif0X10EB
X-Gm-Gg: AYBFou1h3J75S+xhgUIO0emAz55rhZ44WKFsX/v9wAVGItaLnpe1HOa3TbvYr/VmQT1
	XuIIRJmIdYZXhtgQLX7CxubSDefJt8Ib2XmrcCdJgE8PoEnAqTK9QVMZELqCnt+8W12WQqKlr0o
	Cn7WGPSkRd3IX0qxC9iIq8z5qNcEXFTCNeGd+HU8OcbIRKTwIY03JXxgkItfVWsoebs2LwpU1Cz
	3AoWok2f7JyGgk0i9j/gBLMs+00wq95+648I/LmprMo+Zg/T0PHgZcMdmho6VPxGxsHBnK1j0Jf
	XejqXvv574tY5S31dGT4jenA3VheNNWzKwvw+1F4kYXQu2rPnYiacExn8HDO1G5KLRJCXIWQ+5L
	+9N6VuEe6uCUy+hw2OrqYJwQxyr3MZ94xOhU+Ix2+JQUi0YYDy40Yb0NnEee0GhPQyiMpLhRicb
	Vjoc0YY1AuJV+1yAJqgVCcWU03oWYIdcKsFD1cOTS0oen+nEeZZ5I9NdAypL5liCbU9qlWW5bIP
	dz49/++pK/qyM1pSWp+gIwJt7e3cvlJp02cC4y+peWbtorz5/Ev9APuRDFK2751tKA5tIgMFIM8
	OR6o3ej7ue4yeTgUiaE+438+cOsY3xC8pjf3AjV1qFcEO17vxir1PDwgeSlLv47vQ5ipFyVRNvr
	PO1FqpYU99CfiNAxxLQnU7cx2WVdmXzN2yiZOoC43zYv+iXo=
X-Received: by 2002:a05:690e:4853:b0:677:f374:1764 with SMTP id 956f58d0204a3-67a35bfa42dmr1850055d50.45.1792778711691;
        Fri, 23 Oct 2026 11:05:11 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:1d:477:fbde:1358])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a42f3911fsm290500d50.21.2026.10.23.11.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:05:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ci: pin actions in the main workflow to full commit IDs
Date: Fri, 23 Oct 2026 14:05:00 -0400
Message-Id: <CA205F3D-2071-48D5-9986-5FF3F4AB8F68@gmail.com>
References: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
To: Taylor Blau <ttaylorr@openai.com>
X-Mailer: iPhone Mail (23D8133)


> Le 23 oct. 2026 =C3=A0 12:41, Taylor Blau <ttaylorr@openai.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFSome forks are hosted by organizations that restrict which GitHub=

> Actions may run, including requiring actions to be pinned to full
> commit IDs. Our main CI workflow refers to actions by version tags or
> branches, which prevents it from running under such a policy.

Yep. This is becoming de facto security standard.

Perhaps we should say so? =C2=AB Pinned commit IDs prevent attacks
on CI and any secrets stored therein by compromised action suppliers =C2=BB
or something?

> Pin those actions to full commit IDs, retaining the version names in
> comments to make future updates easier to review.
>=20
> Signed-off-by: Taylor Blau <ttaylorr@openai.com>
> ---
> This is based on a merge of 'ps/ci-housekeeping-and-modernizations'
> and 'jk/http-curl-strip-creds'. The latter is needed for the HTTP
> auth tests to pass with the curl versions in current CI.
>=20
> .github/workflows/main.yml | 64 +++++++++++++++++++-------------------
> 1 file changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fe8155772ab..ba0b5ffb634 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -65,7 +65,7 @@ jobs:
>           echo "skip_concurrent=3D$skip_concurrent" >>$GITHUB_OUTPUT
>       - name: skip if the commit or tree was already tested
>         id: skip-if-redundant
> -        uses: actions/github-script@v9
> +        uses: actions/github-script@3a2844b7e9c422d3c10d287c895573f7108da=
1b3 # v9
>         if: steps.check-ref.outputs.enabled =3D=3D 'yes'
>         with:
>           github-token: ${{secrets.GITHUB_TOKEN}}
> @@ -114,8 +114,8 @@ jobs:
>       group: windows-build-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> -    - uses: git-for-windows/setup-git-for-windows-sdk@v2
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
> +    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680=
b81584a72a1a4807401f0 # v2
>     - name: Install GCC-compatible Rust target
>       shell: bash
>       run: |
> @@ -149,7 +149,7 @@ jobs:
>     - name: zip up tracked files
>       run: git archive -o artifacts/tracked.tar.gz HEAD
>     - name: upload tracked files and build artifacts
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: windows-artifacts
>         path: artifacts
> @@ -166,14 +166,14 @@ jobs:
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
>     - name: download tracked files and build artifacts
> -      uses: actions/download-artifact@v8
> +      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a54=
61e7c # v8
>       with:
>         name: windows-artifacts
>         path: ${{github.workspace}}
>     - name: extract tracked files and build artifacts
>       shell: bash
>       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
> -    - uses: git-for-windows/setup-git-for-windows-sdk@v2
> +    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680=
b81584a72a1a4807401f0 # v2
>     - name: test
>       shell: bash
>       run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 1=
0
> @@ -183,7 +183,7 @@ jobs:
>       run: ci/print-test-failures.sh
>     - name: Upload failed tests' directories
>       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: failed-tests-windows-${{ matrix.nr }}
>         path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -199,20 +199,20 @@ jobs:
>       group: vs-build-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> -    - uses: git-for-windows/setup-git-for-windows-sdk@v2
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
> +    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680=
b81584a72a1a4807401f0 # v2
>     - name: initialize vcpkg
> -      uses: actions/checkout@v6
> +      uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>       with:
>         repository: 'microsoft/vcpkg'
>         path: 'compat/vcbuild/vcpkg'
>     - name: download vcpkg artifacts
> -      uses: git-for-windows/get-azure-pipelines-artifact@v0
> +      uses: git-for-windows/get-azure-pipelines-artifact@2e424b98e1251b72=
5d6064c5f1a9f854a33e5b88 # v0
>       with:
>         repository: git/git
>         definitionId: 9
>     - name: add msbuild to PATH
> -      uses: microsoft/setup-msbuild@v3
> +      uses: microsoft/setup-msbuild@30375c66a4eea26614e0d39710365f22f8b0a=
f57 # v3
>     - name: copy dlls to root
>       shell: cmd
>       run: compat\vcbuild\vcpkg_copy_dlls.bat release
> @@ -234,7 +234,7 @@ jobs:
>     - name: zip up tracked files
>       run: git archive -o artifacts/tracked.tar.gz HEAD
>     - name: upload tracked files and build artifacts
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: vs-artifacts
>         path: artifacts
> @@ -250,9 +250,9 @@ jobs:
>       group: vs-test-${{ matrix.nr }}-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: git-for-windows/setup-git-for-windows-sdk@v2
> +    - uses: git-for-windows/setup-git-for-windows-sdk@aed153d1258c311b680=
b81584a72a1a4807401f0 # v2
>     - name: download tracked files and build artifacts
> -      uses: actions/download-artifact@v8
> +      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a54=
61e7c # v8
>       with:
>         name: vs-artifacts
>         path: ${{github.workspace}}
> @@ -270,7 +270,7 @@ jobs:
>       run: ci/print-test-failures.sh
>     - name: Upload failed tests' directories
>       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: failed-tests-windows-vs-${{ matrix.nr }}
>         path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -284,8 +284,8 @@ jobs:
>       group: windows-meson-build-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> -    - uses: actions/setup-python@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
> +    - uses: actions/setup-python@ece7cb06caefa5fff74198d8649806c4678c61a1=
 # v6
>     - name: Set up dependencies
>       shell: pwsh
>       run: pip install meson ninja
> @@ -296,7 +296,7 @@ jobs:
>       shell: pwsh
>       run: meson compile -C build
>     - name: Upload build artifacts
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: windows-meson-artifacts
>         path: build
> @@ -312,13 +312,13 @@ jobs:
>       group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> -    - uses: actions/setup-python@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
> +    - uses: actions/setup-python@ece7cb06caefa5fff74198d8649806c4678c61a1=
 # v6
>     - name: Set up dependencies
>       shell: pwsh
>       run: pip install meson ninja
>     - name: Download build artifacts
> -      uses: actions/download-artifact@v8
> +      uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a54=
61e7c # v8
>       with:
>         name: windows-meson-artifacts
>         path: build
> @@ -331,7 +331,7 @@ jobs:
>       run: ci/print-test-failures.sh
>     - name: Upload failed tests' directories
>       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: failed-tests-windows-meson-${{ matrix.nr }}
>         path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -367,7 +367,7 @@ jobs:
>       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
>     runs-on: ${{matrix.vector.pool}}
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: ci/run-build-and-tests.sh
>     - name: print test failures
> @@ -375,7 +375,7 @@ jobs:
>       run: ci/print-test-failures.sh
>     - name: Upload failed tests' directories
>       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: failed-tests-${{matrix.vector.jobname}}
>         path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -388,7 +388,7 @@ jobs:
>       CI_JOB_IMAGE: ubuntu-latest
>     runs-on: ubuntu-latest
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: ci/run-build-and-minimal-fuzzers.sh
>   dockerized:
> @@ -464,7 +464,7 @@ jobs:
>         else
>           apt-get -q update && apt-get -q -y install git
>         fi
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: useradd builder --create-home
>     - run: chown -R builder .
> @@ -474,7 +474,7 @@ jobs:
>       run: sudo --preserve-env --set-home --user=3Dbuilder ci/print-test-f=
ailures.sh
>     - name: Upload failed tests' directories
>       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v7
> +      uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6=
a0a # v7
>       with:
>         name: failed-tests-${{matrix.vector.jobname}}
>         path: ${{env.FAILED_TEST_ARTIFACTS}}
> @@ -489,7 +489,7 @@ jobs:
>       group: static-analysis-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: ci/run-static-analysis.sh
>     - run: ci/check-directional-formatting.bash
> @@ -505,7 +505,7 @@ jobs:
>       group: rust-analysis-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: ci/run-rust-checks.sh
>   sparse:
> @@ -519,7 +519,7 @@ jobs:
>       group: sparse-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=3D=
 'yes' }}
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - name: Install other dependencies
>       run: ci/install-dependencies.sh
>     - run: make sparse
> @@ -535,6 +535,6 @@ jobs:
>       CI_JOB_IMAGE: ubuntu-latest
>     runs-on: ubuntu-latest
>     steps:
> -    - uses: actions/checkout@v6
> +    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v=
6
>     - run: ci/install-dependencies.sh
>     - run: ci/test-documentation.sh
>=20
> base-commit: d46921825429c74931372567941eaf98d4483210
> --
> 2.56.0.187.g9e9ae442333
>=20
