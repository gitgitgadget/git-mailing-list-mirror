Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C22F6188
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696706; cv=pass; b=sDnBzyhIJdxbTvU7NB24/x8yxPRJhasma9hasp6PXsn5fSZA9CuqpKlT4dpb2F42OSPu3dF5macs4Zv277fcxoyaJYwJwzY0oLBsnCXdRiJzsaSGtKkkdn+EoRK9mIZNg09QD1YNDWpeXMtGtLg6Y77WuNgJo80wrvuEhm6u1YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696706; c=relaxed/simple;
	bh=AFQ/c1cNknOJqsLeRmqS4Pjc9qLiH3vFf/hXCc7j77g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDk73n0e6SWPXt3NCMfjLpsVx6QztpxzahF9a8bpkRULnvRMIJ0rUhHMofp9K8jvG5LTTVykw8wFSLxgzf2rpez5Q+EwMolLZtApeCLnlYLS7jhlZluztWSl+aKd5V3VZ2w0GNhSEV+0J6liTC/IK2ZnjhpWQEy7Qj87YZXBPmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pphI41Wr; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pphI41Wr"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-688a8e5fe5eso1493277eaf.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776696703; cv=none;
        d=google.com; s=arc-20240605;
        b=GqYwUVrj6CZV9x7yqPPsyhTPJXtYy3uCAcfcGNqI2DQXFExT4nzo3Eet7r0Adx83jO
         kqAOcgxBkZ4QWmDCPI9UJ9BFWiXn87PuPPjqvRAxUyBbGJ18AvBxca13lYhBgUF88BJY
         kjXgrKAO2NyKmOpTIO47b3MCSn+swYiWqUtzGiiDxnP28cgbgkxuON2UK7AMHZAnBzYk
         lIPq5If9rk5gRVfQXNUdBsKc0d7kasJy6XEhvbp1La/qyq3pq9MpNUrvH4YkcluP3i47
         NVDK04IwDdojm6r5PF5t7tmasDXHXH1AAoYnJIokesNYM9GnPLifMf/Ia0sX5qhxoZHh
         9QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mi3YN2RmI5Q8Fh5mf8VHyvrGMV3tcGuJkg1H1sfkwiI=;
        fh=N+xGYu39Hzikqwi3BJgDM9PrlRRdfzs2vhr8Q8RthV8=;
        b=LAZsE3IIvlnOtQEQD1H83yqJ7II+FJSZZNptqeC5AqhAvzOo+pHYclOoXJ4fAFLE20
         y5aC78flYjNfc08STmXogLmgsh6dvAbkwdsYmQsjBHvRFtahbta7QqE8lvnsWbz9BYHt
         dBQxDVdhMpZJjYswFBrmkIs7gfO16/oLF4qYDYucgeWElKmYEsBo1azDIYzFLyL4C079
         CIGO6SEiIkxiYZwJK+fdnBamxSne+7fdgsZXq+zkVjTLqtndc5/hFhKe4VTBT8Q0QUfQ
         RQemxVAY6xEtFgE1Q8WVbAILsp7KgQjADQKAfGwJWY7bBjasRnqy2FLbiNVQxDfWQbKT
         kzMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776696703; x=1777301503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi3YN2RmI5Q8Fh5mf8VHyvrGMV3tcGuJkg1H1sfkwiI=;
        b=pphI41WrrXnEMlloBSwU01/rsMH2wfzM2eETQUSQr/WKPJRhk3Ek3eamjXNWPT5P5G
         7Pj9IfFg3aI8XpbiqYGIjtxQmqpq7cilA3T2TiKfqbDOcy2jECiXlo+V1wDpJz02zhj8
         171n3SM75O5yFl1OuZjj7SeZh1ghrAs43yq1YQjgw3FwmBbcDskGfsaJ1Xi7ufFhApsy
         lnOpMEiLiWbjYXqAGcixUaPjkTdsgwy3vCrof4wRbDB+W/jfeFpHbuzdM4El5+U1eLMV
         +U7q5kUSVDWLzGV/kJxIsSWrbGlgklphhPvD3aDDQIc7P/LVpwFj6XrK17AbDEGsjx/k
         zA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776696703; x=1777301503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mi3YN2RmI5Q8Fh5mf8VHyvrGMV3tcGuJkg1H1sfkwiI=;
        b=mSWzdC3pdmKQU6QRJt3Hzx2BUkh/OKmiVQd9nFw8WDUWer3M/nMVJlqFXEzeHP7e7m
         vO30ubYbZrKorFQ/ch91ybSEelvcV7At2Tg/sr2FapTQv08uZ6XSZmePrsDQF+0Z4aNY
         RURg+0LDovjvdeu1365msetQ+slFjWgBVLxRaHIdqxTLJb9NhwXg70ng3ATA4ldPS1yU
         dqivuT+fDivsuRTMeq1OTaaJnmB1YdaiE77gyMLOJhAgHjt3JwD9yesfPG+ntfm++Ivu
         U0b8k+LSc2qDT2W7VJ6afK2vlOn4WFt7gudsiAhGRH/qAJD/pKt8tH5sjWGQpR8perIU
         SwAg==
