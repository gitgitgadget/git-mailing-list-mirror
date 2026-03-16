Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E106224FA
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702480; cv=pass; b=A2jYuyDVdPn5/C/OTLxzLbSVl3TkrrGVcq1ixkKdVpVgj429IrtmzLliuzBC1nIF0ixapzszBqwD0/hFz+wyomAGvy9aKQADdSKO2c5/ojxNeKHf1jZ3cJAodUyvnZXllCK1f5ObJ2Tqtkgo6UJrANOEA1Nr6uqUClMoQlOnbvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702480; c=relaxed/simple;
	bh=50iOJeAsRvd1lEkjrJBg8sKmzgFwiG23OmXesWIJCrk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj9Dqr/o6tD8nWQnfAZOZT+F9XMfd5rtfesJEqmX3UtPDPACbRzPviFNuNeL11zQuPxE3jHcQ/y8Uknyt4m16BGOYoyC+n2bTMvPk14kPLsnQGDUl6o/R09z4b0mXierQ6OJHHnqGYHVBEd5PlEu1b4a5k6RBbbCiOOIR8GQ5Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY7S4E9/; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY7S4E9/"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5fff18d44fbso3230370137.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773702478; cv=none;
        d=google.com; s=arc-20240605;
        b=a2ZlOxX0287ut3JQDiTOSj4HM2XfrmMFT0rWWSgy8rpg7Y8np6XH6hlarHUrjTmNXD
         QzvTvblwS4yqU+d1/5lVIf/+ymPKgsHbiYWI2Fuqp2DYzp3O4o/QUG4u8K0H0mF1513h
         vby8S+gxFq4wRcnyu9STh9fAC/4tiX4P0607Xn3TEoILfrqb1NlBVozus/ZQW3CHmohX
         hgi2W+j4VUdi/7Dv+7BIN3dBw+ztqguhk3sy3Z6PIvWlgjYZ2UAm/3tZQD8N7nX1o8OB
         Ksw431VuLSEBGdM9iu39LlJA4jcU0UlcN/RmlThWloZAABdYXjluoMuM7stWT8D1mJi2
         cfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=50iOJeAsRvd1lEkjrJBg8sKmzgFwiG23OmXesWIJCrk=;
        fh=hOI7sKFDLXZ3t6IodAM2zeToVtLe8I75WQZTE5Y0r5k=;
        b=aPdaTYaal7DS3/ttUfsINvxomNiGfVYwTWG+LR6pBw8KlnckYTBRBPWX6bCWFmyBdJ
         bAlgf0TEsXOGqI6EeKaB9IIrRAgwPrK+imkuV4c7CN86RHKsZO71duVOXUkRfg11iOg7
         zcvxAISWAGu41iyw0VcNKX7rw6mfp98zNYBV141JgcpzQPJeZunGAH8cXQY3turmKSiM
         SWPiD5p8G2NlDFDBxJFCjp61kTcAJ1B1j8Q+WsddONzArrNoUVTtPZ5fgWAFp6c8eGwb
         fp+0KA9Q1jh6H6fzpsLy5XkWU+VK0wydc/0EiSXkzpkQ1W9U1d44ruNEm0WUvw7jzFBY
         ycmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773702478; x=1774307278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=50iOJeAsRvd1lEkjrJBg8sKmzgFwiG23OmXesWIJCrk=;
        b=nY7S4E9/M1jVXEM0rDfFatKqAB8cGgJi6p7FR0ZOx/af87P2EfX6BUk/04AfOXtpPG
         ma/a/wcDlwUzla8tbhcbmjllYzqt2Jplgw4U0iXilzZRCPn+sOOdZx4V9bfpo9v+DI5M
         Sc83lyL5f7a4YJWumnpS0/UNVQ9ygQzJqJHdvciGV4sCBLZNByJtXFHliLrfSfMZhXWT
         ZXJ7ZIHyyi7DVSEDx/fvhaZHvqYQDTJmEYhoS99a5ijU6ZafKNVfsuBq3XIoGoaU+eAk
         3XHRX8+Ih0tzi4DH60MvkoPO+xTXlJy9z/QshtiupbR4qdAtizoKfIwJKrhCgTegUpxc
         WYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702478; x=1774307278;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50iOJeAsRvd1lEkjrJBg8sKmzgFwiG23OmXesWIJCrk=;
        b=KW7AqTtmrLcHCuPk/YlBBiBDnitFAMHvaHvc0w9FhYgjEj2FhCBrmxlIXgV5Hq70bs
         ZdIsgxMcUj00vhR/M1j1GEZ3MplsvpvHW2CDYwcdMT3V+YUaQIVqeOZzlNbUslUU/6Mc
         7/eRxR4eHtlW96FQ/icYxrAUy4e9BkJtK+y7yne3RpXHCmwga/BPjNZiQTqAZIUt/Jhy
         8D4I+jz27VV8dzj5/eKct9m/ktlfgdBPyaCS+z0xpnW4qkcJpBII240yigpR3zHE4zKZ
         mB5yR5qB7/IPT2GZ1aIKSuiM8vnVoxZrgR5SsseD5n7VsRTvKK6peXevfB5nip2wkVPO
         2P5w==
