Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA602472B8
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181257; cv=pass; b=K7y/OE5t8i7G+idPSigz198gzBRJPgCwYElxOS3zxNn4TZb+dxTqJnLAoaMQ9BAFnZ3rDn1EJghDipsV1VQUhOuqeyL8HZ+hluiK+qrHIXmqd2uJT/qbS18812pEavzhvdppCCEvq/H8iwWWiW/30fFXvDJn5fGaAnz7sldHyf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181257; c=relaxed/simple;
	bh=JWSL1bZtB5+L9i5Ux2PDSfTB2NIH2oQyAF3AWHUMbeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlhXey4+5BuQ2tyfR2zgfcwWaDzQEjg3okm36zqMwA0Zx8ztvugMhIh/xhYdcO82eZpJPvIqZbet/4TpE/IlMqo3c9jFRXCagIkiCnNzR+rBSaDHJEoxY0bDIPUWqQB+G3UiT2DZiIKSNAgL9mSswUItWDuHUyG0I19NiiZrp3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqZZLobE; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqZZLobE"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8557c3f270eso2674048b3a.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788181251; cv=none;
        d=google.com; s=arc-20260327;
        b=c8uO/0+LTuopmgFaqGIj7/YWh1/aZYL8Kq75e/4UVaibkgjIp6QmK0L7xinu3pmBRx
         ePU/3gmT/TYSypobDSekGQU7NjXSszMaQIjkH3w/ztgBcyCfeiHZavWzxzo0wkl2zoxD
         oGbUGOFcoO5jARYbeDFpplv8s8yKqhuPUkfwor3ueGInA6tJeikeHrlenFeVrrUidc0N
         QlFLbVQVARwZe15igjGNbagMVns2lh4kEFsPLxY9IGUVzeguoiga+BHpIvY9+XUyAtSP
         USaoAgmUAHOVW1/Q0xXX/d4iM8vh5/UKHOr7HGdbk2ETjsAJZAqWiKn2S6i0JQORP/GU
         /hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykwXPmA4WS56v6LpEkUo25z26p4qSKtd0BNAS62IMCY=;
        fh=cm2cew/swAIiWWhlcAMkdRBIYbqTF3LgRkiK7ovUtOU=;
        b=s9zYdp7Zh3mGVGGJANWG1G/s8wNPGynv16brIgFg2OUdEh4Yu02asu79c0miy6y/8h
         /1xEsAuSZ+8P9FsDepR1kqJZp6MS8x6onkOn62Uj/+vBwZY74WjYR8ghm+U7CvpqLVyS
         myraTt3LxtW5z/7223PlQX/Wvu2/nfSAJTaKiNCk2wh+umzFYj5r94wiS+O8IPqqD707
         ErJlvznIBzvdxJ8JtEIcyMQWwvxfsLYLlqmcDvGg6d1YyKEwftV4NuWVD2v+hem8Rs/L
         UMnwKC+JRNRLnj1rcweYBX+YUEN8YINluQ/D20+1TZLIqUxzQgEBv+YAF63TrSuHu2x/
         +NEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181251; x=1788786051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykwXPmA4WS56v6LpEkUo25z26p4qSKtd0BNAS62IMCY=;
        b=MqZZLobEiZRaB7CzZWwpzCzPgYLCyloCzWkJ/cEUoft15RVCnRE2cFVqrz5wz8ErXX
         tiLf+9mjobDRc97ex5lfaJYBmBSafR4Yszho/bISsZ7ZHJ6zzljdh+wnD2/CNs9uhQe3
         I98XCYCpTsoV41xKN0t9daJf+41UpSiSn71uNtWG/zgKOOHiGv8LWbFW4VncfZ/nd6//
         t5U6PMCdHgW1pigDkVVS2czOFT9k8Qc99j8Jn1OTSbjWsXElHIBAM0+UhrQpKLg0Ep92
         +pnc/sZ6NLIjcITv8Lvyf7r078boqyctccwMcdUNxD5fl1G+ANHHuw0JYNwF/kVQG7Uw
         1CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181251; x=1788786051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykwXPmA4WS56v6LpEkUo25z26p4qSKtd0BNAS62IMCY=;
        b=dRXie4T4OJkgtio+SnbLg/NV6iaIxJOp4iDLKl3eL5E6w92i2L2z+ysRIf6e4JVkCn
         YWFOr5huesr1B4ZqbCoffWB89qMElgn4r/SXh2nWFZEbaJCFgPETqkH0A2uxgI7xteUP
         Zoub03fdKujSF4VlltmEK/RKn5fGmGUGVboPrKWG3HEkk1C+wyx8gPdb/pG3NE+mzutQ
         BOqWb7cMtfiECNF4KEvufSk/iLuv/jj4UwYn/78JqbB8o+OthLktRx9onTF4ICFFlY5i
         AQo5ZNz7v2El4dTCy+TnzwS/xD3axVJsVrcWhkpHvKbJgWpPVUzE4Q2stdnrDpQ78Yml
         1gGA==
