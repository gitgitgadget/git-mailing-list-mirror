Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF94302766
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029560; cv=pass; b=c/WhD1GhLDVXTALr5xIkhZBiFCok5UVhgCFcQcIHFrDF/lIqmOgnDF1PAj3/lP+fM8dbQ0fRfFoz8AST4hL2vFy3n3cEXZGR8kzseCn+X03Gi7gmTx7ygk3OI1Jn2HMU05VK+I3ZnUan8msQ2aKl26hPTW9wDNrWRJ63cOFMzqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029560; c=relaxed/simple;
	bh=m79ReTPRp9kZVhx4FYIF81IiuxOI1VDbgoH//AwW8Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjzKYrbXDtw3RlFT1JmeGOFMY0JF5Y2J478KoKnXKdUD47csK7V7a0LNBWlWpNffluHxa/PZHIzSqZ1QeU5OfbZbruNYe4+NW1KwaKYuDfMxkgQKKFb5fwsyuo4skjteCuhmVgYggiR644NXRLfcLjn+TgyRuKs38Ao/8HACBx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBdGk6Mq; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBdGk6Mq"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so189455e87.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:05:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029555; cv=none;
        d=google.com; s=arc-20240605;
        b=e1/mGdLf5fERf6IGesnHwfhsBpYEX22z/j1oSTBJNITuF/ebXORfYxLIdADtU490C8
         antEJSSUz/XOKtoILVsb89xHdxtcYZbKZbrChYmO2WBXd3R08iKvxwND3SaX3hOX4ZPI
         868ZaodkDvUIXOymLlL9SbAUxBixT4rkHxDxYJ5bCE2wEYmlFq+guEYstUPoYkjqOyv0
         RU3gRJqibeJMaoipuhMw1nc0OEsI4SslZa/OStFyVqFjAC/pJbPt4U3tD6MloUFsmbFM
         3Q6Bu90N7DBmhT8phMGI00O3FN45juN8armd/QuhWn/kPh1shQYGxlzgMrctANK/03+y
         ba1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMvLt+4a5e6NWLlOctbk6qmatBzdpqjfGfeXHammhyU=;
        fh=Bh3Ywnv4FELuotr7n437Sal/ETGMbkk5vf1YhvrDV5A=;
        b=ebIVHwMABIb/9UiFzfFArdpgFHbi1zsy6c/WZM+BcD61613OcYNyw+SvUJikku4nFg
         CnTJOCtSxXEpaTc9xIYij23NT+ZQD7f9GubkNZmrBbzRe1c8C+mQOh0+yXQJyfxmA7MD
         WzC+EVGAg52gcqIDkhOS5+ZVsu8TZ04t3XuCNs6Bqy573d6tv6eodZrkHspv2akxm77B
         Qe9lZ6VqO1I4fFdmdt6FmZqkZErzXYWQKflu6PqM7yo/mxjIOIJnR3oTxAF5JZI7IcMi
         TxVblKhlHAN0Q4dpECfLBP60al4Ni2+jOEX8AyUwv3aVxqSkPfBI3uZLQRoOWOgdUWq7
         gvEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769029555; x=1769634355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMvLt+4a5e6NWLlOctbk6qmatBzdpqjfGfeXHammhyU=;
        b=gBdGk6MqJwOylw7O3EMi6xGXCwNZvqpAdFUoA2IAafEm4bV5JeUT4v4L/6IpXcWRWv
         BSQca48pZAl3AEN8gWppfb50iqJNXs713EZGFB9kDmW1DFqNMFaoHD0gHc3VBa51Mm+9
         VJVEoQuwTRkwB85BYO151xzrW6VYEtHDpo3NmSGsF8eFN4bs55fS8oDEROUcjeaqTXPC
         SH8SOSZnzjY2fR3vPxWP4gnQ5aiyOj018UW3N/LUQVVZDsuAPmjEFaEzAxjTud5KkqK/
         u9nkmIzwdvQOsarJ202xHGmMSqAmq/ajoVKIbR98kmQwx6X61IwCGBVcEYknFqE5dDvr
         sgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029555; x=1769634355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMvLt+4a5e6NWLlOctbk6qmatBzdpqjfGfeXHammhyU=;
        b=pKetQy9PdhHRlzkHeu8Xv+xjMqWELuyb12hSKkckphuA/J7DA6+o6tHm1xsP8GPXrT
         SwGZifN5xRvtEQgEEJu4jDpHTV03IUMPlPat2gB3tj/Oo0pbHwThdedNsZQZUsYdbw2B
         yUw0HHMVKnpZQde50tQplIiBPLXQzTBTlA3zLe6PX1OF7VYIdhHh171rv8zyoNX6afBO
         8UKwR3NuadJNv9h5xw6zc/hyJNeiuoGotXLqf8te9UJSoKi6u3CtUvB9nsBWO1pZTelG
         6DD6Iu3TxYSSfqnXUSRzIbkGSnInfQllvBwqaZNoFhTxcbW4UEE+HHgnajjLIDhgFQNU
         gq4g==