X-Gm-Message-State: AOJu0Yx5BC8UGaQNKTIItOsj8pbm3lOzI0ZVI7pTHjEhR3Jm9g1IJ87O
	g2QNacnZt/ShBPwgKGg+b7ObciAz4AT8cfQ9/DNXCBqnku5CYH0+mYIeztqwEsNmvZOElSVp6Dn
	6wfFi/IZBya7K3BZRZDrtSyOBPXSMrDQ=
X-Gm-Gg: ATEYQzwZOYGr7/O2jKF6rE2gWQp7fFGT9GDO75YqkZ7W7B82X+yDDSC69TON25uk93w
	VG8SST8Pwf3TjEqGru4XBp/IplTtjhR5M1rXF1NJVOtl6UQDu/Kg7Cald7PXj1U2oRFdgpaiP4I
	botiiywouM+p/1vU44jmka5K9Mg3dYX8uz1fymKK9vriEgIEAi8NanKTZPSiwfbI2p0OqVIvg/u
	bO8k99Er90kh7xCC1H2D5RefU2jy14a3XpbpH93oSfpP6N+qEPzFqsoV43dGIuc9UduHJsssl9O
	fYNv6Sy5MUjx2sveFEYOV5xuL3z13NAIIuB7HU2m0A==
X-Received: by 2002:a05:6102:c4f:b0:5fd:8175:2eb7 with SMTP id
 ada2fe7eead31-6020e5c737emr7308657137.34.1773702478134; Mon, 16 Mar 2026
 16:07:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 16:07:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 16:07:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAN5EUNTO8jez1Rc3t-27u29yUYr6wt265shG=QUiKC-65qDwGA@mail.gmail.com>
References: <CAN5EUNSxS_A=XT7cmUiQ9bsS5vtzB_KAb8URCzc3X5AzkQci8w@mail.gmail.com>
 <CA+J6zkQMN0MnR7OG0vr6B0fa7jefOSP7B2qG=fhv_zYubg5gWA@mail.gmail.com> <CAN5EUNTO8jez1Rc3t-27u29yUYr6wt265shG=QUiKC-65qDwGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 16:07:57 -0700
X-Gm-Features: AaiRm52Jps3XfmaKBL_yCI5PDc1eCWrcmGyWeJXm9CgFMQg1jZlkw9IH7Rn2SsM
Message-ID: <CAOLa=ZSJt+6Gr==Y6Y_vnya4x6B+4Zt6cuT98NdEtpspdAgLkQ@mail.gmail.com>
Subject: Re: [GSoC] question for an additional objective
To: Pablo <pabloosabaterr@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000259b7e064d2c4afd"

--000000000000259b7e064d2c4afd
Content-Type: text/plain; charset="UTF-8"

Pablo <pabloosabaterr@gmail.com> writes:

> Hi Chandra,
> Thanks, I didn't know about the [RFC], I'll note that. This would have
> to work on top of Eric and Calvin's work that has to be rebased and
> fixed, once that is done I'm up to drafting some code about how it
> would have to be.
>
> Thanks,
> Pablo


I agree with Chandra,

I think it is a good idea, but better to be conservative with the
timeline. Mostly since reviews often take longer than expected.

Another tip is to not top post!

--000000000000259b7e064d2c4afd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a1578b83b1440c97_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNGpVc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnJCREFDTzkxRDNsTUNqM3lwbU5TMk5qcG92Sk5SSAplQ21ES0cyTkJn
TTkvOHVlZUJ4NkFaa2dvcnZsNGRHOUYvaVdlei85SDFvV2VhbEZVekVZbVN2cndBc04yVk8vCnd1
Z3BGZ3YwK1pMQURGUDdMUVBxb2RkS2RhdC9iTnZ0VUowL25oaFFPWUFtc2VTMWNhc2VhRVg2V3o2
ZnNEUnIKNGFJN044QURxWE92UE9sK1Jua2xteE8wVEpwVDRWbVQ0NUFiMmp4bU1mazROTkNkQW9p
R0RHWXh1eGt1cldZQwoxRzRMeDdpRWs1UGNrQ2JUaTF0VXZ2SUdlYXEzLzhyV0tUbnhoZ3RaeUVN
RUpuNmRnUk9ISVVBbGJTNG9HNXIzCnA0QzgvM0RVUUJHdFFGbGpGQ0FFVnVXb082aGVZTDFWNnRK
YzVnaUhGcXlpYjVGZ3RpZ01IbWxkbnFJWW5uQU4KMlczK1VBRkwrTUhiRUtENDRacHFxdXFuYXdJ
c2l3SHFpMXlLaVdPMCtwV0xpa0lTWkRGTzlDS1NhZmU4alh4dApCQ0dTTGkvaWIvNUdUMElma2lU
WHZ1R3BnUjErSXI0dEVkSjJ4YTg1VllwbXNjeHVRaXpqcHYyeTNLUnhXNmN5CnRidW85RTZxODRz
ZEhuR3ZmM2ZjYWFudVNKM3h1aVQxUWNDWDdpdz0KPStrYlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000259b7e064d2c4afd--
