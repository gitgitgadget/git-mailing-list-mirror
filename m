Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA51EB9E8
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680244; cv=none; b=ofS3j2m+hoNQJ6GmQg08QJIafN5vf1bmgE59xGB6xF9P0Y3jukrQUGXf7UFh1wab9F/X9N1eKr1A/hoq8fnkbsI9X9/wFFZEjvPgCauWvykuSWxguZieh+gfx6bxvrBEy50OAmAa1C1VJTYKFmbed2XtxUA8ORgWbidyxu02G3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680244; c=relaxed/simple;
	bh=8pfnkYlOzUGL1DoIDahCcE00aZJsVLzygJgHpSHVVB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPW3Bkk51yssFwXPayY/357TKfuoNXQGmLkTv9Yua62sNH7+Tcn57UT6Qq6nrdDxmB9oPcdalbNywBrgcDL3tMJ3ColIRgRVqnfvr4GlW3LsFk//4MAlNeQheHZUiMl95LEDbpmI/JCdccgbhJ/XcygrDrpswq4Pu/lUhj9vw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoaiFhTO; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoaiFhTO"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso5385445e0c.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680241; x=1742285041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax/hVnkbgy4UWhwvSy1KG7sHaKwW5KbqyoIU3OJ6n70=;
        b=ZoaiFhTOZ57TWei3VmpzkyAt7fgdehScyKFeS0lEcflDqYdMzi3pqLdSzKXDxlejEk
         Gq6xkKEVsu4KXrZy3xxdygjNkz9ZAFNP5zOpySviytms7t6xd4cA4hqp8WHfJONbGqZD
         cMHxbjesYo/TvOFXpfFCxgJmfunMSKVSDvbca9bHfq0lL6A3XUrmRRR42EdeJm4IIDpo
         Er4v7f2ti41qYyaMVpGqiCWzf9Ivf/wlY7tnxzlMhyU0LP3zn3guldO1Ba8vSGu49+7S
         04JRrQm/sZ82Wq+wzC4JwN2GAm4f6hYWNJWHZaS3ZpGDUxCzZxUn2lLpGnQFXjG/PPG1
         XT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680241; x=1742285041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax/hVnkbgy4UWhwvSy1KG7sHaKwW5KbqyoIU3OJ6n70=;
        b=DlSoZtTaxnOCUy1BUujfVDSPY5FrH2qeGALHyuso0cfsdZC90a/TeealnTQhdUE5tr
         MxIqvhgRbd7lWqmdngJxjuWw3fmeHtcn8p8w3udWJAWI9prkYYrz0Hlwpi9hVMDuCaCs
         +f5PMB2C5X50I4pWjoKK73Vj73n3fR3RXyS6IN+vx4Tn3QuC/EzHiGXHMd8Eggl65hn2
         zRPHVfAxGWEt6Wv5ZRIKR9VAp2bQ9GZxIdFteNI1ewJXNSRk9J6SP9wRLHt/FFSmaWCY
         ooajweuvqqJ4HctU1YuAXQEfDZp90o0C5vBcWDDkgeRMEselz/ACEAP2Yoc68ehvXXtt
         kf3w==
X-Gm-Message-State: AOJu0YxxaqSo0czzNaFTSC1pyHmLb0JgKoIHC2KMAy4OfNP+mmlEWC4E
	CevQajaIrEp5Th/Fxgohf22/NC7CHpKLnIs2SDVDZsMd3L5k19ffvpGylUY4JhXbwGxCfdfTuAv
	XygUn9vNcxZeXSqZrBfp0D2M2QKw=
X-Gm-Gg: ASbGncuZj24dZupkGV1vOjkdhaLWLLdpGAkL7uSKBJEbHCDUL3YUamdHPop9dmzO3H1
	fAYF2vmOrxJZdFbqPFoe8frghrzBAY3HMLdICGfXe+iofVCeRG/0WVjBuYyNYUpTTCgrAdavF+N
	LvvZZTm3o268O212Y7lQdRuAJhNeOpB5G6C3WjmKSY+Uu12LzAQPkxHzmDmtc=
X-Google-Smtp-Source: AGHT+IHVsaPiX+1BSGkUvlyjSKS6Y4plYd/yaS6x7Z+U+9FebyzYjOvlfv/J7vSJt9uJTdP9blKsoNSVt/ULXOTayiA=
X-Received: by 2002:a05:6122:790:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-523e4064b97mr10180942e0c.5.1741680241595; Tue, 11 Mar 2025
 01:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307123934.2064275-1-05ZYT30@gmail.com> <20250307123934.2064275-2-05ZYT30@gmail.com>
 <CAOLa=ZThgmKkYErnxUAGOhHyFcFrYDrcQ8KvqqkMBJ3wEckVPw@mail.gmail.com>
In-Reply-To: <CAOLa=ZThgmKkYErnxUAGOhHyFcFrYDrcQ8KvqqkMBJ3wEckVPw@mail.gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Tue, 11 Mar 2025 16:03:50 +0800
X-Gm-Features: AQ5f1JolslHuAfByAuzgAKKY908vGDVpd4_cQgiwcz1NClfG9_lUE_42weOniWQ
Message-ID: <CAMvj1+on36gmtRF_yKKwxSBvhoLK3-=DM0girxwEriASsvPL3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Improve SMTP authentication error handling logic
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue Mar 11, 2025 at 6:14 AM CST, Karthik Nayak wrote:
> Zheng Yuting <05zyt30@gmail.com> writes:
>
> I see that you've added a cover message detailing the patch, but
> individual patches should include the relevant commit description and
> message. This is also outlined in 'Documentation/SubmittingPatches'.

