Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2F364E89
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938595; cv=pass; b=q7rGhkKcHzPQ4nLW/AR2vhrsGaDoHpKrHMy5nLV/dPOioYFOJd969SFrLlvjf4MhPewksIvJ7wVXjyc9RYPM4vB/6lnlEnPctkb22WhAHAeflRCmIOkPSuwe1APbo05oTZxgQJHOHwU4UUv0EtwP98ssyEwUOn+9GkToo/n6vlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938595; c=relaxed/simple;
	bh=4N2NAsQwCy2/BTcPyTeasf+550BnhWn/JEM4oYCp8wY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHGcl0sJZUdQyoG+hMtDAtZX12YYcGvONphXDVnK4Eov9FJXiPXgTSmKxI8Are3uLXBO5IT3vE1EgND5LwtfUTL/bS9rHLKnzXo4VHHfOpL8RUhdBGraXL6baLiLJocprtSSOgcZoXIhZDleHuycAvUsRK8dGoHyPmrDCyX8yYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BShaJ7M9; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BShaJ7M9"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ddba39060so119535241.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771938593; cv=none;
        d=google.com; s=arc-20240605;
        b=Eztmlp3NXxHkzLFt986NuHNImzixSmTHd/NNvlU5+nmuCrrfXbSqmWy0yzVoZ/F4dl
         mKSUUDtzirROYNwLGdW11VUmLuxE36pH8b3NnsjEnsSIBQ4raGZqA5CwTHo+YUTK72J4
         4CMzFOYDWsF+h5hYnB8SvGWBrA/7vk7LeZ0HQMTbUS+auGbBVY9IdnRGvnKZT4cr4/hv
         cnRjGK8EoQiIxELizfYQnhJVslXORBEfrlu5G0lBQPHk4iU4EqGEmOQCJFg0H2FnkQ5b
         JXLQ0URgA820Vl2o25tNbeMIuAkT/34vsPEFkNEAKu+1MuLyQquhlxXOHACBTXH+lhW3
         gxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FVS25DMgyqzUeXtk8Tl0pJAWQVvZQp/RwzsGBKfy/BQ=;
        fh=Hzlk4bBbaL0foVlfdNKmCnBTMWqrARHzkC92V1a0zgc=;
        b=Ed8nfQjfDNsulHFrZKqNPncRpHjRBYc5b9TZ6GIvhn8m7Lj9O23kXTPE0fImK5BuLk
         1TL5wDS9jhH4Fgd8Tqn9XK2FvlTIdOIYsVYsvdJmqhWr33L9znItwbhpU699TfUSoKQx
         Ah64dnE6MRbDZVrxivL4P97RRud7myyylxgDBPtTDWb0k8OalTl1MbfI5coYIWWkHOwV
         YdchtkRRwptxIlVahfXC+zrnurBouIzB/W2KrBvlG3psKAJa27dDqCDZ5YXbjorcyQtk
         1GhBI7tS5AytAQNS3WWXBNZ7qBUcT4jy2vrv8BUkimNLSub8vWnm0OY5BRkLdYrc0kI4
         NbXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938593; x=1772543393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVS25DMgyqzUeXtk8Tl0pJAWQVvZQp/RwzsGBKfy/BQ=;
        b=BShaJ7M9yrCHhxR24Lf5V2xeeZsI++8wh1MzgcLS1+WFZ5fHJcMKhH48eJgOb44/9R
         kWCCgs5zz17QOOUW+Jb5rxq54K3aXjc5iErZ5IqdbmgQUHUAQvssE7INSL2S6dvzhEUX
         sXoe/e4SxHyGc9S0XY3/+d7wdY/ssqVlwy+iOdGDMuS9xHykwTw6oh/aMdm5LED4aXVI
         6iNdkqLoCda3HTwwewkT4rXlQRcy9xJG/q26Jtxfdri1lP5rHh1RybajxUIGEZun0VQy
         T2zjCI8D1T+004tJ1QIK4+NZ4zdNGWK0bVr5tQo7b5ClzmJcP+rYNNQoOj6/rHqhTZXF
         omqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938593; x=1772543393;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVS25DMgyqzUeXtk8Tl0pJAWQVvZQp/RwzsGBKfy/BQ=;
        b=o21q6jVouj1cEyxgrUhz6ZvXPCaIbiOA9Jq/NT04hDg5ySRYZK4k75GJeq+9bAC4l0
         2GDePEuRJQ06pkWzqK0FZG1NvUCtWS6kNS4aMcQfu/I/dFMJ52E2BSkN/NUUHWhyok7f
         Z9UaGLR34kKwwVkd6mQkgLRyzkFvEq8ZrcrW5vJPgS/6gqjBvkSxxD3k7FyNdkw2pzuX
         qkUISzn5qGgHGcbNfDPbXapHGvlWsgnyRR6cLDgO/FSruN2/ND5krm6dXU9szV/sYS/F
         2uFoRPu72+RLxGn1kvFkBH89xT6QSmvNnP0v7qEdFgtJY2wWtKZc6BvKBRKaLe9+rGnC
         GbrA==
