Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE53101B8
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870195; cv=pass; b=Q4n4H4HAun0z+RVJtTXQrOByqmqHfVi04Q/iwZHZDp77rKAVxMfj7yDTctrdGqAyVCxvNvRcdoxPtzivJsQn2Li71+7fJpGj29xTo5TnMUJHS/ye/Q8Vhd/dusFSJLzoNhz3qm8RWEEYwt2MjrnEPfQAd2nadbgWfWQVmGjNyQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870195; c=relaxed/simple;
	bh=sTTFaz8VWR5o0WwF19sZJjOCBX+FPUpT9PK5k8zfgY0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeIOjRh5T0LXST4yL15LuMvY+fXDVlEItEs6MEYuYcZg3pWfxWfRzs1+bRVL6S3VuVh0V3ly44YD2PqC6jkR+5Cf5oy1FmDjNKJbDL4C/oRR8EKRYU8B+1Mc02q7D8Wm6H0B3XBOxmZ6dDTUBrO0n4GB0OKZgm9LxY4RwLlcdCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtbyUOSP; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtbyUOSP"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-61399bdd395so1754525137.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870193; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUfa19kRuZnAjTTeIEmVOEPl2zFx0gDhiLcz6jnd4G9SXTVmMULsF+zg+ITt5M/MhZ
         /HmB2snlwPFxHQ1w3NrJ2f9AFpsHF37Zmi7stqcXWd5s/BzBbL7DjnztVnOcU3e78s/b
         51tQBWP46BRswJgDTKP2LA721B43IWUhTd/Btl+0y+eQnGs4b7j9SBMxw6QeN/vuxHcB
         CZWNt7vxCsHt70cw1k0+zspnXh1jBiQYCB7BTXZ0vE6ymF0oGSSAvGe0RklK2rW+V1ft
         xfLHg8SHIgnEnBR32AdnXWE82Y0W8uqUTgp0yp3Yz8qrh1JtOSMTYVAPUEHgjRYhzkSG
         gXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=sTTFaz8VWR5o0WwF19sZJjOCBX+FPUpT9PK5k8zfgY0=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=CS2s70lhB3xfhDOU5pfjuudmVICQgZQaJxvPPcZnQZZ/WwxhqkpvqEXfCHRKIK7Ydp
         iFevwoz+uijeCFDJ3Mfo0wzkCusWVKaCJWvS+88bIj7zSV+dDLVFvQ4/ETMFDO1JYdLh
         0bGBR8FYBJxjbmttQ0jrlt2ip4Ia2eE6AhU/U+JyrBo8DtH5Iw9WSSqKhNT+XSvHX8d5
         O5go5hW6cKUJMmSkkks7ueMVEABE9yGs7RQ6R/I6OcmpiPjNzADeVIhvoComgfVtX0F6
         2GeIyaSdrEHycJp9lZ9BzKZgEwvVKXYIwhPVfSFlPbPPX+ua7UD6jhdF3BdCNq6LWosI
         5PGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870193; x=1777474993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTTFaz8VWR5o0WwF19sZJjOCBX+FPUpT9PK5k8zfgY0=;
        b=WtbyUOSPoyfnyimwCGzeP9p11o1c2y1bgZWYxs2nxGsFP3S16dR89UWkrcyMRGMzhw
         ra4RWCUSzXJ0NoYoZKTS7u5iDjaR0HhcDLQDLl/J0dY1CDVc1cPQ5cTni2LGqawNknV7
         Z5JvGlaPDOR9rv6aXTGGjzZAfQ2/VhXNKWzgFY9rRIY4BbmzpZFg8h+z5yt7cXqmDAyz
         zyiWA9n04PiQFWOh10OTS0PRxnSb3lKd2Ab3e8dIBPcJ9gH4E1Aype9bZ5/5Fqf1OE5N
         OoQd7oVOqwauJV9n/Q4p/zGXvYuPDZpEOb1p99gXrEGC9HsJmdJIY1XzEoxXZ7Go2O7q
         4Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870193; x=1777474993;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTTFaz8VWR5o0WwF19sZJjOCBX+FPUpT9PK5k8zfgY0=;
        b=hJW0KWgPEvy2GvVP81qTrzVJwSBEIihVYZPxuFHfUkcpj+l9xAZyWS6W1PBB+E+Ri7
         HAfA45OuVpWlUkSEK9dToikxtfYgbDJSb2ZUy7s1vUdDMuET0hmLUB0kjNAb301jrYDP
         jgN8Ma2bvBFIQvfr1VegjtRdRkRdZ35j81yc8TYpQTqTjnM+IFzWCkAWknBQm5xeGP0/
         TQqVxez+RgY+TPHXCDwld6/G2FRXObOXhmWYGDz1OSi2k+1PayLwz4G9BwFg69EueKCP
         CfAwUiU3B/NwaHj6dnytuVy1dTMBe6MPDbAHpwDOhCJQEgwKzXnmABHSONEjfHgSm7aU
         uQhA==
