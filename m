Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5B31064E
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000912; cv=pass; b=CiLxcGrckX50qF5H3dToBjw0og4N21wc8BzFpNoQvdrb+VCpFEwkswk8r3wRLnn0po8KaKu2dDmUXopErv86kfxvYTzYIpYbkjImz0E4N+wUNEMXI1z0O+Bp4Dcc1pCGCGnrftb9wiHCdqCbgLvzsnEqowrWiHvNG2KyxASP4AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000912; c=relaxed/simple;
	bh=hHW827xd6LL72xktzB03hy9SXI2L9I5xE5A9vSeMLmU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=PcB3LGD8VO+7HCpC+5rBnJwEmzamdRc80rgYUjGGspFg4tuPMaYOHlBWAOgfo4GqWM2YizTaNsU8kKkUkNQgAvowq+UqlCjK8UMQYIV/IDC2vjRgLD0Z7Iq9HD1w01VXZI7wNwSJTrHQCL22hGGyBxcs5Nm0/AhlNjiNEX+N0Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUnQOxZB; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUnQOxZB"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-950ca549ff9so1059264241.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000910; cv=none;
        d=google.com; s=arc-20240605;
        b=CvgvZHxLT5Be00vN6rHjkjU0pi/et+oiq1M2VIfXMZ13vk2SVA/77hwbv7N1vUPAty
         cwrGFS1zED4Ems8/Tx/pVWpW2kmK3y9+2nWLcIn7zTueLGQ98YQMuUAwgzU1AiXz8/5K
         r/cXdMLn52JIfDBY214q3x1DDd/zxTOp2Qo/xupTMEic9FBVCLirQmHD7EJDDTarCsNE
         vSDMrkmdbHSJmJMNuEWXplR0IIA7vYYJp3KXw+cXCP09KK82idw18Qp0B4TY5D4nU5yc
         SBbZrYQxW+M6tpOpoGUtd+NK4nQ0brPaN0aTtPT3Uh9kzPAPuw/gPfqRZ7HR+j/Q8/OZ
         sBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=SbQ0qzuZv0xmV+834GyUyEpJD/XJjaFtNDaKmjA0LQA=;
        fh=4prTVcogMgHK0OTgnyiqKe/B5LpbNzVi3P3akdl3WhI=;
        b=QRw2UuuUP/l4PNuyamMx48EuMHMeZbMnqVLIt0mFk7Exj4Jb+DVLULTGhpqby5PV3n
         z3MczNnpqYKidQkmCQZQLEa9gP4WusErh5pQEQz7rli+lgXsfV774ZXtWMw2BvrjUjSB
         dnEDO2lMirwUc7CI03SneXXLLaRQ4gWypXHvd4i6Lm6kqzfr2xPMv+Ft/Qj7w24dAzyw
         lgnwN5iU3TJ5S4RRLMSuIlJ65bI63TEMR0Dt+LMHU5gLJlGZfGBLtByTVG/Slnr/lZo0
         grPxtv+4A5gxgDbE9qJk0xSEO3xlA8u8g4jGCvlJQ3J4MbVhwnRnMhu/GKOAS2YGwTqP
         poNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774000910; x=1774605710; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbQ0qzuZv0xmV+834GyUyEpJD/XJjaFtNDaKmjA0LQA=;
        b=DUnQOxZBVa60WfmZDfBioPw6N0vZau2Ip7drRaxHMF8yDsMSTXNN5L4yTO1OOB2+Xk
         VmvxKvFvlWDI/0pGOPuNutr5Pq4Gka/Vgm3yqCcsTgvQUT3MxsqQHm77tqlheHSz52bz
         EZgiMrcoSXxn7u+HKrBYMf6pIrFjG0ENdg6EqFVR3jFZe/tihh0oKnfT5c+ouOy5A+qr
         JOdwQ5XjRfqYaKMWX4DKr2Qr3EaqBt+/jurLw0vZDIRgkiupCEAqtZx+OHEgqDRJBL4H
         g/rGZ+tXr4iW7jVyCra+jm6Nh7DNZoO3Ic27AlV5A84gXRhT8+5a1hpmBf+EkKID3mRM
         uzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774000910; x=1774605710;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbQ0qzuZv0xmV+834GyUyEpJD/XJjaFtNDaKmjA0LQA=;
        b=mB+LCt3Yyjo42a9Zn346F1TM8JPdnCMKAUznm3UKxifz15sJlnmBVfyXnTWhCVl0Kz
         JBbVbmvhuL5M5+TF6lumqR0HRgNHvhYKNZYl5h0/UXVrm0GDrEx5PIHSAdY2te2ojpjX
         J6bQW5LEYA2Y40Qoxj7oM291ezWPlT8Ro92V4LT+8iyVnD0q4tZGvjOYw4mJpYuB6ulF
         3EBtl4ccHgMHzntt0Cb2XXP6GW+Rc9eQ9UqeF/EKNp3tz2oCsRtO8+YrxkvYpnTA5nST
         8Mn75lF1Wkq0lLHz+7eBb1QT+2Ok/LNC4bKBjrYAqo5ci17Duphk+YbA8M4/Vgg3Kt6a
         AQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwZEPYn5KFB0bOfnWgDgMwlp2R5wHv6adXpCPzCYnnI2MyXgAeKuslB0lXaCjvHyZxAMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/2xP14F4koR2QZzIt7AzwdgCYT+rAPd5hKn7ya3o+KKwpGiX
	7XhFst3vOkQABhCKSt+G2yLldt3h2dLEHfj4WG7sUwVblMSUn4QZ/zY8mPPOLqjdbkRGBXr0R/V
	mJry7xpM4k+zqsc76bAzL40Gz5jxKGjA=
