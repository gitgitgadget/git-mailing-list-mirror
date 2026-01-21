Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F642773D3
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029978; cv=pass; b=rmuLEiUbS++xQEiDxkWrb4b5jrVueBqK5UTT7hkAeBHQt4GjeipyTr2X8boiPEXWtmPVWfvnRJrJ9UVTXlza77nE4G5mSi8UYKFYlfQcGxfMhljzpOErSFLI4DJnDT5c/eei1Vn8PgZ+wGlAp1HZUq5mPIcMn+X9B40oDv/aekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029978; c=relaxed/simple;
	bh=oXL68u0aNYK1bsdR5kyym10HJKLOHiZcNcshTNYEFJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcGOGJjGIJQwyN4AB1pAjYgN1P+DoUstHu1LsMho0XuFsWRi+1iAGlUjVBg32E8oQeIGTNvvqNjmtYBDN+jfwlOxJ9n9FMOSaBf/7ezg6KZyIZUxQB7mPzMFPM26PS9UdYipVXm8Gzrgzax2JeGaCgomZU80qHRJDsrBLLHxCOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGNtzzNv; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGNtzzNv"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-382f9211cbfso2997741fa.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029973; cv=none;
        d=google.com; s=arc-20240605;
        b=MDDDvgMqrcbf69AX4DtmtyHVzfBzdzrrWAN6/ouoNlxUspFkIYLnclyrCxEAQuPIlj
         DEisTDlD6RAzzWCNXCJKgSRzFDFQcSi/xsM9b1jb4nBKIn5SP+qpNTSVHXkLKcpsb41r
         7JnMBI0kwLq55ROMIhH/aR4Ld6FBmpvWCSOqUawwMpXmiw3SdeMFMDL81wdBwHHIHMit
         b1rnbgPEDiMjmvTLxB/JeMIpfGj7baskmHS5dOjaMKEKbJjrjxq77kPXuLH02GOKfWQb
         V2GYrGmMhmxUdrJe5hzN8Pr8HbOoGjLhnbImd7TqKYkKc+BecP5AFdkr6sODwojmONV7
         YqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7DYO/xJwehjYi6D+ODajDOKLhgV4hGbP3Uz8em4TLU=;
        fh=fd9zhwv8qfOZ3DMDdOATw0Q76ZdXViGqXnH6hM56Uqo=;
        b=IGuEpqZWvWf4qzIUPhaqYKi38TOj+khg6s6bvzZwD6LRkwmospxtx/HXgtsbomnhun
         tQaYRr5+tGs+TcFjmk2lfu4qFtNqy8CJhuSMGy3woVWglVjXrzPeFFoPsIcM8AM9QnvT
         GIayAI/6kAfXxJhb04v1A6GrromH6gIljiFbSbH+dZLG0KKuOf/ff0cNN0oY8Jr6F0j1
         UGH0gGVZP4e9rOCT6aB4ibRWQh5C8V6BL4ekgG3OAkWhBZZMgdXwx4P5Ga9q2rnAeJuk
         IK+b4vNSM8CqQG+UxfQQscWDx9e3pESgkdALjx3OSltxQDnaGJKiC1c2NV8VT+8G9A94
         V+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769029973; x=1769634773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7DYO/xJwehjYi6D+ODajDOKLhgV4hGbP3Uz8em4TLU=;
        b=HGNtzzNvb1uOf57ewiYSbQUocnhrD3mC0mtNYapf80WiiMM88LOCSFg1J7/h+b/+ry
         y9oBnsolBVNxN2sl8lxA3whSX+7sigaz0u0FFgoXcmsgewYPd9KhPR80lc1pIs0kWw42
         vadqQLUkwxxGVC4pKsVCE/zdhxPBsWbaTuF5Gjh5I4X8Mq4D6lCY/IqmKCCMoCxarVF8
         sSft+Rfd9pvYifnEGtDdObtdNDZQV6RGW4BUPVYUzk0ZpP9g2DbsfqYLx+DX8QQfe3dm
         AlovjiwCFInIFjDHmHHjh7B/p/xbYutVRBbNw9+BuOoabfnSvagevcbw2qmiomEkSwbP
         /ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029973; x=1769634773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7DYO/xJwehjYi6D+ODajDOKLhgV4hGbP3Uz8em4TLU=;
        b=n1pK7Ljiw47Xvn8srjyuBpoT/521sr+NvQJl03bmDKYlffYI6OjK1bYc8Ld2cC17LB
         dTc20CCZbNsBg8W/hDXZFxkOIIaVw6l0k1WsvTXvce7PgjqXlpxRs/tHyhhGKQHA/06r
         Xn3FuC5CcrDpJMo4GgTEZrJPvk9zNdlzv/2f8J2ILoGaJVKDz+WScRE2Gufb2vxpioNC
         K0eMBZt+F8WWRc0bVpgy0lFbUeE78/3CIBJVafF3MDGI3FgKHzKVDkF3DqShuvz1sWhi
         RYfIjCFxooljIONWsbGCeVYN/6ZeoyOw8D84oStRMvltdWWYn1jZENZ3fw15Hg6YxB7S
         3X9g==