X-Forwarded-Encrypted: i=1; AHgh+RqGyfzkjck++/bQolfNKyATNgj7Vw+sdiAJGFwAaSL6aaBLhuGL3uo55cWj51LCvPLXZZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlFwY4YjTHZx70E5yQxLgPE4DA6gXyi/tzpzlHM3mZ2rVjcs2Z
	BAbXHNlpLCNJeliclDZx4yHfBrm+4P4g1MIOEcZxvfsN3wz7eUZLfkWMRO9ookmxDo2vv6XUZn6
	tJYsHNSdDKZ1jLWg31f1Wnmsu2i8TLKyXowlGc++tcQ==
X-Gm-Gg: AR+sD11Lvo6OuFtOhDx5zQN5V9024cGtR4cNvN/eUQ5lNkd9zEsUwR3t5n3XGK54uyj
	6Qf6ISBJtoF2/8fJfxQTUA6q4qgMs6SGhK9++xBvPutvCbjU0/ru4TEFdx1YbI9yO8vaDZa62I7
	HoqW3uhCjQVphP8SVRKflFDcx/TJqPYjzmQZH/sPnZ0IQUBcNWUftEYG98Zwq4Px/PVNjS2wMag
	iqP0HubOCFYrYNQS8aBcjU5o+wrlpAO+qhw61l8Ql124upalwLmypPZTFWFdeNJeI5H8XX+1XLi
	CEVmR+rn6DmHgYUpppJZdjXJ0lIpqbxL/pR36IAl12cNU3PITW6LZNDEB60WPELojYyZVYK6A/f
	bcir2GiUHH/hEfAX4qafA3D41wvgK5XoGLAqceCptGLzLhV3LZxMn0n/ag6P6A34ySjYNZv9xx+
	mTsFF420hG
X-Received: by 2002:a05:6a20:4326:b0:3c4:3112:45 with SMTP id
 adf61e73a8af0-3d3bf1583f5mr24856403637.1.1788181251059; Mon, 31 Aug 2026
 06:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788010335.git.ben.knoble@gmail.com>
 <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
 <xmqq8q5n1fa2.fsf@gitster.g> <CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4ckTsRm4ZGaQw@mail.gmail.com>
 <apVJAzddTPPCI7kA@pks.im>
In-Reply-To: <apVJAzddTPPCI7kA@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 31 Aug 2026 09:00:39 -0400
X-Gm-Features: AcwNN1VBd-5r7bOB1WHh2oZTxCTujPnmvT1GYPg-u1xGtTZbJfGUMnDlBzd0NDU
Message-ID: <CALnO6CAbnv4iKpv5TbtnrX_i6Kp1H6wOgh6ARO0ds6kXK9m3PA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Olamide Caleb Bello <belkid98@gmail.com>, Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Apologies for duplicates; Gmail switched out of plain-text mode
without permission. I've yet to finish setting up aerc=E2=80=A6]

