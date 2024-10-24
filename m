Received: from sonic319-28.consmr.mail.bf2.yahoo.com (sonic319-28.consmr.mail.bf2.yahoo.com [74.6.131.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D821B6CFD
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773943; cv=none; b=B5HP1ZnS/Dm/RDQFnKtZTzp8F5PX26/MjhTN1gr4MeUdvQOskYtLY2RSh9iUvI5G11LEKNuJSKn5LuFRIr4/Kr0YlvNaSqjjpmNr3ZaVOE7ZkXl7EhzpLy/nrr2zp0wJtquHCJJnmoIQh9e6Smq2JjOFGh01kgyJO4EB6QRLQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773943; c=relaxed/simple;
	bh=CJ6hR4cZGLJBmb7anilSaSay3Y39fNmP9Fo6HA7UB/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aNKVZ3KFB+pkuBsLeXTUB/tXuYDuTiRxttHlAbXJRJk5CuV06Ys0xXliLcAU54nU+0ZlxCAdKoYUvw+X6NoQOHf51lM7F+r2vX8bdp/SWc1pl/hMmRlRNuYE7NOMxa1HugG8vIR5SBqWBdTt0Fcx6gzrwl8Jmynf2N9+4WD082c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aiNBKS3E; arc=none smtp.client-ip=74.6.131.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aiNBKS3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729773940; bh=CJ6hR4cZGLJBmb7anilSaSay3Y39fNmP9Fo6HA7UB/0=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=aiNBKS3EONPXJvCLwM40SgGQFj/r8xgWc7NxG7gR+7ckpoM5Rd4nHpPrf9yrCiYeNmVH5kzVVprSVTvjgUmI574zYNzeMixjXdhx2PL7asFSd5dfI/rbdJ0Jt04iYhgKt8uST8tzCbJY7xhd0u7rSFEWR14i02skGuCGimKpSwtqxMLv280qwSmN1AuRsw+8yrgqcjpEIOMZPUIAdfaSbRagOm+4OVuZCq2fZ0tGjMp6/IS/nSqN34wZWnAsBSMNBQ+Yu2AxGFZum8aoN1Rm4mzMzXrlVxQOcguHHdK2vZTn/9j0wWA5PnUnnhJVutZ8h9zu9xkSn1bWwCwfBIspJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729773940; bh=6FAsmXofL+kT4yWjXUVXM1pLsL938ATdtbUCB0todFK=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ByHMUHm7H14hiHn1S7nT61PrcPHeyeFB50fZt4Y21B1hEP4crYzQbdPNUJ/0JtQLjeQzOa/ncSzjQcrrsCwpFke97FuDO67iyrW0lpj7YJAsfO1nYkDXLTpZcu5qTxwiJbx+VN4srcEtHyaumesKWGjZki3EpbXx8SqXHa7k7oGQdxkQTs4o8PAVecstcEu+J9R/8eguY2sS50fs5llhTEP08kpvsQMcTxRvml0pWdeNXtYedtklZu07D1tVHuDfVH4AyUKub6Gsq3LVurB6t9CWycs4l5xFZmL/ZeUhcrk4ch/hfIOzmySWs4EILVS8XckdgJQPNlIjvADIzivivQ==
X-YMail-OSG: bczt98YVM1kOX96dS5Fi7xKRYQWZWVEXkH5oblqpLhGdC9TyveJmGWEDXNkhwNv
 8TmtQPvwf3xPHY3tDlF_oHQuYgN1ngKTJ_q683ogumBKbvyuA1qG2Axbvom9RtbX.n8tLb4hThfM
 Du153t2yUYzzULwjm6W6RNUb_dVb_cE4UmCtC6YL5e0Rg71eYxJwJj1xfW_1gG6_zrxHAp4zoaac
 q0OH12yW4HqbAY4lFAczvhpZgWRSfO0xbiARaxwQdOP.gOTWDymrnifultHbHph1NcBhhfRnMiXZ
 xSUSj07vlXT4hlZ66KBY5d2zmgEsKkxtBHd7dYpjmJq15HWXXpBg4V2wU9Dc2KQ6jfq29BzNB34Q
 JXtJtaR1Ri0JhpcxhFGbDJ_3P4EVuuiqxH5kDm9uWivjxi18bgYC5emYv.fz0hSsvh5C7_P8BLYs
 Ct8DzAS1OWikZJ7S.g34e9EvTp264u.68lvp8Nn623WLeSV6UasKdTiJGhZ2fHDR8UQ1w8EtKlHF
 QUh3gE3fAS1spZ5YLSBF0zy9jkcZnFarey8ksYPXu0tfn.eQXb209CYj6Drh9nBe5thshOd5p2fl
 f48W_rDs6WA_bPdngXYXI9DAb6bKn6XAQ27s2xnm39Tu1YOWxwQS6SFUJHIYBwRrVKq7Ivt2RZ4z
 Y_Sv_RNP41DR4PD_E7KTirApNypQLQNS8d.HaGPrYHZS3YFj7wJP4hi5G_BrN607A9OuUHwizRUs
 vwt5hKfcKqgFmmg_4vx3z9bO817eSc193bnR25PuBsRK8jwy4i9dMFkyTLpaQ304utKSpcz4qddC
 ajrDfcNmkEy1oLhyXIyDhqWmhQBSvGYRUvpLA23ILLAI3sHwQ1Hj6xHKQ0q78fRGwn_6amW2xiNe
 bj2y9h7DoLKXM6t94z0trnwQehsrdQy0b8etFcXcFhoEuspoxuEaarYtnr4VdEDbREMKHZYEulTR
 YehdRlqFaGfrAofdB2dyfcrJ7HXKVmGD01TgzQYpyKvFhE84KHzdVg7sMpfgbHfiVqGRfKOigurT
 TC6VkyG_0Gt4IUkE5IDmUukqnoqDNgtAm3BYGMu4EqgYOFvaHw7mOsPyHVugrekp_6jYpuWgZjwo
 vIv4AF6me1RBPdis0MybTHeeI4X06Tb0xKgBfmxYW7WfK2I4nCG3tM9uczgJk3yFEHZYkwZLkypI
 DeRI_RbdrxfR7SQPa9QC_pm9Ae4gr5At_pvImwHAXfUdbLQJ7mSCT2zhaBoGcxhYTVRLXHZYR2_.
 jPMr.sIG75ANi5.XLZygn4WNC3wkd_Snz34R.sWLsDScIRmS41W2s7mOhRnuC3fV8T_atzf6zWBV
 HKqDQgawBlzkjhzRr55VKL3ybCHnAjfpSfCocw7dToPkUFV._7OxyOK3GSwBxmplAHwM9TKO4qAT
 eimgZxFOY9_Ji5n_3j.rTd0PnPa4VaWjylxmjZPCn9SmOrO14sMmOOQJ7Mak29ykjR0f9Z5UL..h
 QzD5psaHlfvc65FNYeZzHBiFlgNfaz7gibwWfH5Dx.yUYM0qS98ZP_RtbTUGxKSfy1dkpSdogRWt
 h4AS04THe7ZU0z.OEaKeftJugU4_O4GAXQzpTbOt3w0Px73QcjKTFUh8E2Ecu18g.iq8rtazuHNc
 MBrwZGQk6kuUg34TwI0gGAU9TRgfJkved5moWmOy7wKwBPPO2loFbxqFkkmygaymZCY2EXPTkZZ5
 5j6WiPJuKg2JQO4s9s041GTaEyBHNbBwffyHP3hkFTeUdNKHmcRB1xp0AHkzRExigwGA63v2HMue
 c_b7iBvY7R8lt4UBMCh4sozoG4Oj.2bLp08HDLFFcsnqBQO0d4EJgfds0mochZcCO9cNdC0G8pbK
 GE7OH5G03hB7NSFl_XP2ml_fXZiKaJ3uV3yUyadeUWUhDnJwjX0jxc8O4cgMeNve6iRyRgX.OY3p
 w3f6viA.UWJnBZ.iv0PlABuPf3rAD3jilxxbvmS391JSkYgbz0zlbTcjXR3yCWJablppJZcw8NTY
 wVIxmeNmoBK.qmXUnUivu_WswtNcwfmeYBtJfQ3rvYlfj0fCYYAa21CpFNmkHXh3Y6ygqrIePI.8
 DiaxruOVw3JB3._hDu2ea4RiSJgFE8qKANY2L84rOxV9jP.0nIzWKSIDHJT3UW55.cYaeh1ofIOx
 iaKXKbDH2_lHWK8tzjrR4ow_IeGPtQILb4672t9Hy1PiqhNlW_ELLRMRLFM6h3g3GdMnGy.1r5Nw
 XncwgeppoOjgCQ.M0xjtu.YTqlg--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: c62f6e53-9d3f-4f99-9905-c4e54501a1b3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic319.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2024 12:45:40 +0000
Date: Thu, 24 Oct 2024 12:35:28 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <936191304.3152890.1729773328893@mail.yahoo.com>
In-Reply-To: <1101848017.3146876.1729770380522@mail.yahoo.com>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu> <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu> <1101848017.3146876.1729770380522@mail.yahoo.com>
Subject: Re: bash prompt evaporates in subdirectories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22806 YMailNorrin

 On Thursday, October 24, 2024 at 02:46:21 PM GMT+3, avih <avihpit@yahoo.co=
m> wrote:
> ...
>
> I tried the following:
>
> ...
>
> 2. In a terminal (default shell is bash 5.2.37(1)):
>=C2=A0=C2=A0=C2=A0 sudo zypper install git=C2=A0 # 2.47.0-1.1
>=C2=A0=C2=A0=C2=A0 sudo zypper install bash-git-prompt
>
> 3. The above does NOT install git-prompt.sh which is maintained
>=C2=A0=C2=A0=C2=A0 together with git at the contrib dir. In its README.md:
>=C2=A0=C2=A0=C2=A0 ...
>
> 4.=C2=A0 Download git-prompt.sh from the git contrib dir:
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curl -o ~/git-prompt.sh https://raw.g=
ithubusercontent.com/git/git/refs/tags/v2.47.0/contrib/completion/git-promp=
t.sh
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chmod +x ~/git-prompt.sh

> 5. Add the following lines at the end of ~/.bashrc :
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . ~/git-prompt.sh
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PS1=3D'\w$(__git_ps1)\n\$ '

Actually, "sudo zypper install git" does install the correct script
at /usr/share/bash-completion/completions/git-prompt.sh

Additionally, that "git" package adds /etc/bash-completion.d/git-prompt
which does source this script automatically on shell startup, therefore
step 4 (the curl thing) is not required, and git-prompt.sh is already
loaded automatically, and so only one line instead of two should be
added to ~/.bashrc (as a minimal example):

=C2=A0 PS1=3D'\w$(__git_ps1)\n\$ '

The rest is the same. Still can't reproduce it with this script.

avih
