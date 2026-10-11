Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E245A2AC
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727596; cv=pass; b=Yi8o6XzZXSV0acHQ7ArufNHR8WvTyifOCF4evw+zAUBJnwkmXOr40XYrYf++KRLQtXgjFJ1InfyLeeVVStwMLVK9sYivquPFqIavyyYtxsDHo2P5mx8SjIuZT6c1/K+uoI3j5/QUaYIL6pmaQ6w9kyWTXUPe0B+92DRe5Y1XzVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727596; c=relaxed/simple;
	bh=xFdM2KWAhPB2xoryyb3wwHaNGyqvjZpvakENyyiQf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtNhyZ9/81fyHG7sdsSNV+iPc2XEKsZYHFDuuvq5wCYWSzkHdzG4ZO5gIAkxtolyprxIt8HbEF34nqgg4AhbROv7oSgYGuG0xC3SGTxeeU8YPpgJlc0gTFfoZqRCk/BYQ3iIbV47tK7wn8ZaKdaqElfjaRYh4Po00MyTw1W5wpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpHWfjU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpHWfjU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e4af975346so6686605ad.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 07:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791727593; cv=none;
        d=google.com; s=arc-20260327;
        b=b4bYFyuYpvhodN/qJfg2HpWRGruajpxoSO3HA57qhtBo0Fa9xfaxUba2nc/hZ/JCw2
         C0WORMqk+sEcrEmKWeMHwI0KLsDJxsJi3TUWEJnDl+aVWODlFJgsCWGKGCda1YgC2WRQ
         VKytP4oJIJt22GKJK7t1GddZ5C1wXVLVV7ydSvJy1IjFllb/CHuyaq23oxXfhWBD7Dgs
         xaq4gc/o+zd4hbImntO70k6YJdanZuxscXNI+Y/0+G01doq34fnvgmR2VI2s8xbRr13/
         MHik/IUdFGrKN0F0ArGmbjCd+LzeOmCySiHgyRL+xPgl17YqeSOWBmmmpkgkAItX/gm8
         LW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=umCeoZZGJ8uhDpeIvY7dHAS9E9CngDXNOhS6AklOqiM=;
        fh=a40HZkC+XHIaLQqJ1fiSHBHS2WxGSwQYURHT3irPygE=;
        b=n/aA52Gh9lW+j93KI9otuUXV3ZWkNu+/qZmcZf+AwlthjDzy2DHYhRoRjxOxC7ZsD0
         3Srt9E1uySylB+Q5twOX7/isYom8agI5oxV/XTaD878Vps87IEsT+ZNDmdkNF3Guueor
         vKNaVSg7tg94HTLzU6vltmOT/u+5BKlT0wtbrMA4pAy8xK7xgEd38QBPjeW87HvL5usG
         EFpP6A7mpEOMh8LROM6LP5ejTBSfIeNQ6q+uVmkqF6PLE4vFNpYN40SM97NsSImBOMSY
         nEBz6ErfyHDOY/SNxYu49Dfr859KELphbG58w4TIETGH7E9Dekew7133PZs8jNyWOaHr
         usIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791727593; x=1792332393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=umCeoZZGJ8uhDpeIvY7dHAS9E9CngDXNOhS6AklOqiM=;
        b=MZpHWfjUYu6g2Z3l5nUNKvCZa5ftzrFCt2MnR3d7rop/HJnBtgB+7GOxkVDZF7vkYu
         CxQUZBmgr59jHgFVwhRQwZr3J+Qvzp+ayQTNBj6I0Mj+4njhU2Mw//trof2ErIQu3kSw
         P6slZp7fjP2qzS0lmrqGnlyL/HUaPOg+ICAbzqiXS5vKIgEzwv3WNm4UfSsMBDuZn9YU
         WjHqwd55rav0QrnAGIdgy00ym5GMmPJSjc9E0+OIJGQSpf6yyoz69ITJMk5l0pfwyHEw
         8uf5CA+j+HTkmS7K+fck6ugdmUyX4h30xeFHjSYpgysj3T90heQIjNFalRUmpn9KSGzC
         Y25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791727593; x=1792332393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umCeoZZGJ8uhDpeIvY7dHAS9E9CngDXNOhS6AklOqiM=;
        b=Iosqepo1ii1hzzqWX7+J+vzVIdEp1pf3gdFHZBQfeKegPvzpNwvyUcCnkgNbCJBPIu
         AXl9OJ0w1s9+b8j93sUqyzsJBi1dvmmNZY2VlnwNWfKzVZjn4RKSDF7X9eSDQ9sIbKwU
         37do17ypKLa7dNPcx6D4go7ywWAhr1RTKtj8jar8TGkLMgxEAFZO0tZyv0leHr3nbJTr
         5Tr42or1yXdsIfwnmdfkFT+0P1X5HjVHdr6TSHAqib79+naqvO1eXeN0sM30l9dIWRoJ
         9vLSMAbrZqNI+BpaTA6KWyaWUjiB6lHSF05RpaoC/raL4yUwdJ2QCfUBR0dvXyKTeV9T
         aCfA==
