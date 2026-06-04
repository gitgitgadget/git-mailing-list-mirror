Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE3371045
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560067; cv=pass; b=h4KOjs3uENCoYQLlds8MAPRMM0wNtxxQ9xUJ5JOcbUcrw1jhMvIV4WckE0ic9vGYqebdOJU4ncPfzLV4zF4T4QdvRlRRqGNF7avroK15IjbUcej7KD0aMBG11vkLJJwkaKajTXHEgybNxAC/thXvs9aAyIfLdLOlxl+koyO/Jqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560067; c=relaxed/simple;
	bh=jO5jWgaXZa2lsbmKmA57m7CoJZ1nTKNIQoumyTQ7CDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGNa2ARwfrDZt/j+uT9USRxupS70lqWueA3PNu4VZCozpGvFhCJpcIz2AGWIxfFHGmp1kf1iS2ZqEvtpCDZXgWobI1GHoOkq9AVZPxyy9pxrSIPWUzs/Hk6pPjwialfQA4G/E0LOqXQss30gg1SNe2fEHq8KVK2U1g2X1pwCac0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnOT4oDI; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnOT4oDI"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137f0aa125bso1116609c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 01:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780560065; cv=none;
        d=google.com; s=arc-20240605;
        b=lsbtWo7899hVj7GrEvTGD+/9dPXhVTY6NtxEe2kagusOzZMO5Bl7kjurjSY0KK6rcv
         71+T/eTY6EG3T0MaO7zjByVc4H9JOHaET/CZtgXnzCAE9+/ZKbeJENXewMrdAin17hBw
         BA4FSqtyDh6vLRU3PT13tFcvz5RN+peLET4qgtZcrbbav3/26EUoMTLPDao6FAmoPpZy
         7UFvhYSvdnAWHwVo99AjiuQXDE1EI0Jzv33EWnNphbS46mihnG4DprlEabFVzrdlen+f
         aON25edDP+3GzOkPufXgVCbACMgnfgE+ijjcTQAV6hpGuhcU6yZOK/4zh1/v/93sQf+E
         d+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jO5jWgaXZa2lsbmKmA57m7CoJZ1nTKNIQoumyTQ7CDo=;
        fh=hNC3CH0eHhWUUyL89m1JlufawEz/o1eXdxLh7P1x8D0=;
        b=HbCSw/KREcvgKTT2Fca/PULzF+9zZNuuczBRLW4cgb3QvX9J7eVpODXj5b17Ki9Fqg
         eU3FpR50KX86UHAEff8lsMW5e9r9lEO5pA1sGuk7RalIksL52KdiGcpeINbspTpf2s01
         ah3mFciP1jAL9KWdyx/f33/cX8rh2c7SBc1sQ+5kid2tM3yepeWFvsFpSlEVxaK4zf0n
         +CTCOr5EodeM/CSV9zZB9uDDEu2IJ5lFbEL+QeNJwKj8V/z721lOv8S2n4aCZkMyND43
         cVJYqjNIUm2KLpyP/eQim38/zh+u3V0Yo/2Y/Vk0O4iar4hRH1UFvjabFt/C6ZYg9yvU
         MlEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560065; x=1781164865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO5jWgaXZa2lsbmKmA57m7CoJZ1nTKNIQoumyTQ7CDo=;
        b=GnOT4oDIFv0XgUaFZnqyAzeyvXrapkb8+kU7Spb7jfYK524IoE3DiBpZ8i1YvaXmw0
         MD2WXjIP42FQzwl/GopKc2JVAuuh28Joq8BFxxIpaFZSvUgBE59EIgnETJGkf+M83Pce
         iE4NMLPfjK4dtS6I9LC5UYEtIDSr5oPrqecmRP/b+9yMDKbfdv5wbh4/CVgCTJlwPewO
         oMUNnw5M3LN3+ov2qeIOvibJZ8COwyLi7q8lOwZhbhgKSB/GN0P2f3FRYPfTb3Unar+M
         tdr/LjAI9HCs8OtyRxVOf0KERW80qNUgXOAp5hcwx13dscFMcmrcTnzE2bf2/Kkm+PPr
         naug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560065; x=1781164865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jO5jWgaXZa2lsbmKmA57m7CoJZ1nTKNIQoumyTQ7CDo=;
        b=m94ywP1z5CGgnzHxaMA8483GnArtXMQ1uuKLCV2yH0riSgVWQKyOB/6leRsriomJ4d
         69UW7goxZtAQafVDaCdDrLT8hMRpOcUSEo7iKBUhzNyYxKx42j/lG75lXaY6R0zq/qFA
         TGdbq59evGJyU5IOK4/idIygco2gEaW+Oz8AlWC/+lAnhMdkTeWw4Tm91wGZ8qQRe28O
         sg5KKH+CymaCf4Hxx23G3tnRdTBWh/4wicl4CiLnNokVzNaF7gQ6Nm86R7jS/C4ckwfw
         RZuhBsvYrJhmFyEI8eBke/DiZqlrP2fpH8EyKldBT/OxgFqEgQ+KcfG//yk47Tv/l238
         zsgA==
