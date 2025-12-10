Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFC2C3278
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396555; cv=none; b=HZSVipHfJMQbAUGKLlqebHVskFicMuheB25eLUuMfb/GJO485ymxPL4Q3yYcP1M0/pIuf0+T05gso6oPqHycHPMfm+D65T9v3ZRXOoZJrETRhVJBf4vdCCc53MqobBK0/LK2fdl2kTupIjJ5T66vp8jDM1yDWhV6j4Ol08coDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396555; c=relaxed/simple;
	bh=dHobGEkIcJq5aO6xzBF5GFTHPdyLuLG0YKtRqCnBAPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6kCWe6f13hKa4+GSO/LwtZxC8YUDonq6EQZu5htdUqbCmgH4EDnOi4Lco/tmH1VBClu4DEUw/MJZyvU9l+NzhHLW4YWJRTiwYK+moVPn+Ep36SCZ4snEseZksw8dmr5qkTJdInJlZvm8mfREHN8sxQSFjEigjhTXY9r2Q8MzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmjHXEgL; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmjHXEgL"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc44ff62so222710a34.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765396553; x=1766001353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnN4FOjZ3VG7nzZVXqjlEM9GN6Wit40O1UfRzxR2V5Q=;
        b=HmjHXEgLS+QYulHVwItg+D47w9NVhBJOh8Rnoz+ytEoDr/XzJHYQRg6Kfom1GJJlHa
         NX1/XJxqDBsnCxsMpZC+ScAjNahZlkgHwS2GMrqI7/EeAc/wTqZOmz5TvVZ5zIBkL1aD
         m1JPxibmRAxDadxK5qRGl7KCP/Ckv8buburDxJZ8ryg0+Q73VGs8uy9473MJJg03kmHz
         IQnrAlXCXWdEca9nmIyTn4aXFlx9qaUSY/ad0O+/jzAZ4o5f+bs81kj6t1QG8++CDsI3
         WSp//AzzRA6rdEfZNLOETHN5HsL9imXJf18wW/MgdTvIVYplxmwzqpBmwL8lKK2BJmPV
         i37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396553; x=1766001353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnN4FOjZ3VG7nzZVXqjlEM9GN6Wit40O1UfRzxR2V5Q=;
        b=RxgO7+y+zi+w+nAGd5+EZ2kWzaPj7rYRB8xxy2vE+cX92BpC6d23HFG0QCW56KPZgl
         UewcLGzKRskf8u5cw51wyYy+kY11TxhosYPOM8/jB/S3bXIecY6i8LvqUl5wtFGUVgQy
         O5qBVBkXaMonnGyO8QETgI4N6evQyneGee126IdDvz6WyTzbX3e7wAXzOgZLQPshzAvO
         fp2Y+hW2PAEQBOqvyrTiIgCEGtgmZO8MCEUJ0Ggwazq1Ux/G3qQixZMEv5pfWd4EVFli
         fs/rz0FxK9aoY/39swLLyY5syQNZSsZa4NkLj6VG5vYfbqBcFcBKCN0JE8SCvW68xygM
         y/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXGv9W/T2ojTojOtgh4/291PM0DMpqWh+NNsOAWxmpwRxDYmt47lji2vgHy8pyPi76IRVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0YcIW3dQYwgzWILhOatOzULhmPyNq8371otMZ3U0xrcXJUkt
	FHhAP6KPIo5Bnjc5gICB6eWvkA9/UEz85/NSfIxSN6yTkohqPVc+SXqkjFXbogVKE0kEXL7GFek
	o7opQZvyQctlNWSqqo5iVDnZQCeZxFBA=
X-Gm-Gg: ASbGncuXtgS1uWVlLC5bBBT41SKopLOL6t5quDVHdTgompm1v8NmhOIdB4cjZd/Ut9l
	TFvDjHYLn29m+nqvJSf/dFzhqDutTxYdN52GwMW4IDc2I/UyOdLGxAYIEHy/Nu8hhJDssIhqW/f
	lDpdqfeQTbVA2ruJSNebXQsj9h/RkafV0y/0hfBO2HNNxgpRfCT8SZq8w44MayuriKsoi3aITwf
	WnPwSFQkrmo0/Uzfzcc9uZDMvUFY4QN2zkGj+RXZsZ3QFhCL77grCjwABcnBSGhssUjLcW/SZKE
	wwUorkM1oyNbj/xyAsMog72+jT9h
