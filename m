Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723873;
	b=ZDEM0ESPEQKuL6BdLRQDyARdEOr7uyTGlF7oVH6qMpQu6ZPVnoruDghX4PkR4J7cx5dK
	 lCou+KIz5YMeCW/ZQo2URiwjlv3i+QIDYZGRwizIgBa2P0F0KEL9EHHP7rb+Wqn9WSIZt
	 5ZLakYPVm/eHgnSFIOg/dFxWQVq8Eat/bzYg7ixG+IZnu2FxPShfhwLzEJCkeWAtPGP7z
	 zEK4Ko574Gv5W1caqzIDdL1qjLxsQGrQK8jrDNnm2Oq/aPjunmsfWYiKou6AGQM/vQMvQ
	 9xXpuZbwtpkpQrs+pkuW2SeJhPiRg2Nvc43uftEH+7n/2FpybILdxecwr226M25ZXaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=5T1yho8JPb2m9Hup02IW8LcgNNlcuCo0BMr2ti8G42I=;
	b=tNkQn3/VVTgB9HWwdxuvzQLTvVm8HJzYhbcXE4jNxNfNy+u3DxtbfiWvnwIC+0aZOXKe
	 Rhxe1OMXjqNE0rir0HWkaqBQxab/Ytv0455aAW4vAGmLckvQpGxeLSlFXWiyF3B7KLpjk
	 0p4Bk4wsbCmVGZlDqlct4xhZri7BMa2tI5kO4eOBRKwqzAGg9gjMd3vv9gbRNcWp4JKav
	 UpmRJ84Lx/sUVHl944FtZ6pYS6fRUD5dAvCGYSbN38bJoNGnpUqnfKn/uC86WRza0wfX/
	 yV9v4mhSQvmbqoEhhYcLX3JbolTYvlPxMo/F0A8RNZPDbs5Xv0oBMEdvxpiLsmirJOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzm4IhL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1F606EE98
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A1F606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzm4IhL1
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c3cecbda48so930817137.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 08:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723871; cv=none;
        d=google.com; s=arc-20260327;
        b=feYCUARngenD5n5WD7Oe4vUkE3+MSHykFI9UT8HaDvbZeFLLmAiM2v7tyVuxsR9jYw
         RhApZFDyvu6+RgHSlGHgVe4o23oX6KzeuXpUmPp5JVwLpoHPiYzgJxooY1DkBLmvZrw1
         GTrrPUSXygjON1yxmlD3mW/xgAy3LeMsd7nYcV/LmSfUUPF37dsR21Brxe8H5GnMMo56
         jeXtPbniC1xO0PnijFLFqybu+AEfPs77yd84vlhQLa0csxqayjOulEdrRHvGhle+TjFS
         YauIpSzdWghITxN3ABVIHanR1C8yQQAplAuX4Hh7f4c0uXfJa0hvZIUImdCrZRYqKw2k
         GTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5T1yho8JPb2m9Hup02IW8LcgNNlcuCo0BMr2ti8G42I=;
        fh=PzLrZRsXB/CQU18k7ak8aKtWfYnEUBP4hCYgUCOcUdM=;
        b=N4PdNsOnioCZAcIXKZgDeq66oMls35tFy0xB5ByKEk703Y6n4cMaifkN9Jde5yF9FN
         KzcvrxEAR64cbt5UaQeJYNC27BFTQBn933djlIOSngypipWKgjH7pJsvPBcuej1w6xzp
         J4Hg7ecI+BydPe6/1Y8g29bjPGvnvcMs9zvWNf3/cEpT9tbRSGGQTNdePpDAbsysV9T7
         gFK/+IvCibzUkQo4MT8bBa5pYABgp6obT4CNJyrEN6Z+JCv8TUp3kjYSw87NJclC+hBB
         FYNB5fmNAAqDitFa3yqAHkamjUcdnv5ioc6/8Y6jxnOAHFnEBy2hfrlJkjayJBjK8RSG
         JKxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723871; x=1794328671; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5T1yho8JPb2m9Hup02IW8LcgNNlcuCo0BMr2ti8G42I=;
        b=Xzm4IhL1PZW8I3fxULVpk33nIgsnGBMhk4kxOocgzrMsNIax3a/lh9APvKv+Y4SZ5Q
         7J1oG8fmYAHT7VfiazLYHK9Taw5ogcvgGyPUteaQOWWm3P82SeQBXnHK2vlI8LqnWyNj
         0eUatb9LBMg63I9yL58Twrr2h2UM/XGRBOk6rXDlyvpDorLZU4Ak2bBeuzOfEGxi9nke
         Z02rrit6CLs7p3RFXJpxSHM9brKvt6Xlw9DW9xsfGnSt1nTTB3EJ6ZR7wwraJIl2iLWA
         m5JFyslKwk/XWzUy9svto+O75s/0Dp1Xo42wZQPMdJ/zkGoFdyQHhVvX4dYhIkmedDqT
         RDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723871; x=1794328671;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5T1yho8JPb2m9Hup02IW8LcgNNlcuCo0BMr2ti8G42I=;
        b=seLupie0GoGsvPUsFLiR58FvNVCizZmE9lG83fnwr1LumFAqdsaD8yS4SPUVP5QAnw
         4h+5oPChHhq1FeqQvDHQQqMxRXwJcur4CNlkvPuDvclHw3Zo7tMuTKOqGPmAOt4XOj0q
         d03Srd0iiCfeJOBNH37p8SlUkw7+XhsXPF5oWe78/D+9IWOBUkIxgPozS5lbND1DKNjX
         dgwRoC8AEzaYPbu+b6NdCvYOscmzpiopPO+UwrkEX0OHpbItZ9w3kNbr7xn31oQ0p8AI
         r3NeofMZi9OQQohveHxJIxoStlVVFH0szf8/yiLO/GfBwDcdaylpt89p0kAA9y2Psefl
         IuMQ==
