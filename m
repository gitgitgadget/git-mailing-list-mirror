Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4F4418EC
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540488; cv=pass; b=qRN7hJgX6RERlbWFZV+kzldYmeiu8iJsYvVRBanSPX+1Zbo78pB9BH0MKI+ei0JORSZIamk8Wj+ap0YYEcJ3MdMtVc6cUm0i7wRPaZw55WFbKcupD9oEQ1JxPcfBx2pfudd/6r8KzAAUdtTa/fcxiCMwjUHulP3emvLPPZVwHGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540488; c=relaxed/simple;
	bh=TapP6vMDG/tHYbF9hveIdKhpUjfOt78kScoILpgTRSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0MvoptcJq9cKDfaRKIQYOpKiDn1LMVYxTqulZU6meApWrewVZ2/Q7C3ZZPAtSdZ9iEU5wVCFbjkG24/svPigaWdaE0crUKUdgYRX104cWQ1KnV8DxVhi0Gu7JfFDX9YstoJLE5lRJY4Af355MASjHR7cEirbHtoOx3/CinZKWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZEqvkbB; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZEqvkbB"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0cea8883so8206331cf.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786540486; cv=none;
        d=google.com; s=arc-20260327;
        b=mQaltOUFd/SJnyn0Kj4AOVpMaFrSvyxokgDVeWP7Kn1D5JtclDVf5xtwWA9Gn4JFqk
         HbjvVJ+5Tfs6YJ4FeiJ+FxzvedqgqV/NOeHww5mUpPCHsSQTgaBGkPMNEvZJM1lCAifq
         MJT6RVNw1XAaOYvyX7ZS2xO4dM8NmLR7WkrcagEtZAcrNe7SimPmX58JAVFLeLiaYQaR
         gtgOMLPtnteGAL20DsKqOlwmdhsB4FySEN5HotRQ5mJYDbo/iVbOR9sNLzCqSiLUY0A9
         9NQ+gEQk8CDVvuPUtFt2XRE/fvvhrIn6s5zG7i2VPxIfYKoLn0OHK93qEXIhIcMnwXHF
         +HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ieT0530/KWWlUsitu4HYUxS/afQhB2cOrueVo5/BgQE=;
        fh=T/S4RnY6IyeqSt+MF6uqNhiHrI4SBMcwowJwxxouMj0=;
        b=BkO043BiUFrjqzot7ssBQB3VCoLCD1+Rtd2fnGc0FpjHJV3bydTUvBvyLridQ5zXJw
         lNspPMrDFGCUcXBqkxfbr0ELNx95cADUia0RwZiSOVrACR7b5hNJzNagxLPOm/WVRG7T
         NhGuAwBEEPsgLyGE/81gpvUB8VdxgjwH4y8n0R708sO/wnnmOaUFjMLKCJhe7Xbml2z4
         8Kn6q5UNS3MkOWfz+cNs/eS30dQUO4p6lyTV0p4s9N9tCZFTufxDrhvplW7NxF9aR1De
         hFtYxX+9pMocRyYI29ywLFdxw1/beE8wprWpdwDfhjymHU29x6HNfML261/Sk7PwStxU
         zRjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540486; x=1787145286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ieT0530/KWWlUsitu4HYUxS/afQhB2cOrueVo5/BgQE=;
        b=dZEqvkbBxqA0kEqUdYazMeBMXxH4Bn5Pc06VuC65akLNjzb0OX/tJphhkNw67P8zbH
         sUTxZLEsYm6oqWlXB0fZxhX1sXBJ2gCEwPrYmfdrzI3Dc9N3Tul3V8spxSXakhmkVYeu
         W5nkewGKpX1AneFeZ7tZak4kWNVmqf4l1NC5GtVD2qgWTZYbFhHmIm/MmYzQQ+GoUx8J
         6Vt1iUCo01SYuPbDwUYKqgQa5KjjleWkQ3Ha5bg6fedVEsD/FIfymt8DpO6IpxKLOaP8
         +mTVtT8i+9t6CsInk2axqKWSH8i9tEt/pmxJ1piFa2Ms3RnqHrNqYwvF71S6Q1qNx+F2
         Wgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540486; x=1787145286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieT0530/KWWlUsitu4HYUxS/afQhB2cOrueVo5/BgQE=;
        b=CJk05G0zK3vhboQsEQXAJt/a/MHpo23wm/NpuQEazF+m4BO+5cCZcQBeI7c/nVwJ+7
         BahVZC8rsdoMcEk5avsi9/IPiDbdw16Ky9OuutanLhfdAz9xW8YR5420hYJRcOLjvThS
         2W37YCnXx/xppFHMKzmKry0CO9EtCDnvhzyZZzCbIhT6SZxyqCSWuU6YEnGrt0vDBgnd
         5SNoDbCcvgVjOgHe1YR4ACVmdexXrVZnckEasnHZaXF//yfqqpO6BMBVN87dgNMItzRt
         QPDWbKsBvlNFJAXHsK1etA0O7B8sZWtTgmxIu56PPGJ8xP7H9YtbN7ilNsJytsggl/WT
         43WQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/oYqogk8IjkIkK5bZHKVQNYWvqwbtlllb41GgG7Qkp2KmUX+jU1m7ciWy/WoTm/6RlGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTk0ism3x5in+CFKvnOx7Ez54dQQ3hw3M5m9rXP6cxkJrYwWe4
	TE6DAzVIXVMBTdSFu78zge8lt5SnHpS+2OxG1H70J0OKmCoLWQNgQQdZOMONIUmbfLXo8KVRMnw
	hBtvY17G0EHaAxGflr7M5PInOrjMezvs=
