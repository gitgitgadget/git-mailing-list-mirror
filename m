Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6A32862D
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315466; cv=none; b=hUcRuR3uft+sUXrn20G1iEHPNAM7zhGTl2EhQ2JDZ1amIZ0k74XNA1fEM2V2jLqHYyMVyVj7fvYmxJxq1gm9CeMJDUOpvAxU9rqe5T0Y4Ew/yuv1Iak+z8jtc1heruRKAHg49h1KaaK3+Use4JcDwBCZy/C0mWVusqGxP/bk9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315466; c=relaxed/simple;
	bh=HCFwjI/5hQfSuCItoy0+L4rSDj+CPXY0YtrOPLI9x5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdaR9ha7SdyGORkZjfHMC1ctKKhWtkUX+ASNZxHc9y/SZzydXRFDps7W8XscuruqRzCKTrtuz+KMRT4snHiYIaEGX6/JusxyKDkrft/zKNj9MWaMLvLTjnRpcV9G8zzyy/DHv7es2xTbt0P2JclHw/PWX1f0Z3Qm+nrONZR4cAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=SNLsjh6B; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="SNLsjh6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765315461; x=1765920261; i=tboegi@web.de;
	bh=KIhhOUv+r+906w1oq4gHpZYgAu9Km3x4smlMavAyMKo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SNLsjh6BzdkyAV551qkMYXFLadScDlbXl+PiNuNjhFIoBSfHGRlyPUJEqgc17PyB
	 bUTJLmy8taZiksGNaM5Ik7RxspRry1rHdfZ0qWixSQ3G/BrZsmdNmT5CuEcT/4rUk
	 lrkuF+wG7XRlDLhOqpKe7cg5JsqCFdVmIno4OLAbGpw2Hxnm32gAkL2DybzXoT7bB
	 Ua4lkLZA4fEosdjZYAcgFQYh66KhogYEu4UYuDynWevjSf7ONP9wtGA5m96QORbM0
	 +t6gZraOXk6Kg7eunnDYkqGeeu1u4h7TVyupZHNpgsIzJDJvuEmJcuRE25DgVO41f
	 Wv037+W6TJXVB8yYoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1vHpKd3q6B-000dyt; Tue, 09
 Dec 2025 22:24:20 +0100
Date: Tue, 9 Dec 2025 22:24:20 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: t3900 failure on macOS, iconv(3) broken?
Message-ID: <20251209212420.GA10149@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <20251209163356.GA5762@tb-raspi4>
 <51dc4ca7-61fd-42f7-8e72-a516a870e011@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <51dc4ca7-61fd-42f7-8e72-a516a870e011@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5c3eCTlJERLEwVpS5qGzHHbbd/CqwDjrX1uLPswUdGfBjF0b7Y9
 uZ3j74QQ/R4FzpEsG7cgf0mKHfFN6eiT1KVtdJWCWnJlg4SA7ulFNhOb3mzIECap5+4svX4
 azPo/+cfFbL8s0Iy3XRJaJZcCCNyySkpyl1ejN5Hme+ZitFwA+n9yz5DzvIB5wLwqACty4N
 ExIX25RN0Vk7T6HfOvzrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:roJqMTElA1M=;fKZe0OvyMNM7Chxu5V3UPqL2Un/
 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
 tsHTHbbENVxEz4iAza9Jwca5XqvDLrxGmfyAk0

On Tue, Dec 09, 2025 at 08:35:23PM +0100, Ren=E9 Scharfe wrote:
> On 12/9/25 5:33 PM, Torsten B=F6gershausen wrote:
> > On Mon, Dec 08, 2025 at 11:59:11PM +0100, Ren=E9 Scharfe wrote:
> >>
[snip]
>=20
> This forgets to reset outsz and the converter state.  With this patch
> t0028-working-tree-encoding.sh seems to get stuck in an endless loop.

Thanks for testing.
I did another test here
(increase the outbuffer with only one byte per round, old MacOs)
and yes, we need to reset iconv.
Back to your patch. I think it is good to go further,
with one or 2 remarks, see TB
=20
			out =3D xrealloc(out, outalloc);
			// TB: move into else outpos =3D out + sofar;
			// TB: move into else outsz =3D outalloc - sofar - 1;
// TB: We have seen different breakages of apple iconv. Should we run the =
same code
// on all versions of MacOs to be more future proof ?
// and do we need a Makefile knob, if one, and only one platform is affect=
ed ?
// I don't know
#ifdef __APPLE__
or
#ifdef ICONV_BREAKS
			/*
			 * If iconv(3) messes up piecemeal conversions
			 * then restore the original pointers, sizes,
			 * and converter state, then retry converting
			 * the full string using the reallocated buffer.
			 */
			insz +=3D (char *)cp - in;    /* TB stumbled here: "in" is "const char =
*"
			                              And I didn't like the fact that insz is d=
estroyed
						      and needs to be restored. That is why I had a originsz
						      (or szinorig ?)
			cp =3D (iconv_ibp)in;
			outpos =3D out + bom_len;
			outsz =3D outalloc - bom_len - 1;
			iconv(conv, NULL, NULL, NULL, NULL);
#else
			outpos =3D out + sofar;
			outsz =3D outalloc - sofar - 1;
#endif
