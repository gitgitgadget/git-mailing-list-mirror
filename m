Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A434EEEA
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290983; cv=pass; b=sg4xvfl8brzIi9TTLGcyOqIdAqcIKZ1u447LiNPjYWIpCwzst5xF7nhSGPeBxpMneEToGCFzrXi2sHkzJfH/K5f9O1EBZ6UJX+yYgjLue7+iQm8FmGL9UzUbPzeuPjOymTJtTnTENFAtds+1yPWrHENmc0+MaRf7qkXv5NV5NUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290983; c=relaxed/simple;
	bh=8Yuq0j8aHpFPMBQuX4yCVpQoo3FvUhDEOy28pwbznVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu5DUYaZANOon8Nsr/SLITYwm/UvJbwKDjrHd8pbNlYACsfOnmYi3FEHYn7vt8qwlYtlCkA0QSR8YDlCbIpFUljb03NKcbAmS9xg1i08Bl7wi4YK0bShSeSGwpqOmWAcmsq9T8QeRZg94yd9EzBDU+Bqd5SLwu0W7ToR2QZqjiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPxI2ZCz; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPxI2ZCz"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44caeb973b3so582959fac.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 22:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787290981; cv=none;
        d=google.com; s=arc-20260327;
        b=mbbYWslcun6iZfgU08hj9v0xJ9UBW6fDkSKEYuQYvYJg7Hk4Dm3uOhwgp0NmQpkmTm
         rk/FVxenI3nEsA4HB1gsvdk+euUudgQc6qaGLgV65oym2EB8EAu2zrpVllZfJCZVq6OU
         +Ardx5lXsaKqAnCfSr/PQM4yRXO2Xo7tD45elYZF3OepVk4IyiKQ4b0xrrF17GGbqAmV
         FSnsn9Emka7+dbIxRbAWxHQaRxEmZX0e6C/eAgK7UrfB8U6faj4n7xfdAz6CWFbYj3Kp
         3jysoCVyYOR5tvzw1nrqUBjo24LYh59UUP5TcC2eeDTz5x3XUsVH5+eN/yMObYA+5507
         9u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0JDE7QlDhg3RduAmr1KSilizsqNHQNMI7tlk3kbE7c=;
        fh=+g4mz2l90uTMqyipMOobR3DEOhZlJjbYYHYPs5pGmXs=;
        b=ixSvryM0s91ibWjMhGDA3Nkte4/0wgM4kLeCiBpJQuN/JAGg+qoTzOXjz95TRyOhAr
         KssNkBwKJ9NhgN76NuWAViWvohcwqK0utloS4CdZg8gSSj8MZREQDOy9GbpBtt7k3GIZ
         5r0Hl8DRBHk25HRr72wWik0Gvwc4lDsSTFPun9nTOxerCDt4YUcVTnRbqDRcgWIYZRCG
         5w7GNxxfDyl/D/mTsxUyfTbhIf+cIDbQbsnVjucaKDUiDdwqp0GUlWiR1832E+85eycm
         TN6efXOT6XE49F8sZTYgEzYhIQWfADfMTtYLhC6qb1hCpaug1ltCXrxeuL0tdIXoc0sF
         jmsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787290981; x=1787895781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C0JDE7QlDhg3RduAmr1KSilizsqNHQNMI7tlk3kbE7c=;
        b=lPxI2ZCz41iVFu19cd3NaRAx68ziBhW+hebVC+VEaVdpVanIRNlpJuxIjfNPPeNK2L
         yG0NtOZeX+JfyGAryPLnLMQ9iGJzr3fcZWRxiWU5CRI8ZCn2TTkASxXw8GYmqRJu7zVA
         lwQjwYe0MUZB5GK7CQWJnbsV0vcm2Tn8ydN8/gtYmWMNjFnmODAwj36w6CG/tpOU1KO9
         wzzuFNnI0IAo2sGWkWSw1yVGYTXg9MeILkzdBepWCIC/ee0GDEspE9XOH8trGd1nhxHK
         aLtgWbzPygZDpnrIZXPFvG65JM6WOq4ExRWivd0I5cOmO96x9Ppk32eitYD+1GpIDvO8
         3t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787290981; x=1787895781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0JDE7QlDhg3RduAmr1KSilizsqNHQNMI7tlk3kbE7c=;
        b=KSb8CUch6VTmJZ6rMukp8CN58vwZKDZ3jr8neDcc6AHiUF5ATArGhDYFmWrWJ5r+wH
         SNvn4Wzopci7exXqOmuooCb9zoPJgsYZ/ThBXK8k/SKEc6If3mfzWfDxhX5QX6f4rgRK
         vy1ennL9XmMJSCk0kcmWyrzjv8YtLzS4x3lt1RUlT4qgfE0Y3fcrkIC0fPQoPLyo8t6E
         TbZ5Q6sDeY+tUrpGw7JFJ8nvKl5F7C50S3Tarjiivncg2FA/t9SJ9uttJS1TNkJKqjce
         9riT1Dd4UW0jtIDpxcN9UnCK3Vg6drFnaxmxE6seFshdyAWjbgnJb38Cm8y43FBb13VB
         yJvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOh4d28j2P1Rir9p+2qrUh2R+MF9nvd+oVZp3elvgSmk1Tbq5kKNmyhv75G1Gb/eGdM5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECm9s9INKwOD2KW+tt6+L5mykN+1qq54JDYVZzKhG2QCX7+Wk
	9TRyom14x1WWrnveon905FAGNyq/MwyfLLtzEkEc4GXserhBUD7yOzCW+3CPesryeS7zQo6j0CF
	mr+5ZG9/5mhECBG2pEY38jf8aFf54r+g=
