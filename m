Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B74AD7D6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269860; cv=pass; b=jaihTXJ+XwnOKXNa/IsGWsqBrpotmyIYzllNnoKCMr6wrzre1ehkae9b4iIBu38zWYS8Kk6uKzmxcji5L63EGIstV/SSQxW+QLjHRtX0sm4Eh97N1CWlJVGN4Yv2kSGVjE0Ba3/w6OcGVRs4nK4ZAb0LLmT2ZtWwbztlAAj6uYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269860; c=relaxed/simple;
	bh=bi3JMvzw6mlC/jb0+2hrqZTwslwVy8pHpochO5cWhF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reExm7lAcYSFKtcw/73CfJqltLdmJdpskNCPrqTHsRPMAwq+lZDFGTCihp7k4EobH0bDa6VbOw1BGR6kUnpCi6Sjjy0GzB4096+YPJyfCBBnAgj5lJEHkFEnh4hwgbqkhc6rQE//l8vg80/Oy8OodlaB3KOCqCyudfYcdy/kjGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbMggQs5; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbMggQs5"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso111269a91.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 10:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790269859; cv=none;
        d=google.com; s=arc-20260327;
        b=IRkIQ8dmH0zzVYCpOkix1HVhTmEt9OKMioTuwlmZzurT9N2S2qk5IOth94NxhWGRBk
         yUo2we1t4jvlTHqQU7W2rgAmaN3FVWTDT1CQjqjgBzdStKGFa4HI3ACL5wv0h3+zIcfU
         NW6Uo1q5K94z1iG1zHfoybmDHQehUoUo0tRLS71bWbhBF/FgJYxg5ssrfmH/URHgHw4k
         Ge8EvUi+i7xutY+xIlDUnpvzYzkzcw+h7lmsoS4ySUHFL13C3ce+SFO2PQrCd0ejkaUG
         2iFAeuOTfXSol7/F5yyeYJuoO4ODn2Gzsk/MLFOmK3lRcDvbpKx2JASkf/F8qZKhP6AU
         cLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1N/JDaLGYKPouu572b198OJGxh+JLkoI22ShJW6E3k=;
        fh=+X1ghTQeOz9Pov+A+SkScp1W3Sq+yov90ZeObLIoouc=;
        b=rdqBAMCxff81gOypgBIynsRw8fdCjS3gX0hXDzrAaF4B5WdRtT9wcfOGf3vdiWmLKT
         kJPOhRCPVknyjvk1FTgUK+EIw1ieD3L71zihr0Lwq4A5qL8jomK234dnZwJgxCDQIARQ
         Wbj/A6UlzdnswNgAWyUdysTYmE9GalHICMg3euVsLIoVDwjKzQV2poDg0QO9DSf4CMNz
         egvv3aE/hwAEGDf8rfdtBtV48wORZzEouPuOV5tinG83ETjbLY3Y52uWZYsnncZb8eXg
         YXr6WPuwMrPDMGN2rdrVLcZ38h55ejXeTstJJEAakSlXg67zYGSnUw8wSfeutm0byGSK
         yrDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269859; x=1790874659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1N/JDaLGYKPouu572b198OJGxh+JLkoI22ShJW6E3k=;
        b=SbMggQs5WGelCmYNom5u2BKFFevakvOoYCyG3dCDAN3CpY0DuhKFlDYH7fgykbGmjQ
         AWp4vwSbhRoInpx7Ab2bwO2jL+o8ju4InAY9ihtt2Zgp8YwouVrkSgHiM6BdcOsOTA6V
         ElQUZDYnqlHVT+x6m2e4Frj53gEVuTfFaL4/OJu/PWsOenHVfElZjqZFOMJcHgY8zq4A
         mR1U9ycC5Q/ORQzHCTorSlZ7oMwB+MpsUH1j1HQ7Z3URNmz4sdtB1kiv8Y5E8DpyKPVC
         XJQB/Yvfgi2w68STqN5YESG645lQxxqWkHriGYWuibS1JbJ/MyQPMDLKo2UY91zimnEE
         8bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269859; x=1790874659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1N/JDaLGYKPouu572b198OJGxh+JLkoI22ShJW6E3k=;
        b=A6FEDtKTkhlIPpS2PaOflnEwDe2OUFOplokjEt8wumcbLqfZBU7DJMP+YAANsgr6pb
         esFygkilo3AolYfP/4L3sONcnGvylfhXRIIUuT+A8/zpr1KQh7I1CLtryeMx+bneyoi8
         snGO7C+Ffq7wEdH8ZzUwt8NafGTjdzgFGDwWJHTGbLNcsLxYRNtrmr6A477l7OkVkq+1
         fJaAbXnY9hazQmOW64kGqLrt1nY/8OJuq7NKzmCovt/ObVGAabfk6lvYMqehCWfoWfNM
         gVICbWKClFUz8iLbQGDlmiGi/TFggf7vV7NwS6QCYo3/B+b7x0kv7xZPGf44Dp3GkSk1
         pSQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDe+nwc4I854Vj23CteZPUtGRufh+XVmmzb0NfD1My1j5UgfoXo33MQhjLhKUsoKpChJU=@vger.kernel.org