X-Forwarded-Encrypted: i=1; AJvYcCX2v5VIaBdL+vLcB5hhNJ4zgcrM6LhWc+IbVtmBsqKwzZ29CwibA89hhUON7SkvvHUX1ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcNkXlfE8lm0pKOYomZN1yng7H5wMXyxSxxgKlaHCTlcqIPMI
	SFlFzeXjuaWpaWNf7L7DjgryaJIHyWFpyG2JrdnU35/L49YS9/iimGyy6sgz5RR3RqcuTGlH3u5
	wtp7p/Rl1VNaUmBBoo89TK0wfjbMmv8A=
X-Gm-Gg: AZuq6aLLVf0hiFFXaVsMy4FDXtMfpwkEWgWTgMhoZFq4nq6Ft2reOi21M2mYTxnjQV6
	u2VbGYGRvov0lzj6CUgnwyIPJuHTXWonj/kIP9hSMGrOEDfsYcLvliR9OG4cPR0n1hN/tfkfaO7
	XKzvF8XZ9zH6jFpD8p52kra0UuMSv1ivTWhagaisXwiGdZVsen+ZaBznpq/WrV7EYg0P9FPJbMt
	Yro6u03taqIWlvM4jhuMJv4ERfnM+dwbv++CFojs/5PY2gOmJ/JpxeXecb/r1EYyjcS/5o=
X-Received: by 2002:a05:6512:3ba2:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59baffe82b2mr6489157e87.47.1769029554454; Wed, 21 Jan 2026
 13:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <9bd01bce9f0763d9dcc962ff94fcda36346bafc4.1767379944.git.gitgitgadget@gmail.com>
 <1c46f551-0040-481e-9476-bc1b85f92636@gmail.com>
In-Reply-To: <1c46f551-0040-481e-9476-bc1b85f92636@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 21 Jan 2026 14:05:42 -0700
X-Gm-Features: AZwV_QiYaxN6YT6na5oU7ww-eQ7jVpdAmICO-GnxuwRai4L2q63Jtclg7raktmQ
Message-ID: <CAH=ZcbAb-iQM81Sd79KtFV0nf1gv4gfnBBvJ2AvcxCTN9xOr7Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] xdiff: make classic diff explicit by creating xdl_do_classic_diff()
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:01=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Later patches will prepare xdl_cleanup_records() to be moved into xdiff=
i.c
> > since only the classic diff uses that function.
>
> I assume that's to make it easier to covert the myers implementation to
> rust without affecting the rest of the code? If so it would be nice to
> say that.

Making it easier to port to Rust is a side effect. The primary goal is
to simplify the job of xprepare to only parsing and hashing lines in a
file. xdl_cleanup_records() is only used by classic diff
(myers/minimal) which means it doesn't belong in xprepare because it's
part of a diff algorithm and isn't relevant to preparing the file for
a diff algorithm. Perhaps xdl_trim_ends() should be moved into
xdl_do_diff() too...

> > Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>
> > +int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> > +             xdfenv_t *xe) {
> > +     int res;
> > +
> > +     if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
> > +             return -1;
> > +
> > +     if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_PATIENCE_DIFF) {
> > +             res =3D xdl_do_patience_diff(xpp, xe);
> > +             goto out;
> > +     }
> > +
> > +     if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF) {
> > +             res =3D xdl_do_histogram_diff(xpp, xe);
> > +             goto out;
> > +     }
> > +
> > +     res =3D xdl_do_classic_diff(xe, xpp->flags);
>
> This might be clearer that we're calling only one of the three functions
> if we wrote this as
>
>         if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDIF_PATIENCE_DIFF)
>                 res =3D xdl_do_patience_diff(xpp, xe);
>         else if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF)
>                 res =3D xdl_do_histogram_diff(xpp, xe);
>         else
>                 res =3D xdl_do_classic_diff(xe, xpp->flags);
>
> and then we can drop the out: label

In a later cleanup, I make this exact change :)
