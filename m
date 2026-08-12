Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E63440A2D
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540461; cv=pass; b=OgrKM66vE/WLu60j3JGjbwWpJyu+cAWwehI3R/1fo3Rzb8j48nLPl1gGvtDhKGTntzdV5h9n2ftGB1lUnAw9I/2/SqKLcVNZlffBLjWHA2P5GMNHVZH4osDZXI5ZjdjakefAR35PM71V6QYnuKZAdiyqzhuny7BF4De5+/eJ9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540461; c=relaxed/simple;
	bh=RnDqPxVaVaUdE+XhAa6goQBdqbSIPqPFptYx4An0NjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdSJOXM7PUqtiFTvF1Wi8bKmnUl8+PL0uGope3Y0NTKMVJ0nCOrjuzEz90CG1/C5lQRcbjK4xzE5Lu2CCM6ig5lK5NmQXxocinfbcpOiqI0wCmApMtL3ZKwUzYKiM8xnCydkbZqkBMk4FXejBuT1R4EMnLXbLrb3gwFCPxwvssY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQpaAS+a; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQpaAS+a"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1304320a91.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786540460; cv=none;
        d=google.com; s=arc-20260327;
        b=J+p3ViHK+crlZSEcgNoocNgmuON5jbyogi6b3nLQPqUreryJJe0Kegt3TdIbAAj3Ub
         4w+HhJTq6rkBBnDZrgG0bqlRKJIYR1Gw+5cK0UqK8owJ7QCyYE3VUn1CxPQej2KmfPpQ
         vlMpK+BDIGwOBLWRoAK84Kw18as7z6PiiHPyo8ok6LOspgI0XnGzTMnRzXWVjEN+jdoi
         1SJu+tqiLm3Zl/I379fXQ2hLTCZ/v9rcZZgZJ41s6lMuiSrc/hbQqsIeD+5OrZm4+/8T
         Abg8xTvEm99ZsdmwpiV1mZ0/8vj7ylFPpT184QiZjJCqFOSEbqTR0WHqrlidR5i/511Y
         GevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lS1CQ8cV8hz2cYppj5FU6Jbs9NdO/WFWuEWw/IbsPZc=;
        fh=a28upuaqsmbKM0BeErYHmWL1gPQ4T+kBRgfmZsDTZZ8=;
        b=UZDLzJsGl+BdqDdh8HvEoaClQ+vrl1L4raEuUYZr3Sv6v+Flw4XeFHvMp61KkVhyHs
         GW2PikxSqvV0fJV2D7KVBAJWE7XBy3fVg1WcjJqPWN+UmPhzJV5PpLfnzpcbWQKq4H+L
         M5zDLFfin3UqmONl3A9cvjSL723f7eoIM9s85T2UekKsjiZVNZlsAJEy+pIFXHBKFioO
         twov1NDxRdef2LSqK4mhOnbUK1YtY6uqeCv+JAu+Atud/r2EdqTRrbRE+SW26DejV5Lr
         DJp27NhtbIu3QvddpDRsWL9ifu/FSBcHTDz0t5tG1cNKW9jILTfw5OWpwrV3C4TkMiZb
         mZIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540460; x=1787145260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lS1CQ8cV8hz2cYppj5FU6Jbs9NdO/WFWuEWw/IbsPZc=;
        b=YQpaAS+aBe2XkMr4R2KICTqmiklt6abRazaA2qDNqKdI9pRPHjCHilKtNRNNe91zXn
         E9PtutrHdttcnoe5Y51N5VsPZMm04+SAuwUKCrSfYXk8BUMunZsiv0bQCNrXQ0eHdCxy
         iOo6Wb9yKbb1vZruQoF39+4aqlLDd4M08XT4i8Fh48EJ4To4NxXnyfcSL6rGOrj2uNvD
         1xEfWAqMHS3aui0pg5HMQSMUs0/2aGWpqe4X75J5TVR2PqtLx7MLjDUhee9JbtVMQ89g
         tcYEeEuWKm476NN7BDPWJyHG5tdmdIYaX6ILe5fxISZ+YR+PmQVxNBHSDBA2az3qjR5p
         eg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540460; x=1787145260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lS1CQ8cV8hz2cYppj5FU6Jbs9NdO/WFWuEWw/IbsPZc=;
        b=bI84gRePNN33ISoxWmd9mTVt7dreEieiHloPXf8vpaGoemciI1GFe8N038qq1TMP3a
         YoCbd0+io02Bj0TRrOP9XdkT9SByuYvYJQi2vhOqtVXtmXpNyphuC+lvLjnBSTbneXlZ
         27VKS9E2U0LtQ325jZCWC0Vq6+zIq845CLVNcJ0OwsYYDcWY9N+4zP1TfTjfqCaHtkSq
         dHWR01qBejJNxsG2u7Sm7dZwzeVX0SGp1U+Mcwh6ShaLzuejXdYd8MIvCqoQj6zMtU3+
         fRAEbO8VoNk+SUsVsP5fSzgjFhJN7psGIKOTMULtOXkS6rvw+kOEdKUnvwloQDhrDBKP
         pfiA==
