Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169302F22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907374; cv=none; b=U/cd6Eg5MsvDLCNKnl+pOLVy+tGG/Yr2QXbN/HYoq3uyN582sjyrpX0UZ47wSd6Gvghi6c6eOGJc+tz/D/yNYMRTqEA2Y7MTFwre8qHWRs3sYu/wB+nhCe3L4XVH94SK136QGWX85gad31lauZvbyuS7vaDtFgFBr1IimGJVnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907374; c=relaxed/simple;
	bh=9FDELH92FNkJwar7XM5V1FFlebll7NGgilGK2WCkH0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rQLQecF/KDBqeHe2mocAf+/AC8Lq5u7oWZkbUeK3CkurawK2ZdlP4nLK/lip95yKpznew2ONHy2i+vf/jnjP4dyyENRcq1pLm3AbubGP6sTk5dzkV68LqKS10JH97OLmiWTyTf66UGVlCDfIn3uUkzuzbOPeUIIPn1VnSJjhOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb33996b79so393446d6.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907371; x=1728512171;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wRP1fjf2NvYZwVj4+kIY48wXuGMT+IFr2yG+sMzolY=;
        b=Y3FexxHgTV1VsRYwheClNpzaz9tDJqzbe1TZxdtm+e37mi8FAJRTxiNe3swgdsPkax
         IifG5UDFKZ2i1ahhUvZ52yunus4sadUQHP2WjZYTGzjNjoluYK0YEj1i/4Ll7qDfivmT
         cHV4YqAdVuylWvPLf66xSFBnToDafNEcJqKyVsv55in+LpqWVUh3ShxpYOKsUwjADkYm
         OS2hvBXoJC1NqdZbc2BwsPgjQeQDPbwi1T8rd//q7XYvU+LDnA8WdrWISa1MM2YCpmTe
         Ap7bykCU5qixz2LJY5m5gNc11O07L0lADRqenOkBDKSjriSI/zUMHadyPC3cxwIh/8gy
         SaFA==
X-Forwarded-Encrypted: i=1; AJvYcCUKz9pM1wjH/6xBweXYvEfdGMbRX/KyO6ZZfSAqUWD9Xf3H8A7yMyHCDGWihtIUBYNFqqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH444gQDWpZ0qnfdvs85j5B09bZNBKKDDlcVzQAWYYddlx4PeJ
	31UC15sv90MijzHtsXBQMybDP4LlWfcSajCjfNQpmUsw6PDFSyS5O1oMetQ2sy3884eYuKch3cZ
	IT3srOB3BDpIZy+ZXWIJCOIYfbo4=
X-Google-Smtp-Source: AGHT+IFpL/AaHSYxuQaYG3U3ORwBGmrhwxGgaooASxEix1CJ62iyL0TA8ArYLEpEU+VstksbpXXbYI4Cxcp5+dF8tEg=
X-Received: by 2002:a05:6214:2022:b0:6cb:5d84:d482 with SMTP id
 6a1803df08f44-6cb81a90f80mr31794846d6.9.1727907370873; Wed, 02 Oct 2024
 15:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net> <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
In-Reply-To: <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 18:16:00 -0400
Message-ID: <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: "brian m. carlson" <sandals@crustytoothpaste.net>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:04=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2024-10-02 at 09:54:52, Phillip Wood wrote:
> > Part of the reason it works well in rust is that it supports discrimina=
ted
> > unions with pattern matching and has the "?" macro for early returns. I=
n C
> > the code ends up being quite verbose compared to taking a pointer to er=
ror
> > struct as a function parameter and returning a boolean success/fail fla=
g.
> >
> >     struct git_error e;
> >     struct object_id oid;
> >
> >     e =3D repo_get_oid(r, "HEAD", &oid);
> >     if (!GIT_ERROR_SUCCESS(e))
> >         return e;
> >
> > With a boolean return we can have
> >
> >     struct object_id oid;
> >
> >     if (repo_get_oid(r, "HEAD", &oid, e))
> >         return -1;
> >
> > where "e" is a "struct git_error*" passed into the function.
>
> However, Go still uses this kind of error handling, and many people use
> it every day with this limitation, so I don't think it's too awful for
> what we're getting.  I won't say that Go is my favourite language and I
> do prefer the less verbose error handling in Rust, but the fact that
> this design is widely used means that it's at least a defensible
> decision.

I'm not sure I understand your response to Phillip's observation.
Idiomatic error handling in Go:

    if oid, err :=3D repo_get_oid(r, "HEAD"); err !=3D nil {
        return err;
    }

seems much closer to Phillip's more succinct example than to the more
verbose example using GIT_ERROR_SUCCESS().
