Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599223;
	b=mHBPfoXnh/+pfCFeoY/E1mTMFOdpLcA5vcM4qO+A/TSU4bGEztsBoHJbU1cWd4AodgIc
	 t6YU4gK0XV8YWa0P8SUayAHqU6eci/H9EXGPC+IcdQpuvP3e+IpXNvbE1F+zcZC8BLXnN
	 /YOuZkfXgKIcKKT7t4pv3/nQz2tTbaw8GoGaHTM1rj9q/QEligCVc9Tp/9IqOSu+3XN8/
	 igunkI595P9eairYNU3KBPx0BEWFedch4nRXaKBNYR31H+foNdfI+GkfYtLlYvCx28jex
	 ORF/OWuontLZMgvLCbVo7vrA44HFs9Ssu2f0x/WXSvYYgpn90jzpAsuKGL5kfpqIERg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j8SFJ+sz9cKoBMC5qNtDKbQnp1npGI8LZAoiN7MRR34=;
	b=NQVodaMgaGl0XDZScW15y7q9hjqM5//4KcPabfz7EECkjExPNrimvlIp22mVA8baDcSy
	 q0u4x5yjKxMdD9vBf/enxsai6sdgIC40HkR+FFAdib0u5aSp+KcleDMvXX2UW3FZuSSx1
	 32NWsoQxWmuV3rAwGP8624LVFlsdrriRKLvCEvYOlktVLzgYdvxat1ZGs6M8T4/9cJoIw
	 qshCRiBzNumjBpSRoOxhJYYzKZokPn1VAg8arYFfsYTFPV2uF9fyFP1g2sEHRLe6bd6Dw
	 GfWLxIeYcTzpjBt7tsNiGAJeXnYTkoYbCLjHbr44zTvfWh+Ns+4YiIUFGw1ztLROXjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ssn8rqtM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF951606A332
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF951606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ssn8rqtM
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so408623137.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794599222; cv=none;
        d=google.com; s=arc-20260327;
        b=ldEVRqfIMRLZXB0km8Cu5KBl+Wvqnx9F+pgIZMch1wrPRnMtNYQIeeIO5In4QM9NIc
         ePlLy53OxmUBqUmbePsmW5YAmlVtbqUFx8bcWi0XJgpVY9OHUpVgL+vAJweY43afx2We
         yK1K3cMfT4AXLmUBQgOuHzewp5GU7qPIgL8vKplSWZceakFZ4zRvM9GBLWRgwR4PEn7F
         uhjnEJmLN6bCIdgZ9hpy3iGobKQ3vYEM0+C0+CYRq4nHYYw0uQbdATu2qyPkh8nHK4WS
         GPnQtzg0LmOOXvpThJhGhzPk3iw2qkV9L2jBIoLo6BgTC8zF9rXdZYmC2KAHTQJMUTnz
         Ln4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j8SFJ+sz9cKoBMC5qNtDKbQnp1npGI8LZAoiN7MRR34=;
        fh=iq5ETLrqhFumZHOFvS/EjcmqsbJKQ5exJVdblLL9nS8=;
        b=kiacWD6V3jbNOd9NJfEuZOSxjjL7kA4oOt42atqgp5oTL1l2IAkJQtwCcYAF2aktjI
         bighxIKQGlJiCicy5uTdnFNhIuRB7QpzS9Gx3o0NSzWMKorsP+duGoOEGdW+4n044Xrz
         b4BdNWf7EZ7ZUn4otNt+JayfAwqJu0nPlva9n49EJzWOcZ8Bx6e3r/PzsyMEZigQyfuK
         H7EML5rTWwsQDH4kV8aMBJnb6YhVbG/dldj7s9SVKVPpsGYe8GOGItUST57WdL6ToAjk
         ImfrrdyzzJ5zZFy5g6+TCVcZVr75kZrzvkMgcFLkxme32klkJgOm7ZPbX8pmcf+H3cWR
         QcXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599222; x=1795204022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j8SFJ+sz9cKoBMC5qNtDKbQnp1npGI8LZAoiN7MRR34=;
        b=Ssn8rqtMZbB2ieHr35Dvg80PrVtnRBfc6IHyEzDEDDDOwV/zNdSidkqGRBEiVECP+2
         ABt0SRdidHOeNWsjbx2RYm1mQmxPKXuuWaqfbAl4WIv5gs0R0f/31KnMqIvRVUSoaja4
         Of95j+dBIe95jMVDSLbsr0LHOxHNZaUkQeXT84bsJQK4moedf6/u1MIVz3RKioznHfv5
         6qIlkPVEkiOOCL52JJZA6g/z7LqXGxzod9LVfDwU8shO2GI+HI2LpvYjx+2eLsAQ3TLO
         MDbJ/G4TqHRBiPhQJod5O2ay9Dz6pnSXt5Pibi4DRiE32oj3elGuvQ2mu5RfL6UhsfuC
         GEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599222; x=1795204022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8SFJ+sz9cKoBMC5qNtDKbQnp1npGI8LZAoiN7MRR34=;
        b=yUaEQlbEcIVEZULKldiScH8tN1o88a4UCAz/AlLIpFXWwqQvNJSBegWco7qt4EomNk
         gJN1CqQDg+AhiM2d4BSOqKFJbSIBk5iZFWKNPK13IJIbNBQY8pfb1e7Y2dM8wfIBIaT5
         D+m+J1yAgEmuYPV/yOUokZvyHGkWiIFDs+aRCL23pNVHcDjdBUtKg2cNCP6ZPJEm5rDU
         RLR1tZnq0g7BEioaPIxQgsVKZZuHWPH/Sb3fgjz77rJx4hIdqYk0Pp1t1beYVEenZgDd
         bqGFBHfFSO/ERf1EWkW5IP1576bq8uiJZf+83ApgDNGiXe9Hf0Crdvg/qdaZJPmT8mzQ
         leDQ==
