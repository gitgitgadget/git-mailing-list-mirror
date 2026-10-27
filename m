Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114400;
	b=nt2Oyz3DjQVXQeVSNqH3Zebz3FFYqaMuBNSKQQE5FUT4ayVGH5LLXPTkpZ+iIpXKXf/o
	 dUuhGw9PFzUPV4gzK/5sb64kQtVpcES7LPrEl+0U2gkoSGRLdt09czIM1zRwmmbNoypT/
	 pqgSqhH/EEFPg84n3qu0SOfBGqBTqoYloEOK7iEZ03vidcdJmgI02KoyxXaFCj2VW8Lzy
	 VytwpEr3OJ+oBVhtwrpO3iFoCkNav/fNl6swhVUVj9/32NIv3z2WyDlAkgLQw6168TVBI
	 pw7KsMCwPX+oCZnrdM/tHY3rOU0GrM3VchphXqTvk12wNSozVbaosVktcbF3g7+KzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=lyiy9YF4KQZRgwzGgvGGO+QMBNkd6cDKFLXnzTXxOdQ=;
	b=QXQfj2Bx7nK2to49j8jk9Q/+dWU6DNaIlKPFhee+kV3pBLDBXxNcMhfMwwIcLbrP28in
	 sYUvupyFKj9RAA584dv+1HbaNmQaD2BBKFSa0KACostdPJL53iYYWbjLdBeW7T9gGRsaU
	 ax18o6vfZQIva9vTdss8AeScahGv9yV+64ni+CYf8GyvNbcRV3GLNCvL03Glv+PClLDUi
	 6c9ulQflFFHMz/pmitmG0BNY0finMO9hFbjCq71V7P/XYwOx1aNd08fHM07nM4exm4W/d
	 ArDE1k+cOrc1jVEzPkb9dknnxVQCkLZD4q+c2zDJXHUHP/qucmx+rGD9T/2O5Gsi79w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y2h2P/zm";
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE915606A329
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE915606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2h2P/zm
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67583c777abso1508258d50.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114399; x=1793719199; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyiy9YF4KQZRgwzGgvGGO+QMBNkd6cDKFLXnzTXxOdQ=;
        b=y2h2P/zm9DqGuJb0XgLQ5PN0uTkjh3LGSgFeWEVi+wzLlIa5bfcJn2a0sekWPvcRS9
         TRhJKma3h05OZ/+IQWQUDla8Qj2wpyZjke0MtGory+XFVwLOyHQstAnPL7/Qw0EzZAIF
         F9MTE9tqLSHKhk0acYNoB5/ZJE6c61e1qj6ATdLi94/5mTVSvYihE71MnPcZX9+0vLRA
         xRkWZvwDsfL3KKWpqTlPIpQcsEe3Q2tdL99XtQjigq4WoDeBWLQuUrkdZhNv6HAi+x+u
         Ru3fyYe3GdOJUItaJ2me/yAsaLD69VBO+z6h6OmnODuJ/VMGz10bF2h50iMZfEeXTphX
         ykwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114399; x=1793719199;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lyiy9YF4KQZRgwzGgvGGO+QMBNkd6cDKFLXnzTXxOdQ=;
        b=iQe76iHrzf6dopP0dLlX+Ok9QKg+vIwvUrj0ZC82g0QZgTq3aigTs47DvzS0oM5moW
         5CrEbA3mGelc55sVkh6zZssIHKNNbgQ6JJfESROiOSJ5fv+xYLeD0jVy2wbz9SAx28uG
         0ysspDuI8MeeP3feGSibZ0kqePW6yA5vhpLe9IKumosiQAWP5rlgHomHvCCjf/6DlVUz
         KwbV7EMDMXdfO98uPCyxfwZH6WcywYihkgEfP1uJOSlspFlsfNQFlD0zzOaLK+gkdrqF
         IuUbIcUQrU5YRx38uvSrvdOZ0opmcC3B7XAY0/oTA+YMClrfZYv2mZRj8Skc6dtA/G0v
         dbjA==
X-Forwarded-Encrypted: i=1; AKwUvBwIbc7UCswLWAgxXD+fvNdBLaB6/CI92Pymy0xjz4s8bj/3tRzfcFztJ6hR19YZoUMY35o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPt2U+BOikFX+TZf7nGPcab9VZynhiKdWiShoLJbpBYYlU/hnh
	beHtBzIluWZIVFnLaC7xzfKzmWkepw3CIrxJdSx4DVeyPn0GTlVCFEv1
X-Gm-Gg: AYBFou1sqAtNVIir7b3InV/JhuRsFSsv9ZB7Ez/hkAMSbNt+VGAL35soP2UzKTk3GTj
	AR91i9FQ4i6HyxXsfJxW+4TW5RU85HnUy88DdHOZiws+2tMVAN/12/NAqMp5jI7qfG+a7QsLvXB
	7UaZMCxe/O4tM5Os2LywViRpymiyheN+UOs8zZWJZ/WUkzJT8VD2n+KUHWHvfeiRhoUit3mh0Vh
	b52GAIvzB3+QeFT0yPpYFX2/fFz7Kel920k0o7VxmBPVxXGTXUDlBtZN6j2qTWDxEUcixUZ1v/j
	pkFc5DSqov2JgJPmfGODxNA0yM0VyhY/+ht3+Nod6Eg58Y4ZfKrFvy18CHst1pohH3lpZC0QPit
	AwMf64KAUbKtBxjSxJfbc0SY3EfJhKQyaXiC1EmjJ7NYT3t1lqsLkXMZNHCdOmsqxW605q1AkA6
	SW/Ckkwj65lpsXzOVX5A6r8H0Q6ckJaw7g/NeKDZ0Topnc9SkI8g2oEafaqWuPSH0o7WaQVQ0qB
	JaVzywS9bfU8UgX/9E282BLoPWOHorOYSzkhFxIETl13Co2gr0QbCwLe2a53OM4pdc3ZURx//ok
	/ANP3THbDpvFAjGRozdq7AOAqMBbAqi208ss579YYBdAGotPXC23sGFsk7nhH/pTs/UqCy+VAO+
	J6++8PrJF4l6gBJyxskxBOm6oryrjag==