X-Gm-Gg: AR+sD10ypaJ0e1HZU1J7cTUnun/iX1Ygggg4VmBx4DfBsDTq6ougJsKmI3wCqBzSKEa
	tEnSNCV7zyFGxOnavaqcvWV6aV01CqAXawBe4oRiKSA3fZew9GCMMKncN+CKXI6Oy/GqbjggCbE
	xp9n93aL6KlhHLwxKonAB8m1Ki5ZapTisGm8mJSy4rC0avwdfrmTB6a6GlxTZJEAw2V1dTnLxWI
	RZA19LDYNKc5z75saN7fkp/xikwep2/UQzsEh68kBXew0nWrEQZEm2XIir1YK0w+9rOlriXEfk4
	3MMRwn/x9z8uEMIthEjLaRT7QB+SBD2NeaDfyfz/VEfPRIvhIrX1+6bIkVr0fhGuobM2y0Eq9pk
	UISvEKkBOXJCzWQ853PGkU08GAbCwaMo8
X-Received: by 2002:a05:622a:4816:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52d603623c4mr70339701cf.20.1786540485767; Wed, 12 Aug 2026
 06:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF5D8-u23Z=f02vF1yAHGKRED8DY-v5=BNf7w-yY3vEDmJChDg@mail.gmail.com>
 <DCB65C9B-5E9F-4FF5-A8EE-27C9442119DC@gmail.com>
In-Reply-To: <DCB65C9B-5E9F-4FF5-A8EE-27C9442119DC@gmail.com>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Wed, 12 Aug 2026 22:14:34 +0900
X-Gm-Features: AUfX_mxeXPLXwDSw4RGcJWrITMs7UuyFJzdFiFG0W0n7ztfMdlF6eCMahhX78-Q
Message-ID: <CAF5D8-vVA31Ci+=+kJk+Lk6E4KvgA319hm5d1HZXgmSdNSgwnQ@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:38=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> >
> > Le 10 ao=C3=BBt 2026 =C3=A0 17:36, Yoichi Nakayama <yoichi.nakayama@gma=
il.com> a =C3=A9crit :
> >
> > =EF=BB=BFOn Mon, Aug 10, 2026 at 10:08=E2=80=AFPM D. Ben Knoble <ben.kn=
oble@gmail.com> wrote:
> >>> -static char *dwim_branch(const char *path, char **new_branch)
> >>> +static char *dwim_branch(const struct add_opts *opts, const char *pa=
th, char **new_branch)
> >>> {
> >>>        int n;
> >>>        int branch_exists;
> >>> @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char =
**new_branch)
> >>>
> >>>        *new_branch =3D branchname;
> >>>        if (guess_remote) {
> >>> +               int num_matches =3D 0;
> >>>                struct object_id oid;
> >>> -               char *remote =3D unique_tracking_name(*new_branch, &o=
id, NULL);
> >>> +               char *remote =3D unique_tracking_name(*new_branch, &o=
id, &num_matches);
> >>> +               if (!opts->quiet && !remote && num_matches > 1) {
> >>> +                       if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_=
REMOTE_BRANCH_NAME))
> >>> +                               advise(_(message_advice_ambiguous_rem=
ote_tracking_branch));
> >>> +                       warning(_("'%s' matched multiple (%d) remote =
tracking branches\n"), branchname, num_matches);
> >>> +               }
> >>>                return remote;
> >>>        }
> >>>        return NULL;
> >>
> >> I suppose the extra warning won't hurt anyone's workflow :) so that's =
good.
> >
> > I removed the change (advise and warn) here in the latest patch. But I =
am still
> > wondering what I should do. I think a warning would be excessive if
> > there is no match,
> > but the user might want to know if there are multiple matches.
> >
> > Thanks,
> > --
> > Yoichi NAKAYAMA
>
> Sorry if I was unclear: I don=E2=80=99t know what hits this particular co=
de path offhand, and I don=E2=80=99t think adding the warning is wrong! I m=
eant =C2=AB as opposed to dying, a warning won=E2=80=99t break anyone but w=
ill let them know of potentially unintended consequences =C2=BB, maybe.
>
> I=E2=80=99m not particularly invested in how we signal ambiguity, but if =
we don=E2=80=99t have a documented policy for resolving it in a particular =
way then I agree we should signal it.

Thank you for the additional information. I think the intention behind your
comment was clear. The reason I was wondering was simply that I hadn't yet
found a clear direction for what I should do.

The `git worktree add --guess-remote ../foo` command (without <commit-ish>)=
 is
designed to successfully create the worktree even if the guess fails.
If we are to
issue a warning and advice, we need to indicate what to do next, given that=
 the
worktree and the branch has already been created. It would be something lik=
e
    git -C ../foo reset =E2=80=93hard origin/foo
    git -C ../foo branch =E2=80=93set-upstream-to=3Dorigin/foo
but they are too complicated. So I now think it is a valid choice to
interpret the
behavior as normal and refrain from issuing a warning or advice.

Thanks,
--=20
Yoichi NAKAYAMA
