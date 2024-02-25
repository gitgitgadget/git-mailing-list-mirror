Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401617BAE
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708888809; cv=none; b=G3woUwY0z04/k9v+CHWk8lWFkoMP4uaAT/J6U0YT8OcjQX7Mm2wqocskrBDI0JmvmE2MU63l3kNuFrocUzZ9Fgtlkn5q+eI8Nweb1ikUXLphzwg0AAjhCyw58Lj0l0QSCjMKks0neTeNYfJ5SNi1Ki/8aguULssGhKQhP/kUy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708888809; c=relaxed/simple;
	bh=mZQqr1ra+7SExHTuPXvkTqOcYpvjL8l0x3fQ+ehV2tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMa8L+09dJRawkPMDRk0gclpz+tF06+K+3IWmV2Hj3q3eV5KNECxzrzbTF4ygfhvzWHHxoF8zZfLWVKkG6Zyki9gywng0OU3Y3ppKl2sGrQTJ9ja9bQzz7dhdm2OuH/UaQTJ10E2/k4JzownyrI4rO0Mi0TPSAaFB+V8nW6pP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=AXS4PTFP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="AXS4PTFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708888795; x=1709493595; i=tboegi@web.de;
	bh=mZQqr1ra+7SExHTuPXvkTqOcYpvjL8l0x3fQ+ehV2tc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=AXS4PTFPkpps2+4Hixok6nJn5zzRtvNOI0VncCMWHM5rzeXMw2OsuI4bDll4yyxy
	 fxP0DuBZlMOTHm/W5rnK/Uio6Cq3J6VReiuU2sbGWSTAD3x/w0vmw/Y3vv0Zcm3G/
	 0VqKyougNsW8GOP3AfvP8Gj1QA75wEqMFxIevNyEu1jpLz5NcLsHOHQGqrz2imVQp
	 BJay0vSILzR9hgX8Coklxiu0G/6O9jZcYNBXgpX1bfcxh6vqTgy+omQYRq17GNuuB
	 ROR6t2pHjyAJpu6YYE1Ypzmjej3FkseArqsX6u8NMtF5wD9x9Nb45zbzYXvNim4cf
	 0LjHkeNFlEaO9e47Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1quvf431On-012vrb; Sun, 25
 Feb 2024 20:19:55 +0100
Date: Sun, 25 Feb 2024 20:19:54 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Message-ID: <20240225191954.GA28646@tb-raspi4>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01be01da681e$0c349090$249db1b0$@nexbridge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:2+KT8B2bK7NY6Fx1gGS6hthhR1MdMiIUe5brRkJWcCdg9mFaJwp
 aixwHsOqkDNs7wxeKMacT3LrxqRA8ooSzZAFYVip/zy9MuzOSy43McCyZoYNOXzVG2XuKQz
 G2O/aUEaDjFwLV9DEm+I1ZRDg3da4/kXlwdTnPiXonyzCiJEde+5F6QGt3u5pmxEmjgJZDV
 yf4r5/bw3yiM6DC7lo8fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zGezTqFe4o0=;kEG4NXCkiLish4pASMGdWT+kTp9
 yTxNM70CvyV6NyT3GXdoIXgOcmtzVhsjd1Y2so37FqKMWJkxt2zsigecXkIQIT8kMeyoNckKf
 Uv194AH8NiMBL5h0bql3OAyUnglxkrgXps7iqPy5qICOzc9SATj+hDXbwq5Lj9btxYMsKbVMl
 FQLo5F7JrovWYsu32Ys6GzA+4gzyYjNqKFY0gZwfMa9HBsSf9U7lU7xIRazKDgc7HI0uU3wfr
 ijVUHvX4ypR/qQr3KPnhJHi/+shx9yyiiT+USPFZcwAcP7JqkNMusx2IxNPlKmN3VF9fV1pFH
 7ZwHxCqB+1MVe4WVMVbcmQ9bKk0qqSo6piqv5OwpeZtDFu7ddMN4obNSEZH71bC3ooJk3ihye
 EK9YYlOE71xHSXvtLw1jfZkorfWN/jjLUUdz9bxmrqqORvc1C/Aa76rHhVESN3ctqjcbPTJkp
 4I6UuuBY6lHQ+hYsHLkbxDKVyrN5QKBWAAgcu/km/vvjcyFrBs8QKHzLytS3+9iUh9YtAB3Mg
 VnpBu2JZRgJGGNeWl9Ro8sPql14wY+boEqKzwuUdazO+pb4LvWAhaueLskGbXg6ExlQ43VlpJ
 ZEHNkip5BUWICcLP7jypZEjagv0MumJdhz0fbvmema6BoVC2yVb/eI1X7vHUFrltrklNFFECA
 k+SFZo20EEu1wxdD7MAXuWbpE6DwG2wA0QT3NRL/TlD+m0BEfi5RqCwNb6lQMs8wYYNlm8kcY
 p+AcbcVrL+z9QHYlN4uLOLEZJ6Dw/H0CnnsR3lJ3Aj0CfyFeXSXlPzrI7J9B0nUbSWIuBnSz3
 M0rnUPG/2fRc4vYQXN2jL943lif+QhAA7yXlUw6wJS3HQ=
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com wrote:
> On Sunday, February 25, 2024 1:45 PM, I wrote:
> >To: git@vger.kernel.org
> >Subject: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
> >
> >This appears to be a new issue introduced at 2.44.0. It only occurs on
> NonStop ia64
> >1..9
[snip]
>
> I did find the following calls to write(), one of which might be involve=
d.
> write() should not be used directly unless the count is clearly very sma=
ll.
> Xwrite() should be used instead. There are other calls but those are eit=
her
> small or not on platform.

(Probably a typ0: Xwrite() -> xwrite()

But I think that this should be used:
write_in_full()



>
> reftable/writer.c:              int n =3D w->write(w->write_arg, zeroed,
> w->pending_padding);
> reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
> run-command.c:                  len =3D write(io->fd, io->u.out.buf,
> t/helper/test-path-utils.c:                     if (write(1, buffer, cou=
nt)
> < 0)
> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
> trace2/tr2_dst.c:       bytes =3D write(fd, buf_line->buf, buf_line->len=
);
>
>
>
>
