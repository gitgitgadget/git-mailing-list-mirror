Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A83D96A
	for <git@vger.kernel.org>; Sat, 18 May 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716058706; cv=none; b=gvLGwQuCvOD2l/e64hGlq9/MIafIQ+oBPol3+xRjSwW4oWws+WVXjVXOI60CdAakzLorCbY5bwGHk8wVHfpthSD+gG9BhlnvihAZOOcFad7oCNx6H3EWTJKsIaMvAaQtbg8USDBVQ7uwV/J/lGFfYd1tCA5/3BrdTVsn+CvGbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716058706; c=relaxed/simple;
	bh=DppO9y6AI5fYCKPAlXTVD/t/wEyeIkBJQxPAam/PWt4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mdOcUCq2tXV9R/x2M0rDpH0DCbA/63WEhMHpphtxiFj/xMo678UGUDNe+Qa2H2aJftYDjAByT1pjK3LcXg2QeK+UDVJGqsxgKvUyXHqrzQlD4xlrfABwNmJguSqizBwSkZv/NBef8ReLarSLvB6RAck41nERwMklnqrg8IFfqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=t7obamDV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="t7obamDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716058698; x=1716663498;
	i=johannes.schindelin@gmx.de;
	bh=bsULHiWMbNMLivJtF86P/iuL/c5EYbc0Q4zSGv0Wojk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t7obamDVqZQj3ICxHSu8dVIZd/0cDso2Iq0R39FvIMzb+g2n000nBXUgGfoL18eZ
	 PY/YrwzOUegatD9d4sCUFPqXBOOFUEoinYejwzgqFs5fDlkv2Ola9jmZAfAI3P65a
	 51xZwTGbLlHd1gg2u/bV47cccldIfS1BW2nOSgSckmrf/ZZNYoQG28ikvjiLPmzvz
	 dOtbSPVBMfgunROGdAEsbpiHFlFXWZHBoRLs/rmzoesccVoLVml+QHu9CVDaEsRZ1
	 jWfsIjZaFPjW6pwZyvCfODGdvpT2jkXut38ZfTfedsScxEvzeZv1woc86Qe3t8pNl
	 NSQFNTck3vU78kRGMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1s7qlD45wE-003s1r; Sat, 18
 May 2024 20:58:18 +0200
Date: Sat, 18 May 2024 20:58:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 4/8] tests: verify that `clone -c core.hooksPath=/dev/null`
 works again
In-Reply-To: <xmqq4jawdlpa.fsf@gitster.g>
Message-ID: <89e16ab9-1ddc-d88f-41aa-c0c6eabe779c@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <7d5ef6db2a9c3c7a1b0ba78873d4202403768769.1715987756.git.gitgitgadget@gmail.com> <xmqq4jawdlpa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ePPv1odLsyiqmoyCZnP1v4SIlCwiNVgBZEYp8bKniRhUo12x7Fo
 jkk7NOYBOfPnkKoQEac2fGX5M5nTs6NkXnNss0NjJC3TEn/PKzBscI40pXyIWt/RxSyVX4g
 csnR9tHjfsPY0BOqLms9TEDmLguQQmJhxy3ssMDTjLFTd5W/rRW8jV4CtxRCvOeypkAU+fN
 2TIJN0ozOiaxgnKaJJxSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4/5h3ICOYKI=;klHoFTyq6ggCDYtWRLXNb10k09W
 vofW06xF27cQWMq0p3kZr3hxHP55RcPp2k8yx00t+6spPHdd74W715FVE+NtYRWvZHwX3dy+O
 6znMifXEKu7O0b3HGyQkZfPGxt53ABZ0E9RU2XyKBFuUAfaII6qhFmSQkD5O7U24TgfL+mbIQ
 kv8udYgfXtdlPNHwmvCNAT39SpQbrh/FQagfw5wZqgJpIVQse+v7hxHxM3idZsqn95HGvcKtZ
 SpF8RAkUcc6g5dwBe33fZNwyiwLXlfyVc37V2uT7Mh3XGOuMCy6E8HSxrVyqU1yzDNLbRGgMW
 dk8sE0rhGcj/HqD2RLxq3Cvm5KctwujPchGeHLsJKzwCAVpsyGh04G9ahDqPreaHVBsQUp9yg
 0Ln8Jj+N5P8XBwOxa614Qje3cSNPvSiYjulTaGkSpDVc3bfDkuZsv9QALi03RbSbScqL13SWY
 Wf40OESN3xk0JzVYsmDmVmzDpjcgetySI3MWmijK0RfeQzkKPqa3dDB5u1FwBDfHYuf3RXwY0
 b745F0l6MCLs7uXHzgQyDqyApAV+MRZV6/Az8VknEJFHyS+a+RIod48m4iYGOhsOt/du3SlWt
 Iu2WYMaBQTjnoXhKFGn0QUYFuMbyMfTwvcqpj2q+uG73sxCb0MF6xQFajLZd2v1PFF45z9bmj
 OB+L53jag8zRelrindY1fu4Lc0GzKHz0CsxQUORGehyrLsLdBpv/KPsYvdSva3N2KbNt0Pq6p
 6pobhHRuTHJhWMpuZ/HkLqwjkX+2ebxS9+80ygSQl5XCwZhVRDdEZithzQhV6jq0UEzTGH3dk
 jNYDjQ/On/BaZozH++h4BX/xA/HLSamhgTELlFcNJCO1c=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 17 May 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > What the added protection did not anticipate is that such a
> > repository-local `core.hooksPath` can not only be used to point to
> > maliciously-placed scripts in the current worktree, but also to
> > _prevent_ hooks from being called altogether.
> > ...
> > diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.=
sh
> > index f6dc83e2aab..1eae346a6e3 100755
> > --- a/t/t1350-config-hooks-path.sh
> > +++ b/t/t1350-config-hooks-path.sh
> > @@ -41,4 +41,8 @@ test_expect_success 'git rev-parse --git-path hooks'=
 '
> >  	test .git/custom-hooks/abc =3D "$(cat actual)"
> >  '
> >
> > +test_expect_success 'core.hooksPath=3D/dev/null' '
> > +	git clone -c core.hooksPath=3D/dev/null . no-templates
> > +'
>
> Is it sufficient that the command exits with 0?  I am wondering if
> we want to verify that the resulting repository looks like it
> should, e.g., with
>
>     v=3D$(git -C no-templates config --local --get core.hookspath) &&
>     test "$v" =3D /dev/null
>
> or something silly like that.

I've added that, but would like to stress that the regression was _not_
that the `core.hooksPath` setting was missing from the local config. I've
added it because the implied suggestion is valid that we'll want to ensure
that the test case passes for the _correct_ reason ;-)

Ciao,
Johannes