X-Forwarded-Encrypted: i=1; AKwUvBzha5mvuUwcL0KHjZHQYT/gFrdEW8M4Oyqj3X3XOirlvFBVgsq756EApeEzTkudKYS69uI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLR4QcZIl1crXQBQb4NIGKViHPE0QTD/oP16U2onx14uXrE7yo/
	kIShYES9lpqUnbIfYdGxYVNqjXsSxnDVFUNKLiFTzJfEtO6aS6n98bJJ//6jNU56alTG2PhOcWY
	+531HiNZWg7fAZqXhG2LAMqmNbBuh6g4=
X-Gm-Gg: AYBFou2YesGfmPnKGQpPMoUnDTfo7m8HwmtZawrXM1YQ2cc2Lp8ICYXVJyFMq/g0xKK
	N9W48OaiGEAmUCQ8LiacG6aoGsjnLCIBEY3hPw6gPXbMD/11gTGcwHTbTXVSthTKalZouK4byTV
	r9IPeATuR1f4D8QhcWo48GD6O65qBU5ppOEHaNSFEdg7BsUmlbpKIPK6Z5cO42NFqbLnHoTizcl
	COledi1zYdZVtCD2aimxSMNZCdBf/0VIepwrg0zVQaG1Q1j2bhETMy+uaHMjgkCHXW+7i5ZS1GZ
	p5UkNfcAkHO2cOoMqTMR4Afvf+jr1HoI9xgKyZ7ulelTR8FL7WCsTEeGmja1kWDtAc04MNLyzyi
	lRf0PdrT/OlxIvqLR0h64CH/zszss32f9Z1K1WLKvx+dyAHDdf0CaLy14UHgNpPFLzWCM7o7h18
	dyEr5OW+gJp+w1Xd5u7sLYrOTmsxaMVQ==
X-Received: by 2002:a17:902:f612:b0:2e6:437:bbef with SMTP id
 d9443c01a7336-2e842d03033mr55745755ad.34.1791727592626; Sun, 11 Oct 2026
 07:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com> <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
 <20261009203749.x4V9kN18@teonanacatl.net> <CALnO6CAEcjieW48DkA9Pt1eqZ5hctwihmTXMxZ29YBrmzrp1QA@mail.gmail.com>
 <20261010153721.943RqWnW@teonanacatl.net>
In-Reply-To: <20261010153721.943RqWnW@teonanacatl.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 11 Oct 2026 10:06:21 -0400
X-Gm-Features: AclHuK-mLGVLgrbFUwu_llzz3MrRO3ZjJgavH2aOwnUWJrjCObyF5d_aZN2JzQc
Message-ID: <CALnO6CBz5-hgEMPUFEHQ3CyaMgnTLuzWFQ7Yk3ukvGOTwuJ+bw@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Todd Zullinger <tmz@pobox.com>
Cc: Sam Reis <sam@opencanopy.dev>, Sebastian Thiel <sebastian.thiel@icloud.com>, 
	Scott Chacon <schacon@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 11:37=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wro=
te:
>
> D. Ben Knoble wrote:
> > On Fri, Oct 9, 2026 at 4:37=E2=80=AFPM Todd Zullinger <tmz@pobox.com> w=
rote:
> >> Fedora's Git package has:
> >>
> >>     BSD-3-Clause AND GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.1-or=
-later AND MIT
> >
> > Oh, curious! Where are the (using Gentoo identifiers for the moment)
> > BSD and LGPL-2.1+ sources? I guess I assume by looking at our COPYING
> > that the GPL-2+ came from contributions that said they were willing to
> > be 2+?
>
> There are various bits of code imported that are under
> difference licenses, among other things.  The code in
> reftable/ is BSD-3-Clause (using the SPDX naming), for
> example, while xdiff/xhistogram.c is BSD-3-Clause and/or
> EDL-1.0 while most of the rest of it is LGPL-2.1-or-later;
> ewah/ is GPL-2.0-or-later; compat/obstack.[ch] and
> compat/regex/ are also LGPL-2.1-or-later.
>
> I used the perl licensecheck tool=C2=B9 to generate the initial
> list, then reviewed it and filtered out some bits from the
> test suite which are not shipped in the binary packages for
> Fedora.
>
> The command to do that is (without the filtering of any
> code):
>
>     find -type f -exec licensecheck --shortname-scheme spdx {} + |
>     grep -v 'UNKNOWN$' | LANG=3DC sort >licensecheck
>
> A more complete analysis would require reviewing all of the
> files which are UNKNOWN to ensure none have a copyright that
> licensecheck simply didn't find (or isn't in the file but
> can be found from the git history).  I was a bit lazy and
> didn't do all of that work. :)
>
> > Anyway, thanks all! I'll assume the Gentoo maintainers knew what they
> > were doing :)
>
> Yeah, I've found most distribution packagers try to be
> diligent about this.  Though it can be a somewhat tedious
> tasks and can change if the distribution switches from
> expecting packages to list the "effective" license to some
> other method.
>
> Fedora used to do (or allow) that license simplification,
> e.g.: boiling down our distributing Git to GPL-2-only, but
> clarified things a number of years ago to not do so.  It
> ends up slightly easier to just enumerate all the licenses
> of the code which goes into the binary packages we ship.
>
> =C2=B9 https://metacpan.org/release/App-Licensecheck
>
> --
> Todd

Thanks, very insightful. I should have thought of xdiff, but many of
the others with their own licenses were new(s) to me!

Best,
--=20
D. Ben Knoble
