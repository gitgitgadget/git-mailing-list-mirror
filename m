Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBF308F39
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320121; cv=pass; b=SOm1ruOiDXRe4KY5o45XSrs3ozidvgp4SccrIuIUyJqxPd1lDvxcIWcMjHBwI3ZU3XHoa99IE9NoksesjcRULIAMeaDvexzPZGwqZewDkHd2RY0tOgTD854uJReFnJ/VGSKSZE7g4nq/PgkXQfgSUVtfGYjkVD6SoiNtR0uPlaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320121; c=relaxed/simple;
	bh=aL1AIbDGZ0SPua1NQGxtTzXbsvMGx1UtuTm+5VqS8og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MadjZpbuzhvYoVUfF2cyYyywfKAO/RnUiULriMAS6aomqZ37YW9KksM3BOz8Mv4jgITehmeqElP+EFpK4Lmwak9Szi+JFyczHBjgXFKlIgqugsjFaHO9di3Oi2/1UCMvKmExNG+AKYlok/5kWffaltqSScwwG3sA+PS9M3QBZSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1HjetJY; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1HjetJY"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso1454131c88.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 05:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773320120; cv=none;
        d=google.com; s=arc-20240605;
        b=OFw3EuUEB1LmNF8TjaCZRzkwvw0YrYFndRxASr5zmamuIiQUs/WBIEZMaQGcr+xfPm
         GS0fNPOm8OcqvJKquI2AqJuZoKOaox19DvhoU/8sCtIFfc9TiyV2/SVpvHxKzk35urMn
         mW59MkElZrD30X9c9l96GtG1W0H0OcIIfRi2T4x4eWTfTDhT3xv8aZgGaKvCtuSkFadC
         U2oSkEdLquSgg8PzB1eEddeUo68ii4mwK4R2vCm94RcLqQ1HC66nCHKiZxbtgE8Oo1VV
         N/3mS2gEYsrDC5Vj8ZqmK02nqzSPmunQHXgNid4/h7CQc/37Q5ATk1Zz+bfbyi5Cm3dx
         31eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1j4vPYbaUGjEM1BwDf11Vd8ecVZ0G4jj2Y44WsiKTbo=;
        fh=IFkbddQ4oMQXWnDQmV0ndnM4aW3CFyJMYVDzVSBK/wA=;
        b=Pc38gtQSwfvvV1F26xfrMPW8GdKuDiEtRw/UlJQ+wNl6QyObwXDK9hLBHDiejRkuoB
         MTzPu483ZdBzycXvFARWzessFwMMZCoTkL5y7poG7Jyhuhp4SxhnxvOD6KHddgLfZDY1
         FKvZ/BFVrD2ln93NLi/IZ2hUBuRWAvhKeAQIa/asin1VkbUIf3trjzQOI5+Ywe5jqNlK
         1+v3Wv88DJvuWj9XlShUMC1Raki2EnK+61sjlybrCjI34nPhmptjJJk/ktzsS1QNkor/
         JEfokrQI3UVx+8l4xCYGRdeFcHAOFJxfnQpVDaum1Xo+JIarHIhsHln180s5xMpsufzC
         Lx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773320120; x=1773924920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j4vPYbaUGjEM1BwDf11Vd8ecVZ0G4jj2Y44WsiKTbo=;
        b=T1HjetJYu1yABMPOz/pRdig5s3PRIRaOVfdrRVzRwOY8im8RYzMH3rmASXO5kJSwl2
         cbiQ4akbpK6IQKIcXK/k4gWgL4YlA0dPdR4iif+iKBwCQMIxtLR8S41LDCf77/y61j6/
         6DANI+j3/bu0kUddvm7iNFhxiTVl4zrhCMTx7TIYH/ma77YrR6dc3Gg/aTC/97aeJszX
         8wyE3WnaZ/G4nO+r2oj5vlGy7vN/2ICNkAzRiGADq0sv5dpbLQkeILaSTtxwyIwr7jOf
         jlKSGROpl4WnsZyp0qox3BXxDi473OTDI1t+0wKprMf+Umdzg6CSbvRVenkFiJNiTE1X
         3fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320120; x=1773924920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1j4vPYbaUGjEM1BwDf11Vd8ecVZ0G4jj2Y44WsiKTbo=;
        b=fzh4TAhMHj6FUSR/9CHniOQsV8KcCSde3+/df1pUckS8QPMYkFYwRv+bOBojZnPQmO
         DaCFcmRXi3hywBVQhNakQvnjrhKvqwORliCyKXiS50f6B/a4+n35fjnEi5myb/coatuc
         Bs8i5ORqTMAnXMrm5IC2i/H38swuh9BuFeyEwajaetBIMHmNJ7+Cmi1zDNJfLwVkxOQt
         tfXG6jRiMT88kT3QJNNrzaWpM1I+7qyKf0KQqBdY5oS7A/Es0gONO0SfTX6J3bEuSYxZ
         EqyrR/fzPxVOD6BEQSrHkaELaZJ148Rj3HTdcLsWacfoUKSDE9eWaMewBqlJg5ymSXRL
         jn2g==
