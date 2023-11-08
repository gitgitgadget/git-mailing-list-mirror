Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A651366
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4HF7kBr"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAF18C
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 19:30:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50931355d48so8697627e87.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699414222; x=1700019022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoereG3YviCakfqPBzk+JTs2yxcsL2E3tpw0uN5esIU=;
        b=l4HF7kBrdCNPDfljnaqz7qLkbL8WuTh0mQN/aTfpvuEHEwW7Pfpi6zUrxuBL8iPmp4
         ILeyne32M14YwyRdtF6INiLri7IzLCWin/y4gVUR/hXbc13Zyncl+aTDtByT+AYDMJr3
         OVUCKgUDwwHd+rIWLnNbW4cmEnvc1HnpO7s28Fv0RZmhVBvzxEMnlzFOOQ0rNmZnsQbk
         rMtchD2miKtl7ubwP63nv09bboQ1wEil1IjgOx7dCxSlHZ3oCYcSaWtbOfN7SGa3F9GU
         tCsiUBDVgIis82DsFhzrDa5j70yf2kBt1t9OzJKn3Jqya9qI8tiCfJlzTmi65GKjK6w/
         M5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699414222; x=1700019022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoereG3YviCakfqPBzk+JTs2yxcsL2E3tpw0uN5esIU=;
        b=vY0J+9UCOMVMTA+FGJpQIJYG3sNjb4MPeyOqjrbi+2FAQXXLfQZb9bxC97pPYnVdWq
         4vUU7l62WuL7biqmo7m4M8EQVAEc+/aibeBpGcu+9HwW51T3HSQ1mc6+I98xhgo4ybX/
         O1SJe5BZ+wmks6TRIG+SzC68SpBUHP1JLPfpU1iOlCvionvVnQeEdcvK81kpsr5jggCu
         /3+C2nvgr0mtRt2LlQo3Zq7P7ub8pXXx0tMxGaC5XyWQbPAiZtDy5ZxKeWawuHygkcbh
         gz4YPWnV25wwTkn4GM8qmVkAFJS6ZpQ22GwqGdz8wDORq9on04uysTrhyFDSHBdInY7E
         Uj5A==
X-Gm-Message-State: AOJu0YylbZovSZzmsxeGpna42TGSSBDJwmAOz977Ad9akJINh2LyrKxC
	DFocjAdI9zxpBlsJ4fC2PWuwKZCYFzsgTsBGi8A=
X-Google-Smtp-Source: AGHT+IEBpBHuYvFC3tGaEKMKQVEDz3CVIcST713mOktTaOunPxSinfzCOd9fb+249Lvt6Lt/JmYjhWaEKcqg073j3NU=
X-Received: by 2002:a05:6512:2391:b0:507:a8ed:ee0b with SMTP id
 c17-20020a056512239100b00507a8edee0bmr364876lfv.65.1699414222083; Tue, 07 Nov
 2023 19:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
 <CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
 <xmqq7cmu9s29.fsf@gitster.g> <CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
 <xmqqttpx828i.fsf@gitster.g>
In-Reply-To: <xmqqttpx828i.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 19:30:09 -0800
Message-ID: <CABPp-BEgxKn3QvJQ+6L3Z1RN1im=c3dfApLRCrQqum_Yim44Gw@mail.gmail.com>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 5:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I find that marginally better; but I still don't think it answers the
> > user's question of why they should pick one option or the other.  The
> > wording for the `--find-copies-harder` does explain when it's useful:
> >
> >         For performance reasons, by default, `-C` option finds copies o=
nly
> >         if the original file of the copy was modified in the same
> >         changeset.  This flag makes the command
> >         inspect unmodified files as candidates for the source of
> >         copy.  This is a very expensive operation for large
> >         projects, so use it with caution.
> >
> > We probably don't want to copy all three of those sentences here, but
> > I think we need to make sure users can find them, thus my suggestion
> > to reference the `--find-copies-harder` option to git-diff so that
> > affected users can get the info they need to choose.
>
> "in addition to paths that are different, will look for more copies
> even in unmodified paths" then?

That's much better.  I still slightly prefer referencing
`--find-copies-harder` so that there's a link between "copies-harder"
and `--find-copies-harder`; but this version would also be fine.
