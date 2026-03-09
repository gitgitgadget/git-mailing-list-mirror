Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC175A96
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017823; cv=pass; b=OmHPNUcslgTNQYUwNCyHVUXVjJwaHjaj4XnnQtxzZMUbibQ0YTTsulAmwy6cFEMEPzsY8T1i/mQb0KxunLz3anUfGq8G5AWGo7Bt01QprmJXrZVlLzj1NeKYMHUYEdCHa/O9Vb0iwQ5tgPMPCZ/kTuxS0S46VI7xBmLatTYljLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017823; c=relaxed/simple;
	bh=gPQLQecXhkQ6+HPwd9+8iAccujt+B0PfuCBzFAdnRek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlwZDbhkFbV3aJNpW5L/wCh+WpJ7USYPrtOrHB2YNXFLmGKz/EBKktjrS2bzSSztJ2SyP5eJRgZjbp9JyDiqEkSva5hyLmhyf4PKBuq5OzxcSQ8mlihKRkw8bXoOB8Eyo6ZrXIZ9PwZ5UWQYbFI+cDxi1BEQncmrD/CvPp491uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntVogsVs; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntVogsVs"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffe9a5b052so1420097137.0
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 17:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773017821; cv=none;
        d=google.com; s=arc-20240605;
        b=EjOhTjjboorP6vNiuY1FDSvMBgVE8puEYxwueYirOVuX7fvL6Zp7tCNHnzIxn1hM4N
         ZmuzuJ1f4Fi4NUYTvxnJK4A0/hTX/Al7h3oFQvwF1qzPuK1e8wEDWd0HGwQdTzZuyjTo
         n9dlvQyNxih/lT7FWVEzegF9ghmBOhvL6wEaw3cqpd6oQ26ltJ7jNzDJECjDijXvV9hV
         kWGb3FJhv4yk/FhhSPhL8pAAVN5W10yDwS1dQbqwcz1hvuLXDLN5kMU3oRMgS6p8sr+D
         QlYx5L/US8X9GsgDHKIGqiNgzJ8f+MQexWp+t4hyYsjHxZOeY7lLb1zwaFbHqr4amEku
         LZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2r5vz9N2nu2YOQMUTCPbM2t/Sub++RFWohVCvcnQBQs=;
        fh=l9w/CK7gb8pPgxsIND20cpOgEiDBd+vkaJjFjHCeOFg=;
        b=HGS/AiRaTEe/+G6a5zYLrFdl/dBewVzGlMyVbVZ+qcL2XqoyGNQYzt5mNf8sBHVKv3
         uwe81FChL3wc8Po2+1zfYruiWRzfY31kISNyqd7bF4zOi8cyZz6f/+0Du8jU7FjA5tNk
         fEHzV/49PMXgkTOWve2l17iCCcxpr7TR6Fqkl7R7cXy8DHSm2cSfAh50KCN8TDoYxTV0
         skSIgscXEhwWBkvt/rNNWwBc5mVMeq0Jz+bH6bu5YGPpCT+iz7Te+xIgl+4LfYH5wU1i
         zhw5Lcc3yvuGLjhC4l1KUZTPirsBRMuMOmyd1L5SI/q0h9OvRTXgQWdG1alcLekmsrvJ
         4LMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017821; x=1773622621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r5vz9N2nu2YOQMUTCPbM2t/Sub++RFWohVCvcnQBQs=;
        b=ntVogsVsN5mfe3NZGMuzuV4E1Q5TjzUkKTMcXIhk7Ew1hZuxd6w0KQaMsD36Iv+cJ4
         oImdhyP44ivOC8dugCRIwEbJPheAMlVzh4Kj/4onx+NCdNEeL1C5Zjk1hbohY1adjUWi
         MpzLN/E2mxSRYZ9PgrrqoHYksmNRNrKG4uHE5+2GQ21GEnQAkdvY19Ygc3XuN17m90Ys
         YEBuEiqyMU63xUIOSl9wCGb67MIbEdnuLPFwGi0nckp2hqtcwVwWjp/8HVad5xDddL2i
         Ccj4BTYMUmLO5VMJzxJ5pXbDw2F2VWPXxR+CG+t1U7dmcWSy0GTBBhm4A2xewAXHUQhF
         D6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017821; x=1773622621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2r5vz9N2nu2YOQMUTCPbM2t/Sub++RFWohVCvcnQBQs=;
        b=reHe5/OKV5jzmsSSfQDXR7gKoIuIp94NynI2Xs5URaifh6WiRHTMo/IqXlhEm2g3xZ
         Zb6RhNU9EGMNzSkQtkdA8JH7RsN7EjOZ4I73m0C7CKPkLP9GW2ddENtR9UEFXwm1KZJf
         fGGvrAUQmol1RAe6wt3Kw4v/uvGrQE7BNlaAIyMIJK1xz8RZtUzfrnJUG+2ZDFl3zRHi
         ublDZ38wjXYccJr3pGk5SQ50bl/9ZZpgwSVzmnfEQZYfViOElw/xzJtFP/S2L6tLXk2F
         8IwM7MVjLISmV87+rCo+gW/Kg9UCg5yQ0Y6cs1DhOOsuAgWzJzqk2wXT6fAgix9vKaEa
         QRRg==
