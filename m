Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77040260571
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611394; cv=none; b=a4kLu/0LyoG9mf2iJwi5r3+vScJFLmUrqToXm6tXesQ8Z3Xd4euWHQfrQFK4VQLKU9GGfXw62cMwabN033pS0PWrtPTmeJjb4JaTsfkk6bRUQD1fEltYMhkl3UTxa/Fy5YYvoAjfrFBLiof57RHI1i4T5dO4Z45wlubdCWWW4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611394; c=relaxed/simple;
	bh=F27mx1trzQmJ7UzBrKAgTvUlAu7s0Nx5K3Cjft2CUTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsYVkyij5W3t8cv5q3bsGSEY3VsU90x8HJAS5jwVO0OGpTIweWMpz+UFU0Ltl7h02VoZkZZ/hh/7y9YoOnCNL/7nNVRanGMcvltpm7re0qOiLhCAnZmcUdmF52Dy2zd+G0I3NkydixxMz3z+kns+LKh5b9brjng/f/3kxDkZ/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adfb562266cso93785266b.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 23:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751611388; x=1752216188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ociyWydQuugUTZnNQhYqVLSGRNmKPumLvncLMx2ZUzA=;
        b=PJRfB5NCWlQVyi4g7EoIkGJ9mPDc9SLnUpOgYV21fgN+fgc9yKiJ2hFRBjgv3AvHFJ
         1Va2t3XRspwxS8O3YNWaAr+qwjgTY4/xZ+r8aEmm21Wa4WRHripABhcUTjGTtff95olK
         hf2YF9w2L7P+qr0kUQSUbUGV0bIf6GwQRGTqdUmJLWPOOUL1QO0NpUW2st5F3/Py6C0G
         atjlTMz5RHm6dPOye03dggPVScUiYFjuprrmQYG3BmLxAHFb6crpRjaNu5XuRH9pbLLS
         fpF8pYe2T9fyT3Xb6WfJfg5lVVli/OwIr063A+ZMPSgvvetOCzvyGP2iLQxgeFJR81kk
         Ll5Q==
X-Gm-Message-State: AOJu0YzPybrZu/85BAi7KEO62+cVwt4pFn+v/3igauN2c1wAhPQ/3tAP
	OG5uvenoRzTRFqmmdlInd13LM0d6+oj7SZq7LLd5+cYATxdca4tJO9pvNyqz37PaRV3Ct2VKiJs
	Qvc5FVUyKaVbW59YdlSLY/Ofk7oYXQwU=
X-Gm-Gg: ASbGncvTSQm/Jc76X7loiRdnP2vRpILfxj6iINnSxQ/HWzG2uMzMFWjeRw7Hc2ba6aJ
	wrrMBYodcOZbTGXtcBNHUpdOAWbWgF9Wo3K7zZIiALw90oQxSv/5NFAGdR2v/n9eQ0QEw9LRGCG
	wKMuZ9ApYrtb7+zNS7K8YL613/0BYwr4WBDOJsoTUFig==
X-Google-Smtp-Source: AGHT+IHOE94XR7nTqJ/SHPqHI5YjsqjlxAGElV0CDxcugT1u0ERk19S8eCDlvsUang78UNOaxTXBjxM4jmLN30zeM60=
X-Received: by 2002:a17:906:b07:b0:ae3:5110:28a0 with SMTP id
 a640c23a62f3a-ae3fbd873a2mr92094066b.44.1751611387406; Thu, 03 Jul 2025
 23:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <xmqqikk8bltr.fsf@gitster.g>
In-Reply-To: <xmqqikk8bltr.fsf@gitster.g>
From: Per Cederqvist <ceder@lysator.liu.se>
Date: Fri, 4 Jul 2025 08:42:56 +0200
X-Gm-Features: Ac12FXyR-CnDFd3I0glb2JqqE-Xw1xp5N4RpZj_wP7yL13f4N_q81jF2eFiBfjo
Message-ID: <CAHx6-UmL7qHf-0SoD1qrOKbWK5JjuESJaZdQK_rjy66RrYg0Xg@mail.gmail.com>
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:51=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Per Cederqvist <ceder@lysator.liu.se> writes:
>
> > Today I realized that git accepts "/" in a remote name.
> >
> > This can lead to problems. I have a repository that contains a branch
> > called "master" and another called "chat/master". Just for fun, I
> > added a second remote in this repository and named it
> > "origin/chat".
> >
> > Now, does "refs/remotes/origin/chat/master" refer to the branch
> > "chat/master" from "origin", or the branch "master" from
> > "origin/chat"? Git seems to think it refers to both:
>
> That would have been a fun experiment ;-)

It was. Luckily I figured this out while trying to deduce the allowed forma=
t
of a remote name by reading the source code, not while trying to understand
confusing behaviour from git.

> > If it was up to me, I'd add a check to valid_remote_name() to ensure
> > the name doesn't contain any "/" character.  I doubt it is used often.
>
> If your remote-naming discipline is to always use two-levels
> (e.g. origin/chat, origin/chien, origin/lapin but never origin or
> origin/chat/blanc mixed in), then there is no confusion.
>
> It becomes only confusing if you mix origin and origin/chat.
>
> So it is not like we can just forbid '/' retroactively and expect no
> repercussions, especially given that I hear there are more than a
> few thousands of existing Git users in the world.

I wonder how many use "/" in a remote name, though. My guess is
very few.

If you want to do anything about this, there are a few possible ways:

- forbid "/", but add a setting that allows it. Note that even if you forbi=
d
  "/", existing clones will continue to work. It is only when you add a
  new remote that the name is checked.

- require that the number of "/" character in a remote is equal for all
   remotes in a particular clone

- deperecate "/" and start warning about it now, and forbid it after a
suitable period

    /ceder