X-Gm-Gg: ATEYQzwq9FCzaVjYrnaDabBMlwLFAOJ4erioyhadTlqO/8H5vx9vbAO8cCRfvwGvlDM
	0ZJOQr5+COllvi/NoKZfh9QATlym+hntCXwQTrLsBGXzBvs5YFcJd6r4TfZOL0POTE14+zjm82Z
	TcOx1tOdzWUGomSIzraYuC0xpq8qJRy48fCIxDsy1BdqJ2c5nzUeFtbPKYWbB5B30tfjhNQ7SqG
	otOo/bAWzkbY2/zj6xWdHThy8zgea046Y/xuTqdKwwLAiNRJldLC/8y/LjU/na1nBKQPqFP5pUO
	AgmK3Dxk
X-Received: by 2002:a05:6102:304c:b0:5ff:fbe4:8a8 with SMTP id
 ada2fe7eead31-602aed054camr1258110137.25.1774000909473; Fri, 20 Mar 2026
 03:01:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:01:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:01:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-11-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im> <20260319-b4-pks-odb-source-abbrev-v1-11-5ddebad292b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 03:01:48 -0700
X-Gm-Features: AaiRm50Mc97JaSWt_oU1Lne0ofGI79dqmMX9qE20KlQwyl9mkO6Oo9LO2-cDQGg
Message-ID: <CAOLa=ZRU3=FqDo8SiJ=+qTsU79NEfoyAVp1uZYBX57SNPTZomw@mail.gmail.com>
Subject: Re: [PATCH 11/14] object-name: simplify computing common prefixes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000a83bc064d71c675"

