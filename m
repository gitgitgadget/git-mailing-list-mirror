Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EA2FE367
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774023; cv=none; b=AtdK96+xZz477AunTvm9QdFz37CXra5f7whSZqu2uk7WXWX3Wk3sxNkQ4zNz+cE/xqPEjJrH7kM9zLSmKv981D2lpNeJNrpsSzzh6TVUuK1fuqwzS0I13L416XIAv7+C1X9UxJ1Qg0VCdnv7UHgQCMbbX97tXVFZ6FCKzN/oKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774023; c=relaxed/simple;
	bh=NvOvRPol++TW3O1IdIcQCEgqkcWWQP2hZG7xSQ3+MY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dE2zLUskEb6ZRW9JUIXYie4hWYiRNTMTQ1alK1YQcwkmbi3Fhwe58oRIzabdd8bnYEAjDYw7ZJXLplmWDAw4XZBD+wFxmD/R9WoqvAFZmNzaaR+/6t3V2szmdd37TIpBSkuu8+/LNQ3ZmDDyWOvpX/112JF+OqRKx4ThLDRFbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Hey9tTFW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Hey9tTFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752774018; x=1753378818;
	i=johannes.schindelin@gmx.de;
	bh=NvOvRPol++TW3O1IdIcQCEgqkcWWQP2hZG7xSQ3+MY8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hey9tTFWHP4rMX+E+m0Y1GeT18ZMr18xX5UFjdO8hMFVcJ7z5WUqOuB8uo4PMBPS
	 HDPxatf6iS4woJm1BnAzAZiB+Kk0INIReBYFTbYneqL4Gn3rhcxSAj3T+TSTxaWFH
	 1EF1gwPGrvthhs3eeTyuPK4g13sbrxmeXfCVzz6mQaxEF0pUgobseO43wgtzyGJD0
	 QcN6d7rF7X/5zVP+X0FQX5oKEP+MlhdJvNm0tfgpCZx/RmTf0OZ2YGmzOVGJkNOAf
	 Txhq93OfTOt7A6lcn/ZPDjQmgW1BWmKBBdzAq+9N5Ppp2XtkGgi6ith7uum1ds+47
	 hPWe9q2K+dixbe9qlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1ui6tC0FNc-0112aN; Thu, 17
 Jul 2025 19:40:18 +0200
