Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C91C84BB
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772989; cv=none; b=Kg2x8sKtd7fo/IHnUTWd3SrL8V0sDE5pxPqeEdxDwahcD97AbxPcqz6HP03hBjscgppK0CM48pLsm0wKsfvRaS6R2EurTeifOTUE1B9uOdEU9QG93hpewmoUkYUFL6TwUVdh6mF70pwZmFTkVcH8Q09AbhiYlVrpA9ugBv5sfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772989; c=relaxed/simple;
	bh=pDqekfvHyART2oXOcar8UBBw3uMdoWB1WJ7q6zP6zVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS3vI97BvscxcrpHTu9qzv4MpVBEHPGNRV2A0I0ABlhVTGVgkNkGxCCjDUOgLhVyi+z2de+kXYeY9yNE/48+C6oiHfGgMtNjz+a17S7IPb+lpOST67XAIVb69I299fWSfqSTUGp6008Soqn7+TJJ7lIGSF2KwOp+679v3LcveKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+hvneFf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+hvneFf"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4769bbc21b0so18723001cf.2
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743772985; x=1744377785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDqekfvHyART2oXOcar8UBBw3uMdoWB1WJ7q6zP6zVo=;
        b=Z+hvneFf4mB3X58cUOhn9hDxpVkK1c9cjeppXjrGYPayXQPzyfVeUwspUHqCp0UatJ
         i/HX0dOWlbQX975MASvbNBFLR2bGT/0ngS1vDs/Bwv7FeI/BQHEnB0xon97e9G0Ju4DA
         zdRJqo72RArqBSb+AhDSCxRROmauPqWSGYavRSHTF1JJZ84Ll5gFEefLR3vhII9X3otQ
         LttLobWt/YaRb+ULmm7YogbpC9Rvh/blkdrKsPpz5GAuga05PD3+7vYww6w9wLN6yRLH
         c/wcblKyeB6vUSNSn7szuzqfUBZik7Ysedy8IyZ3R5PlTeT+lCt1QPYS/EwbzWJ4CBUn
         CVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743772985; x=1744377785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDqekfvHyART2oXOcar8UBBw3uMdoWB1WJ7q6zP6zVo=;
        b=W5LGOBj/+jMaEcnWw8LXci7hF6IsBylDbH89UpraVB1n1JLIsNvzb1Ri6AGAIm9hc8
         wSJemaEhyowsdz7YCph2lXaPVfI0t6r1YYVXxW0USWtco+ZfH90IWe2vMxTEFuFAlT1v
         sQdxmmhZRZm4XZNubogIn0atOpR0QVnL4ICo/oZzOOvz96J0mK8LfBxNBogkpgjGIi1Q
         bQQ4PUg4B4V4enFKf56nfAPeMsu4wkAhaE41CTYuC5vorjSyxjGFteac96rHtUD7IR8Z
         Lykd9XOIylVXNtO0NMIWXwIBfb+ieYnEhqa0eVUo7K7h/3sGuKslQFB4Bcw7Ce8IbrVj
         HX5A==
X-Gm-Message-State: AOJu0YzRcBLLptQrjuYvaguLgjWZ2hHfxpPHwsZK6VlfnH9ycjJT3d65
	Qrv6I3J5w5QI57bW9+0/wgM15K8FL/UZ6+MtlfNbgjH1fTJQDzlJYaKo7oDQE5GgKtug1MOncg2
	Viyg0to281+nbsLHTTqwO4rhdIXjOUQ==
X-Gm-Gg: ASbGnctTwKtMSHVwhbbZPI6B9DhN/xGQFJWnV8mZTDjAgYyMWNssvxiEKPUO9IrCESP
	61g7Qbj6KH1UEF2QxOyqe1BNPKMxYCME/vcKruI7e2951DePHIMc9qEK2XaNO6Ur04ovvfHl3yK
	Y9WbnU4wxF1gNWEuxzGldcyf7dlDOVPVjKCsVkzVrk5hFxTI/mqMZOUBlaa/c=
X-Google-Smtp-Source: AGHT+IFtK5F5VtpkDYiiVdxXDOHzPQzMhrf717stMhcK5vxYTLsFjIoKNjGxwOgO89yq212Rq9ykNHrq6CDjpyQb434=
X-Received: by 2002:ac8:7f11:0:b0:476:fd69:ccb with SMTP id
 d75a77b69052e-4792493b326mr49517221cf.27.1743772985498; Fri, 04 Apr 2025
 06:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im> <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
 <Z--ivMYyD63JkTyH@pks.im>
In-Reply-To: <Z--ivMYyD63JkTyH@pks.im>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 4 Apr 2025 18:52:54 +0530
X-Gm-Features: AQ5f1JoDXnX3O_2tciGhiWJEGz-sEPwS3vLXFkd-GYFA6xjXPdOfhogmBR3DDk0
Message-ID: <CA+rGoLdH=zQy6A9draoZgoDO=Ok7OgaX+mRFarLTLEm2jwhE4w@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 2:43=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Thu, Apr 03, 2025 at 07:40:33PM +0530, JAYATHEERTH K wrote:
> > On Thu, Apr 3, 2025 at 3:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > On Mon, Mar 31, 2025 at 08:21:27PM +0530, JAYATHEERTH K wrote:
> > > I already saw this in another proposal, which indicates that the proj=
ect
> > > idea might be a bit underspecced. In any case, the goal of the projec=
t
> >
> > Hey Patrick, thank you for letting me know
> > I actually have been working on this proposal for a while now.
> > I also sent an e-mail regarding this specific project right before
> > GSOC proposals started. As far as I can see this project was not
> > previously discussed therefore I picked this.
> >
> > https://lore.kernel.org/git/CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyuc=
P38mdFgA@mail.gmail.com/
> >
> > I'm not sure how to proceed in this situation. I think I need some
> > advice from your side on this.
>
> I think I don't quite understand what "this situation" refers to. Do you
> mean that there are multiple proposals for this project now? If so, that
> is perfectly fine and expected. There's only a finite number of projects
> and a larger number of students, so some of the projects will have
> mutliple applicants.
>
> In the end we will pick the student who seems to be the best match based
> on both the proposal, the microproject and any other interactions with
> the community.
>
Understood, I will carry on as is.
I've sent the updated proposal above in this thread with the revised
scope of the project.

> Patrick

- Jayatheerth
