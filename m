Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B084E1C
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781208; cv=none; b=mOno5/WAlSX+9Vd+DEX++j00RxCduZzqQcl5M2LkYAmt4n9WrM/1CsOjeAUFbcf7yZNPI14oR398AO4PW5uHgxfBPJNBeWOsCwrbLRYccX/paAzSBz9xAQztW0yXA0t/d2jkBO2xZis99M6+IxLDEoAn6+Jzpkl9um1zIpdtdlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781208; c=relaxed/simple;
	bh=M374AriJvFdoXmzaOWzqCj+Oy89MeDcRbygnArZZC94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qhh86wzG4I+A8/oA2z+6fSEvvxM71+Gs2C0U+ic4uIsDh4Y5jyCorVxO6k58Jo3jvmZQfCBRuQ2CWlIbNRIISbnsVOuUE+OzMYak4Nf8ci8GVRpv3LHQjOntqxQoK+yuA3UTA3Devr92FP+1OZbFk5byTn6xv15c/ZHR56mT0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1a5Jik9; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1a5Jik9"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85d9a87660fso532560239f.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744781205; x=1745386005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+k6weL1Rgl/IN3TWlIldwF8ugwNYr6ED7loqTwcxbA=;
        b=c1a5Jik9Kn7IREUmvcFkQER9f7ghA29kKfg/0nHhadelG1TJhLNG8Vdu+s/wvfftIu
         BQRlDzuVBGXZmooIe8u/UwxfQReW33A0Jaqhf7wyBgP6TQtCbYDs+knpvb5qniX0UzXj
         ENVIl3bsyyaQnrK14QJd5ZnKHya7U38wxntYS02bjxO/dD2jsVGVDD+ifbwXyO4VzK/7
         FhxVD+6LgJ6+2C+iUYpUldMWKFVn4bujBelD6/B35/dtV4FN1zyHTT7vhEMaD73VFjg/
         x0QsOZDwcpIeI5/Os8Le024A81zYEV0UPYAZE7YDRcfHCjsqRSOAVaqSN0Yy/efuGFrz
         UZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744781205; x=1745386005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+k6weL1Rgl/IN3TWlIldwF8ugwNYr6ED7loqTwcxbA=;
        b=JaE71M007yyd/ZwPC8CHwzQEW+rzTLhhMrfPvTwxJOphea/luD3ILMaLxXWfw+ZL8H
         bSPlbwjEj6nc72C/CNWyfWjuoCkqg7BB/7dIsVROgqTe2KCn8uerKn449uneSXI2m6qf
         Z++eBDOB19QrT8Qd9jTes3SLGpkEpIud48rCvg/h8ksp02puZk6g7X4IqxLQheFdyc20
         BKSZocclwNWKPxM1Jwd6YdHPTxDJAkuyXlM0WZQtlZgBRZx1RVOkC/EZ5h1rm7qVghDz
         +bv6qJcDyspko52wLltCqf2yTARYx16Rp6ObTe6o3JDFrS8HYFLvlC1NnnkLUJM3DCnt
         8CFg==
X-Gm-Message-State: AOJu0Yy9gQjK6P5ejr1La1e9/vQudwYncJZ37vyfK7TsFO0KQRYUuRB1
	dSqp3of4cIsDkTNHf2cCeRJ75WMmzMbuEQjlnMh+3WUmQ/5uysaViELkKpOpgOHUojHBdXaYwVG
	NMrHetyBNuxvCdH6EJaVsfLXgtA0=
X-Gm-Gg: ASbGncsFCKFf3xYG6PC+B3CAA+EGgBQrO+mZRwbFnJQikoT3+HliuLb6FKYjILtKVc/
	TPvB7JN2nX8lpXCh8M80ek+YsuQ9PLYP96QmdTgCctWZiuR+2B3gPhsT4GUuJwl7ug614ktjqzP
	fQ6zoI/lB/6ysQFBiVA2WJZu9UGWLYgWmB450HjU20azaJXHvDMn6tc/E=
X-Google-Smtp-Source: AGHT+IEnAwVpnHlgZBRWoMkCEzidGQymP9vb/Bv4/bujD4hz/Y2SMJItIRTCS+b05ox2c4bMkItqJ4gs3hXyGq/ZnFU=
X-Received: by 2002:a05:6602:4006:b0:85b:577b:37da with SMTP id
 ca18e2360f4ac-861c57bc87fmr40317539f.9.1744781205186; Tue, 15 Apr 2025
 22:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <697a337cb147ed638884cf9b8605fef8b572e1c6.1744661167.git.me@ttaylorr.com>
 <CABPp-BFBJP15g=4M90161=KCDei-hEFdnGs7_oY8ERtqgn9s-g@mail.gmail.com> <Z/7FdgYID9I1qR7K@nand.local>
In-Reply-To: <Z/7FdgYID9I1qR7K@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Apr 2025 22:26:33 -0700
X-Gm-Features: ATxdqUEsrYjxnTUS5_D4L2F2X1zo9yHFED34zzT96nhwePXES_ymAMpm_MZfv9w
Message-ID: <CABPp-BGbScKfZsADuwkHNU5L7FMnXTwv8aUSwV-Cor-VU3hsiw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] pack-objects: introduce '--stdin-packs=follow'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 1:45=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:

> > > @@ -4467,6 +4484,23 @@ static int is_not_in_promisor_pack(struct comm=
it *commit, void *data) {
> > >         return is_not_in_promisor_pack_obj((struct object *) commit, =
data);
> > >  }
> > >
> > > +static int parse_stdin_packs_mode(const struct option *opt, const ch=
ar *arg,
> > > +                                 int unset)
> > > +{
> > > +       enum stdin_packs_mode *mode =3D opt->value;
> > > +
> > > +       if (unset)
> > > +               *mode =3D STDIN_PACKS_MODE_NONE;
> > > +       else if (!arg || !*arg)
> > > +               *mode =3D STDIN_PACKS_MODE_STANDARD;
> >
> > I don't understand why you have both a None mode and a Standard mode,
> > especially since the implementation seems to only care about whether
> > or not the Follow mode has been set.  Shouldn't these both be setting
> > mode to the same value?
>
> I'm not sure I follow your question... stdin_packs is a tri-state. It
> can be off, on in standard/legacy mode, or on in follow mode.

I was just confused.  I looked in the code for
STDIN_PACKS_MODE_{NONE,STANDARD,FOLLOW}, and other than initial setup,
only the _FOLLOW variant was used anywhere.  I overlooked the "if
(stdin_packs" usage, which is what further distinguishes between _NONE
and _STANDARD.  Sorry.
