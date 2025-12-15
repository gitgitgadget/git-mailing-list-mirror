Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24714314A79
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814470; cv=none; b=bYjFxdULF0Q2qmk9UkfHJJ6IQ/MObBdN/GA7oW3pCbK3/GfS3pQBLsHZZ8S/MNesW7rDf/OqOSrWCgMWZTURhPdLXG7mzoziAi2KmvMW7AXUeoR47bKPiR13bHTFYT9anqyCSTw7qrrWJylv41iRznLfLt7HPNmfKEYFPK8+TRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814470; c=relaxed/simple;
	bh=PY8fvlib7ldsrQhnqRncIO5pOMGc89jRmvBpOoTzQtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6vO99jnw1yY8oTOBNAE5is9a02oYj6mnHSWAhVXJytke8PJ3I9++lq9xRuMoXGee90hRSjjLl8OG5SMsMmZV899D1uCd138hIbRFpI2yGKlgG6jXXi909upck0gxSR8sZnpjGfu6rFFdqUuj4hlTGyYouqFX3tVddj0am4NA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctlKTctv; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctlKTctv"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6446d7a8eadso3309657d50.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765814468; x=1766419268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ycy5luKZm4OORWwhrCmZP7gWHlkQPmEwXyUXu25ujc=;
        b=ctlKTctv650dAx/gs+5FW75BkPHApUtfp7GMhYZBvKJprCmjq6zUAIDmtQgAhxImMZ
         Jl7OTHi4btUOIqUex/6c/G3omJ0YYT4r9Yy2y2eJPd6SbIQR86B8XKmhL3u7SvFIFmtH
         60vVUKj/YWkKgwurrxcLOloNF7/F1EjavaailoR7xZyVJXGKwMmhJeyy1tRMhmQRJthL
         6/0DKa6Z/t0gjfG8KTNeHmfTPT4HGFtqLBZ4I6vRyyFSvalUl35/eDHo5k/VBEp448OU
         uM9nwcgJQ9F1mtlWKYMD92L8FWIitElYX+I3f9mkLaafrFjqvY93okZe892qBlZ2bhy6
         3+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765814468; x=1766419268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ycy5luKZm4OORWwhrCmZP7gWHlkQPmEwXyUXu25ujc=;
        b=fPgjmcchmgM2pFWlmumbewOCbK+zROXMX8eMlEp4ijzKovvD4eedWtClIwlCXJ53jf
         5d3AogCeB5EPjRLor/LJFZtI6BamORwb9qEhV8WA1/yV90UJy3wo/FkInXYvx3RIHxM1
         kd1a6QWYB2v0KEFSlm/q8CaOT6BumX+jx0Row0GFmUqtL8QIKZzyAH05ShbW0XgJYqha
         19fYwuMHtu0YbBk9BSGMgFjnihbvDIjrAbTvn0INCRV0xZsJK4rjDIWCSNvyfkvzeda3
         ZJNFcKJ9nPB/Z8+f2ukt9l5pE4riXdRtyyf9jt4Er09cNSwKPo8Lwx/+EN3UWqgHyglC
         wcFQ==
X-Gm-Message-State: AOJu0YwaVVh2ITs/bhtjPU2+JCvZTRlb0E7nNsrFU/Nh/jUsaONXlhAq
	eoe/mNK6h/JGW0J1w1Nf5ux//DBdMpc+nZm1odA9yaFtHuZ2yA9IX0FF8Zr7nwn4xZW/j3QIpbs
	XYHrpnsKiLBQuEjXOvjf3E3OZeywn51ZeOA==
X-Gm-Gg: AY/fxX79FIRIZ13q4Z/f0KlluvNz8OsgLLjT/hMylYoB6XhpF6C4p4G1bfccQH+OkDl
	tvhAxPTYTMjhKkDnSENjnb8JkhvGOB+nj/u0i1EFG8yNbClKAKWK3bHbYKcUXWJ+xtVM37B+6z1
	fKls80SllBR5eWHrt74nFWKru4RPETo1gKkyTnCO798KVmPosc9WfHlk0k/vUE7b2AxZk/ooQyr
	L38mCA0SIYCAzh8IirM6VKJvZoJUaoDDOZ5UDeWMDRfu2Z9Lw/y0MN7lvDJgTwltOJx+hY=
X-Google-Smtp-Source: AGHT+IHqpUuE/5jD4y5MGH080nUYqpVQqDtIXTKqAVhVwlvXH0x//0suLSqq+8ZYgw+uO3DWHOHNEKe/8mXG84XDlYU=
X-Received: by 2002:a05:690e:186:b0:63f:b545:9961 with SMTP id
 956f58d0204a3-645555e98a3mr6153081d50.29.1765814467423; Mon, 15 Dec 2025
 08:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKRouPtDrCgUk1bQeF+ao04rtK_jg8KxD6Oju8vw8H-ZYt-7Ow@mail.gmail.com>
 <8bcfe2fe-3522-413f-b4d1-13e048028296@app.fastmail.com>
In-Reply-To: <8bcfe2fe-3522-413f-b4d1-13e048028296@app.fastmail.com>
From: Milos Markovic <k4hvd1@gmail.com>
Date: Mon, 15 Dec 2025 17:00:56 +0100
X-Gm-Features: AQt7F2q2RC2VdQjX68_7b-rsNO1dWgmbPy7doeAG7Kt2T8LNz9xXPWsT34UqhGQ
Message-ID: <CAKRouPs+TSfg-HGnEgr9KBq_-1xMVktty963v+A31YWFTnPj_g@mail.gmail.com>
Subject: Re: git new features: following and priority branches with new git flow
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The idea is to remove script and to have commands in git directly:

 --follow-branch BRANCH_NAME // name of the branch that will always be
rebased when pull command is executed

On Mon, Dec 15, 2025 at 4:14=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Mon, Dec 15, 2025, at 11:15, Milos Markovic wrote:
> > Dear all,
> >
> > After decades of using git (as dev, as manager and as a cto), and
> > considering different git flows I noticed some gaps.
> >
> > Briefly, different git flows perceive branches equally and shape
> > history from developers perspective. I realized that if the
> > perspective is written from a devops perspective ( focusing on higher
> > priority branches, like prod first , than qa, and with least focus on
> > dev) the source history could be organized differently ( from my
> > perspective a bit better). We used the following approach for a couple
> > of years.
> >
> > Therefore I invite you to check the following workflow here
> > https://github.com/k4hvd1/rebaser-flow .
> >
> > It would be my pleasure to discuss new features in git and how this
> > approach could be used. Finally if it makes sense for you I will show
> > you other materials and we could think about implementing it in git .
> >
> > Regards
> > Milos
>
> Those `gitscript.sh` should be shell functions. They will not work
> unless your default shell is Bash.
>
> E.g.
>
>     git config --global alias.pld  '![[ $(git rev-parse --abbrev-ref HEAD=
) =3D=3D "dev" ]] && git fetch --all &&  git rebase origin/dev && git rebas=
e origin/qa && git rebase origin/production'
