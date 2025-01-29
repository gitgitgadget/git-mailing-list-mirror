Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE457FD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738127721; cv=none; b=IohKyJluw+Nc1xU7sD9TbyI46YFLLymSHyCTkWRs0H0Tl/SuTPqKfKykBVGeNgvmW59pNRwGnXO9+aJnDpB6Pa8TKNB4NhCDCFqDifQhLXXMEmHlIXbXWcBMzbNYh/Brb5QdLtwbsDvrzVi0SlUphJ0VJ6FkjBbZOYlzs4DG1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738127721; c=relaxed/simple;
	bh=FA+ZhyoepP2WVFQVJrOnTepRz8/nlFw0uY+OXJUyXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdZv0IBzLFlgL28neruRF1M7A/ntWlFFNB5lDTWuZHuXDE25qB0i6jlgIZAPXolbV8JJY5musLrOyGrhMV9bKBeW051rJdXyz/sUtY5f/3j7X/qOYIgGW8oIvn/gKIwMQle9kdwwTp8+Hj9W/dK+dwuIAW+UWpi/9S4yCcIG//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCIJgCBb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCIJgCBb"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401b7f7141so5722920e87.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 21:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738127718; x=1738732518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr9HmXO7T4pFjIezHGSrq1c9QeGMzlEsNtfdiixnF6g=;
        b=NCIJgCBbUKee9pSHVhSdyOrQ8HcflvEqvFDO2aOXEa+N+Y6c7IQSbcmJbSDTbyFXhs
         o8HwpwfE47bsiAEtzGcmJsfUI0flLRv6fAI1bIo2P+viUNFTTKleJowi79ENJcxMAkvp
         t1IgP4gscC08CffSAf9lpjPw0LWiGYdyraoT9QwOGCg9NpxMmcZhjCy0l/7oDugz/393
         +2zEASHBq0mfqHT6maE4cJvLhFbHvPK6y8/DV3TmzAuCFqaE3ChArpKQuGBuazdHUWeL
         8RjeAjPPi7daJi/09M6RQRUzN/j5hPuEoFpN4b5bh9lN+UsZ4j1dBxrJabci8gFWG0a/
         b88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738127718; x=1738732518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr9HmXO7T4pFjIezHGSrq1c9QeGMzlEsNtfdiixnF6g=;
        b=PlxlI+cHupwocHu55S4qTdRcRxYZIG3gZYHlrF1Ah8BoVyKm7Fidl/9RXURY3M7BPa
         lN6sTjVuFU3meoY/ONQweyk4iETsCZM+ihBcHVtyeqPgTaHCKoI61Saxdp5VUR3Dtgaz
         JXYqQ8q1ddiSfob0b9ODTIjc6d85SAoSPQKlGosvEu1bx8GHlrTSYQI/sNXJtDA79uhg
         7761f9gtUfViocpfg7+icjUM4BmX4MUgMNcroP/pQ1RpcL96YD+hJtUWv5Ue7rstxxZn
         EGzTXDX7GR0NzRwG/n1TbeK+LgTvpQEA+GQyw+ShPKTFhSpsiDjuvja8cQ/m4/ONQUuT
         leXA==
X-Gm-Message-State: AOJu0YxsO9GCw3l1c+WciLqgPvbBbOAYY5yJrgtXvphQOakevmVkPsee
	ysnkC5zAvVKDMx1jzSGkSPqY/lE5mx69VFYks+m5osUIMio47ouvRAJ/6UcIJoDYMq9GZUlAiKD
	jcTze+v1urUDIHLngb9pJxiM+YUo055uqox8=
X-Gm-Gg: ASbGncu2k8paAWvxgdCwiTO9ThElqIFCgmEYky1V2yOtAD5trhoHAVEk2up5bgCgkKq
	+aGe/hXs3N56yKf9kfkfy4x19npdVGESy13+lp4q4+iZHFhpZvcs5f4doclcDuo71FBgfxOIibF
	0=
X-Google-Smtp-Source: AGHT+IH0uyvXDGSLY91BkRl9SiXly/T2jm+A5HxEA/Rg9oPuuNxkG45Zm/AfhUnV2yWl1J4kU23raVMLpOPvCqIYcFg=
X-Received: by 2002:a05:6512:983:b0:53d:dd02:7cc5 with SMTP id
 2adb3069b0e04-543e4bd634amr402296e87.7.1738127717498; Tue, 28 Jan 2025
 21:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250127103644.36627-2-meetsoni3017@gmail.com> <xmqqa5bctbnx.fsf@gitster.g>
