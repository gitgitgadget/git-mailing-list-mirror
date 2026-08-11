Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770840F744
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443189; cv=pass; b=gvC456G5DxERZ5S7NeMY68wNb2uyMPAsfQaQ/14PKKofLaP+78JUeUplTLZuHTptk+W/uVAjGyz68l46N9R+gyR19gNKGdZVdEO9CS2cEYlvIUt9k0Kot/U258GWCcdG8nEggWb4o5RhW7Hd3mYpjH6nAQd06OikU3uXDpUkT2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443189; c=relaxed/simple;
	bh=sPFroW25s6m/P93sjuuPHzfLIGQ9ycggOJ8/WMlKO2I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xstr8tIffrbYgWG+gFF6VLnT5YWJrd4PEoGtBcOHS0/O9iZhKe/IzZOIfGlzW5GlQlJlYxEy/qRoFRjoYZHLUBo19KdyNLIbl2AgXm5s76Ch4ET7hHF/eIKWCu+qQhK/+d/v2ar10bcmOuKm0dy4LFJqY62pPGmS1pLvHTtPawU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ0pcgZ/; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ0pcgZ/"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9770fffa5a6so596796241.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443186; cv=none;
        d=google.com; s=arc-20260327;
        b=XlsGAsxko0Z+Ydz58dctPHHIXkxLZUlqXD8uxuGxF0tRYRx6f8/kxCm1AF+1SETqYY
         RvVAFefnwnNvle1Ig0ApY9XUXSF5Tss/NH8KgFjFhU65H5qnyESDkzSUrF4LXp3wYBY8
         I3MREiRXQGn4pILa4lrmq8ZyEKkpAUhw6cfdGYi9ZvfnppEdH0d6H1LPN5sr+iN+nBSr
         Q8tltbeWGiTihHgm8fW4PoynomcMexWPCodKrID1v+862ZUwivJl3DdQ5fWy+gTFK89j
         opujDPIhGc76+BmlqRzz52IV+pTifvYXayEzpvcncL7tzJU7myHXs6jt+hax16fU2r3O
         egYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8R8CtXDMT8PxVx/s+QW1wQDzdqRxBKEnN35Snv/6ueQ=;
        fh=FZ40bQDVhB/b4NjtEkKMeusRLohQ8TJT5gy21a2AUAw=;
        b=gcUrvkBGVZLjS4GfzOOwwC5GBlbS52vBvWKFnqCPm8cLTurRV0dUtvGMEYdBsdwY3x
         aKdS7pg+OxIdMLMqxlVQnsU1MWcXf0/Y5v7ATEpNG/sri/OhM7MWYx9MVlU3JI9fp+b7
         P1R/j+lwT6ewGGeXx+m2W9aTd1J0aRHpIDbmQxgn8Z+nTUMbsky+XAEAg1dvhfHIVh38
         kSWvS6MvEFWEfdt/KpZqz3xiLI7c6nlYC+4LPs9gI1MciATMAMp+6zCHQ0MvBrxoDnwN
         x+C4cZ0d6msjhEerO0Vk61ZoQZ8iKkcvyczMl6ho4ZLvRiFglssax9ctyfJPh0CJ9fWT
         WzQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443186; x=1787047986; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R8CtXDMT8PxVx/s+QW1wQDzdqRxBKEnN35Snv/6ueQ=;
        b=KQ0pcgZ/FdH8m6E5Q2yZ6SQtiUnEZNRZ5gR/ksFsXMJgB6tWnIP3YBfrjdKrmTH3Rr
         i0ujVJJ8TLrcPaMpOV/PxDorjCG6KFjVGbJaWnDEyZUjEmsGWSEsjKjAfVBCCb9NQwZY
         F7wJ1J2u0BKgCxkPGHPW0UOX4hh8Y/AYEtYRoOUC4CvcrZZUxLyv4WJbd29OJgBq+CRu
         8sq4hmPZTNbwPM1hWLag9/UfnR259eCvzzyOR8O5QXe9jMD/47DpWIp8MaNlPo93PBko
         klRaHN71wDt9vp4ItqX6CSVs0giFM2vwhfYkHbj+kC8cE1fYFPKBOeEp75Vf/3WUYXIQ
         0/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443186; x=1787047986;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8R8CtXDMT8PxVx/s+QW1wQDzdqRxBKEnN35Snv/6ueQ=;
        b=O1eUNLAT+e14doBqp2TsDVi4a1GwmwqgVxo+alMMJAFc3nwrYhLySooHOgOGSfC4Og
         v5YMlPJKa7aMwYHiRGNynjbQiwGfqMMZ8/xSsJ274c6vh9ZaYmrXpZAKXDsmy/WrLEFe
         vhWd2/TXHHDCbxhThFfTDdQsTlOQ4Ps9Iwe7rUkfSi9W/Ce17+MwoJLi3b/gseC9l0iL
         nYffWKLsxypP7PfOG9or7VLT57gzhauUpUU/McfkwzDVakrB5ytbQ/ehGjpMJYLU7ZKp
         pViEG9ZGObrkXvwXSBwhzl+g4gKj3zvbpGziqXwCCdBsFKUoBWUZ7HKGqWgM+O4YxerX
         3l+w==
