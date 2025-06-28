Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E682111
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751105907; cv=none; b=gDswEIOjUr4p1AA9Mc7/2FNMqDe39OoYxg/bBUuvqjCMzt3L1dPkG3NTk8ZrMJ8Fj9TZnnKRYB5LVp79777JgYdanuINsMmkUrsTE5+bzJDAJQlKc/bE0H2/X/DJqJ3HxO2lYrvRxYr7yQ4DY+GmmqfFbp0IFjxhmPgf9YjUJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751105907; c=relaxed/simple;
	bh=dvKNW8FSmvb5HRc6q6+iF6ZWZPwuchqpqCRewBNQDwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJpAgSmcRBKxczUDeN7pGeV9o2seEYVpyd1k2f0D39JfShvzSWltRPSBKi3ZU1mAr05ouFlQjwWoqXqF1cf+6JmPnUV0sGIa+E1uVTmMu66ug687X7WX3Y9BX7buyMkV8A8hIJtTroauEY8DBjsfcq+EfMPWwxdsCO5Da0EjOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyyvpw+M; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyyvpw+M"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so2122599a91.2
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751105905; x=1751710705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ckeaf24KKU3SfOBTJfBFEbamcbH2szc7jUlsT4W+Go=;
        b=Yyyvpw+MJW/P2JhUo4xVHMhWMcBOxX7/nJ1UIfa3En/b5Z3rEmIevcFHv8vDVhqXUP
         GmE41l/r2Plm1hSLxM3RNMPvLE4N3nyj9VohgQ6EdqMA5JTd2inwVAOvR5mE3XrQvnrM
         qKm68G8VSAiTdHoHnmX87YYv3utXYKdb990GvOPUexZuwcDaUN3t0ymWEUzywAIxqkLU
         xl6Q0uC/+48Dwb4Z+mOqSzyU256Rb9zatudL+W2+rFntukZd/4RqDpBP0BSoY7zBXDPT
         MAObKb02MiJQ/gUVrpsEfZzmgH7gCMB92s+sFyAwD+w95g/AsRG2kHPYQ25KDU9HOggb
         ALhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751105905; x=1751710705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ckeaf24KKU3SfOBTJfBFEbamcbH2szc7jUlsT4W+Go=;
        b=wA/W9dLTlFPiSb1vC6X7l3umpbejX/N030oGw6aUUIWPdbs/MjGP1ub79+EBh7u4pr
         05zSqw9Ee8gD+M/IWt6vol8/W+Z2DAIPPD0iD7ZLeWpuRLAtE2gZbsLlyB5AwAEhAf4D
         SznYZif16wjCXkTL7DzFvRyiB3OsdEBSx236zaujY6s8ihbR6DWuxJpWVAWcAv4lPf79
         4GPf+w9dBKumGbuAaNN7arbcgqAE4nBhtz9pQiBFwJmOzl2v256AZ2QbyQDypNh+VNX9
         tG02LBr0zoSutLTncG2EwKdAElF8GrEyMBacPcluo/qHpAz44jzFVYpm0c8o1KIYsb5A
         pnlA==
X-Forwarded-Encrypted: i=1; AJvYcCVV071LDrfNFkGvKq/xDS2WmiEFTc08fE+s4zgQ+gCEFZiOCed4N6nLy8yB0af27TuaPl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69CQAzP4EdqYyolbXvZJH8WYB4xiyJZjeqT7ED/0PAfFGxQA9
	FcTif/XCboGxs1a1Lz7fE8pNDzu6weGZ/ILguaw0LlSDYYNq9c4E6zC0oGevemIXwKhA087WlhT
	R38F89kKqN7bULSzJq1t6DON+ujY5MO8=
X-Gm-Gg: ASbGnctaI45vytu4pcRYX1U8kHO993bBYma1BV7IRETYj0JF7J1ai7zQHH0doOIeBV7
	QrQv3cHbyCgmDWCl6Rbo0x6X7mykUSzLnI/e02l20x4ozZHkeLPzBb8oubctosN5U8ItQCc8rzY
	KF6nnK+vM5kmC0DxZIyo4YGppgtanY1hfJj8VC31fU4nM2q/MPmzxeq/3olpTxN9GzRhLqpUANj
	wlAbw==
X-Google-Smtp-Source: AGHT+IG/Gn7C4eQJBzj2MpiG/nrprbCH+VKaj7xgFMf6AaolyBWxNgyE0wlVJcRdL7lFy/W6YhnIVdQybssTMS/Wx1s=
X-Received: by 2002:a17:90b:5627:b0:311:b5ac:6f6b with SMTP id
 98e67ed59e1d1-318c9218822mr8663986a91.9.1751105905010; Sat, 28 Jun 2025
 03:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com> <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
In-Reply-To: <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 28 Jun 2025 15:48:13 +0530
X-Gm-Features: Ac12FXwCPMV0klQk6hBJxlWGoDL0h8iKtKQMhyDRmxNEAb8gHlyeumiEuMO4wk0
Message-ID: <CAE7as+acyM4G0wHmxY3AWX9i0pSWa_C-_d3LFxXezrmkSNNsbg@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:04=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> >
> >       if (!memchr(sb->buf, candidates[0], sb->len)) {
> >               free(comment_line_str_to_free);
> > @@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct s=
trbuf *sb)
> >       candidate =3D strchr(candidates, *p);
> >       if (candidate)
> >               *candidate =3D ' ';
> > -     for (p =3D sb->buf; *p; p++) {
> > +     for (p =3D sb->buf; p + 1 < sb->buf + cutoff; p++) {
> >               if ((p[0] =3D=3D '\n' || p[0] =3D=3D '\r') && p[1]) {
> >                       candidate =3D strchr(candidates, p[1]);
> >                       if (candidate)
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index 127216f722..ccfe77af6c 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -328,6 +328,20 @@ test_expect_success 'there is no --no-reschedule-f=
ailed-exec in an ongoing rebas
> >       test_expect_code 129 git rebase --edit-todo --no-reschedule-faile=
d-exec
> >   '
> >
> > +test_expect_success 'no change in comment character due to conflicts m=
arkers with core.commentChar=3Dauto' '
> > +     test_commit base file &&
>
> If you used an existing file (F1 or F2) like most of the rest of the
> tests in this file we could avoid creating this commit and save
> ourselves a couple of processes.
>

Yeah, right, I'll update it.

> > +     git checkout -b branch-a &&
> > +     test_commit A file &&
> > +     git checkout -b branch-b base &&
> > +     test_commit B file &&
> > +     test_must_fail git rebase branch-a &&
> > +     printf "B\nA\n" >file &&
> > +     git add file &&
> > +     GIT_EDITOR=3D"cat >actual" git -c core.commentChar=3Dauto rebase =
--continue &&
> > +     # Check that "#" is still the comment character.
> > +     test_grep "^# Changes to be committed:$" actual
>
> I agree that it is a good idea to anchor the start of the message, but
> I'm not sure it is helpful to anchor the end of the message as we don't
> want the test to fail just because an unrelated change adds some
> whitespace to the end of this line. I'd be tempted to drop the ':' for
> the same reason.
>

Makes sense, I'll fix it.
Thanks a lot for reviewing!
