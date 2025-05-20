Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770C202F7B
	for <git@vger.kernel.org>; Tue, 20 May 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704699; cv=none; b=NyDAyNO12/J6Ku5YJ1UO7cxtuhTOtXJ+vd/E/e2Ez28OvJ0BQPWPBW0lDj3udaLeGd4xTRkaX9oLk4UReChcsqiKAWGPUvoKtSS4uHzHV8TypG4I6st079ThuMcWL1wQBS5dLlNsJ84FQBXvcUwZxG0VlW20MevQNxzdN3kOtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704699; c=relaxed/simple;
	bh=sFuXtIuLeIRfPxJKxfXvnlyvDEqDIpMSmZPFEzVqjIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Inlme/Iu/+tQFgg2Mo+8w2mNLci07FHFDumDJodr/e7i0hFzs03aljYQude0UdRCldj4BKXATbWTBOdKFqIYsLQVxCjS5qB9T197FV1LVEHFwymgrGv76p9nHIScKLbjhWXhuEUocB2NwSNSiO5McurFwoqK5TgHH8pQIIDf1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcuCLHw8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcuCLHw8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47664364628so58929691cf.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747704696; x=1748309496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWQjWgGAq+MWOMkV/FjFniaRdvNU0JgfBYYlOJvjK78=;
        b=jcuCLHw89vX5hnMQEqbASVMdW5Ng98PSZNQxsJcDhPiTlTAVGZ7k/8qMtQ4/FZpaxk
         ajxE5VCgu1DKCnCFTdmetjmusVYuAVBHJOODwkUIAs0jsl4Skcm8Qny3nW0cCfaQLITM
         IWjKO9C9OVv3JyTV6RwRAFWPtzjItSXlzBu9eB25y/fabQl0rSBo5r8h3J3ZW00MLWJx
         DjWZwVDg/TKMG9gMd2T41aIgHIt1hDHQQNx26bfrNqM3trPltDr8LtgerwLbnc64RQnf
         wzKpJ2Mks4dI3+YVjBgm1Xcs3tZKpFjENl3r7ZhdYmtmrQeO84jBVMnebaa2m8b1bXSk
         NGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747704696; x=1748309496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWQjWgGAq+MWOMkV/FjFniaRdvNU0JgfBYYlOJvjK78=;
        b=C8skBdHdT4d2Crh7qw7UGAvJpItxpY7LpwS5ydwMTgXQ2+q8vlUDL2RqPPUC/pGoyV
         YPSy6EKlVUXZi7rutW7jexbH3qfjNJzlHsIQ/FmVIJClcHNx96VcSVR0e06vhGD4Cz6Z
         SOuZ3TFMZ6wGWuyksnmSJLEJBb2gqQb9Rwi0KUFBIEoW3wh0rTUUhn+tQSQeHR5Ja0BF
         Ngeny5oPAmXEFZpeg/TYFnRisqlcisl8kBNpHfovNgRUhQulh0QerzcF5GknlqnbvvqQ
         L/b7sqKWOrodWyBPZURkxkELO3fahkwcLLyOrVIsG/zVmVIy0DzSdXqzAJpEh+BhkUcb
         0Hag==
X-Gm-Message-State: AOJu0YyxAmsZ36LQKpXXJFODKCi5lAvri1seC+Yp2vUk/EMgXxQ8YH7n
	X0pkrXYxkw4eO4kK4NQgsXNC/gi6s2oOKO4BmHQuqvkzncjaiStIhePLXwOM//ceVNxTcqk1+AU
	gaG2MhOcJvONBoXMfjKlvoebjtiY3/so=
X-Gm-Gg: ASbGnctiHDim5eD/wdO3x+y2cssDQO/pH9fMuzKF+iQBTwlyC6dy3d92BFGMy6wynal
	p9vlT6CpLRcSn+LXmLecDY7N3vtidTrph4HX5B5ujTpYGFrogmSKMBlZPxjqe5uWM0V+Z4yUsfc
	TyrTfyss3g9Jmr7Bqtiyj/16HhkiLz/q0xhWzNII2bV6S3C66tGqcNaNyt6Yo//KGa
