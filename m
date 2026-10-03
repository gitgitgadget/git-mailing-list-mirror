Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5170486407
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047457; cv=pass; b=aKT3NndJPlVgSEfMmzNeLjjvThLgOh1dCn9zORKGBd/t166Ko9Ni0q6PRncQMTeOXpfwoP0xhZcIJ+Iw3W5StnnoBkS//vzkBjFvwZEEGQyhojUzppDU2eFfyWIme1q5IjCs2/Ikgpjs+6v0yGox7te+g6ftrwTYq6IarjSPuMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047457; c=relaxed/simple;
	bh=2QmXI+gXy4BLRCopvAcyNbSpyrOoPUKKHx/p7k3Ld8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2dUlWRf/RXLEzND1hyesoPJLhokQ4+w+f5hslhxgkBt/niCVeL3CfxR4+dLZjZdgVEmLKeoqJ2NLK0LGwZLyHt1rqNuVbYx9BhX1EMcezFWLFIx6cKFQHUYOlbiBCv0JEaa9vYYuyGytrps1PGqb8ULyX2Xpg3Y35k1GEKQDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmaCg5NI; arc=pass smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmaCg5NI"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-88a0f29ce98so198348b3a.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 10:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791047455; cv=none;
        d=google.com; s=arc-20260327;
        b=VJN1lAaHSj8OLQQV4ImU29eRmoMbgS0CUEsyA6aqfVgoeA+Ft89afyJTJKtmcdx34w
         mAfMI4NBqXQlyAzdW3eUQBngHK3BiGJ32xsSyWmiYwurK887SELgM6SXh5LVqBgUYBLD
         LWLsZcLJ7Gf/7HCNyoOCXmoONGQSiEGbpvAPsAszge7I/F0zUP/jSZC3jUWSaHLYqjHq
         iTsmvlKGwqZyRYZVQ27ONRM5qDeal9QgcaY5vKS/4pOJFvCXiarLfbQPZSSqPvg62j8e
         qxOAs9bFg/1LWMIRx5fwTg9bGQ36IZaQ8gl6f7eGar2k2kwsklOEM8rianNPpZPE6ypf
         qmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDHX4TKj0c7j+DRK9CBhl/WQkx4j2rho8VDSEeSV3v0=;
        fh=P8ovN1b06OxxEc3fDOCFiy1b5qnKmrjdZyZ14XGhz4s=;
        b=P72ZMTrtBiULAF534XxnFD0WOW5mMIKrcqqej2eBzGi7mgS3b9llHp6EN+q8iL+R89
         7CIOmlRQcYxoj8TlIWfjFtkDzhO8WZlZRyYCMwXYiBYj+RU/s6BOu7ui4b/jGQGQdDoU
         DIDBt8IYO/BlimQwI2tiNVsYJV687S+rMvmFh617jLuqoH5bQ/TCzO5YpPzrJ1tEWpON
         e/LlRw7Z7no40lW00YAQq6t61YaD8io/hEGf4cLSez5ekjm56yedalSPjG+V6cmNuCgF
         IDYR4c6fK5nzeP7QvDSsJk9PYYf09Y/rLFCvF7uglgcdEHIu78ePS6wBVV9Y/cIEr4ax
         O7xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791047455; x=1791652255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sDHX4TKj0c7j+DRK9CBhl/WQkx4j2rho8VDSEeSV3v0=;
        b=cmaCg5NIhZbwQZo5OnHXj2msXlCPIS9tFSVkVjYVEWIdqRrb4ZemIn5EPznJGO99mB
         ep5kJyvipUCTt7KHgN+t9fhwnvUWVi3T7e6hs/eL0WLkt893lScByPkAT5VLewl6av1R
         5bqMWqxYxevIpplmoZDsGWbsaJ4rHWpFsTq8GQvak6joSQupmXOLTTbaUklgmglSAwA7
         ImGPFjUx7SYtuSRXjhQX6+U2inEbeRMd4Bn0Znklqi9ML1mL+gz6+zHWrW+/ONe6KsND
         VDw/Crj7mhNBM8RONUt8uW+5Th3CN6HQNKEqtENIvATIw9x2cf40lC0sBSNofCjtJWhi
         o09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047455; x=1791652255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDHX4TKj0c7j+DRK9CBhl/WQkx4j2rho8VDSEeSV3v0=;
        b=y1nVBtiDQ2RkM9d1SNG7OlGNLoUNwOEIakhIvxr4C4eSTPssRNhA6tH8BUasa4XC10
         QsLbzZrSacxW39eKN7PAIiuYW1GkJzL6mIHkQcXgeCqrMNv1UwcbCoIOSOThxUGS5wEA
         3HTQUC3z4g5rCRln6SZDJqp1odna43O2krW5j+wlOxXtQ8hVKNa5RgD9gLPr1kGa2YcJ
         +ABdFN1+plLyQDZOE9XBnxn1TFh1OJmtrQUiugGWDOy6mcNV0it0KtxIPZJSCbeb6wkH
         V/+kKQb4kLb1Re7JbshtcmZlC5nQxFWf2ZHQbOhY6SuaM2VcL+r/kbQEvW8/PlRGhsqY
         5YLw==