X-Forwarded-Encrypted: i=1; AHgh+RpEdnDIxyTi0kTRb9MRcdO/Mn7lYaVelVb403qJ3U7/SMC2Y+cIzKJTQL9MNN28mzFR8lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNkQUCjlDGAEPU9q57+Q9aV7NGoiK/seyAILWDnUvFoMAIGMo
	aTQBNgwK2kBOpY/+nxKak2gKpfbB7A9KPXcA0ZH1fui8AX+fzAG10Enr2vOW4zxpx4QXek4dcPW
	8iXxXV+9emeG0btes7PpBN6MymlhBNOE=
X-Gm-Gg: AR+sD10gc4cAecTdbZwxx/ZRcLYSNzlVLdW1Ea+9crJ9BsXbTaCCttQV0LRipSYMhcg
	v//0raL+mo8TpjfMM7nkrlNNqtmiOHDWiewpYt8M4N725DPLYL/HjyMbD3f1Ff9542mZia50oYm
	WOrAO6YEJfDOfjgemFKQIAdAS3NR6pENif6aRkmhFpf9NSdBkz2n+0o0adyjI42HYA0SW0TWGNf
	ZPOp6Z25f1Pvn2S4RGAH3TX1JnwVUJeoz0K5p5pz50sYTeajiZqVaFH8t01N3c9JtOZgSDC3Bxc
	ztHtwhMPDBR6Td9wpyTgH3aWVx3wNwX7g3sI8mLmLb/OBqMpyKDMG39FRO/0HNtxgIxPKbJbdLG
	psKUd70GGDYvCFWQn3erOGypJS8tWX5b9k3s=
X-Received: by 2002:a05:6102:1481:b0:76a:fcc7:ef40 with SMTP id
 ada2fe7eead31-76b5538482cmr472254137.5.1786443186492; Tue, 11 Aug 2026
 03:13:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 06:13:05 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 06:13:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im> <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 06:13:05 -0400
X-Gm-Features: AUfX_mx4HET83Dj08uo7bxeTtbse8VUF2uBDNseDhKzXR6l8wfAdtoKhm3Ijy0w
Message-ID: <CAOLa=ZTtn4kpQq6H8gJpEnC9RRbb=eFgKjxGEQyeJGYr5CcW2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] odb: unify read and write streams
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000008aeea80658c2b718"

--0000000000008aeea80658c2b718
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> we have two different kind of object database streams in our code base:
> `odb_write_stream` and `odb_read_stream`. While those are used for
> different use cases, the provided functionality is ultimately the exact
> same.
>
> This patch series thus refactors these streams so that we have a single
> `odb_stream`, only. This allows us to reuse the streams for different
> kinds of purposes and makes them more generally useful overall. For
> example, it's trivially possible now to create an object stream for any
> given object and then write that stream into a different source.
>
> The series is built on top of 5b2471720c (The 10th batch, 2026-08-03).
>
> Changes in v2:
>   - Use the correct object type when hashing in-memory objects.
>   - Remove a stale comment.
>   - Adapt a commit message to mention that renames will follow in
>     subsequent commits.
>   - Add another commit to rename `struct input_zstream_data`.
>   - Link to v1: https://patch.msgid.link/20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im
>

I went through v2 and I think its already in a good state!

--0000000000008aeea80658c2b718
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 28c3994b52f2b826_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wNjlhOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUtoQy80cnRWRGJ0Yk85eXNsdHBYSkVRaStYZGZlOQpGRVBrSG0xWW9T
RnFMQi9RWmRxT2pZSXRtZXR5MFBONThPbk1vdy8wQzBidTJpWTF3aFBUMWkwT0FNOEpFOGZUCjlP
OStOMGdhb1J4WVVrR0VrMFY1ZGMxc1ViWDZDMUNSSVFnVW9VZjZ1blhycnhBUGcwa1NPSHVHVC9m
TGNxMlUKMVlsdmxMZW5VajVjcE01eVJHWldVVzZuQWhjSlVqRnF0Q0tvMUFnRUR1OVRQcGxjUFEy
L3VFa2F1VFhEM25YYgpmbFpaWEZ2dzh2bTF1Wm01bkRONGo5WG1rUTNYUW42UWh1bVhjblhkY1JP
MzcwV2xMczZwc1lYOTEwTURKSlM1CjJPeFdHaGpjUzF6dmMwVkY1L1ZUUlZBSFEyVGlDRlBLS3I5
ckZxaE82cE9id0xGWk5Wdng2Mnd1eUdldERvQWgKL1RHcDNYQzMxMEx1djQ2TG9SRk14c1lQRU9E
U2x4OUZ2bEVrZTFjSzNBd05DYlV0SU84bW9kRXZWV2NoRzczNQp4NnlJSUdtdGJhT2lYcHJ4bWNY
QWNNZDBXcGQ1dytUcTZFaVg3UXVONHB0bDBSeklTNGFLeTdxSmRxaTE0b2RoCkc2a0dtWHB4SUJz
MU13cmFnbEkrVzVZbC9GeVpyRjRqdXJwVUdWYz0KPWd2UVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008aeea80658c2b718--
