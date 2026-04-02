Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64889346A0A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112074; cv=pass; b=Bn9y9/NmRSrPD1l9nCm6G5pq7BZOch7/7qF+nKe/p63mxY0MY4XnOb/2q6Z5AAen9OXd1QNfxjXC0dY/1baXpBsqmvZwRFo52jIF8wQQyAbmQuTCMQvJS8wUDTPG0GdZSBRS6O8+dv2kKJ8tcPWe8yGDEOIYK6JSJ6S75ZJnD8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112074; c=relaxed/simple;
	bh=S+16zuMKWNkSkvuOC5WvfjF69fiPQ5oY0jxwIWTDrfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSTeEPjZbOhGEAkKTl8OquVtzNYgtXVsEHwPlmJJaMmgQ/PfU2bJzamAtfMzPNsAoGuvWUZ0OftLr4q4YHzI+jLCIm6VvTmAtTpfrFxo4mufA6/KFlu5Yt6fiMvg/q+A7qro0hHjrY84rn+X+urGnzjJPpKQjf8AFVgGXLPb6YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P80m+Klf; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P80m+Klf"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso765829c88.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 23:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775112072; cv=none;
        d=google.com; s=arc-20240605;
        b=aEC5w9I1EortxLRjmYl+3jUULSZQRZgeFXM7re8oSusJFduLa2Q0DA84ebpu0wixm/
         joe3UCjnBicu2YzejJHoE6OcEitmzMHhoDQNpxXsomx71O7ROJIC2ecZXBsATTrdeQha
         d+ObmM0YGt4178di1UvM2j0q6Kd9ZMIGRaqUx8SLJrXeLrFClklCXmrTdpGJ5yFIHUcd
         +TdcypNFm6ptqrGUJqcdW4JwhlsFJ1F2uS5UGis+UpjLQD7rTtn0Oykw+u9S5/jUMGJo
         +KTbtlILoN6u19bE2co7/SIGNBJnMjX/0w0vZnicNh5TyrfG0+k6PNdlaRmttmF9opyI
         8PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S+16zuMKWNkSkvuOC5WvfjF69fiPQ5oY0jxwIWTDrfM=;
        fh=vgFBVts90qb4ZwUiDKV4TZwc9rP+4ijM95oe6FAMGy4=;
        b=SuZWmnx6yOTfPcqTM0C0cS6c7nThOFQkhR1mUk14mB6vv9vU1sBMg+ceknfCaZF/7X
         i4fNNVyCFyUOZS8LEQgiNdw9qmlEfquzGVHXBtkjh5/u9EK8i32DfEawn0N6fsUeYejN
         I3P/OgFhrSOkQdDd8YXOYFz7gp82muxeXkVxdYkPYquSEqlIuji4i21hXItBOcgiU2l0
         LwVr1axl009a4DZGyyTU64+x9bfzBflRk+o7w2RELl6Ww5qfvhtAa0zaRAE5+RLEWi9M
         KV5kUy+Sh+jX0UHKKZStvvA+JMky4f5UyMKcdl1NzLnfhq9T97ZjJphvPeH1NdQNYdmP
         v18Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775112072; x=1775716872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+16zuMKWNkSkvuOC5WvfjF69fiPQ5oY0jxwIWTDrfM=;
        b=P80m+Klfz1nQxFro6GkvtA2Fj2ohDbGxOwXg2zlcHXvcM64xrvd94k0mhFRHG3+gOr
         yak3NrwRg7RpkLoSuIExxPdrgP/EAsENUX88VjoQ0nPH3pwcZSxtjIYxM/wX6TlNFlpx
         eckoxJALqyodYu9n0Y8SlaYiCLuWTOhxNMVo136UlwE2zbif5wYvKR3wE2ksWhe2HuY0
         WqaT05QvbzB1bIH0UsmL8PXWrblHom/26OL2rINwWLcNpZJIfsOO8qWbWRvFCCy6mNZ1
         9aW3dN+WPeBmuLe5D90G8RKKveS4a9Dw/EKFt3tq4PZd46Bg6nqNL8No4QD4qlfnM/3d
         0pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112072; x=1775716872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+16zuMKWNkSkvuOC5WvfjF69fiPQ5oY0jxwIWTDrfM=;
        b=psy3VAnNJRzKt1zCxEobRPHKbN5G1loHq5xhg0McZB37jV4oJiAJI9XUJ53NRE9etG
         BIYU8EEIU5svwwJrwdZIO1dSKf81MRZ9z/DS6ekVkZMW92xIQ4PzKIyVJv7xqC5MooXu
         JECM26UuH7/0BrEI9SWgVL25Ic66OarwHiLv/FUG50PNQW+pqyxWP08VDfygKDyBuYPl
         78T7vL7P/T0Yh3LKB7wVUoGvIedo/gmPgUcGgNQzB/Y6EAp8kCkc4+zlHwd6GcVsKfVE
         lgPQuEzzQheWXlHTmQC7agM+H9mS6v0AFb2ENILjOVntrwJgbIo5pxeSyl/hXiSubGUQ
         cy9g==
X-Gm-Message-State: AOJu0YzpHuERSeWxvhlMtIojNgo/8SljOciBRuqA+KYd89c7u1TBSrxG
	8T0GGsheuD0YAjnLWPq4Clqi6v7TwS53l0+CMmquMhgy/0XAu90Vp/pkFOraL9MRngJ7h7B/Qt/
	IGiMZoPXhpEPxLQUs5eMnnWx4i/OqZhe9Hw==
X-Gm-Gg: ATEYQzxgEzzcw0E35Kby9aD82T41IX0QKJqhHpO/Nm+8CFAEEx/aIhTn3ymqTF+zGk7
	zIbUKG0K+Fi58yJcDW/XBGP7cN9fo9FCiOFx3lMH/8IwzHdw3B3FHYEziUiDf+dYrSbj3ajriqb
	W2QkzMVTKpBExyCWwDnkLKUg/VOQS/34uhDb0k2BvqwX18XLC6ZfT66eBFeWTTYcx8mkS7fNmY1
	wRkNs3hN4RaUg9UfQqawcT8MMmn+qBPfQTBMZUG4Ejxxbcc+rl6WwGgqBVEXDlT1OWh2lOSXBvC
	lI0ZIY8MCsQbAeeVplp1ChfIfZ37Tn83z2TrvdrKL0I7n3hiCSk9uMZa9XFHewB7VFB4
X-Received: by 2002:a05:7022:398:b0:128:d967:4673 with SMTP id
 a92af1059eb24-12be6442901mr3364697c88.16.1775112072478; Wed, 01 Apr 2026
 23:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com> <acUk3EAcL8-xM4VK@pks.im>
In-Reply-To: <acUk3EAcL8-xM4VK@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:41:00 +0200
X-Gm-Features: AQROBzDTM4RKePjT7hYT0s7cg3Mnd0Wjf-euxvG_uPS4tNbncjV4st43wCbW8fg
Message-ID: <CAP8UFD05qM0WtD+csThQ3gZZ8dCqguzgs0bxT2HAHGHMELLWxg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Auto-configure advertised remotes via URL whitelist
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> I wonder whether it would make sense to split up this series into two.
> The first 12 patches and parts of 16 are all sensible improvements that
> can land independent of the patches that introduce the new logic. And
> given that I expect some discussion around the new logic itself, I
> expect that these refactorings can land way faster on their own.
>
> It would also help reduce the review load a bit if one then ultimately
> only has to review three patches for the new feature.

Fine with me. I will send a preparatory series with 10 patches; one
new and 9 from the 16 patch series. Then I expect that the series with
the new logic will only be around 7 patches.
