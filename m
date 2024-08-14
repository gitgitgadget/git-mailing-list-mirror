Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672573A29F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660789; cv=none; b=cit4UXCdrSoJWUuxSNVciGHXO/W2acuUkI3hPVeC3HWoeKNbThRv+JL0sIvco6XC2W5LD2/YuswSTvNTSb4mKPkFIzPc8C3uxMXVQKTxXk286/jO0yh0i7Q0EnQDy+36Q+x1ZlmN8F2xTbKN09q+PSwWEkfPn0VGi81E06+Vwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660789; c=relaxed/simple;
	bh=8ReNk+9p/BZBvUoLIeD7HFxP0DYYBvinABwpU5lC/5E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DM5MIDgFpOVZdRSSIA0zHICnF5nuvworStQbjaVmTarWK0tT80lnLBDwBnwt7HT42b3Vtsu2QFFmpjcrTdurk4jNJKO5ZCeyG8fw1VDmwKvi3w/1BFptFD4TOLEctW08L1nIbyQb+psTeFB1CW4COhL4eYAmXgA5d2AbW+606e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ozzLicce; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ozzLicce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723660780; bh=8ReNk+9p/BZBvUoLIeD7HFxP0DYYBvinABwpU5lC/5E=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=ozzLicceuq043GghCYz5KYc8TTOLhkkrxtD4/N/Bmdm4D1R7eg85AUeCV9HUyJmzH5BbItAbNMjf3SfkGplJrXE4D1KmFWKo65yyX4wQuuUbdu0BXwkLgruSHUzyU3H2XGnYfuBv6DVJhbZE2b77QgQuWM8nvd7KcyEjlMk/5nMHI2F+nOW4l7j9mgwMBhTFt+oNS12ZCeypv8cyfMHRU0H18eHngMNml8z3TrmxIwNFcNqJSAD7ZTBSl/adnAT693pd+qOGMR75B0PRawgCXyNjL1PDsjLmR5/b6+gsn3tfBHDqAleoaqTpmExQdPFwFoGWL9oiKPZo3EDFmXsEzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723660780; bh=VXS2hcLucVMUMTIGOYIfSD8sf2B8H2YyNF2nHZE7n1C=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=GhpOk6FBAdJEoR8NPLEN6XgaYDkTU39dKMTYZFXQBb9fope/MeJ06DR9rVKzN1tFw0V2YlD0eF2aBvyqjlvVviUjOxj4ZSk4LzE3A+8QT/3B4P0bfVOiEqoo7pbdxDV7d96AyXhudx1/Z0zC+HrsEBt7XWDm/2YYa05uZQ6vHlAc6X/ttlvHpPa40MQu8RFVZ56GSk4D9Q1TjE1kNOhF/S9o+v/skkUNK6+ZAwNZ2QLM0ne5zrwGQz/rGbFckPXlD8antWvjRmSLKJMbMgv71kYIlp/wwGD7PttRs49fIPPe4rF2Wk505eqXq70S7bljKFh9vDp9P1R/Uepz57vkZA==
