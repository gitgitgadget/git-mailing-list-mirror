Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA23603DB
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980123; cv=pass; b=TLULrejlGVyC+Qi2POc/bXYa7BjEbHk44cg3R5OBk63XrcXR0Kn4kM8AUF4/iMCVs82z0esnWiOIjWJ9dPTIqqCdhOBmaCIxmU5wbYmiNIiBh/+x6a3IEropC8spo9X0ffrYDvQRCdAkcb/EmPPJlpY1yMHOxG+egMDlUy/Wuws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980123; c=relaxed/simple;
	bh=c3HCsiHhsToW13OmSOENJUnnOmaeqnRmy7L+qT+FFFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2RCkIuUVWYzkWV8j5eG9cpyGbqig9c5wSo2gJ4PTmcXWN59wJ+URqvHdWd/ETGQezxDOPG5n5DhKQzo5fHufYG/1GV4X/2AJ9mIkoMrSFp4/Zn/jDX+wLH0aUB4tEM0UGrK24tT5z6ntGUr4yI6qKFwDZNKEQxyCT2IP5WKz74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlnar9WT; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlnar9WT"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa6cdebc33so4583536e87.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 21:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780980110; cv=none;
        d=google.com; s=arc-20240605;
        b=MgK/ULqN65Ohb3SUY0dclc19kri0/B1qgm3fDOVmaK0v453gd2Kdy6DeN6CTeloIjU
         WRV58lBch8buscK1BJcKUuO9Wvi3b++gnljtyZcUgCABqgklzhAJvVDeD3U02GJyBTuZ
         Z92bGHPPI2E9ht2MbUnJ0wI+Qix8cIFnyYiYGvVFE6Kd3vj2VoYIBWBywFxWs7uQ7ZxC
         AW/+H1P3cC3zpWhVf/98jvImXuH/DMj9s4CpS/EgCl+iFfnkZ3eJfQOIFrS09DjnMGFu
         lYP8ktjTLa+9efs4G2FY89bqTQSq09XpU+uyIuqGxl3ovwoli1fVArpJ+UkUxGfuaWEk
         esOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WBLWb4DeRL+UFib3LUJYlrj21C1jITwARb8KJ28VYbk=;
        fh=npDOvImh7nfybJW6lm+j3eFsSJoNjaAC+zc3YeuW39o=;
        b=cGX70dV9mkHpkkbsiC1BZKTKO+8H4KCVPyrUcyJbMYIZ9f/0/EbPtiHcA0rLm5P3JB
         CeFjDYrnqR/H+EqHcny+3HG/M8XEU6hWKxtFRqnHTpFC4i1YzDbukYgX/OWexuxUC4py
         OH52/76cB+jtzup7IyPJ9XsE1kckZFHgx1tKXwp7wjIhtZOJxIIKdTC6VY/htI7Fci1C
         CmQByPhuvFH+zqTjT3cnfAkcm9/BboLuhyYY8ozsf1rm5JLn0JYqaixqSLz8J/O139tn
         Im4EqqBKyHvLcTjTBxpxJ8NU4ckp27oec2b3pnWHhdSyZJ/qaFG4qjcsrrBuv/XqyZpe
         N5Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780980110; x=1781584910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBLWb4DeRL+UFib3LUJYlrj21C1jITwARb8KJ28VYbk=;
        b=Mlnar9WTvvHhL5YQZeIJg9UbYLusVlk4Kw1T1Ccy21cIdmTyqpL4L6JuX1QcGOhrPK
         i9tJ+rjDEksApq+EPFGwI2BikxOzNF57BSyfduzivarTp2DaaKXLLTpxRXvEYSQwerH1
         e5pym3zqJ01Q+2W2DUUKqFQV71se2mrPQvSTQeHZviRK9kfanjasWcUtEDTU7ycFFdzi
         qllM0562HI+rM75hW6ZCb0U4C2DVXCFpwWg43iLbDOy2qz97pOBeFmOhhqK/NP0gSFyM
         P6bg1oT7ImEss33+Nb/75/Nj7gvDWcA/ha1XE5OT12jX+iYYqq4olGhnZz4KQhqTtsBn
         GI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980110; x=1781584910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBLWb4DeRL+UFib3LUJYlrj21C1jITwARb8KJ28VYbk=;
        b=adAxYuzoOEtVBzIv8HibrQ252l/dZgMvSQrsXNdG7Pi/91FZQJithe41w9R5TjSSvd
         h5HIM2J9oio/elvjyk7M297ZbjEOekywp2S/lgpfNoAgf+DvLccfI8qEb2lDA+5nzzMc
         /a2mXRIUhk4ZgkrRCMkrAxJeSQtY2s9c+4AjpBpcF96p62pM9yZIrC5NEHsVync4KIhF
         A3jyyiOq4Ojlkjo2qeNWMVrvyET88X3NagVNcbgfHD01j8UPdiz4P3grnGP3mm6gWv7P
         tQZr6edGuUpy5Cxyq9Rpqv03RjKZGUY0ZQrq6htRxh7JpUxltqPRK7C4yRVD2DxDllPO
         4lTA==
