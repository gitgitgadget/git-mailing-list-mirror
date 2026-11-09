Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237953;
	b=fhOhIWswUk5BF86WU47DcTJ3PdUUU+MLYQFVMf1Il21ObQ19w1SfaMWvch9ov+8GQ8/z
	 SWWMaOSa/HFBOcGwlQd+fVXVQa27K4hTWVedYsG/bA7ulo4ygqABc/HWR3iAjha1wlWqC
	 7ZSQD7+jf55eQoNhz38iPG4/GqCqYswfUiJhcBVyXyBWEfveOuJAII9iCiirxZTFzSX06
	 u2LBPehzxwcZ69xig3rWRcQhk53levNCCXtDEnxLle0KTu2Y4jVIZdDQyT2CULr7HS6jw
	 +nZYqCvplO1e1CrOSWtd750/oR1VXIcDiaolCxTyJM/jGq8Ea86ouN6BbmigLvGTjsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=o8m6fL3ks/2/ZPTUNRQGXlkKu4tyr2CXWAEGzZ5Tm/g=;
	b=EWAuhyFjX/H3ZHDpqkmhKElmF/hyc280nURiVdzibyhv3sv/eoC/YS6LbOiLF19oyz7Z
	 UECha5+L210v1FP/TSm2NpC9592QgxnDhwIDcEYe2ZBj1ZTKA4cE4Pi/YC4uJNjfoAe6Y
	 DrDPah53FnnmlmhERORZzOA4Y+nFBRdnL13Lq6BsXcT+mkswFLiSCnHf/fWJ2XN8fltpC
	 Tw/HByzzabGV9X1SqwPgHy/YnmHafYLoFzlA7YkeYfo6d7Z6Pp1kABI5tq03+zOqhzjQR
	 uQV6+QX4ocbpkNbDC1j+7YgkbxXwVU7mEiZtZnNE4xt50o848BfS+MzkPQiBFMSs3RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CP9c1i3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534F606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6534F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CP9c1i3p
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so1305750c88.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237953; cv=none;
        d=google.com; s=arc-20260327;
        b=mHkVmWvDIeM1mGPyw4Eraa4Y0Bk/sGFdCkE8TKVg2hbQv8FXrRUaMuECicKadIGaZT
         pehZidZ+vRyECDsQ93OE0JakGOLSPc0TjNjpA7Exv2/Li+MJEucSI1ea6I24jAzw7Etm
         2gNPWTTsNI2X+6EJfP0HcQ5nQDzQnSGOr3qdzY0eUBRy/J5hct1vQF1dvYS2k/o6jEgW
         sobmOUPEXY5yNBRgu5BkSMJxcFq5HAankF8tjnoiizL1TX5zDBEztF9sD1dcB1z05lMS
         TePbsJSVSFE96no5PtNLMexiP8aP+0I+anCA3Jg17ChWooRcdIbDFwahO6tLI/za/X0A
         9NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=o8m6fL3ks/2/ZPTUNRQGXlkKu4tyr2CXWAEGzZ5Tm/g=;
        fh=x2rrD6B9m2t/o/tFfJxOhtjsO/m/vWgn+ngxM98X8gs=;
        b=rE46mx1qbYuca+wE3jysZbZYb3IsHA18v+SvEubW0SuvErVTYxXINxmr/CvPw+ml0J
         TkMXk+qhydyYy5tItbAPSxrnpa20q8ChySTzQlMxuFwnxRi3ehrfcE8NTI44fDT+dPmz
         HrXJMaxjib+STnK/K/DHDebWwSKkuSNJxlhZP3W9/kHwKHT4gNtggdPc2GaARpxOpmBQ
         eFAqq2P+Gpb3q1eH/c0D+SMu4/GgIoaYHf+yj4eLpU31ad0oFIKIvGRy7V0UX3Mkg7JB
         hBpA1+Hr2EprL/mxrx8T9CEL6VjgV3uCexbvne+xGFi8B9XeT6n87yPMF8FqCF1CrY05
         cWLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237953; x=1794842753; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8m6fL3ks/2/ZPTUNRQGXlkKu4tyr2CXWAEGzZ5Tm/g=;
        b=CP9c1i3pCgF1wdHpnaFgR/NJwgiRiHMYfOOIA7mNCv/5k8I01bysS5bv+rbUieWp8e
         S5KuhaWzMyzbA2spXbydCVsxaFlTx/T0GFLxv1L0AACfhXt6FwHIaOECi97tT301mVnk
         dHC6nNLhhy+5B9UHlm7PfKw0aI0Or39eHYxQlG7+kDoLx1sfm+QWJH2oXNiXC8PAViqn
         U7fjWV+oUFLDPN+yFojBGGNwQgsqM4nid31iTqdBh++3rMt85S4ezFnWku2samrU5i2x
         0CK7hQ5HKSTC3GsEYN0H/UO8apTNfAB/H6M5K4Lr7QztHZHZhz3ZcNXAsF4CnF73TBKN
         ZZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237953; x=1794842753;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8m6fL3ks/2/ZPTUNRQGXlkKu4tyr2CXWAEGzZ5Tm/g=;
        b=IhfWyXMjc7yOy5rcaTbjQ3PXCSH3+Sm3GXLwn8xqG87Chg9Hpv/wfdmdZkLWdUuvX0
         NutUwvFaU1aerxnF75oRT0yvrnmLsnHC2OxrbW+BjeQxlV2/+IkI6gywyDSILQf98+F1
         QNe3E4x6mKvLR72OMYFzaUI2Z0a99iBGuXpTzw+H6OlNprD3KOtGz1W6PxWRiMtkpoeE
         N8KNl4bOWsG6Z64EZvXr29DFZa4X8cZms43oEZKrIcUaFTLpuHy1z85tYcpDJ/H9Boq9
         bZMpJld1Qn+qiy0H6bR03KJzs2coOeuNWp1hLt/zMtWJTpbTQ70Y6Ax8RoO/28zU9Bdp
         VyGQ==
