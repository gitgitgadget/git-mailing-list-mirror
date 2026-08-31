Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F32472B8
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136046; cv=pass; b=P74RrrKACHkOjwglylTAkY5cPmLIok75jqH6D3Cr0IAqF3P6hJmm++AxGsfpGUfozF/rSeNCOw4AKXUhQKuLhgN56u8HAVWfDmFJ2xB6qHKjKykzgqOs6XlkpGQ28tEr3CrL2gY6/JfpaJA99Obim7a9a/Ts/ItBd2dC6Q+tuXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136046; c=relaxed/simple;
	bh=lQd2y/+bd7mcLP4xowl5nZxuCbtgL8ahd/9k5U5sNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvLW6T+2DaGC3o6E4RByG5pjbY5Vm3/MXOaKYohesFBIIKhPUbVcizFg6rGhDaaeP5vymJuekCGDkgD2qApq6c5hN4lKxnhTpI1lkTiQtfffocL1ptj8YKa1onbFRdGUcbtXUXkcMSmzhFkTH7DcLcw/n4RLTKuZBo9CD6zhhyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klGbKvE7; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klGbKvE7"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so4124545a91.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 17:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788136044; cv=none;
        d=google.com; s=arc-20260327;
        b=Yr3IPcP8x22eFkP1JpNZVnUUtSmu7W2P3tzjspeqOHyufp1vGFY4j1Zq63O6RwzAjn
         lAIPLAQMaHCBNJKQLGDtgNBMT1hSAXA1cyciUp24A43X8I0gblJTvhlbJioYkY1YEInO
         JhXep3jLgHCxE82sX5QOqyWWV+FNluCDTyuMOEZkV9XhwuRtEK8i0trVNgh+s5VXxUN4
         c2aEVgdR3rwqnu8PhEF7DIHSbNo1Wxxay3GuStcKqGb7xq+w4eqoglFXzeEva0cIGLMZ
         J/OFOieq/ZDW1ZxlGR0DyeezhLvPtjOpEbstVuP5YihlSOaAggQkyXbMB1lzhicdCzxm
         Xuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gow/4K1Dgqpy93NYJAyaRSimevVfQL9Ktoxb34UKIWk=;
        fh=TfNCgQSQ0x9kCtBDnfbNEaULwu1Ag9LZTR1Dr/GyrOI=;
        b=QiKXMwx9Pk8G0dKj7LDIWfzoW6F1VjUgupE5kr1UgbD2SoEDy142GbKZZRH4++aiwZ
         LUbwFKB9LVHbYOrt5IZaN57DCiAUI/3eUbSJ+MO4AbQQb2c+PIc9k08VYJka93hT9Oc+
         sSP0VQZTcCzn76ZFRZFIyeD4ERD33O4QiBRMnL6A4LcrsE/ltWnyDWX0e4GwfC38rh1D
         Xvm0glq9vUUNNf2gTK3+MXgF+Rj6LkV8xXihO37gntqVVfyOcGxDsFWpUZlc5jp8Z4gl
         Ybj1KyfkU2MgN3qT/IQUTVJa074eotEsTorDRSC+wce1l+eF21zfFFZ85aU9Zps+Q7ud
         6kqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788136044; x=1788740844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gow/4K1Dgqpy93NYJAyaRSimevVfQL9Ktoxb34UKIWk=;
        b=klGbKvE7mcFE1zh3aYfeGqNLg9VcNhMBMlr9xF69dWJmrRpp7J06bEj6gQIfTKhjsz
         4Gwa/Lc0kYh/t/YCqzoIDM1mQ7vR0+WutfUvTYdo20oQluq23UqOFRdaM4zxf+szMwEg
         9DJ8tbng3kKKiEnzet/3HpN+PviTf550HwzMhHiDZ6JWJOCrGaVDctSXfjDK44Ry7tdd
         pI4haeainvDAA6TCMM55oVpBjSaH6IuMVvSmFrJzPa2r4q2DbWC9N7IV0NplLx/54znx
         NwCZz9/67UAL6mAf7u9BdGEX/cIl+Vogl3bdvQaeUv9gQueHok9qVFzHoYB1uy85T1u7
         tC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788136044; x=1788740844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gow/4K1Dgqpy93NYJAyaRSimevVfQL9Ktoxb34UKIWk=;
        b=NmEf0bbEwR42WHu4UCDOK8OTcEbDCN8wr449oEMs9wdn9FxtXTnWA1iGVPY5ZC7dpK
         RvaDWUj8Up7Q6tt1SNjZqe4RxJcP8PV52i92p+DXAqv4g/pdet1Q2egmu9cnM071qKCY
         z5MKIOWviNuWxsvWWJZn3io8h0627G+NOPYbdTt9y8rVIUJSZlGZPqBIr64vvDRB2n7H
         ojrd3CTgewjP4TgKAdqn+0zdt9RWEvX+YTMVXV2ddIlkjyaOyS2oEiuKxXd1gSD90KxW
         GCfWCIpPuLJpENLxw082BH7jwQub8MT87w/NNqsPA3OdDq0N5/wJZdcucGwtrY1fpMNS
         deqg==