X-Gm-Message-State: AOJu0YwvCB0Y+B0cFtLQRnc9Zb9gUBjp9kPpC0fMBYva68ktkycFtaM8
	Vp9t/oe1PyelTpzqnm7ASCtam+cNIvXfhSg5lpeWYBdb3GhUM/WMjBg9noT2+wfbXdxh2ZKnfGf
	J71Vjf6xy0+yGkTGIVl6IVigSJ3u1wmk=
X-Gm-Gg: Acq92OGCBDAOgQMnubxgm3RqGgSyzpwYfviK2fGS6gmGpVrnuVduH7YdTTFiqpb/rbt
	cTVNOtTK3yeJiVL+gWGhfSrzUceS3oq8Rmy1tkwHFAeOILMmO9jrL0+jdRvhU+/WFr5Ph0q+vTz
	ckpECPWl2Hv5JcRbkDUa7BEbVVpaEa/chzoDZpzQyuhGeK4zyYjJxDT46KBCjF0/+hn8LVWne+b
	6lsYfaehcAHYcO2goTmZp6v4iz1zr4fcIdlgQUlwz569BIijBfk7uvKXWyYQmMcuVcnlaQlW3GS
	2+L4CvPhFDj9pnuS4o900r0jdlkQ2oT0MbLEmBDy2eSEP+RUyISY5ITh1AUJj1BlBGV7Knh8seJ
	c4OvYmTH5su2cJERALNonl9Oc1mOkjcjC9JOz
X-Received: by 2002:a05:6512:3b07:b0:5ab:bf4a:3637 with SMTP id
 2adb3069b0e04-5abbf4a36dbmr2733920e87.31.1780980109552; Mon, 08 Jun 2026
 21:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com> <aicDOlJdUrgMi3sA@denethor>
In-Reply-To: <aicDOlJdUrgMi3sA@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 10:11:38 +0530
X-Gm-Features: AVVi8CdVOxv2y1dyrPM1UodyP80oYfVZFO_Hgg1DY3CfESJDHBH4x9TJIq_endg
Message-ID: <CA+rGoLdpkuigWXqNSk3bS7-uhtzCizkPx2GGtNaTyy5J1SF7Rg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