X-Forwarded-Encrypted: i=1; AJvYcCXFXd61C7PKfFfyjZBcD1lMJaE6V+vaV/fgyd4eylr11Z4jM4y0qqUMYNYgUYoHmxI2xkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTX0v5DHOXsXQ5tapcAEBQ5efMdJMr6pfZcYJIjjcITym9nCb
	Lbu1GLtsOEw27mBCLPbP83mDO6HxKGqBgu/itTJGc5fnSy/Hl5fnMRkOW+FHzoXDnqtLjQSJtxW
	Dg/tZmyUOnwX+0V335dOTWRJYojBATxY=
X-Gm-Gg: ATEYQzwT95s2lYka1rGUj0MimX22aOFPaqEsWhm5h0HpNgzJkZvrmtt0LGZw59zZIYA
	psa4zVl+s/X012iygdb9Asdhp7POCabCjyfyL+A4RlxAaFyb11TL4dupEEY0BUO8pJoJCYLl2is
	OiFNOZ3jcHfV7sKpW43BtcQZIiJ1AsJFfXbJBzVYkkXx+etlrA3d9RoNLzMWRRWsRwbEj+wwyAf
	TOAlCOnMFoiY66HaD5usjgQHW/alokInZnXU9NaftkLEEn+J8VjyfHUINIO6g1wlJYK/PpnxmUB
	YSyI7bFLajdL7rrjlQI+2SxQHuxEVJNKLKh+bqc4SA==
X-Received: by 2002:a05:6102:d86:b0:5f9:3a1a:47d3 with SMTP id
 ada2fe7eead31-5feb2eef61dmr4425572137.12.1771938593075; Tue, 24 Feb 2026
 05:09:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:09:52 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:09:52 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3af8a2ba-dfe4-4e43-8f86-b03a0cbc3698@app.fastmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com> <3af8a2ba-dfe4-4e43-8f86-b03a0cbc3698@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 08:09:52 -0500
X-Gm-Features: AaiRm535jr73w3aSLLmPGjHKbzmO7e1cbzqGp5wkH2ZbbuqD-jmdisLNqs7MplE
Message-ID: <CAOLa=ZTJ3-7OSbfRYbYuTaZBsPSSXrHHJ5LkCO_HSMw=y5+Gfg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] refs: allow reference location in refstorage config
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="00000000000067dda8064b919a58"

