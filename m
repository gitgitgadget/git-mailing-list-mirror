Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521033;
	b=ZN0vo27REJ8ZiQEFsIyGX/dsyLQJR4TT9R83USB9pXYpK9LbP3PGx9WXb6F4U9pkKZ+e
	 q4NCTe8g+fJa9ISnDHB644r70RyENA3tPXQaP+aAjQI2gABLz1g8sac9n6c+q6QWOCSMk
	 XFLu3+Mf47Uxt4dCCRzkGr0Z9518yDFqFubQTCJQ1zQDMoUy/TkIaSYXq7vu7Fg0gEbnp
	 iowEh6aCGItGVFuUW+W+RU/tAgic++Wv6I8llVptQtT5KeXHIqlXgpfYsDmjK3ZvzVJUU
	 9BRXS1ZcEqGOHP3qshxE6yHdAXsXBhiuRszUI7FTkL6Vcr5E+7shgY7aIWgIbyG97bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ylPR7+AkZ7jCblSywx64OEQMl+KwDx9lVkJcv21Al0Y=;
	b=nczmSSbdgmvk88Jer4ArWPubYIzmXlxl9n8coTpW4O4SlnBA2TPMnF1byFKzw4+4cl2h
	 xC30Or2cmtrNlV91tnn8+S8k/O42PeTi/lLlZ8tDFhe+RLG1A92DzuaCPkIx5kmWbgmCH
	 X6iJfpXYKVw96vXOEBJdLpTSnVX34pCDa/bV/c4vHrwBqlvrjegmsZFZVC931ajoIfogW
	 bIL+mQ1o3YlZkOuX62Arq6ZCQU4ZJxUA8fwjeJ614SwPIIEsb2qLkHhGl3jJhHm1oK9OZ
	 BHCkqN63bMkGxG7lqM/HYkG9jY284iLasZmoiPMPm/6qje6h7Y70/qtQIBTBIFLJR2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e61Adk1J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B1606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e61Adk1J
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc013095d4so1097317137.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521032; cv=none;
        d=google.com; s=arc-20260327;
        b=W6ZUmqPyerUavrqt0bHFWWy+dvLfDWH3gCGEr578BK/AO9XmeExLUwHL6QxfhuziLi
         Zg6jh3YYwptEJidORGvwg30OKR1bR1Ca4BhPoeviWLfnowTGv0PivWP5sfQxstn94ShW
         F9d+2pst+dtzo4yEHC7fvwAJFHCIOBZyinVUGPS75ErD321I7mPT8l5T6FQePOyMGkD2
         9BYLl/ExvOB2lx8xOUxhNKC8ooYmORX3DuxQnX9Z1aT4f7nikkOpsIZa59VAgSJ9W33b
         8c/Mt6ViW+fWnWptgwH8j3+WiSwOxOpw9G0QFxso8z3T8cWnJmekN32nwWkjHH0bHLI0
         rSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ylPR7+AkZ7jCblSywx64OEQMl+KwDx9lVkJcv21Al0Y=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=o+WlqNBh6UdgUl454wH8vtQ4Ln1qxBNe7Kv6qYInhgLFIHU6v9cv8blbyyz+O98JHb
         jUnLUzWXUxk0Dti0tsxPijnmu3xQIkgROucPXjSclI81H5+D+mwnoBeYVjMr61LdeDM8
         FXtfT2nZ2yqX6qnb9rt49DQ+xQWqH8XiczsYz5Ee+Ren9FFt9p08hX08Ilcgi2juXYVj
         XtRPKw8jg6SQ5/A8IQYavZrwtXuHhbU/19X4TpOK5QfIM7QOczS55R93DsRHHcyltCvD
         2mZlgav6x0agCbQE0uXYgkv67w0WUipgCKu1QNUI6RSwjRUfFM2/gq1yjd6XjKlb1DyP
         icAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521032; x=1793125832; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylPR7+AkZ7jCblSywx64OEQMl+KwDx9lVkJcv21Al0Y=;
        b=e61Adk1JozKkHeCruRw8wQbBu+3pq+Pv8nnxwphPuFuc0k/G5Wvv7fX6ywhnuTm7MJ
         CP170cc/bdj5jAKlCdBmfl5DIHFgIvTKY9F7R+gsod0y3uMgZWjVlDGOs/6h38WecQFo
         gRNWjFKgr5kqp2r7QNnLQKIXDtTvJiLJN7NKQwx4fM66c2rs9o/iRuwaxRf1x5C6wSjL
         LyibfY9cFxfOyxYxnkxtVmR7gfr4BL+i2LAtGjlwoaJs5kYdiKNsKXfa11vsBbJTPfJA
         vzO1RonxoVJ/9v23L8IKeL8EwDs+4FXohb6Ozm3As15Hs28mQixyKkdvUvEs1+JJpP1R
         K74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521032; x=1793125832;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ylPR7+AkZ7jCblSywx64OEQMl+KwDx9lVkJcv21Al0Y=;
        b=L8efSf8r5ysQ/TrhDseTXqGaLSzEOoOE3eO+tTTEWbUVPFHmRL5eVAztTqAZhbwTQc
         FjdzEhxRhHfKv+7hk6j7YR/Wr22zvxrwuBtDKV1ijvupvsFZR+iK7haViHSSphp8q4Gg
         9RTucNjUEg9Kh7VK2VhV921PW487fNpnOTkiQ4JEbDfgwcRmUyc595Mpc4dk6XYIJOoU
         lsu8B0jinc3zauiD5nlGO/FaW0iEum8dSn6EMs0NMA/VizTCkS4ebLcM7qMdPj+WhDS+
         2pI5k+Cjjq1nOxRbFntoQv0im5qKTlu1UNL9V/TzYVWKoH3U7NxONi6XoJ44E20Q/fgy
         YLKw==