X-Gm-Message-State: AFq9FYKdN1PeP90Wp5qSR7fHbkQ3OoF96nPwuB0+Mqx5EwOcBeH9TOZN
	18lkVUN6I2fMMZojMF9tMaEoZ8+cIrqTZpO47jQysOqDArH8bYpbVlnzkG0qSrQg4OoDKMB0B5n
	0ox+eFR3DuW63psnxOwewftV2BHNDp5xizw==
X-Gm-Gg: AYBFou3dlumbwg+kvaXA/JhnLetn25477OylR12OPjTh3dj7Fhm5dd1znmr5m5HJ/+8
	02i1jZveXjCWzH5ue/luqCeXm7Ggfw2KrjSOwhU0DGv2PTgTPItgnLt3s29qisCkTV4uEJNrvgZ
	BQ3cwRecP5QvEATYRfqRBW1dS8MxTH7whHHQuL7Dn53jG4rF00Kj5TdoZHAl9ZTApbHGWfFtbeL
	8nKd5r37pMUk1emdIuqeen1k+4sHP2THUFpF3q+d5ID8zxZ0MrNwamyFNHJeZhqwHgn8X88uoCm
	LZ94UT1mHdk9vAFS5jzdLxfCSx79SL7hKHc9c8B4sUpVZnyNeQ54XnvEOUacRG8i+kT7iwmIsRG
	c6yCTx6rYWx6CJupWD3JCTZ5Ukzt+Go3zV30762aquTfnfLtAGsqo58zDjBQD2dUQ77gTj6AUks
	vzqUTjrWx1NM4QRUdenvbnsQcHt0fkKTxLwzL93KZ6
X-Received: by 2002:a05:6a00:a0d:b0:87b:ae53:e334 with SMTP id
 d2e1a72fcca58-88af4d362b7mr5808989b3a.24.1791047455005; Sat, 03 Oct 2026
 10:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asDTWsH-RuIJOyne@debian> <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
 <asEa_Lp01DVJ2ThZ@debian>
In-Reply-To: <asEa_Lp01DVJ2ThZ@debian>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 3 Oct 2026 13:10:43 -0400
X-Gm-Features: AclHuK-ZOYy6VgQs6KlnpbrYWkJSI3j8BIPQqcTAAWI-cW75hhNricJAEKVEKxI
Message-ID: <CALnO6CAsd36-XEnRQWNhAsmH7Bg6ZoHv7qb2xQ1m0cW4-Decmw@mail.gmail.com>
Subject: Re: git-visualize(1) plumbing equivalent
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 11:13=E2=80=AFAM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Ben,
>
> > Date: 2026-10-03 09:45:17-0400
> > From: "D. Ben Knoble" <ben.knoble@gmail.com>
> >
> > On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.or=
g> wrote:

[snip]

> > > Having read the documentation for git-bisect(1), visualize reads seve=
ral
> > > environment variables, and thus this code doesn't seem robust.  What
> > > would be the plumbing version of the while-loop condition?
> > >
> > >                 git bisect visualize --oneline \
> > >                 | wc -l \
> > >                 | xargs -I{} test {} -gt 1;
> > >
> > > The goal is to know whether git-bisect(1) has found a commit yet or n=
ot,
> > > to stop looping.
> >
> > I think you are probably looking for the (size of the) set of commits
> > between bisect/bad and all the bisect/good-* refs. So you might need
> > to "git refs list" the good ones, and feed those as negated refs
> > alongside bisect/bad to rev-list?
>
> Yup, this seems to work:
>
> git refs list | grep refs/bisect/ | sed '/good/s/^/^/' | cut -f1 -d' ' | =
xargs git rev-list
>
> >
> > In the general case, that wouldn't account for skipped commits as I
> > understand it, where multiple commits are left at the end of the
> > bisect, but in your script it doesn't look like you skip any.
>
> Hmmmm.  I'm now working on adding the ability to skip commits, so this
> would be a problem.  Do you have any idea on how to deal with that?

Not offhand, sorry :/ I'm not totally sure how bisect represents that state=
.

--=20
D. Ben Knoble
