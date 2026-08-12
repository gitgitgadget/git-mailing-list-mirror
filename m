Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985E46EC64
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549334; cv=pass; b=iw0NCFw6zhqgDIsyFn4oA7tIEayiZEwvtWSbeoVVvU9N/eNkxoJYwr+4aXq2iC8oPiwwlS5ylbvx5P84CSxwIQKh8to/cFv2Z/7asByDGagNDA7qAsBPD81JoFMLtG9R3KbadS50FMIv3yAsi7cF1a4ROpjIUFRn7YkfgH4K/JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549334; c=relaxed/simple;
	bh=fFSSslifti7EWEHIMvY3FDAJ558KSPebJjltr0NXnlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3fnjl9Eo7LwmQ9UARp+gY9omKvHWxkHHsuJS/AdRUiXd0Hi85hxWh71PDuObj/2qwowY1UfdOcxVgXf0WfxHXLV9hXuvgfv4BMq4s5pokfP4UGb+z4Mmp7GbPElILCeqXGXFWX/4lx7BevdhtyosNk2Wt2AqX6Xdz3jw7u+ZNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhKGKWuU; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhKGKWuU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacf197759so22828755ad.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549332; cv=none;
        d=google.com; s=arc-20260327;
        b=ETPZDf+arWq/DtHKbXYtPL+cnItinfNEiMYN1DOKieXmlnmU5WCxXW3p7OXGQilmLv
         v2Fvs3Rh5EPVaxycgOtbeOF/dwRSJbkHlseBcA8X01va/yi0RDr+6r6gxplsyVnd5MLQ
         lTnO9aRjX/H7pzC7WXh2OQrTZX2b9OZCk+7SNY18CwRBz217xqSGHSZ/tap7OyxI/5je
         GsbxR0PKSLc6612HUJJ5UAO5AIAjBTbdg+a+M7kEdnNVmZduZlg4S4dvF8RGKa+7Hpwi
         cS5te9PQwqgOGloTFuWkdVSPkHqWh/YaqgWMiFwztN6teQncNmb8VrHPM5gnXSiRy7N8
         cW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=boi3x6gZDeGl3IyBZ4FNzJr15OaJp52C4OA1aMlKy6o=;
        fh=GAAKa9LguZDAG5QbThFIPuaXJI5pNTddj1MZ09WV46E=;
        b=eQrwu4LmCp/icOXAD6PGGEnYW7RsyWSry70ZRpFW11gEj3KgS0hXts44TEIDZiMgzs
         FT5VKVQzMLCg6xCVgc+LQBXttq0V3czrl3tYC3fnsPVtsxSY5OZmaUcJQ+jVBxenFSiq
         GhOdHLTRPKw72QYsdLw48ezOsAMXQlHaLroeDBUYKMrioYBOXkrDZLn8XRw5lIH7jnJi
         TH90GEWWNIBQDfVDG/J3SkN5oA7oUNv697dEJhr/L4T4PKAvHtru97f5xieL/oupa/AC
         U5rjDgUHRsCBxRA6yzM10LO2Me2992gwPQwjO2odrvJ7Kv9GofBwqJECdpRST25h7Fgp
         IXyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549332; x=1787154132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=boi3x6gZDeGl3IyBZ4FNzJr15OaJp52C4OA1aMlKy6o=;
        b=MhKGKWuUMq+YdyobtWbMDW/9Wn3tkoYQlsfdLEsDMx1DHIDNp5fY4xng7swZeHqxmo
         zMmCMLBC9UlmEQ4rSt4pxgKiliN2JPCEBRc82/iQ0d04GYQTvRej7le2GXAFX+pyOR+S
         4XxhYzuSXl133RCwSwzSchEovm1K0PyFUhslmCfnP1wb3B1QHCzbkcKHgt9Kf31DfEWg
         UjADRK3YKbeZrWm0FL5FDAikD36UfJtYyMlRqs/te1+wFNk8mgD9xMddxJnKHsoqxul2
         l97AkALPFwsbnso59I6d8BVjTdZyuoIxH4F7uVtl3QcEt8CYtbh4zFk+qaVzVy/flk+I
         /JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549332; x=1787154132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boi3x6gZDeGl3IyBZ4FNzJr15OaJp52C4OA1aMlKy6o=;
        b=FiezQvEsFP6HpfcT6v1/2yYhhak+gquPQhsWaTZ0Fw2ZNaCjlwNeEGYC/T3wRChdEh
         Nbxp03zR5hZKEEbSPwcrll0KFTkNY+sKDRk3GSmDj+Y2xrjVf9Z2GgWr06GDD7eHKsbQ
         usp0OGUm/F2kC1ivFjkcuNNE2OXyviZynl+q9GSTmbI1H/Px+n0fF58Exzzz2zC72KxJ
         Df+bXIxojlMoWPa5Vd2W812IAI2mN2gSphpPsojTAtjkZe6nmaZP4cHarkZvWXHRUw7V
         BLn15YU5vYOwS/3uPnI0MfPVeV2gxxxctyhCIug462k5io4rvsnKPYr2oaDstImMw96k
         AOXg==
