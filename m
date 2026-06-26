Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC3310652
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489714; cv=none; b=B0G7EoLMEEDX03R6ev+c0N/UIMvq/xufK5K0zeokhF0NMagvOt3gNmxu4LbIX+IT+aS8U5yEbv899gkPcxqZQritQgopwdxFNf3waEknODCtrhuZi9Ity3/NqIWsVZB4FCAa1rvapv+ciEJSg9VCEw4sazkhR8F8kMpqgzlHDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489714; c=relaxed/simple;
	bh=vS5g7N55X//1GculhDWacGqUDeHIA7kwLhJ4uUSVQG0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gcRvIgbwR2d8HK2JFCgqFLSPmu0iUqcoxHHe74X1JryOP7AgoVN/MEgUCTMIDOrAaSYPCxEY5RojjxGCG23SVJu1hqT53NMvQVWOB9n5zvcHpqZpyPeMU7PHIMSbF0a2KkpEZJC0okYWWfclbX6cbpw6kD8+vkjwz+ZQj50dukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DU0C0Orp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DU0C0Orp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782489710; x=1783094510;
	i=johannes.schindelin@gmx.de;
	bh=M5K3mxje48fx93uVMKT3HibqYppy/w/krPUM0VnD09M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DU0C0OrpQC4hiAzVvLa3IFnfApL+2bNfOQWMrvdUzw8wp7mrL4ZHUzz/4BEBgThm
	 uxkG+A1S3Tizl82PutcCeaiqS16J+k92rL2XcCUAzL737WKTZL979HZGIDt9CLtYz
	 9doRw2nheydsvn6u+dWHTFqCMNsUT4z3tks0OLutn+17DPAZkeyOlln6K6qDrbLGc
	 PVMtcoO3IoCTq8WmnbwmuhJ05dqz91lhmC/uxjE7ud5eryyyjTOgkNkvXcm6Twf7i
	 97+uia6tDbSrULayqXwieoL16NPqe0i1vw3SCuHvTwOWJp1uqpR3Iy3Y47rtSl59g
	 pdUr0UaQBVUaiBZ4tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1wZa5p2IJz-009fJG; Fri, 26
 Jun 2026 18:01:50 +0200
Date: Fri, 26 Jun 2026 18:01:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
    Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
Message-ID: <32bb1cf6-1e37-dc0c-dfb2-e78a30763342@gmx.de>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im> <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:cphlzdbS++R1W5Mt2f0xARRRe/yykpm8oCl+m0L8A4zyx9AVpkx
 KbuFLaI42CmJymgePqvo69R/Q180WCM2cBMrrHs/eUf+5zUEmwRTiEau23FJYPdx3qOn/PO
 6wC3cSvfGacVQbUlcJ3rBHSf5K4jjHaJIXQrJCnK5VxNos4Su3ukImIIuzp8SF3VGwwI4rI
 Fv8BznVv6fRaoBbV14tgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2fwiRdN1Ssg=;ZnScOVxhckDjcnX0FjT1TcJ2zmC
 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
 WKDetTunM4pYTzLM8Q=

Hi Patrick,

On Mon, 22 Jun 2026, Patrick Steinhardt wrote:

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cf341d74db..a8402babd9 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -179,7 +179,7 @@ jobs:
>        uses: actions/checkout@v6
>        with:
>          repository: 'microsoft/vcpkg'
> -        path: 'compat/vcbuild/vcpkg'
> +        path: 'lib/compat/vcbuild/vcpkg'
>      - name: download vcpkg artifacts
>        uses: git-for-windows/get-azure-pipelines-artifact@v0
>        with:

Please also adopt:

-- snip --
From 1d09a51d426bd3592e4f4b0331f7715ab3b5d502 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 26 Jun 2026 14:39:19 +0200
Subject: [PATCH] fixup??? Move libgit.a sources into separate "lib/" directory

Turns out that there was one path that was forgotten to be adjusted.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 29d2057bde4b..57ad4ba64f67 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -188,6 +188,7 @@ jobs:
       with:
         repository: git/git
         definitionId: 9
+        path: lib/compat
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v3
     - name: copy dlls to root
-- snap --

This is needed to fix the `vs-build` job, see
https://github.com/git-for-windows/git/actions/runs/28242360731 for proof
that it's now working.

Thank you,
Johannes

> @@ -189,11 +189,11 @@ jobs:
>        uses: microsoft/setup-msbuild@v3
>      - name: copy dlls to root
>        shell: cmd
> -      run: compat\vcbuild\vcpkg_copy_dlls.bat release
> +      run: lib\compat\vcbuild\vcpkg_copy_dlls.bat release
>      - name: generate Visual Studio solution
>        shell: bash
>        run: |
> -        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
> +        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/lib/compat/vcbuild/vcpkg/installed/x64-windows \
>          -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
>      - name: MSBuild
>        run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
> @@ -201,7 +201,7 @@ jobs:
>        shell: bash
>        env:
>          MSVC: 1
> -        VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
> +        VCPKG_ROOT: ${{github.workspace}}\lib\compat\vcbuild\vcpkg
>        run: |
>          mkdir -p artifacts &&
>          eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
> [...]
