Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222884156E6
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224794; cv=pass; b=B3EwBbuevMAucj05g+ZJsLv7GT83E912xlosPnhv2YaIsrEXhIR2X21gohzbd3oWHgzN+iJSrTKvK11mDS7ialbW+/VpzCUXvrejiINJM4bNGtLPZuRw96VMId8EKDxDuDh4hgD5q88CHjqdXciCJZK9tOCx5K0lBbxgzbXrgis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224794; c=relaxed/simple;
	bh=wFOGr6uvL1POsZOAn1cFhawfUEam5qEptndLZqwP2rE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWn+rY1RTHPXTmz2cse6loFQiWxInfBG+1ratn5fZYT5t5GV8q169hBEnIdOUrJ7vV89rs/qeBEXPuIz3NiKZEHlua5N4iRh3P60uKSGSjUrkKqnPh+Oiry+jIZaY4boBCEV9N2JUvpTvSkKGtaNl1mGHeiHe40fgFo9CB+gn5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rj5rbms3; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj5rbms3"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1801463e0c.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 04:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224787; cv=none;
        d=google.com; s=arc-20260327;
        b=NXzCj+h90WHc9slviAdEoC8XeU+Xfe09ri8+y5QzJmmaB3/+HECx+btQTiPBxearaJ
         97+yUwAhDNK0jCafZ7o6ER7C3YQaoBCQwcUdANBrIXxFtLhwEiB5k+qPcGyteMdh23HT
         C4O4SLxZCNz7PXJSPKIlz7dM0EArCz+SDSg1KmMt2hbmkb5tCapmFt0X6SvGjpN7Ytqv
         plnE4DbwDW86Zp3X8G9XjpaHalGRUqKwmN0yK19w3ug7Gi3EwpjHiAJCvJHoSYOZvSkd
         yyv+5XNYWwUyca9biFzICQ0/hcNO67q/x36bxNb7K/pEsqkH8EXP0BlaLfEBNd1m9Nib
         QOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=b9d7g5XHtE8eu6gEOLFpmrUJK6necVyD1+sDU5+6rKI=;
        fh=6DXZ+Op0tXqxntFnPK1WqGQqRpz+8e8kfJAMfU5umrU=;
        b=InMLHeAsdzWheN0/XiyDeXL6yS85ZgOBQGkNutHO2WB8mlzX3pC1UoOCSEcBeyJ2L8
         OP1Ho75LAv/1JvKM3rHvq+5nphn6adUKJ29rvH+hMSLgBnVRIW0OVxMj6OPTLYHI6yL1
         v5wCW/BTu/UtdTi65iMDL5doDrkrCraaYCJ+RjF1zDr7nGiMGh/iOfX8uxWjIZ9ht4ia
         ggQKSqIya+6bxfG2nsD90MO8Skd10+46ODlpiZqPSpAiJSYENPrEnZOCWYliK+07WWNf
         WzUAlPaMzy3MeL3pCFcixxTVl3Dbol3geC3OUWbjmfJNGeIoZwN8ZKgalaxK/Xfpqh/h
         kcmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224787; x=1787829587; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9d7g5XHtE8eu6gEOLFpmrUJK6necVyD1+sDU5+6rKI=;
        b=rj5rbms3AdXZsAooJyrWNHq6sF9sqEqSM768JjtW8VhWEE3c+mJwa2u7xIL/YYduwK
         0gpOycJEmlFYxS3HGpjmTjK/zNG3YlMztV5vs/QRaMU/3Ujuy3dq3uUFN6GssbutkRMN
         vCBPw7jnGe2CGdMFXOzXVtdPjG/+Vb7kiGtM6FIMvM4jbWBAAjJllzmDshHjKoDnvWaz
         gqXqcE6GzL4YajZKVzkZtv6MOFIG5W3wX5IQTRSa4gJ2HgYcf0o8wcbnkUXcb2TKV0fx
         m5T0TvfriYuauoNdTtgUxdlmKz+g52s6JbYe1tsQUJbS9uFfpddzyVCvfMJaG6UJ1yWW
         VP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224787; x=1787829587;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9d7g5XHtE8eu6gEOLFpmrUJK6necVyD1+sDU5+6rKI=;
        b=Fw7CR0suYkL80+XEN26DSEpTR4BsZAltDZ1SMch3rNkcBh5p+TxTQEwYeZCIeoB0Up
         odhWaSnCqCsBVMX1i7+c0Dt+YA0GqjT4oc9PL1qhXBxSpasrIHIgEx3NOdO5AW/XFwPO
         ulywHEI61MzksKZvhJnbR3Rcdt5//Q7t1X9f8qlBf3mXAoc6oi9EuJnMR2FnkYaGDndR
         1WLBz1ywZo0E420SoEIJo5vcdxYNLiRmeXhuog7RzX+I1TSLMMlBOX5wLJ7hiDGSjBRD
         w4MvaixgQxKmp+Jhl3GBaYBaK8PQJJPX3SdrL6+bc0pGLKIG8XyPcE0gP3hIqQXkfzs9
         P2aQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIr2Zey2x6sUC0jjF2Py4Cz47sCzBozpL4ZOkBgjI3fX/PYBhWEs0dNFenQjOSMaxHXro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/zgcHy2Pxiu44lXK2c4yI2JLU2TLmqiPzDA5symAGe7q1OwU
	S1BxO1xrsuPjXGuMJWZSeK/8KXDUzn0pZunfka4rMvBE2nN5TeS7s8vZuGBKC/jW+3d91aqxgF2
	lArOyVWhODebByWaO1r1FQRebuY7/UKI=
