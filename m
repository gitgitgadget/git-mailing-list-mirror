Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24972E8B83
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771640926; cv=none; b=kQYXMBcCXLvWbL0ffuNOFz8QsNgj86XgzUf425EnWXL9UjCNgr7SnUMCdx6vL01ML1TU++URD0cz8FXQK7deSvezDfXUgBLSNx3tI+kSbyzKIlwb6mhqUcKgXHbcmtq5t7NCX3dfllznvQA8xeAyGYERtdy0Ijb9ASqPbN4DW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771640926; c=relaxed/simple;
	bh=iVh30jb810wrg6gVcGITOSdNxLX/56RKyGy81sbOAGU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GiJpySRKhIeGgWj5B5txM45QPCsDMblf1qpHn8i4ikmMKbw4kyNUgPAfB59DC3PvUEBH2MZADNKCAtgYNAdhUPNfL8FzYHCYdAspxpAp6xa6Nd1OaO2RnzBQksggkw7Y7S6BSDi/W+vOGJPOgKYieqr/m9K57Z5PjuMHPtiPz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgU57qgA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgU57qgA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a67282a0so22762691cf.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771640924; x=1772245724; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqYRXnEx1+QME5tHip/rZt/wsmYxiTAOk1tRcjQhQQI=;
        b=BgU57qgA5Cik8e8sQCzzhz3J5RVbXZ+A4HmMfURsFRydUDZZvmtzxJUNB72tiFTyMX
         FmPvG+KAHPAeQW69KpYxp5S+fjycerVUpmox+oMu94UW59dQya+fui7hvtEJvmwkwRpu
         A7GTmnRB9VYAhYmJlcTVuQUegqJLxb6OedwDvji9WloiQHDNTpKnDkT+3YKWZQzJ/hRY
         4mtyz9XxEvCNG7W8PhCBYrI5i/Gp85QWnw6E2zw2300l3j5lBLuayYiNiHywLGt4Ph7q
         HvcotN/YktQZ0sPPi6V+lZIPjcqRTtwGIoGmKOgkJYRC/iF9y8WUq4W1kmS2sX9xwCPG
         4TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771640924; x=1772245724;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AqYRXnEx1+QME5tHip/rZt/wsmYxiTAOk1tRcjQhQQI=;
        b=MC+5RPDHlmrQbkk87iVzqL1uP+8x9NkHA7u48pAYr0ryvfMoFr2OFK1AExdAg3sgAP
         snE2sTsLUvrOmhabNpg06M/6Nj3/c9y0YrhEJpHRDe+fd2Zt+UyFiNmOokS2jLGGpJJB
         l1EcUcqgnB7GmtCDAhGvGVnLkcetnnLZ4rZxQXxUenS4kBuS6yaevsmkgSNzbTr4a192
         3jL27+LxlYeRvAWowSZVh7PDM2It4OMIlPixLsuZKU0vpkPV4jtYQ7DmVTOSB/kBO9rl
         Vs5o0KxT7foleE4udaW6HJlblo7/ew49dQ1vVpB/OD9knHnKIhAmXGAEexSLc2oXV7RX
         eSrQ==
X-Gm-Message-State: AOJu0YxAycYPmL1km5sjfdpaji0oJgYT3JSkKxzt4J64Bg30YyGUoDpB
	0Ts9C4gGMPpmjDgNraQi8QLaV5d1Lfo07wixSrGdRhftoQZNDKqHYdHuaOvgXQ==
X-Gm-Gg: AZuq6aLvOlwXUPLZTYovfCH08KgAlCcfxQZIjg/L0UwXa+43MZELDF4DqNchWHoz3Tt
	o+zDgAFE8vmhrIxfPmELW4gpWzAeKE4lHao5h+XDC3oqmuaFVzyh/SmjAGFzTqdMXtAvBd6LV8F
	GtZtyOuWNbxT2JyWm1nfeBGyjgMeAcTcXHkvM8QrMcoFmvTv82pD7SLq71WBkygXIfDz3pErWfo
	A0nxmoSl5Yizy03rk1LcpNOX4azbnqXxtDcKWL+cjXUn4rmbXzXEpa3zCcHagBtTo1W2/fDUEXv
	9hLrwcFe2L8fT4TFo67Nxyy1PAzkZixHiE0dn9TEL3EdGxtjRdNudlHqBM9Xf0evTAB1bW7ros3
	5sm+SuHg3JtEBf/rJrY5Rir7J4U3wMa7NHpgeCbK32LF523Quo9+k0wvghj2eb9KTkeWlPYmPjN
	LoCZxn+Vv/3Jn9+R7MxvbgKC70GSFaKyka1D0/bOSriExoXoG4iJQKD17+p7pqx+pziGIMqE54z
	vtvU93QWrXWJ5f+Kqs9NgRUlCu5rb1afq3HynFt
X-Received: by 2002:ac8:58cf:0:b0:501:423e:fe0d with SMTP id d75a77b69052e-5070bba6c28mr28922591cf.3.1771640923851;
        Fri, 20 Feb 2026 18:28:43 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b25e:bf13:8cd5:2788:d0cb:fbb0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6d505csm8163221cf.27.2026.02.20.18.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 18:28:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
Date: Fri, 20 Feb 2026 21:28:32 -0500
Message-Id: <5EDD26EE-51B6-4BE2-A7C7-E1E0991537E4@gmail.com>
References: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 f=C3=A9vr. 2026 =C3=A0 09:51, Shreyansh Paliwal <shreyanshpaliwalcms=
mn@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFHi,
>=20
> While using git send-email I ran into some confusion around the prompt tha=
t
> appears when any 8-bit (non-ASCII) content is detected.
>=20
> When prompted with,
>=20
>  Which 8bit encoding should I declare [UTF-8]? y
>  Are you sure you want to use <y> [y/N]? y

Yeah, that was a bit confusing for me until I got used to it. Maybe saying =E2=
=80=9C[default: UTF-8]=E2=80=9D would be a small and definite improvement?

> I initially assumed this was a yes/no style confirmation and answered "y",=

> and ignored the 'which' part (this was due to my oversight). This resulted=

> in the charset being set to "y", which later produced a subject line like,=

>=20
>  =3D?y?q?...?=3D
>=20
> Mail clients like Gmail still displayed the message correctly, but the
> mailing list archive showed the raw encoded form[1].
>=20
> Afterwards, I realized the prompt expects a charset name (e.g., "UTF-8")
> rather than a yes/no answer, and pressing enter would have selected the
> default (which is UTF-8).
>=20
> I had also encountered this earlier when the non-ASCII character was in th=
e
> message body rather than the subject, in that case the result appeared to
> work fine even with the mistaken input, which made the issue less obvious
> to me at first.
>=20
> This made me wonder whether the current UX around the prompts or input
> validation could be improved in any way to reduce the chance of accidental=

> input being interpreted as a charset name.
>=20
> Best,
> Shreyansh
>=20
> [1]- https://lore.kernel.org/git/20260219181154.66814-1-shreyanshpaliwalcm=
smn@gmail.com/

Thanks for thinking on this; better that I never needed to get used to the o=
ddity ;)=
