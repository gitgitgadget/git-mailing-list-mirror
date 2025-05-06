Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D4221FA0
	for <git@vger.kernel.org>; Tue,  6 May 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512086; cv=none; b=dvmkDYE8F3Pv7F+EGK0r1uc6CRTgJVOn52k1igXk/zPTbe7GANA3acpvInGEnBf98c1kUTObf/hLJ9LEWLqq6r/+hBsx0B8/fzfcV4LXJHuvF4k18a2TB4Zr1WKJMzCO9M9NToyg9/1fd6W91b75EbCs6pV3yuRPr/YXmNFpYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512086; c=relaxed/simple;
	bh=SWQre0T/2k4GAc3nkvZFZdZnAONDcZsGd0TwCg4PftM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCnQywyg4+sD8cjV07vJWBoVwARokp61j7dqdZm5drWgEEA5HvCTW6cey4ow7HbaGhLcS23n6uIV11WqZOztxh4gUn4sJbuq6jU1nCNPZSfblOWtR7vAyUuYe84JUlmjR6xIunngPJx40XcAgr1pS6Tm7JNvAEz8HQPH64ulUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=yW6NJLE4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="yW6NJLE4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301e05b90caso5622950a91.2
        for <git@vger.kernel.org>; Mon, 05 May 2025 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1746512083; x=1747116883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVH9uszKUf0ImyZn7pUcvK6tOg67lyVz/6ILO2VOaVg=;
        b=yW6NJLE4QXNu7O0z466OCZFLaoa2RFnnHhlF5AEWttz7sro9Mn1OA9PCQ4bpTtNG6s
         cfpCHRcPu4XlUV4vYiAISuaQZwFHy4Ps4thvJvoxiN8yWs5O1Sk+7njjOYe1GxwXF8+6
         KFWNh/xQtByFKLcTIi1N+YGn4C/XF7ZOwpa/LT8McNGDHN1Gu8IhVnsNo85WX8yiuxAB
         4yl+Ic855LCRFCYyGiJpmtMbcdU9Okm1u++pVeVOpDXSFGfNSiIP56S/iQ8pQmtjJY55
         N9Ev2Hg6DrBdoc8jIlZsRvq/ggRByVNY8y+y/VtPwsa3uJO9zYjU4jgY/wsrW7Cqy4Ta
         2yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746512083; x=1747116883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVH9uszKUf0ImyZn7pUcvK6tOg67lyVz/6ILO2VOaVg=;
        b=E7KZycagAHE4RGn8BtOtJflszOSl0dn3r+CXoMjMH8L9JTz/Hu4shsI0w+HVbvU3O/
         WfiBFQFJos93W4cjTWwwk8Q8fG+DNo9pEaArDo6kTXPwd2wG11CkJQOofIpj2nsGR1Q6
         cKAr2Mv05EPgGAyC6nqjjh1+pZEbirva58nidVlvtscm/W1GyEycHl1hVC0bzDY/zQhc
         h2zrWYaO2hdHor1GRzeaq88niT162ZizdBsahLoFtlyH3Mlohrsj3cAXdOwoyJErnFbU
         D32+JxyOd4i4a8chjNCjo54J1jg+8Ep1j1gcVrxS/+wkdtYNWH6Sco4ew7Xt1pFFLAZl
         ci+w==
X-Forwarded-Encrypted: i=1; AJvYcCXGv6BMrUNHDsTwxZCZiVshEK5+nF81jdYC7nzmBRxKeGB6byfL4Ix/qjdRgYd5sWBI6Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ6Xmk2mZUZUWKj/LX0mNe4i5CFAmP39p0Q6Qhi4np2gtKhmm
	1JY9sW9/HYiS5Wfcp5LwywwND+qElit8oE4S6mk5GhUidEYPGEOkUJnw67mw0mwQ4kN0ZMjUTnA
	FsFfpUrE5MKnbU7Q9fkp80uLfrDvgddQNjJlw0sUWEl4zYHgLVVcPNa7jFLgV6DolbrJ8hypkiA
	tGuiwkzO1stduY2gwHfJe6i0fF7hNJZK0RA/pfH38bZziN0jxa42ObIZ+UnZdJU1NMlEjUZLcrO
	01UbT4adkQh2TpKdgklan91aBQhrJkP8elmYCtdLDPOYchxfQdT+tYoFZzCLBEtp/Mr64HK5Ot1
	Wyjg3IjeIyA=
