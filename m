Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D01476CD4
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551357; cv=pass; b=bR8M6SHcpL71mQ5B+NCIpoO69ze9YnPRPPZnv+CrvZh3w6x0gLbq/4vplypFp4ognGadkVdLk2zM5XnFyVHUzumSfpQrw4YdZ3f82h34KBQT8GnsL+yUbGQ41zxSYspO7WMsKmic0NaiQ+eMDf6IMo4orHSvlkJuWS2Q0Jxl+WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551357; c=relaxed/simple;
	bh=HHOVg5muZu8CJxw5gsigy7gVjB5Y/glBUNvD8LiqB00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr3bvdSPFLRwogvZ6A/ofVp24zdDUfAf1HCp4yfbgcXPVA/7srT1802jnwFjt4jX/buDujGlgx6vwOhL1H/e4rJIdNMaAl6IfJfTwEVh60syoqK/II5tjzKMww4Eai89m90uFhlJBcDh/zKZGDm8Cz+VdXIl/dCMRddREXIB7Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM722oeu; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM722oeu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso796897a12.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786551355; cv=none;
        d=google.com; s=arc-20260327;
        b=fa/90R3sXZSl6HWC1G66oXDh5y0hFto+tPMS8ScSm2uPdyxh6XwSlJloFgn1GTZ7Y8
         HhPSIKwp2+0Bp8/87qhSYDLLZh8M9hopBRoeVdAIST9/8TL/KL4VTmWl07egyNRkUbxw
         FCkjDOH/Rn6v0QQ6ZpwWfgW/vcV81PPej4OyXcyy1tJabwhDXUJjXYFwu0+J7IVLGeog
         ptuUo0s1uvwCxCcsJ8WGf9dmRiQupvmNOS8kREnth5/zqQUbp1DSq3Ztsxyy9I8jcZHk
         vjol2g6D7YS2xWROrNKWWRQJ1KrDGkx281dwo+PIako17CNSCx4t83K1ao/K5DjlYWr6
         n21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NhE4qvvaUjxK6rEqzUqV0HhMBcS19v102AqqJhvZvrY=;
        fh=xgj+vSGq/gGUery/oIClRsu4cMrai2x0EL1nksSCsY4=;
        b=DCQgKWKafIYZtGB+RhEOAM43Ouw28i31nY7R5VYJTMTsqR3DMQzu5XdH/JgjvMAVZt
         eWpWfs9QiHdDhD34dJnoCUjH5ZHuqgdQVeojxrIqvrVkpdHXDSTN+K+8cP3cMOXM/kWn
         o2N+oOCXSAR5qVess0NtHgOhs7fqaWmA270tdQp445gtEKhcatPlUfIrxX5Gmm65uUxa
         AeAVgA6omishj2mZlZjbTEiS/G7T2o1VSEi2whRPwVKplzNwo0AWGT/iPxKMmL/GRyQd
         pr5Orhp+g+7xGe9Gy5p9v9bWci8aeey6zCXPIUm4ZiPGRpTZ9a3NAJOztRi+mH9Bg2Rn
         TcFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786551355; x=1787156155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhE4qvvaUjxK6rEqzUqV0HhMBcS19v102AqqJhvZvrY=;
        b=BM722oeuvQM70gES7ouEKAYIkwpK00HnAO1VkyRSCshqg6jCgB7RUjataP892T5ati
         Xvv45Le+CKRcJ3QPKkLbA75zYbxdCkr3VFQxC+ABx8ezWjKvUrTnOWpcLSYkg7PqKp+D
         ppbRk5nvuiZj+STo03bjnOPZ508Z4+Ki+oXE/0qCIv+dBDx0/tUMHIiERVux/Z+GZ/mr
         RgwQX7qeJSk6x4wcX58lMPKeRYwU6+Uw7TJk+RgDctslUIrlKOECR2yf6F+EDuIEas/h
         1Cqks5XxbEtBDQWamPK7cDwSCnOTfNHWVnhVSM7nPB4Tul8mEgHRNkIOUOLkciPLiDJv
         8oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551355; x=1787156155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhE4qvvaUjxK6rEqzUqV0HhMBcS19v102AqqJhvZvrY=;
        b=qK//NRw7t9xQ+BfD7u6N503p/N0BLZHT8P69OQhZUsdqqdymjwPL/LlEaPwBKjkC7j
         S0BgcUZ19RzDtfP1IjYWKwyE4EQ4ZFok7StWBtik1s2Uk/Q9NHQ1lOgv2L6g1OrQjt1B
         LHIIfjuQr9VW2giQuPvKO9LyUS60lULS1X6VTXqP6oKsen7cEPgpCq5QFYMpUNpom5v0
         XCBRuhWxOy28TecV0RUZlxY+9Uq3J0Diqw098kd9ZSCKoupwlUacI+agMztlLeiIZRpL
         +NDMnK7DJOn9xWnFMDAu1Bp3tu2YiCodMynGt07zqkY+1nlTdc38HSF66TRghjHxgysf
         QVYg==
X-Gm-Message-State: AOJu0Yz2OkDxUnlYJAvGBrAP4MhAnhl0QsnHezWJSkhx0yNf/ihCEYeg
	VdFXWgraZt9T4FmTvAsOi73G/AVuRso2w/lzN5TDEYqHSMbQPvq+d982n1pvn7lwkDvhd67tCmx
	48FjANnEBOLQn4M/wlahaGS7CupM+1xo=