X-Gm-Gg: AR+sD12PqpTZ0P2y/XfCmWy1dYl+UNzc6jkdS/WECeokHv+bBjSt9ldSdI15As0+kEN
	4mHJGGrT3VVJ4pn4RjpqN21x5Kxm5Wvyw5aFxPliToW0WF1lJNKOMcvdZoS0g7lIWvsc2jfLOzk
	qEbI8II57tTzYr0ZBehRDZJbio19wBctgXR7B9WH8a26jTTNLb9qn4ue4DZ9LY5PNqhX6UdTLxc
	LDf1JvS7dxpsUwHat1CQCVdfP3Wj2XY++OtnCBoEyRb2+uhvSjtqB9zvRDIYIXRGn3rDb5UcAKE
	Dl4cNrUVSBdaa4N001Y+DyW1QKu4e57OSiIjqSaOdK2H/9mWQz45eJlDLlyyaP8zdL5Yodaof+6
	qOD37bupGRgyT3rIDNCP4I+BLFxHBbiS94TGwy+inrzERpA==
X-Received: by 2002:a05:6102:5f0c:b0:774:f009:e93c with SMTP id
 ada2fe7eead31-777f5c6160fmr5370494137.0.1787224786785; Thu, 20 Aug 2026
 04:19:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:19:45 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:19:45 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-6-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im> <20260820-b4-pks-odb-generate-pack-v3-6-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 07:19:45 -0400
X-Gm-Features: AcwNN1VqopJbQyVeLsJesIvaSJw6-ki2zWfs4SSAVoMsYm1f2gH7EZIzJmDp9Fg
Message-ID: <CAOLa=ZQ7-_=T1NSXY433oME8OoddJOuLX0wmdbk2ocQ0JTAuKQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] bundle: generate packfiles via the object database
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008d03b0065978b22d"

--0000000000008d03b0065978b22d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
> data that gets appended to the bundle header. While bundles are not
> part of the wire protocol, they are a transfer mechanism for packs all
> the same, so convert them to use the pack generation interface of the
> object database as well.
>
> This makes the pack generator the single spawn point for all pack
> streams that leave the repository, leaving only local maintenance tasks
> like git-repack(1) with direct knowledge of git-pack-objects(1).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/bundle.c | 10 +-------
>  bundle.c         | 69 ++++++++++++++++++++++++++++----------------------------
>  bundle.h         |  3 +--
>  3 files changed, 37 insertions(+), 45 deletions(-)
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index bfafadc984..de86e092a6 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -69,7 +69,6 @@ static int parse_options_cmd_bundle(int argc,
>
>  static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
>  			     struct repository *repo UNUSED) {

This '{' should be on the next line, but that's not on you :)

[snip]

The rest looks good.

--0000000000008d03b0065978b22d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 51cd88f292ed0d09_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzR0QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1ViQy85VHJ6Yi85V09mcW1hUmtpOGpYSG9yK1lsUwpwajVoZWdxZ0Fp
NkJreTVGUUJwUUpJTUhtRkk4N010Rm1DaTJzUlBGdnljWjkweHhTQ28rTnZrOXRIZE00VHZjCmE0
S3lmVXZrNFRsUXYwYmVISUlXR1FRNVhDK0JmbG8yeUw5ZDVQT2pHa2ZkLzBpUEtoUlRTY0tpSmRQ
SW5pYmsKNndVaC9Rb2x0RXlxajRMVnZlUXVZSkxyODN3bEtZdmkxalM0RG5pdU5xUkl6cndCU2Nl
OStoZ3lxcTFjMDZEMApPZlFtdXgxS01LV1hvL3A0eW5PRkg3QXRXTEd3emdDR3dMWXlDRmpiT0dC
djJzUGNoejc3QklMT24wMXlmYUNuClh6M2N5MjRRUDFvckYyWHkwaU5HVGt5Tm1JU00reU8vTHQ1
bnNIQmRVN2YxZGxHWFMwdzZiWmNtUGo0RU5mWEwKTDZGWlNOY0J1bVU3WmcwTEo2Y1BzNk9YWWln
SUJnV3owOXRBeGNsMzViMkhOeVFNQ0hxdTlzOFdLNC83ejladgozUE5BdldvUEx2RkhTeldZOHc4
NTNFUGhnNGFRdEpWdktTT1pVeFFmQUpSdkZhWkd3NEt6QitUUVdNOVp5VjVpCmVIOS9BTHZQcGZB
YXl5Qit4NHlFYVFqWnhvdkVhWU83UXJ1b2Q2OD0KPXg5c24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008d03b0065978b22d--
