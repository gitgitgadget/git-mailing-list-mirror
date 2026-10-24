Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792855360;
	b=tD9LSPiaxykat6GFpmX8ogeRfyUzfyknuWKrhWDBlesN352HL8mwYaxwY7+p8YggqP1z
	 NwgMqhnNrEhyiyUfoozPJAtWVGD9dBFiojR3Kp6H+pjmNeG1KwOMiPsgPL5y+1JaxXTvJ
	 531pYAMjn2IMZWvyFYtbTubdEcX2be5ZKL3if9MA8nVc/o5VRR+PeDhOnlUFw7EXaHeg0
	 CGr3Ur4+mdTwMzoRwW4lM1JHJw3Lz1LaKtOGpzMRbNV0XkX8VlTf5IsZEtCz9wosHEK9t
	 Br5aBZGCO7Lj95d/ViGsLEJ3Ev+o3OwxRTvRfP+ihnzna4azcipzMT6DxJtt/tp3PEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VC0RjtMhfypSDX9ZhJGeGqLnoLGXc+JS6O1j6uS0qSU=;
	b=rX1J/0mmDBhdlr4A3pO3gTnXDzAWYnjmhMjuN++7MWeEmK6MSyMdA1wt8qNBj+gKDYn/
	 7HQkZJ3UegGdzc/+qQIcLFSvt2XuacLDQcYdIsNphGaJTpbWi6xArUfd2Sd0pAmr5c3bP
	 ccWYOAdx2VChlchfHUJdWpXNt9yA4KXgWBJlAL/LfFR7t25XMxdwuf4GWySMpQWRVyO4d
	 f8iOr1+4FBrk72pzJCXE0MkbxXxKfGsLX1bvSFP15WdqN8jtOwUVFiSoN61c6V7cBG8JY
	 d8mIxd5gFA+BWPR/UqYihQkW0NzEClf/JKGxwqUbC43sHnnScbsmeqvmpmgSd2DuJ1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jD9EQAJ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09029606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09029606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jD9EQAJ5
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so680796b3a.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792855359; cv=none;
        d=google.com; s=arc-20260327;
        b=Zjpk6gMAp3igJ1lyfnXEI4JPBu8ueSWyBZfvZtb1dmXmBdSWrAo9qakGyFLr33lZHx
         Ll+MjJ74XiCwqn6yveAOynaXg6axyfJuJVZawMySoFll/4csQ4sdniEXObJFb6Y1C5zQ
         3hwzFWwCa06PMlext9fwDfi3GVlUyVIR9I8vXsTFDkOzawu6lXf78JDPFPwCcp1bZa08
         iL/YpLHGwXgcvCipYx/2rCbw8GgHMk6b+k3PsCoNd8YV8P2uSkLWd56LAlHyRfFFHV17
         5hTqrD0hYSIHtmwP5fSVH9xHwKmEHH+SMgpRONa6xqW4OObxjLPDsTMRRZoFix1qXAui
         jK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VC0RjtMhfypSDX9ZhJGeGqLnoLGXc+JS6O1j6uS0qSU=;
        fh=30uhIBVGkGd5Tb9+T5yCic8YLwdJaQ3n04mqr6/PeT4=;
        b=mDPdDJWvmMjfmScA4K3+Opc9v/gwyCX544S3YPB1gjBKffyLM4mCw9fomdtho/TKve
         hvIOO161PbOU0RmBdU7cnB0Us1bz2obLmvLsCUkBjGRFQVaqTbO5zUxdCFkH95xlD5O7
         I9iCS+g4ZoAO3B5etLrS+C11GZn+RX1LNjnh6RPvqqp7Ko9xe+2QLX5C4CuGWF5BJ4qD
         HMb0qngGViDXv549oDAMANSiarqK1V5W911/J3mYR0aQOEhhz3xp8cgA6/PFDDwkuNDe
         3yHpTeg+8MxTqnFWjIMGUjmbcKF6RUMCQmIGJ6OU33v1k96WmiMRzmJ91cbc9cDiJNRo
         Tc/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855359; x=1793460159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VC0RjtMhfypSDX9ZhJGeGqLnoLGXc+JS6O1j6uS0qSU=;
        b=jD9EQAJ5SsHJopbO8bMpn7NFaoHFGUwrEb9pCYTRYr2Z0zCRtTq+qUAKaxLsxwYGOQ
         tTxTTCMFyi+d214f7X2yhZekH+w6OgKMF0KGOCS39XE+aZ3aXst22Jw0Y+OOLJQ+XW/K
         3JguRPYwLwFcGcADZLylVUcNfhIMWwNqk07qUMWOlPelMqYdIbvLwVSF44KM0WKwGpm/
         L1F4N8G9yzzYLkVqdESMwoBIfyZ4lr0RkKvtRhELU9fMF881QC/mbbWZ/XBEAxp5MYZv
         /bkP6raHp8fps6mkRLVGVS2h8IJZU4gE+nDML79pcaQbk4KRji5RaDpB0uF6Kz2VFknU
         MpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855359; x=1793460159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VC0RjtMhfypSDX9ZhJGeGqLnoLGXc+JS6O1j6uS0qSU=;
        b=pYSW4sxx259T+XTmsHnjfxD3+ryrykbZtqiGZ/MRsbNG3I4kWF/iJfnFAHzqbSZgWt
         wbHlks9DQxZafzu/TTaES3ddNeVpw7G3reTu0UM/xLAhlr4MYzZy5ieEOiykE4nJz14n
         tpyr4BiPrHb42bspQz/x8NzrxsIJbsyWGBih6W6VyKrEAgYgJDMs1ioklp/ZIRLzCA8k
         sr5RvbF4owM6579oZk6EyAI7dmvfLHQtNXSgfTvxt+8+5PgNSHOyHcz3RIBeXgMpDFm0
         XFo9QnAVZTWDp4eqJ4gcQVOq2nBr25S9uxFwzy6JQgS5TsSpChYGxvZTA04XpUkLBeHN
         nNWg==