X-Gm-Message-State: AFuF++lSuzUIfoiYmb7alXcF+3qqTwUk0eQxePdAf6NDnY6Jsq+HAqtb
	UFJI3leAUjTuEaIn2/tVlDu0Ys0hX28BzEsZBE80GSyBOUjDg5J1uFf3/p/eNAjFWQ9rgCqgmLi
	Dh9VFtJ+mtOnoStjXflhYRe0Yno390u7Cyg==
X-Gm-Gg: AYBFou0dwRCwET6u5GHdFns57uisDrtAIASIAsDhgWIG40C/qechJ0GXUnn7z6Hrg4T
	3AzVjokzrrGRvRMh9svBjb28Bfk8vGk+YeSow3EvbPehSFjJ38wPzagWLKZuveCOLARs8TC4u31
	QPHuZCr+wEI7LXhYjGknfn3nCYE999T9oKBBLKvNKFVh9WsM/f5qWzdbuSxykOF+BW9MWk8NQc9
	Hf8SVKjPqsKAL9KnIN9PWYk7nFalNBkRSeWYwUhiH8Yqi8PKr/IUBC9+Z08XLnnpNf13Fzjk+fH
	TkAUllJDs8q+jsFg5+dMSL+O4csTJpwu2QwZzwLKPwlTP/xlyX4Gs1VwBzhnbsj595Oi+m+MRjJ
	XWHjjWMpHtv/qobfl3fUwYWTQyqejvwftFy3zRIr1OZO0VOaBbvXz3hOsqbQdbpvVMrOpTadLbj
	gU3nOoFNg=
X-Received: by 2002:a17:90b:4fca:b0:3a0:910e:84aa with SMTP id
 98e67ed59e1d1-3a098d45437mr2734023a91.12.1790269858886; Thu, 24 Sep 2026
 10:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <xmqqh5jhfbyw.fsf@gitster.g>
 <05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com> <xmqq5wzwc76w.fsf@gitster.g>
 <CALnO6CA2DXvyOO+fu04sozg2=E0JoymAqyhs_heHzExgRSEzVw@mail.gmail.com> <xmqqbj9nagt2.fsf@gitster.g>
In-Reply-To: <xmqqbj9nagt2.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 24 Sep 2026 13:10:47 -0400
X-Gm-Features: AclHuK8-5ThVZASD3Bc0TqIiwcEjSJ0UMOSV4xvDnB1coAABguOQ_ns80bb1nSU
Message-ID: <CALnO6CA5b7mpia9tkiOENdOKcOHF4errc31wuF5n5-=rrbHxVw@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >>     $ git fetch second main:refs/remotes/second/main
> >
> > I've wanted something similar for notes, so allow me to interject from
> > the sidelines: it would be even nicer to still have the ability to map
> > fetches (so that "git fetch second main" did the right thing, creating
>
> The thing is, the command line
>
>     $ git fetch second main
>
> has been used for the past 20 years as a "single-shot fetch" syntax
> that expresses that the user does not intend to keep interacting
> with the same 'main' branch or even the same 'second' repository,
> and for the "single-shot fetch", it is absolutely the wrong thing to
> create a remote-tracking branch.

Yes, perhaps I was a bit cavalier about that particular case; but in
your other message you suggested allowing configurable refmaps, and
that's what I was getting at previously without having the vocabulary
for it. Thanks!

> It would be even worse if we created a remote 'second' and
> remote-tracking branch 'refs/remotes/second/main' when you ran
>
>     $ git fetch https://ho.st/second main
>
> Having said that, I suspect that the fact that you have the
> shorthand 'second' (i.e., you have "[remote "second"] url =3D ..."
> defined) may be a good enough sign that you expect to keep
> interacting with that repository, and some people might appreciate
> it if
>
>     $ git fetch second main
>
> created a remote-tracking branch "refs/remotes/second/main"
> automatically.
>
> But we cannot suddenly start doing so without breaking people's
> expectations, and without a good transition plan.  We need at least
> an escape hatch for users to say "No, this is a single-shot fetch;
> do not write the object anywhere other than FETCH_HEAD as we have
> always done".

So anyway, I think fetch.<remote>.refmap is the right thing here, thanks!

--=20
D. Ben Knoble