X-Gm-Message-State: AOJu0YzlrkNxBmpzpaEOnPYIwi0myOFzSulwQGSp/9aQ6Yg8GX0Jq+Wp
	7GGruVm9gCPZKNxMi2YYZySbY/lW1aYL1lT1h2gsNVlrgWYPi+h4Btb64NxMALJBwodP29pVbwY
	jnJQQDNB8nFabC30k/PEDvSS+p4RduAM=
X-Gm-Gg: ATEYQzxe9D3hAZ5kPkM3XiyQjy4eK6EsTFL3cBhlk6avRLaMoW561/EkbIhROyRf5Pb
	bP8p6OhuB6B32kHEbV42OSrNux8ZgOXb2R8z2ncgIUTZyFvEf0C9AgWLz1qO3g1HHDjGED//39U
	Ouvnr3a5hW5AO41EOoi+ym5zBP2/Mq2qs+z624PNbF8PcHMobjsk2lggiJwNIdxwo5ccIKIjscC
	tbQY/g8GQCZPhMpbrtJQx8lQeo8I1Yfx4ED3C4eFCZYcONmKJPurOLFenumnLBuz0F6v5y4c4Y5
	SUxipAqgh9CDj7Mm6Ymu2E6C+7AVskB8/HTU6H3zaibw
X-Received: by 2002:a05:7022:78e:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-128e7836519mr2468935c88.34.1773320119570; Thu, 12 Mar 2026
 05:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773127785.git.belkid98@gmail.com> <CAP8UFD1t4Xs=xYW4uzqi7Ybc7Wz0nGMTkucCt5UxVnKTO1KE8w@mail.gmail.com>
In-Reply-To: <CAP8UFD1t4Xs=xYW4uzqi7Ybc7Wz0nGMTkucCt5UxVnKTO1KE8w@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 12 Mar 2026 13:55:08 +0100
X-Gm-Features: AaiRm50bQ9uC70MEM-xCJF9OSUdTGFFQPcKdtzbFFAwWUwKSx_gj8SX1up-97_A
Message-ID: <CAD=f0L8phuDNSvJJ8GdPxM_W-o01uUduN29XHDaKT7tu0bTGvQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] repo_config_values: migrate more globals
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	gitster@pobox.com, usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, 
	me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 at 13:31, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Mar 10, 2026 at 1:07=E2=80=AFPM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > Base series
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This series builds on top of the merged series:
> >   [PATCH v7 0/3] Move repo-specific globals into repo_config_values
> >
> > available at:
> >   https://lore.kernel.org/git/<cover.1771258573.git.belkid98@gmail.com>
> >
> > It should be applied on top of that series.
>
> The above was interesting when the "Move repo-specific globals into
> repo_config_values" series wasn't merged to master. But now that it
> has been merged, you can remove it.
>
> Thanks.

Thank you, Christian.

I will remove it in subsequent versions