X-Gm-Gg: ASbGncuTBgBcDAS5fkGfdsfkR/0DGoKMpQk6pGg5C8iYpnWFzmDEHDItD8tlPad9wQi
	i7ygCOdjv785f5pNoxYlOK0W2J18cpMtYoO/sWQMWndR0LTWY88yJep0S6AYlQpIOOijMZ96eo9
	zH4u8UMd5lUiawPQOKRo2UYOs=
X-Google-Smtp-Source: AGHT+IG9Qn4Nuo8hmyxgOYvDCyrbFdOpPbs6YLNjI+Vt7oDYHmElC+4edXAor+t/qFTx0xjGa0uovMQiMyHSM+WyQdI=
X-Received: by 2002:a17:90b:5148:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-30a7bf68f44mr3410817a91.7.1746512082659; Mon, 05 May 2025
 23:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de> <xmqqjz6uokdx.fsf@gitster.g>
In-Reply-To: <xmqqjz6uokdx.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Tue, 6 May 2025 15:14:30 +0900
X-Gm-Features: ATxdqUGGKozQmEa7Wa3N4bblKzwxsDpZ6CAgctVXAQprX6ayKwzMvFni16Bw8iQ
Message-ID: <CAOTNsDw=0+2pLfPTaGdfwpMrnFDJ9nTBiwRO6w=fZ=Am5thXXA@mail.gmail.com>
Subject: Re: Problems with 82e79c63642c, NOT_CONSTANT with sigfillset()
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
> > There is a problem with the somewhat new
> > commit 82e79c63642c introducing NOT_CONSTANT with sigfillset():
> >
> > Compiling on older (?) MacOs machine leads to this:
> >     Undefined symbols for architecture x86_64:
> >       "_false_but_the_compiler_does_not_know_it_", referenced from:
> >           _start_command in libgit.a(run-command.o)
> >
> > What is the best thing to avoid this ?
> >
> > The introduced "false_but_the_compiler_does_not_know_it" triggers here
> > because there is a proper prototype in signal.h and then a
> > #define sigfillset() ...
> > further down in the file, which can never fail.
> >
> > a) Define a sigfillset_or_die_if_needed macro,
> >   which does what we have today, and is simply defined
> >   as sigfillset() without any error checking for MacOs(some version)
> > b) Revert the commit (and fix the conflicts)
> > c) Anything better ?
> >
> > I have a raw patch for b), not fully cooked, as the commit message
> > is the hardest part. Before sending that out:
> > Are the thoughts about a better solution ?
>
> How about figuring out why it does not work on your system?
>
> Namely, compiling compiler-tricks/not-constant.c should yield
> compiler-tricks/not-constant.o and that should be "ar"ed into
> libgit.a, just like config.o, connect.o, etc., so I cannot see how
> your ld fails to find false_but_the_compiler_does_not_know_it when
> it has no problem with say git_config or other global symbols.
>

I reproduced the issue with Xcode 14.2 on macOS Monterey. It seems to
be caused by the ld command's bug and can be avoided by tweaking
Makefile:

diff --git a/Makefile b/Makefile
index 8a7f1c7654..8a06db8400 100644
--- a/Makefile
+++ b/Makefile
@@ -1387,7 +1387,7 @@ UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/lib-reftable.o

 # xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_F=
ILE)
+GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
$(LIB_FILE) compiler-tricks/not-constant.o
 EXTLIBS =3D

 GIT_USER_AGENT =3D git/$(GIT_VERSION)

or by explicitly initializing false_but_the_compiler_does_not_know_it_
(which changes the symbol type from 'C' to 'S'):

diff --git a/compiler-tricks/not-constant.c b/compiler-tricks/not-constant.=
c
index 1da3ffc2f5..9fb4f275b1 100644
--- a/compiler-tricks/not-constant.c
+++ b/compiler-tricks/not-constant.c
@@ -1,2 +1,2 @@
 #include <git-compat-util.h>
-int false_but_the_compiler_does_not_know_it_;
+int false_but_the_compiler_does_not_know_it_ =3D 0;

Koji Nakamaru
