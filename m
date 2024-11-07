Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8108216E1E
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002181; cv=none; b=SZtGhIT8F6CuRd116pR6WR4DMCXt3vtXR0j5LdwuDqq/SBfjmsemKV9t8MtuC0hi/9DgUbumAWgrMNR0vQRjQkAQZppH7+LLO8GQpco7mq3KCJoNJMHwDuH90vLB/q+JxSCfQFjI/xizQJsZJkZynolfOFcAyhn2UfnZr8Z3yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002181; c=relaxed/simple;
	bh=ArqtA4cKzaUXeSkmFBG8ZLq1TJAxI8PdGibayo/sZwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ/OSja+s6JbKrJYU+rU9H0FxA+Kt+K1bOagiPb+VFYxpHApp2rpyUSbAS/LGqSdB89OQz+COdJVagj4ncjz5PkbdtY4tmeUsxGxgPIVAmrCZEn5l9jLrkwuOftX/Jh+onjAYBVDwJyNkrlhYkSk0Tf6emUcWLAepN/biu7bfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=g792wvmq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="g792wvmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731002167; x=1731606967; i=tboegi@web.de;
	bh=m+5IhBN5rI/YszylfonzOgUmP1O2hw3mZGhZzCvbfWc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g792wvmqLLpbgDEY2T0TlMnxCqPSvCgUh0TnJiuAe9g/0L8IzZ32SSV5D7DnLYQc
	 A71Eq8XhLJT9xCyYDu0Y7LcgcIBOLrM5wBny8thto2Pp9a7KAaQsUkc4G+dn70xaO
	 wqHwhTjhLbT2K7Lig6bcaZ1j6Ro382OFneOUuhg7yiHcfVpNPePBF8eD5/FKJPveZ
	 A1YPWgWxj8Vi0GnHD1kNEN/UBdfrnL2CpMSMT59jJYvC4/1su/2t9TyvoioXyTDz9
	 JthE4iuBaclJXjY6DQENwZweVe/sGQQiLXhXxPYSB5JSXtNhkKqDJ0T0RZBS5XXjG
	 wkd1rS2hOz835tyxGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1tgmWy1HgZ-00oqFr; Thu, 07
 Nov 2024 18:56:07 +0100
