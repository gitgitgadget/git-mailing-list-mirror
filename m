Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB797B3F4
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645138; cv=none; b=Xc2oDlm8IhwZET4+Y1FbZG33Pqw2XlB4WhWH24AH4nGtsHYbkHb3Ot5MFYtOP4XQwt0eTeo1QHM+0Y/dFT9gC8C72mcGiJJulFqkRKVimKk6xuY5Z7ud0U4RE3pl8icQtsewvR/Ly/fVToQSJ4HZBCxX/02KABMi1R3cF2DHQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645138; c=relaxed/simple;
	bh=zQCkfdys6nwrrxs8yIKHDICQ8vIRfutReZlOgJgVgE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mmzhYgoHEQ94N2RrTQV+QLlO+9ZtJQC2IsDKU7ghu0sfIrQrFC7TJ1JcilKM1LIipSQn+bl8ugtE+gkp8/O88uHKwwswr9twr0Moku9OUVgPaQRE0fgtRyqxFt45YTaW5gM10rPRMPRUwgI3PnCnYJinbKEnl8anv0DVwE5eEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XcvcmLRK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XcvcmLRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706645131; x=1707249931; i=johannes.schindelin@gmx.de;
	bh=zQCkfdys6nwrrxs8yIKHDICQ8vIRfutReZlOgJgVgE0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=XcvcmLRKJqkD94jV/rfF57Hrxn8+AXJdnvCwMEY2B9lmAwyTYm/yhTTIeQY27Zf7
	 ZBEjjTwNxyIalzekma59uN04bF57fzbCmPUg66+EIZWfac2SO3ikyab5JgQuuRAo/
	 HpBucRqnKXrdDB2PFR7JDXf/beMvHMooKhxHxrAjfMqCDwBOZErfObKiefPziymSL
	 qwz3Xax5qhnl9V1fky4fqI27PNgBAKH7Qm4Xm84RpDxpDxQVuZuqoe2f9G1HUy2tI
	 RcHtWsG2SawrpA5XnoDq6SjQADAwnRnxaWe++V+Y4G1/eWjMEuvzhTuWbSqnA2TtP
	 Y4/w0XAoqVq6Nvb7Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1qkcK33Lh3-00kfYL; Tue, 30
 Jan 2024 21:05:30 +0100
Date: Tue, 30 Jan 2024 21:05:29 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
In-Reply-To: <xmqqplxoozh9.fsf@gitster.g>
Message-ID: <71c5d2cb-46fb-b6f5-7180-d7b769dcc686@gmx.de>
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com> <xmqqplxoozh9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PTEttK54/z0pARRBTHITZoAkIsP4meqh0ONpx/oBJFpUPfGYOD8
 81+tfLN6OryvZdp62qUacKeHm9nHd+kDHp9o6Ho9vywUW/AvJb9uzVy+nnrmacYz8aekcOT
 XyoDXl8Sxt5lI1fP8KKv73KgdwgK6j0RbFZSOMFBDGZB5kquE4uUCla3XO7GGYkpUlp6cJd
 1zNZKBzcAwMJDFIhoVChA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KziMDSw0A1Q=;yfaf6oh+46fqkZUE7uCXBex5HDT
 VIlfGtWPhDHKc/juOQfpg/SEB2c8doqZ12jSW52WHeC6umb1Yc230QeUdivezn9RLV7YPI3YS
 70cpOceoltefVoHl7K957ARlyvAg8ItjtCJkHaF0mBLkYmoIwly24r6HpF3qH3/7Jz0YWIUGx
 GLwZF2N+iCsHrM2ff88NPCZRq1djDq5AdWS5gGMc+/PDQU3v/mmpHNsFpTccnGMH7yMOz/QdN
 I7YsWTGirzLs3nc45NRx1GsWY8cK+/R5Zq1OADNeegsEGYXqUEHELlxVJQ7g9YESpYN+O4Oqr
 3SEkRorU27QOYT+X5a3Ub0/WVFt0FcT7HbsKRCQjq7XJZlFIyuFaOvf8elFB9YxAo/Pj6RTXK
 zE17ZUFjXu4E7h1r9psbksbH3g4XVjwIlav7IlLSrfbmtW8dSqERYBN+zNl/26ik5eZrBtWQa
 dIVDvq8PcUrPrLmAINmdQTaDnbUbErYPYMDAuSalF/EA8eS2OkrDUQFiV41rpTgvb7UbnvgDi
 ZidoC1DQ33VneCROojxqVEa7iM35k/Yje/A6ycje6TsoncVoMy9eq4+AEhWKJM31VXRNZ6hk5
 O8pBSJir1+k4t/PAAdPj0qdiNuabvPBJ8PFUA+FjmP1zsN4AjmZosvJVRZ/K92ZWMhW/YpjI6
 HCZ+nE9NdsRmt26jrznnNI0N4Pdy5+8fSCbf5q2i0o0JIb/X38XHP9aCnGmDTlIwo0PS4nqvF
 KY1ZCmK/5UKaRECYnoyGkse4by9iVlvAETuLqPPARhFrYNC9D7KKOh9tZz5rlaE+jak5b0+wL
 1jFYKZ8L29IjpjmvGXe+pk6DXbPYiQvgQ8wEvhcTr7u6fsFnQK2Yye2cDt0hJLi8wbVqTjj7I
 Ckn8PP07CSfpuq/taLrRdwwBS4c/OtfsPFlXrVczYQg8WNOhv117ts0Zp6XfneA+UCvtDVJ1N
 1oBSOQ==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 26 Jan 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When specifying a merge base explicitly, there is actually no good
> > reason why the inputs need to be commits: that's only needed if the
> > merge base has to be deduced from the commit graph.
>
> yes, Yes, YES, YEAHHHHH!

:-D

> > diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-wri=
te-tree.sh
> > index 12ac4368736..71f21bb834f 100755
> > --- a/t/t4301-merge-tree-write-tree.sh
> > +++ b/t/t4301-merge-tree-write-tree.sh
> > @@ -945,4 +945,12 @@ test_expect_success 'check the input format when =
=2D-stdin is passed' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success '--merge-base with tree OIDs' '
> > +	git merge-tree --merge-base=3Dside1^ side1 side3 >tree &&
> > +	tree=3D$(cat tree) &&
> > +	git merge-tree --merge-base=3Dside1^^{tree} side1^{tree} side3^{tree=
} >tree2 &&
> > +	tree2=3D$(cat tree2) &&
> > +	test $tree =3D $tree2
> > +'
>
> You do not need $tree and $tree2 variables that would make it harder
> to diagnose a failure case when we break merge-tree.  You have tree
> and tree2 as files, and I think it is sufficient to do
>
> 	git merge-tree ... >result-from-commits &&
> 	git merge-tree ... >result-from-trees &&
> 	test_cmp result-from-commits result-from-trees

That's valuable feedback, thank you! As you saw, I changed it accordingly
in v2.

Ciao,
Johannes
