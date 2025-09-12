Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04C1EB5CE
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683557; cv=none; b=lC9ZPhEuGyQZ/iwjeOAxZy6P2hbq7N3qnUeDMn64HD/HVd3Pwa0ICFwoCftlvcsLpTr2MKapKxZM2he7SrNn7GC6oxDwFUHEOB2Uj9Xa1QEPqvpSVO3F+k17//Tpt+5aDXPHlgxZMWKi6f8oqHxtQ14+SGaoaIND0zS4iVwncHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683557; c=relaxed/simple;
	bh=LnCdWuQzzv2S9e8OIoB6735Vpgp5hRGehjdmEFnPQjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Seqj0FE2IdRWp+k9D850SYcoOZ/jGcOe2sFbXePXDzSM5j/ts2GKggWnKRakKFXhFsJ586nDuQlqBH/ladsnzmsY1uEtSsQHty/8wRL+kdya+56QYrGtldg5V5V9mO1oL8k31yWmG2XHxLOIXN/KqjVajrZkBatAukaapro5DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuALyVRz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuALyVRz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso2598318a12.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757683554; x=1758288354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNT5ZJ+sC5ixN+tw36ODpb/ga5CMpgqMbfP7XpCQKcc=;
        b=WuALyVRzbHPAv7yH4CNWQK1OEyAHD4Q/kCaLEnJL3XokoYM2UysA+8ITYrTVYjW7kr
         zRyRpY7AskukOHchX6lyRJm45uhgB0sfC5aEF/TUQPjlZl/Joi6GF0/i7hkA/9/A4Ohy
         GQao5iBwPVEV1SG7MDlT1cmnk8ansCqwGpB/AEHVJCLh0MKqZUq3qPLxalxDbGury4b3
         Ip2eRxjj5KyIEWMQMiJGpMg4KKHorpZl5i4iL5N/G76eW3CVRmppPUrn2fKP+kMozQua
         zC16vXaV35NMqztnCy9fI58j9cC34Q4F2s07HhB9fd6yUTOyWwXceCL2Wr8nSddDRJ6L
         k6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683554; x=1758288354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNT5ZJ+sC5ixN+tw36ODpb/ga5CMpgqMbfP7XpCQKcc=;
        b=gu4KR7byaQsAnugjLNs6GdzcpEJu1op9j0hMgriTeWanmwlQuBwe5sq5/2y8h7eV0A
         J8YZTUs9FTC7ds4BL9McwUcj1l8reVb9hKriquoQ5xI0mtl/d2pwcWEbGK9JGTQ7U5ti
         9lS+j8bmVTe+vjRNTO3HKNt8gDLMFTzHCqR6YC7dtx0uB+34n4c0laqIWxdoDz/+50Fz
         SLD5B78mHIHgWPZPGKs1boHTtupAagx5P6PYMFe4Nttykzgsr51+Heum7lqqHYBbxEjL
         YEuD0RadkuT/PmlNXdHlwP46snqOizHUXRBrZYh202fEiVoL0M195uW++3h7WEqiIqWf
         6pAQ==
X-Gm-Message-State: AOJu0YxqCFI5viz5U4S+aO1PHEXGP3oMujkaVEL7Yudivt3pTdtIzm7M
	V+jznV/SRE1wRk4c5u6drumz1b8O0ElLxdLEqXB/ry7m+GOswe9YNq3t1OBWZL/IyBP/6LZ3MtX
	/mygxTvM/lUBgQF9mA+pmxyjl3u3n1W0=
X-Gm-Gg: ASbGncv6wqf8JC5rUNB799H2osqSEMFL09GY3w40EoVcPrPhXKI+QO3rlIQ2jjPSTeV
	0XrhddTX7he+ObRh7XtaUeZDrfvx3U6waKpu7bSxli4LXzvKCtnZrtLf2p2J4PBzbePVct9yOzH
	frViOv3RfRh6iehyiAOlA/lEi0oZQjqg6/mQ4JZIOlE8SDmODUIGpxKLNi/gCDQ7vKTBe/QsLse
	Fhdo0zhPw==
X-Google-Smtp-Source: AGHT+IFglIUdVTc4fGHbrdUV6rY7ZSH2dcheLiG41XdviJMBpwIdBcvCTh/RN353PAgOKTWKhpVpWXBkLlhPwDlBtNI=
X-Received: by 2002:a05:6402:4309:b0:62d:4988:cc75 with SMTP id
 4fb4d7f45d1cf-62ed828a5a7mr3169566a12.22.1757683554097; Fri, 12 Sep 2025
 06:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <aMJm8rSOeQsO_qTG@pks.im>
