Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EA156678
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743742808; cv=none; b=Zro8jDICYurPfslMyRS8/aVJO6/vmUgNLIZQSLeg2h2o0utTcSqD0DVKtXKC/P31y1tWK/W5BrkuUB9I+aFX4zrUnPa04cIAs9gt8hZQHjauHCCdr7JlpPF4cA1q9afRq0zXUZSKXWRa9xBR6fo2zl1BwQXa96SBrzw9p3mWUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743742808; c=relaxed/simple;
	bh=q+0lgR6jwwA3dIY7H+UJTkbbP8gwsS2eZH7FOiYafwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCN6GiBL2kx9bHNMzOx+6dLfoHLKffNSDOtvIVEh/jm+r3UKMnuqaOxX6G7DeGUuVm8zYtZ5YFgAaDxPjV87sTn5g5EyYLvYej236AX/4/USkqDSJHPDSAjZe4uFEBdw94Wqjdw/wfG8yMmI0me3QCTmlyU098Z9EESgwxcrnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3qNJ9oV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3qNJ9oV"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b5e49615aso142646939f.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743742804; x=1744347604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fIqyt7uMa3iZytclUl58ziqvZmoiCY/bSp/0aZWDFg=;
        b=K3qNJ9oVNStoVUeM/XCvOtPRlmDLR18BPVoetTb6/LQ9soE/88usYQxxrkvqhNyoLi
         iZKt9X0WmpGP0u4Dt5UZuUFlptnTBULsO/lb7DJlK22yQmjtJxsO9iF4Q+pIH3YGoMJy
         x1mankqUguJ2Ggvdje3iytxJWj+htzk8RpVSWOkOzA9WzFC1oGexgyIR4JtZ6zzVPgU+
         5qrTOb/uSfxf80p/3Dr+wGeS2I2P0hOEjbvl1WoyLWtCIvuyzVboyqWEv9qdB/l9Gxrt
         58noBPRkpCNMTOqIxlwEy6ihLjeL4zCRwjnS18LhDfTV40DCY+C5CXbqianmiVbo8UUg
         +v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743742804; x=1744347604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fIqyt7uMa3iZytclUl58ziqvZmoiCY/bSp/0aZWDFg=;
        b=mHNdAOXdwFZs0A9R0k4QqDv5eA0ehg7ogJQ7KL/tvvQWBmZAdV6QRpxXy/yp+/kqAa
         RkFoRDHpzIcbJG1uEOz4u0fGZ+LlWj2Kd13R7+0X/b8u+aSXYZu4yKb523VJ3Pv2avU3
         NGYePBtOAsVPCX6mmwGmeALFzqqHQ4cPdiGZEjF7LDQ5NefQULSJpv1Nd4iqnflqbgdK
         EX/pEYox8k0O4y5hHFmIk9Ly/t3YaIBS0Y1bkg/O7RgUByPUbzae+EjKqLexw8ev1YSp
         yLxpTFtwm9nmSWhYp5almr8mYPiUqwkprW7d5W5rzMvMQr2LY1t/2j87GV1qP2LXhkZj
         p44g==
X-Forwarded-Encrypted: i=1; AJvYcCV0QMvuGHgDLOcg25LJUg6O7L3wVsTWMOCcKaPJywIQk+Hwj1SPSGk2RPfaxw5oqeevcRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88q9WpRr44YQ4tOa991DWOMzkvV3dxjITYA5ocHKihvShw6kM
	6X7Gju8WuJNObVuaInIa2JqivvKpfP3K9nMaOn+68171nIhlQKZ4MPrfW54JL4cnMLo7CYv70FN
	/Or/5wGm9578qzTe1sVcd9mvF+C0=
X-Gm-Gg: ASbGncv79egSGggfFB9OraQq5YOhKJ30ofJqKkHh/zHsaowkeXiMhzKSoR0gh9bgx52
	GVs20/nB83NlKtdg5Lap42BouTDPsH5S4ypEGq4vpsiKijLpIHnw/+iJP+1eYnwFHLa7lJtGIqG
	TgIL6019bdKfYLYvGAp2sN22JC4EPtXRoZBcANy7CilLCBaVe4NUgcOL2cgy8=
X-Google-Smtp-Source: AGHT+IERPgMb88CYWkZ9UAeLYzy3ie22gtlV1gDs+0AXbsGpBzFu7MTCyP6++6h04LAnh77nJyouTCZyzeA0SqW8CJo=
X-Received: by 2002:a05:6602:3791:b0:85b:40c7:ce54 with SMTP id
 ca18e2360f4ac-8611b53f859mr232611639f.14.1743742804461; Thu, 03 Apr 2025
 22:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev> <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
 <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com> <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>
In-Reply-To: <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 21:59:53 -0700
X-Gm-Features: AQ5f1JrkDm4osU5hqTIuv9MfeiyDZoutvPYmBR_ll6fgEW3JzbUQNFOzqgzuSF8
Message-ID: <CABPp-BHWFaUHAXwuddNpD1w=Fe7BK=9-Bc=-b9yXbqqWsQ8_pw@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:47=E2=80=AFPM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Thu, 3 Apr 2025 at 19:40, Elijah Newren <newren@gmail.com> wrote:
> >
> > One possible simple solution here is just to treat change-ids (or
> > there abbreviations) kind of like abbreviated hashes -- they aren't
> > guaranteed to be unique.  If the user specifies a change-id and there
> > are multiple branches with such a change-id, we provide the user an
> > error much like we do for abbreviated hashes.
> >
> > Is that what folks have in mind?  If so, I'll be happy to drop my
> > reservations about this aspect.
>
> Yes, that's close to what we have in mind. I think I just didn't
> explain clearly that it's mostly harmless in at least Jujutsu if there
> are multiple commits with the same change id. If there are multiple
> visible commits with the same change id, then you'll just have to
> decide what should happen when the user tries to refer to commits by
> change id. We currently let it resolve to all the visible commits with
> the given change id.

resolve to all visible commits?  So the Jujutsu equivalent of 'git
switch <change-id>' would simultaneously check out N different
branches?  Or do commands which cannot accept multiple commits just
throw an error in such a case?

Doing a "git log --no-walk <change-id>" and have it resolve to several
commits would be kinda cool...

> We may change that to be an error instead [1].
> The user can always fall back to using the commit id in such cases. We
> call change ids with multiple visible commits "divergent". They
> currently show up in red in `jj log`, which I think we all agree makes
> them seem unnecessarily scary. We'll probably change that soon [2]
> [3].
>
> So when I said that I think it's quite uncommon to have multiple
> commits with the same change id, I didn't mean that as an excuse to
> not consider the other cases at all. I just mean that I think the vast
> majority of commits are not cherry-picked, so we don't need to
> optimize the user experience for that case - it's fine if it's a bit
> more complicated to refer to such commits.
>
> I hope that clarifies. Let me know if there are still unanswered
> questions that I have missed.

Yep, thanks, that answered all my previous questions...though you
raised one new one that I mentioned above.

> [1] https://github.com/jj-vcs/jj/issues/5632
> [2] https://github.com/jj-vcs/jj/pull/5800
> [3] https://github.com/jj-vcs/jj/pull/5850