Date: Thu, 17 Jul 2025 19:40:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Conti, Chris" <Chris.Conti@pega.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: symlink issue in 2.49.0.windows.1
In-Reply-To: <BN6PR13MB3091D0E52DBC0D6F60B6C95E9493A@BN6PR13MB3091.namprd13.prod.outlook.com>
Message-ID: <1904293c-bab8-4a1e-e8a5-045bdc13e754@gmx.de>
References: <BN6PR13MB3091D0E52DBC0D6F60B6C95E9493A@BN6PR13MB3091.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jB2IIPTUSCPHXiJDZontqivPSwKGhkbK/67iyW3msqJMc3yBw0w
 rOw9LxtQXCbJ9W4owV9CtXgNbhVlFbOiEvwrF8YeZ9cRosPJ6+DYtlFvh3fiDcctrLlb5mI
 GSTzi1dbx8OjFnC1zAZnUR1XBbEOc7K7zOdmn4d7jfhdabGOPqqYPV2fNAkZH3mw8vOwR7W
 tg4yTsRvczHloAFxIZ5PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:roReUPUJDKc=;85FjVKFxw5Hmgb0ybw4RYJTOyoY
 QnKGQo+rDRJYOrV4cwNWaEz8IO7E3EIVVogNI/i+bAz5PFsf4Fei8SuCFP25knx+eGP4VuhSE
 8z0r6y2IwAyyiVqmLpGzUofubcHxBU2nql8ZdwO+iKt5ZjsirfENBtlfcF9a5YVs4zh0nKZ0M
 Vh+WRWaIpfKs3FbhHpRPZtcQnrkgd0Bd3uAZBw3nLbnW+CDk1mLKOBnbHPNqUcYZjX+rP12SC
 wJ9NKz1/G9ogqQsd5OB05WWKD3kIEXKKdlYB2Zu3cyGNT0ZhHuATvayzGRB4Rrz2El9EaTScg
 fLoOmFs+CBq2hsOzahN2AGb0plBMG5q1dYklvdloKR38QcIQ7/9OIuSPAc7Km/Vahp0A8sE+P
 33udgFBa44P+mGpO0gmYwr9NdLFX1AGGMDrcfTuUHu3iVu/tyj6KBgXlnyr0+yWIwgaaTgED2
 B3YXuiStnRSKVBK+9eA/gPCxuvmsd8Br/cweIJ0sCyKsKyDoD9ei0JTapL1kU3xKmvcUy6Z0W
 K079+OC6boenNcRxXVL5R6e9JcsFdhc8aYvWqUGZ4Q3U1VTQ/xPn2qjo35D25bvv3vI9RF+YG
 05R50LaomyB5hBAYFGU2kz/gjs+XT53xPFit6+lo1B/wDkZ6UMqVx3plAjzaM1csjcoIYJ4e5
 ipLZPjBVFmzyDodl1uxdNmaFRTA6aVaFxliCYNg3emfWrtRA/tEW8QtkiKr8Xz3vfq2fRIuC7
 64i5nL0wyPDYHu/oCYFYi3U/6UbbQSAksw5acSunHiYTJhmyDZoMjE+97tpnf5xv3Y0Ryxumx
 TffHHaopnCqg+uzbJuCrCaOorjLqhP8HK3jrbO2bB3l5N5zmODXKQZQiU2ZSqQf9R31F3xemH
 4v7c23djFc+wwEuk9NvifZ8Zly4yevc+dJrwS8Duf9wjjHtaO20dCfolaQZWKmkMKq0FfH4Ef
 rjXtrxcmIJ0piuype7+FhFiw79yFvJvGhfmgfFXts7+DS9CnhQO6S6tJVStEkxKFFCiz9vxig
 6setRxpJZ+lTp2ZUMX9osQqSYmnF4uGtko7nYJt8FuR0ZCYwL1v7dt3a1BIKDBnGvFKcvAxqL
 yCG7GGE9r+mDJIcpUK+YHm4CXKlm/5fv1PYg7e3mZZdkqjU188k85kwY+Dfi6SwxzUazN/39C
 vJA7zTZGHXO1FDY+7mLzUsAGHjUgEn6qjrPRKmAmP3kOd+G76bp7qEldVBsghaYCXHuB4tSTt
 Kbi4K/dIdc1yGuNjUsJPsQW8DbpyRInlHhHcDO3pPVL8KLFd3QBk2QF3OSIixwcireuf5/Q9s
 CvWithPUGD3dijmar0TOBMFFyYmk7quoC7VaS+GwASFScUnM4SrtjWOlY61IjXscwPuwUjgI4
 IIxuPicjjfDEMXepCfhkik/qcHcYDjtH0pXPsJpGzuOqwjCpAEjyVzcfOdq7uw3c2uXrmzvZO
 18FG50nMxxWkaHpV0C2w+striBFjptfx9PY7cfR2nCHLVXiEVa359DywDcr/XVUIrp6HtGCq9
 7DESRVHuf87f5BHntWtJYXktw3MQnlgJL+2T0nHO9t1+zJkFvievSgwuhszYDJ3hSz6ZOSZ7w
 JAdcg7F0w0rCyr+Pg96/BGPl/RpnY9S5fco3hB8WL8NZvIec3uerYPG81IthB01vvnq7E2VBH
 W4WBncuH6lbUSCE3b69tqhqEcqst19jrTmlazICuKIreTSR1dFfefY8AMZW0pGcTIq9juCW6l
 62nlKwk5GQObcSZJIhJqXLagj5Ef6E1j3iX4eJA5Wl6NqsAsae2gpkxVhSo/vUittQXHSyVHR
 rpefz765zpcowhjL/VKJN4s+8MaxWPTdLaY0r85ScF0WWcvipatXTDI/Pd4zom2Ylo4YT1GGj
 r4yrqEYCah0Khz5bEL8Z0Oi30ubQqadDFRfK1wZcl1VpFfxsP0MDoZRN9KJ+rpYYab5r2hJ4+
 Iwxjx+8HojPHhy05Ps2OHaKAuRVAhFNnja/tCF82XNgqtbIoN1wDGMkWRuDjoziDwz8Dt1+bM
 msFEyIXox3yPUO2mhFP+u2y1CyUdT1s0rTKj/6F54hZWwIprmL79HrtlkrSlAYkpj6KfvbRoY
 ygHxMI5CCEdzSdZBV39OkG+gsZjVLipcp4irzscil1DFv5K/OFtLL5hIQwTM8Qeo+21umyqCv
 5+eHvuT64xt0rk1XiFcSflESR5J+gU0rzNzR7zzKOcIqPhMucvhPTfx4QNAv5oxp6xL6iItNr
 0xAdq5h7gI77g8IpXXlEaH2XIGWiVelx+NlFFp7NdazLAJ5NaclXiPmLyTx9P4bSSoi7+fcUC
 hxdg8PdDhVwCKx3CJJHU9uCZQ2nJ1yXEAAMKopZwdsRX+laIIg2ToCwDw+dZwzpBC7H2+3gQb
 TXlKliOBBMXD1HxgorwD8hfUmYD5FvPaws6tiwMssS/zpMnoyvIYkki3lSs8XqBbt8uiwYteC
 i8nELkFC6DtR8QUdirfo4eRAEg1au9/UIsvzMWDtnTdjrGjH505v0rpcnbYhD/N2mzCGP+lbz
 PSm5It0zYYZLa3ILiv5RkuQEtLIRTeln5IcS3tGNn/Pu78WVQ4vp10yb6cyxAEHKIB+quiehn
 p+y9WwF08dDtOS9z8LPc7D08W3Ip+1FGEyeia7IC4BoSsZAxX4R5c0QXm7s6JxzbdvXTqkI4z
 nL1MTlmTQEWy9tFp1U+/H+TZpsPJ2OgwA7ikXWo1aLfN7ZsIEgX5K5rnMRSmImaGLnHxXbO1o
 koYMlvctAlj2okxe4Gav04drKcxqMO/HSJ8nt/xIctar4TRAATVGm30h27D0zubOl1adNpUij
 3L5Rl7Sm0gKijlYtDH8Ar9OELFbsYNDHazuv8/PRnLT7+pOAlt/XALRu0LmVEswO4QqhCaL24
 +o8k+54RxoQs+sP+v2nBToQc+cyTiVUObWLfJSXPb3riJG20jSjnjxr55fV93uRsC+CRR4hhx
 WHExcHGgo0UgX2v6b5A4xwglgzh5NPwcubIE1Ri5jCjbMVWT/C03y8Ft79cxep9kAonG8VRJR
 mdDnlxF0asgGDqxO8o9Yek78/ImDAmTqiILW+g8HxQI4vdsjJzPj6ABlro4ZGlmwCPzntnUZ6
 c0h4oFi0s7IW0zt8BAGNgRVg5WZ4rxz36+fp6l8SpmaaPwlokjk5bvNaLxCe1cVmsvNL3ScZl
 U1xs1PYlWBMzxpJthklCAW0o2P1VjsH2y+jTn8qONuzqFKN1BcHWSAe44LdUmy4f3w9yttnxy
 dBT2zEqmdY9wrvpoKTm3t4JLmiZ9OsjPQkdSfX3Bi+r5CIwmKag5EOnBuEVGoMuy764LN26ga
 aF/PCrY/29TTLqpA+0B4u6gnet7UL82CW3+q+OCmof0psYYv8EWPC22xvRLlvAg00TH0ayZh3
 jXJMfo+dVLSRhqtjfcpkP+ySkAzLteVOwhr4NjYg4E8fkWL7j+oxCYghBUe7njKzduWsXvqlO
 6P/vDpcifTKtCfLmtEoVcs90QrRUgsCJkVIvO9I0zDppJ3YewJsZ+evI5VAvhVDKWaekb1GAF
 VSyUfeojepN31GbLyULrLj1U3S3HmiGrFCKKe5fFli7min3L6LKPz5AjZgqK0+x+/FnUvZVqQ
 aNjuqMaiAfKaLZm7Wd9N5WScvPEqFz08U0mEMt5gU877kUkidmdrpuyvw==
