Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12508322A
	for <git@vger.kernel.org>; Mon, 25 May 2026 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676588; cv=none; b=Gs3EdNv6ybBs8jrV1wqhZkrEnx1XnT28GkyddsGbi3Gdg1RlZBM009lXi24p5Mp91DSwILicbE7rTOzJV+Fkncm/PyKx40+Ek/+oO5mFUj/z9qOQkASwNkHD6MnzAr5+JmYTty3zNWD1zUS8xHkayZ/1pjfiCpoNZlQdeUBYwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676588; c=relaxed/simple;
	bh=krX/m5t7Vmt86wIiEDMeF9EbOhRHeScrNKkzodWVJPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku9et4w0hAvNYrw5Lki0TJhJz9HL9/LDOcv9Sq0CEwTsjzMiBE5dnj2QVOedUnpv9BLKa9Cuso2feagMFIcd77VJcIRF0/YPW0rToYWViG/FAvVhKDO+fYfhilgb4uKXeaeGFuHXR4FUUHD7yl6H1H/ApNPt5NTQ5GsvDC7re4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso8246277e87.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 19:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779676585; x=1780281385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GIdYgXKWdbnYtZ/rN0wuNcHykw2liy+VxHDuHwh9Yo=;
        b=CTvyCjxbu48iRtO2L3SDTbhaUPev4T/sO7Y+n0x3G93swb7Z7egOjEBuup4ptnl0cn
         8VRb7LuF1gFS1UPbj6ivTlt3e6+WsLDfXYCAcDG9O6RP0YoC8P/JQAqpZ2KiIhDiMr8J
         oklFQUGrKY6qFN/MF0cFds9E0ofUi+R/ulFd6GTJAIlsyT2jAl6ywvSbJDYojBWKLeIS
         ej2fHHk9gOrehGg+oUhX9bEpZ1j7RugmXg0q8DqC5Rzk70YoYc4h5byaHAxhUazytW2t
         nH1V53l5RIw16Z8TQUTFyjvgm+jEo/LMiP6k2HwW7eMQXD3Ue6qik+jCMyCIStVIrrg1
         i3aw==
X-Forwarded-Encrypted: i=1; AFNElJ/kNQmsxWiJR1tOUBPpx4QOIH1qT77ifwMXUKkkw9XfxsTYlbuh9JghRSQkNSJbmBsHzWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCSqqmbjnjt01ptxXJw3jnqSLxfO0cnON5dGszEuO+B/330x8
	MaZYye1+lqBenoIr1EbjtCMHB2NkOCI/k3tDw6xya0b6QN5vmZd66ed1TkJSRePE3FA=
X-Gm-Gg: Acq92OFvgthKTQKV+EkejyWQswH/ABcXtNMlyi/ujeUfrsBlvSk+xvgx10sRPcvFqTT
	gJUROR0svlSjDiy5YqsqlrLNoK4UtsHmO6c4dCUAXi6cj1wFZvcj0EALylX3ksW3BfZIV/isrik
	yRCPGheX1hpv2KFvW9WNizqxYH/l0ZS6/2oc0ahk6mFIdxGQliJWF9eat+ZNZVI8azmB571g3JI
	gTFBXVL3Si2b4YQC7MtPsc8ILw2SyCS0BB02QPF+ox0YFnQMtAU+VBh+tAK8EXNO5qHmcNnJ0ra
	93VuHX+I5X+cW8PYrah8+xf91TsKfvHClc4shaNoHaJoJE6F/D1jy1Kc3kDY4IEroz9Q16dYUzP
	7/0k19RY4Afr+sTw2PXlQv8ScTKM6isySSLvtrpm4GOj7mWgO0TxciradjNi27P/4iQpVdvbvAg
	4Ddo3aaDhNle266q1xJzhSC6lR4fdEQuWD0sh0SPv42cdQAzCc5eohsHVHkhRCtgCgpY5zhosGa
	6Px6nWvmD0fsF1BscXVuleBkyR54Q==
X-Received: by 2002:a05:6512:682:b0:5a8:65ce:e832 with SMTP id 2adb3069b0e04-5aa323e10admr2892543e87.36.1779676584596;
        Sun, 24 May 2026 19:36:24 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb37b4sm2363525e87.1.2026.05.24.19.36.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 19:36:24 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so82498941fa.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 19:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/xEVfWQvQo7N8ayarb7cJltgHc7/XpfKDRltrx1Ol/W/wvPp5VUvOM7+q2NM4b2EAnTaI=@vger.kernel.org
X-Received: by 2002:a05:6512:2245:b0:5aa:b6a:6025 with SMTP id
 2adb3069b0e04-5aa323e3171mr3612685e87.42.1779676584260; Sun, 24 May 2026
 19:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn> <xmqqbje4grra.fsf@gitster.g>
In-Reply-To: <xmqqbje4grra.fsf@gitster.g>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 25 May 2026 10:36:12 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNKfm9Q=FWJkvpUSBmpmxL+RaOCifST8p=ViDwqVceNsg@mail.gmail.com>
X-Gm-Features: AVHnY4KQx7ZWqO7X79NG_p0eibfxB1eDrEb9JThGmwmwMe3Zq_aIcRnHa8cH9Jk
Message-ID: <CAC1kPDNKfm9Q=FWJkvpUSBmpmxL+RaOCifST8p=ViDwqVceNsg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] includeIf: add "worktree" condition for matching
 working tree path
To: Junio C Hamano <gitster@pobox.com>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
> writes:
>
> > The `includeIf` mechanism already supports matching on the `.git`
> > directory path (`gitdir`) and the currently checked out branch
> > (`onbranch`).  But in multi-worktree setups the `.git` directory of a
> > linked worktree points into the main repository's `.git/worktrees/`
> > area, which makes `gitdir` patterns cumbersome when one wants to
> > include config based on the working tree's checkout path instead.
> >
> > Introduce two new condition keywords:
> >
> >   - `worktree:<pattern>` matches the realpath of the current worktree's
> >     working directory against a glob pattern.
> >   - `worktree/i:<pattern>` is the case-insensitive variant.
> >
> > Supported pattern features: glob wildcards, `**/` and `/**`, `~`
> > expansion, `./` relative paths, and trailing-`/` prefix matching.
> > The condition never matches in a bare repository.
> >
> > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > ---
>
> The test in this series fails in GitHub CI for Windows, it seems.
>
> https://github.com/git/git/actions/runs/26377220573/job/77639885088

It seems that "includeIf.worktree:/.path" not working on windows.

Will be updated in V5

>
>