X-Forwarded-Encrypted: i=1; AL+hErHWLhmIMd2Ej9FWPzBuFfGMkyrMebFzi8RJjSsD3MNLreMRTvbf/+d5Bp3SA/wJBJ5Cn8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uP5oEjpvYWqfbt8ODqv7jAUTUzlgtUXtOtKnymvwJPd32jwRi
	W2/2QbUo/6lyzh4bZu5dESc7wTQSR92nTv5jVzpmwWlmQwOIJqjEpr/EfJlQJgOwXlDSMeI7jEv
	B7OCaXPXwYuWF+xvQdTlnJ+6yoJV5Rcg=
X-Gm-Gg: AYBFou3f+A2cdVrxhhE3CM3ebo6wNR+x8CAaV6gb/J6PTrnE/CfIjQoJU9X+B8w+yyi
	JbtdS5bnYKpcKVq/Mxu4yQRbYKfpKgdmGuTtWla1MzghY5QQ5YfIBOsfq/qVIYPzuTmu8QaSegv
	WGOCjW5bwFV6UGWuoIp3dPCqZmWX5MAiMujiwZTNs3vFfAwcPK80E8NIFF5Edz+z0kTcxZ6Rj+B
	JcbXPhMqWQoY0k8+P/RkkVMcdGPXIGJ+Y3sdMV2uaL3NgSdgMaJsO9dmHrVS/iQL2GHUaKvdELt
	nKTfzVCI4qMPhSWL0R+PD61/hL9225R9wpMfzwcVquITX/74Wfl75Xo7IPme8E9gxAPyEfey9YH
	68NJFyzCsZDHNZEaAWRV8XKTo2LXXgHuGzY/J3WXCIbN00mrE5yz6lEg+56ojJ3lX5U/aTfKfGV
	XUeUNDGwZ9kQwVur8dtvcSo5oqXA==
X-Received: by 2002:a05:701b:20de:10b0:188:ea93:6cf9 with SMTP id
 a92af1059eb24-1b39fed6d3bmr6273710c88.43.1794237952452; Mon, 09 Nov 2026
 07:25:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 09:25:51 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <avF3yR-PYA3_Ih3v@pks.im>