X-Forwarded-Encrypted: i=1; AHgh+RoM/jConoBF0euzpSvp8mW+9kmwG3xEDDF1lETEaWoNhtDMQunQvzpx33z3tdhi9iJCtcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuL84mBlwNl/4XW5xIrWepmXua92aAGppIsFhwzzUGaEWhsNM
	0puRzmWzHl++hUE4cK3zj2akEJnWM4hmtNRDygCAfQI7SxLvBOFAm8JBOBO5lbo3UR0V2FWGtA4
	w2qZjlTEYHjl7VuGKzO47pBoOXzXiUVnrO4P70xDkrw==
X-Gm-Gg: AR+sD13j0+ChLJ+MLGYKQoMB8VEYLzHY/WSwBf88s56PIKF85/MzV+x4PaZZ+m3SmlJ
	nwN/ZaBqDTofXxruURY15cxhJy3S1YsGULPANfZuOnu1hfYlhsO5o52mRye9ntlK1gUck8uHOnR
	ZZAChVRopV1h67q6KzWNu8DAUfRfzCFqJ8mniwWceWwMPhHwUFUi46wJaaiUhUEmoW0zs2CO/i9
	bWe5m3kb2u84LNaMYnk3xn2qC0d5b5vO0JkdBOfHnjC2FGxl4fG7mdY+LM5TT4iF4D/iiREa+sw
	+mZM79GK18ID4Sd5dEWKyOLNWylf9iAvJWUZxozoLASZYPBdHfOA6uhyIoWxZpZ/B/gZYoBTgPv
	CXTKLMkj4npaMM9/A6Tq4OZK7YDQvSe27TkXX6d4D0+I2vCmTwSC8mqzllflg6h352RTIi3QT
X-Received: by 2002:a17:90b:4b44:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-393013f8644mr4302546a91.13.1786540459566; Wed, 12 Aug 2026
 06:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
 <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com> <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com>
In-Reply-To: <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 12 Aug 2026 09:14:07 -0400
X-Gm-Features: AUfX_my_VMdFjoWDLHyB7CVuWGzy6snymUDG4mqvB57kU1haFgEdIohRHmb__gI
Message-ID: <CALnO6CD-nWAJhaMqAPCL9NOHUtqbna6Z=RHZVrE_WfOeC6bdsw@mail.gmail.com>
Subject: Re: Bugreport
To: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[please don't top-post]


> On 12/08/2026 14:54, Kristoffer Haugsbakk wrote:
> > I have only skimmed this.
> >
> > On Wed, Aug 12, 2026, at 14:31, Marcel Svitalsk=C3=BD wrote:
> >> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >> I called `git lg` command to display git graph log in my terminal. The
> >> command is defined in my
> >> general gitconfig file as follows:
> >>
> >> # double liner with hash, time, branches and tags on first line and th=
e
> >> message on second
> >> lg =3D "!f() { num=3D15; if [ \"$1\" !=3D \"\" ] && ( echo \"$1\" | gr=
ep -q
> >> \"^[0-9]\\\\+\\$\" ) ; then num=3D\"$1\" ; shift ; fi ; [ $num -eq 0 ]=
 &&
> >> num=3D999999999 ; git \"$@\" log -n \"$num\" --graph --abbrev-commit
> >> --decorate --format=3Dformat:'%C(bold blue)%h%C(reset) - %C(bold
> >> cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold
> >> yellow)%d%C(reset)%n'' %C(white)%s%C(reset)' --all; }; f"
> > Note the `--all`.
> >
> >> What did you expect to happen? (Expected behavior)
> >> I expected to see git graph log with the project commits.
> >>
> >> What happened instead? (Actual behavior)
> >> On top of the project commits were added these four pseudo-commits mad=
e
> >> by some Git component(s).
> >>
> >> * f7b611ce - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
> >> |  Notes added by 'git notes append' - rewrite-analytics
> >> * 1a7605bb - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
> >> |  Notes added by 'git notes append' - rewrite-analytics
> >> * c2a05d79 - Wed, 12 Aug 2026 09:25:03 +0200 (5 hours ago)
> >> |  Notes added by 'git notes append' - rewrite-analytics
> >>    \
> >>     * 01c630e0 - Wed, 12 Aug 2026 09:13:00 +0200 (5 hours ago)
> >>        chatter: initialize notes ref - chatter
> >>
> >> They are not graphically connected with the actual commits, they just
> >> sit there over them. No other graphical
> >> tool (Sublime Merge, IntelliJ Idea) displays them.
> > They are Git notes. They form their own connected graph. That=E2=80=99s=
 why they
> > are not connected with the =E2=80=9Cactual commits=E2=80=9D like from s=
ome branch.
> >
> > The `--all` will include all refs, including Git notes like
> > `refs/notes/commits`.
> >
> > This doesn=E2=80=99t look like a bug.
> >
> >> [snip]

On Wed, Aug 12, 2026 at 9:03=E2=80=AFAM Marcel Svitalsk=C3=BD
<marcel.svitalsky@gmail.com> wrote:
>
> I see, thank you. Is this a new feature? I've been using this command
> for years
> and today is the first time I am seeing this.

Notes are not new. Perhaps a tool you use started creating them?

> Also, is there another
> flag instead of
> `--all` that would just include the actual commits only?

You could limit the refs to be listed, like maybe "--branches --tags
--remotes", or "--exclude=3D'refs/notes/*' --all" ? (I'm omitting
treatment of refs/stash, too, for now.)


--=20
D. Ben Knoble