X-Google-Smtp-Source: AGHT+IFzGxD0cnQo3UjNolAelac9XgCLqpWQH7CSa5RBCRbg1JnmPg/Hv+ufGB6muQzp5FCfXJLl47y6ujmRajW8VMA=
X-Received: by 2002:a05:6820:809:b0:65b:2944:7319 with SMTP id
 006d021491bc7-65b2ac6b812mr2209737eaf.12.1765396553098; Wed, 10 Dec 2025
 11:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <CANiSa6hwaQ2zLsvw=uiJNgfVYAVp2RyQtgVeTevZ5NO5p2Xmgg@mail.gmail.com>
 <CABPp-BEs_Q5eGYugogm=Msu-acS3uTj5Oo0xTUnWay9OXBKqXg@mail.gmail.com> <CANiSa6gxA5SVBALvkYzpMJUrHTW8OJ+fFLkAmM53fJ1GdbUsbQ@mail.gmail.com>
In-Reply-To: <CANiSa6gxA5SVBALvkYzpMJUrHTW8OJ+fFLkAmM53fJ1GdbUsbQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Dec 2025 11:55:40 -0800
X-Gm-Features: AQt7F2qh3OqRA6VvcPDr_yLiKrca_PvcuJCv6Cyofm9O0LNNujLP6tCQE9_dzcE
Message-ID: <CABPp-BGT=wvvg0OYZkMwv+a2QEXrBhRqjDVSJH_nYjEyiPPkaQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:45=E2=80=AFAM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
> On Wed, Dec 10, 2025 at 10:27=E2=80=AFAM Elijah Newren <newren@gmail.com>=
 wrote:
> >
> > On Wed, Dec 10, 2025 at 8:52=E2=80=AFAM Martin von Zweigbergk
> > <martinvonz@gmail.com> wrote:
> > >
> > > On Wed, Dec 10, 2025 at 2:38=E2=80=AFAM Matthias Beyer <mail@beyermat=
thias.de> wrote:
> > > >
> > > > Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
> > > > > Hi Matthias
> > > > >
> > > > > On 03/12/2025 18:18, Matthias Beyer wrote:
> > > > > > Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER G=C3=
=A1bor:
> > > > > >
> > > > > > > Let's suppose I have this piece of history, I'm on 'branch2',=
 and I
> > > > > > > drop commit B.  Which commits will be rewritten and which bra=
nches
> > > > > > > will be repointed?
> > > > > > >
> > > > > > >     A---B---C---D   branch1
> > > > > > >              \   \
> > > > > > >               \   E---F   branch2
> > > > > > >                \       \
> > > > > > >                 \       G---H---I   branch3
> > > > > > >                  \
> > > > > > >                   J---K---L   branch4
> > > > > > >
> > > > > >
> > > > > > Just speaking as a user here, but my expectation in this scenar=
io would
> > > > > > be that rewriting B would be denied by default here, as branch{=
1..4}
> > > > > > would be rewritten although I am at branch2.
> > > > > >
> > > > > > In the scenario at hand, I would expect that I can only rewrite=
 G, H, I
> > > > > > while on branch 3 and J, K, L while on branch4 (without passing=
 some
> > > > > > extra flags for "yes, please also rewrite the other branches").
> > > > >
> > > > > Is that because you have branches that you don't want to rewrite =
because
> > > > > they've been merged upstream or is there another reason?
> > >
> > > I think that's a common reason even if it's not Matthias's reason.
> > > Perhaps one way of doing it would be to have a configurable set of re=
f
> > > patterns that are considered immutable. That's similar to what jj
> > > does, though we use a more general language for selecting revisions
> > > for it (https://docs.jj-vcs.dev/latest/config/#set-of-immutable-commi=
ts).
> > > I think that has been well received. As you might expect, the set of
> > > immutable revisions are respected by all commands.
> >
> > I like the idea of a set of immutable revisions...but wouldn't that
> > result in the request to drop commit B in the graph above being met
> > with an error rather than with a single branch being rewritten?
>
> If branch1 (or any of those branches, really) is configured as
> immutable, then yes. But it's desirable to prevent rewriting or
> dropping B in that case, right?

Yes, I definitely think so.  I was mixing up in my head the different
requests and thought that Matthias had asked to rewrite just one
branch, which sounded like it wasn't something you'd get through
immutable revisions and had me confused why you were suggesting that.
But, it was all just me mis-remembering and not re-reading.  Sorry for
the mix-up.
