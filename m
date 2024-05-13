Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8517E
	for <git@vger.kernel.org>; Mon, 13 May 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622968; cv=none; b=R4t/6fiJERwxs0g6FJJeBHa/qhnXLWHxKjbIYjXRYBr80MsolKq2ElmNYlFmlllMmpYicbzKTEMIIhB+5yd3ztItN9EtCewXS/SnySUl0vcjfzh5sltv/8yv0NE2hRv/3kb3HV9yAursjn0y035MjtuODFTQXgWz4s1kofrRGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622968; c=relaxed/simple;
	bh=QosWZkK//ZyCnSA+VM/OZEXkMh38e8+OdFEywgbHmHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EW3jLj+pSwKeztkddrtP2+zeJeRBto6sJ7PlxQEqWv9bT8N1j5oDuSQkkIO3dQTImB15XbxK7DjPNR4BNtbrdxKRyINNnTjfl3rKV+OWm3pPKSragT5Yasi6NyIHNw49zUlAwDDYok4hu3+gLCQejWd6sgXbZgi8/k6uR6PcE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb/GwcD3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb/GwcD3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43e04c95c06so4492411cf.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715622965; x=1716227765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbthcBVnbsHT9AxRWIAUt8jvz/iU5H1biFT+1Q5VGgc=;
        b=Hb/GwcD3PEck6/xxvjQoZ5tj8b9LyriOTk3NBnFWMw3ZHHiIz/A87ioyvHo9cl8kKQ
         H8sE/zq8A/aNrXCgb94J1soBvRn2oaKR617Gkawagz/9lYuzXUFkrz1VcY/wZ+JkChq5
         rHb1g7tnkqvWtEczOdHowvnpWSCx66JFynY21zgqIxg4I5tx8HpCnexdsZffU6Pme9K7
         HUGt6Re/TazotmvmYnjabhJ3n1BnCl6dNXyTIdbtEC0JyDbUdZlAi3Afbzc0UlrsNUD/
         TddH6d0jBAohhh6HxqGtlmlvkcWHCfwlKD2V7DZtCD1gWPR+mIlC6Tqh8GzgEj4udIkC
         YmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715622965; x=1716227765;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbthcBVnbsHT9AxRWIAUt8jvz/iU5H1biFT+1Q5VGgc=;
        b=kz3OuVEcNBFDz+qhqFzX2WflsgN8ncsYqJLdPvagZLztEeLkHv0FMP1CNHZOU9byIQ
         /6DdmQ7aSvN4FvOBy0yVnegFD+2qGprMNXBaEy4+2bCed6XHcDi5mYut56GKlCPviIFZ
         v3NM6qQZtqAgr+6tOVY8+ZZMPdWarTTi1S2NiX8KzVRWinJetOPlUS4xeXr/wNUGw1Ag
         NST1keJF7AWjjWVzIxgKZWliYjap6sOmWB9RvQBD3SKPI0xiu1pyX/iHQWJhhZogfWlz
         E1eCz3FOyALiiTWxlzBEU4BY4dyAqwGt+Y2OuE9xu8jmR5+eQjsvG8sk402fygUrJPPp
         7IHQ==
X-Gm-Message-State: AOJu0Yzy1neZf/Uh8QngNIxEyQb87KQLjZdNWCcoDv+xC7uOdENcqsrA
	Ra7VrZOlNcMYsyH3Iw+rEM2Tms98hhgNV6j9EoX8I4JoFHASt0Rsrm3ieA==
X-Google-Smtp-Source: AGHT+IFmhDvyq12nvQe2A9bQ3cKm0EAjTYuJVCBGMjsO7Z/M6E22XNrNHHHUEOX+71sslW+w7B95Lw==
X-Received: by 2002:a05:622a:14:b0:43d:f5d7:bfae with SMTP id d75a77b69052e-43dfe0055e3mr105633061cf.6.1715622965015;
        Mon, 13 May 2024 10:56:05 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-f.epic.com. [199.204.56.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df87da55bsm54357611cf.33.2024.05.13.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:56:04 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: <lbdyck@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: git client enhancement request
In-Reply-To: <02f201daa547$503df630$f0b9e290$@gmail.com> (lbdyck@gmail.com's
	message of "Mon, 13 May 2024 10:07:45 -0500")
References: <02f201daa547$503df630$f0b9e290$@gmail.com>
Date: Mon, 13 May 2024 12:56:02 -0500
Message-ID: <m0pltptx3h.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<lbdyck@gmail.com> writes:
> I would like to see the option to allow the git client to request the
> creation of a new empty git repository on the git server without
> having to open the web interface to the git server to define a new
> repository.
>
> Perhaps something like:=C2=A0 git server-repo public/private name

Is this even technically feasible? My understanding is that
storage implementations of each forge vary *wildly*. I don't believe
this would be under Git's ability to implement as a project.

You might look into combining your preferred forge's CLI with git
aliases:

  - GitHub has 'gh': https://cli.github.com
  - GitLab has 'glab' https://docs.gitlab.com/ee/editor_extensions/gitlab_c=
li

so you could alias

    git config alias.server-repo '!gh repo create'

to get something of what you want.

I believe GitLab also has a feature where you can create repositories
just by pushing an existing repository to an empty project path.

--=20
Sean Allred
