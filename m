Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6552500DE
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145798; cv=none; b=bGQLOkcT6S4E44ALvTb9+MtqV24JgmAfDdCAHC4oZ/AO+5CU8Abzojfr/WR9hQtSJt9NkXk/LD/2VHzoMDdJK46zaCC1EOVVvvZrIVRwcAbq/wIY4PiFUbkcRwhSDp8eOdDzGzHA67Hodyctoe0n12zJAAYIOp47+Wpl9NQP5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145798; c=relaxed/simple;
	bh=zVT1hZanlATOB0LTTJ0JG/yXVOvxamOOJLimt4FXDdk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nZvyxyFnjiJXIAe63Mqry8CX8lCcGruYSWY0dZRNnORUsYu46U+FtYqSLBLNHXaiFHrVnBPWH4SoQf9WCJJ9jNDBbVnGY9mcbzmGzFnFrLwNaeZcjlOVFclOVTiiBwVemCdX17d3Q+vPUn+DXLUVpl4vp2ZBNzbOq23KKC9JYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bAstmBGq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bAstmBGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744145794; x=1744750594;
	i=johannes.schindelin@gmx.de;
	bh=OgTjcjSJdgCSwQXzGAAt0MEXGHkGzzOAmxIppyMQ5xw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bAstmBGqkh7vseh5zkFRaQyESAOKZhIYbhxiodhVG111VTICXyZNXkIz56vXPIUa
	 9e33LSjVC+IkkeFKjaTKiR8TWFKAeN7gchXSiLWcdJthsZzl7NwhpacKTPcd9vgyt
	 bcivAblTWx/82peck+6XrrewRIkSbgOEPk4+ET8sJZiLOlga0qFGa9Nw9tYXcgZeO
	 176WtoYgTlyibUdkOFoCyY32yArqUTZgrANjiFkh8YzPg2v6Ty9fC2X0IxSQ2Ul73
	 +QcB0m/RgS2c9jcbI23U15npFtmXRAxT/m4Ec3aYa2+9Qo18/wIpNqEyEx4xOJI+i
	 2N7+C6q8Zgstqb714w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1swrbw48rV-00xo5w; Tue, 08
 Apr 2025 22:56:34 +0200
Date: Tue, 8 Apr 2025 22:56:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= <congdanhqx@gmail.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
Message-ID: <77f82414-261c-d2bc-f911-ed3d4b06c86e@gmx.de>
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1294897309-1744145794=:9725"
X-Provags-ID: V03:K1:vWi0Zlbv6mb5cxRW8waE4G76kykF190+oAXby/EO4c4zuCqmGtb
 aFQkfLe9Wrxqwz7CRGlQ43ibDGxqMlSc4fEbloPyjTdaHoG/Kt8Smj6dGoo71iBIs/77nxe
 AL4fMHQeWTAO2pSRdYiup4ngmeubWsxl+nIjsuU6FIiwCjq0Ny7p+q0JI9/2lM7kdFIcqUF
 nwPjldfMGRgQ9tBR/8Uqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6bEEkACdeMQ=;TTDAjtjzVaJz804OmXkAMkwDGB2
 9V3CR3aE8a7aj+oX39YExOFsDIHMh5ZDGM1Jb+r8PBPQ92MsTi1/1MeHLMPi9Ee0BGtx9+kHl
 59V6DQ1Lx+2F7EL8KpXX8UYggeXArRi276uayKo39WlLJi3nX05JceUboNTmqHtmc3VOn+2+n
 pqlVliRv/aX7zd/pECuafRsLX5yR5Lwn1uTMcSbUxMBhPs4cwPa2HpXrMKPALHkI5b+lr7zL7
 n8s7lw5DPJ1g9j+83ndxfFvCld9EzDHTfcA2U2kpgKPbp+9SHeneyKbjLoug6IOp03ZwioUkc
 tdIFps9N41CGXkyCXiBuEZUTwvudFiABcHNrT6I123kagS28oT871HMK1OqmJKiGfNrs4ulLe
 SkgFOpKAdpkDib1MduedICJoWqyH5ESq4uuVSjMehXhYCJLzsX/GW+AniborqW5CRCUBvUCIK
 7wCIoL+kFLoVKnEPe8WU2dUkYqDWiQPa4s2xA2GB9Te/qveNsiONs4uCwDcr+MzcmiH5gRQFT
 PPEp/tmTmF6nsuPv1xX/BFNJ0OLZOgQVgX98BzW6tFhWbAvtRBl+vXS9muLWwtlxw/5VEs9Mt
 qqe6z/8DQX6reMNT8AZF41KAVRsrxd1lauqT9LORuPz4gNXfbFm8reQ+MzxIzwbEu1j95E5FA
 xCC04ZGXctd8EhNDdqoN6HgrkZa+juF7esE1UJnD3JTLukDydFQ++Ar/PHOBI+xj9hZYXR0zs
 S/+VKDApjDqlFfSvSBHa1Tx3YSKs5GoIHU7wZTliGuYKV33E6qBBarUcvWzTPIJxUpGbohGyv
 hyrrJWJqypyl/SS6gCDvFyniiFC4Z4kyr/4dWd5Ttk+pJpC1fWKM4jMc85q5lNhdCk4epq2Ac
 AYFhN1plp0NrbrvTxy/wH277ZP4jYS9yjuZGckMYjlnpb5qt+AW8+Z7pa7QK9V6gFSoqGob4R
 fAiFijlJhU+Ptx3naMpLecZN2QknvO9tzkBIBQWXdiAT2mtvGjokx5kmrWDdPNtg5UX7B5ic4
 Xo3kqNZoHz8xbb7yuHDIG7CefSPR9HHsiO+2uokFBawWA2v3vXJKiA2lSsvuc3WGwgJazdoQl
 s08ju6kAduE1g+4DIupvWYGGPW/IMSu0rmqOcPscOEtHnB6fshOTiNvg0vjg8zj3vmUix3iNf
 v+qqWN7IJ2hPr3XVzUQZ+HDas1Csmap9JBHpP2dTwvwlhOSviXf8cdmc9W8/kIrhLrffaOX4p
 KAEo2gg/cCrbt50hmIJPYTlLQMdM4BS7hksl1suAnnmldE3lBS67FPlGigu3ir7gGcisy4+Xq
 yIkQ5YTgfL5DZ5SKPsKFFTJhxglc9SYNLnkoovleli7KTnbKh5TGpZMhsrDtL20+/Xem7G3BL
 JDJ0JAuhEv48eSfxnd3aaQwR1nD0xavh3jfNP4MUp2jcr4QrzwUCQDi0Lnv4ZrRUWV/zrd8XV
 2mwR8BEgbO+ClO+IxE504YEZozM+rxftsZDBYiFSxpzFllNeHduDuJmTQGhBnijLWLNlilxSk
 atLdwlLq1R5PmMHiSEk=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1294897309-1744145794=:9725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Wed, 17 Jul 2024, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> With at least glibc 2.39, glibc provides a function declaration that
