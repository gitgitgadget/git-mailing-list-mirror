Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184B40759B
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133301; cv=pass; b=bs+Ihl/HFVp6zCMpfX9IMp6UHKHdBj1y2+B/b0iKfxlq4HE7StQS7mtZsrc7pJ5V9Nx144XsYUzDlWHDkyiF0YLSKPMBe/AaBViAdk/9osz33IpIjmfSLgwlAXkyV7mRAyUzXOvh3CfQhcbQv+K4aXj4NTFiQyrMZJBHAXFr7Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133301; c=relaxed/simple;
	bh=PKg8sCLGZRIl7kkSVzvq4RZr92A6tP1+neYPPD8goCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXJsWJnVJ1Oxp1IHFXKhIF1Z4VmhXWwOK1vR5tygjYiEZM+t+Q74cSlh8It17NRyB5OjxVNexdIYCU8udRESQjuuz+DyGDh8j2ENCoeSs5XDDSOIMI91yF5DIcb2P5vBHdu9lVfk9sO28w1O/30jqxB7srmQPSsIEATS3hbdmgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6kHkeL2; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6kHkeL2"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128cc4b4b6aso3290982c88.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773133299; cv=none;
        d=google.com; s=arc-20240605;
        b=OujhIlJT3pC8LU3mnXqm31xhbOXe8UNcnUb0wwMkVxgXb+DnmQRVft0lJqlEdM489K
         04YR56bxXcfOJTdYufLDdZqhHcS5LEkIwlJvELD0qHBPvUrtNFzpI2lWndm/LoFETCrB
         4VzrGnrY7FFlUtLbGoLq0AgAQ26EAAeUoQrW07xcWtK1Xt9vPXFB1OOU9jNFSlnbymgs
         JLEE04YOh+XlyyBNzuo1zdEnTMMUiQge3kXlGPtZFOgLXCt3Vyxhk6sZf3TS+AEvir2T
         3NpnNVT8EiEjLxXVUuwVao0sx9fCRvVQfUixCHhzwWYhVBc3eTp4S4KaQdY+q3FMWG6E
         bA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PKg8sCLGZRIl7kkSVzvq4RZr92A6tP1+neYPPD8goCs=;
        fh=nVu3zMpebDzg1Ff15F5ywHRoIXsUIo/ckc17zpZE/+M=;
        b=D2Rta/4CggaWTq5kFTHRYgCs7BfdZA/ZnL8s18kQhvIttE/EimgzSrdy9qi/z41ego
         WIc0xENJv1l9zpvFIX2pM4Iad6UwYjOPzMUWuheUZaRegXK6W04fLobh/+0D8I6AwUda
         BWD/nLQc0x8b9OxUfnfXJ8Z2OpVIAzHCYeVOU3ljkKSSWMqIWLGbWBLk0nc13T6QW+hr
         VwCqQk+CLpSncgIApXdsfV/Tnwx5G7WGJ4iVLXjUoBMBaBo4MTm28aMTbhu4drGFiruy
         qyXhmvG0XoMF9stn9KCs1eydtciZHeaFa3udv7EKew+Wrw4nqSJSzlwXliyy/b4luVYK
         tFiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773133299; x=1773738099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKg8sCLGZRIl7kkSVzvq4RZr92A6tP1+neYPPD8goCs=;
        b=V6kHkeL2k8keCKW/0yErb14HKoebK/C10ek9nbrKcC6CyG0tAAlrgwNJ5kQu91NUp0
         JUZs3QZCCFU0vCpjbgqLNUiSEU+obU2TqKMjf3uJPhA85nhYCB4AeuMQlUYdzUNwb4Ob
         xPHR0Z5CTHGpr4CfplGaYILpanrrcD5lFelyPXN6mL9j9B2hGEK+ejE4OWetYkByDUEf
         pwUxDNRUrPvA6hiVa8C0WS5HMYebNb3a+tle5chNTnXMgZgqkTiIm5VkL+vgEA4X6z4e
         KLphxkBkqXyTzlQZg5kMVGxDYehZwVeqbNyRvwNGoPFJdpUy3xQUEDDh+h4E9ipYt8ja
         wXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133299; x=1773738099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKg8sCLGZRIl7kkSVzvq4RZr92A6tP1+neYPPD8goCs=;
        b=k+iaJEhqRFC8nLlbgn25yaypVOluPfeJHHUrcNoNqOgVryukQK1YfWydYLVTnf5bUG
         AF7ErWTD2EcrjHSD6LkNerGfFLSLyjQS47z/gP4TtFhFLPxZP4aN6lvFk/vAVg6y+D5Y
         St2VwuY1PgRHJpyLCIJXxe9g/rSo235fT50tNPegllzuWyrnTrh+uRHXKexjbZXdYsyc
         cPVoKTBmCRUiHbkMfisQ6QlShIa1ybxPnQEsS5hOerPe0Xqv/eEoZueb5yvTkx9LpC5c
         wN7tS5/dWm0XDRttVM7ueSroggPnHSNr2yHMCTuJLCloNW1c8nrOW/zuU9ZhTStYXI17
         7m8g==
