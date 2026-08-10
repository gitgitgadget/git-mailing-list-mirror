Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977737DAAD
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364879; cv=pass; b=u2niLSRMblcj+DAHtbogzrlXdsbVEaNtLkIZsSN45jwEnoK5Vb9LxaD9NmbYXscq3fb3zo84YFCmPRa9WU7TLZhSsTDuEm9ioR9aSmLwDJIS0VdDcKMe4KQYCCiBEzr8D1zpCl8qMgETjK6Zb8ZPo3ghRvyHAun6BMYqmdc/o5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364879; c=relaxed/simple;
	bh=WokVm6wO9l/7W/2LuD2A40X+h0gF5nqCn/JrS8Zq0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YatSPCV6FRCvsVl7Juf2IxiylcqJ2TI7iKOUgtfjb3LW3chbqhlN+OSNZQWn/wJ1aiyEn3sHVixML74e9Sb4DfbZVCM9szlVEOw/a9uad/UOKXIzMXwL/4VTwKh7o4AEea4+2GpHYjUM0qwdqDeWVfZUvX9jil3/iMw0eoxA7oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6pDNzAH; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6pDNzAH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cea3004256so22049505ad.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786364878; cv=none;
        d=google.com; s=arc-20260327;
        b=Q0oZeMBNUOBBaRDECSuTlvqGEIqp7ZV9bnhFnzw/OvqnZoGYeNi/fzPrmBx4qHVbWm
         JvDdtHsb2M9BFZwCIy8wGbzoR8KvJ/AvCjgbONKdU3OpSGLHILqIcYSInFnUZoUYtG06
         E6oXdyNEq7dPtZgMOSRRyZc8qrzWyYDpUklKnuzeUaeEwzvyRkqcNhTQvg0e6SmJA0K3
         Srghd6IKJYFqXZJfRcggkaDz9UUVUEXLNDvX95jgS9273kQjCLRZuIQ3PksbulheX6Pf
         NKHwpUOvZPHsppXQJzcLJvm0O8CZjVy0w5eOjB1G//7ZGIyQyaeKn1cK53/2UDloH96k
         ng2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/NClb79ZSs7I6mtD0/TeuhuRiRQUYabQMsnzpCt/nU=;
        fh=aV4r8oKbJ9F0Y8vkQT74TqNr0JVf9ADeC03IcTyMr6o=;
        b=rEMDodvdd12biAVCF0Nz3EibpicGNcBDeiS8cESHoEsauFdP7yIDyR/FpSTkI2cdHo
         IXy3fFK2HuIhrzQj1xwpCWMf4AumH4+6ft2a+dyj2fQOyFH7bFNrdGtvjD0261zXlVb+
         qgmQDeRyri8Y+2IAjM1jWm+wb4fxl40CeQQYITy9MqriKAGvHjJMhau79WH7LJzF2Esn
         wh39m8TALBsi/ix86vshWuAlL3B/X0P02AwvGX4kj41UC3vSCiSbm7SR7jVUOovorvsT
         jfpmsEa22yjxWxdFQh6lbY6pyUT0M93Kp56PDD8YSBUjS6mQcwbOuhTXQmJitYm0TwAt
         lpLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786364878; x=1786969678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/NClb79ZSs7I6mtD0/TeuhuRiRQUYabQMsnzpCt/nU=;
        b=o6pDNzAH7ipGsBLg066xSIeqnYsnPhWENg5oc5loRv/MUAHPWdWIIB0cw7pbWhkCNq
         Yp0hn4lK2qI0IFQw/gBGKX/a+cKVYse4ekzo+48Gjpk8AZ6NJzcITE9Avl+7/JOQK2JB
         e+h1T9bhUL6NwCi9kAJwAPXUBCEzna9faH4XiTlNxUnSBdmw13MZRuw/1I1Xyt8fAIoA
         ff5rwFt6Rhm36BgBiRLsa1pE8pHfeH21f5VO0SyORW9rMROOrfjrgJJzUlv1f0q6qd5o
         QnWUawxjeoYV6mDiQ1Fn8UWRz4n5djTnfOw5R9O7S2iR2PMJsZHgB0ru3lqtBpAI/scF
         g47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786364878; x=1786969678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/NClb79ZSs7I6mtD0/TeuhuRiRQUYabQMsnzpCt/nU=;
        b=Idwr+PpPNMiIBwU8PEuo/nglWbJxEYWjL7vh36OgAutrw60YGhnvUKQc8B5YbaTDv1
         OVIekZjIKPZdNdsS45WxN3tGpAGCD55eLS0Xoe6GBGywvoP9NG80qTkc9vzWCrOdJcX7
         C2QdRCgtwDGIplGswl+/6CxYydRiHxVTXq0Azqqz2I/VElAK1PXMMVYx9Gy3F1JAsM0y
         MPRGc9Q4SonFJom62Dpnok0j/K/xomOtr5iMYTFRr3rlV7WkvR4CcDC0Y2z7/D4h8UBx
         eXVoLufXpmgll22hIr/Jx6EIYYu9Ck6wihS9krIMXrC7rdjfX0k2pTpdUSkOh3pPE2oP
         /hjg==
