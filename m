Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55020187861
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561222; cv=none; b=MQ2kWxtmQ4jML9RCeVS8RQ+mAKUQC5kEa3jT7cS7MMZZJswCU8WWzIOolQak90WkEqbm24s2Vq4tqrdDtyfIJ3obWfx0sxTCQ4ntiiXn94AVHq4PTG3N5GobIJ+Uoy8HFQZvVIiDZLcg3UcFHorj8XOMEJdpAddqkYiIXn/wNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561222; c=relaxed/simple;
	bh=qrISDgOSv3REir5KrPPo1bIj8zpg20GYye2bpiMJauQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvKfOU0hl0f0rqSbj/ZdvpeER3PNUI0RX+90Rt7ztOsZIbY1eT7FwTfLqy0LYeE56QprwZxEDL9JvgEUgZOLXevZ3bLfIPr5xQWugfchzhdrb7PcDKBwY3Tx99KQ21EdAYue0MWrex/3gNl9Vazwlbj9XZmItGzCGCny+5tKudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b06e63d288so28660876d6.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 14:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720561219; x=1721166019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAYPQLW37E25J9oaZErpQffMT8GtHVbt6lbrj5ZA3N8=;
        b=OFrcSvlhBMcFlaDon7KWFlm+pZr8mKpv7xT1OwKnrCJyJL2uwJJiTtk7qEfBqXdKvT
         a8rglEy7sRv+NSWFp1eJJGV8u3EnU49DA/LLpnnrVhBhDJMHH/GdJJSrVv2lM7D4ABAA
         IOozUQqaFIeNx6XmGt6lmBrSGPaTP56ZVMZ8cfz/WRj/ZV6pXCSYALHpkxDt9otZ3PEJ
         oHcXlAEtbU84s58jVvqzY2tjQPHfakQ29Owa0CGUWx4DZ2+Yv36qJKKSejpPJkFXwOtc
         0v7six3ePLWvYAgdPZI0CuvyhISX+fAFZdEuxeCz5RM2TQOscFZ0hUq/LVY9/37ondym
         pnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxLIptVSb2HDQwp9WoL1D/x58csq4PLGcYC91ntlW4Bj5ocvhgowTHorJBWZdbycgQcLL/S8mOQq3YSWTneQd+7m3S
X-Gm-Message-State: AOJu0Yxfj1nRFaTbdVSJuwT+hsnLtnCPGQq+ts7Pfl+5ZMTGxWL+TMgI
	D7NWC4KceK+OHea2TgxyUlZWfJgjDEW01FMlqdwX8/j2v1seKgB1cZu4fUZGvk6Ny69gm/m6y+w
	ETbYY5kbFPmKi2x1XOnJbIe5nC4w=
X-Google-Smtp-Source: AGHT+IF2/Z0gTfY+isQlrLYS9YEO26LYjpDC37H9wGLOxjXx2g06OflKLNuM1iyAyZ6l8krkJj209z/ZAYaUQ2QugT0=
X-Received: by 2002:a05:6214:482:b0:6b5:5002:11bf with SMTP id
 6a1803df08f44-6b61bf610ddmr45440526d6.39.1720561219289; Tue, 09 Jul 2024
 14:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zo0sQCBqyxX8dJ-f@ArchLinux> <Zo0uiz1y6hJld2Rv@ArchLinux> <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>
In-Reply-To: <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jul 2024 17:40:08 -0400
Message-ID: <CAPig+cR=RgMeaAy1PRGgHu6_Ak+7=_-5tGvBZRekKRxi7GtdHw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v9 3/9] fsck: add refs-related options and error
 report function
To: Justin Tobler <jltobler@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:30=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
> On 24/07/09 08:35PM, shejialuo wrote:
> > +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> > +                          const struct object_id *oid,
> > +                          enum object_type object_type UNUSED,
> > +                          const char *checked_ref_name,
> > +                          enum fsck_msg_type msg_type,
> > +                          enum fsck_msg_id msg_id UNUSED,
> > +                          const char *message)
> > +{
> > +     static struct strbuf sb =3D STRBUF_INIT;
> > +
> > +     strbuf_reset(&sb);
>
> Naive question, is there reason to reset `sb` immediately after
> `STRBUF_INIT`? My understanding is that because we initialize the
> buffer, the other fields should also be zeroed. If so, resetting the
> buffer here seems redundant.

This particular strbuf is static, so it needs to be cleared each time
the function is called.

The cover letter provides an argument for making it static: that this
will be called often, and we don't want to make a lot of repeated
allocations. Personally, I find that argument rather weak. Why would
an error function be called frequently? Is this really a hot path that
needs to worry about a few extra allocations? Also, importantly, every
static added makes the code harder to "libify", so making it static
requires a very strong reason, but there doesn't seem to be such a
reason in this case.
