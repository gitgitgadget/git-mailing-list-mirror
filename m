Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4178F58
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967043; cv=none; b=lkGB/8zFMbrAXTFfoc6KKzuCGWd/X0+fOeT87H4PXGlAF+GGegutyLRnMqvLs9YS8uTwnB+PEWrataETYhn+C70CkK4TX8RJxFQWXjJKXUdmiUU4kwQ/VyIHrC45kZnBzn5RwYObouCZLLLg+NWskPHsrNT9T1yLjYb5bRaYDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967043; c=relaxed/simple;
	bh=m6WcQ3mracH0cM5y6zZ4XO9d0rzqejXwDz9R9Xg8ARY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE4NWfHFdPc/6I43eWj3avHLxuVUZpanx90HcY1pddSqhTqIXx3I+3NW9qsugVTO6CH6WjnGIL+U2L4siU86Pg1gkT0FArXnm3iRPGHKJQghjEBkYSOZ0CGLsxjPOEAlbJPXLZUq38KtJdCB2wNjMNpnDG03miy10/imtzhKh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFdDc0eT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFdDc0eT"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f8d1cbcdso25049761fa.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755967039; x=1756571839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faYPX/eZRphQOG+pLl+lsWePX0TIEjsK1DEb4Mv/MgM=;
        b=gFdDc0eTTHjvpq0q6G3a9e+Pwk06+GKdue1uE5zjRuDGj7+BuvLPaZavxtxgFtuR1s
         n8cx1YN9B8nnhGHDuNlbNtccxg/Ynv4XjSIFRPIk6pHXORktiBc3wMHr5ovTPVVkGGhI
         J8CVqKs1womiDPFYCTighzT1n1bLlQ7t3SyZCsaNwt7kRedmAlyZf5qYrj26stZlXetf
         9YW+im8gANaJNXLHPDW8UA3LfGdebZO/EkgXfpxX9GFQWEOWSNbCXqXB8nTwygvEIpVW
         E0IJrSRUqW4JZdJDBZu9RNPkfF5Jn6gKG9Vhnx97LH3WUDmTrMSJbZlQPfZNhpa4VgW2
         WfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755967039; x=1756571839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faYPX/eZRphQOG+pLl+lsWePX0TIEjsK1DEb4Mv/MgM=;
        b=XcH5CHD63yiADKRSCnK4Dkpt8lnN4VPJJ9wX5lI9i11dvJz94ApHSN2ZyDv7r7gUPN
         GZhbceuqPyG5/rxAte4qIjMU4GBC5VeuuwGci3gmmVt18AHx4XRMn4j1mzeZ4wd+GA+P
         zm69khcb8/C1hu+6YU9uaj/qWm0mkcvbhDfC8PDHJRx3REP9vRqe5n9YZWrCSMPc2G5n
         MjfOuReBfL4kAr0Fv7J2Oicd7OStkDr7ue5tHwbV26horo3lZyK99cwMHzrUDpzD9DpS
         fjGpPisIJ4uqckg8dkDjO7xYne12nvgqMQ1OYgKBg8ku/sJE8vbZMjaZwiLKSJjM4RMF
         Aftw==
X-Forwarded-Encrypted: i=1; AJvYcCWBLelR3ASfi5IC4mc4t/h4B5eEw4B/mkedNFwC9C+hCsz0RWVW3fyj7xmq0zUa5Xj6a08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoOxCJ/XZiUkcjBwGLLUZdGwNNQakkOPk7V8/oznJTYa2Aw3Y
	5z1s6Hvakwect8odKu4GvgGYOpjpyh0SXqT7qL80x51Mz2mBBCfQDIBHZ0gY0UuL8ZjmvqXv1ca
	zhnsDHMWjMChWNmMiMqPIKT931elEwO8=
X-Gm-Gg: ASbGncvVsKlay5VYTmlOVYNHY2Nln08HLn59GtGNdTPmtFPsXYIDT0S8meNsfeVWuRc
	E9incZ9Im48Y2e5lAaf+cPdRTAVLwXuNjH+d7GUU+61/PW6rSmdPSyRC97RiGjJIChvo++bCp7D
	AuYw3qceMc4Y78n8Zc09PfNn/lRL/5kLtBGTnoBQU78BaCiM6qQlQ4qcqL5B9xkFFIqr4Zjcr8d
	j3U+nw1
X-Google-Smtp-Source: AGHT+IFh6QNJ1N9GPdd64CTrYakZ0uxD5R8WslnEK/IIJU9WxBZfEOpOkjZ6HFuOgAUTgCkIJ80xFiZj9gYbdIctsiE=
X-Received: by 2002:a05:651c:3059:b0:32b:2e45:c403 with SMTP id
 38308e7fff4ca-33650fe7527mr17890841fa.39.1755967039271; Sat, 23 Aug 2025
 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <xmqqo6s6uia4.fsf@gitster.g>
In-Reply-To: <xmqqo6s6uia4.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 23 Aug 2025 10:37:08 -0600
X-Gm-Features: Ac12FXzgKhgQsjvurf0YQ-4ZKyH38RxtOx8m0V0mVN3hsPhYYpiepEh9URAUrRY
Message-ID: <CAH=ZcbDuE9AJBWRvx65hfJwwbJ4qJoY7cZo0KcVrR+fWavnnFw@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> > index e69de29bb2d1..8b137891791f 100644
> > --- a/rust/xdiff/src/lib.rs
> > +++ b/rust/xdiff/src/lib.rs
> > @@ -0,0 +1 @@
> > +
>
> This triggers an "new blank line at EOF" whitespace error while
> applying.  Intended?

"new blank line at EOF" is intentional, but it is showing up in the
wrong place in this patch series. Cargo format automatically creates a
blank line for empty files. These warnings should have shown up on the
"xdiff: introduce rust" commit. I will fix this.