X-Gm-Message-State: AFq9FYK2qRBDtrNxLVCpz+yQ1WrjtXeTIAPej7n2SGI6uZIgj32e7G+V
	neouSdnUNQheJkHhQQu0TBy/7gLTVRLt+RjVGWR/hl8Jk9C1YrVi6yNMItlYint+rFisAFU9j+/
	yyU/iuYzXpmtlNP7SH41ih0ANJA2QSSAfpQ==
X-Gm-Gg: AYBFou32zYm6NwML3nSXKu0R3ZMwHskX66PfcFBkFcfwWmPR/skOG+5B1zSFWeBsXJo
	WqyzH/Zx5b8DEe2h1FwrQVUVeIpEmIz7VJmfIgjWY2RT5xnnO0Sk+2RTKqrH06UfTH2h+9b0GOn
	Q5Vl7awu0GepyX8OSeUPF9fcPfEjaYKRO5X7axXn9CC8ZPuJno/dZiikKwQ0YVfkmXHponC+zN7
	7S9E3CbUMocS3zIOIIgffqL837A/290TYrcsOSpxF3xezfM3esMsWU7s345AJYkNuGCI39Y7ZXJ
	hRZnGCB4O4atKixJ+QXyxQ1ayEDUwKuN7DhbWK6OoMNCd9zzSLzp91sNS+wMTNEowpNmVpH3p0k
	LJIOrFf99xBuBTzF7bEH10/A3QHOAO/8oBhrPbwHT3iYD2KBMXv2VD0le
X-Received: by 2002:a05:6102:5489:b0:7cc:226a:f963 with SMTP id
 ada2fe7eead31-7cc926d4603mr18232137.28.1792521032295; Tue, 20 Oct 2026
 11:30:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 14:30:30 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 14:30:30 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atcrJ2u9F_9M9wTl@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-1-143a5963b77f@pks.im> <CAOLa=ZT91C0OZE=h7B0j6mgPhfrGjkRN4bCT9gVEXdXx+bSi1A@mail.gmail.com>
 <atcrJ2u9F_9M9wTl@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 14:30:30 -0400
X-Gm-Features: AclHuK8DgowK-2uUshqGCXuiVxvNbCUGEPSQiHqDgXOBxxerXIrZCHhlDRr124k
Message-ID: <CAOLa=ZQLbB5R1sc9M7Odkp7gpHAFCy9Wa+OYOJoEpUXGS2X3=A@mail.gmail.com>
Subject: Re: [PATCH 1/7] loose: drop unused `repo_write_loose_object_map()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006204ab065e49d373"

--0000000000006204ab065e49d373
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 19, 2026 at 01:21:08PM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The function `repo_write_loose_object_map()` was introduced in
>> > 23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
>> > objects, 2023-10-01), but it never had any callers as loose object maps
>> > are instead written incrementally via `repo_add_loose_object_map()`
>> > whenever a new loose object is created.
>> >
>> > Besides being dead code, the function also hardcodes the location of the
>> > "loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
>> > reader and `repo_add_loose_object_map()` derive the location from the
>> > loose source's path. The function would thus disagree with everyone else
>> > where the loose object map is supposed to be located when the object
>> > directory is using a non-default location.
>> >
>> > Remove the function.
>> >
>>
>> It's like the function being unused is an insufficient argument by
>> itself, so we also talk about why its incorrect. Made me chuckle.
>
> Yeah. The only reason that I even stumbled over this function is that
> it'll break with the object storage format extension, because it would
> put files into the wrong location. I only realized later on that the
> function isn't even used at all. But that probably explains why this
> message is a bit on the excessive side.
>
> Should I trim it?
>

I think its good, I just was amused by it.

> Patrick

--0000000000006204ab065e49d373
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e23a9ec073de3222_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWHMwUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNENkREFDT00zMEhORkUzVUV0Y3ozZ3NoKzZudlpHSgptVWdEN3pGa2Nj
ZmJXdStwRndScnAzNEVJYy84am53SUwxTEZRdnVIL3FIbDVJTk44WHB1ZGg2SU5hSGNsTHNpCllO
SVpsM1lScFNDSGdYMUtJWFpwSDVwWm04cnl5M1JwcFVoT3FSanBhakRueVlIQVdVc0lJTzRJZEhH
ZjluVnkKVnp2VThnR2ZlbVZqSWtqUFZKTGpHWWVCZXEycW1Cc1dKTm85bDZoSUJsNjZPUHJCbTJk
SUgrMnpiTlBENkl6UQpGei8ySWpyRmY4bmFLTWd0M1FZT1hWQkRIZWJKY3k2Y2RnNGR1eU83bjhM
VnpLejczb0lKQzVKc0xhMXpSTG5yCjlVNm5LbE4zWGh0elF3VFk1VzFwdVI4TUZRaFgrbTNMVGFk
aWdER1gvOVNVUlI4QW40bFo1ckpWWDhnWCtTRGkKMXdTUHZLbFRNR1hjaVlHdEdsc0RBOGgvcndW
YmFQKzVFbzEzcnVSaWYwMzlxU25SdlVwSWlkY09TZ05TTlNzTApvc3VnL1d0NGc0eGVYZUZRREhV
ck1RakpnTDJ2M0VhR3JIRzZPSDBGMktDQ2xJS201bEVvYVZCYllKUStRaVZUCmxyaE5rSVgyS3Zz
b29ubnZFb2FkbE9ISUd3K0ZuY0kwN0pMUTBIUT0KPTNkangKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006204ab065e49d373--