> > +     if (format == PATH_FORMAT_UNMODIFIED) {
> > +             strbuf_addstr(buf, path);
> > +             return;
> > +     }
> > +
> > +     if (format == PATH_FORMAT_RELATIVE) {
>
> nit: we could just continue the "else if" chain here instead of
> restarting it.

Ahh, good catch!
True we can.


> > +             strbuf_realpath_forgiving(&canonical_buf, path, 1);
> > +             strbuf_addbuf(buf, &canonical_buf);
>
> Do we need `canonical_buf` here? Can we just add the path to `buf`
> directly?
>

canonical_buf is necessary if I my understanding is correct.
We can't pass buf directly to strbuf_realpath_forgiving() because it
resets its destination buffer before writing.
Since format_path() has append semantics, doing so would clobber any
existing content in buf.
The intermediate canonical_buf is needed to keep that safe.


> > +void format_path(struct strbuf *buf, const char *path,
> > +              const char *prefix, enum path_format format);
> > +
>
> Ok so in this patch we are just adding the new path formatting
> interface and will integrate it in the next one. Overall the direction
> of this patch looks good to me.

Yup, that's correct!


> > and update print_path() to act as a light wrapper around the new shared
> > engine. Resolve user-provided formatting flags directly within rev-parse
> > to pass the final determined path_format to format_path().
>
> So if the format isn't explicitly set by the user via the
> `--path-format` option, the default formatting strategy used depends on
> the path being printed. IOW, there is no consistent default path format
> here.
>

Yes, that's correct.



> > +     struct strbuf sb = STRBUF_INIT;
> > +     enum path_format fmt = (arg_path_format != -1) ? arg_path_format : def_format;
>
> hmmm, so `arg_path_format` specifies what the user-provided format and
> acts as a sentinel to signal there is no value provided and the fallback
> format needs to be used. This feels a tad bit awkward to me.
>
> I wonder if we should introduce a PATH_FORMAT_DEFAULT to the
> `path_format` enum that maps to one of the existing enum values in
> `path.c:format_path()`. Here in `print_path()`, we could then intercept
> a PATH_FORMAT_DEFAULT value and override it to the specified
> `def_format`. I'm not sure if this is ultimately that much better
> though.
>
> -Justin

You're right that the -1 is awkward
it forces arg_path_format to be an int rather than the enum type
itself, which loses type safety.

PATH_FORMAT_DEFAULT is cleaner in that regard, but it pushes the "what
does default mean?" question into format_path()
which currently has no notion of a fallback.
Since the fallback is call-site specific (each path type in rev-parse
has its own default),
I'd rather keep that logic in print_path() where the context lives.

A middle ground would be adding PATH_FORMAT_DEFAULT to the enum but
not handling it in format_path().

---
enum path_format_type format = PATH_FORMAT_DEFAULT;

/* ... */

static void print_path(const char *path, const char *prefix,
                       enum path_format_type format,
                       enum path_format_type def_format)
{
        struct strbuf sb = STRBUF_INIT;
        enum path_format_type fmt =
            (format == PATH_FORMAT_DEFAULT) ? def_format : format;

        format_path(&sb, path, prefix, fmt);
        puts(sb.buf);
        strbuf_release(&sb);
}
---



> > +     format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
>
> For absolute paths, I don't think we actually need the prefix, but
> providing it doesn't probably matter too much either way.
>

Yeah, true. Since the relative had the prefix
I just added the prefix here too.
It is consistent.



> >
> > +test_repo_info_path () {
> > +     field_name=$1
> > +     expect_absolute_eval=$2
> > +     expect_relative=$3
> > +     env_prefix=$4
>
> nit: I was a bit uncertain regarding the purpose of env_prefix here.
> Since the env_prefix is not used by any tests yet, I wonder if it we
> should delay adding it until the next patch. If we want to reduce churn
> though, I think we could also swap the order of patch 3 and 4.
>

Good point
I will actually swap 3 and 4
It is just better tbh.

       (
> > +                     cd test-repo/sub &&
> > +                     expect_absolute=$(eval "$expect_absolute_eval") &&
>
> Can we just compute `expect_absolute` prior to passing it instead of
> using eval here?
>

Yes, I plan to follow Lucas's suggestion from his review.
passing a repo_name parameter and capturing $PWD before the cd to
construct the absolute path at helper-call time.
That avoids eval entirely and also addresses his other concerns about
test isolation. Will fix in v3.

> > +test_expect_success 'setup test repository layout for path fields' '
> > +     git init test-repo &&
> > +     mkdir -p test-repo/sub
> > +'
> > +
> > +test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'
>
> hmmm, do we expect the path suffix to be the same between relative and
> absolute paths for all test cases? If so, we could just have a single
> `expect_path_suffix` argument and let the helper compute the appropriate
> absolute and relative paths internally.
>

Yes it is consistent between absolute and relative.
This is a good suggestion.
Also aligns with what Lucas said.


Thank you,
This will help building v3 much smoother.

Regards,
- K Jayatheerth