X-Forwarded-Encrypted: i=1; AHgh+RqsMdPx3MSEIaR94bCeAk+RbXQDbrNImn8jykcH+A0BmCti5wEa3QjT1rFBkGr5/mR8pNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPu+x1MgWyjI23ri4TL+A/2B19lQ8CuxsI6IMe/eRc6eUc+IzN
	27+iYQ6DNe5xTolNRFF5pUnyxRK9v5kMD2H89BW3rsVKeWbeMsN3K+ZLdFiQnU1iWW2OfjgRrBx
	tiQzbp3wcuwfgD47AfVIqmw/IDQebUDg=
X-Gm-Gg: AR+sD13gfbLZ56JQqpLHm+pETHiIoeDQnAok2b2WZWDx2SjEk+zMnvVkBTbVGKRiHqq
	AtDKxmJrMTOUrjNoQ2A/ahFe43tVZv5nL4b3TApXf0rWyN/bEbiYqSOVr6RHfXrxcYPwhWgsZyq
	zRV5CNUtGmWOTgmZ7KVh2MaYLMF9TgfXtGRvWkYuo4FXApA1OZD9nflRd2uXlQMwmrHEGh/nvzY
	3Vag218yREJy+A+vrCgh4Au6o9RazbRWwQ9OrA41dmRPYSIPB3GdSurF8f+6+RqFnAFF63s4agO
	aHMBaH2zbqTQNXMAuS+p1WX6F80dWqjgSJHvuKhIKf8WEe0llzBP7Q97NV+nOasNGp9lcLQIwW5
	xYZPhjpnmChvXGJRJC0057RvoQBkWZ9Cc/zLbjdu/1FNdLUbSqKfc+Io3IdPWy0nOmubeeUyReq
	J9imW2tQwj5Pa74fxdhOR86b3bILMPKQ==
X-Received: by 2002:a17:903:18d:b0:2cc:9179:32e with SMTP id
 d9443c01a7336-2d0ca759b87mr460432285ad.10.1786364877728; Mon, 10 Aug 2026
 05:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
 <xmqqv79ld40c.fsf@gitster.g> <andZ2eIe6RXifor4@szeder.dev>
In-Reply-To: <andZ2eIe6RXifor4@szeder.dev>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:27:46 -0400
X-Gm-Features: AUfX_mwPnixht07c84KbuJSXP6HXZ60221R5GJrq1KZosgl3-kqjlnjn3RlQ-sQ
Message-ID: <CALnO6CBqJT6uHTXvgffB9rW458THr5LjzL=NZSt81PPfBATPyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Tian Yuchen <cat@malon.dev>, 
	Todd Zullinger <tmz@pobox.com>, Patrick Steinhardt <ps@pks.im>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:31=E2=80=AFPM SZEDER G=C3=A1bor <szeder.dev@gmail=
.com> wrote:
>
> On Fri, Aug 07, 2026 at 02:17:39PM -0700, Junio C Hamano wrote:
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> > > Racy Git problems persist today, manifesting themselves in the
> > > performance of commands like "git diff" in new worktrees [1]. We have
> > > long had a build knob "USE_NSEC" to tell Git to use in-core nanosecon=
d
> > > precision when available, which mitigates most if not all racy issues=
,
> > > but most builds we know about it don't use it. In part, that's becaus=
e
> > > someone distributing Git can't safely enable it at compile-time if th=
ey
> > > don't know exactly what platforms their distribution will be used on.
> > >
> > > [1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoS=
EuPUh-yoeK9TseQ@mail.gmail.com
> > >
> > > These days, most platforms are likely to be safe for the USE_NSEC cod=
e.
> > > Regardless, we want to give users the ability to benefit from it. Thi=
s
> > > requires exposing the compile-time gated code as a runtime option.
> > >
> > > In addition, update the Racy Git documentation and other mentions of
> > > USE_NSEC in the code.
> > >
> > > Best-viewed-with: --ignore-space-change
> >
> > Don't do this.  It probably is helpful to have something like that
> > below the three-dash lines, though.
>
> Including this hint in the commit message could be useful for anyone
> who stumbles upon this commit in a couple of months or years time.
> Whether it should be a trailer or not is another question.

Yep, the trailer is a force-of-habit for me. I'll move it into the
commit message body in the next version.

I do find it helpful when the author of a patch---who presumably knows
the changes best---provides some guidance on making sense of the diff.
In this case, some code is re-indented as '#ifdef's change to runtime
'if's, so ignoring whitespace changes makes it easier to see there was
no change there.

--=20
D. Ben Knoble
