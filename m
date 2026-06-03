Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5875480DD0
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491845; cv=pass; b=YqW5Ku5BvX4uzrKtY+ictDeZcBF9F8VdyPRT/ghLD4HaOcQLiSIbZCLoYibyIoNuE/HWGISQFJmAy2neaJWYEBRxv+2vbVECSaMnRXZZi+WQwxgv5FWUCSW6biGqMnt+rCOD63Kkekgm3oSxNxe05LYLl7pj0KAyM9YQzmBfaE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491845; c=relaxed/simple;
	bh=hgUoPVSib8O0YLzGs2hu+NVqwo3FFQlZnqxWX/1o+uM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIkO8gUsY2kWKhL2e+ztEJheQHuTzfY1qRbwXeeLBzd1/2RHsy5+9pAIOMT5+pM5OI9N8OQf2YfbunafcYEu4YsYoCVj45jwD/tQFacAoYVh/aB09wo3F1bAtyRLzT6xN4tv/gxF8cxNrfZ4bzaU+us+t15jEJeM3UTrFA8mcdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBHeMq7C; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBHeMq7C"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-963a997dea4so4273544241.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 06:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780491842; cv=none;
        d=google.com; s=arc-20240605;
        b=gVmlbQEdxSn2CeSOiWcY4+SsgcV79XduCwi0f6vwDjOva807fQ9U2DESEcJwaVPPYv
         PFD5ueRLh4djDwDTVArAsPbazauLis9kdN0ZctUhNgIUgEKDa4E0BhkmQnwZ9Tm0RAfD
         L20akweR8wWJLh+gevKI++dcaRr3e/Z1fLK6aTlMyVuveIfZrJk1u6HoJKlaPFch7oKC
         JffPH3YadTkidleUxLGo++P93kAN8bUpAor7rI7u8T0cvHMNmU86RbmtX2NaxGyijgu8
         Iuyoo8W4Laac0nKB4yhOCfa/HEhSRrPaBiP5VILr1wfFMYXQrQyb1ZhoAT90s4j0N1CW
         Ubxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2VTpRzEP7Lnr7Qu/L876an40hYXExv5z/+eRH7/QmD8=;
        fh=6Nlt402NqIi2IHiBT1KAkDyS0gPQfsplQR21V+JJj/M=;
        b=jL6SxWm5jghw19QXjZE96gfGGDY5JfzyXIWGMtG86R1ohki+uL7LLc0kvMxA1rOADb
         Lgy7GtbwmqrCSopjeEJ8om4fXuxeH5nzT8VzfFl38g6w4VnMNxx3lc/Tc3CQyo9CBhfr
         zn3zJSjSpZaizomHWCM9R8sl4nLvAKqq1kO/xhOXcronFVKx7/auZLtakAmNf4jgT4oq
         QeiAhWeX+cOM61H0syYH2VPJOSge4ah0oLh0y20oDlSgNk44FWO+chU+y39AUMglvn3Q
         Ls7GDAfpAqXZffmi1XUDwVG0s1Ep+1m2KHE01qPNgXxexPRxTwo+BRPaC+wFUSKITbte
         Tibg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780491842; x=1781096642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VTpRzEP7Lnr7Qu/L876an40hYXExv5z/+eRH7/QmD8=;
        b=QBHeMq7C+DrAfpXpPopOIEDQg+0ZR90kHdm+Cq8OxVuHrCRyzxb896ZAi0diLdxyU1
         7C5zBuIym+i6MP/xtZX8MYEuzPmdMP57Vqu4kZdCY5hrO4MbWAQ+ioTs9CaKrl+oVJp2
         OYsy0V1ijW01NbHB/XRTM6d3xUauVite6weFIaEHiYIylv52mlwUrXUiz3fe+gfSjGXI
         dQwraW646EzmX426PiJ32tcgmksyWV2GFvthwyRNI8J1ADB6DsgURXsmg8W+oTQcCnxY
         Z1m7nCB3TvpP4Gq5jlcKTXMYpDdYutmDFJPozjikZeh5Y42fNJg1wpts2X/7ofP4n8wT
         d/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491842; x=1781096642;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VTpRzEP7Lnr7Qu/L876an40hYXExv5z/+eRH7/QmD8=;
        b=ObG7HHGLaSIMhiIwXTN8+9xbJUdGxhEubhu3wMVo5Rn46+HFkaA8v43JdvUUlJyYfS
         1ycB/QE956mzDozlN/JtoGT+pYx7X5Kx3yuihnXe1+19MYiBLXKd+x6xtr15pSvaZUlF
         0+8FAMAbG7xzmgc4doGEALv17ZTXSorlIlrHN6s1n6lD2qOiy7c1lO8fc9Wnze/vn5sA
         PEoQJJw6r/yJi/ra8mBW3fGbvLD7aqo9lUjsZWOqok+0ObcfFsemXG73TcaAH+q/XojT
         yBSrc4tpTqlNXv/NqqO2n3cHOomwpuZ5UTnIBwzVrGbizbIJE3rav0dYb95taxg6HEct
         byBw==
