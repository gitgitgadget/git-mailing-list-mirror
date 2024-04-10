Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B515820B
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744159; cv=none; b=C9hS9d0pZlQX3KdR6HyRfN9lIn4QknO9R4EXWj2pLvTpt43fcMP7T5q18aC2XzdrvgN87ktY4Xt3MK7ZE9xE+S2IejMyKksjivuaSUI2ZwuOeAzGPSHFRXb5jeIDVGjpENevCoSKFNKFgtG0vzzmX4qmjmhO7W8srVeclzQI3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744159; c=relaxed/simple;
	bh=tRCM2utPFZU2mjKjltZvhlYuKwzX/cdYbpFRA6WC9jU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du3WWHUruqo/Q0WTr8BGHJkQDO7nM1vNXxvSBzMGV2f4lzR/9URt7ju8hyaV5WBaf5Cheu+zz8u0ODZvOhUE3l1iSgu/KgN8BXco6/CY4xgUlD6gOAh7NNqRAwfvc3Hu+ylcEwRmL2rph1e3XlFYc6o1fmOoYnlrAMFHZbeW2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5geQax+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5geQax+"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa369179e1so2429167eaf.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712744157; x=1713348957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJeXAlXympZ3fGNAigYcYIKbq79Uk9zmaGjanfGy4uc=;
        b=S5geQax+YEkDkldijF4fzUeREqsRUf50i6cCMoFQuD6LWwHT7VoXKsuFB9sM9Mdbkt
         E1u/Z2N9Rm8YMhHa+9D64jo2BykO0jWT4dFhNXRWiGQPtFEB98cLf8mz1O2XycQJYDjY
         lmmiJyc5IvgKcKa/BDtwwfElRBNLzbcMMmO2UJibW6M8ppCUOlB46k/N9yt9Nv+WhRHe
         OuH9VXXCnkzGNOnLsDdKqXoAcc1i9+0Nano8rtqNy0sKui3hAVgHxoawWxWxSiDPAUqg
         rur0yNHl+oLaOeO4ZNiH0EZruIlBNwzQWcr7jguW7ERx5WqINPKjcgbL4aQ/m7vZ+5PN
         2Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744157; x=1713348957;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJeXAlXympZ3fGNAigYcYIKbq79Uk9zmaGjanfGy4uc=;
        b=gKLNUHOluGqcdvumS1U6INqopCUCFvXb0//2BGmroN6dqJ5LX2qeAJMqnuc6GGRODo
         Hax6/AWqIET5USHibGXMpKMNz9rYE7uPwQbglvUyRc8isCkDdJOUP3ZHdDFxYvY7DSP0
         DVnjnYC+aejeOjW3dmxpnQcTd5oOorxSs7iT0FfTuIdJ5Ed6/eI1mTelyKtHD4RzAL9U
         wjFKowGZ3uncNenV2BBuTx2ywwSG6CP0CU7zSXgql7iuihzvfWhC4Ne0T9VuEF2/75BM
         H2JtZ453328MhOJMn6+dXo4SZ2ai8efazj/J4KxWycXAkaHTM7dZdNAkJlyYoJTdbqhB
         +UFw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6mrc0zRPUhF/dEOD9tqbxBJJpoa134mEHD/qsTRLIUlI8sSQxjN6kRh5U7nYf9c+iUp0DtjLzNzHDKLcjZS1S3Yg
X-Gm-Message-State: AOJu0Yw90IspuFjwIiN12vV7R6VOZ4nVwbkoKeUO47z8/yyqaDQAsXmC
	PKhYdgpeZShU/qR/vMs3wI6vbLgqVao2rtFdfp5o+S1SK0E6j5g0I6h+LyijYwSKJ3Hi7k5fNWi
	AG514XOzWIdeNqPtohRLUDsSEzes=
