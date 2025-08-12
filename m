Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36629994A
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018815; cv=none; b=tb/jXJKQdLcIJiBSVhVxHTR6tR+6OmBWRRjRtZ5IRnyhLMzApWLtQx7VPbnzNToSVDHQxrfvYWMMnXSeLMEUE89bw3uqSx9YU1S2274RbzDtg/Vd7qyNYD6HWN+sXNidxeTWmD0QAmG8+Lp4g9RKBYAmwGvRkpHl9syjpQ9Xo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018815; c=relaxed/simple;
	bh=0ZEonjQjzC724v++IsvhFxmFD7fZ1aLdVOOegJuMsfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX629kvA2jVhRkigkSq4rniQa+UY1/RAm2Rdx3oP+KKbV7/VIElmH2ovggWY4KGca06ylH5s1XqeMnLEajhzQdVPHH6NQE4asSIMTmOoLcYgKCoZ+YOcThsw202zasRXOHBZkw7FvAW0511N96LetDVgqFjBHTyWm0G606y6pJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7096f5c5bc0so13162336d6.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018812; x=1755623612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLdGLKupuxAIods8+K0cjbLXOj1uGW1awjk/y1aLn3k=;
        b=Jawz57wIuQUPkQKOntEyPcmm07027Uon4zhhB2NP7nvw947FPG6hl4/LgCdiVhjW4G
         9tQJaQesG+4yjHEN5ar9T2+mcGafCOXsiX5gO9kKpj9k7aXwUvK5WpGPV74AsEW70l4o
         wgHrgmnCErQXNtLS0MDTeam4wV3u8QCH/Q+sK57dFOJVDqp5PRSU1zs8AB/8wPWl3VHB
         NoS9DlyEOBlJgzuQiYEa25xJIgyOA9UxOHdCmuWewfX5s+KNETBmLdLC7YZMsTrjP6ct
         KRUAMjwn75PKW66mHQwoq4ukEKFnkwAK7c9svhsoBEWuyZtPn2LR4kDkTNqFNeL2waCd
         8/Pw==
X-Gm-Message-State: AOJu0Yy5DQRXeOIaY/0VQyS1HNnlPmZ0JuXh17D6TKTY7QuXLi/Nx9U4
	HYJiwY3VXFOwtcDwY4N/HdMZdeWvn0TWS6MeENV4J7xMCmYspKWaCXy/13EPXUJQfJmy/w5jNXy
	rln9yD9tUdL7xes4ETlwIbZTDrMCzK6I=
X-Gm-Gg: ASbGncv4AWAp5mwSiN6VRDmbldp4Sq4Zpk8WXm//X58BznyTASNsnfeca++sal6zHJf
	rtw+d3f5e1Si3f+15Uz/VeVsPrb/MtyfDiWkkRFr8//99MIR69sM2X2cjrkQ5gkfaRQ5UU0sj7l
	veHhwUWcV3NGDevRFd6rv3yp7l+tsoGM1A8OUkyPSeQGE5QMDyHaoqjRbbxdRya2oyrAmbblJXY
	w+NBNOUfNa8FUhNa11/Y0jnyKZWgSuKJzSzLS7JZ1RPAzTiFg==
X-Google-Smtp-Source: AGHT+IF2psJtTnbdnI6rbXLcUVMX2Tyqwnwu+4y7XX+y6lvuIL4KcXiuMQsJ5nOhIHz+/oI5svNTx7G3i98Eq/RzhQc=
X-Received: by 2002:a05:6214:dc5:b0:709:8751:2ab8 with SMTP id
 6a1803df08f44-709e221ebb8mr12936386d6.1.1755018812375; Tue, 12 Aug 2025
 10:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
 <20250811221706.67168-4-ben.knoble+github@gmail.com> <CAPig+cThhm8b2vE=vAHYc5cEA9n232Lwi1c+p=LV9hK4hz=0Hw@mail.gmail.com>
 <CALnO6CDaHZuC0=_Saccj3DuW-vaWs30PmwXf9dw1+AfsC34wWg@mail.gmail.com>
In-Reply-To: <CALnO6CDaHZuC0=_Saccj3DuW-vaWs30PmwXf9dw1+AfsC34wWg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 12 Aug 2025 13:13:21 -0400
X-Gm-Features: Ac12FXxq3cO9kWDxNtf1xv5FJhc1cUDhoJF4qntJ_z5AxPmviebaiqxj_aJGnCk
Message-ID: <CAPig+cRRBDqewrqUZGS=EPJgSkYmX-zD_qrqbRXzXq59Ub2m_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] t7005: sanitize test environment for subsequent tests
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:41=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> On Mon, Aug 11, 2025 at 6:34=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM D. Ben Knoble
> > <ben.knoble+github@gmail.com> wrote:
> > > +       TERM=3Ddumb test_must_fail git commit --amend
> >
> > Don't use one-shot environment variable assignments when calling shell
> > functions. Instead, you can do this:
> >
> >     test_env TERM=3Ddumb test_must_fail git commit --amend
>
> Yep ;) I had the latter, switched (see range-diff, I think), and then
> CI caught me. Why doesn't the local test run catch it, though?

Although the `chainlint` linter gets wired into each test script, thus
is invoked automatically when manually running any individual test
script, the `check-non-portable-shell` linter does not get wired into
each test script, thus does not get run automatically when manually
running a test script.

Almost all of the "lints" performed by `check-non-portable`
could/should eventually be folded into `chainlint`, thus eliminating
this difference in behavior, but the
"shell-function-one-shot-variable-assignment" lint is an outlier
because it can't be easily localized. Specifically, whereas all the
other lints can operate just by consulting local context, that one
lint can't because it can't know what command names are in fact shell
functions without looking at other test scripts, as well. Hence, the
operation of check-non-portable-shell.sh is two-phase: (1) it first
scans all scripts to find all shell function definitions, and then (2)
it "lints" each test script individually, in the process consulting
the table of function names compiled in step 1.

When you run a test script manually, the script triggers a run of
`chainlint`, but `chainlint` only knows about that one script it's
checking, thus it can't compile a table of shell functions which might
be defined in other scripts. Obviously, there is no technical reason
that this couldn't be implemented directly in `chainlint`; for
instance, `chainlint` could detect other scripts which are pulled in
by the script it is testing and compile a table of names of shell
functions defined in those scripts. Eventually, I think it would be
nice for `chainlint` to subsume all the checks performed by
`check-non-portable-shell`, thus eliminating the latter script and
(hopefully) speeding up linting altogether (at least a bit) but the
work to do so simply hasn't been done yet.