X-YMail-OSG: dVIr8VEVM1nKYQGuIVWwXb5xxQeu7d2I1ul0V0kx3rdMr7WTZ6InvD.LJGhkpjz
 ZRFMNtsb6ypQbDvM8.rutc6RWYLjhmvjIean9wdGhSJquHOAixxy04wgMRZB_zzPAxP5ScTAtqwt
 a39JnJrfRjddDQJPDdZ3VT_mOTE9SGyBaZXRdWGJGSMQI0gSKeMyWEj3pnkmfxc3i1TFnZVS29C4
 ZPk7rIdbQH2ngw6B7wOhTkl.4DeBfGEYZL2mUyCFGEp3is79DP1QRdCqxCHwHlnR1rJYKEcA8i_P
 KZvNSfePHSEUXAa63ajp6qgCnH9jCVaWCdAy9vY1O09dYiqQABS9XsrMlpJZNYFg8ogEm.p9BH.2
 Pim5S9xqhjgIKzeU8xmoM7RXdjBddqOavDK.uupIllP3eHAWI1ycXeR2CzYZokJXJAGbgyR.rahc
 DslsF9wrtfo0wn7s2AVjwCHyVXv9KAkFvUmIqUsFoXCS_BpkuH4Rck5GVvk5zQUCKxx.ukwPaWB1
 ItOLab_HCIVKySqlR.ggVGa.BzOtfUmiAY.1EzPyVwN6USYtflSS0nCcH6osFFwE0H9Q8M.irYYh
 VvDE6lx3gXhxJOZ_XA_Iy5HmRTJDEdhUI9B7DRSPUyqd5hpf4vbnaUKzN5HPKzNTtzBQjMnkeh6i
 qY6xEqk9nWCR7m4E9MHVQr97OP7axc8evJcGiBFaQKsC6OMCHEH1zY8YueQLUqdBPe6P6GgR92hm
 zB4QdQeKqtHIABwQFhZmiM0I57ebShnBc3El_Ti3jUIum8JVYhWrXycQvN2p3edgttYWEK9twqD.
 Oa2SvjQtovAG1WcEcIOBuJCsJJW0iX1LcxmIzb9evE10tRH1ouwGuuOmVRUZ5GEWYof57_W4delw
 bhkI3QmwKYi.xQJBLJ743vD652pMJMh9I8owj0djWLNpdTRGXxjygKTmrUv3fA7ZeFAzjPk4pjeL
 iuj71dgEn1eesJUYy.wZDA26tOh_XzUmSHr75jWfXBVkuxT5G2qbviXALDT644ntEuRrxf12zZtb
 fPJwe5gq0A4msTLvv69Y1zJ2Ayx0uVnggM3sd8BlFi96CBbkiI9erDl.beOP.dUPorOaoW2jfoox
 LuopglyeA5n.HBsU2Nc1PDZJtlmg5SJHXNM2ttN7RheS0zDvI8uOJuydqu85X1iHkXKSMjgqY_uY
 tb4PmNZpG4qw7O3UmZlmO7a009G222FoQ.2RDZmuSarkE0uYo0KMO0ntFTNEG.4Wqm4A91iyl87J
 akb.f7PC1SPdVcM1ats8dh75aeLBN4pObDOHI4d7geMKy6uBorxdXOPkcqULIksK3qLmwnMh95Y7
 okvrBeWLS9iI0fW48.lLy6Os2rJYgU5tppjHsPnCfQyb3HbUdCKmX0LdovngQBVVfKkkn07qSd61
 rLPcPMog7qOH.3qavHQnK1dA30c4NhlKNZy7ucTD9yv3hYxsaK3tRjWc6zE71Ep8Jr.1fm5By.a8
 d2JPl.UwZ4ozOFXMYLyKfTRL1lnvdZUbereyAv_9SQjljAnBRxwFnFnyeIPDLNvKhkigMr0rahhN
 IpzGxSyEGUfL79hBXp05vFJbLiIk_SGnAzHeC_Sc1EEHSb5p17r7aTO.r3oQom_AnlJseSEavyCM
 fLgdIxxOIiPqttZOJyCqlfk1.aBc2jSkAndn2e.3DTwAXffXsfHOmFapnwDzWdtFP8GMo_5ZDqwA
 _vtwoFe4c.HfeBqyd4c4WNNaSHGSRoUZy8zwOAFOGGBUV2CtK_9.3611JPxCCyMZyIADTFCXuAS7
 ssncGiJse.IUFnZQQtkNLQPNij2GBdlFRb2zLVaS5XLf5nnx_KgJPDGYN.bPau8mIZiFiFG6bVW3
 tUFJE51ualGHOi5v5bz3.zlhn4VbOyCsdJdVP3PznkFCuYLPM34ZkyuqAcunMna.jQkONcWN_stB
 sJtnlV5XC4Bo3WhZt3GLeJRpFkL35CM8pe3CzeH8rJHOEhysIAC7hJtUNcPYZT1ytxdJy3OXyPrA
 ByuKxsBFWgpIML_zPUzQ_JMtBEojKIp5AUtDO1sE8DMwvrUKCc2BYk45xXd3MXVAlx0BBkrVfHtG
 zsT44S0KgvX8chb7jlqkoaH2ZMUnrH_KaEAt6WY.maqCsYbfUZr3U7dmEa8O.oKOWx0In.dJ1NDI
 Rx7q2n9_qXKHWo7aKezJGteGUiJEvV4_Nu4Qun0.5ufnb1MeIuSGbWT5jxEXrFU6fHMWb_EwPOyK
 KlIYZTE0O1cmWEnSHyl4WZxj9Neh3OpCS02IAgmCa3rK0bKewxj0VBJTR02iXrg--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: bf3a4d67-f61c-4761-ad28-b251404b9dd7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 14 Aug 2024 18:39:40 +0000
Date: Wed, 14 Aug 2024 18:09:14 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <2007960310.4114358.1723658954502@mail.yahoo.com>
In-Reply-To: <xmqqy15rzwi5.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Tuesday, July 23, 2024 at 11:25:29 PM GMT+3, Junio C Hamano <gitster@pobox.com> wrote:
> > From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
> >
> > $'...' is new in POSIX (2024), and some shells support it in recent
> > versions, while others have had it for decades (bash, zsh, ksh93).
>
> I will not look at this series futher during the current development
> cycle that is about to conclude, but ...

Ping

Reminder: I'll update this part to not-use $'...' and without
fallback, but I'm currently waiting for comments on the other parts
as well before I update this patch.

- avih


