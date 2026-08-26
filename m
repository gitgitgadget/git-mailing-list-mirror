Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B8372B3B
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766546; cv=pass; b=RGadSV/ORDvIKjx9nZCjdZqzPVJ5IjENjYrYsTW1u/S71OQWyNu0iwToabeK0vvAMbmWwJSloRUUxwWo7QQZlDzKyVln4/+dxuYW8f/jw8FV5HMy3dqrN2YvaPdfwZ/7LMjr04GUceMX8GP031AKBwWbETub+CaCHtlnDz5zyiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766546; c=relaxed/simple;
	bh=wtWaOhgfslYSjq0UOwo+EYcemNygNsq4H9f8SBiMnI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLu2Qe6+1GkhY8sK5ahiRqmsMb8kqyeDiDIRn2za2hRCnXBvw2JxDfdNVOXKeA+TALVP4ZRgM16kCjlADazs/2rStb+CgbQmjBTosYm3OHJcevsmVktgCEEv7QGllsncc2Gf/ewhH9vTLQ8P5Iw6oz2/i4yKr2ttSW8hDePwl4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai3fx78U; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai3fx78U"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so1352499a34.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787766533; cv=none;
        d=google.com; s=arc-20260327;
        b=JDVTzgJYcF789RTBPZ/TfCpk2j03Unr69SqDLVqto3yCblMYgGZd0llLA1VPw82hzM
         ugeHAbcHEKzVE13a6gPtiXWlSjiOSP4LWV4tbA9BPZVZy93qRjCXyeyqV/RYn1rNKP0d
         iZYEqoES+sw5pPxnSMtJbFF1/xUCHv+8PLz9MlreEkLezroZJCvrCLTis5zrM6Mu90/t
         dzHOL/+ehoyYZWvZu0gDpAa7Hf8zBCVe62DEsPRZgI8jdpDocymHNs3vFH89REmeNCQv
         up0BcDK1PvBF2+Z2iYqRINFBZ87mTO4K5Ly2Bvbl9K9rqJ2mvhj0OFPrY8xVAcfV9Jh7
         goOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qP9T9y6Uw/l0Sig3pFK2hmiAhGNJsg5e1OFDwHx0nJY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=s17hdS7I9Gi9zM5pR5njyM4LdCgQA/qdnztbUli41tFLuzBeEDp34f6VSo8Gxi97Go
         wuNsJryjLTq65Tt7EilBblO1MXCLkvtyeM+ZezEhCwyU7LDezW65sL/l1qMmzDs/EQj4
         uorLSh+8Xtyk4mqYaNhiG2Xh3+qTLRyt8hkKQj1qOAy9sRipJtxKe8TnQREhQnCTwYSj
         uODJvnefDfHOU0EpzSC/n3UWkMDfEBXuid4Xx/mgv+UUJIm0ykOe9G68lRuVyDoH72Bf
         XgOkSviJOL/PJuZVXJSg7z0rDP8Lj/XFatPnjhhY5wHoCztKbXU7GVKd4o4lcmvbptKp
         yP9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766533; x=1788371333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qP9T9y6Uw/l0Sig3pFK2hmiAhGNJsg5e1OFDwHx0nJY=;
        b=Ai3fx78U9iIXpqKBJ7kWhgs6h8dvgpgflfYGlavUQ5uPyrOeUVp94/eHeBYsBjZBX+
         QE7W/Zqyx28foANl8rgRlHV3rTpShpSe6HIO7/A0PrVtcF/pvVI2ThDFQqU1X70usut1
         OaagaiiAs6ZvpCjqMqkAXWCaCRi5upL6IXCVB1Zgw3wXqtxgP3BJQ84WpH04is8bD/cj
         9Ubie+hAkZnk6jRQg4AJVzpO1pzjQoGizaPqYkNPYGh9k6X9RdNkwniR2Vevz/jWoEjA
         GXfybSqzk3k86swD0kC7gwiB3pasP+FcLSMKyfWYTl/agh+FZxjzGJS9MLfh2UBFaJ5e
         ht6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766533; x=1788371333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qP9T9y6Uw/l0Sig3pFK2hmiAhGNJsg5e1OFDwHx0nJY=;
        b=fFUTFDz/4PT+eWii1ZLZZ4qxHEVxp4Kl3N2z2La2UbiuK+zyyKddwKNGwWGY4NX1+e
         AwRYYzTh0WNweHLWR7mmHaMy88ScSm+8xEyYahcgxV30wPukz6eXp1OGx5hpcRD/h2Od
         8qOnMKqauN7+F0nEq3+gqJODFOEwJIeFp2YAdbTrPeV89PpkW6b3MfAg7QNDj4XpEKp1
         3Yd/YoBCZVmo4dMKfpzBXBufmvGEEePdq/eYnno8M5L6Qf5ofnXV5S+i+qFqOBsLqBJA
         EOpAQpms3dtVgI2UexbsDxXiio3jAPn0nYHZza6BDipaK0KjdiPrv+1SKon3NW8eZjAf
         JeaA==
