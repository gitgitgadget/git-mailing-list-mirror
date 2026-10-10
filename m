Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7610F1
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590826; cv=pass; b=FcZa5FksukTXfPdE3joM5/2dORTmbGLyDUqhm08Slm4NqqUrg69XmN7OCbJGiUupJH16/QDbeYGdur4+q5AZ9ZzdTAS0JfpfULE6ftKxL5qB/XFSQ5UO6g6kT/nVfbgBVOL47HLm9Y8uWb1YfA7mPjExx6HyIxCycyEEzBCDYbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590826; c=relaxed/simple;
	bh=l7LNc8gN5VIoApmA/j3eTF31mms7d/h532FW+lxoUN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6KRqZdjnDLaybCKPQjk+v6fWrKP9u4V7yFn0+2lnZmulOfRlTMKu3zPH9zJL06QoWRHOVSWmkTaztsA1tLzjN8iwVgO9sZT+SzNAnl3kqPjzCXcZYOZzfIz+S4NQZ9mYl8D/+F3rBXD5RU3qYld5GYFSN/OTfQyVHWeY8hsWB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBJsAa72; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBJsAa72"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a595487d43so2509931fa.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 17:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791590822; cv=none;
        d=google.com; s=arc-20260327;
        b=g21KvsyBtI3/4KnqqQ8eKh0wEyWwJrxVMfYJ0wxFP53xufNJpSaBLu3ge8UKAbQn/L
         Y2tC/kF7GPW7YvCH17N1bNLytBW2gKWLWwDnKJlrcldV9s6BhT5CSVmvulMcSPezjlMP
         OkGx3FUC77rSc26qqNsuDTxLCQmXzzI2Vrdi4q3s0yZoK+DWa8iy3Nf+GmKUhM2VcfQF
         AaP4nqHwUf6bdIPMtBj2botPOvQLuVL+UW8UiKJrWotBXXGpQRUTE2bQLudk5Kjf7qkj
         83Vm83PVChcVWYdo1yennaKEQZLth061FrLek2pu3XoGVo6dU6R89N0hWXenq33GWBU2
         C8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9rKGuCFlUpf0oMd05nxVJfn/K4I9jm0n/w+WHoh0jX4=;
        fh=DJj88G3niu4nMkK8tZs64niV6eC2qKQO7uThuLrQ00A=;
        b=iIoTGY0PbhVa2WW6d8xmLAI+91/BcJjzoXRUSUYlSMJW/8Dw22So0heUeiiZfLFQQI
         PSQjncAVWJsOldYrS3uslzQeTxIjE2LYfd4Bx4futYNOHR47Ggow9D8tQ3NgDn5ZWwjP
         C+qDQj1v+lpa7e2b8iB6enkHwqTfaZmSRvpv0UQ7SrYeml3ouy+WZJNq4EO6Iw8PzQ4x
         8LkXGk8ecVvPX2tBgmNZ097MuNgXCxguP+EcHQK+EQrtx3ERflk0Tzdg/McGB9qcS9S0
         q57Jj9osRIX0s0gMDM5s5T/4++HMBi+YJIygNqoLV9LMlHwDDrJ4cnwO51D+lQqy+3mN
         l5yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791590822; x=1792195622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9rKGuCFlUpf0oMd05nxVJfn/K4I9jm0n/w+WHoh0jX4=;
        b=BBJsAa728F4OFRUX7mQkdyfBZHsO5+Vncyj/crdHo6fFOAWwmDPDAcXODy+XhyPkn/
         cpJ5LfKAPvzOHQAy/rO7/q25zCO4JYR+XAQLf56HyJc7ohQGZIo/lkVuvBfqfym3cp5U
         twJQAhiOdVszLbYQpAxttMAto1GV7d1qgT0Rfca4s7f0VfdRg/7eysriCUTf6Bi0cbqt
         hCPMMz6r8siXPZ8517SkZ9CZ/n+DDhYcGQ7sBKeZ6ZlDIktOGP22zk2iAOeXlgHjjkny
         6R2wVATmjFfIcBQQm5W2grbyvKwBCs8QcKmshGqQFGjKbygXlvMBrvsfI7wsJxVGkUL/
         Osng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590822; x=1792195622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rKGuCFlUpf0oMd05nxVJfn/K4I9jm0n/w+WHoh0jX4=;
        b=G8iwrszjGn4pcQxtS0PdiY2jNIvikLEsoGOmCqzP3xYaLdDocLzsQliPC00omUWeGO
         Ukg5PPr9+fjxwl7ic+7auOmqKZUa43O6h1X2FFtKM8hQEw2MdmK308vPJ6Ntnw/3Wzjb
         cmjFsqc5WTFrfVa2k/6zl48KS0wL/G9PFBRet9Dxfa4mXbd4v8l59BLcXf5JOUuLayMR
         wWDiNZVNS50DPt406LZfAgf0DWezRhrmLrDVj7+Z0j3QFJ6Qsn4rCncgTDuq5zxWJcK6
         ORTr2Ut19fBjX3GghgWJCzKh5vNeIFDeFYi7YYp5ezyK4nejt2xyrhDlJpR2qO8MIScM
         P9xQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/iGaos2TIHytm5jcsaQAYjzY+2SqFEtc1XLcuwYIz73ipkJNzgBn0xWAs7WBhgp1uZME=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYNp6USn45huMyQIx1QxdKCnzhDtEDBkmLtt3ZVr1vaNUW6GKU
	n/r9VP0r4w9EeBOiF6qjJedDc+ko4kI+4PNr0Q8jMdX8w2DC5x42wFR6Jl7PITLD8l6Fd781X3r
	udZReBz8FbyW9KsUO6p6gQ5huaTuxnHVD1mef
