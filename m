Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F628CF45
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430077; cv=none; b=mtgtP30f8TzRjBmp2WpuPX3EMe/ailFvXGel5pqnPqXWY3sKNX7ED8mE3ONLVsve4Bkj190thQTk1GZbb3bQFlsHXjGCXB6wkVO+s6yxwdfwfKBqw7g1Ue6AKl5mgH+Tz7NmBXJBPfQ0ROM07cpLvh3JVQir5RRBD6fjQSnCqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430077; c=relaxed/simple;
	bh=DGZYMt4HN71xCq0Xw5KLrozrc7yRi79SstE1SDihZ0A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKsy2vQjJdzZ1042VyCvYFbP0/w6DBbRM7RQ2u4J3dwuk3qpC16b5WQQ+orDIAXJNej3b5jp8yxVEn3gp/2FBEz+wGdKix6e5vnkVng9e9H6ork4dGsUShg2gYXW3VyFDGxugojDhK4V1hoeYv+BE3mwduFowy/2hmVbd71Pk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9Ql5Pi3; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9Ql5Pi3"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so65496241.2
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430074; x=1746034874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZYMt4HN71xCq0Xw5KLrozrc7yRi79SstE1SDihZ0A=;
        b=a9Ql5Pi3jiXoIW7lzwOhPm/rpIKZpMEgaU/6b/i0YPQnPW7l5R/qBfdH+eRvk21LJo
         qzwYbUuTz5FC8xQcbcrNCeDpSJhF03hvAyqixt714PBOuInCvZ/tYqXGbZ/mIRowGazh
         6ybie00f559zYEZ/TWmHOUsb09kiNEYGmkX4PicmInsPo8netq9I7SSWXDrSb3hpPYf3
         LguUrUA/TYOtGkEE3pWEeSPweOYiWTYCWioYWp+6eIAy1sIAS0Ng7uRTX/bGEBKhuIeI
         TWUujI+Tq35ALDbpZoLMWafK9EPw30ydTOZS3e0dcdC446J4QC8K4XYkONkkIf4ooOne
         zYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430074; x=1746034874;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZYMt4HN71xCq0Xw5KLrozrc7yRi79SstE1SDihZ0A=;
        b=C+mk1NzlC2Un/3Vqks4AU6XTU0AbGkA3FnUNhVh6wWJTKw2dzsOdYxfGYKtrOK0y/5
         HeCdlxZFxUWOTXSxB1y/Uy9Lyvd5TsKz8f6GvDR7sGeNfhExMSosFYDUCsaDuNzBwp04
         xA1Xm5rleQV0AI8buoPH6/LKiNJUa0M8kO6KKTliHO5vGpv94iYa2qRJc743YkYcd9+y
         wlKlvdZkXuvb9wmMww6xNOR6Eys+fDN0fDs4gwfaY62u3J6H5jS8Nr6eRGIEoFbwQeNt
         zSWq6BV611GSyJHks9IV9J2WDR96849Gf2pMHu3Y4KRRmc4gOF4O3ATIesSLERziGUQ9
         DYbA==
X-Gm-Message-State: AOJu0YzOzB4GEtFsk8MXy19Fu91fJnw0W+Occ4UaCbUOrgKb6umG9DmB
	BjypWk49yGccwxl7AuorIzFvoX7pdoy/+nL66uIOkERmoH4zVqf0ay1/jhU1GlP72c1tWUBsQtW
	GyBZDSR1eD5YxFfWUOScx/ubJXrk=
X-Gm-Gg: ASbGncum4NOA0P3tAUYDjh53h7z9vH3BbF/Y3DT22EsbVID6oqYyO4ie2H2DLJ83rOf
	n5lrTFO6qrtOk9gewHyjLxL9gXpeEse53uW3rKwrv9UUBG+A2NmQyLkBrbrjzOospKRS8BM5tZW
	sPqJ3USJtvUkwgkIJsyBRFzQhqK1pleDQUZ6Lsie6iHLolTNdaoxJ/8f8C