X-Forwarded-Encrypted: i=1; AL+hErHt7jvQWkxxhtOvos5Ovy+Itz3eICxCeqenB9iiMStmLlmf5wnYeQILwBDiwGLwQzCEHjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jB8P8zx+1TvY4+8A2li65evoAbD3kXyWcB1gk5VIIY4P/mCzP
	IfH4OFk66Zgc9m/HFckewbQTOxJQcw+yjjsAG4NXnRc53gxB/5jukJ1i0QjCNocME42w20/ELqC
	ACLGJIcpiwFrgaeQtOUAmMKb2ohNM998=
X-Gm-Gg: AYBFou0EE5BIjIFUqm6+twgdhoayzVAj2Sfn3X6kYQp+Z2pSEE+UWyMi9GM04WlDb7v
	eOCIRgIaKrurG84mY6fBjoA3SAivsjOv8HF8OiKIvKD3l4A/N2LR9vCD2kpVU7bn7IAhLFC2DBZ
	k5a0qF0TDsNxPy9UlNc/iaQXDCMLu/1ugMNuWzep4qFB0KR8494LPI11hzLa4N8h20pqR2Q6B6n
	sPKFjzg7w0I/1kBrWJqkXj3euUhnSJ7KaRgndkn/WFZJ5ETtVlyiXHRcF3eDmjLOCLV93F4RdkN
	R1QoTGaQhZ6VVM9M/MMsmfhCsq3aWv7UDiZjleWvLq7CiCi8QzDr5I70bm6xDPnardXnYTJWy+O
	mILJBNZ0y1kVuIjGJ6fFA2mVjB/1ifmadRQ+LBKBV/hF6mzeb/31L2GS7ih2uERJylqt2YuiwtT
	iEC4tOrywK65JfZZcE0R5XHtkBR0WarSv3iZTtlXzy9pkRto87J2l1yXQLUFd4dIXnC0xjZV+hq
	+IeH0ELaWpzOw6Juity
X-Received: by 2002:a05:6102:6050:b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7d64d6d2d9amr1033007137.7.1794599221679; Fri, 13 Nov 2026
 11:47:01 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com>
 <20261105225223.1163975-1-yopatatchou@gmail.com> <xmqq8q36q3il.fsf@gitster.g> <CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com>
From: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Date: Fri, 13 Nov 2026 20:46:49 +0100
X-Gm-Features: AclHuK9HsZGLgAsP_38g2KtqIgKaqI6eprR71blCTae8lyB0gjBinAu6_VSXnZE
Message-ID: <CAG7jffxyM8kQMeio1Z9Y6Wa6JsHLUuFefq5XxKKKY-tfhfjHeg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, tangajoris@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Thanks for the reply, and for pointing me to the "Don't work on a
proposed project right away" section I read it when I first found
the project page but I misread it as only applying to projects
someone else was already working on, not to the main problem of the
project I was applying for. That was my mistake.

Your description of the real problem is very clear. I had not
considered that the best order could depend on which remote the
related objects came from, and that a single list would not be able
to express that. I can see now why this needs a design discussion
before any code.

I'll leave the patch as a prototype and wait for the Outreachy
selections before touching it again, as Kaartic suggested.

Thanks,
Yopa Nelly

On Fri, 13 Nov 2026 at 18:10, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 12:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Christian, I thought you are the go-to person for promisor remote,
> > and if I am not mistaken, you worked on letting the server side tell
> > the clients which promisors to use first?  How would this mesh well
> > with that?
>
> Sorry, for the late reply. I didn't have much time this week.
>
> First in https://git.github.io/General-Microproject-Information/ we
> have a "Don=E2=80=99t work on a proposed project right away" section, but
> unfortunately this patch is addressing the main issue of a project we
> are proposing.
>
> In general I think that there should be a design doc or a long
> discussion before we start implementing something, because the problem
> could be complex. When you are fetching from different remotes, remote
> A might want the client to get some objects from a set of promisor
> remotes, like A1 and A2, while remote B, might advertise others like
> B1, B2 and B3. Also after a few regular fetches from let's say A and
> B, the client might need to lazy fetch some objects. Then it's not
> clear which order would be best. A single order might not work well.
> The best order might depend on the remote from which related objects
> were fetched.
