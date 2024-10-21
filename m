Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C21991B4
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533670; cv=none; b=Ctk0FzTmlp5k0BaddItNfQk1K21XLkyzdepIe73VYpJaPJsuD1p+UL5mEsVzIP5gM3zAiNiTW0nRggoCX6xNJQ8JDKu3lc/aGi5hCUQgJuAbxrJg1gVlHnmCCEPJ5xyzTwPdL7weddq4mhRL6VrZA9kV1vLm8pE7D1LMfAIunHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533670; c=relaxed/simple;
	bh=xYaVjb7Mhnea40CEHD57bNgOs028Lt8WF4mf9LQU8oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqVy7QaO20hMeLK/7RnuNJYth0yVfb1rGFJLEr2u0s020Xs/sGZwJkpBCUrkJ9bGCQA21NsWRsxIHCfRCcEpn5GXAqnTcGEYOBDOrsvi3YVF1LSRIoNUahvRToRoBF/V8RWWvmUuOAT/rxvAQaUao/m4ZMDi/wsIBzCB0KexUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC74fmMl; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC74fmMl"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d35639bfaso1560034e0c.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729533667; x=1730138467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Wm+jqGZWXsXmXxPXBBhL4fZ+t5XHkaiG8TSAnqjMpk=;
        b=EC74fmMl1vtUQFiLMiewytgiaEc8LorHNviBQxUrN8IhWSegQH8jQIH/dUE/Q7msW6
         UlosyizCO84bDnkrffNjoscNF00tOXYXivXXAyNzIgH4TyzexxZpd9w6esEmtxAr+cHd
         vANzN/pCoL07p6X7TdbKQk3bz+Y4YEmWd9Ud0RUR7qkrjmlvRbPBsl2eiEMRNnmg+uAx
         KeOa8jjK9ZwKa3TQFMWPouLtdnvU1GddAT4kEtG5rx2KQYPiBv5U5W9ELDnmgiU0xKYN
         yWCAh7F8DHv2fVogjbeQcXijyGuj7cR8XpbNjiJWC5yriBeltPk5cI8fOmbIhtULPKc7
         ITtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533667; x=1730138467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Wm+jqGZWXsXmXxPXBBhL4fZ+t5XHkaiG8TSAnqjMpk=;
        b=f2RYeGr5m6ZbCTdbcJ1t+/+ahKUWcwtIYojiD6tOjok11GAJ/eWge5JzRwj4+VkYk5
         OfuqVAv5ZjS9qa6BNd5QbRoxIYuvSdIvzLp3GzaQ98imwz30gv/K4b+yrvnsdE2LDeau
         DrxGmqF3H79wGnhiBPsutZAAHAOSySGmidJE5RH+qZiXVdi1wRsrgSUIkkZ9byHO7+Ik
         3VXZJT1ec6yQw5gLF1gLh9WnwE2USaAOXGBJAJgZ8h02ezP2UhGqdrJ2eJWvpvFRW5Yl
         WVbruNQMK9w5SqJfAIK4G0CNVp0nR3d1E3hvSv5pRXa10oTFVIeFYR9jnqEZooCiA19O
         Cz2A==
X-Forwarded-Encrypted: i=1; AJvYcCX79gw/ndVHuqZl/gbsu3cuUvrAESTCsFP88FWFdyDm4Ybn2xiVY7MRHmfaMLz/KUqmILk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDErpXd7cfPJi9O451zp289OF5Re2fAdROTTW2LF7m96PBg2Z
	jgbit714Kpsp9kS6Nr62EA0pu6yk1zSR5usoq59y0J8ZbnmZWh6ctKdPK3klfrfXmLBEh2kiodj
	/EuYvdiWaQMLTgszQljebauuCRyo=
X-Google-Smtp-Source: AGHT+IHwRZnbUZPnpzAFZqjkzOvAsUSf/11FB48orHW2utxW7HPLuuB4/MvCsPaP2N9M6roujurwf4J/FPa83C3Uev0=
X-Received: by 2002:a05:6122:169e:b0:50d:8d89:9f4 with SMTP id
 71dfb90a1353d-50fb2707490mr791529e0c.3.1729533666425; Mon, 21 Oct 2024
 11:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>
 <ZxaClmjrLAJiVxNJ@nand.local>
In-Reply-To: <ZxaClmjrLAJiVxNJ@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 18:00:55 +0000
Message-ID: <CAPSxiM9W+YcJqxnkFmOpBcHuHab6V_vn+ibwgq-vCNWZUXPw=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 4:34=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Oct 21, 2024 at 02:24:38PM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 21, 2024 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > >
> > > > Replaced atoi() with strtol_i() for parsing conflict-marker-size to
> > > > improve error handling. Invalid values, such as those containing le=
tters
> > > > now trigger a clear error message.
> > > > Updated the test to verify invalid input handling.
> > >
> > > When starting a new paragraph we typically have an empty line between
> > > the paragraphs. We also tend to write commit messages as if instructi=
ng
> > > the code to change. So instead of "Replaced atoi() with..." you'd say
> > > "Replace atoi() with", and instead of "Updated the test...", you'd sa=
y
> > > "Update the test ...".
> > >
> > > The same applies to your other commits, as well.
>
> Thanks for noting, Patrick.
>
> > > These are a bit curious. As your test demonstrates, we retrieve the
> > > values from the "gitattributes" file. And given that the file tends t=
o be
> > > checked into the repository, you can now basically break somebody els=
es
> > > commands by having an invalid value in there.
> > >
> > > That makes me think that we likely shouldn't die here. We may print a
> > > warning, but other than that we should likely continue and use the
> > > DEFAULT_CONFLICT_MARKER_SIZE.
> > >
> >
> > Ohh, I understand. Philip suggested this. For the warning, will I just
> > use printf statement or what function to print the statement ?
> > Also, how do I test the print warning statement ?
>
> You can use warning() instead of die(), which will also print the
> message to stderr. You can redirect stderr to a separate file in your
> test, and then grep or test_grep that to ensure that you see the warning
> message.
>
> These messages should also be marked for translation (with `_()`), so
> the result will look something like:
>
>     if (strtol_i(check->items[0].value, 10, &marker_size))
>             warning(_("invalid marker-size '%s', expecting an integer"),
>                     check->items[0].value);
Hi Taylor, when I try to use this warning(_, I was getting some error
In the editor
warning(_("invalid marker-size '%s', expecting an integer"),
check->items[1].value); Incompatible integer to pointer conversion
passing 'int' to parameter of type 'const char *'
while I tried run make

erge-ll.c: In function =E2=80=98ll_merge=E2=80=99:
merge-ll.c:432:33: error: implicit declaration of function =E2=80=98_=E2=80=
=99
[-Wimplicit-function-declaration]
  432 |                         warning(_("invalid marker-size '%s',
expecting an integer"), check->items[1].value);
      |                                 ^
merge-ll.c:432:33: error: passing argument 1 of =E2=80=98warning=E2=80=99 m=
akes
pointer from integer without a cast [-Wint-conversion]
  432 |                         warning(_("invalid marker-size '%s',
expecting an integer"), check->items[1].value);
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                 |
      |                                 int
In file included from merge-ll.c:9:
git-compat-util.h:691:26: note: expected =E2=80=98const char *=E2=80=99 but=
 argument
is of type =E2=80=98int=E2=80=99
  691 | void warning(const char *err, ...) __attribute__((format
(printf, 1, 2)));
      |              ~~~~~~~~~~~~^~~


>
> Thanks,
> Taylor
