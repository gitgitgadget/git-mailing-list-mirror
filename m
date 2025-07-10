Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229A1E520B
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183510; cv=none; b=un2tICGy+8e8mK8iLbOITUILqkVTqUu528Opih8NkKXpXpd8IJhP9PHQ56B2szMsDwv8NeMTQlveZ/Cln4ZvxUQ4vDwmbQdPvoORNsGX/+dfqRnYpO6OgFi+JH48NJFNw9Wh+WlQDzzedWdFcb78Xsi3lVcTiWCrINLrN/pQWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183510; c=relaxed/simple;
	bh=IapYYDm6+bGJRoKZ8++IfnGZqhe7PBE0C5G4wM4RhMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuIhN5UeRI5Le7e75Z4Kh3pKsG+9lPDNzIBpD7UV2TmVRlypUeEAZ6y+aFTufwoF/1paA7/qNnFmE8GG6DpD1K3cHQwHDVTQ9idzQN9xwJfQA7D3Kh0PT6rs3TfvKwgttTBy1YqEWxO+bN4DjOmeojfUVrTVoQw4lpSuKb8YLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d5cc7beae4so23632585a.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 14:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183507; x=1752788307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IapYYDm6+bGJRoKZ8++IfnGZqhe7PBE0C5G4wM4RhMU=;
        b=xUtdiTxQ/Puil5ndA94Goqf65lChyAQUElELwJrX5OZCxsEFbDu9e1Mx5xiv062d4F
         Saluxi2uLC5wzNIpl83njr1F69QtSYO+0ijdyuy1IhOv4ad+JNOymzryoerxi0kY3t3h
         3LaGPqd775h4vz0a7gi4Z6ADw4VFJLz2h15pQmMbRGfbwPvxZNK+HVJtMWJ7JVXbX+AI
         Pso5EnHAiyFNz8uOxaPKnzhOm44xGvqCAypxLl3ENH55l/VZn8ei5aPOMRs6tBh9anKi
         RPr03XiM/AjEByk6sBzFIH2m1I6ZHRja0c0THA1i5reaGrMVLiEYhBqArmUPhzbZe0ah
         RVjw==
X-Gm-Message-State: AOJu0YzdrxIhf7b+LP0498JOrnWgU08KD38kmgA7Hb2k7+fNJmZKSbZf
	MQAx1SbgO/r80clYGY9ciij3AVSxLg4mLJLBxvB+9TH53s7Dc3YqdP5rUl2R9vcpdxuXtJHLAXt
	Fth8KBO9+5NKqb6N230bI9MIbQ7SrGas=
X-Gm-Gg: ASbGnctmGE09itAI02hKUtRBM7vSx1TdhUXYGrjBzucJZfk94sddaqvt0/PHtbwupN0
	2YmG6Xj5ohhlNDIJZFQ/x76R/MczQ5O/8aZyHJpXyJdB0ZTz+11qU8ODu/gn9eiO9k11YP4sJ39
	Q7p2HJuLT01XN2GHE/f74unV69d2jpI9/k++98a6xQEUS0zLvvcPH3pWZ6MRcUWI25f/hj2iUtZ
	edI
X-Google-Smtp-Source: AGHT+IFG8pHRG2eiIsraWjWWywjrfytrOcmiZR5V6PQJD9c6qdAMo5GGfM0LL8Ce4aL/qTWG44yH/iH2CDThlhijxDs=
X-Received: by 2002:a05:620a:2703:b0:7d4:2901:2b3c with SMTP id
 af79cd13be357-7dea4af9ab6mr7468685a.9.1752183507411; Thu, 10 Jul 2025
 14:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com> <f21e8ff5c9df0989ce09b3d9a50c0dc81af18837.1752176743.git.gitgitgadget@gmail.com>
In-Reply-To: <f21e8ff5c9df0989ce09b3d9a50c0dc81af18837.1752176743.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 10 Jul 2025 17:38:13 -0400
X-Gm-Features: Ac12FXy6dY-u-tE4eqOezjXjEFCNDrb7V17yTD1N-j1Gg5PSGwMqbRlQF-yDY_E
Message-ID: <CAPig+cScQN7O-cs+-9X+RpjQqJUstD10LgNYZqSHFwyAdRL+Cg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compat/mingw: allow sigaction(SIGCHLD)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Chris Torek <chris.torek@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 3:45=E2=80=AFPM Carlo Marcelo Arenas Bel=C3=B3n via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> A future change will start using sigaction to setup a SIGCHLD signal
> handler.
>
> The current code uses signal(), which returns SIG_ERR (but doesn't
> seem to set errno) so instruct sigaction() to do the same.
>
> A new SA flag will be needed, so copy the one from Cygwinr; note that
> the sigacgtion() implementation that is provided won't use it, so
> its value is otherwise irrelevant.

s/Cygwinr/Cygwin/
s/sigacgtion/sigaction/

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
