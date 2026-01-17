Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F924501B
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615798; cv=none; b=sqDqSsvNDcHBN5AbFtyxGiTjC7jthvtejOC4RW1tx0muUmiAKyiHY8PqBUcCG8d+sfUbg3J4zPZGMkzT3xG+JucHy7fbqGVF/Uos05GB6wi0gBz7hHihYlBta7XwqIV2BqwJL6b0LqqXXRiRj/SM84t4gP9sJFRbTx3e22AoeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615798; c=relaxed/simple;
	bh=/2PgC1vQtABJsOD/PLOImiJwAyKg9I5Db9h5kYdoSnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fenSGXBW/PKMXZ5MxXMs/FThvsHhJjMpyB0LJCUvAfNmgbR98Z9h6zE/A7cNzs2FXAzMGqHMsDFM0OblcB7cApGT1sICk5GoNBPP05St2/g2gJDPqlcyuFrJuT7X7YBThv/RoAutUXeSRQqHA51GMhp/jvtaxH82HBX/x9pCl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=DpaUSitk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="DpaUSitk"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8719aeebc8so493432066b.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 18:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1768615794; x=1769220594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK9dlyrmNOygqruz6LxdKFi32TqPoaXT/vtdLaGxKUA=;
        b=DpaUSitkLdKRZZ7VlamsMzXEPNHOeFROeyRJYVz/Pi6YF5dA65wiREd4KLlnYEQTKE
         8kTqh+Qr9ZvrgwCYdLO+o7nYPiEE6eXe2pYtd4k5pEu36i1eDU+tmq2y/ozfS8O6boG8
         Z97tJS1ltvq6GBJeDmUtg4W7rOnhwZMayDrgoyQzPp3NGlfmsX9YwCSu2YeoMZ8ph1FM
         89F5atPLSt/6T1RRQkgOZ3zenYD/m2GmRvzRmJM9mLHIS/Kb1sAsknlLNGLW78B1AYWS
         5JyOLwx5QdpP6UHJGCSFO47eTBDwb7Y9ZvqsTrlsys0QqZDheun4suz6MevKAtyfZN5I
         OxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768615794; x=1769220594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bK9dlyrmNOygqruz6LxdKFi32TqPoaXT/vtdLaGxKUA=;
        b=PmBHKA6S+PxdaY51S8szPaEPJUpi7J9JcfoV0aLgdQAcFAchOk8WvSIq0E/fawqzs5
         xQ+1dRyfG9NTH5zRWpW/QuStQGCy+qj+4WzEFTPNge3TsJixH9RKOEc+L6ovVlXMFibT
         D+K9hplcyuIL4s7ATAlTqOZ8xcHJ+oypNfLs1S6K5yLY88V+ikElJRZOBe4n7d0QXAeR
         oeBTqq4+uGiBCp/7CFVSuJVZlGvZouLB8M5sF418H1We/n+VcivRl5u8oMoCvHVdN3kR
         XAlVdX3/rhUXm+eALnfVF6TaLNj08Umk6IgioaE/GfoOUqvJ2nka52QE1ylXKbsgACj2
         P90Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1tCfVAFKr4i6BNsGmkHmUWegFR0MHaR4FLTS7+P0lq55kGCPEY5wL9PVvAPsC224678E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLKhuwcezOlanUyITUS+VxOoGcya6TZ2ChjJ3pBoYhLW2h/l+
	152kuU8o3GZ7GN9TMnxofU0pvihM3VQrw4yuCUoqxfVIMlxyU/tKy4XOTJxR76RNg1OjhPyZ4LU
	CGuCg9MsZYp2VakXz0MnDWQevUk6E8uD3pIIHWemZCA==
X-Gm-Gg: AY/fxX7WUBL0TGiGWXXTjcGoPW89F+MvZzBAs8EWDitmyhirN5gZcXbhgQ7yHdpM2L7
	qU545CFmWqB8yJh+3Wb5DHgqtbLPuB9YmtxyNjnqA0QEnG4AYqEyS6wap70TyrvuiMCR/piEoWM
	aXiMBKPvNQRZXFJfBErvfjy5Yp1qPYbWZtDBUnb/ctaD+ZFdvZAz0jvcSaycVihPGb5i63PmpsQ
	wFHQN0CkzL2kZ7e1PvG5LGLzobMoF1ggKPaRjEdlTlWg0R5fOzwGJbCXInWlYNqfPKGT0I=
X-Received: by 2002:a17:907:944e:b0:b80:42cf:1157 with SMTP id
 a640c23a62f3a-b8792f79f03mr430192866b.36.1768615793570; Fri, 16 Jan 2026
 18:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com> <fb4c8dc5d4434deab9c8f1872f309a79351dc799.1768519120.git.gitgitgadget@gmail.com>
 <3243b63b-b0c1-42d5-beeb-df42b891f09e@kdbg.org>
In-Reply-To: <3243b63b-b0c1-42d5-beeb-df42b891f09e@kdbg.org>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Fri, 16 Jan 2026 18:09:17 -0800
X-Gm-Features: AZwV_QinBOWuQgFhBu0nIviqEXlqT-P5iQH_IrGwm-KGI9k2FcHTTUzq7ATVPnk
Message-ID: <CAF5LJ4Du-x9ND-EHCe0Npz9GaE7kinEYNnpP_416cKpZuxc9hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] userdiff: extend Scheme support to cover other
 Lisp dialects
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, 
	"Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:49=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> The commit message doesn't mention the changes regarding the word-diff
> pattern.  I would have prefered to have them in their own patch; it
> would make the patch text less obscure about what it actually changes.

Okay, will do.

> > diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattrib=
utes.adoc
> > index f20041a323..a9ce5adef9 100644
> > --- a/Documentation/gitattributes.adoc
> > +++ b/Documentation/gitattributes.adoc
> > @@ -912,6 +912,7 @@ patterns are available:
> >
> >  - `scheme` suitable for source code in the Scheme language.
> > +Also handles Emacs Lisp, Common Lisp, and most other dialects.
>
> Saying "most dialects" immediately begs the questions "which dialects
> are not covered" and "is the dialect that I'm using covered". Let's
> write it this way:
>
> - `scheme` suitable for source code in the Lisp dialects including
>   Scheme, Emacs Lisp, Common Lisp.
>
> Note the indentation of the continuation line

Of course I will fix the indentation, but I don't agree with your
proposal for the text.  There are many Lisp dialects in use, indeed
probably thousands; lots of people write their own.  As previously
noted, matching an unindented open parenthesis is a very general
heuristic that is likely to work for the vast majority of dialects.
While we can't answer the question "is the dialect I'm using covered?"
for everyone, I think the text should encourage them to give the
driver a try.

So how about this:

- `scheme` suitable for source code in most Lisp dialects,
  including Scheme, Emacs Lisp, Common Lisp, and Clojure.

I've looked at some Clojure and I believe the proposed regexp will
work for it.  I think it's a good idea to mention it explicitly,
because people might search the text for it.

> Using the identifier "|the \| greeting|" could make the test even more
> complete, I think.

Agreed, will do.

-- Scott
