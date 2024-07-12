Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E01BDE6
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817203; cv=none; b=XEPvpkQUyKQe0H366/F0R675A/An6K/4zA9GRW43aDxD9rZuyiNxyZPaGD7nJO5yJLL4/B7UufeXksWYs+/MMrze7bpD2+6WqDC+K4YRQlHi6Pm0H/m+KISUPMb4UVku7D82VmyTq8vxoKUGs1ox+reVqbqVk9Wg+9dGCrzmPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817203; c=relaxed/simple;
	bh=brnK5SfD33TdjyUps2lRvzI+dZBu1+GcgGyJzY1F4KI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o1VLmeOiBcYq99DrZypUpr4UoAszKVcm2RSxG9fok4S37j1kAt1Ff0nK8epbYeAcWoVjd7qzxGEve2n1cm+Kyhi2cBjoJSWv3eLL3kVuwCUkbnGVpV9irSXwJFbKJlfBSitxbgzDFyazwiMCDTUPNGo0RhRiKH0J7bhYsz7U8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kLwwUNE8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kLwwUNE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720817198; x=1721421998;
	i=johannes.schindelin@gmx.de;
	bh=tsF36pcY3XOimsWFapzmjEtExI/6NCnuiiapteqAgwE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kLwwUNE8640jq8pGOMtsEvZrrdWaa9OfQWDCd2zBKNfpyYoyxZJCt/q+Dn50YgJL
	 /KI3k9D8NcUgLjNc9q4zsQvB13AXZm+asO3jXp54ko7Wh8B57DaBbnZlNp8qw4wH1
	 u/R9Fofq3+jzEsDIUkcd9gbNDq87Px6Pgsdf2mvmXiZmF7GAKxy5QzeCgO5IyCJk7
	 aTu+4QjNPokt70Ty2ncl9lD/uhRCnkCMNqchkf9bXnmdMpV1ByxOLT/OHgoB98w/0
	 c7IXd5o07HLLTP37un+y+RqYQcPToHCN6/bqr53MWx45t3Qux8Qh9wk5dd0ZrhmvI
	 H7iJkcWKOeQ8GGjXBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1rsCOn2TkN-00p7sC; Fri, 12
 Jul 2024 22:46:38 +0200
Date: Fri, 12 Jul 2024 22:46:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [PATCH] cmake: fix build of `t-oidtree`
In-Reply-To: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
Message-ID: <d6bb6432-b10b-a665-1dc0-1a4df4a6495c@gmx.de>
References: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UB0b1/h8IalGGSJJ+33H9JDlE0GfdZSJQyYSPW9e6yfaFiDXKx3
 ohIaJKDBNl7C6/bsIodzLJy7aZQXFlQl+81UlGAOmkfFdzKmS21yE6DhRaHMcXNfoQMczGb
 M/IHVoPauNcaMdYSQQKNf/ChxmbkvxE3+oJe2RYYJ+eWpFH3n1rfbChL2OBOla9r1wbQyM6
 hALYnodLVXvFcPhOAeh+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCnoush+hOE=;OOJppY/KUN6mYXCbR2earvVI/bt
 FtPB/VhML69O/E5goTSuTgQqeVsFB/nyOvQx3uFQg2n8qHR9Mu++9OwftrtV/rc2zCbCEadrG
 WdhLmbk4EbuPG/2F7+Adx8LnFlHlaSH12NyTw6ZLRV/+jV2yT7f+YUJmIGJhYlZkIyT8Rt+gk
 EC+WdbtZjMk2vWnCo1ta2ACiWNwYMOO7TMLFcd/lkWYlImaJTqEMRX+Qnk7+iLecP4W7cJdHn
 nl7RK7UL2JvjmGkQmP931sjf9WnkJjJwBbw/q9wdMDw+7tO9tUtd0uicEus2vf/qY2NFoQHtP
 Jb8c5h0SmGFX1WJ0xy4yDhbMKjYpTlcYOIRArvJU0XW4ppLl+BvxKXTYffaUcZ50gB/QVA0Dp
 RicRK5WvbZ6ByFfcrWJNZgoOSeOb1hCY7w7ZNIV5+MeaaNIGagGdWsFfZ5lWiFfP2MPf1x9VK
 /f0PjVKj4LIHuQJo8cniViOhApl5E6uTZ7QKB900jCPeUXRANDdgfWiatBLsSlMj+38WMqd2y
 aI1LL3EFOaErDpiK5hHTWDlO2mVkTiAJPElUkjPk4pawTsz/mlkrvYPqpA+HdZjY5EzT1/ekA
 0M/j4wcirunx19OZJjNl2Sbxmt8S0EdWXZJXAfaIf4CANT3fs2JaVpIRt4Ju9QnFQUIFSISDM
 SWV58+kWaiLDNuhFQL3RTikeK9LYUIgBKJNTAItk2hFoatokZSxlMVQNQ+scNsdozyLN6ZPA5
 4wmtXSu6g8Ux3vPUHdeDF8LreBvb56Jm3DYuWAVlrZvbFUOZxNlTg58zVMeqTX+iOA5DnnjwU
 psMKuV3/K+DFKsBPM9LUKLbhVsqh1d/P43Nn65+Jx/dGw=
Content-Transfer-Encoding: quoted-printable

Hi,

now Cc:ing Ghanshyam correctly. Sorry for that.

On Fri, 12 Jul 2024, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When the `oidtree` test helper was turned into a unit test, a new
> `lib-oid` source file was added as dependency. This was only done in the
> Makefile so far, but also needs to be done in the CMake definition.
>
> This is a companion of ed548408723d (t/: migrate helper/test-oidtree.c
> to unit-tests/t-oidtree.c, 2024-06-08).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: fix build of t-oidtree
>
>     This is based on the gt/unit-test-oidtree branch.
>
>     /cc "Ghanshyam Thakkar" shyamthakkar001@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1761%2=
Fdscho%2Fcmake-vs-t-oidtree-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1761/dsch=
o/cmake-vs-t-oidtree-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1761
>
>  contrib/buildsystems/CMakeLists.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 2f9c33585c6..832f46b316b 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -976,11 +976,12 @@ list(TRANSFORM test-reftable_SOURCES PREPEND "${CM=
AKE_SOURCE_DIR}/")
>
>  #unit-tests
>  add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-=
lib.c)
> +add_library(unit-test-lib-oid OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/l=
ib-oid.c)
>
>  parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
>  foreach(unit_test ${unit_test_PROGRAMS})
>  	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit=
_test}.c")
> -	target_link_libraries("${unit_test}" unit-test-lib common-main)
> +	target_link_libraries("${unit_test}" unit-test-lib unit-test-lib-oid c=
ommon-main)
>  	set_target_properties("${unit_test}"
>  		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/=
bin)
>  	if(MSVC)
>
> base-commit: ed548408723d6e969160279398cc47f88f5700bc
> --
> gitgitgadget
>
