Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957041C64
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255703; cv=none; b=O3yU7C6iBLG+Olh174P9BPRqorQfaths6HNyGxGbRgYBfxsSqUzOcUYHCe8JwCGaO0HQNU4O1EJ6G0EVlHTREySkGZYDUHbw8Qno5K34/oWLVfuUFkaONUgBF1Q7BeyOErqs1m13j0G/LjkWIKgQZgKHo43PRNkwauuZoLRwNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255703; c=relaxed/simple;
	bh=hY8GVSYCG8Xb66tNqJacAGSYcYVW88dnOZk72ADdhyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6qUgQBduQJmIam7yrwFOC8pX9zfFvElIhAgBbC9ksSM4h2ifa9hiovXd7enXmZnQPxZpjtS/BIZP/hZ3EDXyc4BPnXgMzQwYLPazP74ve3L2DCU1QeUFU5YStTZDw2J2PT5gitjt9dhGlXa+fh9TAYKZCO59cSjJFgNkiO2GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2dP23Vq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2dP23Vq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acacb8743a7so388755866b.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255700; x=1748860500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLE5ONb08OZY9B5wJVD5oqOg1e4624aVJzu4W3iy754=;
        b=j2dP23Vq0m8RhGYJ/Ged/01QUxaoxQ1pj+yXmJZM8uK9m62C1bN7NquA2n9vnOdN/F
         m7jZDzI4OKaIsUA2hZtIDQMrWNax6EVZLuLeJwEj0k3Hds2NM3rlZXfa0vGAfO/McfC3
         HnLAflkGuhdgQ20NJ45oEuEnWRV8c/QMcXStPvcSFsbPUalJMouILu0fPpIaMy3bsKvX
         XqOEkOvB2RffnjxtxmgbDy/ubHXmw/s/s2EH/a6HwxDx5C5U/gVozooC6kWdYzshXEae
         4pV4y6lSO+kJYCoUeA9xO9vWD1yFH+V7dmdvXlsoKPuUnSZhOtJ/9Yqh29DwfvjUrqi8
         SvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255700; x=1748860500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLE5ONb08OZY9B5wJVD5oqOg1e4624aVJzu4W3iy754=;
        b=GiGwH1pdT/u9/frqbcbhXHOD2DKD1T+rVFemFotBhIKOAj//5zx4SobIxj86XM4+I4
         7RBC+qSdFjpOguzOaSc1h8mflR/LojBY6HpGHggP0drh/YPFo4ZNtkRnX0Re/eR2FHeq
         7IFQAUiy8uov+6u8LkEv4xXsxApPNJXM5D8bInbYz9TxxyaaRZxq5QvnfJYztVzfF0EA
         prS0qcmCZrt9tpiizu/bIz/XyJIw+/dtHrFYe936QYiM/OxB/WdUZRNfEvA2x7DVzbrR
         P8xg/+bzP03AZRlndE5CzMlJGEyMtndaSohWDIdffSqVzWz0zD//bFTWcMUIIt3AVRPz
         JT0Q==
X-Gm-Message-State: AOJu0YyODU6BTlVuxegrnulQ8Jpy3IDixlNIv+9ZejPe47qtlBZhyj9u
	Jp0SbpbLpwy7Qr94o+ax8H0RnHkNi2f5ri+hVx5E5ko861rNn9Whv/E1k2B8gmoMbisKi+mxUtL
	PyWyrFV5sriD6GynR9HJlHZti6oVz49k=
X-Gm-Gg: ASbGncu9GhRBf2m8hT/i1JAryimdONS6wVbZJwIzyOdaKWebTzl6KLf8Rfu+s/MXkd4
	+slMIrO+5K0Acmu4P1I3ZJ2RCSCzbdpteKpnufNbPyxt9Ps9RFCwzwMCv4sxK/jUtzseHbhaSQT
	DCrG2emPVgQNsezq/u12VzI7hG+Fk2r7NT96O7YFZ5g7lAZA==
X-Google-Smtp-Source: AGHT+IH92udMM3WXOJ+iZUiBZHx4yE26a1ENkTBgxm2OWDCUfps+CpXBxnHY17AWC6YnBCn+V/Lf0HZKYvnFCnaJzuM=
X-Received: by 2002:a17:907:3faa:b0:ad2:2e9d:7517 with SMTP id
 a640c23a62f3a-ad859747d18mr811378866b.8.1748255699672; Mon, 26 May 2025
 03:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com> <CABPp-BFrau4F1a_+umYw0qu8HYz3dTPXZ9oiHhawTSZpgAoGLw@mail.gmail.com>
In-Reply-To: <CABPp-BFrau4F1a_+umYw0qu8HYz3dTPXZ9oiHhawTSZpgAoGLw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 May 2025 12:34:48 +0200
X-Gm-Features: AX0GCFseGbDgpL8gV7wgc4eckjNktin3KXTcd4Xnv35xstjbPoroFm0zhUR9lRw
Message-ID: <CAP8UFD2+h6hthbHQP_hmd5xXXCwizvSOd5tgGDHJ=V_eW1sgsw@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:41=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Thu, Apr 24, 2025 at 1:39=E2=80=AFPM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> > signed-commits, 2025-03-10), added support for signed commits.
> >
> > However, when processing signatures `git fast-export` outputs "gpgsig
> > sha1" not just when it encounters an OpenPGP SHA-1 signature, but also
> > when it encounters an SSH or X.509 signature. This is not very
> > informative to say the least, and this might prevent tools that process
> > the output from easily and properly handling signatures.
> >
> > Let's improve on that by reusing the existing code from
> > "gpg-interface.{c,h}" to detect the signature algorithm, and then put
> > the signature algorithm name (like "openpgp", "x509" or "ssh") instead
> > of "sha1" in the output. If we can't detect the signature algorithm we
> > will use "unknown". It might be a signature added by an external tool
> > and we should likely keep it.
> >
> > Similarly on the `git fast-import` side, let's use the existing code
> > from "gpg-interface.{c,h}" to check if a signature algorithm name is
> > valid. In case of an "unknown" signature algorithm name, we will warn
> > but still keep it. Future work might implement several options to let
> > users deal with it in different ways, and might implement checking
> > known signatures too.
>
> The last sentence is somewhat ambiguous about whether it is only about
> the "unknown" case or whether the second half of the sentence was
> switching tracks to discuss something else about the known cases.

