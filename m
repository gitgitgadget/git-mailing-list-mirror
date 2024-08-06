Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8B29CE5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965900; cv=none; b=lu2v+r89YCaciayOrc8QT+ZeEPNAUp2Z1iF9kP0p4RGStoOYMz1hdr8WIY/sDsm9mcpgMQDdAIGcE7Q+AZZeI7qBQcgRVuAMrGyhIyerE3svOTDEmETNhst9jhVBALg2i48c3QqqSVMOIn0ALqK1AVIT22V+juYcM5xLlmlfbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965900; c=relaxed/simple;
	bh=jubdG/44wk3A5SMDqYYoKN0IQGzly+BKcaZ/S1d/B4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtdmHmHbwqJdubfYawfMojJpz6fVIG0148kGzvHLNdYiTa8Ek2a9YLNfmF1yZ4vEoHNzPswv42i585+bKBs5emwdlqDtYyldgglcFmhiRhR5S0QX/ZcbJcS3JT/b1r3tH5fl9r2Fmm0cGXbv03Pf5y+HXXg0ZwquuGtxxlFUSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so539201eaf.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 10:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965898; x=1723570698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQQgRwlzhl9vHNSYJ2BywKJ/MjynP3bz8nKvzhQJz/Y=;
        b=BjZnaTjsppuVVmnD+6nR1rEyhL0t3Qjp4kQOAyORJIuo1xLdz9S4L0RyZgbzml3/Mn
         TnB9kS7ck3TLxRrM0oAyzayzErYvfXfYRJyanymw/QkOg4eJ3NfFHoWA0zDI0YQbi6pc
         rH7AhH8XHkZWFdeQke8f/TBMJ7WcbnpOfoVVd0+QOO38oLT0RcuMWl8KHEKjQGOWY4AS
         hLH1qytJsnYkR8Iedcp5pcHwXmjKoVf1AT29+L3R5wAh/+xKNXjlq1fnfscZASiEX/b2
         WBbJOYEB2h1+ZdU13HqgX81Gv42qczRF5FRBm1QGqeMEep32mHk41fP40HGoMdlygnd6
         gjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGGT9+EyD7I81QZZp8uIKXYPOA6AW3SH6PVlMKBR77862Thq2kTTya7m30WF6iT8y+2b54jpNVv0qmrzcwLOi2UpTj
X-Gm-Message-State: AOJu0YwwgTvU/756EDIfhnOLnu0+WSapmQAeZJ3Tw+q9PK2yaNMpWGbt
	VE719mmucARD3zPWBacMfrimXg6EwGBMWxMcyQ064T856vqlaWB8HG4ZIaax8XbuIA8RpzNIOvd
	T/BHrliiBzF42ZU+Bl7Dk4cq6muE=
X-Google-Smtp-Source: AGHT+IECub67OWoJX/h6MX4JPrfnClKVxcDhwhWQBqpHH6SodFD1Plquvz1MgDxxwoGms4evetk3uNFe6I7FM/BwGrE=
X-Received: by 2002:a05:6359:4c03:b0:1ac:671c:d424 with SMTP id
 e5c5f4694b2df-1af3ba1e842mr1713174455d.8.1722965897749; Tue, 06 Aug 2024
 10:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806003539.3292562-1-gitster@pobox.com> <20240806003539.3292562-2-gitster@pobox.com>
 <ZrG_A3UQk56aYJ_m@tanuki> <xmqqed71vbps.fsf@gitster.g> <xmqqmslptw3u.fsf_-_@gitster.g>
In-Reply-To: <xmqqmslptw3u.fsf_-_@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 13:38:06 -0400
Message-ID: <CAPig+cSobEaKf3G4OQ7wHYMXTB23mHdwk2sJi5t9+X3ZX_xcLA@mail.gmail.com>
Subject: Re: [RFC] usage_msg_opt() and _optf() must die
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 1:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Patrick Steinhardt <ps@pks.im> writes:
> >> I always have to wonder how helpful it really is to print the usage
> >> information in such a context. I feel that it is too distracting becau=
se
> >> in many cases, we end up printing dozens of lines of options that drow=
n
> >> out the single line of information that the user actually cares for,
> >> namely why the command has failed.

Thank you, Patrick, for voicing this concern; I nearly did so myself
upon reading this series. I always find it very user-hostile when the
program dumps the entire usage text, thus forcing the user to sift
through a bunch of noise, when it should instead just be printing a
simple explanation of the problem to help the user correct the
invocation. (It's even more frustrating when a program dumps the usage
text but doesn't even bother explaining the problem[*], as if the user
will somehow be able to intuit what went wrong.)

[*]: https://lore.kernel.org/git/CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=3Da=3D7kHQ=
LV07-ZKZW9GsA@mail.gmail.com/

> Yes.  I do not think I found it useful to give the single-line
> message, blank line, followed by the full usage text even a single
> time myself.
>
> I am very much tempted to suggest us do this.
>
>  void NORETURN usage_msg_opt(const char *msg,
> -                  const char * const *usagestr,
> -                  const struct option *options)
> +                  const char * const *usagestr UNUSED,
> +                  const struct option *options UNUSED)
>  {
> -       die_message("%s\n", msg); /* The extra \n is intentional */
> -       usage_with_options(usagestr, options);
> +       die("%s", msg);
>  }

As a minimal "fix" to eliminate the user-hostile behavior, I would be
very much in favor of this change.

(Retiring `usage_msg_opt` altogether would be even better, but is much
more invasive.)
