Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DC2ED843
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786768599; cv=pass; b=Rcs5mCz7RuNztsvauWQBiOwVLecx0JGhare+gWBGoriK96cbe2nD+HoshH2ao9hCP/CNmD5zStiHztsUBl5cr5Ud1VPU/CzvCGEfwwzrQBVNgACNE3EkFz5bGcbXUdfi4p5TxH+j6lT/jYwIIgJ+Fi5B6KF824NsJTYfMR++jfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786768599; c=relaxed/simple;
	bh=pfy7axCCXbq3JISbi327izF6MBsIVQv8X5xDTJfzBdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPajlEG4bzNyr+ah5adh+BYeoN6plBewsKpgRncCQOBaCmnPD3OMvtNj69GrFrSPTRiix+b5gkNdW1dc/npmyNmE7NSJYN1K8u4hzSfxS/9FN+ArTD/3KfQJMcaRIPiN6O+dHLU+z8xkMbm9Qi68C1fPI5vjlndLUz6D5yt6y88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgRARaxu; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgRARaxu"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-936c02e58dfso111237885a.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 21:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786768597; cv=none;
        d=google.com; s=arc-20260327;
        b=XKPXU2JpNTMDc2VLRb9D4vk0gdIbgazmHL4ExIzO/9ckSb654mjtJcGivf5rA+0EM+
         NeM1OawpDmAic8EWhUXDS3nasDEWu5uiZ8CC1CO3OgjgU29DrN1rEe2yGks1IY2xNYe8
         NdFC4mSTCCYYG2mXaE3Qd+4S6m3qp/7UuFpFZCqfIIb0XpbM6Y3kF9yQyYo21hwYrh0F
         /M+g2JBvERgz1FeRTgL9Jwdh0hKLfDXzMT6OOCTAChpzA1+Hg1EuKxPstHg1BSfKsXYr
         bxcHY5P3a3ACboAP3+5n6jFa5Lgqquq78AjitKq89JwHY1YXEOmbLDv2T13YNAAxuNFY
         pXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NvME3OH4RoqLRp0c+zddbWOTL75b8+Gdyf4+8aNDUJ8=;
        fh=COyj8d6quMzpuK3QR/Cr6DleK6Uk2+oOlFqtjMSySAI=;
        b=nAWCOv9b1Vl3i0c1znLzM/ErDn+TMA7d99ejvEIII4wmgjNS9pDElLSDN7ZOYX6upm
         TmAj7j5jixDmFVdZkWS0A7ILZW8D+O6UgwPe4kcV9imizY3sR16G3ewyUCEkIiD0xHMC
         t8x2B781HY0swwurtNrwEPKot7jSKI4BrsUunRKjI8B6z02oWRe4Kf7gBTHu7EyAdJDm
         UIY/tqpaPZSfInTU5DC7Tu02ns7PX+X9xWgzDlPU8PrV2cMlrx4BriXXWbmNo2xfTTk3
         qtXpVHpyREg9rzYN0n7hECbTX4Bt1tE78S3MNhucOfTvTLT6xW5i5LvNaUVNyk0n50QS
         +74Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786768597; x=1787373397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NvME3OH4RoqLRp0c+zddbWOTL75b8+Gdyf4+8aNDUJ8=;
        b=lgRARaxuG9mpGIQuopbm2HVYnHCwvmiobhgECPesT7SzB4+giD65DxwD7FV0DXV0np
         UNqmr4CRg1ZlhL2vfKcYv+ouvDE/7LR+LPuVY/HeQUU/y/eL7UQ2f6HIaooA0trw6s/Z
         0m5H5+a7P+zsUDYwTw5sOf1ljHcGL1NcsC8cYfANG2pJq1bXMlFqJdUIfQUVN9z3vMVe
         hOD/13N4QkMSopQ/KleT0fSng0ItrDKqpHzPy6C7cZ9uHWvVZlSXeXeQ40CUQdlcXzYf
         k8ljyL0RUY7dt+qTWUyHktZeWPGvFH92lCNweBXoskt4vljMAPoseaZ3jITvZPf99iak
         zQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786768597; x=1787373397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NvME3OH4RoqLRp0c+zddbWOTL75b8+Gdyf4+8aNDUJ8=;
        b=GSOelo2CgKamHlLCHukYpT4eA3Z7lwJRd/01CG07amyLby8qO87TrHbe5d73MmOp/H
         tHxytYXvkDqfYOx/IQ2+EupOh98utI9GhAkloVNofbpPibg45nfxvsv7fvOBrZ/6TBUd
         m+177h/f5FnPFwYqIy0onkpTrK66jicNkt45QAxirHrxODtSwskREPU5c72pUKkExAV9
         95BTw6z6/H3voWqS21Ge4gkq3cE4Rxbp6ZfmK8kjBnZf5edw+iP2WyRU+KzYx3fCrNse
         WdtLPWJrxNq1CTJBjLa9JslI8YhqPg2tMv3S+ledEWmF2BVDOIHO86CxxJ/z/pBhTCNz
         PDsw==