Yeah, the second half of the sentence was about switching tracks to
discuss other things we might do in the future.

> Do
> you perhaps mean something like "Future work might implement several
> options to let users deal with an "unknown" signature algorithm, and
> when we have a valid signature algorithm, we may be able to not only
> verify the signature algorithm name but start verifying the signature
> itself to ensure it is valid as well."  ?

Yeah, that was the idea. Thanks for spelling it in a better way than I did.

In v2, I have actually tried an approach based on verifying
signatures, and I'd be happy to know your opinion about the different
approaches.

Thanks!

[...]

> > +Signatures are not yet checked in the current implementation though.
>
> Thanks for calling this out.

[...]

> > @@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
> >                         "encoding %s\n",
> >                         encoding);
> >         if (sig_alg) {
> > -               if (!strcmp(sig_alg, "sha1"))
> > -                       strbuf_addstr(&new_data, "gpgsig ");
> > -               else if (!strcmp(sig_alg, "sha256"))
> > +               if (!strcmp(sig_alg, "sha256"))
> >                         strbuf_addstr(&new_data, "gpgsig-sha256 ");
> > -               else
> > -                       die("Expected gpgsig algorithm sha1 or sha256, =
got %s", sig_alg);
> > +               else if (valid_signature_name(sig_alg))
> > +                       strbuf_addstr(&new_data, "gpgsig ");
> > +               else if (!strcmp(sig_alg, "unknown")) {
> > +                       warning("Unknown gpgsig algorithm name!");
> > +                       strbuf_addstr(&new_data, "gpgsig ");
> > +               } else
> > +                       die("Invalid gpgsig algorithm name, got '%s'", =
sig_alg);
> >                 string_list_split_in_place(&siglines, sig.buf, "\n", -1=
);
> >                 strbuf_add_separated_string_list(&new_data, "\n ", &sig=
lines);
> >                 strbuf_addch(&new_data, '\n');
>
> I'm not very familiar with gpg and other signatures, and was stuck
> trying to parse this logic when a review from Junio came in, and I
> decided to read it since he often "thinks out loud" to see if that'd
> explain it better.  Sadly, didn't help... ;-)  But I'll watch for any
> follow-up response you add over there.

Yeah, if we want to continue in the direction of this patch, let's
discuss it over there.

> > @@ -381,6 +381,62 @@ test_expect_success GPG 'signed-commits=3Dwarn-str=
ip' '
> >
> >  '
> >
> > +test_expect_success GPGSM 'setup x509 signed commit' '
> > +
> > +       git checkout -b x509-signing main &&
> > +       test_config gpg.format x509 &&
> > +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> > +       echo "x509 content" >file_for_x509 &&
> > +       git add file_for_x509 &&
> > +       git commit -S -m "X.509 signed commit" &&
> > +       X509_COMMIT=3D$(git rev-parse --verify HEAD) &&
> > +       git checkout main
> > +
> > +'
> > +
> > +test_expect_success GPGSM 'x509 signature identified' '
> > +
> > +       git fast-export --signed-commits=3Dverbatim --reencode=3Dno x50=
9-signing >output 2>err &&
>
> Is --reencode=3Dno important here or does this work with --reencode=3Dyes
> as well?  (I understand the default being --reencode=3Dabort and fact
> that you are reusing an example that used a specialized encoding means
> you need to specify something, was just curious if this particular
> value was important)
>
> > +       grep "^gpgsig x509" output &&
> > +       test ! -s err &&
> > +       (
> > +               cd new &&
> > +               git fast-import &&
> > +               STRIPPED=3D$(git rev-parse --verify refs/heads/x509-sig=
ning) &&
> > +               test $X509_COMMIT =3D $STRIPPED
>
> Ah, --reencode=3Dno is critical for the test, but only because you are
> trying to ensure you get the same commit back.

Yeah, I think it's useful to check that we can get the same commit back.

> Should there also be a
> test for when something is tweaked, such as the encoding, and whether
> the signature is still found?

[...]

> > +test_expect_success GPGSSH 'ssh signature identified' '
> > +
> > +       git fast-export --signed-commits=3Dverbatim --reencode=3Dno ssh=
-signing >output 2>err &&
>
> Out of curiosity, any particular reason to export the entire history
> instead of just the new commit you just added (though you'd likely
> want --reference-excluded-parents if you did that, which really ought
> to be the default)?  Anyway...

Thanks for your review and all your comments!

As I am not sure which approach is best and I am trying a different
approach in v2, it might not be worth discussing some of the details
of the approach I took in this v1 anymore. So I will skip answering
some of your specific comments unless we decide to go back to that
approach later.
