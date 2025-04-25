Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81072153C7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586904; cv=none; b=JxWuUhCDYzlkJ67hXrbsD/rL9xudwJMGLXwPnYsmSNp+gMeHm8S78u9xVrz87k3ICoj5OajmqtyQffkSEGYL3O6J3XIoQdIGkA5xoowKQ0RXCX9b2p+MDjVNLkdgy6JS+kwxqnvBsj8W2f3lIufmyZif6PL+2Vmq7Bk5SOA7POU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586904; c=relaxed/simple;
	bh=0BjWUP6RJI5ujuQXYPYXkeqxCucE1MA4yYmgxeo1Z94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM9awFbm5gtK67Z38Ih12midXCt1PuxMdkQ1TPrqZSIUa7/jC0bBEutdcwNORtXrzXre58Ddvkf1kXQltZEtEg/JZY5IIVOH3daA0PJQz0PhbSQ+oFXYq1fkCbaEcIZckUi7zvdyM4yo/oxaPlLxwfq0ETOVIflZZzQyMnDohgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR/b4+Cl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR/b4+Cl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bee278c2aso35137151fa.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745586901; x=1746191701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VYiPGsxLN1r6ArRSlALAkeQDt9SAdtFUbsx59h3E0A=;
        b=IR/b4+Cls9PxxITzNe04U95+VjvBhfi0/sFW3OuQwYDs4J49NHl0GyQzc49do/m0mX
         nTP08rJmwC20O8AwO1w+m34cXNdZ2Dhrip0+vbHfHPvZOcdXZOIWXRGtJJ+GrP2XjqtZ
         RcTvKGEWV9nSA0mU01xQD7IWqA4ItSC5PaZ8PnSeMWWpp2HqUazPnxqXGLiajKYDRhR9
         WkwqwBn0y5fyECJcu05jR35gxuXfbKMQO7E23fBKBVMR0pMfNRxhE11k1hVqIexso5t2
         mQJPHKJq0gQyTSslp5jsrwFmkuf1PYvbjLk+0qQWlw1kPnnUZoFYWZj/eZPMRnhXJ3Ab
         2mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745586901; x=1746191701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VYiPGsxLN1r6ArRSlALAkeQDt9SAdtFUbsx59h3E0A=;
        b=o03sTLFotGcvcAefhdLsh7ExAZ/WiCG7FDrmmglw+TiDHzZE6/RbE4I6xKsYjaVQNA
         9IIn7ggU7ptcjomXhUUzClpchTgzdCQiwBF+WFWz6GuRzXpfV0Ui3FyOy4aIiBU7bnfx
         PqZEIvy37tiEISfqI5XpqbkpsFGOKyENsT+GGsVeOoiGncn/cykQnHxc4wTf8y+MkmVb
         UMvoL0MjjfSfFhITrkn5XkTDKUQB+CrQpmHoCYUpLB7nEy+gRpkOedhiAd/rakAqwip+
         YrZToIrWmoIKnFRW8skwGDGV0IXdMmO33pjbqpyq2U1bGW7D0CTs7NUjIY3RWpAKOouz
         x/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZnNgOSozqqdnW/dzzFhdn8FFC+KTsM/dxOY3/U4ng5tvyjQZuJjsezsMngc2pZX91SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5RTAaEH5sC3kqNnt/6mzHJF2217NI5ebvqqNC2LuJsQ6UnzG
	TqO9mUijVB76sSkVr9iGSmztwtUvXsS+2velb0UM5jB/HJcamVfxnUstkjZXuY7r/8XZSoS68nN
	CwzQIljgXNWc66Aah0xdMHtdyTqk=
X-Gm-Gg: ASbGncvrODulf4NSs9LsnJkmAskJIzJSatnMKhfZ7IiNY4MEp0TuzcZkGM4+xylR7QP
	9+CESCOBuIT8vIWL5sHBAfrN00BnulN6sP+yKTPYDSywXLaEgmRDNXONfLCD7LZ8flkfptpcq1f
	W7Q0GAiUXriQmP/Vns9RBJQBU=