X-Google-Smtp-Source: AGHT+IHSZbOOITgYp5cwTYtJM4gEvBelr3OUdCvSqiyIBu5/yi7QT4IBq5HF96nrtn1RJkmWv8feCm1SO6mr7K+YTTg=
X-Received: by 2002:a05:6102:2998:b0:4c4:edfa:9634 with SMTP id
 ada2fe7eead31-4cb800fd27bmr11571209137.1.1745430074582; Wed, 23 Apr 2025
 10:41:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:41:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:41:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aAjPUGJeOjQHpAKz@pks.im>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-6-d1e2be4b2078@gmail.com> <aAjPUGJeOjQHpAKz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:41:13 -0700
X-Gm-Features: ATxdqUEaK9y5c3SfpfUQtks-54xhs9sfv1eQg71tbrXHCd6yDZeMSQyInbNHU4A
Message-ID: <CAOLa=ZTXjrXgqkQo1S9VgLFrgniQmJTtNwtuVt0+isgsCoLFdA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] makefile/meson: add 'check-headers' as alias for 'hdr-check'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000009386690633759b69"

--0000000000009386690633759b69
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 23, 2025 at 10:15:39AM +0200, Karthik Nayak wrote:
>> The 'hdr-check' target in Meson and makefile is used to check if headers
>> can be compiled individually. The naming however isn't readable as 'hdr'
>> is not a common shortforme for 'header', neither is it an abbreviation.
>>
>> Let's introduce 'check-headers' as an alternative target for 'hdr-check'
>> and add a `TODO` to deprecate the latter after 2 releases. Since this
>> is an internal tool, we can use a shorter deprecation cycle.
>>
>> Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
>> also use 'check-headers'.
>
> I wondered whether we also want to rename `coccicheck` to
> `check-coccinelle` to match. But even if the answer would be "yes" I
> don't think that this change would need to be part of this patch series.
>

I would say 'yes' to both those your statements!

> Thanks!
>
> Patrick

--0000000000009386690633759b69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 32a0ee69af2a983a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkpqZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkRpQy85YVpZMlVUWlJoYjFKTW5RbW5VU1hTejFuVQpJY0x2U2JEREF3
UzVKMmFFUEZKSlJlK3NPUXFtU2Z2VkJoOVlVcGQ4ZjIweHNqNit6R3FmRUtra0ZCY0dPWklDClFu
c2ducW5MZGFWN3FwdnVoZXpMaFNUR3VvZzZ2YkVOdjBWbmZWZC9rMXBJaFNrNTM1MXNROGhPMWV4
S2tRMmMKNVZ5MTEwQVBKcWdwY2RNN05xNENuVGFXY3o2TXdpS3lRcWlPMmJOb2hpeFRRaFA4Z1dz
S0N1N1dsUFhXTXVPUQpvY1E2MmR1QkJHZnZBODhnekdCcnpzckE3V1NpdU03cmd4eVBSaW1pVFRw
TXY5dWV5S3lwYVBVMHBSOC8xRWRvCjZnVkZpZmdkOVRvRjlSM3J0RDU5SlA5aFJsREVQZUZRSXFx
ZWtRS3RpUnZITC9yUFU0c2ozbU8rTlBCWUg2bUMKNjFteVYyN25kdDcvS0hYc2lWeGhrSXM5M0p5
empQbnNrQmZQMXBvMld6THh1RmVLZWw5WWF4ZFJTRkdoN3ZaegozUTJ1OFZqaU52aHJhSWVxWENB
SjBJVkVMYW9FUHpvNmxUNktLMCtmUW44VVVQU0RhelNJUFNXMmxOaVBEejBICnVkdStnaVNseFR5
Y2xPbEQ2cXZKeTExSmZDWWFZRDJnQ0pGcUtQTT0KPWFIcFMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009386690633759b69--
