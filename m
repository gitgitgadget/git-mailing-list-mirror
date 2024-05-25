Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396733D0
	for <git@vger.kernel.org>; Sat, 25 May 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667297; cv=none; b=ryttHRGbzlsvMEn4ko2HorFSXSd/mU9sozLyQWmElpGsvlQNlaOXIIAD2DblIfPRohB9bB2siwTcitoNzzHTATDd+2QLviS9aaK/+LIVrKCMsz7Jy66v4wj62Vl0z5dCpGRcfwSlS3kXZy4V8lv4rI10y18q5MFu2sSCHFsiUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667297; c=relaxed/simple;
	bh=bCeUF4IWw4hDl7dyu7Ir6erkG0fSpSwOghrU8/u6O5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq3FyiS5GNgWUfSvmJuxrZskl/RgSf9bQ+WvZqfKLEnqWuAfZZRssCFflMsgIx3lw+csccglAftjrO8q1KmFG57EXCI6obdf5O/UpcRcp732Y9OyKHm283hnc4iXFrzQBb3X4qHXaQR9SR7fiExJ4IlrBuPb7ndXzy0a/MMU4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=OY/lSAeQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="OY/lSAeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716667275; x=1717272075; i=tboegi@web.de;
	bh=bCeUF4IWw4hDl7dyu7Ir6erkG0fSpSwOghrU8/u6O5U=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OY/lSAeQZQXTsUnSY0ogkjiBwDSY+q3BW6AXqmGAC+BQqDjl41x8HG8+B+X6DLDu
	 QmzWDT6sW9EwoRi70R6bDlFwZWCOJ4f72OEClNv3S60q02FoArrMgKh9RxE7/fTyn
	 wdK4awwpbL9VCDlHuNCFfqJAZrL6P7XY80moV21qfux/HMW2dVZyP9fCoCM/SZmk/
	 eeL6OzoLnkvJGyGYupxXNnLEG+Rv4Ybh61VcGm6gGN6yEbWUrkPBbi09AgtEN/yyH
	 QD1Lpho4xDoRBCuBImV/tYYWCqx4cGHTsVolyXeYdh+abmIg4l4gSC/760szzMQAY
	 Fej5oRTaZCIEiMKeNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgub-1sVf5Y1MhL-00v9iP; Sat, 25
 May 2024 22:01:15 +0200
Date: Sat, 25 May 2024 22:01:13 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is
 NFD
Message-ID: <20240525200113.GA14951@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240521141452.26210-1-tboegi@web.de>
 <xmqqttir9hr2.fsf@gitster.g>
 <20240521205749.GA8165@tb-raspi4>
 <xmqqa5ki95i1.fsf@gitster.g>
 <C5E35F2C-2423-4571-B737-411F4D4B13B5@kba.biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5E35F2C-2423-4571-B737-411F4D4B13B5@kba.biglobe.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ijtX/EdDNqWEaPhWVNVPVOuZNHjj9Aa6eBu9RuGBa2nDQU6nNzU
 6TY2xoiyFIUuz6eEzerF0Evqy8TYEAlMzAsEtw7UjYcfj3VElnkMKrYwxv2NCPYpF6P/3nu
 4Rl8M23Chm373LfClyzxB8b3CcS3E5l/jd2J1+zGNTLbB/h+3XBtNvAbJE21IA7m3ZLu8yj
 Ruu2K1zeWxyNaW4/ifhFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v4NGjktgtmY=;kVVMAVi1c73vrLH7cu5LYyIumgc
 PFHPciLF4IBxn3/Kpt+iYwyu5x6NoqeRRr8MBIuGeqJ+E5ViXr4IMKzK2jCA6DeGSnI8bpA0j
 E5Uv4/W0ShAj9lNuXHgMJRcm5QC52QIdum3H9aMBO83ne1emIOxcQauTibC7jrQ42bKbmSTw5
 V1dE/4irZKsyxkcKCFfaxqvwfbXXX5TTLlR8fU4TqYEbuvO2LxRLdkGVx80nNW/hRDJnWTcCn
 XwvTasonPrhtoLS6eUoC2x0ohJs2PYtmxSJcePETklDthcDVBDL9r1+u62LEijVUOuJQXrW2M
 eNhgYaxNhVGqb8xLmv6+jD2xXt3JfDizksywARszy0WkT+aGJ6p8zb5ainBmBD1tshR6axMo6
 DFcNN4CCAeUq3D6MOJkFu5au5xsOCNrmmX0gHPbM0xm1SrRCkNRDLvd/Bj1UzpDwAReoFEdbo
 o+PD0LuViVCoeLQ992E6D4tm4JdizESkxh8PbBTbc19fZVOPdxZAC75YdmQXke7pnG4JAgTrr
 qV3J5omwi2tBm+Yc1GEPEjRuzeBVZtFr9+HexBGPkbTL8JhsrnUavmcgRqhQDgfiuPx4OkZHY
 wmRMupqaTWXRVff1C28cNCBhmNIZkQ3scqDUi/Fa/h6MaEl7zu/Z3ql++wP596WnK7WBMWBzL
 KzLxB8RJ5qHdM5OpVHC/K2roA74btEa7YGSuWhPPMTZOxWGbK1ERVKx/yDZuxuwG3Bl1gDFKA
 T3RVs3BF5RsV7f5jGTlc3ypzwnEOCSciFbV/VTcvzPWtu5P+WbMu4uWUx83KC/2mrCEvMKVGe
 8N7bpm44D/2zTwSD1mGqk+dD5WW+AQtO9U+PejNz+Oo7A=
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:33:08AM +0900, Jun. T wrote:
>
> Unfortunately v3 still doesn't work.
> 'git ls-files NFD' works but 'git ls-files NFC' does not.
>
> I think it better to test both "ls-config NFD" and "ls-config NFC".
>
> The reason of the failure seems to be the same as v2, but
> I describe it here in more detail (or too detailed).

Thanks for testing - I was fully convinced that the new test case
did cover all problems - but proved to be wrong.

[snip the nice analyses]

> I don't know how to fix the problem, but I think it better to avoid
> calling precompose_{strbuf,string}_if_needed() before commondir
> is set to ".git" and .git/config is successfully read.
>
> Or reset the_repository->config->hash_initialized at some point?
>

I think that I may be able to offer a v4 patch, which has better test case=
s.
=46rom my understanding, the reading of the local/repo .git/config does
not work as we need it, since the .git/ directroy is determined after
the config has been read. And so it is never read.
Having said that, a patch relying on the global .gitconfig may still
be an improvement on it's own.