X-Gm-Message-State: AFuF++mZ1YQ+wubA4cGfDEaolW6IfyDo41/teiCEjV2x0uHK+sB6c+b9
	kEnoyD09S/xIBe/mXtzwt1pPhJBkwBwSlU+GaPo/GdtT8Fn/X7ExHAmjEbjw030cNdyOd+SkwsE
	5s2u0q2uaf/jf2veJANWuUZrU0N9BTdj5uMZBrRI=
X-Gm-Gg: AYBFou1c2eR3hCm2dO7I+EYQE9g2Feamz/2+d2ujAJ6IEmHl9BcNhp06GnsCtF3Hidg
	0/TEB1kJNoAx/MBVfZrOFILycRwwaO+avgZAHh3RjYkD/E4KRrFxQPhW2wqskTLcL63TAg2+Lrk
	cSr/fBg53ECSHUmQoKoIO3yhEq5kURt37cqTrpE+k2KOHuDwrL+oB/tE2QjwLDWiI20DuRO3Fxg
	PFWpimp4d+okBsGwqpQJgxwurqwCkArjTefeBwvsTpxvNdxCX3V9GRDZ6bzVm2DvcuvWkmTf1IY
	SpCUQQKZNl9TsVlzBh7DYpUGBBDJXxO/bFyak+51SwudL1hhGqj0xRIQzdvsjq4iRAwWQwYVd5Q
	Jr2ydPsuwZlCNva2KrPDjLnd3hxk1kebCJM8KGQi/Rgb6llqGWsraZH6wYq5VbNRovZ7TWOnQ
X-Received: by 2002:a17:90b:5905:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-396d0d7b94bmr36707776a91.4.1788136044315; Sun, 30 Aug 2026
 17:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788010335.git.ben.knoble@gmail.com>
 <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
 <xmqq8q5n1fa2.fsf@gitster.g>
In-Reply-To: <xmqq8q5n1fa2.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 30 Aug 2026 20:27:13 -0400
X-Gm-Features: AcwNN1UgtoY4NgIABGKdUzkPZ6XscP-izxolP4ZWYO8TKhT-UjQecTbqamm0dOY
Message-ID: <CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4ckTsRm4ZGaQw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Olamide Caleb Bello <belkid98@gmail.com>, Todd Zullinger <tmz@pobox.com>, 
	Tian Yuchen <cat@malon.dev>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > +             /* nanosecond timestamped files can also be racy! */
> > +             (repo_config_values(istate->repo)->use_nanosec
> > +              ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> > +                 (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
> > +                  istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
> > +              : istate->timestamp.sec <=3D sd->sd_mtime.sec));
> >  }
>
> Currently this is probably fine, but the use of repo_config_values()
> here means that the order in which we can transition/libify two
> unrelated things are forced on us:
>
>  * We'd first need to make sure repo_config_values() can work on an
>    instance of repository that is not the_repository,
>
>  * And until the above happens, we cannot do a --recurse-submodule
>    option that loads the index in a submodule and operate on it in
>    the same process (e.g., "git diff --resurse-submodules"),
>    because immediately at this step, istate taken from a submodule
>    would have its .repo member pointing at something that is not
>    the_repository and we will hit a BUG().
>
> And after writing all of the above, I realized that I am mostly
> repeating what Patric already said in the upstream, e.g.,
>
>     https://lore.kernel.org/git/an720tZnot07HYiK@pks.im/

Yep---just so I'm clear, we don't currently have such an option,
right? I mean, there is no --recurse-submodules for git-diff(1), and I
tweaked t4060 to run "git -c core.useNanosec=3Dtrue diff
--submodule=3Ddiff" without any issue.

I would happily prove that at least none of our existing tests fail
with core.useNanosec=3Dtrue, but I'm not really sure how to shove
configuration into every test invocation of git. Even if we could, I'm
not sure we necessarily want to add another CI job for that (though
that's a separate matter).

In particular, (among others) I have not received any concrete comments for

> Comments welcome: I haven't touched any tests; I saw a bunch of hits for
> "git grep racy t" but wasn't sure how to fit this particular change in,
> especially since it won't be equally valid on all systems? Advice
> welcome.

so if there's at least a way to exercise this path on all the tests on
my system (which should support it), that would probably be a good
thing.

> Other than that, this looks good to me.

Thank

--
D. Ben Knoble
