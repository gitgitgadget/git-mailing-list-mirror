Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9836D4F8
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661971; cv=none; b=lfuxZwjEEDIF/xJVMwOiBiUjt/Glxyx3jwaRsb+g6LFAOqn5ZGrlmwlHvvab4tfcqPu9fN0wB6krFWgZ2G+Kk0NPs2MxGVRu+Wj74rnxUMHTA1OdgRC+SsaRUxfAzbfjyMPZ+pgQljibrOlVSGd0KqbhljcMAgK9uLmdZd5g4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661971; c=relaxed/simple;
	bh=kQhoiH3MyLrOOYY7pfQE44C75oE4sf7gIU7ArLnjRVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCF3aekLW4A+bqvBs+Rh1u061IMt/CCNTkoHIx6o+7K/+SDRf1XEO8p8ct744DlA8LrVNCDIxROyYPtuq/iZrGiSfnTK9YgZtt1abIdAO5BeCr0vdipZhasduYEbVkNov31kF8vkq2Zo4BfRKbQCjn+vauuv6FOGtE52xbKdP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b30d1b467eso19761785a.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 10:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661966; x=1764266766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTQENiCO3KxXQyHg5Pvt/cjdSrYUzH0BwssOJW1SfCA=;
        b=V01TVUjncQFy1zOqApQoew9EakMQ0r4VWqFLTRIj5LpXaSi+c3HzNUaiJ7EcOl5WWO
         cyieG2sreGdiTF/f6eWmR0taPkCfChP1HR2YjI2M+u3cUoKTFglDJ4OcSyEqlr7N0HjX
         YgoO2G5ckeixQgwVYQCI6tgipRs3Nsp26+BQ/SjSvjJn7zrRU78C2im96JCNLkERITlw
         JeV67G6J1RR3RrsOjeegaMwdgP7p5J6TBwi2VQ+I+8LTGCncFsDnEj59aiObTiARUKKh
         S3pgS9xlWbNFlLTf35U9j0421eZzvbprLfT9bZ5JvVBYV1NNQzafhMw7pGD8nHQjEgb4
         elaA==
X-Forwarded-Encrypted: i=1; AJvYcCWlbS1RWo2+5RFugdAYH0Mk6ZOn91E6HVWHuq8RpH58Mg9LQOYyotTisnuT3O7g07HB2R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmOypND5SeVTIWgzq63+cYo0M8zYaAkgJZZ65ZAC2gEJmZ3hu
	FnFFZ2VzyAWhs6RllFfWFP+jtCbDjQINSlGnaBl2GaqVZiuhrNhh84USz1Nbi7MUTS6IRPok/85
	qkn7YAGQBMspKsIbXuYvDaoSWNbrMtxU=
X-Gm-Gg: ASbGncsl7fNbjoQR4ICo0iyh0eUh4oOztLuVvRIElA/hX6XYok26jmX+WxUJwpAiG41
	4ltYhC6B6wcQzMc7lqQ50WVi0bTIDPO1m5xvyItdrclug4mR7LUzCR05Jq2imy8UZXOyakcnGCf
	PkPfT5xk1VOHdnqtYHJ9fkMihHWqYHQhfn/M4Jbc5Fjd895vnxen8THByVubGwIhcjQwjKOcNPu
	NaB4eVshQMoeC8bdZJSKZjVcKI/Dwz9c7lmNm/u0efdFHJalvBhrxnlSKntoTVw89dwRRxrVK31
	2aUqXoz9kW1ogaNB3TY9tm8dw0w=
X-Google-Smtp-Source: AGHT+IEKsnmmupES18xyTwPPv6W5Qt70K6olg8C/BpML4mntKI3fQK5bC696MMPq8qVy7P1XvxR9S2evuk7UVZWhEA8=
X-Received: by 2002:a05:6214:c8a:b0:87c:2360:d41f with SMTP id
 6a1803df08f44-884717d5d1bmr31114796d6.3.1763661966092; Thu, 20 Nov 2025
 10:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
 <39b17bc64ff0d2e4162437ab745845c055315037.1763232863.git.gitgitgadget@gmail.com>
 <CALnO6CBzE-+51LfgjpEv665oG6kZG9_4YZTv8qgqtNrhh+a-Bw@mail.gmail.com>
In-Reply-To: <CALnO6CBzE-+51LfgjpEv665oG6kZG9_4YZTv8qgqtNrhh+a-Bw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Nov 2025 13:05:55 -0500
X-Gm-Features: AWmQ_blh-A8ZHWFqJap-83QRmzhbUHFo4gTh5zL4OV1AZTPPRbN1dYG6lO0pKgM
Message-ID: <CAPig+cTpDdTceBSYoVRBS7wKoSxURMeTA7TruiAmjgTX4B=m5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-prompt: add quiet upstream indicator option
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kiril Ivanov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kiril Ivanov <ivanovkirilg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
> On Sat, Nov 15, 2025 at 1:55=E2=80=AFPM Kiril Ivanov via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
> > @@ -275,6 +279,8 @@ __git_ps1_show_upstream ()
> >                 "0      0") # equal to upstream
> > +                       [ "$quiet" ] &&
> > +                       upstream=3D"|u" ||
> >                         upstream=3D"|u=3D" ;;
> >                 "0      "*) # ahead of upstream
> >                         upstream=3D"|u+${count#0  }" ;;
>
> Our coding style also prefers "test" to "[".

In this bash-specific script, the normal project coding style is
relaxed and `[` is used regularly, far more so than `test`, so use of
`[` here is appropriate and consistent with surrounding code.
