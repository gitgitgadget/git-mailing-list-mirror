Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225987;
	b=mJwLWFvPvDoIw6xvmR/V6HvZDyMu/xYB87uWcrbFDjCUABY/WbNFv4Es5ESgfKQ87YXq
	 OBHu7J3gJkk2+Q0jw1udODC+WPiHIC3eSQw3XR8KCoQuO2wPYy0pcLHkgD2s3++AtHVTj
	 1pea2f31WIH0d8MZjyP3X958NKcblS6j3YEkhirPn1s77lJc1Ul1zUA/Y/CTwo/AoOov/
	 D81pfm2zP52kBB5nIQx1GW5vZHJM7na05ahf3dsAEVisCZBIue+OqxLZBLbEqaJab/vdb
	 bqdmowvOh53c9MBzpR2RVDL2XYsjYwYb9VusiBwstnepheeeOrHtrAXBbYpJ9yL75Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6I09XAecJGKqMjJkMAQgPA5ZTJoib5mVxQ1ydB5Q/8s=;
	b=t2aCBS5mP3NXVAL5Eq2lhbFYQ8j/4S0AP380H/C6V8v1LG2J0QKl+MfRNKXa3l+D97G3
	 hcvuKAWDGFiN72HwRrHvQL/D5Fqj7ucVrZNlOuUzlGjvm2ZAjfF2dQ3MPMVFqoUPmGyS6
	 Y1xjARAFYMXRmRwoNvTLuswLLxrjvb/1x0HionKWgODO2YKUB/6iRgwvnPcW1+xEU0vm+
	 wc78+itg+bJXawGPe+ituAztO0nKfDwmTSfkRR5fXK9B6ORu8kCn7q8gNXwe56ezMON/C
	 Fx5reL1hGcOyQH57x4e6t0v2FWlmgO0mKKSJiGH8f2g+ew5givsYiv21Cc92cDsIjFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kE4nNfgx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1100606A32A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 12:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1100606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kE4nNfgx
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso1192351c88.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 04:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794225986; cv=none;
        d=google.com; s=arc-20260327;
        b=bDcK157mNfiSJ+fKBV7VuLjN6uZsOgZOV+iwSqiYNbWcZ7H8K/GwaIv3AFMQysQgq9
         DwlrImsWNr++kdYst6CyaBgAiiJ32mzPqAd7/b9wxt98wUKe1uSBOGyFuRQrg++ebrtq
         8fg9wKKpg7Zm5PYcKdlvqBWZPAdsozHIjCZ6vVSbEw2/Mkpp00TOBvujHC09zg2Sxr54
         2ZcegSNTX+/OiAzf0O2rrU+0GJjUHANbuJzVN4w3zAQRQ8whGHwrOul04pGDUIXbfy3H
         +AJYjRSiZJwkegt8ayHA6dnM5lHD2ZaY/uwhiKsvxoa/vd3273QxQ9NTTIgh9Etx8pGS
         /Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6I09XAecJGKqMjJkMAQgPA5ZTJoib5mVxQ1ydB5Q/8s=;
        fh=Ii7yibyY7PCkUmYWVfMq/b/0DDXqIpgXel7IoD5P1eQ=;
        b=DI+xNcTx8/GuivHgAF4GGbsshqwG5ELdgJL3Sc0nGYAjx0aoMPHTvV9geQx5dWhRgu
         UnBgIHRGOZjuH0xkG4kjtAF46vKEc8ee/BMJS/fFbwlvax0k6GBLKOVxeH/YXaiqT3yI
         jx2tXlw5RvQh5ib3otJ89WWZdWPsUFb8Bz6yLlLIzlQSF25C4Z9uDrzX2CQsLyrq5jYB
         6hjpm86PkkiB2/foskLgsaZcwV1vbilWdPNEkQgLxec3VE9UMBvYnLZrYsE7JMpr/CdU
         H5teVXfVICYs+mQYOQUfWmTV9AGehr9CV6Vxr7uwbNiv/tGlS7F4ZDUiV8ji2qAopmjo
         7ORA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794225986; x=1794830786; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6I09XAecJGKqMjJkMAQgPA5ZTJoib5mVxQ1ydB5Q/8s=;
        b=kE4nNfgxxawt21uEzAaYgxIKYn9FliNTbX1fNCpg3VhyEdRfg1+ArWm6ULMkv8zPeD
         z6ruZqFGno1qDUV4wOJ/5jF4LBsYHhdY8rS6WstahfQLbLnYm7kG5Vtd3mbr5IXGynBh
         191ODsPSuszzYtvYVVytJ8XeuAmTyfclH/TPp0IFdqtnnlpuG8ZQTiUyb2AIc0dBZ8i7
         c8FVLjx17hZWyJrNfi0PV8OamSPryc0Cke+PfZjee3KGQwgl17myU1dVM9OZm58L99Ok
         mdkVRJvwkpEbaoZaHz3v/sK5VDTzXeDNj4CCPVOpHUl4Fu2rBMRWE7TLe1e8yPKgwPs2
         CcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225986; x=1794830786;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6I09XAecJGKqMjJkMAQgPA5ZTJoib5mVxQ1ydB5Q/8s=;
        b=hlu6pxphSYLWJhKZF4z+iLnLdBmP8Ww61Unh3mEWfGyJjoz5YQon+yUytSkLPa1Xxz
         EMJXL038ZzFRAoErIt90Q2y+l+/zvCVvI9y8g7yP20jn6it78fv3B33RHbESts85Tj5F
         OMVe9hiKrqglPZ05ia1xLp43Hk9ncA05Sqy/WPrCMY6F+VqKiiQX8TjwNsl+2tlq1X9H
         eA2YS+rcw6aye41ED2fPK7/fcQWpJgxx8b340mMRf6urNyhXr92ov5UtIdgimve4tUkQ
         NsW1LrcaKKJ4KLchD4a09wvm6UM59V/t5lI54vW0LOXvVwHUnMtehIT/zRTaUBHrJ2k4
         06xA==
