Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984F1C84A0
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218054; cv=none; b=Y4r594GM/tTcHXDgrXVSYmJZ11ikI2ghd6j+ZNIswNNQ1nhZbR0VQUAk6fyy/CqK5W2n+FKHjFdZi136CeI56ZjAyNErlcLWajrfb4oBcJwAd+TfP1hLPEXHTtRVxZm0PnakZoVtiVegwaYKhCyYBC9PqM6878u5bITNB6+3crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218054; c=relaxed/simple;
	bh=XB4cr6eTS+U52yIJbDOE/2nUfb4512XLfy88URIY9Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkNxvAjavupfkVHyxKDNn+xnSBX66gTcTXMMPcr5Q0uqvkm0BAwNUqswohvbIxoqo6aRXen88qP07vHidRZGq0bSSGpbPJ3kfVfChGndBfOVoWS/YwtkwIbHDwOR8mpPbTue7emmARZDFJiXCYrUIjoq+S+HBX9mx0yPtSI+Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so6486786d6.3
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 10:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218051; x=1744822851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB4cr6eTS+U52yIJbDOE/2nUfb4512XLfy88URIY9Rg=;
        b=N4NWs5k/wl8OhGdLYbNIFMJgy6DjgAO0FHklfba/cL3pWzzJ4HR4TBVQDDz8zpz/gf
         8+fQ+ydb9Acn+ayFF6ZojmgFffMgPPiz0YrqF+6AENR3qb2met6NyG0F6qiStDeufihd
         emayULFZajyWTFwoiHrE1ctYgalZqm1g28EYklrhWCiWZZok5KB/QDr0PgkD13yCWowV
         3s05fT8FQmV3gAke147gQjc2rBW9xF2G+NmmDT0x3FJ5o4EYqVFgjyqKny8uRhX88JIl
         m5E12NXF9rQL4k+aE0pXXQr5MEB8JDC+UxAsWw4Q3fHxsKBZIkGVAT+V/BdGUeGt8Am3
         FCmg==
X-Gm-Message-State: AOJu0YwltJCLoaeKctQDsD3MutPOAre/4bl2JBgOvDIDNdNb8liY5n69
	KSyod0SNJo4BRD8W+fmzmG0E8f7Jiu96g0kz+zV+nKGpOsjorfJB8RVSNqgEFRQf7Ja/a072h/v
	rO2+sOiWw8mCsMzji5e4L7kSboQU=
X-Gm-Gg: ASbGnctMmR7a2O06Acdagzx91N+pQfhcroLKfHmHLEBUvYN2TyvIqNHHBMj0b60kaTm
	HGCOiUgiJC/gyqNXO2on1+lWd/qegewuF7SQbTXOPnZ5MTSUa7WUvMwwyfGLKjBHnZK5VvPuqh5
	3HFX9QMytQSo69rXIO6q48
X-Google-Smtp-Source: AGHT+IFJ3uo3Uto4JC/pT+dwk2kUS6N5GrrrLwXgM1gVI0P99MKjCvj9lXjpqPNj3idEJA04RLepT9YgNnzCfwneVRw=
X-Received: by 2002:a05:6214:dac:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6f0dbb7851cmr25288026d6.1.1744218051158; Wed, 09 Apr 2025
 10:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403144852.19153-1-sn03.general@gmail.com>
 <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com> <CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
In-Reply-To: <CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 9 Apr 2025 13:00:40 -0400
X-Gm-Features: ATxdqUFIlDuZi2a-rz4fNS8o5k5gL7UJWn-EMXLwGxiFNtx9SO7_xaDqURxGPVc
Message-ID: <CAPig+cRe9BQw=U41uOprZ5JRNgNTC46zMpyGjNy9b=y-hA8-tA@mail.gmail.com>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
To: Subhaditya Nath <sn03.general@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 12:29=E2=80=AFPM Subhaditya Nath <sn03.general@gmail=
.com> wrote:
> On Thu, Apr 3, 2025 at 10:35=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > [...] for the sake of consistency and to match the author's original
> > intent, it may make more sense to retain the argument to printf and
> > instead employ `%d`.
>
> The problem is, there are multiple ways the printf statement could be
> written -
>
> 1) printf "[submodule \"sm-$i\"]\npath =3D recursive-submodule-path-$i\n"
> 2) printf "[submodule \"sm-$i\"]\npath =3D recursive-submodule-path-%d\n"=
 "$i"
> 3) printf "[submodule \"sm-%d\"]\npath =3D recursive-submodule-path-$i\n"=
 "$i"
> 4) printf "[submodule \"sm-%d\"]\npath =3D recursive-submodule-path-%d\n"=
 "$i" "$i"
>
> Which one of these is to be used?

 The final (#4) seems most natural.