X-Received: by 2002:a05:690e:dc6:b0:679:bfcf:a0fe with SMTP id 956f58d0204a3-67a6df14740mr2207328d50.18.1793114398744;
        Tue, 27 Oct 2026 08:19:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:4455:c602:9aaa:33ee])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a79f38dfesm327851d50.1.2026.10.27.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:19:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/2] doc: add new git tutorial
Date: Tue, 27 Oct 2026 11:19:47 -0400
Message-Id: <A48F72E1-8686-453E-91EC-674BD92CA1E5@gmail.com>
References: <e7a03372-56cb-45c7-ae32-68b3c9e6bd27@app.fastmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Tuomas Ahola <taahol@utu.fi>
In-Reply-To: <e7a03372-56cb-45c7-ae32-68b3c9e6bd27@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (23D8133)


> Le 27 oct. 2026 =C3=A0 10:30, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>=20
> On Fri, Oct 23, 2026, at 2:01 PM, Ben Knoble wrote:
>>>> Le 23 oct. 2026 =C3=A0 11:17, Julia Evans via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>>>=20
>>> =EF=BB=BFSo far we've gotten 112 comments from 30ish beta testers who ha=
ve tried to
>>> learn Git for the first using this tutorial. Most of them were able to
>>> finish it successfully. By far the most common piece of feedback was tha=
t
>>> people want to learn more about collaboration and branching. I've writte=
n a
>>> draft of a tutorial on branching, but this is already quite a lot of wor=
ds
>>> so definitely we can't cover it in this series.
>>>=20
>>> I don't know if it's possible to get this merged quickly, but if it were=
 I
>>> think it would be amazing since people are so eager for a tutorial on
>>> branching. If we spend a huge amount of time revising this I think there=
's a
>>> real risk I'll run out of funding before we have time to write about
>>> branching. Ideally I think it would be great if we could merge a "good
>>> enough" version and then have a way on the website for users to give
>>> feedback on it, so that we can later incorporate that feedback and
>>> iteratively make it better over time.
>>>=20
>>> Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and all 2=
0
>>> or so other test readers.
>>>=20
>>> changes in v3: (v2 was the "first" real version since v1 was a WIP)
>>>=20
>>> * Say that the tutorial supports any version above 2.23.0, when git swit=
ch
>>>  was introduced, since the next part of the tutorial on branches will us=
e
>>>  git switch
>>> * Mention that on Windows the tutorial will work best in Git Bash for an=
d
>>>  it might need adapting for PowerShell. (thanks to Ben)
>>> * Add a warning about how Git can dump you into vi, how to handle that
>>>  situation, and how to write a longer commit message. I tried to strike a=

>>>  balance between lightly suggesting that it might be good to write longe=
r
>>>  commit messages, while making it clear that you can just use -m"" if
>>>  you're not ready to navigate the world of editor configuration. I don't=

>>>  think we can use Pro Git here though since it's a bit outdated. (thanks=

>>>  to Ben)
>>=20
>> I noticed some discussion in Discord about the main text being out of dat=
e,
>> but while the appendix makes copious references to editors
>> that have fallen out of style I think it also covers common cases
>> like VS Code and so on.

;) long emails?

>>>    ++
>>>    ++Warning about terminal text editors
>>>    ++-----------------------------------
>>>    ++
>>>    ++If you run `git commit` without any arguments, Git will open a
>>>    ++text editor in the terminal for you to use to edit your commit mess=
age.
>>>    ++This lets you write a longer commit message with more details.
>>>    ++By default, Git uses the `vi` text editor, which is extremely diffi=
cult
>>=20
>> Personally, I=E2=80=99d drop =C2=AB extremely =C2=BB here to avoid castin=
g a judgement?
>=20
> The goal isn't to judge vim (I love vim!), it's to make sure people who ar=
en't
> familiar with it know that it's not a good idea to try to figure out how t=
o use it
> in the middle of a tutorial on how to use Git.
>=20
> It's almost impossible for me to imagine someone successfully learning vim=

> when they're unexpectedly put into it for the first time.

I too love Vim, and I agree. (Well, I sort of did learn both at=20
the same time, but I had a lot of free time as a first-semester=20
freshman in college=E2=80=A6).=20

Anyway, I think since the goal is not to judge, I=E2=80=99d still consider d=
ropping
=C2=AB extremely =C2=BB, but it=E2=80=99s your call!

>>>    ++2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`
>>=20
>> This is probably ok for now. Long term I encourage folks to set
>> EDITOR and/or VISUAL environment variables, so all
>> programs know what to do, but shell configuration is way
>> off-topic here :)
>=20
> Yeah. It also depends on whether the user is planning to use a terminal
> editor at all, I think some folks will choose to use their IDE integration=
 to
> work with Git and so setting EDITOR might never become relevant in
> that case.

Well, if they use their IDE=E2=80=99s integrated terminal and run a command
that looks at either variable=E2=80=A6 ;) Although I wonder if some set
those variables in such terminals automatically?

Regardless, I=E2=80=99ll let this one go as it=E2=80=99s off-topic as I said=
 =E2=80=98:D=