Date: Thu, 7 Nov 2024 18:56:06 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: only replace hstrerror if NO_IPV6.
Message-ID: <20241107175606.GA15130@tb-raspi4>
References: <436f1046-a997-4bd1-9d4e-17a429822c07@maxsi.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436f1046-a997-4bd1-9d4e-17a429822c07@maxsi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5pcjKxolKtV/CxyuXRDnsh8WvWRNV8dQhAJ5dVj5SmmaXTrQD1A
 hq7r3h8kfz1eTcHP4D68Zscl9eq9LgoYmYUEsD69RfxDcnDGpwUknUDAHPeXSt7gD+y+cEM
 qgg+H9n1d0Vi7xfOzkms1UwR4Dea44Yna2s9slxsdmXZXe+ed9McTF33vCAUE1t3uCGiGYN
 uYYcI+WnSj5BVI1edhM/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ySXSMtDDzgI=;ZqA/nf3y/X3ozi4RPF1ExyVfa+0
 m0pPwPkGr6Kg8q4pHqrSjMyzjbAVTqvT0o4A2UQRuTi+XSr2MMxGKR6vrBmGqArCvh5QMkkaf
 UVaZH/OZgWGWaqpuHoe6gcrBjpldN1IUfD4x/P4ThmjoAXoIQOEgc31+e/hDSD0TxCTEFgrHD
 pIqs45n9c4+CnvVPVJu3+hfvNIllHt8kS/PqiYBnsnYBy6RvBufdcLsMOwR+YttFVakrfLha3
 iWdlyU/yNfc4KoMHXvrQxyfnpXvUL1MX+I9CEbLaCZuiKNi5CYg7pwk76U2tq38SBh0RdBC6B
 4F2au1cdvFxZnGQf8G20ItXno5s6N2ahxH7faP6uTAuIwv5bNN7of6vVrGuOWSs3tlNahwo6s
 rTut7T1msUJeL8bWXdqGVMWCsBkMHBrGYh8rQR2v6SS2qrmK9ghxL/+wVEdZQLqxQ7CBjqWMP
 YYRLBbvkpVUWh4azBeNCCfeVKdoFLGoR8MOtJrwnntGD0mjG5g3V+V40wzhh3M8pXzQWfhlrT
 sB8YTkfrzkVsAPYosVmzb6f2r1Tf7gQnb5yIlArdgEtjZyunD4gd4eF7z5RHZdT/V8kf9mYqJ
 ujl4ejv9jxaajHEBn7Ki0VIQG58D8yPVZEzdcXeY17Q2nTxLI1Nh+1+KlYFydh/Q2SGnasxRJ
 iYZY6eBb+8H/9adUmHS+eAw9ro4xoFKXS1otBDWiaO6Xv91lEBBdrZxIHEVMcQGhoZSwH1Vky
 rephjYuzjXQjL0pcibS3Iuz4UjBMdCUFI800g7Y0gHLIZYcOVoQO0vUHf9DmOp6q8Glr97CWb
 rL245/uJK16K/eT8DbSndHY45vXGAY5Wv08GTPTtnPsKIUsTihjOl+FjmtkIOUmoLYdK5wBuy
 bEtwU0eOizF785ZjnFpodFcKI2OE08nwrpQldeO//9jWRtcnjmLnPJbwy
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:23:33AM +0100, Jonas 'Sortie' Termansen wrote:
> Modern POSIX-1.2024 systems might only have getaddrinfo(3) but not
> gethostbyname(3) (and hstrerror(3)). Git will only use getaddrinfo
> in this case and not hstrerror, but will still attempt to replace
> the missing hstrerror function, and the build fails due to the
> missing the error constants.
>
> This change declares githstrerror only if it is going to be used.
>
> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

Thanks for the heads up. Out of interest, is this a real system,
or a fix for future problems ?

After reading the commit message and doing some digging, things become mor=
e clear.

How about something more verbatim, does this makes sense:

Modern POSIX-1.2024 systems might only have getaddrinfo(3) but not
gethostbyname(3) (and hstrerror(3)). Git is then compiled to use
getaddrinfo() and not hstrerror().
However, the function githstrerror() is still compiled (but not used),
and even worse, the compilation fails due missing the error constants.

This change implemets githstrerror() only if it is going to be used,
for systems that have both NO_IPV6 and NO_HSTRERROR defined.


For a side question, please see below.

> ---
>  compat/hstrerror.c | 2 ++
>  git-compat-util.h  | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/compat/hstrerror.c b/compat/hstrerror.c
> index b85a2fa956..0a481d97dc 100644
> --- a/compat/hstrerror.c
> +++ b/compat/hstrerror.c
> @@ -2,6 +2,7 @@
>  #include <stdio.h>
>  #include <netdb.h>
>
> +#ifdef NO_IPV6

should we add
  #ifdef NO_HSTRERROR
here as well, to make things even more clear ?

>  const char *githstrerror(int err)
>  {
>  	static char buffer[48];
> @@ -19,3 +20,4 @@ const char *githstrerror(int err)
>  	snprintf(buffer, sizeof(buffer), "Name resolution error %d", err);
>  	return buffer;
>  }
> +#endif
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e4a306dd56..4a1072b9cf 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -930,10 +930,12 @@ uintmax_t gitstrtoumax(const char *, char **, int)=
;
>  intmax_t gitstrtoimax(const char *, char **, int);
>  #endif
>
> +#ifdef NO_IPV6
>  #ifdef NO_HSTRERROR
>  #define hstrerror githstrerror
>  const char *githstrerror(int herror);
>  #endif
> +#endif
>
>  #ifdef NO_MEMMEM
>  #define memmem gitmemmem
> --
> 2.45.2
>
>
