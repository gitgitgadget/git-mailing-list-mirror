Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601E389107
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427291; cv=pass; b=IAJ+/zTPh8BzRJwYEOX17wQcaiOlrz1UbMQUP0fqUwjBzeVoVZBUtJc1m4PZ9LdlIu4ZyGqpmnQiX67CzUscfI4G/GfAxHt1vLFWIZqSv9qy3nx6ryy8ipbMotYiTLhzMunOKprYdhnZyxlXoYqZEwj3DqoHCWRpioOI5F05uW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427291; c=relaxed/simple;
	bh=xCDNWparFqFJhDW4fwzwVzUo/a6w69M6nInRRZj5Fck=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKTfmpdyBafaiYW0aFOKBfzTpK3xkD5QWuoXA7qPxWcd6Hrctq36f02EkXjgjtQL+7j1o5C0f3aDz4eTYbmlEkWOkJJwUl/MaS3RYfU0QjGvwulPbjpLoKVt9LmHbEVyO/4Po0S5b612qeBB8zo/C42ls/IFIN6+J2lr5youjuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJDrpXmT; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJDrpXmT"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf959b820cso2030960e0c.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788427289; cv=none;
        d=google.com; s=arc-20260327;
        b=AAcK1Cgs4XUz5pe3qSbGmTZcTgeeWQFD5QWUGcax/TPzelCDy34/LqphJ5At/+sgp8
         Xgrtmeec1ZzoQeX2icCC2ASVzIue2QVzvp9CsknIF//AT5JrAk77ltDLQHehcJy5pb0J
         QDPyWcVOYsTgYfgT8Eakw84SIsp0o5oxbK6z4AqmBxRMpuXbfHaFyzJoDsKZWa8ybhT8
         i4LxXaefNOK6q6jB+7aiEiBn9k/rC6Rb4xpFi3SwRD5u74nsLuv+9Y2vEKj3+OJ7YNDx
         717GC1qFNo2TPpNIYzaW7EUNAKd5Yuq9Nc7OcrXUvL4IYaAho/eELxoPRYFOtLxAvg5j
         lBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/8zNKoD45CCRn9l+48OMr5nSYfXfaUPYeqvNxWJk2iM=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Qu1CqUHlLZtywwKha63YH1FhFkSxBfRCdTBBa6kCmLHaG95bUKLBj+F2bAdPjcXf4v
         yQMw5t/0ayVn7EWnPlEu4WsrTGjTuvrLfvNFObI5okgcaRfaBdqJzMb0mrT+Hrz587NY
         Rj/cTPt3ywjmFIn8hDVAI06cL2BprAb0+Z2YyHtOiqSQLnVZJEYD570kvm27KeejB4Eo
         CxWAGigHZjOImRQBu7/5SQtgV07uaq6yOXTapmWhWYaJ2xZoZZ7dsEcmX0tZJi8r4Olq
         4a+wvjQIH/hkYALmLUsLfg0HU1eZ9byB1+3eIEF6/zbDZNjWa3oXMfETer2MeKECEvzY
         lLyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427289; x=1789032089; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8zNKoD45CCRn9l+48OMr5nSYfXfaUPYeqvNxWJk2iM=;
        b=JJDrpXmTnMQIqv8nX6VnsBJBPkxvHuHm+1Ocr2nLL6mcpm1KzoDLNAbWG6njbAqIa/
         xwWrFiNqZ0entJjygN3yHlKtZNgNVpRjXzGAHsWxQvWnV+Lwuk5xZ6EX31QKRNf+7Muo
         YLCFz5CukmkU9p9xZUurQGLuLmDOUinRV/secQBEZE51hDbXWZp+ggGgHe954V1uE3Ex
         DXlL8Ax8C7sIthIQ0O3DIFK72EJ18f+MqIQjm7OP4YG7OVjUGuEH41B3h0pr2CnMwiPm
         avs8WXjtrNKHG6AOe5jxSDTAlATmfBHZkoBXwxLPtFvsFiqZLBv5CMyx+9WVgxptQ9TS
         XkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427289; x=1789032089;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8zNKoD45CCRn9l+48OMr5nSYfXfaUPYeqvNxWJk2iM=;
        b=jv+h+Zq2qLp6d1fODeuX2R6GPVnb9wIaTbBB8ibqRMNfzY+3SnoH/cdPrS5I8kirFO
         9x8lx4AWUgEIHN1N1/LHszFFP0kRhEXnth+v5woLwzvDU9sCwR41hGlyFwzycGxRlkdz
         ztHU4lzkzHR4GVV/XqDA2cjdg/kBQTo34TXVmQy3IJuOtprABFcBNRJPXFZUhPqs53fc
         N6GExPCZn+ejBiIxS5q9yPq+3LqKJYZy10aGFMLab1/b7mnNa+ZImJ8Z4IjSGri9+y+m
         J/w7Bs54wBJAnqkZNM4Ut2j4YuAga6EwKrKGYHfyGL1jNU1+zC9Fhw6BBVFoN1AtqA35
         J/SQ==
X-Gm-Message-State: AFuF++nOQGUB0xiPnry+abO6FAE0MN/m8MDOWNQpIqDM185RiMAY+IMI
	6JU1Fo+/Y9Gxr+oMU/oBSHN9I5TEj69MozmY58aVyp1YudYuas5d2WuIQRnx5QDzW10Ly3CJYpY
	J1YxGqXUFNrYCQdhzWNt65MLKhETYibg=