X-Gm-Gg: AR+sD10+gi4uGNXwK6O3HJLKbWB9qs4cSufYkbCz55HY00XKCyRJq4xr46taT0D9Z47
	F0o0hRsqtEx1J7gw5YodW+NtGeLMvM5CE0igodPWOdWrZuyqP+0W7mpZNg0suVUa1Zrnmv00lko
	ID1OSgPcqC4m9KNrwOzoWUTfcKCzPn7HbtgiWURq8gRVlVDAp5RPw0zTi2lzv4lmQoKWi21qHSr
	EJmiWttUu5rX9QSQwdlGUcZ4XDQdA8rJ2RXmFJchAHTPq8JkWGl7/H9Mmx1XT1zoRPpxQYsUwni
	eylmhzX7EhYpcPPCk+wzO61wnAMYzEjyg+FYXnzAEOELIeIS1wnvOtJhhUCEQidOFFWNgLf3wAQ
	jQq4rhgQ5Go/Ea5ejfwcssBe315dREETx+oJBW8DN3fwYuY9uBlMwtrBA/4jm4P8mu6EYLfGNiQ
	==
X-Received: by 2002:a05:6820:858b:10b0:6a1:4040:97cd with SMTP id
 006d021491bc7-6b1591cf267mr3352480eaf.3.1787290981261; Thu, 20 Aug 2026
 22:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
 <xmqqik5866di.fsf@gitster.g> <aoPtDyISRa0mVXRa@pks.im>
In-Reply-To: <aoPtDyISRa0mVXRa@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 22:42:49 -0700
X-Gm-Features: AcwNN1WNatsel7jWwgm39Bkvbi3Oy4RW-1BDHsFQegSvzm9tpvUXj3DDCKfHXws
Message-ID: <CABPp-BE63m2sB4-18JUiYDK+UXaCq9z_=A8JAutvjn155_HWZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] bundle: get (mostly) rid of `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:26=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Aug 17, 2026 at 09:47:53AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > Refactor "bundle.c" so that we don't depend on `the_repository` anymo=
re.
> > > This conversion is trivial for most of the part, as we already have a
> > > repository available in all calling conexts.
> > >
> > > The only exception is that we use `get_log_output_encoding()`, which
> > > implicitly depends on `the_repository`. Add an `extern` declaration f=
or
> > > this function so that we can drop `USE_THE_REPOSITORY_VARIABLE` and n=
ot
> > > accidentally introduce more uses of `the_repository`.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  bundle.c | 32 +++++++++++++++++++++-----------
> > >  1 file changed, 21 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/bundle.c b/bundle.c
> > > index b64716f252..a9330bf0d3 100644
> > > --- a/bundle.c
> > > +++ b/bundle.c
> > > @@ -1,4 +1,3 @@
> > > -#define USE_THE_REPOSITORY_VARIABLE
> > >  #define DISABLE_SIGN_COMPARE_WARNINGS
> > >
> > >  #include "git-compat-util.h"
> > > @@ -21,6 +20,13 @@
> > >  #include "connected.h"
> > >  #include "write-or-die.h"
> > >
> > > +/*
> > > + * NEEDSWORK: this function implicitly depends on `the_repository` a=
nd is not
> > > + * available because we dropped USE_THE_REPOSITORY_VARIABLE. We can =
remove the
> > > + * declaration once it's accessible via `repo_config_values`.
> > > + */
> > > +extern const char *get_log_output_encoding(void);
> > > +
> >
> > Doesn't this defeat the whole "drop #define USE_THE_REPOSITORY_VARIABLE
> > as a mark that we are done with this file and no longer need to
> > worry about it going forward because we won't be able to compile if
> > somebody adds a new use?" premise?
>
> Yes and no. By removing the define early it allows us to not reintroduce
> new references to `the_repository` by accident, but carve out a single
> exception for one of the functions that still depends on it. The
> alternative would be to not do that, and if so there is no guarantee
> whatsoever that we won't introduce more references to `the_repository`
> in this file.
>
> So I'm still leaning towards keeping this as-is, but I don't feel very
> strongly about this. Let me know in case that argument doesn't sway you
> and I'll adapt.

Would it make more sense to do this the way replay.c does:

#define USE_THE_REPOSITORY_VARIABLE
<a bunch of includes>
/*
 * We technically need USE_THE_REPOSITORY_VARIABLE for <X>, but
 * do not want to use the_repository.
 */
#define the_repository DO_NOT_USE_THE_REPOSITORY


and remove the declaration of get_log_output_encoding() that you
added?  Alternatively, should replay.c be adapted to the way you are
doing it here?