> matches with this POSIX interface:
>
>     int regexec(const regex_t *restrict preg, const char *restrict strin=
g,
>            size_t nmatch, regmatch_t pmatch[restrict], int eflags);
>
> such prototype requires variable-length-array for `pmatch'.
>
> Thus, sparse reports this error:
>
> > ../add-patch.c: note: in included file (through ../git-compat-util.h):
> > /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
> > /usr/include/regex.h:682:41: error: bad constant expression type
> > /usr/include/regex.h:682:41: error: Variable length array is used.
>
> Note: `__nmatch' is POSIX's nmatch.
>
> The glibc's intention is informing their users to provides a large
> enough buffer to hold `__nmatch' results and provides diagnosis if
> necessary.  It's merely a glibc' implementation detail.
>
> Hide that usage from sparse by using standard C11's macro:
> __STDC_NO_VLA__
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index bc81d3395032a..4b9daca1dcc58 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1381,7 +1381,7 @@ ARFLAGS =3D rcs
>  PTHREAD_CFLAGS =3D
>
>  # For the 'sparse' target
> -SPARSE_FLAGS ?=3D -std=3Dgnu99
> +SPARSE_FLAGS ?=3D -std=3Dgnu99 -D__STDC_NO_VLA__
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>
>  # For informing GIT-BUILD-OPTIONS of the SANITIZE=3Dleak,address target=
s
> --
> 2.45.2.599.g51c0d632d3b6f

Thank you for this patch!

Due to the brownouts today (see
https://github.com/actions/runner-images/issues/11101, surfaced e.g. in
https://github.com/git/git/actions/runs/14342895944/job/40206357016), your
patch came in handy, as it is required for the following fix:

=2D- snipsnap --
Subject: [PATCH] ci: upgrade `sparse` to supported build agents

The `sparse` job still uses the `ubuntu-20.04` runner pool, but that
pool is about to go away, so let's stop using it.

There is no `sparse-22.04` artifact provided by the "Build sparse for
Ubuntu" Azure Pipeline, but that is not necessary anyway because Ubuntu
22.04 has the `sparse` package: https://packages.ubuntu.com/jammy/sparse

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 .github/workflows/main.yml | 11 +----------
 ci/install-dependencies.sh |  2 +-
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ff44c0a8c067..c9455246269d 100644
=2D-- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -449,20 +449,11 @@ jobs:
     if: needs.ci-config.outputs.enabled =3D=3D 'yes'
     env:
       jobname: sparse
-    runs-on: ubuntu-20.04
+    runs-on: ubuntu-22.04
     concurrency:
       group: sparse-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes' }}
     steps:
-    - name: Download a current `sparse` package
-      # Ubuntu's `sparse` version is too old for us
-      uses: git-for-windows/get-azure-pipelines-artifact@v0
-      with:
-        repository: git/git
-        definitionId: 10
-        artifact: sparse-20.04
-    - name: Install the current `sparse` package
-      run: sudo dpkg -i sparse-20.04/sparse_*.deb
     - uses: actions/checkout@v4
     - name: Install other dependencies
       run: ci/install-dependencies.sh
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0df74610d063..8700c0f2924d 100755
=2D-- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -119,7 +119,7 @@ StaticAnalysis)
 sparse)
 	sudo apt-get -q update -q
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
-		libexpat-dev gettext zlib1g-dev
+		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
 	sudo apt-get -q update
=2D-
2.49.0.windows.1

--8323328-1294897309-1744145794=:9725--
