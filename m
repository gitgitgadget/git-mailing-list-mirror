Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DC35BDAA
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764365; cv=pass; b=K2LTuUyB/6Vua4/QWzwSYF8QtBlHaJAjCoStEVK57IXmvXUj/5STkPMIs4kYS+fIl1V0GBZ3cCKsR3omaPK6IbfHid5Yznt8v25pLFO3tzaXeqZ4heARuH31JeKsvBbi+4WhQFuGEjorQDSEfWivTC8cv5BomtYZmyMur4j9luk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764365; c=relaxed/simple;
	bh=+VEGbynwnfy5xDMWF3ShBDDALS7Z0o3QmlkeEO3iNbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsbJBUPTrNSUKOhUae30yyPRDN55TZkbRx3CVAS6WF27Lue/eymDNKS3uiqdNmi3sQv/PUg1TgSwlyi8TnJvyR63XjXysWGJm1PxgRJMKNGt5CoPzQh/Zmv8jrnpzwoO8FRIF14QfADiaFuTyeXnAqR4NWIiNJuofr62Odhvpbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUBx9wTj; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUBx9wTj"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4b94d72acso1164418a34.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787764345; cv=none;
        d=google.com; s=arc-20260327;
        b=bv6QGn+MX8o+Be0ewco3hvffsQxOq07B/dhpOZNOo5doo/vr3CsFgYpPoG8nce6M1s
         L5zLr83F94lCqO3UjF5PihK8825L/Ho04mmbLaFeWwyDlN22nLQanVRE4zW/TRO8jyJq
         G407pt9jZdQyVmQ9SV1S1eg0XIuwesRsFRob4wrIIKC9BHUicuFK14fZTR0PF+E1WScG
         ZVSuu8Dw8sykx/JuJFJNnsh660t/fFCZ77yupw+3/IbBmIwIFznULTMDiFMVk8Yyg8tq
         iY1/caIuslIOqYE+vdOOo8cP4bsDQ1Sh868HafquKoG4+pT12aD+i2kv1B5TKS7yRgDB
         Q4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1vJ4+1VpjKilFGsXhO05FH2zLliNsBJc5LBQqZzhRs=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=nUCLVOTajE1U0j/Qp+wnUu3wN/T9BCy9WQuaBtA1R+gPNEDmMaJWPclW+X5G4ToQAW
         xD7xMyyrhHXsjl/6U9pvU8L+4E0gRZ64Zcccx3oNeQuOQrrfCYgrvYTBqvFRY+cQG7D8
         LlPDDdq9h4IjxAuKjqfR3Gf8tkE21emJ32owP+5iJoX66Tcoe3pkEU/SCFFeEPaJSzie
         FrfwrMP6ZvPb8exBLVFWdDPpwSeEdEEFBzLIMUdfAK+okOXOP89Zky85e6RwdocHkloW
         OlLVQvGadXhyNpsWP7HXzYXODlO27OuKP+v1tcW8hku0M/pSyQ+uz7SyiKQ+jeYbhVW2
         Nc2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764345; x=1788369145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i1vJ4+1VpjKilFGsXhO05FH2zLliNsBJc5LBQqZzhRs=;
        b=lUBx9wTjNEA6iT8v7PTLxQBnxzQdQqc90SbtpBRRkTQnVr0lISpZklF8hfAZW7WOwo
         1BkD7yK5IdYAAW0sy27mKz6vEqO3xkaNZhlMy7RR8cjsK/9iYmOQM5dBhET7/YAPtzyO
         ubASdu5/GlDInGXuPVON3WCKpD0FxJTLi0n9kJSSIuKivw+duwGc9vvaH4FgK//zgN9s
         WntpDQzUv86ODNj9BkwagUoR3LzzCWUaYFfwqh7hKEukhpy1pZg4B1LcwgLGXJRYSeO0
         u/t9oQ3Te5OX7RQAT01Royx03JKDGcrQhLHYJMmi490aYxRpYXnvINqdtmIPADianrgN
         VliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764345; x=1788369145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1vJ4+1VpjKilFGsXhO05FH2zLliNsBJc5LBQqZzhRs=;
        b=OLI0b7awHm8cEcZ/wKJNgNHmFQHnygSc0uK8iyKRmbZeNXB4wLBUP1ExQ7Gx9UhSEG
         dQ8I81wecMek7JbaTjVNuaDH3dHqhE76pcq6q7cwWpyFoEdENYVK96BqBHWIWNcgpdrQ
         Qz5YRZ9Dnl68x0ppvivIhflkAtfv1ta6k+Usf5yT5X+XzJu6dW2Ek15Zp9MQa5/l39do
         NxZLMT673Z3sGJ3chuPwu4o6wutUUGRMwuLIe24sjlSX/dDDfIzVB1oS5sqFWCaw2uMB
         Vx7U4wKuabC6hi5tXV8VpZeZmbawUpuRTp8nZTuAO9S46wQVNNTHDNHajty8wpxP0pfP
         Oc1w==
