Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAB7BAE3
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362884; cv=none; b=jV6hcHPIlIEcbX5qSBRw8fuYb56L0XwOMlDXmlKC5Xj21cKj/6rf4t6uC5HUcyXXVJMGQIdpcPDH3UWGmOGxYqDjNu9Tt1ytFG6HGhjRbXgQKYTy+6sZGWWE7PskFtyr1RaodI92TDjJIjz/V0atW3OaGsuTm/uPWclRHKlpUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362884; c=relaxed/simple;
	bh=Ir6R5XsM52EfAz3O4CQxoHb6cB3h5ocYC7ihu2hJi9Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gkcp+CyRlR3XId9/joxUeMEWIOTJFvwy/KguTSWrEyVxiGUjLBI+ogXsG9WPJYGcXKjDWOeCdzmZzrrFAEKBVW8gBKaGoy+Zx8XtTKjUZcQbRZ2+QLg06AtTryiGWA3agTPVNl+XmWyn2FjvQTNmyO8c+9XMEASOo5ybOoLuAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=m3Pk0FEJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="m3Pk0FEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716362877; x=1716967677;
	i=johannes.schindelin@gmx.de;
	bh=rQMSGBLmtHgSif8/OaBmJllwY0Jy2eZeW7TBOlTjvvo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m3Pk0FEJVS6zAVGnIelCNW/xbTRAuhZRyU8FYdPFLQXlElug6p7yc8xkNtW8ImlR
	 NPIzjE2TJwNq11oE9OnGVcVMpZ8achZp6IPTLLHQ1d9yP3xPWeR8x9WKJsMgSMLT9
	 qV/C2wb9qmiEytUn4/OYcKLxhNi/BcFFAeJ2Hice/OWTOJRcrIKzwBvfE2LM0UFbh
	 1OfNbszarLLRPpJPfkg2EoLQMCojOjdmepQgPvks0KodmFwCBi6NDY9LYyQNV6Txy
	 yzsC08t93HS9YaNQY+fhDe0q1uLROQGjIlz+619biDx5sWoMH3bZMqbQGgR4CeFgm
	 U0Rja1OAb79ExC7Svg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1smIOI02VD-00fffk; Wed, 22
 May 2024 09:27:57 +0200
Date: Wed, 22 May 2024 09:27:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH 12/12] Revert "fetch/clone: detect dubious ownership of
 local repositories"
In-Reply-To: <xmqq34qaaobk.fsf@gitster.g>
Message-ID: <6e493925-f3f6-43aa-4381-612067e87d01@gmx.de>
References: <20240521195659.870714-1-gitster@pobox.com> <20240521195659.870714-13-gitster@pobox.com> <xmqq34qaaobk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9WiNMF/CbckkehFTimrIj0GG9vDoYkvw6r25NemISxNUjL974Uy
 kTdM+tDheXmg33DRmoeVPi7uCLBOkTb9EJpJwgNqx0Oy+A3as9xsnWwKAik5WIWWClgvIVY
 K9LgbncnHe8Etujthi50nSSZRnKoG7C/tDGZoP7KQzGXUh24/8D8SOapmO7OKAUaYu82IWR
 g4Xq44+bDkvunJAdF5NSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tk7UY+cEmIc=;r37K7+we9MDiEyChzmlEh/1s35B
 rISjsU6ef22MK5Bs7plqjbkE/SkDy1pc21T1znb0QZEcwzUpEmNLamtJZi8ZC1UgYPy9qtXWf
 S41V99oHCclCzQ4z7Aq2DIxet/B/+3aJY8nPOGpmdwUNE8tbBBpx3bdD6ZY/ATJ+8+Grl1UEN
 U3/VEiHhZDqVu8DcOTXTtACxEg4E5SE/a1HIOVvRYdVB+fFOdGLtdnYH0pr8YAOV6GmgD4JR1
 bUsRA3tg2t1Vjb3HO1j3t8IfE7/G8WauHPDLiNMr8PPOHtMFIfcHLUI1JwZEZxmF6EgV58nZa
 cjA3rvlWjK37ptlV8b6+OAFIdvqgApkeQaLBGvieXy7HlarHSMBOfB+VRzQU9W9y4K9N6ZwiT
 VzWxAwCgSO/xDbey0v9xHuHnHYGYYgrR6FSBOyTJzEoCOAxX9Jy01M914zkwGB0NT47gVOTD6
 obEUGJjCwOL8W7Pw+OuYKBXtt6k4uATJ6kU1adviz9CEqRwyQTMV5u5z30O4Skux6YYwaBZq8
 ARWfLA6oAw6J6A471+DPRS+BQUyKZH/PlsM08UEXKrq7xQ5qLnEP1nfWaBtcCE/rNlvC050Tf
 DOEi1hiPJ74jdLOQUMBgZINesdrGyab7Vk/ySYqltUCXAGo+HTovFz92XjLohZr05gkUD/uLX
 Rvo7qzqMmFBnGHSbknjFl6nwL7gWIvNVMFWtvH7aInI1f71UjWUQ8vTaHj7YFe3Fm7ntkpL89
 FWgtqwAF79wsQxlr5jOblmfhAkgIYNTuP+lXz6LE0AUmGlZZllB83h4+cj58kGORIst/j++A+
 VJSzanCWUwbCWHCHo37fdyqlfH4HiNJdhGHtUujeWPL2Q=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 21 May 2024, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > This partially reverts f4aa8c8b (fetch/clone: detect dubious
> > ownership of local repositories, 2024-04-10) that broke typical
> > read-only use cases (e.g. by git-daemon serving fetches and clones)
> > where "nobody" who has no write permission serves repositories owned
> > by others.  The function to die upon seeing dubious ownership is
> > still kept, as there are other users of it, but calls to it from the
> > generic repository discovery code path, which triggered in cases far
> > wider than originally intended (i.e. to stop local clones), have
> > been removed.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
>
> I am inclined to propose dropping this step, actually.
>
> cf. https://lore.kernel.org/git/xmqq7cfmaofl.fsf@gitster.g/

To https://github.com/dscho/git
 + c6da96aa5f0...f71d7009814 maint-2.39 -> tentative/maint-2.39 (forced up=
date)
 + fff57b200d1...21dc6c4d521 maint-2.40 -> tentative/maint-2.40 (forced up=
date)
 + 616450032a0...0d21b3451cd maint-2.41 -> tentative/maint-2.41 (forced up=
date)
 + b1ea89bc2d6...e9bd0c8f8c4 maint-2.42 -> tentative/maint-2.42 (forced up=
date)
 + 093c42a6c6b...9926037ce8c maint-2.43 -> tentative/maint-2.43 (forced up=
date)
 + 3c7a7b923b3...aec5a9bf52c maint-2.44 -> tentative/maint-2.44 (forced up=
date)
 + aeddcb02756...d3c56966d13 maint-2.45 -> tentative/maint-2.45 (forced up=
date)

This command-line comes up with no differences (meaning: you resolved the
merge conflicts, even the ones without conflict markers, in the same way
as I did, which is good):

  for i in $(seq 39 45)
  do
    case $i in
    39) gitster=3Djc/fix-2.45.1-and-friends-for-2.39;;
    45) gitster=3Djc/fix-2.45.1-and-friends-for-maint;;
    *)  gitster=3Dfixes/2.45.1/2.$i;;
    esac &&
    git diff gitster/$gitster..dscho/tentative/maint-2.$i -- \
      ':(exclude)Documentation/RelNotes/' \
      ':(exclude)GIT-VERSION-GEN' \
      ':(exclude)RelNotes'
  done

Ciao,
Johannes