X-Google-Smtp-Source: AGHT+IFLKqv4i2hIUT1VLBAnhFjq6weHOEcfMVmO0xJ5EbAAW06bDX0BgtVukZGtl9cG7snhqBJCPO7A4pwHjZ4+I2w=
X-Received: by 2002:a05:622a:22a9:b0:471:fef5:ee84 with SMTP id
 d75a77b69052e-494ae462300mr236779721cf.7.1747704696178; Mon, 19 May 2025
 18:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
 <20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com> <xmqqwmacobf0.fsf@gitster.g>
In-Reply-To: <xmqqwmacobf0.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 20 May 2025 07:01:24 +0530
X-Gm-Features: AX0GCFu7ZrnM_bdWjBavEAnzbps4FHQbPLtoOOd27Yj79Gk8n28OW9p6szCFYqw
Message-ID: <CA+rGoLdbmRkk5b3LJ+n3HG6OJv7oURJaLuWs3tTymDfsbBgwjA@mail.gmail.com>
Subject: Re: [PATCH v5] submodule: prevent overwriting .gitmodules entry on
 path reuse
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, mlell08@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > When a submodule is added, Git writes submodule.<name>.active =3D true
> > to the repository configuration to mark it as active. This happens even
> > when the submodule path already matches a pattern in submodule.active.
> > This results in redundant configuration entries that are unnecessary
> > and clutter the config, especially when pattern-based activation is use=
d.
> >
> > Avoid writing the submodule.<name>.active entry if the path is already
> > covered by a pattern in submodule.active.
>
> This explains why the part of the change that deals the .active bit
> makes sense.
>

Hmm, I look at it this way,
active and path problem are not different,
It's just that this has to follow t7413
submodule active too.
Therefore the submodule.<name>.active =3D true
logic exists
 > >Avoid writing the submodule.<name>.active entry if the path is already
 > >covered by a pattern in submodule.active.
I think this order makes sense to me, but I could change if you want me to.

The path is the core issue and the active is just like a neat wrapper
of following all the
test cases in my opinion.

> But now do we drop the other fix from the patch, namely "ouch, we
> are adding submodule at 'foo/' but the name 'foo' is taken by a
> different submodule that used to live there and moved elsewhere", or
> have you forgotten to describe that fix in the proposed log message?
>
> Stepping back a bit, perhaps this patch addresses two independent
> issues, both of which can trigger with"submodule add"?  If so, would
> it make sense to have it in two separate patches?
>

This would be the case if I wrote a separate helper function I guess
but the core issue still lies at the if else block
And the active part is just written to mark the submodule.<name>.active =3D=
 true
So I think these are a part of the same problem.

> > +test_expect_success 'submodule add fails when name is reused' '
> > +     git init test-submodule &&
> > +     (
> > +             cd test-submodule &&
> > +             git commit --allow-empty -m "initial commit" &&
> > +
> > +             git init ../child-origin &&
> > +             git -C ../child-origin commit --allow-empty -m "initial c=
ommit" &&
> > +
> > +             git submodule add ../child-origin child &&
> > +             git commit -m "Add submodule child" &&
> > +
> > +             git mv child child_old &&
> > +             git commit -m "Move child to child_old" &&
> > +
> > +             # Create another submodule repo
> > +             git init ../child2-origin &&
> > +             git -C ../child2-origin commit --allow-empty -m "initial =
commit" &&
> > +
> > +             test_must_fail git submodule add ../child2-origin child
> > +     )
> > +'
>
> The test seems to be about "the other issue".  Shouldn't we also
> have a test about "we no longer add redundant configuration entries"?
>

Actually t7413 has a detailed coverage of the _active_ logic.
I actually didn't consider submodule.<name>.active =3D true
but looking what failed in 7413 made me realise we have to
solve the core issue and then
submodule.<name>.active =3D true it too.
Therefore I didn't add extra test case too.

> Thanks.

I'm open to a review from your side on this
I may have missed some logic here.

Thank you,

-Jayatheerth
