Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FE1A6829
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783199635; cv=pass; b=T4IfzFx7uXdkhZUiF4CICnJEGLmvJHa5QajkhJKtrwRDYPH+RHpHAcGXmFy/T7/OJsCCdKcBbPkZD5JwH7XoBoHdxGTePEcquWQR13CyxDfTCRstiJO5ZwaW1LE87Wq1FZXcLaCdE4yHrmB1v5/zKyYyKJGFuqh+ww4EHHtZbdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783199635; c=relaxed/simple;
	bh=M3SK0lBmqND5099Bk3SDvTFwqinPLhcBvJGKy/kpPyI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yys7M83bpHo73qvAlLpEC9g4O6V4VvuuU9/9VDV6uus6ogVQSViLUm+9NhQOcf6qSUkF4u1dGlTayRzia0rAEbudBze8z/ULuEZ9pCQeW3dOo86euDDjgDW6yUIS5FxAmPcwvLzrKxk11JjwfkH98mCMNO61Hk0L44D1MXGOvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV+kT9z9; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+kT9z9"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-737f6e70678so923599137.0
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 14:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783199633; cv=none;
        d=google.com; s=arc-20260327;
        b=M9xvODlX3DmGJ0Cpi8qRLzy7WY42o7XN/3TdpLf+sQxN6S3AlQDgYf4Tu50NsZF20J
         JKwgC6kWW6i9jSNKEkqfU9cDyPEDoHbEvX9RDMMSSSPgWKbavUgKGapAOzrgXRU3gU94
         tgS+FB+O2L3ZZXfGQlW+fl8JsyKvwAhYNt0UoUSWZcgK6aanPzdmZLvCrqe8ZFMjmPGl
         bQaLb5IIl+VpIf+DE5wirIbMftpZf5iZaDSD9N+l/JcZ3nNcr+B7WLfChhk/LjX4VzDN
         Gd7YNGHlhss9NaYE2l+t/HjWwRCaHen6vEdfOA4AE3thCnahYSYjLgjG4DIrd8cCy81F
         kWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=M3SK0lBmqND5099Bk3SDvTFwqinPLhcBvJGKy/kpPyI=;
        fh=5TEQEIwlkYdNcwLynZ4avXI7cnYSkCXw6fo+zXEiM8Q=;
        b=fQlJL4x8UzdhSs+LA+ZrPqpjVz9Q3L92SEOLd8dR2dS5qIcZa+f7LPnlpKwZzD/F6H
         0Lue1+JQE9NV7og1p9OGdMnQRV/MHEHWVb4mjyLyAOes7LSit3X+oBn4FWGMIKHF0mbG
         pCsrhW9cL5DbtTqXr8gFPltFZaxxB4DeTga++I9EfBoBGIpJ+pF0pzvzR9skEyZ3MK0G
         it1/HL9Unhzv7XldGMzHmykMPt10wZKMYAzrjpa9Vy5uchC3EnreibuwyRCdz1Dkqa67
         LV1P4Hm4OEkfWNgmUb5SGJf42Iwexc0zh0u0iEAyKuoXyvyzcIyGnmj4gtGfwMsBAvJv
         i+qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783199633; x=1783804433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3SK0lBmqND5099Bk3SDvTFwqinPLhcBvJGKy/kpPyI=;
        b=YV+kT9z9gCpGINoRYXZY7MicyqA68xVaReVdMJYfxELT474a+oeST+8CwlZLXk0RFx
         M/n2lcAqCb4l/VwzHFNfvA5wOJ1QB/+uLvHrYGjneHLR7z6r0RwQjKUJ16EYB8ik9Uu6
         usmmcj8twInoEdaVs5r4ruHm5jDKqQimXEWBgC5x0x2OBkbeNddHTXooaO+jLEyraD6J
         VarGWI0PuCQHf0meJJSmV1docrfAOwbF0QVQ3rBdYv9tWXwVdZKQtDCisll8zmiVYETl
         eWMzRyKRnRXq1TZuClOmfm6uyOZNlpbYOORKjQ9mjHNR2lHSo3V7DFBI68Nq8kJvUJtN
         rCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783199633; x=1783804433;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3SK0lBmqND5099Bk3SDvTFwqinPLhcBvJGKy/kpPyI=;
        b=iIawbLM/p06KcBqHtaLgFgL6Nzz/YWZpiGDwjkPZZQcSqhCtZEpN/4lE2XP2VI76pj
         hsmphVYaE2tKW4tc6vO8AX390XOl/ij6gLhcqlW4kVfXo+MsQ+jBiHuGfh9kKTyqoBGS
         txHYZIIHUZjuuuFt5o8AlRbiumOdgFwc+0bJLXiAri5tI32TVyDY3HHx+3Gl8yM9q7K0
         G7tJ8soqMJ6MnifQwl0wJqNBEVSfYAzfZYgj1wJBwAzO3um4l/RZZO+Wt1sTlnYwSGDE
         B+vr68K3XKN/2hHROCoAyA7TfY2kJlaGTYVrXCrZq2Xyn4UCVUVSJDovXWuoxx1oV2aJ
         bGBw==