--0000000000000a83bc064d71c675
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `extend_abbrev_len()` computes the length of common hex
> characters between two object IDs. This is done by:
>
>   - Making the caller provide the `hex` string for the needle object ID.
>
>   - Comparing every hex position of the haystack object ID with
>     `get_hex_char_from_oid()`.
>
> Turning the binary representation into hex first is roundabout though:
> we can simply compare the binary representation and give some special
> attention to the final nibble.
>
> Introduce a new function `oid_common_prefix_hexlen()` that does exactly
> this and refactor the code to use the new function. This allows us to
> drop the `struct min_abbrev_data::hex` field. Furthermore, this function
> will be used in by some other callsites in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  hash.c        | 18 ++++++++++++++++++
>  hash.h        |  3 +++
>  object-name.c | 23 +++--------------------
>  3 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/hash.c b/hash.c
> index 553f2008ea..e925b9754e 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -317,3 +317,21 @@ const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
>  	/* Otherwise use the default one. */
>  	return algop;
>  }
> +
> +unsigned oid_common_prefix_hexlen(const struct object_id *a,
> +				  const struct object_id *b)
> +{
> +	unsigned rawsz = hash_algos[a->algo].rawsz;
> +
> +	for (unsigned i = 0; i < rawsz; i++) {
> +		if (a->hash[i] == b->hash[i])
> +			continue;
> +

Instead of transforming the bytes into 2 hex components we now compare
the bytes themselves and perhaps then compare parts of it?

> +		if ((a->hash[i] ^ b->hash[i]) & 0xf0)

Okay so if the 4 MSB are the same then we end up here and return i * 2.
Makes sense.

> +			return i * 2;
> +		else
> +			return i * 2 + 1;

If not, its the 4 LSB.

> +	}
> +
> +	return rawsz * 2;
> +}
> diff --git a/hash.h b/hash.h
> index d51efce1d3..c082a53c9a 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -396,6 +396,9 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
>  	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
>  }
>
> +unsigned oid_common_prefix_hexlen(const struct object_id *a,
> +				  const struct object_id *b);
> +
>  static inline void oidcpy(struct object_id *dst, const struct object_id *src)
>  {
>  	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
> diff --git a/object-name.c b/object-name.c
> index d82fb49f39..32e9c23e40 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -585,32 +585,16 @@ static unsigned msb(unsigned long val)
>  struct min_abbrev_data {
>  	unsigned int init_len;
>  	unsigned int cur_len;
> -	char *hex;
>  	struct repository *repo;
>  	const struct object_id *oid;
>  };
>
> -static inline char get_hex_char_from_oid(const struct object_id *oid,
> -					 unsigned int pos)
> -{
> -	static const char hex[] = "0123456789abcdef";
> -
> -	if ((pos & 1) == 0)

So this basically alternates between odd/even positions.

So walking with an example:

if we have '10101011 11111010 10101010'
pos 1 should get the hex for '1010'
pos 2 should get the hex for '1011'
pos 3 should get the hex for '1111'
...

> -		return hex[oid->hash[pos >> 1] >> 4];

So for pos 1 '1010', to obtain the byte we first do 'pos >> 1'. Then we
only care about the 4 MSB so we do `oid->hash[pos >> 1] >> 4`.

Finally we map it to the hex[] char array.

> -	else
> -		return hex[oid->hash[pos >> 1] & 0xf];
> -}
> -
>  static int extend_abbrev_len(const struct object_id *oid,
>  			     struct min_abbrev_data *mad)
>  {
> -	unsigned int i = mad->init_len;
> -	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
> -		i++;
> -

So earlier, we were iterating through the mad->hex which already had the
computed hex. So to compare it with oid, we needed to get the hex at
each position i of the oid.

That's where `get_hex_char_from_oid()` came in place.

> -	if (mad->hex[i] && i >= mad->cur_len)
> -		mad->cur_len = i + 1;
> -
> +	unsigned len = oid_common_prefix_hexlen(oid, mad->oid);
> +	if (len != hash_algos[oid->algo].hexsz && len >= mad->cur_len)
> +		mad->cur_len = len + 1;
>  	return 0;
>  }
>
> @@ -785,7 +769,6 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>  	mad.repo = r;
>  	mad.init_len = len;
>  	mad.cur_len = len;
> -	mad.hex = hex;
>  	mad.oid = oid;
>
>  	find_abbrev_len_packed(&mad);
>
> --
> 2.53.0.1055.ga2ffed1127.dirty

The patch looks good.

--0000000000000a83bc064d71c675
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b212c724e778bea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOUd3b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEpnQy85YjZQVTVVemJjQ24xRDRMUXBTdzd1V25PbApJOFFmT0JtcFVy
WXlsQ3JDdFJ3SmdTNmZyMzBaemlHV0RmRWhYd0tRZDdya2RYdWJHM3FGbFRpamNSYnhFcE1UCm5T
c1ZucGVTaVBEMU9uaDFhQmZVVERHbHN6R2l2b05vOHBaVUxtQ3h0ZmpscnZ0STBXMk9pMkNCYTVO
QXRscGwKT3owNjhKUUh1dExEYzNjeXJMbU00WlZEUzZqeDVqWkRHSVloOWZIQjRvRTdIYytpOWxm
OXpOTTIxL0h0TkhkdQp3K2kzOVVuaER6K21VeGdjOXp1UWMxT3FkbzRkSGd3bEJHdWRlZ0ZyY2Zx
Q3czem4xcU1wMFk2UmxRejZ6TlJXClBYaW9aRVN6MXFhanNhWkZnVzBVVzhkU0kxbVpFUGRqNi85
aFNkT1FTdGNHQm4xK1MrZmx1OGRlMytkNW1oRk0KMFZUNTZqbFVPcGp1OS83TjFkQmx1d0dPUUxo
OXFwR1RKUDhleXBncVBkNTIyc294c0lzVDc2L3VFMXh3MmZwagpOQVNxeGlybHBOSTFzUXRWbnpy
QmI4dWsrbSs2dzcwZWFuU2F3dmZGQ05UY2cxbjByNkN4NGp3WDZrZXp3YkdPCmpzNjFwa1BIMGxq
ZENGV0JnMGg2ODVrOFZ4T0RyUFNjQjZwWG4xbz0KPS85OUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a83bc064d71c675--