X-Forwarded-Encrypted: i=1; AJvYcCW07xsFEjwLqlkSBCkoscnmj8x2datbyWkaWrIFxch9rl9pJ1IMtAEZBuIZrb+uG5aRxIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2knCGCwEnMEMFDW/q7eYihk320K9iuvSTdAX2RaY9O3lhUJjU
	xehiAUSZQdpUiprIKWxZKy6SnRHyIFhlAFFhD4pAnS991amxUZNIyNr5FXlqsHZWOu9t6OHrkm+
	BPNPm7Bv8EAgm4ziczbtTukPc+O15FCw=
X-Gm-Gg: AZuq6aLlr6lH0Jhq2Db5LJ6IzG2lJEjGbCwvTl3d/LbsrxKi2ap5ALegnIglwjc4jlg
	PDtMSUEE0R+OXbgXGjnFqJelIH0GoVyOXU5z6BJh/4KQncfIQ/8NkCJ3e6BMJC/4mu9Zcy3yIuG
	89S1f3CD6E4QAD9CaDPLB5fD3zfUK6VNrCtAPyxDoGj91FMXR8erV0w41qqwdr2NxKRxK9C9JAu
	/y7Kmw/7HOhhKN2lw9l9RdZZFtonE6r1jZOwDQbAdFrkxocnT8m8EOdm8MBknMrkn5Nxd0hzek6
	PpPHvA==
X-Received: by 2002:a05:651c:4cb:b0:383:723:3c50 with SMTP id
 38308e7fff4ca-383866d040dmr57038271fa.14.1769029972325; Wed, 21 Jan 2026
 13:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <53e4840c1653772379dc8d5c883b34717b81ac43.1767379944.git.gitgitgadget@gmail.com>
 <208da094-8a5d-4f16-b42b-5d5204576b5f@gmail.com>
In-Reply-To: <208da094-8a5d-4f16-b42b-5d5204576b5f@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 21 Jan 2026 14:12:40 -0700
X-Gm-Features: AZwV_Qjk5YjPBF9L_uoSkMrup3gKswB3xBW-Fx80h5QpE-8iFrpxFySWX3xOItc
Message-ID: <CAH=ZcbCbz6MB9-9Ehskk2+27GMXXewmAzRcGyN_bBi8s5Ksxjg@mail.gmail.com>
Subject: Re: [PATCH 03/10] xdiff: don't waste time guessing the number of lines
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:02=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > All lines must be read anyway, so classify them after they're read in.
> > Also move the memset() into xdl_init_classifier().
>
> So instead of looping over the input lines one and a bit times (the bit
> being from xdl_guess_lines) we now loop over them twice as we split them
> first and then classify them in a separate loop. It does save some work
> not to call xdl_guess_lines but it is unclear if that offsets
> classifying them in a separate loop.
>
> > +     for (size_t i =3D 0; i < xe->xdf1.nrec; i++) {
> > +             xrecord_t *rec =3D &xe->xdf1.recs[i];
> > +             xdl_classify_record(1, &cf, rec);
>
> We seem to have lost the error handling if xdl_classify_record() fails.

The error handling was not "lost" it was deliberately removed. The
only way in which xdl_classify_record() could fail is by a failed
memory allocation. On the Rust side this would result in a panic
(panic means something different in Rust vs C) in which case C could
not possibly recover. Also for operations like Vec.push() in Rust it's
assumed that memory management functions will never fail and if they
do they crash the program with no chance of recovery (unless you
account for panic unwinding which is really ugly). It seems a lot of
arguments about ivec and my xdiff cleanups are "We don't do things
this way in Git/C" I'm aware of many of these arguments and I'm trying
to address them with a more specific answer of "Yes, but that's not
how things are done in Rust and all of this is to prepare the code for
conversion to Rust and some things shouldn't, or even, cannot be done
the C way in Rust."
