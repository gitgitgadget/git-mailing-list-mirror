Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2F1A5BA9
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255665; cv=none; b=D8Ykn3/EI+/+IGB6vSxmeiN8XuetaGHseIHR+9YkQ3s/M8woUP0v0OmAgSrFcDJPg7t8iL9SKUdy9mKsV3R/qkeRgj+iPi1nYbojkJeMvPNOEIqSVvfHcKAOZN3oFKt3/OKe2W+ZVwm9QtLvbBMKNQXOpHCUx7UJBqflDTCTwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255665; c=relaxed/simple;
	bh=Kcn33Re+kbtz05FfBA5DSmxbrq2YqW9QturaoJxGTJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDFRl66iWI+7/1s06Hr4ZFCSGwx6C/ZtNyhQ+7vh56CA+0YgSqijLs3mIu0d7wFW/0HDhr7X5LdPytZNRuk1UKfCpoREaKJYNHmO0f/Tf5OXQRot3SAlHasfOb8caLAVCwDGvkJhByVpjm/0fCp0Iyzi99/t/mGftkBuIcRUaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjME/mPi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjME/mPi"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad69e4f2100so311979266b.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255662; x=1748860462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V/nBjGscUKNqj2Na/UwvyFlFb4JiTQfxD56xgKv6YQ=;
        b=QjME/mPiRdC6403iqgWidxfFo0OQ5FIcrWiulSPtk+CS2GSUXt/GHblLbVKoQFfE17
         DvMJdFdZVXA4ibIy3GfqlanFi4Kc/dQ/cT6mQWhe4PHAq2xL/PmNOHdnf3qTKU9BQEqb
         1TKUhtN4sxsXZQPuxuX8lrHpfuPtJEjD3utOzgLwNLQzKNSygHLC/oJyht/S4CnYchLu
         oPcHpr85Yu7MZxTWWQiCL9dmqdoLVC3OVRbXc6Tn4uiSZQOlfg4rnzxUBE/7a+mGef74
         qK9EEZDEMUDTRbMkB2sbgExlX9gYXpIhjuA+ECgRWOG2xIXQLQa6NuFLM2AxLmULEbKS
         8E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255662; x=1748860462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V/nBjGscUKNqj2Na/UwvyFlFb4JiTQfxD56xgKv6YQ=;
        b=Wn5NegmcJFaQhGu6EDCYhPiR+6TbpROm3Z+MMiV/mfDWfdbAeZw7fjTWGz11SbMy9V
         w4Y1aaQ7R/i7K+xCpvY7+aDZqyjGj9LGxnzFSfUT7cV3dnaMYhmAloYvTJ/Nrz9C73No
         aIIvHR2PXkVjtSeq3F+peChEirsqRp+R5RiZ+Ghvkwj9BEpsoNOifk/jfKX9N+tvwu98
         Sjk63fTPqbhPB8RYHfp4fIn7sDb8wwfj1JLJK4RZKQG6PeltJ35B+1pefaN9rKRkwvdC
         9sJIp13wjK1Yaojy9UtSYEPHG0ZquqACcPgRU57zMf9nvFKPDukpbAeUUyxOK4O4f+Lu
         JYiQ==
X-Gm-Message-State: AOJu0YxgfJf0vWwSswgejGRXWBM5u4NkgjsC9WxsVkMDVH+3IELfsqX+
	MrIAHKn9X10jh9T/6cgaoaxCj/sHIYd2pVNRtYjL+hVAMo0y6cSEhcUmm1aehV6jpHaVfET/RJl
	QXZwOFxOZaZd5/xj+z2WQTJE2eMOWC71v8JLR
X-Gm-Gg: ASbGncuhX4a4gOMqKVakUntk6fgcMgdcF1joKjAG2uVQcUE9Vku4XsGEo2tuyY60lom
	GVvS31U6lU2zNEyvAe2X6bytV8PaT031JDmJj35FyhFIP4fZ/G9dtyFRlASdfgYc7CHcxrislPg
	iMHFM4Erco/kgkoUav3rYxCGdYnBRD4DCwkU0=
X-Google-Smtp-Source: AGHT+IHeBjDUFDKfPoHjlH1sl/R+z2fxqJBTpilj4BqHvU8kWDS0QizkJhSWNFu3Drvv0RGf2/J5J2twLcBI5Tfqhx0=
X-Received: by 2002:a17:907:80b:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ad85b1844eemr670143566b.23.1748255661886; Mon, 26 May 2025
 03:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com> <xmqqselxtfyf.fsf@gitster.g>
In-Reply-To: <xmqqselxtfyf.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 May 2025 12:34:10 +0200
X-Gm-Features: AX0GCFtT04bVih8Y3T-wsTyTau0G-AsGIASTL7uOKxCDLxm4Z3cJ7ofVCG8tKks
Message-ID: <CAP8UFD3BbxDGg=pAPfgxkwtuCC1gsmjnyOQhJgZyu7R_hxOyAw@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 63880b595c..59e991a03c 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -29,6 +29,7 @@
> >  #include "commit-reach.h"
> >  #include "khash.h"
> >  #include "date.h"
> > +#include "gpg-interface.h"
> >
> >  #define PACK_ID_BITS 16
> >  #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
> > @@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
> >                       "encoding %s\n",
> >                       encoding);
> >       if (sig_alg) {
> > -             if (!strcmp(sig_alg, "sha1"))
> > -                     strbuf_addstr(&new_data, "gpgsig ");
> > -             else if (!strcmp(sig_alg, "sha256"))
> > +             if (!strcmp(sig_alg, "sha256"))
> >                       strbuf_addstr(&new_data, "gpgsig-sha256 ");
> > -             else
> > -                     die("Expected gpgsig algorithm sha1 or sha256, go=
t %s", sig_alg);
> > +             else if (valid_signature_name(sig_alg))
> > +                     strbuf_addstr(&new_data, "gpgsig ");
> > +             else if (!strcmp(sig_alg, "unknown")) {
> > +                     warning("Unknown gpgsig algorithm name!");
> > +                     strbuf_addstr(&new_data, "gpgsig ");
> > +             } else
> > +                     die("Invalid gpgsig algorithm name, got '%s'", si=
g_alg);
>
> Hmph, we used to have special cases for sha1 and sha256 but now we
> can handle sha1 with a more generic "valid_signature_name()" logic?
> And yet we need to still special case sha256?  Not that I trust the
> old code all that much and take deviations from the patterns in the
> old code as a sign of something not right...
>
> The fast-export stream produced by the code with d9cb0e6f
> (fast-export, fast-import: add support for signed-commits,
> 2025-03-10) used to identify a signature algorithm "sha1", but this
> new version of fast-import lost the support for it, and will barf
> when seeing such an existing fast-export stream?  I am not sure what
> is going on around this code.
>
> I am not so worried about the other case, where the stream produced
> by fast-export contained in this version may or may not be readable
> by an older version of fast-import.
>
> I am puzzled enough, so I'll stop here for now.

I am also not sure about the best way to approach this, so I tried a
new approach in v2.

Anyway thanks for your comments! I will address them if we decide that
the approach in this patch is still worth pursuing.