X-Forwarded-Encrypted: i=1; AKwUvBwAm6v7MDdjCa73rnl/zyT7AHUBDBmFBeYV253VbKbv8LDg7m54mVqaoH+MSMGdoAskVYc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLl+CkpPuqow5e+zv5uQE1+K8hpC5qNDtQ+j45CpiE7gHpuYknt
	L0j+BWiutM8ZT6m89ZHhTAxP/7+CHYf2qd1FDclKuwjEG0XdiP8KWxH+gHBi5zQ3cTrC/pGf1Hq
	0mGWmukz1KMtmyXAZtbBjmXFnR8GmuVVNIR/+
X-Gm-Gg: AYBFou2KWGJJQjFyfrnycM0iQkiVvLEtzt0E1EcE+M6m26ysWxNnUCpM8yoXCEVoYRD
	/f45Imz0tMxf+q9ZE1c9bBIjijZVfi04CxjnEC7ry9O5i9iy101dhGbEctJTuh907SyHcfUqnfB
	J1O/fOQd/knA5DhGb+ViD8Drl8ZmC8yRqwHVoOcFNmbj8rdlQHzsSqb7nmzAkm/Lrdwv/C9xxGP
	aP8guZ9kfj6iE1m1/KJDG1YaVkj3tXrsJGy6aTH4XgkxhOJdHaxn76dTD2IXMsZGG13L3ojt8Cb
	g7wEz2sQ7LtsxiJ+WLg74ufW7+e+KDgpKbJ+hNu0+rcAr4PpzQi7jA2BlSgnOn8KiOg79QzdX1L
	gEHgwQcSQRGgIh01iSOO04l1kaqtBmRSkAWIU/vR7Z9BG4IMJxILgBx1SGfX2L86EulBOXSKUpw
	52S5+VsdNoaPhr1LY/Ih0/SDNdAQfLO1E94XZuQQ7dTbM/mhONkzq3
X-Received: by 2002:a17:90b:2745:b0:3ab:c674:cad1 with SMTP id
 98e67ed59e1d1-3adeafd682bmr2046387a91.50.1792855359260; Sat, 24 Oct 2026
 08:22:39 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
In-Reply-To: <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:22:28 -0400
X-Gm-Features: AclHuK_pQUqNCCWXHtwbTe9717bsbTP4BxEuvkVnFCro0Ryfn-LIHaWFYq9HwQo
Message-ID: <CALnO6CCtm2PLOfnNF8p2aGU5Pn71qimdC4aAS130O5PrzQb_oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 9:51=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Harald
>
> On 18/10/2026 19:27, Harald Nordgren via GitGitGadget wrote:
> > Create a better reflog. Follows the discussion in
> > https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.
> >
> > "git reflog" lists every step of a rebase and every branch switch, whic=
h
> > makes it hard to see what was done and on which branch. This adds two
> > options to "git reflog" and "git log -g":
> >
> >   * --operations shows one entry per command, folding a rebase into the=
 entry
> >     that finished or aborted it, and leaves out entries that change no
> >     branch.
>
> I'm rather skeptical of this in its current form. Not all commands that
> modify the working tree update the reflog and some commands such as "git
> cherry-pick A B C" create multiple reflog entires that are
> indistinguishable from multiple invocations of a single command.

Great point. I thought it was very neat that we could make progress
towards this simply by parsing out existing reflogs, but it's always
going to be a bit heuristic.

> The
> message you cite above is arguing that we need a separate operations log
> if we want to overcome these problems.

I also thought this series would be doing something like a true ops
log, which would be very cool.

> Most of what this option does can
> be achieved by looking at the branch reflog instead (I really wish that
> "git reflog" defaulted to the current branch rather than HEAD). I'm not
> opposed to supporting some kind of filtering/simplification particularly
> for HEAD, but we should not pretend we're showing users one entry per
> command.

Ditto

> >   * --historical-branch decorates each entry with the branch HEAD was o=
n when
> >     it was recorded.
>
> I quite like this idea, but think it would be nicer implemented as a
> format specifier ("%gb" seems to be free) so that users can use it in
> their custom formats. I'd be quite happy to change the default format do
> for HEAD to include the branch name after the reflog message but I'm not
> sure others would be so keen (perhaps we could get away with guarding
> any change by isatty()/GIT_PAGER_IN_USE?).

I'm quite a bit more positive on this change, but I like the
composability of a format-specifier. Great idea.

> If we're going to do this we should make sure it supports "git rebase
> <upstream> <branch>" so that the branch names are accurate. That is a
> bit involved because you have to compare the name of the branch being
> rebased (which is in the "(finish)" reflog message) to the name of the
> branch that was checked out before (which isn't in that message so you
> have to go looking for a previous rebase or checkout). It also needs to
> take account of rebases that checkout a detached HEAD which don't have
> the "(finish)" message and those that checkout an up-to-date branch or
> detached HEAD where the message is "$GIT_REFLOG_ACTION: checkout
> $revision". I've got a patch [1] that fixes this for "@{-N}" which I
> think works, but it needs some more tests.

Ouch. This definitely points to my "heuristic" above, and while we
could maybe invest time in the reflog + parsing to make this work, it
seems somehow simpler to have an event or ops log with more structure
for this new purpose.

--
D. Ben Knoble
