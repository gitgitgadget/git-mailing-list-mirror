Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AF6A346
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338263; cv=none; b=oDUNVHAblY3ZX+X6lXgUIatPZok8DBzpjIpr3mkLHHn0dv2Dwt1dVmU91FKaGj08uoMmIpbbkcVh3chXpLUuUxHpdnmviYpJPAFQUxOanmXdf3LombsiI56WreL4Tlsy/JZXdYmO+f4zZLbSTFPMljyyQTIPPawdSTfcUYu0pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338263; c=relaxed/simple;
	bh=q5s2dJNBK4BZcdTJA7PoaP11gjk2h2esHdhFl6e6MSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgehEda2vscwt27tmp7muNZ8YHbxTiZ/SZPwRCCPDK4y2LpDH3rq3fi/94n1JJDmmoGo2Y3pjVWNcKxoGytZX2wKmuHNTrOaNywFM1f15yX8MGtgfuLdWUu8E9ljYr8nun0XeOLblenZEIHjYoB7Zky3GGbz+pfiaaPFnanA3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b0f08a877so27241746d6.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338261; x=1713943061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u20GOtsvDlkiO1S9avLFFJOmdikkqlXvFFpGvaKGae8=;
        b=BWFyazQLlQqMfl/5zD8NoAwjXbmLzoTVeYnsQj/YQTELFrAMzzG8w3fu8RhT8tdIdV
         fC0S8geEXkE/WbAVqQ2CfWqoJ49eaoQyJdvTpwgYC602/EKeoCZCu7BLGX/umVquL/Fw
         zGhHpNfhlMxHNmTW0tSeTVyzVgI2eeFg6Y5irJ4H4BFqSJAsdAy/WU5081JSesOHx37j
         BeSXmtgGl2x8qgqXOwFQixwBhYEgx3yi1S+rQPQKcMCm8QWUbY35CrS0XRaO4osL8Qva
         LeYwvbGO8V8A9VlFCLNx7GoX87LQretm5ERKWs5n61rr1vFxaGiFRETiOI9o2F8do3Xn
         VK9w==
X-Gm-Message-State: AOJu0Yx9G0CIciVqcnohiyWclA4ocS4gKVrmoi1HWLKbHaCpBW07HHxM
	FJW1uMVPh4xMMmcEWE7B1yuzGvhFG/SJ90iCNKcw4OthMaI6c7foXSoKcz+h3TgFIEW3WOKkKI+
	4KfmUF1KTeGYadR0poHjJmbxEVEU=
X-Google-Smtp-Source: AGHT+IGfG3l8DlgtRpFuMdY+NZqRTRu/dXz7VIjMXESW20xNlLgiwcYeKmIoA4Fy2h1Cxl0hqWVymR/kf/j7a8pDXQE=
X-Received: by 2002:a0c:ee8f:0:b0:69b:57db:9182 with SMTP id
 u15-20020a0cee8f000000b0069b57db9182mr13714012qvr.14.1713338260806; Wed, 17
 Apr 2024 00:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com> <a0b93341380c2157f6b87e19129abb49@manjaro.org>
In-Reply-To: <a0b93341380c2157f6b87e19129abb49@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 03:17:29 -0400
Message-ID: <CAPig+cRPUQW5ux7oKwDO5Nu46fRHrs6LrUoxnFvX9D9oNjqteg@mail.gmail.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:05=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-04-17 08:35, Eric Sunshine wrote:
> > On Tue, Apr 16, 2024 at 11:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> -               die(_("options '%s' and '%s' cannot be used
> >> together"), "--subject-prefix/--rfc", "-k");
> >> +               die(_("options '%s' and '%s' cannot be used
> >> together"), "--subject-prefix/--rfc/--resend", "-k");
> >
> > You probably want to be using die_for_incompatible_opt4() from
> > parse-options.h here.
>
> Thanks for the suggestion.  Frankly, I haven't researched the
> available options, assuming that the current code uses the right
> option.  Of course, I'll have a detailed look into it.
>
> > (And you may want a preparatory patch which fixes the preimage to use
> > die_for_incompatible_opt3() for --subject-prefix, --rfc, and -k
> > exclusivity, though that may be overkill.)
>
> I'm not really sure what to do.  Maybe the other reviewers would
> prefer an orthogonal approach instead?  Maybe that would be better
> for bisecting later, if need arises for that?

The comment about using die_for_incompatible_opt4() in this patch is
the meaningful one.

You are very welcome to ignore the parenthesized comment about a
preparatory patch. There is probably very little value in such a patch
to fix the preimage to use die_for_incompatible_opt3(), only to then
apply this patch which updates it to use die_for_incompatible_opt4().
That would just be busy-work for you and for reviewers. I mentioned it
only because I noticed that the preimage was doing it wrong (not using
die_for_incompatible_opt3()), which presumably misled you into
continuing that mistake.