X-Gm-Message-State: AFuF++li+q3PgRCprckSk1r+ntIbljwSCbM8GHm+E2NyO/W/gjSL8v0X
	jKPpGahOqzARaZ6hZWWmMu9Bxtku5hLEtiXUsL9PE6tgcKBLnhyIWpZZlMLxzK/cGTNhBTGgSc6
	pP/Uvc19wO7IJ9mS9U9AnoBFOu8QPOzA=
X-Gm-Gg: AR+sD11PUvFqCeQvLTAd4qQ9q1nV/ZaRvpHfO2sIYIBGcVS+h5bsSLCGRcev4/yB9to
	B3ROBmixBCfTnMcJ35YUPx5KEjPAPUeutogzNBpUydcatw4d3QDUl50OIfFKZC3/FLedYDCfsv5
	Uq/Bp116XHPYRhgNFQv22sqRR28QS4awNHXNUr+Lu9ACMMp0RokFutgYbL5qyTvfMIUtzJB8wIz
	J9Iy0d2EV8G+PX53Ss5NYrOKP914pAkVYk+9fS35P6iAtlngKZigAC3TbnbcyjO3ksppbnfWHnm
	HhW3roOUfNQHfqcgNDLEA995KOpFlGAfsnJ9RA9tIuYBuSG7VsQnMTOWWBw3jVmqkqCnE65vROA
	1/nvrLsMMrBnm2fm+R4fmjTQGbuGaQ/UjVt1KZCsrOZpDxF0XEw5tQ7HE0hNZZyo=
X-Received: by 2002:a05:6830:258f:b0:7e9:e5c0:e0a with SMTP id
 46e09a7af769-7f4c4d52c28mr9222944a34.5.1787764345070; Wed, 26 Aug 2026
 10:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g> <CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
 <xmqqik4wizqf.fsf@gitster.g>
In-Reply-To: <xmqqik4wizqf.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 26 Aug 2026 10:12:13 -0700
X-Gm-Features: AcwNN1WD0aX5zgZ7qDOdbUmeMYttfWaB-4HSh4cgL7gj9sT6uU31ZUGu_H1c9yU
Message-ID: <CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Michael Montalbo <mmontalbo@gmail.com> writes:
>
> > I think this change makes sense.
> >
> >> +                 "- Send an email to <git@vger.kernel.org> asking for=
 help, only if\n"
> >> +                 "  suggestions by others do not work for you.\n"
> >
> > Maybe a slight reword to reinforce the idea that the command is not com=
ing
> > back:
> >
> >   "Send an email... asking for help, only if suggested replacements
> >     for the [now?] deprecated command do not work for you."
> >
> > Other than that suggestion, I think the change looks good.
>
> Not repeating 'replacement' there was deliberate for two reasons.
> First, the preceding instruction mentions others suggesting
> replacements, presenting an obvious opportunity to keep the wording
> concise.  Second, this message is meant to be generic.  For a case
> like 'whatschanged', the "new workflow" is to use another command
> (i.e., 'replacement'), but other cases may involve doing things
> differently and are not limited to a simple replacement with another
> command.
>
> And that is why the message only says "suggestions by others".

Got it, the reasoning for removing 'replacement' makes sense. Thank you.

Adding something like "[now] deprecated" or otherwise more explicitly
suggesting the command does not intend to return is my main feedback.