X-Gm-Gg: AYBFou2V9phPBStvvXjUHz1b8sjrCav8rHQ/qHdVPQGUCv2X9HgpaZb4ZR22+degtII
	gadTw0G3E2cHBXtOKlUHZGHShU70n74xxMwFyrkS0LFwH71NUO38TWFdq3eeWZnWsJXshHRgihD
	mbQGS/Rc3OR/cZgicF2rwc6I+zpCKIY/ioOg9S/cN8ze6kjp8994euSKMLrmElbfhaqWG0Qa5n/
	cRzv49P/sMUfm7TXgDMvW1XR3g2MDftOmyGWUx9Q9RXOp/ekwZtvV+kO8D8tIv+eC0zTmg+xcgT
	oJZQvMrepWftVDcBJ+5kaM4OdB+5s7WufwkA3X6c8CKXnQ42xiJeuOS1Yoxn/V0mYXFf5gqtRo/
	p/mKpNRmbn1Hs9z0uR3JyJ+h9T3TI5u2ktoI=
X-Received: by 2002:a05:6122:794:b0:5c7:a844:493 with SMTP id
 71dfb90a1353d-5c7d235ddadmr4723666e0c.0.1788427288621; Thu, 03 Sep 2026
 02:21:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 04:21:26 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 04:21:26 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6efff9l.fsf@gitster.g>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-4-gitster@pobox.com> <CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
 <xmqqld9ksw26.fsf@gitster.g> <CAOLa=ZSQs5umaTxT6RKQJdnnAEbK+AHgj0n5yiTM0jsbZcyiig@mail.gmail.com>
 <xmqqo6efff9l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Sep 2026 04:21:26 -0500
X-Gm-Features: AcwNN1XPZ0eM1J-wqyiwKXMlDzcZ2uNhAOcvUUC4TdgbpO324TslaOI1xWDHeAQ
Message-ID: <CAOLa=ZSeVEAxmckAmApQ4jsOnQ9=nK5+H0-10s-TmFWqGU-URg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] checkout: validate stage and merge option
 compatibility in checkout_paths()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003edba7065a90ad72"

--0000000000003edba7065a90ad72
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Sorry if I was unclear. I was stating that the condition udner which the
>> check runs is now difference. Previously we checked `opts->pathspec.nr`,
>> but now `checkout_paths()` is also entered for '--patch' without any
>> path spec.
>>
>> Having a closer look, it seems to be okay. Because in patch mode, each
>> of the combinations is already rejected before in `checkout_paths()`.
>
> Yes, that was why I did not see what difference between the code
> before and after the change you were concerned about.
>
>> It still might be good to have a sentence in a the commit message, since
>> the guard did change and the reasoning why that is safe is not so
>> obvious.
>
> Perhaps.
>
> Having done this, I do not particularly think these changes and
> refactorings are all that useful.  As unit of reusable code, an
> entire command (like "git restore") may still be too coarse and
> callers would want a finer grained control out of "Git restore
> callable from C programmatically, without having to go through
> run_command() interface", which means the caller has to still
> formulate argv[] array in order to call them.  These 8 patches may
> give us a good starting point, but it merely scratches the surface.

I do think there is merit in merging this down since it leaves us in a
better place than before.

--0000000000003edba7065a90ad72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8822de60bba5abd4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWlBCUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0ppQy85RlliLzB1NVloUlFVUWlWTk9kUGI4R3MreQpaaTBNWUJ4bytG
NHFWUG40OUhPVnBMYUd4Z0o4MlBNd1NETTlnbUIxZUNzWkhqcDlqMTdVTUJ5SW00ZFhpbFMrCkl2
UHlHRlZiQ2lwdm40L1JDeW9GS3BINGVNL1hhUHV1WmkxaVRRK1cvS2s1aXRSbnhpTkZJTTIxdk0w
dHBGa1QKM1ZkM1dFOENvQ1prdUR2SGlLR0pvMHZjdzVxZXBHTHZTMmwwd0R1SkxXUXVsZWwrSVVX
MlZWMTNxZjZrT0o0QQp4YURTODJLbm9RMTdwUnZnRGJRTmM1Lzg1dXlicllJRVQrNnNLNUNyQ3Np
VnJ2ejhFbGwyZDAyVUlaQlZKbkFUCnREakdoR1crdVdldENQeFBGNWRxaUczOWZCRWVmdTlXL0x6
Z0JRMmpZbGh3UEVGWk5qSEp4MzJmWXhKZndaZmIKR21WU0trTW9HZmNuYXVLNmFzakNqTSt1UEQv
dnd0Nk5ZVm5oVmxJL0p6VU4wa1duSnJ5bGkwYUx2TVNmMldNUwpORk91QlMzVi82anIxUlVVWFVU
bzFoV0VqWkZqeVpjaDhlZWJ5dHpVSVY0YXBHZEE3WGhlUzJQZDV5WEM1bEJiCktLWlVHSUFndStV
UExpbEorZU9KbVZLQ3Q1YzdzZzZqb3V1dlRCMD0KPVlHVEcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003edba7065a90ad72--