X-Gm-Message-State: AOJu0Yz7v1wtCLB6vFTSR9V0NZGtkyjWkrSpf6NluCt60zMh8AL2p4ap
	cpw/eOqfi430ktbWkR6LoJ45AznGKlgRaoYcmGeNcNorkKRU3laS8mCSWncRuLBfgIPRLeRMerR
	AnjDlCmn9EHGITO3WCZbxcDztHX8z8uQ=
X-Gm-Gg: AR+sD12efchFOqZxRWlupkohrkNOraR348fnFYKmnrc0XNKiGb1mBTRz5/k8L0X0/zE
	R9tf49Pjf2KQwa+icIvTSexeWiJUpjEOqCXQnvCRL/pCrI9frQCWMOjL0ssy0K8WQREVGJwdxT6
	XC9iHO56wAa/2/uKMyROi4USQZtSzt3yeFeBP8XQQD9xrSzVwoIUgFer8MKmj9QuHL9trs+/q1D
	YVmEVlZHyBKETx8cmUmVeXt2lyo2tyD4LN1jMcOZ2LK5AcQPPlSd6a5ch9tKdOVZhXzxKC40ZEr
	dcyGR2Iwgsu0/01kN1S7ECKCOxwMkhFA2TE6GB6R8DXgq77G2koLdLOahS2nz44p7BaVGr2CMMv
	dVl/Nbo7dRPCUCLYlY9KRrsZRpl0Wv+B+G6XOXRS321EM4BIcT8v9RuIS5rTVxWPTLe4p5ykL
X-Received: by 2002:a17:90b:2783:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-393014b0169mr7523538a91.20.1786549331622; Wed, 12 Aug 2026
 08:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811121446.2080190-1-christian.couder@gmail.com> <anxXbnuRt4I4uPdI@pks.im>
In-Reply-To: <anxXbnuRt4I4uPdI@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 17:42:00 +0200
X-Gm-Features: AUfX_mwL6GnxVmxn4N1FFaYnlXWGjqjVBPu1ZhbwHGXTT0bh29x3eNpNbLcxJeM
Message-ID: <CAP8UFD1XMY6N3UD5FhK_oeQDX7banP1e0oKM1WHUPhPv_vzbsQ@mail.gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a value
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:22=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Aug 11, 2026 at 02:14:46PM +0200, Christian Couder wrote:
> > diff --git a/git.c b/git.c
> > index e5f1811b6b..96df15b5cd 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int=
 *argc, int *envchanged)
> >                       if (envchanged)
> >                               *envchanged =3D 1;
> >               } else if (!strcmp(cmd, "--shallow-file")) {
> > -                     (*argv)++;
> > -                     (*argc)--;
> > -                     setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], =
1);
> > +                     if (*argc < 2) {
> > +                             fprintf(stderr, _("no file given for '%s'=
 option\n" ), "--shallow-file");
> > +                             usage(git_usage_string);
>
> Should we maybe condense this into a single line?
>
>     usage(_("no file given for '%s' option\n")), "--shallow-file")
>
> I think that also printing the usage string is only distracting and
> doesn't really give the user a lot of extra context.

The goal of this patch is to fix the bug by using the same code as the
other options that can be passed a value like "--git-dir",
"--namespace", "--work-tree", and so on. Now all these options use the
same pattern for the error message:

git grep -A3 'if (\*argc < 2)' git.c
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no directory given
for '%s' option\n" ), "--git-dir");
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no namespace given
for --namespace\n" ));
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no directory given
for '%s' option\n" ), "--work-tree");
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("-c expects a
configuration string\n" ));
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no config key given
for --config-env\n" ));
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no directory given
for '%s' option\n" ), "-C");
git.c-                          usage(git_usage_string);
git.c-                  }
--
git.c:                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no attribute source
given for --attr-source\n" ));
git.c-                          usage(git_usage_string);
git.c-                  }

So I don't think it makes sense for "--shallow-file" to not be
consistent with these other options.

I could perhaps add a patch to the series to convert all of these to
something like what you suggest, but it could also be done in a
separate patch series by someone else.

Anyway thanks for reviewing this patch.
