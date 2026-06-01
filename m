Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71653DB329
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329107; cv=pass; b=c3xMdVV8kNu/8i/G+K6uxvOzaA9TKYWkI813rT0tAUQRrGjWwNXXJhxdB3N2e5FVtOXuiNKHPkvkrJD6swg4Fu0ICAAXGZ2COgfQfLMwF9sqc/gPbag4FLWWh5oFtDVSmDUpJy1XWi80tZ872cpFHUJjMwqpfGDharcBH0Nfh9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329107; c=relaxed/simple;
	bh=SrWT8PWT4/+6LYPhpmOGpbabOX9V0viU7OVAWvlJzTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NadJMMPxFaZYi9A8eIx0YZCra3bSsaXAuPkJjO0qMT7w9h/gznk+N/d+vBEdpLhr0A/VYC1P0AnQ6UGB2ALl3B9ImNUqsedI097D+YvGE0ll4kHAromaP7KlO+Ri4/zX8mkxrOQmqgN3jIGNxC/7wWjHeziMm72zQsFiQ4uVr9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2BA44m/; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2BA44m/"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69dead44101so3173961eaf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780329104; cv=none;
        d=google.com; s=arc-20240605;
        b=ELb65ZGWvG2CwfjdVS/Vb4rm5K/77evNyTzDCvE5NCargeDISTT39S9mFxG606usya
         x+OMIPaI9ucJKkwiGQnwlogecnjgVE5POBZwxZvgJaiowZEZXQ5K3m4jsTtjengQEheT
         FLdldDeLl18eUwlPJcirm4UXxM3iVys7lCOd0koV1vwYP4NduzwMp9Q6BtiDVgvjlErX
         s7vvIQhYu9Si64Fn1ThAlx3AaKE0Yi+T4aZ9t9X8DTIsUu5n7mopmb+O7E+wF4QwfSlz
         zAqZRRAsoIS4383WPLocNFRexsIW8X85rXzUwFWua9PYIaIvI+hrCnRZJgyTecz2aMSy
         ju+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jy/EdiP4+4UCVPW+WPvV7UtfeKpduE9Qbiw9EnfDPmE=;
        fh=JFjA0UzvMOzJ5oGmimro6ZcbDj40oQlFiOm0xznFf/s=;
        b=jF/CMyKAMroPkGBxPgnOQeoWsf5zkoLQ7grljD5FDLrrO0ZRVbT0XmCqTSuCRzC2P/
         dSSxDMXjiQa31NgR7OdWOYMXMmekFXYEtjy6Hl4RWQu4Et2HT4ZUNC8FuE7+d8An381V
         ayXgJor3dbOwTty39GMkEpANmxv1DTqJWNJjFBk4UDuCYa+h1DNyDI1/0CxsYlGxO8Fj
         NYRLeJvp8m3tf66e6qDinhR2hGJXspixzAg5/jMQiecInWcV+/mF8UPLJvn2XnM9pw8y
         o/F2Q0M5zxQ733eGCV2ynOF+Xfr521LNA6a4KDsw9ndRVWL0rpeyqU213OoG6deNEk7D
         1trw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780329104; x=1780933904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy/EdiP4+4UCVPW+WPvV7UtfeKpduE9Qbiw9EnfDPmE=;
        b=J2BA44m/8uu2QVKP+6uTIT0fsaJHypQc+rQyrgwmG5jQMtEdlY20jloxtgj5ZirGqz
         ODbRJU4j/rfqgRPLPaZIWZdXKEtVqZpkmO23dwdsRn54BokyZR4HwJpmbaT/3GWhq1m5
         EsB1OZRwuJm5O+iwJzA4ouV8KXAbK/DdjHpn81Vbr7QlzXXHvoGd9K658TCaymCSI6ns
         x6wI4BtGdL6Be4sA8M0cllFubkHzH1/QyGaJVVEj5L3lGkr2edEHN4lZ9H6VYsByNUAB
         EpSeM23aDVSy2IbKgfSN0BdcmOECLnU76mE7O8vJHLEwKw4XlmgyJwxexbnfHHogw4RL
         xVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329104; x=1780933904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jy/EdiP4+4UCVPW+WPvV7UtfeKpduE9Qbiw9EnfDPmE=;
        b=YoXa3ylaVlYUawYjSQKWO8a334opyLatvDFsZHtfH4XLsJql2ogS8TlLIWprCYRyuF
         OnE4QiUS4gs1+QHImYpw1/D6DX4S8xZc12sqR09ceacPrSfd2xDzQ/fAaf/IUIygBkMr
         tuJZF8VlT2tOGH/qE+uIkFTGgPZjMgucv143AwW4w1nub0eL6xP4E0cbGZHIlBiI6fwR
         9NSRxfetTrlhmuMxJRlLxHMwXMoU8QpUVgwTNpN5tVdA/sYp2HbZz8rzKQrH9ToM0o9D
         R8LQcoZk+blYaEuAS1cPxGh4/RDYGqEIn1/TNr8bMYLHCDrX3S6H8JfZGJhVJODGbhFd
         IvIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UmB/dOE/8H8vcqUYgt3IwBsQCqqEo3QODZnxWwHUO4LMbARV7u/0l34qRD18Apnf1psc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gcwiU1Lcpxks4moEsTBcZUc5PhAg5hJJPWxKAO25COsxOCP2
	CIe9HAqguwXnYZhCSOAhskL8YBDgLN2AqxlBFfbq/kzdfq+oin6v7rprYE/ryh2kMGpPKBcmi7x
	qvKRWbGW2LDewE37pMr8ybIZnVVT9I/5dnw==
