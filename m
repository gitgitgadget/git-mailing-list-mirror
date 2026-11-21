Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277056;
	b=XGT+YFUYPPzahHozBWZIRoUAjNUCbvQ31y6t0o7STFNu4vmlhFgDmCerS75xgm0EKuDs
	 Zi6bUjAOhnPVj6xoChtOt2y3wYuq9uhWkc8McW6pxD+x/r2imOR838tZ2JhiFsPvt7m1B
	 uRefUrFcJTi+XVzx1WS7r8TJa2rjnax8kwHRWwqbiD8N467Wq2zslzrhz4ZVvX5rVXIlC
	 H2910QS+iLWQszQlKaKmreczyX9K8DpN008bir3YM36ls4W1cj5jTGeBK2kx4cAksPuBX
	 sF53oBeH4vpBAA/BLPC5c2YeHOkZ3ByGWzEEWJqsbuLLG9RNH9kVDRa9Jhjw6be6+CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277056;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=wYYPddqLsxNscrc9jJsCaAixd2r9QPv/bWJhqBlS9p8=;
	b=zeO1PYKIGCziqyPxhE1RziDM7O0pHzBSyNZWZ2ZCsm6LWwGY7Fz8FKboH7rloPuM5RvU
	 piUr/KsHgpgSWOV/pSmM9R4flt6RfAqiu9EE/R/8Q2MKSK3fl/O2j+jRleBftvAj0FgXC
	 N5DfP130ajGsZbrLmmrt73eeRRA+nc6QO4zia5KYjt3FrNfwUKq2ONGhJS1b3IHo6SJDM
	 kzaFFsdFBoLaMYiecuTCAbAm3k9IDEXkRsSg3N2cdbZ6ZRl2HGYQn67D2c4mw8645xJAQ
	 ZtpcP374A82vTehcFe7AiYa+gAUUEXrkoCXlpilVTWJPpVyNTubA/fGr2/D9RxBQHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=s9S+RRkT;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF0606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41BF0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=s9S+RRkT
DKIM2-Signature:  i=1; m=1; t=1795277053;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:aTQrC9LkynwqEn6G7kv50oo+iAQr
   u4ZzwUXzYh/5+WTPDGdGeln/xyIowSs1Iw+3UAmcIaviwsRRLFJGeEM4xxQsnr9uVmoTKKrEjgw
   TtFBESacBxIijq4yv74D6fOUYd/Sc61vhIJ1whsLmmRArTXpX0eT4JKJvV0SXTFa4Wto+pj6VT3
   eV4CvBUNCzo7ubQIDX6/GEMXtE0zmuVBnCerLLZe5GZNonZxXLDgSOi0DqwuvdokdNWrqkTUiPJ
   yYJkIKttSc5pk74XRVmlhVHVAu9vzrxYQoEt1hmhbherep1u2wGRvdi9oQBeGs13iCNaeWS7lzb
   b7pi/qPyxTOVOA==;
Message-Instance:  m=1;
 h=sha256:
   C9+IFds7DHBTiAd+ApLYIrKAHa4WpnKICTx4QpRgMxE=:
   ogDkAbUFLLE0p81+uU2fS492oT4o8zdLKFaKSLnfUfw=,
  sha512:
   rfSKc41LWsz2xgs8PQ5tq8/Fij3yfL8S5We97/LL67rBI9TbVCfBfpsRrRP6QC0XFDFmE9jhXjHWmYqqXPQKgg==:
   1kl+HMwXjiPPft38k0r58LI6FVaHE4IR6WLrbmbK3bHoqS4VonzE+6eZ7LQVAZlV8jUcO83VU6X34+TXlPOHrw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795277051; x=1795881851;
	i=johannes.schindelin@gmx.de;
	bh=wYYPddqLsxNscrc9jJsCaAixd2r9QPv/bWJhqBlS9p8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s9S+RRkTK5clnINQKIKPEc5YZBa63fy1kgvN/C1uicUzL9pCN7Qpv18SeM2uFYDx
	 JlVM+Xl66Y1xk7WnacUfEUnMMWdDWpYczZxrt2c3Eo6NHRqHxO38WCOD9McQRrBMJ
	 DiiyOtKX4NV/ZXqeiICveomiE2GIIKjq1inZM9uvnCiMaB82NnMQKZph3lPZmEOA+
	 BZlSXSmaI2xPmCMg+/nFVICbX7g9kjnVDESqxCb4umqqo7Es0/WzXa+SR4d+pa8fV
	 m+QE+00k6GhurRaH6aVP1kX6jGf1vsE9FNDbJ8nAItgBZ3KcnhDf6kR1PzTbeAK73
	 1JbMI/OYGBrP097wGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1ySZ7Z35Fy-011gpt; Sat, 21
 Nov 2026 17:04:11 +0100
Date: Sat, 21 Nov 2026 17:04:10 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>, 
    Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH] lazyload: fix typo in comment
In-Reply-To: <pull.2497.git.git.1795275842564.gitgitgadget@gmail.com>
Message-ID: <97cb053a-07a2-c840-c8c6-d1455b282580@gmx.de>
References: <pull.2497.git.git.1795275842564.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:yLisQbPEMZARyBt0uDUhGlr74bmvsPFVQsSGKVIrd/i2eI1/7CG
 OL7EhrPc4ek2/aevDipUARXguYSeG/+9CSaWbSHd3S+D9PKJ1+ZwErr9dLWcsYs/p9fY7vw
 gtgXEmx7KTlHOgudFYE5tbPYZgcHg9x5dfBVF6XazuxPhOXQuSRqnwR3hrqY9qSZX6SIUPO
 IW5ws3+6ufj5QLWXySPog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fLB+UH8Yu1k=;r+D2gQu77ZoTFop/Z4CsyJY4kcK
 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
Content-Transfer-Encoding: quoted-printable

Hi Ophir,

On Sat, 21 Nov 2026, Ophir Bleicher via GitGitGadget wrote:

> From: Ophir Bleicher <ophirble@gmail.com>
>=20
> Fix a typo on line 11 of compat/win32/lazyload.h, inside a comment.
> That comment shows an example of function usage, without a closing
> parentheses:
>=20
> return error("Could not find CreateHardLinkW() function";
>=20
> There isn't any closing ')'.

Yes, this was incorrect, and your fix is much appreciated.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Johannes

>=20
> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>     lazyload: fix typo in comment
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-24=
97%2FOphirBleicher%2Ffix-typo-lazyload-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2497/=
OphirBleicher/fix-typo-lazyload-v1
> Pull-Request: https://github.com/git/git/pull/2497
>=20
>  compat/win32/lazyload.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
> index f2bb96c89c..d348a89f9b 100644
> --- a/compat/win32/lazyload.h
> +++ b/compat/win32/lazyload.h
> @@ -8,7 +8,7 @@
>   *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>   *
>   *   if (!INIT_PROC_ADDR(CreateHardLinkW))
> - *           return error("Could not find CreateHardLinkW() function";
> + *           return error("Could not find CreateHardLinkW() function");
>   *
>   *   if (!CreateHardLinkW(source, target, NULL))
>   *           return error("could not create hardlink from %S to %S",
>=20
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --=20
> gitgitgadget
>=20
>=20
