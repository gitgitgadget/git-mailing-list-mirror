Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94331D5AB6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398374; cv=none; b=aeQh7cqHOfsNTuIfkoOTqQ+t6j9UpW4oc2wsxlYuHyFuBP55e1WrLlaBrrDVu3xiCy4AdW1/DkrQInEt+HvYeWVtN+tE2ihxXKpCGHaZyyGEuKjvCnUMrUiykgzPnak1NZ/0xe2tZkhLN900wYwaQetOg3tLgqScjhpTBIQihPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398374; c=relaxed/simple;
	bh=K/a5CVUc/H6cRfJ0V7CjOwvjXQQm2vtYjCj49TTkskE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3M/aufOeWgc1US9Ro2WncSUSg4KFbve7eeW4bhHAjOS5SvFhjt9tR8o/o2Ny6FTmyU2G/j4EoUF4pLLrmx3I2TEHRPAxhqV13XEjAojdCrZMYPMmVbPewdoSKKQETFlQ17hjfhhw1MYt1S3/ZnK2+t4jBvs1HXLAtJ32TKzG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKFXG8eQ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKFXG8eQ"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cfc8772469so27997525ab.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742398372; x=1743003172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LopH62ZcjhShbMIE2q8Ez9BUbYad7pLWoywn8rIx8mI=;
        b=DKFXG8eQfhmRo8K9Cm/OzFzXa7RrCORBgiD3Pt5meulgF2VgH1E7j+mrlrUmuIz6Xb
         WbfvBJctUEuDcFsqlYnZhMlDONZWHEtO7RBtM0Jx4/8Tongm3HnXbXRXQU1nCyjQVAio
         LQo7TkFdLPlq/drlnaA32EXNq/jPTLY32alclSkHNBbWZXku4NZ2Dvrm06hSdFgcisma
         PCg2haZlaX39xZ7KSPxOcHkHEEkWLfHO9XE5TI7fHWxm08h+ZB6grJVUFQy4DsItpyI4
         Ufu6AE2e4DLDqOqfA11pLeuwXp+tOLCJ+x237X5eGFhbDEZBIAOBhw91x4/rZsOnRxzq
         PpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398372; x=1743003172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LopH62ZcjhShbMIE2q8Ez9BUbYad7pLWoywn8rIx8mI=;
        b=uStnTD0vAnZKDa32wO28yx4zhsXCLDvCYTwQpYmxIswFaSvEYU06D5AzHCh9XU15S0
         Cwn28cVTqOCRrbN5ao/dSrGCR4FNLCBADbOVoy48sG0h6cC9uj8GleP3sZDz48eUra38
         WJeW318fj2Jax86y6DIxVpewGeOKqWZE/FqfLBw5Iu2ELY3eicNKFF9SGXAQQw2FKT0m
         bZO8AF++kgPCc4dmu7NRs2RiLX4SLnoSv5HoiwKvad1USXI0I0KXZbUC8dQlX0sQ1RF9
         8mFMCzYFjY29D5LYvjMuVntgTrcbzxERxIVmCV7dG7BLjVmAEhYyK4OLRfghw0naynPB
         QWtw==
X-Gm-Message-State: AOJu0YxA1MUJ4Kh9VA/6fax3/eUJncU7V1Gb8LmiqDkrQN52F00yx9Dv
	kBXva5HjD1iao+VVgWRghTKQO2zWggGXqZdZvho7UHR2DebuuETB1vmuxaAxRfSDyvIS/csHMSi
	g+rH43bxgR5BC8PE7RiPKjPTXTmY=
X-Gm-Gg: ASbGncv1E4z3GNbKP2+Uy5WIS/2YKVMCUasnM64iJc4kWeyd+gY9YlmPJlv9mKZ2GbT
	AJiDJ6UpGvscfNtMbmDEgXDNO4ausLxdm41X05V3CGgaW5a6800SqMoLxTmGHGVdYTp5eXFkeK6
	K/RmJ4wJB2gU79Tx8FDAkYIj+dagox
X-Google-Smtp-Source: AGHT+IH0Q1CfDD8wTA0Brwgrxq+8KOuB9/V89+YbtzNmgtWO7X+rgDID3aqBf4qpB1nlJz9do+rBWlgF8n6+9Sy06mw=
X-Received: by 2002:a05:6e02:1d01:b0:3d3:dfb6:2203 with SMTP id
 e9e14a558f8ab-3d586bba283mr32716665ab.19.1742398371751; Wed, 19 Mar 2025
 08:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xkdrrhs.fsf@gitster.g> <cover.1742338207.git.me@ttaylorr.com>
