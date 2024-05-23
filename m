Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549C849C
	for <git@vger.kernel.org>; Thu, 23 May 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490218; cv=none; b=IkSt4ft3QyVYFRvTsfhzEmhobtHzPppTnNVrfEkOwKilJzXz/jVtNCvKj5ETjoR54sQhFegKf/+MawgDkxpa0r59P9rjkDoETFv9VQdVDEVEiUKoxoGYsVl/9RMeeVfDjMKPx32rdYg95F6eIpg8B9xIzbHUASTpEG35vKYlWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490218; c=relaxed/simple;
	bh=dVVJ1FwyhGcttOYc823lGmkbWNKfja8VblwF2TCTyn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bc6lyLze/oR7paRUhHSrK11eyf/EH5pPZBkCBuokJuK9TgrG3aSfa9PA1TYInf22RgXbfPSyLQhFyGsH+RqmFLuVDwk6gY1HeOQk7vTBczM1YlERryCeOLlyT2yXlqGohkQRYXfL6N0tvLvBNmtD3PHCHm049buhDttN29SsCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ab9e0a4135so149466d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 11:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716490215; x=1717095015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVVJ1FwyhGcttOYc823lGmkbWNKfja8VblwF2TCTyn8=;
        b=bSi9aIEzEmFhSoTDLMN2elSS7ZMac+kjN01B08lQ55wnljXznw6j6nAYJTRb/hLAgo
         1NeoXG1Z3E/+auMpP0vIzy4Dt8KmH3cqLIBS4cBkF+/bSoZrfTVJMd7DFmX1HDhVII6l
         ObRxmTMTCrHbdfrXa1fjjPjmrY78E7y/8gavz1wwlrO6PGchBO2r+905PgHNS6CuvLPa
         01UwWcpww8kdfPyyNkusECE6Cd1oRmu1pHb6+to18mbkH7xPm3xAYOE8yJ76Gv6CfLaa
         XyIEhLiD+PCM7uBhqgzTQswIj7iwo0NcUfXmQhoi1XM1KZt8l5TCnLjFOP67GnHXVNIm
         YKug==
X-Forwarded-Encrypted: i=1; AJvYcCXy9iAPW/jJdxpZfXjiOuRCnJ0VQ4ppzzBw+JEHC1y0Gqv4pHxejsXHdf+EcvueThGnzShmAF1BF1IARN3Rdu3n6DM+
X-Gm-Message-State: AOJu0YzrLX5aGLeju9MxkbzVFoJEZMtixi24PLbbZuEKIBVJwH8qWVLX
	HIL96cTzNXZElpmfkWzeMpXtwJokQwP0zzDZOVA8b+cbFJcQAQnxoPRXTBIWxCqnd2SnGBZJUm/
	z0sRwhfbDQfNEbttxaa0S71WPIzJsSxHu
X-Google-Smtp-Source: AGHT+IGYM65UvPb40btS3byMLUNzeECwYzTPCjCfqBv2A6nEbNvCFf2WWXcvPVzH892n/CNfJRIUPqQHVUagxdKKicg=
X-Received: by 2002:a05:6214:246c:b0:6ab:7b70:923a with SMTP id
 6a1803df08f44-6ab8f5eeffemr57695996d6.29.1716490214880; Thu, 23 May 2024
 11:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240522090326.1268326-1-knayak@gitlab.com>
 <xmqqbk4wy3ji.fsf@gitster.g> <CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
 <xmqqr0dsv6e8.fsf@gitster.g> <CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
 <xmqqo78wtn7y.fsf@gitster.g>
In-Reply-To: <xmqqo78wtn7y.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 14:50:03 -0400
Message-ID: <CAPig+cT71R1qYTkshvQNpOepOskz3LNDCc4eiih-8H9LDJmf-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Thu, May 23, 2024 at 12:29=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> We may want to teach "format-patch --range-diff" to place the output
> >> of range-diff _below_ the list of commits and the overall diffstat
> >> in the cover letter
> >
> > Placing the range-diff below the list of commits and the overall
> > diffstat in the cover letter is how `format-patch --range-diff`
> > already works.
>
> Heh, so what Karthik was manually doing made the cover letter harder
> to read?

Apparently so.

> In any case, that is a great news.

Placement of the range-diff in the cover-letter was a deliberate choice[1].

> >> (and at the end of the patch for a single patch topic).
> >
> > This could indeed lead to less visual clutter for the single-patch topi=
c.

Regarding your experiment[2] to place the range-diff at the end of a
single-patch, apparently that idea had been considered, as well, but
it was noted[3,4] that, by default, some MUIs hide everything after
the "--" line.

[1]: https://lore.kernel.org/git/CAPig+cT9zCcNxn1+DPMQWqJ-hfxb7gE7rKyfbqHjT=
C+FDNY_mw@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqh6ep1pwz.fsf_-_@gitster.g/
[3]: https://lore.kernel.org/git/xmqqmuupogei.fsf@gitster-ct.c.googlers.com=
/
[4]: https://lore.kernel.org/git/CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=3DM0cNR3L5=
UJGGC6vHPDQ@mail.gmail.com/