X-Forwarded-Encrypted: i=1; AHgh+RoaFJQfcIuTXP14ZUBS+tUePPo9muNi8wbKkv64ZjrQb6izbtMPd7xKm0u4S4qDYbGSQ34=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9qPbB4ekvBJUucxarryPQMz7tUXGmEJE2o/t9X80yzJ3/pH2
	wJVceOeqSlxT3uaLYm41MpW76Bk6QfsVd2KvbnUrSt0I/zpDEKpERvELH8zt9RpBHTiGfgKIT9Z
	G+ySP6qCpmZCc8n8L3NvqdszrmocM+SaqCQ==
X-Gm-Gg: AfdE7cmFhvcUFLnbZ00rcuyXVw7xIRBUyvandl+KcTATRSn5JCvS2x3vM7kPwRdEskE
	GLBQY4JlK6fghXKwn1eZ5qRgQuF/3KsSMwxB5zDST6v0YoMitcaZx1IDHXpyMFxLacCXaNLxiMA
	Sc2jA5H/cH5niGzGIz3fzt11Xc813BaifAaP7oEdlO7IVfLxhwQzmY+UEF47qFfyq7Tcnvw9631
	JhtJA3Ma8d5kDNgH2wA2LiVNzASUcbSyHzokG6l45HjcUXGBqhP2BkkTwsrTrL50sAJroWiAYKP
	W8SmFzEL6Fn/A67jKaFj6NP776yeukbh/iitritbHZPYquG7ZFgHcjefHbF7aBg=
X-Received: by 2002:a05:6102:8082:b0:737:ba2e:8a26 with SMTP id
 ada2fe7eead31-7427f037faemr1685577137.27.1783199633512; Sat, 04 Jul 2026
 14:13:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 14:13:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 14:13:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260630063944.GA3733670@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 14:13:52 -0700
X-Gm-Features: AVVi8CfZvxEIqV8sNXeyPL6py0LwWEZByJTfU0cm8ek7yHaT5IbDSU8KypPbx8E
Message-ID: <CAOLa=ZRX9fGPdtUKXhmJF-zm_+F0zDuXSV+w02ZPEzqXY6n1Fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] small leak fix in format-patch
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b84a5c0655cf84ac"

--000000000000b84a5c0655cf84ac
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> This fixes a leak I found while discussing an unrelated leak in another
> thread[1]. As a bonus, this fixes some minor recent breakage of
> leak-reporting when running the test suite under prove. The patches can
> be split into separate topics if we want.

I think you meant to CC the other "Kaartic" :)

--000000000000b84a5c0655cf84ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 114a9e156361285d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wSmQ0NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlZ2Qy85M1Vma1dEbXRPayt0WFdRNTEzMGN5dTJmOApFZ0JnUzdIV3RU
VndmT0Uzd1Rpa0lDR0tCMDFqb2VVZ3hSOWEwSUUwdFVNQ1JMTkhZRkZvb25PV2pGdms1aHV4Cmty
cFlCbDlicWVOYmdGSTM4ZnZuZjVyejRuWDkva3N6dEd0VzNJRFRyeUpPOTJ0MExrLytVUmNxTk9y
b3JqcHMKZFY1d1JTMUZXQWNqZnR0U2JLY2FmVnlKRkpsbkppYVhZZ3NxVUdFcVEzelVzR3J0NW1u
QnRROFJYL1I2em5MWApJSHloSjZ0ellkN2xaSElCMkQ1VEh3MlFFZGxhRFd6ejJXT21YSFBocjUw
WStGSUI3cisvb3FFb0w2WGlkTVlUCmE1NGRRUEErNVh5TVlmR01KVnlwb1hPL2pzY3VTbldOVTd3
UGpQYzFFSFAvUERoN3FjNlVBVDk4T21iVlZ0QmkKSHRVUk44bXdPb1luT2wzZTBvWnJ2cGdUMzI5
cDZqNU16QVVhOVJoN3FYZG1XSGhtVGhObTNzUzlXcTA0dVJBTQpsRkNZRW9tdmFBODFMRHI5MVJP
UEY0UDgzVTNnR2Y0QUZTRHdyL3R6WGNqTlJiTFBoRFNSWHVwVFNNRzBXaWYvCnI5ZFNXaStwU24x
SmpJNlpXSm1pMWNmWWJtMGQwV1kvMWhvSFB6Yz0KPUV4cWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b84a5c0655cf84ac--
