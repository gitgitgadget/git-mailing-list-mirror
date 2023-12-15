Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84C30CF2
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncs4reFY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e465506c0bso3412997b3.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 03:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639007; x=1703243807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDOaxjfiou4hjgiX0Kg7DNODmB5E/aBZykS79SCNKYs=;
        b=Ncs4reFYUSNPy+vmozM+CJk8mCh5H6Y4TjaheeOOfF2AGpNo9JSmGABovBNElVBQMc
         IoZCJjX7xpUrdCoAp62LB/h4ZDnEpV4q6Q1HKH01CM3O2HVQKLIEtCmMTRZzBzw/QHbZ
         7YZtX2DpgL5rL5hp1mViH8kliFHsVJJ0T5i7X0L5gRaxsvs2fm8ZYS4oov+UxdFbb5lS
         uNFGZCLg0U4QNGV7vfJ4Ie77hH9kklnap0PN4JpcSvJp9gi/SYLPr24JquKh4gj/zsAZ
         AUUrOdF3j4sljRpMnrhqADILPebOl0dQZk/b+GXOjkYrcKUon5tQBvT8dJngFPi92j3U
         uEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639007; x=1703243807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDOaxjfiou4hjgiX0Kg7DNODmB5E/aBZykS79SCNKYs=;
        b=lnHVi7nEqDTOQ+VYAFxEFfmqq3jYJaqDbxgfKi/9ruXJsbSNYCeo8OyefuC5oTL/cc
         4gJBkLXZCq64z7vbKLfCK84tNwPWPaaxT6P8OpzBfnuvjArbh5Y5DLixX37ik8bxldnT
         mvY+M3ck+A2T+a931rpeWbOOkYk3OHC/QKbkwftLH4TMUfUuyQnBRto6F2iEuavbpjJn
         IC5fRhygaOEhPmPkqejrS/16bp0FGxPgTDwfsnsv4K4F+z6L3kY8DGVUN7lfJUC8ASBN
         Uc4izUO9B+Rz7Wn8up9nQ4l0vip4R61WfEr6PR/9Q5a+OMAaAUsElbF8gSe6g2wxgDwQ
         4gDg==
X-Gm-Message-State: AOJu0YyKD1ER9h3TSu7I4LhkMif7cllkkGbhDrwKs1rRwlTiI+DFnf0y
	P7tXkBZWzADtxuR0rjsyqeVx+04Wb21wwJ9NKVA=
X-Google-Smtp-Source: AGHT+IEE5HwFmu9ule4zQGlUBlcX8EDgbXQ1Qj8maV6voo3UVeD73QL50ZZmzlZ798fZRuKu7b6A3YdaQOm4k662G+Q=
X-Received: by 2002:a0d:cccc:0:b0:5d3:a63b:88f7 with SMTP id
 o195-20020a0dcccc000000b005d3a63b88f7mr7727925ywd.25.1702639007213; Fri, 15
 Dec 2023 03:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702556642.git.zhiyou.jx@alibaba-inc.com> <210191917bcfa9293622908c291652059576f3e5.1702556642.git.zhiyou.jx@alibaba-inc.com>
 <ZXwi2MA-KUxszfGj@tanuki>
In-Reply-To: <ZXwi2MA-KUxszfGj@tanuki>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Fri, 15 Dec 2023 19:16:36 +0800
Message-ID: <CANYiYbGaJjnuVx7wJshgqiwvpGTmdq2JiOe4S_ph1bgiZ7XTJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t5574: test porcelain output of atomic fetch
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:56=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Dec 14, 2023 at 08:33:11PM +0800, Jiang Xin wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> [snip]
> > @@ -91,36 +85,61 @@ test_expect_success 'fetch porcelain output' '
> >       git checkout force-updated &&
> >       git reset --hard HEAD~ &&
> >       test_commit --no-tag force-update-new &&
> > -     FORCE_UPDATED_NEW=3D$(git rev-parse HEAD) &&
> > -
> > -     cat >expect <<-EOF &&
> > -     - $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
> > -     - $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
> > -       $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
> > -     ! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updat=
ed
> > -     * $ZERO_OID $MAIN_OLD refs/unforced/new-branch
> > -       $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
> > -     + $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
> > -     * $ZERO_OID $MAIN_OLD refs/forced/new-branch
> > -       $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
> > -     + $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force=
-updated
> > -     * $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
> > -     EOF
> > -
> > -     # Execute a dry-run fetch first. We do this to assert that the dr=
y-run
> > -     # and non-dry-run fetches produces the same output. Execution of =
the
> > -     # fetch is expected to fail as we have a rejected reference updat=
e.
> > -     test_must_fail git -C porcelain fetch \
> > -             --porcelain --dry-run --prune origin $refspecs >actual &&
> > -     test_cmp expect actual &&
> > -
> > -     # And now we perform a non-dry-run fetch.
> > -     test_must_fail git -C porcelain fetch \
> > -             --porcelain --prune origin $refspecs >actual 2>stderr &&
> > -     test_cmp expect actual &&
> > -     test_must_be_empty stderr
> > +     FORCE_UPDATED_NEW=3D$(git rev-parse HEAD)
> >  '
> >
> > +for opt in off on
> > +do
> > +     case $opt in
> > +     on)
> > +             opt=3D--atomic
> > +             ;;
> > +     off)
> > +             opt=3D
> > +             ;;
> > +     esac
>
> Nit: you could also do `for opt in "--atomic" ""` directly to get rid of
> this case statement. Not sure whether this is worth a reroll though,
> probably not.

Yes, your code is much simpler.
