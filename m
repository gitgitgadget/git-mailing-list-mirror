Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679341917C2
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942339; cv=none; b=rqN+eEqtmMYvvv38yKNRJdFnmnbQhLY8fgtr6vwwYgvnAGkr0enGRPVuP+1d/dFlJCb8dUvudK43VZaEJc2yKlM3UuCeZRE8ce1Bu426FP/V+Bqz1TgBq8kOhB6eKTEj1jQfVkg9BJHzNHCcGQsngSduhj83egrHzDi9qe3+iTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942339; c=relaxed/simple;
	bh=gTeAUwKst0ZNgeyUhoEEhY2YHQmQ/7M/K05QqfVTayQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Le8ICyHn5OMjj+1/YvKDnRhqRBZzo1YZr+6KN/SWB7Z/bLRTgSfPsyVpCg3w+jg81eEDhLRRPCQSsJKRh9YSm1NwErBdYMLiK67qE3pNV/stuiy0Zqr90CSXQXAkAqjven5B7vrG2KCnJYAfTOll5+t9GvW8S0IQw5174kQV+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8c3de60f2so8271526d6.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 12:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747942334; x=1748547134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBinrZzB3mX3e234+AMqy5ytnrvZYOolz6cUeVskHZ4=;
        b=oa34OWnR+Oc89E8b8GN2JLra0zcJFDnNl7CXVPpqDytm99PkZEP5/Yw6fxotCuEK1N
         h8v3oc8LUhB7Q6XNE0YKlr6WL2J2Xy+x9+h46IjdmbqNWdCBsBl7YSWuUBaGsSokRiYE
         98/eT1L6gJongST1xs52IAr0sXxZx39LL834XdOdbHKW7x/doJDlo4oZaoVZyWmb7PzI
         jHV0DeZjFgy6KBM2z8JWinV4u25KmLwA/mSzodWSJ7CxsgHQUEwCCq277psEJSEw2yj9
         HDWcdiJRq+aNC+kc+nkLg2fBMllDBUW3sN9hFu9XCmATBO4UQQ/sl0gqH6ZeM5ZwlNHQ
         eBcA==
X-Forwarded-Encrypted: i=1; AJvYcCWWt/SZEpqOBhv4gGofJmFbIKaxmr8EuoDHiHrXDkO/nxqAGAKxEU6DVNTt3sxwuaAjJe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAdEUn/Ix1WQtI1S9I1Hw7a4EDBU6fEAqG+xtJdjTA3JopOCJ
	Zh2GwKWkKppG1sNaHobJTRUgTAcXyGg+L7u8+KSG7RuxGkkSjymYr/L8llJnRIDftbrutw5vGli
	olaqtDxMMnVkBe7eABw2r8/hd6E9pxwg=
X-Gm-Gg: ASbGncuABd3Onxro/tKO3Qss/d8JGpBQnRaM8wnNvuUfan/kO5tI50vu1TcykB6jy4t
	vUDtYS9be7ZXYVxEEIgYbIq0dujKXdEmTvQrRq69rsF2Gzu4dD9XACAkOHto2LOeRGJQtyutord
	E05lDK9HolhFm++qStQM4Kqh0Mt2CVhH/A/MvrQBUeqZbAWqpVD5sE9naHLJJl0N0=
X-Google-Smtp-Source: AGHT+IFkPM/E/B2bvLk3pInqQa6ipYkr6QfTpS9L0oe3IVvR07Jfp5ZXD8hWT0JsANg16LtEfJ1Org/QLIsI66r3zWw=
X-Received: by 2002:a05:6214:2586:b0:6fa:8aa6:af83 with SMTP id
 6a1803df08f44-6fa8aa6afccmr17762686d6.4.1747942334174; Thu, 22 May 2025
 12:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95972EB02A873B8998F51877B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB95972EB02A873B8998F51877B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 22 May 2025 15:32:02 -0400
X-Gm-Features: AX0GCFsnJv3KmNEadn2Q9zgK6cC4DjSAHdR0KhmbYffZtn5hgIiuTPX6duAP2Xc
Message-ID: <CAPig+cQkrwy2GBNh7OdBAzWnuSo7mVH1XFUyuB7LzJ4cMf10MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>, 
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:30=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
> > Not sure about server_fill_credential(), but I think this is also
> > a potential memory leak
> >
> > static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
> > {
> >       int ret;
> >       char *response;
> >
> >       response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
> >
> >       ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(respo=
nse));
> >       if (ret !=3D strlen(response))
> > +             free(response); // fix for the leak
> >               return error("IMAP error: sending response failed");
> >
> >       free(response);
> >
> >       return 0;
> > }
>
> So this change leads to:
>
>   imap-send.c:990:2: error: code will never be executed [-Werror,-Wunreac=
hable-code]
>           free(response);
>           ^~~~

Is that because you forgot the curly braces around the `if` body?

    if (ret !=3D strlen(response)) {
        free(response);
        return error("IMAP error: sending response failed");
    }

    free(response);