X-Gm-Gg: AR+sD13BlF8FN0j+TeAtx+jTqxCtj8UiZw+rLrF7SbZilIPUCYYbjc/hY82AQ592e3k
	9MP7+hGKyTSVEYz4KzGX7uaNPVVKTTOkZLTlnYj/91TZxUL8l7bv5RomjSNm06XGyRA6NuDvN9E
	Bpnfuic/PgsZnqK18MDqB2RLASjl5CiFSPNO5FL/ZOu4u6r5AmsyYQhd1CNWWYIUteds3SmQLUG
	5zhSDQuQOyzHHTtI6MXumr2X/3dYLhZtGEvizNkpHtycstNcAmL2WBx1gb4ZhI7cbmFmJZ+Lr/3
	YlUsOB/Il/eA5Ii5ERf0SZxjYR6ldrd/ITIbMWSJSj8fJK4RvdjxMIjGmtQL0VJDHa2/cL+WQB8
	hIvyp4pqOEYsR/hQhlao9TPFAlecpgCO3h623EKKB4OZhlDagZVOi1clPB0J9ahgiUDEGzMEy
X-Received: by 2002:a05:6a21:e097:b0:3c3:7762:5d5f with SMTP id
 adf61e73a8af0-3cc3f719511mr6457029637.19.1786551354467; Wed, 12 Aug 2026
 09:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811121446.2080190-1-christian.couder@gmail.com> <xmqqcxvo1n8w.fsf@gitster.g>
In-Reply-To: <xmqqcxvo1n8w.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 18:15:42 +0200
X-Gm-Features: AUfX_mxdch_s2K4RLaWG61MPbc9VWobmPsmllVP2G4a1yh7x4u4zsY6ZNzK3T2Y
Message-ID: <CAP8UFD1BoXTo-bNyaQeWeC1QhrpdBAOOW4BwXCi9XYMr7aRuZw@mail.gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a value
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

[...]

> >   $ git --shallow-file
> >   Segmentation fault (core dumped)
> > ...
> > diff --git a/git.c b/git.c
> > index e5f1811b6b..96df15b5cd 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int=
 *argc, int *envchanged)
> >                       if (envchanged)
> >                               *envchanged =3D 1;
> >               } else if (!strcmp(cmd, "--shallow-file")) {
> > -                     (*argv)++;
> > -                     (*argc)--;
> > -                     setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], =
1);
> > +                     if (*argc < 2) {
> > +                             fprintf(stderr, _("no file given for '%s'=
 option\n" ), "--shallow-file");
> > +                             usage(git_usage_string);
> > +                     }
> > +                     setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[1], =
1);
> >                       if (envchanged)
> >                               *envchanged =3D 1;
> > +                     (*argv)++;
> > +                     (*argc)--;
>
> It is curious that the fix needs to be so big, when the only change
> necessary, as far as I can tell from your problem description, is to
> insert 4 line "if (... not enough args ...) { ... barf and die ...}"
> block and without anything else.  I think the culprit is this "while
> at it" ...
>
> > While at it, let's also set the environment variable before advancing
> > past the option, instead of advancing first and using `(*argv)[0]`, so
> > that this option looks like the other ones.
>
> ... that made the patch more confusing to read than otherwise.

Sorry but the goal was to use similar code as other options that can
be passed a value like "--git-dir", "--namespace", "--work-tree", and
so on.

> But without reading the preimage of the patch, the result is just as
> understandable ;-)  Let's take the patch as-is.
>
> > +test_expect_success 'git --shallow-file without a value' '
> > +     test_must_fail git --shallow-file >actual 2>actual.err &&
> > +     test_line_count =3D 0 actual &&
> > +     test_grep "no file given for " actual.err &&
> > +     test_grep "usage" actual.err
> > +'
>
> Do we have similar "oops, you were supposed to give me a value" test
> for other things like "--config-env=3D", "-C", etc.?

In "t/t1300-config.sh" there is:

test_expect_success 'git --config-env with missing value' '
        test_must_fail env ENVVAR=3Dvalue git --config-env 2>error &&
        test_grep "no config key given for --config-env" error &&
        test_must_fail env ENVVAR=3Dvalue git --config-env config
core.name 2>error &&
        test_grep "invalid config format: config" error
'

I couldn't find anything else.

> Just being
> curious, because (1) if there are, this addition belongs there, not
> here,

I am not sure the `git --shallow-file` test belongs to "t/t1300-config.sh".

Maybe the new test for --shallow-file with no value should be at the
same place as other tests for --shallow-file, unfortunately there are
no such tests. It looks like this is an undocumented and internal only
option which is only tested indirectly in the following files:

- t5311-pack-bitmaps-shallow.sh
- t5537-fetch-shallow.sh
- t5538-push-shallow.sh
- t5539-fetch-http-shallow.sh
- t5542-push-http-shallow.sh
- t5614-clone-submodules-shallow.sh

> and (2) if there aren't, this addition may not be needed, and
> (3) if there aren't or if the existing coverage is incomplete,
> perhaps we should give a more complete coverage while at it.
>
> With (3), I mean something along the lines of ...
>
>         for opt in -C -c --git-dir --work-tree --namespace --config-env
>         do
>                 test_expect_success "git $opt without a value" '
>                         test_must_fail git $opt >actual 2>error &&
>                         test_line_count 0 actual &&
>                         test_grep usage error
>                 '
>         done
>
> I do not mean to say that (3) is my favorite among these three,
> though.

I am fine with (2) or (3), but they don't seem much better to me than
the test already in this patch.

Thanks.
