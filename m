Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692387263B
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601408; cv=pass; b=FKaXBb2mZuEkv148MHLQWb1UtMNwLgNC43r+ydTQGTrN+l2VWlI6bURkpOA7gQWhY0FZBXhV+gA6cfIbwby3TgmHj2TG+jY1gskh55A8ReOLPwJcgg44Fh6aUpGNy4aP19EuTmcmARB0Z3sSML9EMlWM6tJKfmr31LKRfclTjYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601408; c=relaxed/simple;
	bh=xriG8qSaBgDmkgcYsN2SUXeBjBRYaroLBMBWjIElXXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CpBjmdkA2H3J2DIa6lb8q9k+xLnzU/77E0RxsCYWE26vjmaEEn+Q1dmF8tcT6naK0HEg+IjRFs7zMfTAFT0YilZTHj3tdZ6hNn+I2THb7nHvQzfBeDJ6g1lqhKyag5H2EbypudppJBBHRCEoApaLIarCS0EDMvTAyGnXq9EPMnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1xdcqSk; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1xdcqSk"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso866867eaf.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 16:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782601406; cv=none;
        d=google.com; s=arc-20260327;
        b=er11GYnrtVkKkYitrizefUieDdp/5rkLkeGlZwa3VQmouF10z2sik5FfSFRUz++7rL
         D2h/VVuAavwqw7oInxsWLu2PKnMhPorqhsHktuH/gHBuF2xtrf1kV5TvdsX6VuYx+YGn
         Qvgj/AYluJ6N0ag/lGTFsDct2ot32if5B9vMnAJFXHS4Dy3Jekyn2THBHVGLF6MXbntI
         CtJTU2Mm7sJck9el2jGhRduIfHIEsTYiPKWBVWJqtBgfXsGPNuFhmU9Vwxlsx75VzGXi
         TTir+RIUq8+QkysNJB2JgoQynHdA/GYGQ7AmBSNiPBXEoz2umoSTeMhiYkb0U41HlYjV
         NyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnlApgbKSyxtWL+9UjLAEypaWzdLaqbSIH3oORWSFDA=;
        fh=zjcX18DJU24Z/vd6tBmUcdJIBoUU//2+HBT8Ez3z2Qg=;
        b=m45J81z4t3g4/hYWbO+2AoOxQHtOzkXjx4oV/M1REtOC2+WrvznlEbq+6IfTwkYKxG
         DUlWgTN/8HNCuRrQiNacSkTrIu8oJvc1SJIxzANS9D/EQ1jBXnF1D1laCBx3EcNy9LTf
         RH5TS3sQfp1+PsXfTyrOs7mBBG/MokMbhruWZabOstK5P7lhJXDtc47DMPfDnGYYh01r
         SeYS7yjYLr8lFWmkfGmbhKuaMXGoYNsQzvUa38kqIpYvZaGrYjiMSXhA5vTZ3/BHm/Ii
         LRY26z1yswaJ41o4JaSTA/Lrtfh4w+fhkyxiU+3C1+p79/qBcLdwB+UEzMGa2pFl//eo
         f0Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782601406; x=1783206206; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnlApgbKSyxtWL+9UjLAEypaWzdLaqbSIH3oORWSFDA=;
        b=s1xdcqSkt0HJM7aoaqmjpg0Uy0TwpOqWJn/Gh631MQBJcuIzEUloQ84UawWYt343W1
         jveRCNVOYRR0QJeQf5TJZWUBCJwCFXZm7VmlBerax6BAUAv/ksmLegpXfCC/t44s19mc
         4n5u/oG+XN0cqqh6URjW0vRfIwukJSYp8Mt7PAG/NOdUOVneUFth9A6IMnKRtxuLAIM/
         40o8VZg4+Dz6TvYa6bhbnya9uPwXVa1iqb1pXEbR4GahaFRqYT4UdjaPr5/o0K/tlFPo
         iua7fMfETimB8zzssByYJ+KyBNyAF7MS8p2ByYqnQ8giTxSth5LuZQH1mwf0bR86Bdnw
         jmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782601406; x=1783206206;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnlApgbKSyxtWL+9UjLAEypaWzdLaqbSIH3oORWSFDA=;
        b=jYnnYQzCNjDpIVNrUHYow2iipFVEQuL3lwpdwHBAYqoPUiCuuQCrUxUKFSH11ZVl8K
         GBdjTqSGyE5Wzjcpb25q/nbdqufDRd+woGLYNJJoUUmhew7t73EArYO3B9grVUnHhbMs
         7vpTRskhLfrPpd0N7lZaawUz9iWYv1qaIOi1RA+CdTB/TJT0PGzNq/lNUjDyZO6tdB7n
         lyDusHN3n/tLoC2iT6gGkL+0FB18hyFDQyqshPnDcGDR4J/x2HhsDFDInXOEnEPOONXz
         Gmr3omrTuAV7ZSAiniqkv+2KkTqXwOjxGuCe5FFnJtfdZXbxOumNXjqSPIS8VgsBpWVL
         Fgzw==