Content-Transfer-Encoding: quoted-printable

hi Chris,

On Fri, 16 May 2025, Conti, Chris wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I have an alias that enables core.symlinks from the command line:
>=20
> relevant lines from my system gitconfig:
> core.symlinks=3Dfalse

Is this also the value `git config get --show-origin core.symlinks`
reports?

>=20
> relevant lines from my user .gitconfig:
> difftool.bc4diredit.cmd=3D"c:/Program Files/Beyond Compare 4/BCompare.ex=
e" -lro -expandall -solo "$LOCAL" "$REMOTE"
> alias.diffdirsym=3D-c core.symlinks=3Dtrue difftool --dir-diff --tool=3D=
bc4diredit --no-prompt
>=20
> execution (in a repo with a changed file)
> git diffdirsym
>=20
> execution environment
> elevated powershell 5.1 shell
>=20
> What did you expect to happen? (Expected behavior)
>=20
> for the command to work
>=20
> What happened instead? (Actual behavior)
>=20
> received a "Function not implemented" error:
> error: could not symlink '<redacted physical path to changed file>' to '=
C:\Users\contc\AppData\Local\Temp/git-difftool.a49272/right/<redacted rela=
tive path to copy of changed file>': Function not implemented

This looks very similar to the report in
https://github.com/git-for-windows/git/issues/5517 (which I am constantly
running out of time to help with, maybe you can?).

The culprit identified in this ticket is 8241ae63d821 (difftool: eliminate
use of global variables, 2025-02-05) which seems to have flipped the
default of `--symlinks` inadvertently (as far as Windows is concerned,
that is).

Ciao,
Johannes

>=20
> What's different between what you expected and what actually happened?
>=20
> Anything else you want to add:
>=20
> verified the alias works in 2.48.1.windows.1
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.49.0.windows.1
> cpu: x86_64
> built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.2.4 11 Feb 2025
> zlib: 1.3.1
> uname: Windows 10.0 19045
> compiler info: gnuc: 14.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>=20
>=20
> [Enabled Hooks]
>=20
> Chris Conti
> Email: chris.conti@pega.com | pega.com
>=20
>=20
>=20