X-Forwarded-Encrypted: i=1; AFNElJ+uk4266UYN8uLAsxgE9BJVEIhrcWgEYjwMinlmvXzEaIG1eQ7gUW/IRnwCdmnx0RYxUQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfgbzrGFqNIvVCVZwVgUZnWV+v3iVziEJ90qTNUhT+Xu2+GXa
	8K0WrfG77lp5PvNFZk0K/aU8D/mzQrFAig/r8WU4Rq0R1KAKCp7djARKuaTUKZaQCJ+bca9otwI
	vrmGSiZCW5Azc5x1cJKBZhR2ONHgGGks=
X-Gm-Gg: Acq92OFiJyL7TpulNXiOkAjBDFMVEMT0qsQVHFYmxCIzFg9xxkgiWx6FlHkZCaLPeR5
	2FVQeYaB4Bm68rERvPL8hJEEesS6JW84h7lmwGxTLsiDy3+FzQVFWTtyefs/Mz3vy4lz8k8X8pK
	efZje83O3r68lsvZXLgxOuM7CSBL2u9ylQjHoTgesd2V0CGCss6IvdjB4I6/sMcmC24bY4EUUvJ
	avwOpOG2wCdMBClGeZUnQlKoMp0W7DV1sSgum56M4GpyJYK6WBmlNmjJhytaj8ZJj4rPzjhGgxe
	RrmmsJkMx+Xo3r8vwLgH/I3dS1jjZ67QVRUcyocS23ES/VHEpdGA0Pa05HSDAIiQiq4tegTXq9X
	f9y8ppUv7
X-Received: by 2002:a05:6102:3751:b0:6dd:ea46:e3d0 with SMTP id
 ada2fe7eead31-6ec459014cdmr1366819137.19.1780491842240; Wed, 03 Jun 2026
 06:04:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 06:04:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 06:04:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 06:04:01 -0700
X-Gm-Features: AVHnY4IrtS8WHaAAZZeb2kLA-YgDp0fHh8T2iJMP70KTXWl0mZMzfl58lU1eo-M
Message-ID: <CAOLa=ZS4mSHEThYD0GKFXxqDf1Yz9U7pQkXYQJ+54V5C2FPBOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] setup: centralize object database creation
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000c868940653590fd7"

--000000000000c868940653590fd7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series refactors the logic for how we discover and
> configure repositories. Most importantly, this involves the following
> two steps:
>
>   1. We unify the logic to apply the repository format, which is
>      currently open-coded across multiple sites. These sites have
>      already diverged, where some repository extensions are not
>      consistently applied.
>
>   2. We then centralize creation of the object database to happen at the
>      same time we apply the repository format.
>
> The end result is that we apply the repository format exactly once, and
> that's also the point in time where we can finalize the setup of the
> repo's data structures as we know about all details of the repo at that
> time. Ultimately, this makes it trivial to introduce the "objectStorage"
> extension, even though that's not part of this patch series.
>
> The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
> with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
> `the_repository` in `init_db()`, 2026-05-19) merged into it.
>

Apart from some questions/comments, the series looks good. Thanks

- Karthik

[snip]

--000000000000c868940653590fd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 98b87f4e6dfe0d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0pqOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlNNREFDWmpITzAvU2lwNXM3c0ZraktxQ0NGQzJzNQppNHczMDI5eWNi
OTJweEIySGx4eXZJRjJ6SjFTUktTeWVkbS8zZnpRYXZkSGdkSmtDWmt4am9uR0JVeHRIT24vCnhk
SmwvR0xwT3g3YlJoeE5Fd3B0V2hYYlBpc0xjK2pheThOV0pRUGpPWkJiMWUrYXJCclFWdVQ5MWhU
Rm9kMUIKVjU3TGdQVnJLMVhRMnBmVFNtYVV2Z2hmN2d6OHQ0dEtyUGsyVkFpV2NyMDlwUTA4Z3Bq
SDZqT1cxYjgvb2FvVgpNSS9hbkVWR0pzdm9vNGhSRWU4b202QkI2cGU4Lzd4K3cxRlZQaVVYM2VX
Tjg4TlBFTzd2bTE0OXBWampnSUxiClBHMDZnVWxEbi9aL0tGRGxDMEo4RmoyQ2YzSkw0U2VpRWUx
bnV6S0k2ZllSbGZ6REpYRTNmakt5TWxyV3dNY3oKVVNXbkFGZFFoc1VMeEFvUFZPbGRzRkVsa3Yz
YSt4a2hsalA3VHNBMzVHR2QxakJuNnMvNFJSSFFVNzEvcE5BbApGSjNpbzJPQW9ZSHVjYi9oejlW
MkJoZnVja2xRR0JweVhIa3kyUVQ0Z0RZYlhrMHhUcWkvNDM1SU81eStUTVBCCmxDRnhkNnJaMHhN
K2xEdWdXLzlaN3J5aWtMVkNLUHVqWG9Ra1ZpND0KPXZFTGsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c868940653590fd7--