--00000000000067dda8064b919a58
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Feb 23, 2026, at 09:01, Karthik Nayak wrote:
>>[snip]
>>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/config/extensions.adoc |  16 +++-
>>  builtin/worktree.c                   |  34 ++++++++
>>  refs.c                               |   6 +-
>>  repository.c                         |   9 +-
>>  repository.h                         |   8 +-
>>  setup.c                              |  34 +++++++-
>>  setup.h                              |   1 +
>>  t/meson.build                        |   1 +
>>  t/t1423-ref-backend.sh               | 159 ++++++++++++++++++++++++++++=
+++++++
>>  9 files changed, 259 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/config/extensions.adoc
>> b/Documentation/config/extensions.adoc
>> index 532456644b..3e51da36d3 100644
>> --- a/Documentation/config/extensions.adoc
>> +++ b/Documentation/config/extensions.adoc
>> @@ -57,10 +57,24 @@ For historical reasons, this extension is respected
>> regardless of the
>>  `core.repositoryFormatVersion` setting.
>>
>>  refStorage:::
>> -	Specify the ref storage format to use. The acceptable values are:
>> +	Specify the ref storage format and a corresponding payload. The value
>> +	can be either a format name or a URI:
>>  +
>>  --
>> +* A format name alone (e.g., `reftable` or `files`).
>> +
>> +* A URI format `<format>://<payload>` explicitly specifies both the
>> +  format and payload (e.g., `reftable:///foo/bar`).
>> +
>> +Supported format names are:
>> ++
>>  include::../ref-storage-format.adoc[]
>
> It looks like this causes list continuation (+) and the `;;` syntax to
> appear in the HTML output of git-config(1).
>
>     + files;; for loose files with packed-refs. ...
>
>     + The payload is passed ...
>
> According to `Documentation/doc-diff master seen`.
>
> It looks like dropping the list continuations fixes it.
>
>     Supported format names are:
>
>     include::../ref-storage-format.adoc[]
>
>     The payload is passed directly to the reference backend. For the file=
s and
>     [...]
>
> Maybe because you are inside an open block? I don=E2=80=99t know.
>

I don't know either. But this seems to fix it, let me know if it does
for you too.

--8<--

diff --git a/Documentation/config/extensions.adoc
b/Documentation/config/extensions.adoc
index 3e51da36d3..329d02b3c4 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -67,13 +67,13 @@ refStorage:::
   format and payload (e.g., `reftable:///foo/bar`).

 Supported format names are:
-+
+
 include::../ref-storage-format.adoc[]
-+
+
 The payload is passed directly to the reference backend. For the files and
 reftable backends, this must be a filesystem path where the references wil=
l
 be stored. Defaulting to the commondir when no payload is provided. Relati=
ve
-paths are resolved relative to the $GIT_DIR. Future backends may support
+paths are resolved relative to the `$GIT_DIR`. Future backends may support
 other payload schemes, e.g., postgres://127.0.0.1:5432?database=3Dmyrepo.
 --
 +


>> ++
>> +The payload is passed directly to the reference backend. For the files
>>[snip]

--00000000000067dda8064b919a58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48a321e9e8df084c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZG94c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0FnREFDVFZSaDJZemhOSlF6Z0QrWFBqTWwzWkhFUApBQkhsSmVLRVla
SUV1QTFBYURmQmtERjhIYmdZWi95NVVLeXNFY0tlNGpGY0Q1Sklla1VmZVdTdU5ZT0lFckwxClBo
dnBVc0Q3VTI0bVhtcFBRQ1AvMmhkaGdtL1M1M0JZZzFKTDk2SVIxU0wvRXdUdnBzL2lSWlpSRmYw
K3RFbmYKK3I4aDU1K3MyRlRTblVSK0ZxT2NJYTJuMElVWUZrSFNsc0F5RlA4b2sxN2VnbHNUT0Jn
MmtUY0kxUDIraDNRZQpRWHVFampmcnRkSWZmSm9GQjNvcVpZSVgvUk5YMkJIOWt4QkZVTnlhWmtp
UE1qZkZEV3VUdG41dzJnaXVLYTg3CmtkQlJLY1BpV3Vuc2QvcWpOUlMxNkI0MzF0b3pQQ2htK3lr
bll6YnRJQVFSYlczcGFEdDNYeDAxTVRET0FJb3UKUHBzOFRuRDV2Q2VjLzJkTTNMOWdLWDlZUC8v
VXN4SG9xczZiNlUvQXlSQjlKNk9CcGFwNlFDRllrK3NyNkV3WAovY1B0UngxZnF0T0U5U2xldzhr
UXFDendESEhSemk5ZzNPWXQzNkdhTUVTTE5hNFZIdFp1bytNNFZHN2dUaFQwClZ1bUR1TjB1ZlJD
dlROZ1F0ZWFTU0xJUDMrdXFLTWtzVFg3TDUzZz0KPXlnU20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000067dda8064b919a58--