References: <CAH=d44co_ZFA8EJwAoFL4=88ZqWzO65_+GbHDZfjG8amR4cHBw@mail.gmail.com>
 <avF3yR-PYA3_Ih3v@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 09:25:51 -0600
X-Gm-Features: AclHuK8rfg4xQWglisZc6r5VjUMwYvrVuOa4KXewozAoz9bwYov8CafWdxGAkYo
Message-ID: <CAOLa=ZTDwMgOLPTHgkcX=pULFHWSWkwOQoFYVgnL8r1trd7D4Q@mail.gmail.com>
Subject: Re: [Outreachy] fast-import: Use repo_for_each_pack() for duplicate checks
To: Patrick Steinhardt <ps@pks.im>, Joie Joie <soniqjjj@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ccf16e065fd99369"

--000000000000ccf16e065fd99369
Content-Type: text/plain; charset="UTF-8"

>Patrick Steinhardt <ps@pks.im> writes:

> Hi Joie,
>
> On Fri, Nov 06, 2026 at 06:44:49PM +0100, Joie Joie wrote:
>> Hi Patrick,
>>
>> I was looking through `fast-import.c` and noticed that both
>> `store_object()` and `stream_blob()` still loop through `files->dirs`
>> to check whether an object is already in a pack.
>>
>> I saw that Git already has `repo_for_each_pack()`, which is used in
>> places like `count-objects.c` and `pack-objects.c`.
>>
>> Would it be worth using that iterator in these two places instead? The
>> idea would be to avoid accessing the files backend directly while
>> keeping the current packed-object lookup and duplicate-handling
>> behavior unchanged.
>
> No. `repo_for_each_pack()` was introduced as a helper function to make
> the migration towards pluggable object databases a bit easier. But it is
> ultimately still flawed, as it assumes that the backend uses packfiles
> in the first place. So the goal is rather to eventually get rid of this
> macro altogether in favor of higher-level interfaces that can be
> implemented by arbitrary backends.
>
> For git-fast-import(1) this will be done by making use of transactions,
> and Karthik has already started taking a look at it, so I've Cc'd him.
> For other subsystems we'll need to investigate how to do it properly.
>

Yeah, that's the idea. I have started poking around a bit and don't have
anything concrete yet. I was hoping to send in a series cleaning up the
tests before getting into the weeds.

> Thanks!
>
> Patrick

--000000000000ccf16e065fd99369
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1a414ad7323a7341_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yeDVmMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekRwREFDaHg2NkNIellBWkVxeG8yVWhBeTIrTUFubgovWEtrZ0dEVVhB
cGJaTFZoR1duaHNmK1o1WFZONGxoSEdHVitrTS90dEtsOHBKVi9BU3prRkJnUjZIYURYSUdGClRo
QjRacCsrSTdWTENJU1RRanBneTQvbU8xWFl4dmp6U2h1RnloRnJOeGxxV0ltWHhnSzJxaFBUTnJY
UU5yWjIKRzZtUS9FbVJLSk02dmdYbXJTdGwyV0JTb0tUZ3UyQlE4UmhYMVFqMGFaaDhRSm41SmpE
TUtVSGs1ZG1FQVdJMQpuMkdjblpXY2s2UzRMK05mVFNOZVozUCswUTJrVHdzczlvQk1QMTJiaHBM
bUFVcDlWVE1rY3A0eWQ4MElyQnZQCnhGN0NWR3Q0VjdSazVmTDdnUmZnSXdJNVYwQ3g3TWVXeVJ0
a2E5NUhkNUFTRnNtMzZDOUVsNjdIc0g1TTNrRjYKQUtKbUwxUGIwbkxiTVo1Mm9wMjFjbGx2WTkz
ZU9wZzdoVTRYSS9DeCsyUVNxY1lrZjF0UVE0aVl6MzQvRzN0ZQp4aWMzSG1KdUs1WmdnZGZiZkZr
WVdFbjI3aHh0ZEo3ZXFTbTZZbW83L2I0dEp6eE1qSEFHVU9XUHpRT1JDZm5UCnlZY3pkaEV0N2l1
YUpZbWUySnlhWkFkQ1I1cXpuWFJqVDM5ODVLZz0KPU5Lcy8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccf16e065fd99369--