X-Forwarded-Encrypted: i=1; AFNElJ/ehmm8lMkg2Q0S2rAMW5hJg6j423i6wMP6ArjlrI8+iD/RqLFHbCd8Qoi6C4SqyRO/V90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0D1pPttsMn347G0VGuDHrURFUoSqdQeWk3pOGu9Ca142viTD
	qKmyCujBdqY2Y3y/Pf98pLoXZqWDRRCck92WCEKf9WoNuYHPLG9geRR3gSphraoLjivJJRgoW0W
	IRk9x3Gqrrsgxuy1+fggVdBdyOwlSAkU=
X-Gm-Gg: AeBDieu/zzlqWgGxiGZu4ci6F9fXICHQSm086zAVOzKXB2emuuYBx9rivJLGKn5cktn
	oyCQLtvW0cMvZD1kAp4/FoYDRuzE9OAHInPeiu1C8uqpcZWRwr1Xlpu3Noexp0co7cAemduC4E7
	Cx68D0EjFMlDfPJEjUON/8N1sLie/ZrMhzSj0TLdKJYIFNAL6iVRdmXRT02mgHbp4nBu+34CfOp
	D40rq/fZqwri8lGCGqMfERJf5/cZiV1Y6+reWhE2XyJSCl88HoWN6HfP9hrFzxIbWdrAQL/biD4
	Ewmcp1uqXwwPiyu9m/BajAeCPZnRtBTbjxgMoflsz41o4K8/IB3UYIK1b7IuGPiGiYKwlbT/z94
	n+2wGHJB2sUG0h6srgDYd6cbGlZOwV6cbySrV
X-Received: by 2002:a05:6820:62a:b0:67d:e619:5c5a with SMTP id
 006d021491bc7-69462e48395mr7861219eaf.16.1776696703599; Mon, 20 Apr 2026
 07:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
 <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com> <aeVqqsdq9B7GE9gS@lorenzo-VM>
In-Reply-To: <aeVqqsdq9B7GE9gS@lorenzo-VM>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 20 Apr 2026 07:51:31 -0700
X-Gm-Features: AQROBzBhWTrfo20WDCvRHYJytFPilqrozfiu4M5QplucpM6zwZLpw3AkHDmOj6o
Message-ID: <CABPp-BHgnyS_SB6SX1dzAezfExomHts1t02+qr+duCPW6sk1nQ@mail.gmail.com>
Subject: Re: [PATCH v2] diff: fix out-of-bounds reads and NULL deref in
 diffstat UTF-8 truncation
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 4:52=E2=80=AFPM Lorenzo Pegorari
<lorenzo.pegorari2002@gmail.com> wrote:
>
> > +test_expect_success FUNNYNAMES 'diffstat truncation with control chars=
 does not crash' '
> > +     FNAME=3D$(printf "aaa-\x01-aaa") &&
> > +     git commit --allow-empty -m setup &&
> > +     >$FNAME &&
> > +     git add -- $FNAME &&
> > +     git commit -m "add file with control char name" &&
> > +     git -c core.quotepath=3Dfalse diff --stat --stat-name-width=3D5 H=
EAD~1..HEAD >output &&
> > +     test_grep "| 0" output &&
> > +     rm -- $FNAME &&
> > +     git rm -- $FNAME &&
> > +     git commit -m "remove test file"
> > +'
> > +
> >  test_done
>
> The only thing that I don't quite understand is this second test.
>
> From my tests, the previous code using:
>
> ```
> [...]
> while (name_len > len)
>         name_len -=3D utf8_width((const char**)&name, NULL);
> [...]
> ```
>
> passes this second test just fine, while I believe it's supposed to
> fail.
>
> Am I missing something?

Sorry, I did two things wrong -- I forgot to specify that the second
test only fails under ASan, and I simplified the test too much such
that it doesn't fail under ASan without the fixes (and simplified in
three wrong ways: not enough control characters, wrong kind of control
character, attempting to use hex control code to printf instead of
octal) and apparently forgot to re-check afterwards.  Using the
filename
    FNAME=3D$(printf "aaa-\302\237\302\237\302\237-aaa") &&
will trigger the out-of-bounds read under ASan before the fixes;
removing the final \302\237 will make it pass with or without the code
fixes.  I'll correct the patch and send in a new round.

Thanks for checking closely.