X-Gm-Message-State: AOJu0YxfJBUzTbtrTn6lduJ7LGBY0uVUOpOlTPYt7OFcqz40ky1UnRgr
	QqD7l6vMkgT+wNlqFwfDqc9omi9LqhVjeG5qW+R//TLtl26OstZP0UXwLqy+kOIo7hDUqu53lOh
	fz3Gmnl2bThcCxT5bjZXD+H9KjU+yixxGbYLh
X-Gm-Gg: ATEYQzw7rxeXzUSYXM5EPQq95KzS0oPWd85V+ycU65EDqy7GYCL65JBMub7eJP1+eHk
	8HX+gEOQK7+rCgtDt71IaOMa6djXROu3AGLeSGiuAdsRsPGv69eDr5mstcNg3tGLbUIx5s8p/4I
	CGxN3ugm/ZDP2c0BY4B7YLZcH1vX1JqrMriPwYoM+ffnLR8gJJebv+P07F1I0KTgql1vUnp3Fiy
	dfKdyi62Ua3tP+t3+0SnRbMXiVrkGyNy0GAonU1vAlvjEQMsW80unoskxxf85PsdPA4+DRLAtxx
	iudJp80qpz22G9BFoRglF5C/qyT1/98OqXOAOt6SHWkOZ2S4UCoF7aPl+eog/S1KObDR
X-Received: by 2002:a05:7022:f83:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-128c2e43e2emr6987274c88.29.1773133299044; Tue, 10 Mar 2026
 02:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223194146.3476768-1-jltobler@gmail.com> <20260306205359.1723254-1-jltobler@gmail.com>
 <20260306205359.1723254-3-jltobler@gmail.com>
In-Reply-To: <20260306205359.1723254-3-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Mar 2026 10:01:27 +0100
X-Gm-Features: AaiRm52jHcedjWr4TpykSZW2UTc4-9QyxSHJwlOGQH6tFcyciCHDOEv1kSF2dDA
Message-ID: <CAP8UFD2F-81dwyOP8iMqQq2MjQ0GN-92ZyACSzbk6f7cOQAmTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpg-interface: introduce sign_buffer_with_key()
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, ps@pks.im, 
	gister@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:54=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
> logic to get the default configured signing key when a key is not
> provided and handles generating the commit signature accordingly. This
> signing operation is not really specific to commits as any arbitrary
> buffer can be signed. Also, in a subsequent commit, this same logic is
> reused by git-fast-import(1) when resigning invalid commit signatures.

Nit: s/resigning/re-signing/

> Introduce `sign_buffer_with_key()` to centralize signing key resolution
> in gpg-interface to allow callers to reuse the same behavior without
> duplicating logic.

Nit: I think it would be a bit clearer if the change was described as:

- moving the `sign_commit_to_strbuf()` helper from "commit.c" to
"gpg-interface.c",
- renaming it to `sign_buffer_with_key()`, and
- exporting it (so it can later be used by both "commit.c" and
"builtin/fast-import.c").

Or did I miss something?