In-Reply-To: <aMJm8rSOeQsO_qTG@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 15:25:41 +0200
X-Gm-Features: AS18NWBio6RMKqD3hGiLSYJuf5-IluEPH7-hAN8xT7oEaeAUusOOhK3-u2AJJrw
Message-ID: <CAP8UFD1GHfVvT4c5cFocwP0KJFXOAybfFWXwK1WABy+igE+xOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 10, 2025 at 10:08:39AM +0200, Christian Couder wrote:
> > diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fas=
t-import.adoc
> > index 3144ffcdb6..90f242d058 100644
> > --- a/Documentation/git-fast-import.adoc
> > +++ b/Documentation/git-fast-import.adoc
> > @@ -66,6 +66,11 @@ OPTIONS
> >       remote-helpers that use the `import` capability, as they are
> >       already trusted to run their own code.
> >
> > +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > +     Specify how to handle signed commits.  Behaves in the same way
> > +     as the same option in linkgit:git-fast-export[1], except that
> > +     default is 'verbatim' (instead of 'abort').
>
> We could of course extract the description from git-fast-export(1) and
> move it into a shared file so that we can include it from both commands.
> Not sure whether that's worth it though.

When I add more options, I plan to improve on that doc, but for now I
think it's Ok.

> > +     else
> > +             BUG("parse_one_signature() returned unknown hash algo");
>
> I think we should not label this a bug. It is feasible that we introduce
> a third hash algorithm in the future that we don't know to handle yet,
> but that would not be a programming bug but a normal error. So we should
> probably `die()` instead.

I changed it to die() in V2.

> > @@ -2817,19 +2836,28 @@ static void parse_new_commit(const char *arg)
> >       if (!committer)
> >               die("Expected committer but didn't get one");
> >
> > -     /* Process signatures (up to 2: one "sha1" and one "sha256") */
>
> Aha, this is where the comment comes from! Here it makes sense as we
> have a loop, but it doesn't really feel sensible for the extracted
> function.

Right, I have removed the comment altogether in V2.

> >       while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> > -             struct signature_data sig =3D { NULL, NULL, STRBUF_INIT }=
;
> > -
> > -             parse_one_signature(&sig, v);
> > -
> > -             if (!strcmp(sig.hash_algo, "sha1"))
> > -                     store_signature(&sig_sha1, &sig, "SHA-1");
> > -             else if (!strcmp(sig.hash_algo, "sha256"))
> > -                     store_signature(&sig_sha256, &sig, "SHA-256");
> > -             else
> > -                     BUG("parse_one_signature() returned unknown hash =
algo");
>
> And the call to `BUG()` is preexisting, as well. How about we move the
> extraction of this loop into a separate commit?

There is no extraction of this code anymore in V2.

> > +             struct strbuf data =3D STRBUF_INIT;
> > +             switch (signed_commit_mode) {
> > +             case SIGN_ABORT:
> > +                     die("encountered signed commit; use "
> > +                         "--signed-commits=3D<mode> to handle it");
>
> This message should be marked for translation.

Only 6 out of 131 messages in die() functions are currently marked for
translation. So I thought that it might be better to mark all messages
for translations in a separate series dedicated to that.

Anyway in V2, all the messages in die(), warning() and such introduced
by this series are marked for translation.

> > @@ -3501,6 +3529,9 @@ static int parse_one_option(const char *option)
> >               option_active_branches(option);
> >       } else if (skip_prefix(option, "export-pack-edges=3D", &option)) =
{
> >               option_export_pack_edges(option);
> > +     } else if (skip_prefix(option, "signed-commits=3D", &option)) {
> > +             if (parse_sign_mode(option, &signed_commit_mode))
> > +                     die("unknown --signed-commits mode '%s'", option)=
;
>
> Do we want to use `usagef()` instead?

Ok, it's used in V2.

> > +test_description=3D'git fast-import --signed-commits=3D<mode>'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> There shouldn't be a need to specify the initial branch name. You
> already create the initial commit with `test_commit()`, so the calls to
> git-checkout(1) can instead say `git checkout -b openpgp-signign first`
> because `test_commit()` creates that tag for us.

I copy pasted a lot of test code from t9350, but yeah in V2 I fixed
this and the other issues you mentioned in this new test script.

Thanks.