X-Gm-Message-State: AOJu0YzzJCjS73NWh5UZeIMmJH0RVkmka4dN3HW3ia5VUrldG20ygxPI
	MXSCmZbbI6FYy1PtvLBBts4xUDsC1ShRbhLa48jaXFjdOrSh5m2oeL2LplgWnQKPviwuNpFD5A+
	wyyKRMgq1qxYolmC78FJA6NEm7pjIqjI=
X-Gm-Gg: Acq92OFnTB/Es8gUJFuBnEDHz7gvazvyXbPJkJtqrFUSrFaTLPgY1vXe6TnGaN04Qmm
	GzSfaldC4XAlKpq3Z4Wrz6QrdpDVwACws/Zo/T/ghUfutrEo6YBPG4FFro/fDyG9DpNIAOY5nQB
	yMrdTrYtszbNoqJVaCb/v576S0GRUj8BTlfgG71xozqJD3mayu+sCtDXQmE6BhTiZxp/WMYtgzz
	6XBayCfjwhBQ+ezPpdf3x2cxyEhQRMLcXgpQ4tsOIKxVXjMEH/OWqplMFcvkEFF3pvmY/WBe9ZD
	TyXkjL0oI9F+Sn0bidP8BhJ3FBP3ZtJckg5L8NVWiGcohCjW7aGcBffFFtofN7JIMnDGU18Oj8M
	cumGSarH0S1gJVg==
X-Received: by 2002:a05:7022:6707:b0:137:c0a7:8d01 with SMTP id
 a92af1059eb24-137f6bbdf2fmr3321000c88.23.1780560064980; Thu, 04 Jun 2026
 01:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
 <20260603111044.39116-2-r.siddharth.shrimali@gmail.com> <2412618.ElGaqSPkdT@piment-oiseau>
In-Reply-To: <2412618.ElGaqSPkdT@piment-oiseau>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 4 Jun 2026 10:00:53 +0200
X-Gm-Features: AVHnY4Jwxus8YyGaYXC4CA2XrtvzW0cJtmC1vMXHLaX9lOp_bOEftpS3ZFP3FRk
Message-ID: <CAP8UFD30eMS_8GSOw9BeQZCT5Xtjw4D4py9fR_JvdBd4Yo-hKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: introduce die_for_required_opt()
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc: git@vger.kernel.org, Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, gitster@pobox.com, 
	toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 3, 2026 at 9:49=E2=80=AFPM Jean-No=C3=ABl AVILA <jn.avila@free.=
fr> wrote:

> To me, "die_for_required_opt" is a misnomer as the function does not die =
for
> an existing "required" condition, unlike the other functions such as
> die_for_incompatible_opt<n>.
>
> The names of the parameters do not indicate that the test is not symmetri=
cal
> (not failing on XOR).
>
> Maybe something like "die_for_missing_opt(int tested_opt, const char
> *tested_opt_name, int required_opt, const char *required_opt_name)
>
> would make it more understandable.

Yeah, I agree it's better.

With "dependent_opt" instead of "tested_opt", I think it would be even bett=
er.

Thanks.
