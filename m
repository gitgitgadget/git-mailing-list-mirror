Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134914A639
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408979; cv=none; b=jqt0o4F8SiLrj9xFsC056zf3x85GBJX1FcxS+ipQ4ND9gpwA/fjXSYas8ZupnNAPWUvc/Abj9dA8QqqoYIlsor2TcjKTeyOy2mSNquFAHJTYH/st3SIxYrtO+iWlM3bi8O84FLqDdXigy114iqYJLG3Pd66Hbj6dFSt/IX1OVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408979; c=relaxed/simple;
	bh=iUhfrHL0UKaC4JpCzzDivjp1ZKuthCv5gP8eks1auJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIK0faudVqhdXto/MOwNCbefde0flhvKY6+LTRsRZIXTgv0QEwlOh/d/Vt4iFSYJxAs7tBKEGBxrtCQKlJKEc9fwjGZ4dLHO8j63/u8fWatLfCEoptxiJ+SVhC9W2NYEIJq5YI4LAQU73e5x2Iv8UTQuJZFEzAm2fAxtefMi+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy1V/Wqm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy1V/Wqm"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d071fcd89bso145454fac.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747408977; x=1748013777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42wtKr5Yey2QnTVNHI9defVST8VXJUOHu2f2OLcdumQ=;
        b=Iy1V/WqmJZkqHyjwT4hKPpCu1pblyGQLf2RiSX1u9vKGzvCp8I+kRy/h/Oe5Jk/fvw
         9zJOqE6gG0ttQfsA2HX2XApvu21We8cgPypdoLl3Vg8z+TZE8QWuKEdSQ25+id95gdm2
         PbBgttwoKef2JCWUMBzlo3QRqImqo8Wj/rxiSG1cH4QMDg6NXt+THXi4iyUnWFHAbHKK
         PLrxQgR0wrL7J8ntbCOqMuk+v9yTH5ptLO1E5NpkNjF2y6pmKuk7MI4era0UeS5d/09Z
         J9rbIKaUuOawgnGxT4h/3X0QDSffCPWR37VU+Fk3U38vavemqA3AlzN8PK+D19ZMVchI
         /5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408977; x=1748013777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42wtKr5Yey2QnTVNHI9defVST8VXJUOHu2f2OLcdumQ=;
        b=xMnkmqMKnznJaNlVuQGA/pukp7yKGrR8jjHuDQOEjIu7zkTzgjswRiT6L/BrYKtDW2
         x4J1PAO9Fo6jqd/OhpiBstwiIWpwOBbno4Yd1Ttb8lrnFRDBISWAZpNihhN1/OZBFpFt
         oGTIwonCt9BTfmOA/jeBbUnDVcV3puJHF6jnYtCE6yDR02Lly7o6XOr2Ozb6GuH2fNfn
         KvC4Li99LGXSpucsfcKloVbuxGfuUrj/qaGGCEGspG01nmE0lRxYtMf70OveyTItJfoD
         se1nXSY3sEkRcdyK7NYonImJX+ztctE74X4WHhfnW2tHpg+g7e915GQkDN4zz/yHa3Jw
         5o3w==
X-Forwarded-Encrypted: i=1; AJvYcCU5bSsxFtCJyfjt8Poo/0l6OqHMM3SL3szVlreEqHcxCbuvOXQ3S9Rsp83ch99acViP+mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd56t0rpZXY6WHcPbq3ACkBxYc1Cryazm0RVNe9VxFHWpc+FDz
	4HmGJuQ7Xf61nxxcFYyYz9l90LyB4X/v5wOZvNgCIiUy02VB8uCbPRJ9Rhr3Bsq8R8IbszE23sb
	co1S9y8spheq5RKb0YnHR3sEhy94LbBc=
X-Gm-Gg: ASbGncuFt/g714Meo0lHKj1W0W3dFyo3lqaaZj78pJD/pEu8bbTSaCWjicYQIU5Lyxr
	Lhmb5OEwS+v8aAEsbVPAvqPIt+z7C5bsaYrnjvOLHzii2gd3qQyUA7R3xHDG4kQFHcVDnPiEI+N
	WLMGNOb0Qlgfw/ChndkBcgcB8KUoLWJPJJcwMXMyylnI9mqKGIxnkZt/CiOYhRDn7ybQ==
X-Google-Smtp-Source: AGHT+IGO7eQfRhqnrOUxAmvSFJk7Ah7mZwQNryIHHzH9BjUYgJEuZ24+5WD1Ak3LY+31clbQZHy+7iEIEyYY8kYK0dQ=
X-Received: by 2002:a05:6871:3a8f:b0:2d4:e420:926c with SMTP id
 586e51a60fabf-2e3c160e63dmr2353175fac.0.1747408977239; Fri, 16 May 2025
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv7q13m15.fsf@gitster.g> <ABFDED43-3AC7-455E-9736-A8D9AC0F3A40@gmail.com>
In-Reply-To: <ABFDED43-3AC7-455E-9736-A8D9AC0F3A40@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 16 May 2025 08:22:44 -0700
X-Gm-Features: AX0GCFsDv9JEdsLk_XWi44xzux767yDlp15_SloEG3-ZWuFWnwqeSbp43OM4R2g
Message-ID: <CABPp-BFKrgB5_rMX=i0t1Dvj2XwEoCS71+QAFY=hcTnyDnOr7Q@mail.gmail.com>
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:07=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
> > Le 15 mai 2025 =C3=A0 11:56, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
> >
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >>> -        grep -v -e \# -e ^$ work >patches &&
> >>> +        sed -e s/#.*// work | grep -v ^$ >patches &&
> >>
> >> I think we could just use 'sed -n "!/^#/p work >patches &&" here
> >
> > Or even "sed -e '/^#/d' -e '/^$/d'" ?
>
> I=E2=80=99m probably missing something obvious, but why step away from "g=
rep -v -e ^\# -e ^$"? A one character change from the original ;) If we mus=
t go with Sed, I=E2=80=99d prefer Junio=E2=80=99s construct (combining, wit=
h obvious semantics via "d") over the sed|grep pipeline.

:-)  I made this exact change to make it be a one-character
modification of the original, and pushed it up yesterday
(https://github.com/gitgitgadget/git/pull/1923); I just hadn't
/submit'ted it to the list yet.  I agree that every suggestion folks
have made so far is better than my original proposal, but I kind of
prefer this latest suggestion of just making a one-character
modification.  So, unless folks object, I'll indeed go with this one.
