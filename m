Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA13EAC71
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930798; cv=pass; b=O2xxFlvY/5QRMru/Wqb5p/QZ9TmnY9DO2w72WMyVX8BjPvTRlWpQwpau6n4ycFComBEZWnw2ZiRmq+hMYgINi+5COvuahzcub4iwwx84dgb9PAO9r8rIQeX+XLEP5RXSMEC9rZgKMpw1bayilpYC1/m4hmTjn4eohGmu4ZaMOiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930798; c=relaxed/simple;
	bh=rB9A17KQFpZ2UTEtnRbID1iqo7dsbXwFZwNF9WN1M+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNMrtkErXYDDuw7P9Tey6/VXJjnXbkHDF0H03eQ/oApb7C7G8GvWVce0E6KCGj50xrbrP+INqLYOX01JQ1eqUcN0O+sxBfdcpz3YyQMuuYbqRz9XWnGWWqdnIfffeREO+kXbQzVf0ZAUhhFZVx+rlNNQ+qu87uMnPBfZWNeB52k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md7j0syu; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md7j0syu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4609064a12.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930794; cv=none;
        d=google.com; s=arc-20260327;
        b=Zw/xIdoF6uZcLSTBR+h0cdhRX6R8YwJJQp4lZ3MGag4KFa4L033CRbr0Q+NObyuNce
         EjCt1Qyel0E0/WZbDZg6p9TIa1dOZmaFFwNQYpAOksscAm9NRcZ/nc8yvfU34Em0lyLd
         whFIWCv4DN469LNsHGd5ov7OAJ1HvOX+wLDduq3g0l/1iiTbmMde0+XIPDN8wiEedfcY
         3bIuKooi/xHjUxzcy0pp9SWxSRW3YkLL7ATrWZrQXFIuP5kY1jm3pXHGXsEvZHirgzAu
         PYUuNZKggGlvEHZO0jCWAbUETElK2XqtqEIcT8v4bkJ+fm6yL+DhWgti5ZVa6mbdlo54
         Oz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rB9A17KQFpZ2UTEtnRbID1iqo7dsbXwFZwNF9WN1M+s=;
        fh=hv86tS9KzE8Kz4f8u4dZlokELkq6PSd3zKnHihZN1As=;
        b=UgdtQ2cX80Bm/2QJGh56vfSb0cD7Aq8w00Hm1DRUmuCiQXKOMaKcYBCX8qm9Ew5b04
         8+tdTrt8UtOcxqzRP1O5B74pTWsuWwpEGx4Gd9rGX0GY2rmg3OVnFJSnSUpgKG8xNb3H
         Twmwx1dcH1c8Qz+r8qqBeAFNxDIjrHuUMBbD9ecAgE3SfgcdnfzjjhpIyCK/FCWX2k/Q
         LpIPet6/BfID9/NOX/pTNdk1tlNBIk3BfSGInRCkzyfiTi5q4mgKIP3xSqlR+DKVIFxp
         DlwfJS54aFB5l+o+EQ53dzpFLMQr8KHe8xCaxLVAitWi3kH7pF6NsZuJxdqxM8vjRg6c
         BtOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791930794; x=1792535594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rB9A17KQFpZ2UTEtnRbID1iqo7dsbXwFZwNF9WN1M+s=;
        b=Md7j0syuJUCzeIvhpxMwUR3im003N7IL6TZgPY+d24+kclhE2qLJj2BgMF4wZ/JOPZ
         K0ad6sRLG2hFaqXCQ4zhrMRY2mk3k9n4oXkwJ2LA+2ewrxnfCq3n7wBiYoqPduqca119
         Eh/RU5i4swIEYkZtSkMrSq7PYvvYG7dwGnulukY9tZioopAMsAfQWu8ZDzx4p7359YQ5
         AJbxEz0+tn28QDfCFzGMOxJlQulIBx0Pwr0QLXsN8iegz73SjxEs439I73jAkUKrZgTg
         qZGXWi1TQsa19ndOP6fyIbF29ve0An7M5oJgLjd9EEoxtp1RFNbnivN/xM+T87xNjASW
         rdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930794; x=1792535594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rB9A17KQFpZ2UTEtnRbID1iqo7dsbXwFZwNF9WN1M+s=;
        b=z/CtP+BpjO71s0a+C/sDDtBSvCTtw9+lSOLEXa7o2c4UBvTBb/apntbwHJTot/zbV9
         CyXvcinpVcUIGX1zLHPxlpznCpMpGxvhQHb8sMrZGNEnBIahwuw/E++x+uQRCVO6xYhn
         PRBPlfrDU0x4u+Wr1Mm2DdA/bOFLXrtSNX0AyYgz8J10gid59gPhWXM3RRstbBRWAane
         ll0KDPxBFNlDN3H4n2lCloge/vbmW0gEabFNKtoz1xK1h8hY79XIdrLPvTt3L3/vjBWi
         171i8SU4fE0vE/igvFCvqCpu2fgyY4UYjUAycEXtGNdyvO3eahMjuP0ws3OcG/lnfW5X
         6klw==