In-Reply-To: <xmqqa5bctbnx.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 29 Jan 2025 10:45:06 +0530
X-Gm-Features: AWEUYZmLlv1fkORwgWpB9ZenZpL0uY8TmSXJAqJm9gO3Kd2GiToRZTjuqpsR9NU
Message-ID: <CAPhwyn34H1NgR5k67MBKEezwTJXtCLeiUhwKQkfVGcmKu7_v5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] refspec: relocate omit_name_by_refspec and related functions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Pavel Rappo <pavel.rappo@gmail.com>, Jeff King <peff@peff.net>, 
	Jacob Keller <jacob.e.keller@intel.com>, Patrick Steinhardt <ps@pks.im>, Matthew Rogers <mattr94@gmail.com>, 
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 at 22:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > Move the functions `omit_name_by_refspec()`, `refspec_match()`, and
> > `match_name_with_pattern()` from `remote.c` to `refspec.c`. These
> > functions focus on refspec matching, so placing them in `refspec.c`
> > aligns with the separation of concerns. Keep refspec-related logic in
> > `refspec.c` and remote-specific logic in `remote.c` for better code
> > organization.
> >
> > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> > ---
> > ...
> > diff --git a/refspec.h b/refspec.h
> > index 69d693c87d..891d50b159 100644
> > --- a/refspec.h
> > +++ b/refspec.h
> > @@ -71,4 +71,17 @@ struct strvec;
> >  void refspec_ref_prefixes(const struct refspec *rs,
> >                         struct strvec *ref_prefixes);
>
> Back when these functions were mere local helper functions in
> remote.c, their name being less descriptive of what they do may have
> been OK (because readers have more context to understand them), but
> when we make it a part of a public API, we should re-evaluate if
> their names are good enough.
>
> > +/*
> > + * Check whether a name matches any negative refspec in rs. Returns 1 =
if the
> > + * name matches at least one negative refspec, and 0 otherwise.
> > + */
> > +int omit_name_by_refspec(const char *name, struct refspec *rs);
>
> Imagine you found this description in the header file and are trying
> to figure out if it helps you writing the feature you are adding to
> Git.  Are the above description and the name of the function useful
> enough to you?
>
> The first question that came to my mind was "what is exactly a 'name'?"
>
> In the context of the original, the caller iterates over a list of
> "struct ref" and feeds the "name" member of the struct, but this
> caller does not even have to know it is getting a part of "struct
> ref"; it only cares about its parameter being a character string.
>
> In that context, is "name" the best identifer you can give to this
> parameter?  At least calling it "refname" might boost the signal the
> name gives to the reader a bit better (and it is in line with how
> refs.h calls these things).
>
> Another thing to consider is if the comment describes the purpose of
> the function well, instead of just rephrasing what its
> implementation does.  What does it mean to return true iff there is
> even one negative refspec that matches?  What is the conceivable use
> a caller would want to use such a function?
>
> As I said, calling it "omit" was probably OK in the context of the
> original file, but it was already sloppy.  This function merely
> provides one bit of information (i.e. "does it match any nagative
> refspec---Yes or No?"), and it is up to its caller how to use that
> piece of information form.
>
> One of its callers, apply_negative_refspecs(), happens to use it to
> filter a list of "struct ref" it received from its caller to drop
> the refs from the list that match any negative refspec, but the
> other existing caller does not even filter or omit anything from a
> collection it has.
>
> My personal preference is to do this kind of change in two separate
> patches:
>
>  (1) as a preliminary clean-up, we rename functions and their
>      parameters in the original place; if needed, add clarifying
>      comments.
>
>  (2) move the resulting functions with the comments to their new
>      home.
>
> If these two step conversions results in
>
> extern int refname_matches_negative_refspec_item
>         (const char *refname, struct refspec *refspec);
>
> I suspect that it is clear enough that there is no need for any
> extra comment to explain what it does.
>
Makes sense. I'll implement this in the upcoming version of this patch.

Since I=E2=80=99ve already prepared a patch for moving the function in the =
current
series, I=E2=80=99ll add a commit to handle the renaming and changing comme=
nts.

> > +/*
> > + * Checks whether a name matches a pattern and optionally generates a =
result.
> > + * Returns 1 if the name matches the pattern, 0 otherwise.
> > + */
> > +int match_name_with_pattern(const char *key, const char *name,
> > +                                const char *value, char **result);
> > +
>
> As this is merely moved from an existing header, I am tempted to say
> I'll leave it as an exercise to the readers to improve this one, as
> improving it is outside the scope of this work.
>
> Some hints for those who want to tackle the clean-up for extra
> points, perhaps after the dust settles from this series.
>
> The "pattern" in the name refers to the src side of a globbing
> refspec and is passed in the parameter "key", so we are calling the
> same thing in three different names, which is already triply bad.
>
> "optionally generates a result" does not convey any meaning outside
> the context of the original, as it does not even talk about what
> computation is creating the result.  It does not even say what
> controls the optionality---without reading the implementation, it is
> likely your readers would assume passing NULL to result is all it
> takes to skip that optional feature, but that is not the case.
>
> If I understand correctly, here is what this one does.
>
>    It takes the source side of a globbing refspec item (e.g.
>    "refs/heads/*" in "refs/heads/*:refs/remotes/origin/*"), a
>    refname that might match the glob pattern, the destination side
>    of the refspec item (e.g. "refs/remotes/origin/*" in the same
>    example), and a pointer that points at a variable to receive the
>    result.  If the source pattern matches the given refname, apply
>    the source-to-destination mapping rule to compute the resulting
>    destination refname and store it in the result.
>
>    The destination side is optional; if you do not need to map the
>    refname to another refname, but are merely interested if the
>    refname matches the glob pattern, you can pass NULL and result
>    location is not touched.
>
>    In either case, returns true iff the source side of the globbing
>    refspec item matches the given refname.
>
> So "name" in the function name should probably become a bit
> narrower, like "refname".  Also the names of its parameters need to
> be better thought out.

I agree that the function and its parameters could be improved for clarity.
Since you mentioned leaving it as an exercise for readers, I=E2=80=99m happ=
y to
take it up and write a follow-up patch to address these issues after
finishing the current series, if that works.