X-Forwarded-Encrypted: i=1; AHgh+RpFHRos4VoFN9cjKIVL1lLVfon8ngkpwJyILE6dT8SCxeJCxGpd5qP8kBnEzfEmP0qg0GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w03T66xLm6r35dPn15vh+W9TPAgU+yRJkEck2WLkRA2IiYNW
	5m+T4WdKE6bbcn5TMsRyvTPnyDtUZBg9oc4Ymq6syHGk8LZlVLmfscUamNpn4KspsFT9OV/8i4s
	B6KSV4nu8nQ9ZHzT6ZqS1jcbQQdsfAD0=
X-Gm-Gg: AR+sD12Dtqq1eaMkgwC5yJaLZti09SiHgORr4Y6gSUPUiB8vIY38xQUpaD1M4rlN/+I
	oefZMuv9KU+Dzz9aipFCns2J+LUGabxqthIfZyuSmFaCINaAJg+S+5UQyOvz1hWYUhuVEvZO4Xn
	pXrDHa0EZayHbw3/olziOkCFYy+ikfc1W1FXjc59+XRf+nx4RKWeF2TX5Z6rAhbY4ruePC/vFpO
	P+0tWTq5mFdQrQ+T4jyHhONQlPM8K+EOomAu6EEcTffbL39ht6JliYrWwt2yjm+EUGIbpCoitSb
	cJUhdlhuOFT/R+MFnIw4cqm9c3rtE7RUjBxXjk/y04xHOPYy73iZv6ecgr+kTqd/hSj6c2dQix/
	d1v26TwFZoAGsC+poysGM17U+cJDqhfITvuDPKFw6UstS
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-936d2a24ffemr1213284485a.6.1786768597172; Fri, 14 Aug 2026
 21:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com> <xmqqecg55xqq.fsf@gitster.g>
 <CAF5D8-uCjA-MFtdBCa0+5PDb-LFJ7JJ0yK1AtuWCKEN+tKQa_Q@mail.gmail.com> <xmqqjypvw3cg.fsf@gitster.g>
In-Reply-To: <xmqqjypvw3cg.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Sat, 15 Aug 2026 13:36:25 +0900
X-Gm-Features: AcwNN1U3teH2CU-KlFurzNl_DSMHg3BQlBK51kQZzRl-u3VH702ffW9x_aKBQu0
Message-ID: <CAF5D8-tfAfjNONh8dbqxmF+kzzaQ4rSQL94DK2=TLd9_HV9oaA@mail.gmail.com>
Subject: Re: [PATCH v3] worktree add: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:
>
> >> Instead of throwing the problem back to the user with four extra
> >> lines of message telling them how to run 'git branch', I would have
> >> expected this patch to teach unique_tracking_name() to optionally
> >> return the list of remotes with that branch name, and to use that
> >> result in this message.  However, if the goal is simply to provide
> >> something better than 'invalid reference', we do not even need to
> >> go that far.  Just stating that branch 'y' appears on multiple
> >> remotes and asking them to clarify which one they mean might be a
> >> sufficient improvement.
> >
> > Extending `unique_tracking_name()` would also affect the implementation
> > in `checkout.c`, and since the goal here is to improve the messages
> > (making them as helpful as those in `checkout`), I will hold off on doi=
ng
> > that for now.
>
> Sorry but I do not quite understand this logic.
>
> Giving unique_tracking_name() the optional ability to report which
> remotes have a branch with the given name does not have to affect
> other callers of the function at all; that is the definition of a
> new feature being "optional."
>
> Furthermore, the goal of improving these messages falls short if we
> withhold the list of remotes the user could have meant, which we are
> already computing internally to decide that the original request is
> ambiguous.

That is certainly true.
I think the modification to `unique_tracking_name()` that you shared is goo=
d.

> >> Could the original request be aiming to create a new worktree with
> >> the HEAD detached at the commit pointed at by the remote-tracking
> >> branch, instead of creating a local branch forked from it?  I am
> >> just wondering if "-b %s" is too specific to one possible
> >> interpretation that may contradict to what the user actually wanted
> >> to do.
> >
> > If the user is aiming to create a new worktree with the HEAD detached,
> > one would specify a fully qualified branch name like origin/bar-topic,
> > starting with a remote name.
>
> I am not sure about this part, either.  After all, we are trying to
> help a user who made a mistake composing their command-line
> arguments.  If they specify a fully qualified branch name like
> 'origin/bar-topic' (regardless of whether they want to create a
> detached 'HEAD' or not), they would not hit the 'saying bar-topic
> alone is ambiguous' error path, would they?

If the user specifies a fully qualified branch name like
    git worktree add ../foo-dir origin/bar-topic
the 2nd argument 'origin/bar-topic' will be resolved by
    commit =3D lookup_commit_reference_by_name(branch);
before calling unique_tracking_name(), so the ambiguous warning
won't occur.

In a worst-case scenario, a user might make a typo in the 2nd argument (e.g=
.
origin/bar-topik) that fails to match a local ref (e.g.
refs/remotes/origin/bar-topic)
but accidentally matches multiple remote branch names (e.g. branches relate=
d to
refs/remotes/remote1/origin/bar-topik and
refs/remotes/remote2/origin/bar-topik),
then it could cause an issue. However, I think this is an edge case that do=
esn't
need to be considered.

Thanks,
--=20
Yoichi NAKAYAMA