X-Gm-Message-State: AFq9FYJy1FGYDtseI/PdA1LPvuIQECAyELZeKh1asMeQCwcaul07e+fY
	EOLZk/CARN9W7ENkQgCnCBwnl4HEwPNj6VsBc/KrExqiMNo7VVdVTvX5rq6X73zbx+b3EyE4DxB
	j6sVKTjFmygigEMZ4vkNZe+B6UjeaUYo=
X-Gm-Gg: AYBFou1+IaQj45VSKQ8x1gH8Re2QEGwW+0YXYmk9hMu+IYCw/J8PYFdfIr9b1uZCdOx
	qyas8EvGnctbT9tJxJUEYXEhRr/qi1Bvn1UgoqSj6RGWm240FNJIqtNxfmav2uEhA1ap5/7fBwQ
	gY6AxoQR0iF1LzA3Nv5ZAU4w7G8kOuofnwn+MNN4uCsDrYwaIZPnoTKZB6GGotzx1bR6Jb83etv
	QEdHZFexgKfX2X9wnE4PdEt+nvhCV6xdYZDuXTHTrkPlBIfE/SmWQfulwWuP1Mp2fKVFYExDrpo
	gwBxm/DlGSOCoKbzps5MyEK7dpxQgBq5W8M4jQzY1D0ApAYkrLwAVd88EcC1PaRfYDwYrCDgHHo
	SAOMk7Mb44tWx
X-Received: by 2002:a17:907:c0b:b0:c29:5215:b2d2 with SMTP id
 a640c23a62f3a-c31aa016eb5mr1424880766b.23.1791930794181; Tue, 13 Oct 2026
 15:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
In-Reply-To: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 23:33:03 +0100
X-Gm-Features: AclHuK9GWHxwVO9smR8T09WDDKzfI6fLSsQKFLBsrqOzGSYaxHc_yYp0lQ1clM8
Message-ID: <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Priestess <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hello, everyone!
> =F0=9F=99=8B=F0=9F=8F=BD=E2=80=8D=E2=99=80=EF=B8=8F
>
> My name is Cynthia, but you can call me Priestess.
Hello Cynthia,
>
> My pronouns are she/her.
>
> I've been accepted into the contribution phase of Outreachy December 2026=
 internship round.
Congratulations for getting accepted to the contribution stage.
>
> I'm interested in contributing to the Git community.
Thanks for your interest in the Git project.
> I've just read through the general microproject information documentation=
. I'm going through the materials for developing git, and I have just attem=
pted to build git from source.
> I hope to get started on a microproject soon.
Yep.
>
> Looking forward to learning something exciting!
Definitely.

Thanks.
Usman.