X-Gm-Message-State: APuU4Z881Tm495MlGBUva8njLkMTQ959l6X7ScNq/vZdiIDBijIwE7Kb
	RSq30DpQAMl/AQNiVl7ztkfzPCsGWHX+bwsUrCeSYBG431Bd7ZLQnxj+xTdrze8xKLNqZZ3R93P
	A3zpPwyRAfDd+S5IcM6pDJVPe4k88wpI=
X-Gm-Gg: AYBFou1jLI7U+spyk8ZacgCm1snyfjgC799jWSClQT1pcxMBaCmsXgeKV/IMCx/VKnQ
	JqqEhUunjPG332skZhnQr/MQjNgWp5gjAPW8JhA1vOwZ7WIiPE+TOocuCjbGqyU2lAvcoLGNOPz
	qKXc/NH0SRGw2mrFydej0HfyhvCLQKjLfKZUlUGQEsE+b1eWqkGshs8NO52iIxcUdQyyKKwxUZD
	6DS0Ja8RMmvwUGla+tODfiUQRrcItdfHQjuJzc6aHDVIZSJ2211hsnKNHU16lvYGGFiHYsMronO
	rcXebetijFPWsqsrBzrmG2T9c+fHCECSWKL/z+QmjISKOvB+duHuAz+O7N/GJJcyUtIilLwUcE4
	dGBpRnZWWf2dmDDWN2njEETeRBoERXJ7EPEx9UxIUmtsMU/NFWc2/fp2uO8MTq6eCcgS7UYVrTv
	/NigQjt/vvvOJJYVkwmN3KRCvajA==
X-Received: by 2002:a05:701b:2214:b0:1a6:4679:6cf4 with SMTP id
 a92af1059eb24-1b39feb9511mr5904040c88.36.1794225985522; Mon, 09 Nov 2026
 04:06:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 06:06:23 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com>
References: <20261107193020.583215-1-jelle@vdwaa.nl> <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
 <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 06:06:23 -0600
X-Gm-Features: AclHuK9mNqyCoHpcYv1uEo26uR-nJ7t4sGJ8AZu9Z5ywUmmmcwoxLj5f2c8nHYE
Message-ID: <CAOLa=ZT_U+gDjdLYkbtqRjUxwHA6q6+Uk4ssznyHgn09xcFqpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Jelle van der Waa <jelle@vdwaa.nl>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Harald Nordgren <haraldnordgren@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: multipart/mixed; boundary="000000000000841f0f065fd6ca83"

--000000000000841f0f065fd6ca83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 07/11/2026 19:49, D. Ben Knoble wrote:
>> On Sat, Nov 7, 2026 at 2:36=E2=80=AFPM Jelle van der Waa <jelle@vdwaa.nl=
> wrote:
>>>
>>
>> Anyway, my point is, there's a lot of possible meanings for "verbose",
>
> That's a good point
>
>> so maybe we could use "--commit-verbose" (blech), "--diff-in-editor",
>> or some other thing that smarter folks than I will come up with which
>> clearly signals what we're about?
>
> Off the top of my head --show-diff, though I'm not sure that's any
> better than your suggestions
>

My preference would be to make this (current patch) default behavior and
not even have an option. I don't see a disadvantage of having the diff
always being shown and it definitely is a better default to have.

--000000000000841f0f065fd6ca83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cebff680c5bc4fc3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yeHR6NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEVkQy80a2NLYWNQc0JxYUp5SWNPSG9wU05vQTZudwpTUjdic2pMY1ZV
MmJtbW1sUEVRcXBwQWhKK1ZsY3RadVE3bVhnMXYxQ2NWWlJjS3BIdUt5UFl4MmEyOVEzaWZICkVt
aGo1TTRDZUxIdUlyRWdaUWZsWlVqbXJDNFIxek5Kcm1ObDBnT2ZMa01GQlByd1Vybm1yeDBGWm5M
YytwRDEKNWxBY3R2MWZqcGlpTzFONy9RdW5kVzkxVFYxbWh5eitVU1puVmJWUW9TN2pJaEhEeDR5
dVVFdjYvSmxDL2VUNQp0RTB2NndpemRoa2ptZGsyYmdSaVJJWGsrWUxGRmRSZDJZaVFSb3VNU0xs
UFgwb2xRb3p3b0F0eGtOdnBZNFNVCkY3MnQxUXJBQzdWK2FwQWNYV2dHZHZzYUk4ZldyQm0vOFI3
WEpDcldocDVVM2p3NFJvYTRucFBPWXQ0Rm5MU00KaXA4clIyQ0FoK0RJU2VJUkhLMmNFLzJ5OFhy
K0RyV29Pd0k3N0ZhLzRkWXVxd05oUWZ1OXBWVUkzZlhNbHdNcgpIMHA1SU9KNnhFZ0REcTRub3ow
bjJISlc0MXluQlU2YVpNTDJRUUJjd1gzeUVFRFoyWE1OdWQ4blMrVU5UR3AzCmg0QUlOWDJVb1dv
emxLVFNVeDVwMG5Lb3hoOGZpT0oxSnBLaklOUT0KPU1hYW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000841f0f065fd6ca83--
