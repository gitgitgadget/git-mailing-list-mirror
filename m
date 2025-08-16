Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC51DB13A
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364174; cv=none; b=kiWXeyz4eZ4wYdiftgiLcNw1JUOISIVe+SRVI5AbtFrAdjrVqdpBXWD6otnMxDWlGAj1bh1nSl7LUghsK+QDFS6ZO7M47HvbSlKw6UfKyOmqn1u07XZ8YpM1xLrAycn4yat/9jND2pE0T5BnBYn5jvsJC6pVS+MIJknflkBuoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364174; c=relaxed/simple;
	bh=hIJauNoS7qKQEUZJOrjYcVj53o4hKH/aSOqkm0x/u2Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u3kSDJrgOgKWfmba/Ez2CzVWHV72vNJV+vrPRZ35NWe9KNvW8HSZZr7iFOvO7m7YnFPWnOFf33c/jIHiDXjpX9+ndTEmrBzFALItFGiWHy3YJTFMkAS/1uheTnUUbJ5fDU5CoD4z7ipJHhtL1e/1hGdiTD5t64hVkAfGuBZRCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=opdd+6q4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="opdd+6q4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755364170; x=1755968970;
	i=johannes.schindelin@gmx.de;
	bh=JY351m80MIXi5lgVhJn0hKsQaxXMibuPzrNn8A9bX5c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=opdd+6q4WNhC/+WMSwemoisIwgBCrNmNoYYvCmICadzO0Z2Vr9gQVDoV8Ol2Uovf
	 g/rNozJt61u9MCnaPtzmtG6lTXT5+FoKmKI8zecOtPfYB5pBDSRqlDLFPbGulaU1K
	 goXslBnx9PFuwdGaBEmWrj6iQZyOpYy0GTtA1TKPBTY8G7h1wb8aLyd7Qo6eo1qCW
	 tVzKchgp6epXDAVyboOwMNIt7EGnrA6Ci+6YdBM25+7YPP5NbtF6uolqsNjZ1pvDy
	 yrmesRHwboLCZxEM02gx0JcLamZxHibpmxMd+Ora/A4kGBpa5d/Y3FH92+FsRGfbq
	 Yd08w9amVyKJgNa+Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.154]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1ucEbq1VUW-00zKe6; Sat, 16
 Aug 2025 19:09:30 +0200
Date: Sat, 16 Aug 2025 19:09:28 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] cmake: accommodate for `UNIT_TEST_SOURCES`
In-Reply-To: <pull.1947.git.1754256267117.gitgitgadget@gmail.com>
Message-ID: <3a5e72a3-ae92-5fa7-2bf8-4276afcfd863@gmx.de>
References: <pull.1947.git.1754256267117.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cmcjUx/JvUUEXrPKpjQSVzMgF0ov4eMcL/9rtahRqG1Z60iknHc
 LKR6Yn4yeKRpVzsBIxzU5s4syPGH3ljYTAjPg9Xm3Zy0H2aXT3tj3emRXSEjzxtaY0h9Y21
 OScs8mWL/mSyHu2qxDjJ+dycEyaLZ4EYhrvY+sNELJzQE8UIVnTPpj57//s2REL0mUgYhTJ
 E90owFjDyl/NlHFo8eaTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:igGgIXlj+ro=;R6TFCC06d3+aNuCbA2RUP1g70sh
 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
 FCTcLN96gT/H5tX4=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

this patch is still required; I sent this before -rc0 was released so that
it could be included in v2.51.0 final. Could you please still merge it?

Thanks,
Johannes

On Sun, 3 Aug 2025, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> As part of 9bbc981c6f2 (t/unit-tests: finalize migration of
> reftable-related tests, 2025-07-24), the explicit list of
> `UNIT_TEST_PROGRAMS` was turned into a wildcard pattern-derived list.
>=20
> Let's do the same in the CMake definition.
>=20
> This fixes build errors with symptoms like this:
>=20
>   CMake Error at CMakeLists.txt:132 (string):
>     string sub-command REPLACE requires at least four arguments.
>   Call Stack (most recent call first):
>     CMakeLists.txt:1037 (parse_makefile_for_scripts)
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: accommodate for UNIT_TEST_SOURCES
>    =20
>     This fix is needed to build Git using CMake in the wake of the recen=
t
>     migration of the reftable tests from being regression tests written =
in
>     Unix shell script to being unit tests in pure C.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1947%2=
Fdscho%2Freftable-vs-cmake-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1947/dsch=
o/reftable-vs-cmake-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1947
>=20
>  contrib/buildsystems/CMakeLists.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 25b495fa737..edb0fc04ad7 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1005,7 +1005,9 @@ parse_makefile_for_sources(clar-test_SOURCES ${CMA=
KE_SOURCE_DIR}/Makefile "CLAR_
>  list(TRANSFORM clar-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${C=
MAKE_SOURCE_DIR}/t/unit-tests/")
>  add_library(clar-test-lib STATIC ${clar-test_SOURCES})
> =20
> -parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
> +file(GLOB unit_test_PROGRAMS "${CMAKE_SOURCE_DIR}/t/unit-tests/t-*.c")
> +list(TRANSFORM unit_test_PROGRAMS REPLACE "${CMAKE_SOURCE_DIR}/" "")
> +list(TRANSFORM unit_test_PROGRAMS REPLACE ".c" "")
>  foreach(unit_test ${unit_test_PROGRAMS})
>  	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit=
_test}.c")
>  	target_link_libraries("${unit_test}" unit-test-lib clar-test-lib commo=
n-main)
>=20
> base-commit: 866e6a391f466baeeb98bc585845ea638322c04b
> --=20
> gitgitgadget
>=20
>=20