Thanks for pointing out my mistakes, I'm sorry to ignore the individual
patch commits. I will add them in my next version.

>
> That said my perl knowledge is limited, but I'll ask some questions
> anyways.
>

I am grateful for your support. As a new contributor, I=E2=80=99m still lea=
rning
the best practices and will improve my process based on your feedback.

>> ->--->---# if there's no password, "git credential fill" will
>> ->--->---# give us one, otherwise it'll just pass this one.
>
> I didn't understand why these comments were removed.
>

I removed those comments because I intended to use the password directly
at that point. I understand the confusion this caused and will restore
or clarify the comments in my next revision.

>>  >--->---'password' =3D> $smtp_authpass
>> +
>
> Nit: unnecessary newline.
>

I=E2=80=99ll remove it.

>>  >---}, sub {
>>  >--->---my $cred =3D shift;
>> -
>> +>--->---my $result;
>> +>--->---my $error;
>
> Nit: It is easier to read with a newline separating the variable
> declaration with the rest of the code.
>
>> @@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
>>  >--->--->--->--->---authname =3D> $cred->{'username'},
>>  >--->--->--->---}
>>  >--->--->---);
>> -
>
> Nit: unnecessary newline removal

I will adjust these suggestions in the next version.

>
>>  >--->--->---return !!$smtp->auth($sasl);
>
> Shouldn't we do the same kind of changes for this `smpt->auth()` as the
> other below?
>

I=E2=80=99ll review both instances of the smtp->auth() call and update them=
 so they
follow a consistent approach in error handling and formatting.

>> +>--->---if ($error) {
>> +>--->--->---# Match temporary errors
>> +>--->--->---if ($error =3D~ /timeout|temporary|greylist|throttled|quota=
\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\s+error/i)=
 {
>
> Where do we get this list from? Regex matching errors for the type
> doesn't seem like the best way to go about this.
>

I agree with your assessment. Initially, I aimed to interpret the SMTP
server's responses directly. But after considering your suggestion, I
realized that I should use SMTP servers return standardized status codes
for command outcomes according to RFC 5321 (4.2.2 Reply Codes by Function
Groups). I will improve it.

>> +>--->---return !!$result;
>>  >---});
>> -
>
> Nit: unnecessary newline removal
>

I will adjust these suggestions in the next version.

On Tue, Mar 11, 2025 at 6:14=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Zheng Yuting <05zyt30@gmail.com> writes:
>
> I see that you've added a cover message detailing the patch, but
> individual patches should include the relevant commit description and
> message. This is also outlined in 'Documentation/SubmittingPatches'.
>
> That said my perl knowledge is limited, but I'll ask some questions
> anyways.
>
> > ---
> >  git-send-email.perl | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 798d59b84f..a012d61abb 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1419,19 +1419,19 @@ sub/ smtp_auth_maybe {
> >               die "invalid smtp auth: '${smtp_auth}'";
> >       }
> >
> > -     # TODO: Authentication may fail not because credentials were
> > +     # Authentication may fail not because credentials were
> >       # invalid but due to other reasons, in which we should not
> >       # reject credentials.
> >       $auth =3D Git::credential({
> >               'protocol' =3D> 'smtp',
> >               'host' =3D> smtp_host_string(),
> >               'username' =3D> $smtp_authuser,
> > -             # if there's no password, "git credential fill" will
> > -             # give us one, otherwise it'll just pass this one.
>
> I didn't understand why these comments were removed.
>
> >               'password' =3D> $smtp_authpass
> > +
>
> Nit: unnecessary newline.
>
> >       }, sub {
> >               my $cred =3D shift;
> > -
> > +             my $result;
> > +             my $error;
>
> Nit: It is easier to read with a newline separating the variable
> declaration with the rest of the code.
>
> >               if ($smtp_auth) {
> >                       my $sasl =3D Authen::SASL->new(
> >                               mechanism =3D> $smtp_auth,
> > @@ -1441,13 +1441,27 @@ sub smtp_auth_maybe {
> >                                       authname =3D> $cred->{'username'}=
,
> >                               }
> >                       );
> > -
>
> Nit: unnecessary newline removal
>
> >                       return !!$smtp->auth($sasl);
>
> Shouldn't we do the same kind of changes for this `smpt->auth()` as the
> other below?
>
> > +             } else {
> > +                     # Handle plain authentication errors
> > +                     eval {
> > +                             $result =3D $smtp->auth($cred->{'username=
'}, $cred->{'password'});
> > +                             1; # Ensure true value is returned
> > +                     } or do {
> > +                             $error =3D $@ || 'Unknown error';
> > +                     };
>
> Okay, so here we try to do the authentication and if there aren't any
> exceptions we return 1.
>
> >               }
> > -
> > -             return !!$smtp->auth($cred->{'username'}, $cred->{'passwo=
rd'});
> > +             # Unified error handling logic
> > +             if ($error) {
> > +                     # Match temporary errors
> > +                     if ($error =3D~ /timeout|temporary|greylist|throt=
tled|quota\s+exceeded|queue|overload|try\s+again|connection\s+lost|network\=
s+error/i) {
>
> Where do we get this list from? Regex matching errors for the type
> doesn't seem like the best way to go about this.
>
> > +                             warn "SMTP temporary error: $error";
> > +                             return 1;
> > +                     }
> > +                     return 0;
> > +             }
> > +             return !!$result;
> >       });
> > -
>
> Nit: unnecessary newline removal
>
> >       return $auth;
> >  }
> >
> > --
> > 2.49.0.rc0.57.gdb91954e18