Hi Patrick,

On Mon, Aug 31, 2026 at 5:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sun, Aug 30, 2026 at 08:27:13PM -0400, D. Ben Knoble wrote:
> > On Sun, Aug 30, 2026 at 5:15=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> > >
> > > > +             /* nanosecond timestamped files can also be racy! */
> > > > +             (repo_config_values(istate->repo)->use_nanosec
> > > > +              ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> > > > +                 (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
> > > > +                  istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
> > > > +              : istate->timestamp.sec <=3D sd->sd_mtime.sec));
> > > >  }
> > >
> > > Currently this is probably fine, but the use of repo_config_values()
> > > here means that the order in which we can transition/libify two
> > > unrelated things are forced on us:
> > >
> > >  * We'd first need to make sure repo_config_values() can work on an
> > >    instance of repository that is not the_repository,
> > >
> > >  * And until the above happens, we cannot do a --recurse-submodule
> > >    option that loads the index in a submodule and operate on it in
> > >    the same process (e.g., "git diff --resurse-submodules"),
> > >    because immediately at this step, istate taken from a submodule
> > >    would have its .repo member pointing at something that is not
> > >    the_repository and we will hit a BUG().
> > >
> > > And after writing all of the above, I realized that I am mostly
> > > repeating what Patric already said in the upstream, e.g.,
> > >
> > >     https://lore.kernel.org/git/an720tZnot07HYiK@pks.im/
> >
> > Yep---just so I'm clear, we don't currently have such an option,
> > right? I mean, there is no --recurse-submodules for git-diff(1), and I
> > tweaked t4060 to run "git -c core.useNanosec=3Dtrue diff
> > --submodule=3Ddiff" without any issue.
>
> I do have a patch series coming up where we start to rely more on
> sub-repositories when recursing. The motivation behind that series is
> that it allows us to get rid of registering submodule object databases
> with the main ODB. But I just double-checked, and your series luckily
> doesn't break it.

Glad it worked out ;)

> > I would happily prove that at least none of our existing tests fail
> > with core.useNanosec=3Dtrue, but I'm not really sure how to shove
> > configuration into every test invocation of git. Even if we could, I'm
> > not sure we necessarily want to add another CI job for that (though
> > that's a separate matter).
> >
> > In particular, (among others) I have not received any concrete comments=
 for
> >
> > > Comments welcome: I haven't touched any tests; I saw a bunch of hits =
for
> > > "git grep racy t" but wasn't sure how to fit this particular change i=
n,
> > > especially since it won't be equally valid on all systems? Advice
> > > welcome.
> >
> > so if there's at least a way to exercise this path on all the tests on
> > my system (which should support it), that would probably be a good
> > thing.
>
> Yeah, I simply don't have a good answer here. It's messy, and I'm not a
> fan of the current direction of `repo_config_values()` because nobody
> has yet stepped up to untangle it from `the_repository`. I gave it a
> quick shot at one point in time, but the result was messy at best
> because of how we populate it via `repo_config(git_default_config)`.


I took a quick look (being unfamiliar), and yeah, it does seem pretty
tangled. I suppose one way to go about it would be to have
repo_config() forward the repository argument through configset_iter
to the config_fn_t callback? I'm a bit surprised (leaving aside how
pervasive the_repository is otherwise) to see it doesn't already do
that :)

Is that the approach you took? Or, where else did you feel hung up
about the resulting code? Just wondering.

> In any case, if we see that your changes interact badly with some edge
> cases that we don't currently have on our radar then we can still
> refactor the series and move the value into `struct repo_settings`
> instead, as that structure works alright with different repositories.
>
> Thanks!
>
> Patrick

This sounds reasonable to me. If nothing else, this series might
become good motivation to untangle repo_config_values=E2=80=A6

Sounds to me like we might be ready for 'next'?

--=20
D. Ben Knoble