X-Google-Smtp-Source: AGHT+IEDmGoiaZVFjQU9mM4A+TQFRml/wLobmTrk4K99245aZzNcAkbtE28SyDXInpqT+tYsvK/FlsVf6yptqHQs428=
X-Received: by 2002:a05:6871:6d83:b0:232:f9da:5cf3 with SMTP id
 zl3-20020a0568716d8300b00232f9da5cf3mr1452279oab.15.1712744157026; Wed, 10
 Apr 2024 03:15:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Apr 2024 03:15:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <587b5601c0c51a8f041258a27e693a2590468eed.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im> <cover.1712578376.git.ps@pks.im> <587b5601c0c51a8f041258a27e693a2590468eed.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Apr 2024 03:15:56 -0700
Message-ID: <CAOLa=ZTnnmBvwXMbHqJ+58kPGe4jwLhu_GaEfkAXyfVa5imeYA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] reftable/block: reuse `zstream` state on inflation
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001239c50615bb532b"

--0000000000001239c50615bb532b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When calling `inflateInit()` and `inflate()`, the zlib library will
> allocate several data structures for the underlying `zstream` to keep
> track of various information. Thus, when inflating repeatedly, it is
> possible to optimize memory allocation patterns by reusing the `zstream`
> and then calling `inflateReset()` on it to prepare it for the next chunk
> of data to inflate.
>
> This is exactly what the reftable code is doing: when iterating through
> reflogs we need to potentially inflate many log blocks, but we discard
> the `zstream` every single time. Instead, as we reuse the `block_reader`
> for each of the blocks anyway, we can initialize the `zstream` once and
> then reuse it for subsequent inflations.
>
> Refactor the code to do so, which leads to a significant reduction in
> the number of allocations. The following measurements were done when
> iterating through 1 million reflog entries. Before:
>
>   HEAP SUMMARY:
>       in use at exit: 13,473 bytes in 122 blocks
>     total heap usage: 23,028 allocs, 22,906 frees, 162,813,552 bytes allocated
>
> After:
>
>   HEAP SUMMARY:
>       in use at exit: 13,473 bytes in 122 blocks
>     total heap usage: 302 allocs, 180 frees, 88,352 bytes allocated
>

Really nice how just reusing the data structure has such a significant
impact.

--0000000000001239c50615bb532b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2530bd00765ffc61_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZV1p0b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNG9ZQy9zR3hIY1oxNWM1V3NRM2NQdmVnMElpNE9WYgpsWElLZVdvdml1
aGNMMHBqeHRSNk04cTdUSWFIRXZQMHVvZ0xPazlINGc2RExZeVZvUmRqenFHdXBEbFdhSnFaCmR5
SC9nUFlTaHBqTUV0bUhZOHR1QlZhL3Y1Mkg3NkRwbHBGV3hDQkRoWWIzOU9KMFhJR0licFJUL09D
c3AxNEkKWXNmamdMdDRVNEpNd2dUWVhuYzFTSmp1dTlFVldCRTZ6ck05S0hTdHhoSHVmVHVIWVVG
ZE1OTnB5RkhwdUZxZgpnbHlxeEgrRzUzNzMrNjhIOUNPekt6L0lpT0c5UlhGN3ZBMzJmY1pDU2NB
cTk0WUsreFRQQVcvVHVMcUlGblJSCklSa3VLdkY5aHpaa0ovK0U3bUU0REhqMEJSLzUybXZwb0xG
VmQzdUdpUldZdkNCcUFnTEpFSjJ4TTl4NkRCdmYKWE9sS2szbGZJQk45NU9XclcvUDZ3UGo3Q0FV
alh2VFJOcUdZRW1rdkVFbWg3TWI3UFlCZnhOblFwdGhtbmlFVwpIYnk3ZmFnNHJtMjFPNHJVajVj
eUxDOWc2Ull2T0JEdW14VXBzc0xkTXZEUUxCZTBYUHhHQTZ0WjFjNUs4ZGV0CkY0eHpsWks4Sk9S
Q1FCSUZVSnlwTWZ1d3VoUlprYmx4dWpCaUVJOD0KPVhld2EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001239c50615bb532b--