X-Google-Smtp-Source: AGHT+IHANtSaev8pepz0iMIg/ZNmdpbPxeQ1BeX2LyEXIWHAwjXbUlFX4Mhv30VLgnhPdyx0jCOgUaweHXP1TN6RGwY=
X-Received: by 2002:a2e:b890:0:b0:30b:e73e:e472 with SMTP id
 38308e7fff4ca-317cde05778mr20068251fa.14.1745586900649; Fri, 25 Apr 2025
 06:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
 <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com> <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
 <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com> <Z9sD63+d+EQKSMXM@nand.local>
 <87cydf541c.fsf@iotcl.com>
In-Reply-To: <87cydf541c.fsf@iotcl.com>
From: Scott Chacon <schacon@gmail.com>
Date: Fri, 25 Apr 2025 09:14:48 -0400
X-Gm-Features: ATxdqUF1oiw5PQMQoEehBwg3VSbQD3NswcZyT5tieuVZ475DvANKkD6m7k9yPM8
Message-ID: <CAP2yMaJZU2nmKezHvePaHQ780SXSvcemoDGL+n65f8yv4N+VJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with tags
To: Toon Claes <toon@iotcl.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>, Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Toon,

So, I got a bit thrown by Junio's message as I'm not sure how to even
approach writing that test case. I had a bit of a time figuring out
the testing structure enough to even write the tests I did.

I updated my series with Taylor's patch and I'll resubmit it. Beyond
that I may need someone else to help me with more complicated testing
needs if more work is to be done.

Thanks,
Scott


On Mon, Apr 14, 2025 at 8:19=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I think we should be testing that all of the refs we expect to have mad=
e
> > it over actually did so. This diff (applied on top of your series) does
> > that:
> >
> > --- 8< ---
> > diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> > index b1276ba295..9b211a626b 100755
> > --- a/t/t5558-clone-bundle-uri.sh
> > +++ b/t/t5558-clone-bundle-uri.sh
> > @@ -128,13 +128,12 @@ test_expect_success 'create bundle with tags' '
> >  test_expect_success 'clone with tags bundle' '
> >       git clone --bundle-uri=3D"clone-from-tags/ALL.bundle" \
> >               clone-from-tags clone-tags-path &&
> > -     git -C clone-tags-path for-each-ref --format=3D"%(refname)" >refs=
 &&
> > -     grep "refs/bundles/tags/" refs >actual &&
> > -     cat >expect <<-\EOF &&
> > -     refs/bundles/tags/A
> > -     refs/bundles/tags/B
> > -     refs/bundles/tags/tag-A
> > -     EOF
> > +
> > +     git -C clone-from-tags for-each-ref --format=3D"%(refname:lstrip=
=3D1)" \
> > +             >expect &&
> > +     git -C clone-tags-path for-each-ref --format=3D"%(refname:lstrip=
=3D2)" \
> > +             refs/bundles >actual &&
> > +
> >       test_cmp expect actual
> >  '
> > --- >8 ---
> >
> > While writing the above, I wasn't quite sure how to follow the test
> > setup. It looks like it creates the following structure:
> >
> >     $ git log --oneline --graph
> >     * d9df450 (HEAD -> base, tag: B) B
> >     * 0ddfaf1 (tag: tag-A, tag: A) A
> >
> > , which we could do with just:
> >
> >     test_commit A &&
> >     test_commit B
> >
> > But even then, I don't think we really need to have more than one tag
> > here to exercise this functionality. So I think it would be fine to
> > simplify the test to just create a single tag, which a simple
> > "test_commit A" should do.
>
> Hi Scott,
>
> Are you planning to pick up this patch series again? I think it would be
> really valuable to get this merged. The patch by Taylor above might be
> worth integrating, other than that I think it should be good to go.
>
> Let me know if I can provide any help.
>
> --
> Toon