X-Gm-Message-State: AOJu0YyZwmBjZYFB89aN/I+rI6fs9l056fvz9ATgYHVZ08sFKSO80TXs
	9XhJpj87nN6XcGra1K4tK96A4LL3x6HqoAQb5w2o9ZVOfAglywO/fPJj58ay+9kZi8gYOAE5kY7
	07T8OJUbleQok6JKF3o/bLLxQWZRteGA=
X-Gm-Gg: AeBDieuVlXKcI7uCjR4go+87F1oOJAXwj9X6wmsXmkRSpnqbN8AYuOZawDedRtTF5D1
	l6x77TMGcHAhOeSe8YZdG32KLdj/ktAeXrP0N3DPUkExa4pMeBI4/Nq64U+l6+a484YhsVJ2REO
	c5tDqqrkahgHHHAMeHprUgj9Vkw07Mmcqbq4tPmJfg3EcxVwmBqPMfYtUIgc9G1f56ei22LvjID
	C7E3Ch1QKCwCuuigSzF+SI2Y6u7YCq4dR7sISDdZu4RcBQRj8ja9r5ZkimTJjeoa5+5qDeepZA7
	1z9IhBD7gnk1OQxVZzkwSMqW+pVA2+itbntxKbYDgW+93pfhB+tn
X-Received: by 2002:a05:6102:6b02:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-616f74063a4mr10872682137.25.1776870192936; Wed, 22 Apr 2026
 08:03:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 17:03:10 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 17:03:10 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeit7X0Q_MlxvPas@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-6-513e354f376b@gmail.com> <aeit7X0Q_MlxvPas@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 17:03:10 +0200
X-Gm-Features: AQROBzCaZrn1sWtaEc04StWtIEXumua1no-3d1RNr1ERX44gYhDxtdTDZwqM2JI
Message-ID: <CAOLa=ZQnxNgsLbp9J-T8eP5S-mW9xgr=viDfwo-VkbqQcjXU+A@mail.gmail.com>
Subject: Re: [PATCH 6/8] refs: move object parsing to the generic layer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a9a56d06500dd4fa"

--000000000000a9a56d06500dd4fa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:12:04PM +0200, Karthik Nayak wrote:
>> Regular reference updates made via reference transactions validate that
>> the provided object ID exists in the object database, this is done by
>
> s/this/which/
>
>> calling 'parse_object()'. This check is done independently by the
>> backends.
>
> ..., which leads to duplicated logic.

Will add in.

>
>> Let's move this to the generic layer, ensuring the backends only have to
>> care about reference storage and not about validation of the object IDs.
>> With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
>> error type as its no longer used.
>>
>> Since we don't iterate over individual references in
>> `ref_transaction_prepare()`, we add this check to
>> `ref_transaction_update()`. This means that the validation is done as
>> soon as an update is queued, without needing to prepare the
>> transaction. It can be argued that this is more ideal, since this
>> validation has no dependency on the reference transaction being
>> prepared.
>>
>> It must be noted that the change in behavior means that this error
>> cannot be ignored even with usage of batched updates, since this happens
>> when the update is being added to the transaction. But since the caller
>> gets specific error codes, they can either abort the transaction or
>> continue adding other updates to the transaction.
>
> Right, this is what the preceding commits have allowed us to do.
>
> I think this is a good step. Being less entangled with the object
> database in the ref backends is a good thing.
>
> Patrick

Agreed. Thanks for the review.

--000000000000a9a56d06500dd4fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ff189662369ee767_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ubzR5c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGkzQy80NllzY2dHaDBJcURCZXR4OVFVbExVVjlTVQpRYm1pYTVITW1l
UHZ5TytyV0ZZQzl0eUc1dWNoWUVnWmcvUE5FT0tRQjJuTW9TSTFOTzlCd2VraHBpSTM2ejMyCm5r
OEVxbERJa1lTN2tGZGJDNk5TekQ3Q3BTZm5nUTA1UlZpczNXTk8wWk9WNE5VZ0JRU213ajFnbmUr
Wlh3WEgKTkx2T29UeERJZ0ZpTnRsRHc3amxDMlMzaUpXZk5kR0JkVlFFL0J1Wmp6R0FrRE16ZGlM
TzBsdmU0OHhidXlYYQpSMmNlTmFsOTNUTFB0QlV1eU9STGZlSG9EREFqZmZybDlWV0NraTRrcm93
MGhVOUlxZFRWNk43SnA0VldGWHIxCm8vcjZ2ZW1oK1lWSlJra2pnc3hNRHJsN0I3WFBGWnBmZTVE
SlhjN2JIWE0rQmU0bGFsV29NM2RjRVJFbSsrUksKMmNnT2JNYW03WUNHVzNHcCszbjBvZUE4cTBz
bzJGdW5NSWVKMXJIdmlZR1puMlNxWEtZZUdyMVo3ajRDT01oYwpTYzFaVW43K2ZyL01yMGxISGdv
VVZPcjBaZ0Z0N3ZaNmxWNFI3Q1RRdS9ucWZ3bmZIMTNxZ3hYTlJZaDBRa1crCkg2WUZTZnJJdkJJ
TkttOEozSUxUd2R4bDJJQ21tWnl3djQ1TXlpMD0KPTJONmkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a9a56d06500dd4fa--