X-Forwarded-Encrypted: i=1; AFNElJ9gJCsnGOIfOPPlc6taHPgZsDOWmV0xjVDOcS819ZIX3YXZPMv/aYl7w+uLyU2Yhy/20Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7DbqhzLKj+EQ/Zd9PJDM6IR0Ue2R0RakLJUO/0IOMrVEnfsw
	sK6zoaiJ9sxr04ouVUd/aMndLHd2k+cptwOavD/FktzI+FHdHGT4Ehp0fEyIYMhkZJQlKJO63sq
	O0W3CI/gJx3WcAyITrI0aFL6zTZgejA0=
X-Gm-Gg: AfdE7cmdYu54+hG05BN1Emgn+pqXnp93RpKIcX/R0Sh84BsKv7xyumZTr5Y5GgmG2Lx
	BCs5n1vlPaGhSez2D2i93eEwsV6iVxck+kf2CQ8PyqpJPP/H7un/WmPcAY0jp4r/hGX/V7wHEpg
	C5vsQhY2DtSOpTBSKbi184eNwRz3im7F4usEw4/TpzXu7Jmyq2CnpL2HwAao+8xI0IVvBakV4n4
	uIiwx44OrRhcoOa4lbjrj4pEOOuWxOFiH5z4NYiWRkJ9zxIfTO7WhOTIa6Wcs38tWgskFykEURC
	iagWuhb2lLsHvCa9hrQ7klvVeiECfSuWp4YfZc5VdEFXdf6nLO6qEpVbmwi2VvjQgJe0ltDtRe+
	wKc5UR/QD8xi/LPg=
X-Received: by 2002:a05:6820:2013:b0:6a1:50e7:5c0e with SMTP id
 006d021491bc7-6a150e75d05mr4089585eaf.57.1782601406462; Sat, 27 Jun 2026
 16:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>
 <20260627201558.Bw6A-jbx@steffen%sdaoden.eu>
In-Reply-To: <20260627201558.Bw6A-jbx@steffen%sdaoden.eu>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 27 Jun 2026 16:03:14 -0700
X-Gm-Features: AVVi8Cfi5TyYH5MRWx9vK6IOq829Fx4779eda-knUhxcL8rNmUGb2x_QZNMe5wg
Message-ID: <CAC2Qwm+v2pRp30TYJpy8Wxzb7gbX+nzybZ_3A99cHb-xjjpCnQ@mail.gmail.com>
Subject: Re: 2.54.0: fyi: endless loop at 100% CPU
To: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org, 
	Steffen Nurpmeso <steffen@sdaoden.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 1:16=E2=80=AFPM Steffen Nurpmeso <steffen@sdaoden.e=
u> wrote:
>
> Thanks for these pointers, i did not know about such configuration
> variables.  I will set them like you show.

No problem! Just to clarify, I'm not sure you should actually use those
configuration values verbatim. I was more pointing in the direction of
potentially relevant options for debugging / working around the issue.