X-Gm-Message-State: AFuF++knqZdR0IyRdFboqPKnn8dyjRAX9Kn0y83P+QrUx6JB03S3sVo9
	Q6JNivudpwoKGh5AE7TgpZOiaQ6VWpur6eSbcuRp8K7i4diu2+HdYeF/OOg/NRLQ0N1MeBrqD4K
	Plnc5M6GRKScindtGHoGY4HGVw/2kBxg31Q==
X-Gm-Gg: AR+sD12edBcqX3YjMUozmT7tNWN7fUVmsE0BWCzgEz8cmdllZfyLkelzYUxEPEPhtYP
	6o3zW9/osa9sGdFxbqK/P670eJy6X1tnSWsrXt6lv9uhItkuZSSWDDBPGkgRPHKTPb0pGR+h9KS
	CBwdeVP9K8b7nc+JdnP5iGCFBjpk3B8jav8RjhC590+a5fMU7omufg5fr3Z9m8rU/5dLoSGlvNa
	we0mOEz2R9lnoZonCu3lI5QClhIWmIn6EB7ssAi9tCxCSkcv8N2F/4A73hYoRdPu3mNiAI26sXZ
	6MxJ7UWDGmy3bWbxcDeBsJqoVRnOXrXcr4mpboQwGBAFj7o8TZCW1CpH1ruE6zyu/OdbN/1jj1u
	3tRbEdeAqKAn406nTB3wdlbU3uWxSO2PI670K7yG56qcjeIYBsZ3qzfxqrhrNWp4=
X-Received: by 2002:a05:6820:55c2:20b0:6b1:9e80:6944 with SMTP id
 006d021491bc7-6b1a0513142mr6544783eaf.32.1787766532655; Wed, 26 Aug 2026
 10:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g> <CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
 <xmqqik4wizqf.fsf@gitster.g> <CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
 <xmqqwltchj2p.fsf@gitster.g>
In-Reply-To: <xmqqwltchj2p.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 26 Aug 2026 10:48:39 -0700
X-Gm-Features: AcwNN1XpvgNNCqpZmZrMQtkRq257VW2eB-WSpB5q58pFwCoM8I3SmPHSdCS6RS8
Message-ID: <CAC2QwmL6GvnLoW7xOc19vQ_Nj+0B=fiqAmz2sRnaev-boHyc3Q@mail.gmail.com>
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Michael Montalbo <mmontalbo@gmail.com> writes:
>
> > On Wed, Aug 26, 2026 at 10:00=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>
> >> Michael Montalbo <mmontalbo@gmail.com> writes:
> >>
> >> > I think this change makes sense.
> >> >
> >> >> +                 "- Send an email to <git@vger.kernel.org> asking =
for help, only if\n"
> >> >> +                 "  suggestions by others do not work for you.\n"
> >> >
> >> > Maybe a slight reword to reinforce the idea that the command is not =
coming
> >> > back:
> >> >
> >> >   "Send an email... asking for help, only if suggested replacements
> >> >     for the [now?] deprecated command do not work for you."
> >> ...
> > Adding something like "[now] deprecated" or otherwise more explicitly
> > suggesting the command does not intend to return is my main feedback.
>
> The same function emits a message that says "this command is
> nominated for removal."  Perhaps we want to strengthen that part by
> saying "will be removed" instead?

Yes, saying it "will be removed" sounds great to me.