X-Gm-Message-State: AOJu0Yy0O8GQoy5rq7etJ1ZbU3pocfTLTKLIXQu2JAobPcX1aT9mFn1f
	gbEoCOdbqtFwEtcRg6aYKa0cvn4qIVJqlGmreV8h2c+FTPKyDrx0nz0Kd6qhoR+FZCT6hZdG90z
	CNrDcjE0a3k8U8wfqoFKyHhuWEnWt3rI=
X-Gm-Gg: ATEYQzyHrwvWbmG+OVyn+SwVhKCm9mPyTyUpDdGOz59STpxEzFlXFYelp/WF9U7S5tz
	5gfb7Fio1TpD9xV4pQxlE+1mNFB06WhM3Pr0g3cgjGJ8rIanF159jIrJU9orJrQpOhlxaQ8O4wH
	cz/TpGrfI7UwIAayhjfW812+fro7kXHqDLtHv5b2NU1cNcoIqLeLeibZOWVv3FHysNq9yvl6xf0
	GuHZrVSTW7B1eRZYIZom1uDZbv0HxAznR4c5raqP0z2w+XEKBrgwfP5CR5Oglbfus+xI9Hid4yL
	hrBBbMSrubd/mzl6Qrj68FWpZyI7Byu22rEF3SM=
X-Received: by 2002:a05:6102:c86:b0:5ff:a606:3cfc with SMTP id
 ada2fe7eead31-5ffe61248dfmr4441345137.21.1773017820989; Sun, 08 Mar 2026
 17:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260305223248.170785-3-usmanakinyemi202@gmail.com> <xmqq4imsv13x.fsf@gitster.g>
In-Reply-To: <xmqq4imsv13x.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 9 Mar 2026 06:26:49 +0530
X-Gm-Features: AaiRm516gxaVEQ-J5XQTWBQOj_mo8-gauBKvpkoTGm6-JbzczSOsutiL8rC8QmE
Message-ID: <CAPSxiM_KVU7rE49=omWUwaYS-u_J6eQPDgTRjPop1gj6BM1qKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] push: support pushing to a remote group
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> The basic idea to use "remote" (the default remote cannot be multiple)
> vs "remote_group" (the command line gave which remotes to talk with)
> sounds good.
>
> But I started wondering what happens when the command line gave a
> single remote to talk with.  Probably we want a code that does
>
>         if (remote_group has only one remote)
>                 remote =3D take the sole remote from the remote_group;
Make sense.
>
> here before we continue.  Or the other way around and we handle the
> "default remote cannot be multiple" case as a special case, e.g.
>
>         if (remote) {
>                 create remote_group with a single member "remote";
>                 remote =3D NULL;
>         }
>
> and then we do not have to do ...
>
> > +     /*
> > +      * set_refspecs and mirror detection must not use `remote`
> > +      * when it may be NULL (group path). For the single-remote case,
> > +      * handle them here. For the group case they are handled
> > +      * per-remote inside the loop below.
> > +      */
>
> ... "handle them here because single-remote is special" at all, no?
>
> I would prefer to avoid "X must be done for each remote in the
> remote-group, but Y can be done only once", as future developers
> will get it wrong when they add their own Z and consider which side
> Z falls into.  The code structure that removes special case would
> help by making sure that a singleton case is special only because
> the loop over remote_group runs once, and otherwise there is nothing
> special goes on.

Yeah, that is a good design and makes sense. Thanks.

Also, in the cover letter, I asked some questions. I think you might
have missed it.

Quoting here again:
"
  - push.default =3D simple interacts poorly with group pushes when the
    current branch has no upstream set, since setup_default_push_refspecs()
    will die on the first remote that is not the upstream. Users should
    use push.default =3D current or explicit refspecs for group pushes.
    It is worth discussing whether the group push path should automatically
    imply push.default =3D current, or whether a clear error message
    directing the user to configure this would be sufficient.

  - force-with-lease semantics across a group push are currently
    unmodified =E2=80=94 the same CAS constraints are forwarded to every re=
mote
    in the group. Whether this is the right behaviour or whether
    per-remote lease tracking is needed is an open question.
"

I will want feedback on this also.

Thanks