In-Reply-To: <cover.1742338207.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 08:31:00 -0700
X-Gm-Features: AQ5f1JrbzlVcKTdF02pynslhgK_YdiwydHk7l0bUM7bASQmNOwDubMLT0FY4pbM
Message-ID: <CABPp-BE6JmiXB+pUL1Z4ewVDbG2RBxCdA2m5-WTYtoKMTtu_Xw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] refspec: treat 'fetch' as a Boolean value
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Igor Todorovski <itodorov@ca.ibm.com>, Bence Ferdinandy <bence@ferdinandy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:50=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here's a small reroll that cleans up some wording in the first patch,
> and drops the accidental inclusion of a stray 'git-diff-pairs' binary
> that was sitting in my working tree at the time of writing the initial
> commit.
>
> Otherwise the series is unchanged, but a range-diff is attached
> nonetheless. Thanks for reviewing :-).
>
> Taylor Blau (4):
>   refspec: treat 'fetch' as a Boolean value
>   refspec: replace `refspec_init()` with fetch/push variants
>   refspec: remove refspec_item_init_or_die()
>   refspec: replace `refspec_item_init()` with fetch/push variants
>
>  builtin/fetch.c    |  2 +-
>  builtin/pull.c     |  3 ++-
>  refspec.c          | 38 +++++++++++++++++++++++++++-----------
>  refspec.h          | 18 +++++++-----------
>  remote.c           |  4 ++--
>  transport-helper.c |  2 +-
>  6 files changed, 40 insertions(+), 27 deletions(-)
>
> Range-diff against v1:
> 1:  7e662acb5a ! 1:  04e1ab8209 refspec: treat 'fetch' as a Boolean value
>     @@ Commit message
>          refspec: treat 'fetch' as a Boolean value
>
>          Since 6d4c057859 (refspec: introduce struct refspec, 2018-05-16)=
, we
>     -    have constants called REFSPEC_FETCH and REFSPEC_PUSH. This misle=
adingly
>     -    suggests that we might introduce other modes in the future.
>     +    have macros called REFSPEC_FETCH and REFSPEC_PUSH. This confusin=
gly
>     +    suggests that we might introduce other modes in the future, whic=
h, while
>     +    possible, is highly unlikely.
>
>          But these values are treated as a Boolean, and stored in a struc=
t field
>          called 'fetch'. So the following:
>     @@ Commit message
>              if (refspec->fetch) { ... }
>
>          are equivalent. Let's avoid renaming the Boolean values "true" a=
nd
>     -    "false" here and remove the two REFSPEC_ constants mentioned abo=
ve.
>     +    "false" here and remove the two REFSPEC_ macros mentioned above.
>
>          Since this value is truly a Boolean and will only ever take on a=
 value
>          of 0 or 1, we can declare it as a single bit unsigned field. In
>     @@ builtin/pull.c: static const char *get_tracking_branch(const char =
*remote, const
>         if (!*spec_src || !strcmp(spec_src, "HEAD"))
>                 spec_src =3D "HEAD";
>
>     - ## git-diff-pairs (new) ##
>     - Binary files /dev/null and git-diff-pairs differ
>     -
>       ## refspec.c ##
>      @@ refspec.c: void refspec_clear(struct refspec *rs)
>       int valid_fetch_refspec(const char *fetch_refspec_str)
> 2:  fd2354dade =3D 2:  c3021b82ce refspec: replace `refspec_init()` with =
fetch/push variants
> 3:  49b470de61 =3D 3:  88f6a91c46 refspec: remove refspec_item_init_or_di=
e()
> 4:  95783265fd =3D 4:  f0c323988f refspec: replace `refspec_item_init()` =
with fetch/push variants
>
> base-commit: c702dd48567cfebca3d4a06b691de97da3f8dc4a
> --
> 2.49.0.3.gbb7a4a684c.dirty

I read through the four patches, and it seems like a straightforward
translation of the previous state to essentially a boolean.  I usually
would have picked an enum based on avoiding passing a 0 or 1 to
functions as you have in the intermediate state, but you didn't stop
at that intermediate state and refactored the function names which
makes the end result pretty nice.  Series looks good to me.
