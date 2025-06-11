Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8652750ED
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668728; cv=none; b=gKlFVLyjWzusc1gfZNndSG1dVXstQkpLDbpYJqgbyOVOJOl3Xc46mqONND1glqkFe4HHVIRzUIISW8zjDEqS1wZvwHZxsx3eor4wSP250EgstHAQiq7TXmeeuOqpMAg/m1GRg2j4CSIHpJQyz6w37zYlOS1c18xQhSeKHwpFPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668728; c=relaxed/simple;
	bh=fb2y4DHwz87Q9hvhKxUdi68diTTjgMgSqLCCjZIKVnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFhqU3Zfx9Loy9iW5zLQr9nkpCOV8C/s+7zg6hOFIJMUKBXAUtdq8VAhMRh6NDovDTxNbvvxqRVezPNSDdRdET/cVuBtfUx4IAV/D8CNGOQFA9ocPLPHJ71MSUbP4vjwvuSEUmzSX2Hq6YbYOOxf8crERk0ZrKArH59Ci3LyOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so189576d6.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749668725; x=1750273525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAZvpRWVQ7xfe4tqLFJ7WMc/6Igt8uT4K9AfJL7jdEc=;
        b=b1ZP3TtRinEt2WVqOhTbfxo4TND7R38BiJ/lRsmXvbvzvlG0tKj6YU2VU87ITVFFin
         pl5SwhEL0gI34nQ+60n7FGDUc9+4pvWaPlM8b49VHBhMerECdWDJLFgrHNvSDLsE8oB/
         aGeUCFAbGwO7HrFpIZ/GMaQFK4rWD8aXqAKp88SK6AjZx3WrR+SBwPJikhSZJPacDo2A
         NQv0qmI1Jgo6H/wt1gdWun8eAlxSpIophsuN19VWW8T5TVMvyX6MbZ/Dzpg9FSmfvllN
         gSH2AuI7O+9kaw3vryE8tbd5e4X1EUudJBWh9glOqwwGaSeGPJiGtGorqJJIuu6nEpUy
         o8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVESRLpdYfRbSDd8Sooke+nsarjmbUUFOg73zcZ+B3PBJQYePK4N25O7vIWu0IXU+4bpUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0lpx1i0l13UZE2L4dPlLmPBDMzEWUSapThWKaBPf/zFQl/+b6
	v9hpnYJp49DrhvE9AOdDEdSvl0S8Sokv3brFzzuNo+BM86eD7BaYDxamhI43oP1rZAgosVojkrt
	bUF1B7ZfUdoYFnOH8xJYdksclV4rHpBxpuXTW
X-Gm-Gg: ASbGnctbhz1P4tyR7xrN9RJZFt5uEwndT9ot4wjaF7Tg/fEH5BoJsDnfCqso6dAmZWe
	v+a3lzUja/cO29MHOQzWeFE5u8+ylVMLKrQQZS/K8awQe7zdbiPjEkeYf2fFDH+NoK7+1U3KPYy
	tWxPWWG1aPQ+4eyiyuv10HFfw3AQep0Uby2gKkbo/bx3bufku/tx4gXPez0z01weX/K+DTYF5yD
	nA=
X-Google-Smtp-Source: AGHT+IF3qrGSQD8s90p4CwPCRJMKKX+l+8CBM0pt96LIDvpEB05gNCRARbKAWnzAEbIAl1x6KL6IbibYQSaGMS84neE=
X-Received: by 2002:a05:6214:519d:b0:6fa:cdc9:8b06 with SMTP id
 6a1803df08f44-6fb2c3296famr28414626d6.3.1749668725323; Wed, 11 Jun 2025
 12:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611062643.8639-1-siddharthasthana31@gmail.com> <xmqqy0tyi8aj.fsf@gitster.g>
In-Reply-To: <xmqqy0tyi8aj.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 11 Jun 2025 15:05:14 -0400
X-Gm-Features: AX0GCFuZLOTMElKFUKYSP8k_frpmHMaILdATGjfPz3_RjtWBrqEC-OOwHpWgYyk
Message-ID: <CAPig+cTezW8XYjNo3L3Qy+f+aiCXppTj-Z=N0bBMG8mp9jJ8ZA@mail.gmail.com>
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
To: Junio C Hamano <gitster@pobox.com>
Cc: siddharthasthana31@gmail.com, git@vger.kernel.org, 
	christian.couder@gmail.com, viakliushin@gitlab.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> From: Siddharth Asthana <siddharthasthana31@gmail.com>
> > +     sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).=
*/\1/p" log >actual &&
>
> Perhaps just a  matter of taste, but
>
>         sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p"
>
> may be easier to read and more portable (as some implementation of
> sed is picky about semicolon concatenated multiple commands).

For what it's worth, Git test scripts already contain a fair number of
uses of semicolon-separated `sed` commands, and we haven't heard of
any problems with them; not even from the very old and quite picky
Solaris `sed` (or was it the ancient SunOS `sed`?).

The only case I can think of in which there was a semicolon-related
problem (and perhaps what you're thinking of) was when a recent
patch[*] neglected to insert a semicolon where it was expected. That
particular case involved a missing semicolon before a closing brace:

    sed -n '/ version /{p;q}'

which should have been:

    sed -n '/ version /{p;q;}'

To summarize: Using semicolon-separated commands is safe and portable;
I don't think there is any evidence that doing so would be
problematic. Whether to use semicolon-separated commands or multiple
`-e` arguments is subjective, and I don't believe the project has
expressed a preference for one for or the other.

[*]: https://lore.kernel.org/git/CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ=
7aC+1tGYw@mail.gmail.com/
