Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC5370
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985108; cv=none; b=sbwljdVdVJLJ4DNQhg07/HRfbceO7XDFWCf+0ZLG1zz72IjqPBWP9pQhr6FDzqpdk2FuWbWEXoO/dmUpJiLUEClSA8anvOWjwHr2esfAlDgsUPkBJi7FrXtfelNy5ZZTsRR8MnqEe6nqsJ44X0jSGDOLpszCEDpuXYToyufKOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985108; c=relaxed/simple;
	bh=XiqK8QD+tk0FmaR63o3X6ItKdMt+7zr1xaeWA6pvTls=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=U6wgjIgDOb6wYGCpodun1YeJOtz07HP3cXiHwfe+/W8BLFlPL1NY4CZeQ8YCWUTOMslqku2bFKuOv4EID8YTzqeNengvszug6HTS9PX/I23ixvq7yiWfr8tBQvYuLgwYZi+gWAFn//ZaiIS6tQ0KgVp+ugdaMMOvhnuN/gqKMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayfrz3ZJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayfrz3ZJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6963cf14771so4466586d6.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710985105; x=1711589905; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCO2HdOdWCyThE/8i/M29Oa7hk/AkBDxksQ3na4S0W4=;
        b=Ayfrz3ZJF9GetyIU2vwlI7rMhGN/b+3O8jZIq1/52J651zSAvuGgWNUUvpkN9bf30A
         fi5VPgSlWAPBiGP8QpJg9zfm7zZBDJzClKoGmJHKvdJg+LZXcGfXiU+bHr6Og+wLAhG9
         scTvWMhhsjCZb5oSn5GZwSXVPTN3rRzhy6GnmgA6hPLe5sChXLHk6fhY9WlLSW9h3Hxi
         meVPhboXWqKghH7mOJjTiU0Jcgfioj5YkwQivr9xEO5ue7bp9SLUYNm3OzqtZaYfse8h
         L9G+9Ie9pzYD6RO/MWFncZD1xYW7NjSXb8gPfRidfltEmi31cK+6Ha4ZCUnjg4O0/0Ro
         LIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985105; x=1711589905;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCO2HdOdWCyThE/8i/M29Oa7hk/AkBDxksQ3na4S0W4=;
        b=PSbswqMGQNGrfjjzQBKkX+PrIlr3Tngf0SkUowN8oEj27l2CtoMRveF+v6uKwptwYx
         k85lFOxYVngJKzA7BtD2XukPkJnp4VtLYDnMk/Cg45ElhGJ5yh3ha32kBXJglK9MhM9M
         wBaJgh97NuwChJY3NP32wppegMRnRFiZGy5Dk0jhZOD30YQZC+eMVSMYsRDdgfWIBAu4
         GgA7ntNfO1ixO9SEnic9isi8PwcbSIrGfE98LznCo3/zee2nOEZT/YKm/KrmfoiXdx2r
         1Viu8/F5326BMEaFHRNDkCcZGt8zBbf+Nw7wJDEzxofp5tgKCHUo36bIrj1MONq5RlJJ
         +HBw==
X-Gm-Message-State: AOJu0YwFdBlx5jSDIf8ZWKHJ8Fg0AQMFaM9Wucx/GqVFClJV7n0lG5HO
	Xo01O4sh1WV0bIfUl7BW5RaEBoNWVPN1loHPfHAwStS4zK3MsE90br+iJBx2hDc=
X-Google-Smtp-Source: AGHT+IG+JibNJS1t9PpqcR9JtY6DsMD5WQSj7iWK5OeEJfHEN2NwhlRBwGB83l3BXuwdqStfFrBrPw==
X-Received: by 2002:a05:6214:2405:b0:690:5edd:936a with SMTP id fv5-20020a056214240500b006905edd936amr607500qvb.44.1710985105299;
        Wed, 20 Mar 2024 18:38:25 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id gm9-20020a056214268900b00691865eae7bsm6411470qvb.4.2024.03.20.18.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 18:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqq4jd0fle4.fsf@gitster.g>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
Message-ID: <17bea3e3320609ca.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 01:38:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> To me, this initially sounded like it meant "your patch was not
>> something that the git maintainers would be interested in accepting". I
>> *suspect* that what is actually meant here is "your patch was
>> straightforward and non-controversial to the point that no members of
>> the list saw it and felt the need to comment on it", though to be honest
>> I am not 100% sure.
>=20
> I actually meant what I wrote.
>=20
> It is possible that the reason why your patch did not receive any
> response was because it was uninspiring, looked useless, and did not
> deserve anybody's attention.  But it is also possible that it was
> lost in the noise.
>=20
> And pinging on the topic by responding to your own message is not
> just acceptable but very much appreciated way to remind others who
> may have missed it, in case it is the latter.
>=20
> If a topic is truly obvious and straight-forward, it may be taken
> silently to 'seen' and even to 'next', and since it is suggested for
> the contributors to look at "master..seen", such a topic would not
> fall into the "hear nothing about it from anybody for a long time"
> category anyway.

Thanks for the clarification. I do still think that a change in the
wording and tone of this section could help make the project appear more
friendly to new contributors. Phrases like "totally uninteresting",
"uninspiring", "looked useless", and "did not deserve anybody's
attention" are all fairly harsh sounding, even if sometimes true.

Something more along the lines of "Mailing list members may not have
seen the value of the proposed changes" or "Your patch may not have
presented a convincing argument for being accepted" might land a little
more gently and make someone more willing to make another attempt at a
more compelling patch rather than feeling harshly rejected and leaving
with a bad taste in their mouth about the project like has happened in
the past [1].

[1]: https://lore.kernel.org/git/xmqq7ck7x10y.fsf@gitster.g/

Simply food for thought from someone relatively new to the list.

--=20
Thank you,
Brian Lyles