X-Gm-Gg: AYBFou3V+i9Br46cFIFpZHaaeADSQjl5SOdyyVG8DVnuu2MMVhecBQvkGbFdY6yVHoA
	M0L78iE/q9SFaMB40Yb1vzQFDiyVB7wKep4a13UAOfop9ptGqknIex7hldaVuEDU9bdUFaXlECI
	drUBmTHn+eso/IWQaqpPcAXoaDEmCM7/UFoJxnaOTevhzh5531N2c941UTZaZNA5zujkRMxKYBl
	E4EKP2fOC7pWyitaq7dROIH1JE2vYThZAe5IRD6blxtBBQngrQdCpirgXbLSvaBc4aHcWyQa0OR
	5wJhwE5MbTeZ/kTXldUpDVTH1Y3vE2MRSTRe21A6gaZNtKelrQwHfE9HHoGTTvcweDzDZZ4fUBF
	ZVflmPZO+OZMxbKlHTv0uTgke8z/07xh/E3FMHgB0HXdYqvsQBVn0iLBHFZqcNAHeaejsEg==
X-Received: by 2002:a2e:be91:0:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a9c53912a7mr8136361fa.22.1791590822260; Fri, 09 Oct 2026
 17:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
 <xmqqece02no9.fsf@gitster.g> <CAOLa=ZTtLcSPop-A3y-kOv5h-0D-Kq2P+QUpKTEcmU5z77eJYg@mail.gmail.com>
In-Reply-To: <CAOLa=ZTtLcSPop-A3y-kOv5h-0D-Kq2P+QUpKTEcmU5z77eJYg@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Sat, 10 Oct 2026 02:06:50 +0200
X-Gm-Features: AclHuK9aAhUxpzBInLgdjdn5P8nat59pYV3YVQrETI01eJAx3RssffKejLygO3w
Message-ID: <CACQ=SRHe_gKjr+-TSvo7F+L=vXeV0TwFGRAYJ52bf+09adBFOw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> At some point I felt it would've been faster if I used a LLM locally for
the same task and reviewed its code instead.

If writing the patches on your end would be more efficient than
reviewing mine, I'd be more than happy to go with that approach.
Ultimately, my main goal is simply to get both issues resolved, the
one discussed here and the one in the thread you referenced. I don't
want to hold you back.

Thanks,
Maciej

On Fri, Oct 9, 2026 at 11:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> On Thu, Oct 08, 2026 at 11:44:15AM +0200, Maciej Ciemborowicz wrote:
> >>> Changes since v3:
> >>>
> >>> * Rebase onto 6de20f6092 (The 4th batch, 2026-10-06), the master comm=
it
> >>>   used in Junio's report.
> >>> * Preserve the packed preparation error in patch 2 as described above=
.
> >>> * Register t1425 and t1424 in t/meson.build in the commits adding the=
m.
> >>
> >> Please engage with the reviewers. Just posting new versions without
> >> replying to them at all will very likely not get you anywhere. This ki=
nd
> >> of behaviour is nowadays a red flag and often hints at contributors wh=
o
> >> are basically just a meat proxy. And as a consequence, reviewers are
> >> very likely to disengage and stop reviewing your patch series
> >> altogether, which is frustrating to everyone involved.
> >
> > Thanks for bringing this up.
> >
> > A response to reviews on the N-th round must come long before
> > sending the v(N+1) round of patches.  Some contributors send them
> > after v(N+1), or immediately before, but the proper time to respond
> > is soon after receiving the reviews on vN and having had enough time
> > to understand the comments, before starting work on v(N+1).  Only
> > after that work is complete would you send the new patches.  Hence,
> > we expect the time between vN and v(N+1) from real contributors to
> > be measured in days, not hours.  Whenever I see vN responses arrive
> > after or immediately before the v(N+1) patches, or worse, no
> > response at all but just the new patches, it smells fishy.
>
> This is kinda why I stopped reviewing the other patches [1] from the
> author, my reviews were simply met with N+1 version of the series. At
> some point I felt it would've been faster if I used a LLM locally for
> the same task and reviewed its code instead.
>
> [1]: https://lore.kernel.org/git/CACQ=3DSRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2f=
vmEmGJDoB6oTg@mail.gmail.com/