X-Gm-Message-State: APuU4Z8t4yUQNmC6ZwmduFTwgtf+qqK391qwDjS7p+pm0y+qtm0K8mn3
	AKt46qzBb8z4Ge5LjclKSET3a6LMl0DZhxbRPXT3f7cP4oSAgcqFAoF2XZjPM3AqMhx/Atq+QBl
	v3JNgpv/o8G7iBosns8i1om6aPqkDY5gBAg==
X-Gm-Gg: AYBFou2tw7Ll4PrW4uJtpM8px/8ZC6k7CDyQTwjtl3otlVU9k/YGLMzPOxD5p/wFjkS
	9wPa0XcjpWu7/up//wPRbTEAXUb++JiI73Zbte8GtkmbWZbL4CAZV87dZxnv99Yh1l1muZ1puvT
	McisqIk4pKYfnD66Og4iRjGefhrSfLvCq2HC7XbPwiSTh7NW3AnhJCuqtS4NjGhLwpcB5ZRXtmL
	ysrefJ9gcdSJBuQFIMwK4rprK+/0mrPD3Prp4zf0VHjiqfq+HELHIugbocnq4ACfS2X7Vpiagte
	C38B9/DRPFprSug55vGnVBDY5V3fa0p7PWvT3xYzfYXwVoPHWPl3G/SoT19qozlIs8ntbj8/4jE
	DWwo9aiWpi5nWOOm/cZ9otP5StUT76O8DZ0AhEqP+VYhe42P4wLGAA1Usg2/Zh7t6VxRt6+igEf
	fcg26AT9Hvxc2aCfRyei766upIOqo=
X-Received: by 2002:a67:e102:0:b0:7cc:2086:34e0 with SMTP id
 ada2fe7eead31-7d0728b1cffmr4146637137.4.1793723871489; Tue, 03 Nov 2026
 08:37:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 10:37:50 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 10:37:50 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <auS6c_Ov1JOUtr4P@denethor>
References: <20261029002413.3291184-1-jltobler@gmail.com> <20261029232220.1245827-1-jltobler@gmail.com>
 <CAOLa=ZT_ZNcXztxE2gmTORD2o72f3u2i0Ptj5tgNzS54_V1MTg@mail.gmail.com> <auS6c_Ov1JOUtr4P@denethor>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 10:37:50 -0600
X-Gm-Features: AclHuK_hdfdY7FakdKMCPAfc3qJ2tLbAw6ZBrHIlN1x307ov8JiHopI-ER-jmts
Message-ID: <CAOLa=ZRBdgNZ2D9B2ZFhMAOJc11ENZCcw2a7NhKtkv07t4VE-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with batch fsync
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000002f91ab065f61e26f"

--0000000000002f91ab065f61e26f
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/30 07:38PM, Karthik Nayak wrote:
>>
>> Will dig into the patches...
>
> Thanks for the review! IMO, I think the suggestions left are probably
> not worth a reroll, so I plan to leave the series as-is, but please let
> me know if you feel differently. :)
>
> Thanks,
> -Justin

It's all good. It is in a good shape already!

--0000000000002f91ab065f61e26f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c417e7ea4622b0e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ycURkMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkpOREFDV1lSVjc1b2s5ZENiOGMydmFIMVpCSDh6NwpPOCtjWGhPMzA2
eS9UQTZRNkNPVEZCVnN6NHZGRnhDTHZ4S2NnNjFmMGY3UU52Y3ZRWWFJVzNKR0FFV3A4amdWClJw
YmtnbjVsUmtDaDB4L1QyNjJWd3pUaWtKTE0zRHVvMmtWZXowbzJrS3QrUHhYVzhma3NmUUQ3WWtX
c29mZ24KK3VtMmQ2bGVTU3lMN0Mwbjl0eGNEaE14akt0bkEyWmwvbVdjUzJGV0dmeXVwQmtSdjFq
UFZoVWhrRWZxYkVOQwpIZlFBd1ZNUTRkeTZHM0laaUU0WndlRkFuc3grVGc4dHF2OGdmUTg4bUp2
Sm8velZHZ2Fhc0w1VmdEVVFOdXN1Cnp2eVZGSnkwK1NlYTZrWktCYk9jM0FmdGorYlorTmVHMzJQ
ZFkwRzBaV05qOHdYZGlXL01MM084SDZIRC9vUzIKQzY4MWdLWUthWmFkaWloZWsyTVN6dUx0bkV0
YnVXN1JvTUx2bFRQUWtmSmlvdis4VDlCK25uT3JpNGxLRXE4MwovSWN1WURXem9MNlhpeTRHeGxo
cWlCSk8wTWdGZXluYTNQMkZvdDE5b2xET1RnYVp0SGdmMTZDclRxRzlwalNmCjJWVlBoN1o2Qkp4
b3pGY0QxQWdWcWVVTHVqa1ZKUXpvMW5QeDI5WT0KPUx4dVEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002f91ab065f61e26f--