X-Gm-Gg: Acq92OFFbdOY1SKVlaARiDWDuA95gsXorBvWP/Z8FaAfKjWj/59+Nzt7M2unSc0a05y
	gFsqdeY4L2SDrOwJOaWovUvIzydUXJW13GHfds1qIOmCdKQHS3KnyosOuKZNF94kTN7RaGflNKU
	UYzuOzTm3Jnn86dBCp4c2zhWJG/h1bXVd0HxCVn5fgxj1mOv3Xs0g5pcFb4AF6/90Vfy8oi4a8y
	IonWvGYr/Mk8aLVty+zRYo1dU4GZoYRBeYPUdDLL4PGyVR3a8cpv8+A0eXx9PLUnXNO2UKBe67X
	quia8p1nxVvOLIJEI/+OoAIuePp0ubrFR632dU2ZZnGssLjGl1Q=
X-Received: by 2002:a05:6820:1f06:b0:69d:f58b:8fbf with SMTP id
 006d021491bc7-69e10405affmr5271669eaf.8.1780329104340; Mon, 01 Jun 2026
 08:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2133.git.1780287309846.gitgitgadget@gmail.com> <xmqqo6hu92wu.fsf@gitster.g>
In-Reply-To: <xmqqo6hu92wu.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 1 Jun 2026 08:51:33 -0700
X-Gm-Features: AVHnY4IiaGS9isIsT-YCM7asqEH8Ut41HV1manzS-Xnl8ypS59DAA20f2ZjhPwo
Message-ID: <CAC2Qwm+vhhuRzJ1uu-xBD8xrcuwvba+Ugs4iPGDNF7SPQPB8Fg@mail.gmail.com>
Subject: Re: [PATCH] sub-process: use gentle handshake to avoid die() on
 startup failure
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 11:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/sub-process.c b/sub-process.c
> > index 83bf0a0e82..22c68bd10d 100644
> > --- a/sub-process.c
> > +++ b/sub-process.c
> > @@ -132,18 +132,19 @@ static int handshake_version(struct child_process=
 *process,
> >       if (packet_flush_gently(process->in))
> >               return error("Could not write flush packet");
> >
> > -     if (!(line =3D packet_read_line(process->out, NULL)) ||
> > +     if (packet_read_line_gently(process->out, NULL, &line) <=3D 0 ||
> >           !skip_prefix(line, welcome_prefix, &p) ||
> >           strcmp(p, "-server"))
> >               return error("Unexpected line '%s', expected %s-server",
> >                            line ? line : "<flush packet>", welcome_pref=
ix);
>
> If `packet_read_line_gently()` returns `< 0` (due to an EOF or read
> error), `line` will be `NULL`.  The error message printed will be:
>
>     `Unexpected line '<flush packet>', expected filter-server`
>
> This is misleading when the remote process didn't send a flush
> packet; it hung up or crashed.
>

Makes sense. Will fix.

>
>
> > -     if (!(line =3D packet_read_line(process->out, NULL)) ||
> > +     if (packet_read_line_gently(process->out, NULL, &line) <=3D 0 ||
> >           !skip_prefix(line, "version=3D", &p) ||
> >           strtol_i(p, 10, chosen_version))
> >               return error("Unexpected line '%s', expected version",
> >                            line ? line : "<flush packet>");
>
> Ditto.
>

Will fix.

> > -     if ((line =3D packet_read_line(process->out, NULL)))
> > -             return error("Unexpected line '%s', expected flush", line=
);
> > +     if (packet_read_line_gently(process->out, NULL, &line) < 0 || lin=
e)
> > +             return error("Unexpected line '%s', expected flush",
> > +                          line ? line : "<read error>");
>
> We catch error return (< 0) or a line with payload (!!line) and
> report an error here, because we want to see <flush> here.  OK.
>
>
> > @@ -171,7 +172,7 @@ static int handshake_capabilities(struct child_proc=
ess *process,
> >       if (packet_flush_gently(process->in))
> >               return error("Could not write flush packet");
> >
> > -     while ((line =3D packet_read_line(process->out, NULL))) {
> > +     while (packet_read_line_gently(process->out, NULL, &line) > 0) {
> >               const char *p;
> >               if (!skip_prefix(line, "capability=3D", &p))
> >                       continue;
>
> While this correctly stops the loop if packet_read_line_gently()
> returns a non-positive value, doesn't it introduce a subtle bug?
>
> `packet_read_line_gently()` returns:
>
>   - `> 0` for a normal line (which keeps the loop running).
>
>   - `0` for a flush packet (which we expect as the normal terminator
>     of the capabilities list, stopping the loop).
>
>   - `< 0` for an EOF or read error (which also stops the loop).
>
> In the original code, an EOF or read error would have caused
> `packet_read_line()` to call `die()`, aborting the process.
>
> With the new code, if the child process dies or closes its pipe
> during the capabilities handshake, the loop will terminate, and the
> function will return `0` (success). The parent process will proceed
> as if the capabilities were successfully negotiated.  Any further
> communication with the child process would fail so the damage may
> not be huge, but somebody must check if the loop terminated because
> of a flush packet, or an error.
>
>         while (1) {
>                 const char *p;
>                 int len =3D packet_read_line_gently(process->out, NULL, &=
line);
>
>                 if (len < 0)
>                         return error(_("subprocess `%s` failed to give ca=
pabilities"),
>                                 process->args.v[0]);
>                 if (!skip_prefix(line, "capability=3D", &p))
>                         continue;
>                 ...
>
> or something, perhaps?

Good catch, thank you. I will update the logic so a failure during
capabilities handshake
is correctly marked an error instead of silently succeeding.
