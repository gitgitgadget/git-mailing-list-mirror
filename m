Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225C19004A
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562979; cv=pass; b=jVydEcaXwmVGvONcodskf7bnPD+uu8k98e3Hn06y8I3cbu9eOMQUlj3kKHHAzy6Dlo6YndmzQNPrHlJbZwHQWsn7JjWSVHu+mkkFhUQ3g7TzTyAwf+PdVV9jfUOdBYWDazt+mZG36ZkUgYYNctSrvlBHmgUpBAC7v+CefBUixwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562979; c=relaxed/simple;
	bh=PESsYx1qFkqvXOaF4mtYlMeAsfD4BxU5SJegtIXD6po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnsDX64VGq47mTfFIq5/Ur3lnsLx8ZIVo+a/wQKqldmR7NmvWViZLfHT48xR3JEynPT9tHQHevMspxTAPSRmDlv+ncjgTMfvC6zd3satUO4YARSKA2p3375I4sjNmAyCcencqQ0xkK3KiSl1E+Qvlj1Y0rx/3ncYRkBOJRioopc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Z/TCI/JX; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Z/TCI/JX"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c2cd216c9so4925378d50.3
        for <git@vger.kernel.org>; Mon, 11 May 2026 22:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778562977; cv=none;
        d=google.com; s=arc-20240605;
        b=NvBCPwxjeCnCqZSmxo4vrtyNt32vzX9whQCxy4l1uA6Vb/qY+nKYLkXlAHt5riv8Ol
         IIjDa09Z/DHGSKB/Qj/HP/CM7htZk5Jk+VpDe0gDhRW/8+DFqc8me1yMCi8AF2rPsU59
         eJ/BmRO2wBbC8Cpopmqjlq5UljqypCP4jIVTVTu16iTS6z+mxJghYkMNhDT8qcF9qdaW
         bbozIdr3Gc46ixK7hoNHBwXSiPm3uoazn+e+0fJDCpLyCt77Wpa+Ge2MUMK2KLNIERkR
         n9PiUAy/fwNyjGat2TQtjtwJQmVPcRZ608VCqF7fzXKXAHNh7oJQp8dUD92SluHMI1Lq
         ItOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zfB+SZGGwmXOinZqjf13gK35heS3QOD4N3WwPD5GoO8=;
        fh=Jmu2Ft9BV00bhn4uLun7mcytFNigTXQx6+y5yC8Z5Js=;
        b=DfXO+B0MqkhKGTWHw/anUvQDac7g2KAxfVw3FdtaGbsRUaECS1ns0Y63YgmO96sPCz
         ppPz2ESHeXBw1fNL4o/0DShhw44SSdgToXcVH/dhh1AB3h37/wByiqHdF6t45mjI0Wmu
         57NplURdxul52UQ+j0xyyni5i7U5H2Wyos1LX78X+zoh+msVYHC3vi83JetCUiaaMc8h
         aKStsKz81GbduuQnzE6mYXdS5Mf3SSYSD7L0EbWAx1CWbue+MU9PmJvMm+KoE/4MgAJt
         68kdhWI6/QcKQ1Gbz2SxAYJXWXORkSY+V626gR503TgXVwSGr0yOYF0kq3rH/8AsbixJ
         FTxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1778562977; x=1779167777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfB+SZGGwmXOinZqjf13gK35heS3QOD4N3WwPD5GoO8=;
        b=Z/TCI/JXRl5/N4lVKVNSDKklUlUI5cqL4er0GYDxGEuu068yfqvpj1b69raWXBExBK
         cgFGkhTd/hd91ibdy9JgvIwUsTCE8QHww9AxackAFIKOFQwKpBo/wnzS9Si6JsUuG+CS
         MgbB8NmEYBXXGmsrN0yMFFtN2G132PpR9Kjvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562977; x=1779167777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfB+SZGGwmXOinZqjf13gK35heS3QOD4N3WwPD5GoO8=;
        b=Uul03VWQhZkWxWIYfrYDQCZsfLmXkkWaQ/C6xf8fguKrkwqvG4G1RNpinv5c/kFCvV
         Rbr2SSkGUtQ5jIksDKLKhtHm918r3uiaToAxqL6yYQd8meF9iWNzP7QOIOPegYWK+wnm
         p+wPLNObRJcD+J9AmVn1rZcPWrDCElioSn+rX4kYW7+ZhpFjrjtqRohGQXEmXoiY0DrD
         TMbijSEGhn9vWCllmHaZjyjfie6fKod18LZKa/XUfckqOIz/bgMSuYPUokocAu/boL+k
         l22d3cmx0ng98/C0dO6eAyac1IfTh1BaxaqODUcm6YYA7uszJY7UxXSyQWDtnl0M6pol
         Nviw==
X-Forwarded-Encrypted: i=1; AFNElJ9Uc+yqMsFayvv7GEdJ19AWz7qIvVK2oFxV0l2VrbiFECq86uUFZz0EJLtqWBQYdjUApzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaAfjAPWNP2sv5pUFHqe5tpnCPRZ0/yelBg80kj15iHpAwDdd
	yUI5cve5WYNeKsiPZxRXzLN1lMfVRAtQTzXiF5nHzgUmFFVnh7DT/H/KVOv6Yp+K8V8tBiejCNH
	0R4uMsod6AbtGZZ9FgEx3FiO+VuTHlYS1MxT6s76rag==
X-Gm-Gg: Acq92OFJwP7GAaSNlnkxNa4EM0Qc0UEXbC7+laYHFvCHV9byCTfki4v61p1shpiWBC/
	Q0rIlcgEtejvIulOAWFqFYeQxY/yZqLWQvM4kQCniKS5g3X5BpvRqDMD61hxjS9NvMkXo5fB5fb
	LrvM1CAJvH+kskHDsvo75r1XPHW4aeOQq5Q0fIWRfViGgluflwbJGwdsb3o03lKXnPsNTOmH2HS
	/hGyaRINRhjVe0ZfR1cULQUZOnrtd61O+FrufKX9XK6Jcc0nvhKX90TEkicMRe9YrjcYF6E8CSP
	ZiFByYbY
X-Received: by 2002:a05:690e:d8a:b0:656:80b0:2d2e with SMTP id
 956f58d0204a3-65da84d636dmr11692495d50.40.1778562976715; Mon, 11 May 2026
 22:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
 <pull.2109.v4.git.1778504352.gitgitgadget@gmail.com> <19f1605067e26c8e393c6c2e341844bcb3dc1b41.1778504352.git.gitgitgadget@gmail.com>
 <xmqqbjelqx2t.fsf@gitster.g>
In-Reply-To: <xmqqbjelqx2t.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 12 May 2026 07:16:05 +0200
X-Gm-Features: AVHnY4IizaWPlcWFW-xWIWWBzbmCyPuBABhjbHpwmMFyogqQKrTCmryTSp0j7Cg
Message-ID: <CAL71e4MiOCx8OP-OjDoS1bPgDs-0yzC4v6tVsg9CLp2K-okQ0Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] commit-reach: early exit paint_down_to_common for
 single merge-base
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Thank you!

As for the difference in variable name, I will attribute it to a mix
of oversight and personal preference to keep variable names short if
their scope is very small (and longer names for things like fields or
larger scope).
In fact, I might have preferred flags instead of mb_flags within
paint_down_to_common but it conflicted with the existing flags for the
commit so I had to differentiate them.

That said, I think it would also be fair to rename it to mb_flags everywhere.

On Tue, 12 May 2026 at 02:40, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
> > sort to the top of the priority queue.  After those, commits with
> > finite generation numbers are popped in non-increasing order.
> > When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
> > with a finite generation is therefore a best merge-base: no commit
> > still in the queue can be a descendant of it.  Skip the expensive
> > STALE drain in this case.
> >
> > Add MERGE_BASE_FIND_ALL to the merge_base_flags enum.  Callers that
> > need every merge-base (repo_get_merge_bases_many, repo_get_merge_bases,
> > repo_in_merge_bases_many, remove_redundant_no_gen) pass the flag to
> > preserve existing behavior.  git merge-base (without --all) passes 0,
> > triggering the early exit.
> >
> > On a 2.2M-commit merge-heavy monorepo with commit-graph:
> >
> >   HEAD vs ~500:   5,229ms -> 24ms
> >   HEAD vs ~1000:  4,214ms -> 39ms
> >   HEAD vs ~5000:  3,799ms -> 46ms
> >   HEAD vs ~10000: 3,827ms -> 61ms
> >
> > Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> > ---
> >  builtin/merge-base.c  |  3 ++-
> >  commit-reach.c        | 19 +++++++++++++++----
> >  commit-reach.h        |  7 ++++++-
> >  t/t6600-test-reach.sh | 40 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 63 insertions(+), 6 deletions(-)
>
> Very nicely done and well described.
>
> > diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> > index 9b50b4660e..a87011c6cd 100644
> > --- a/builtin/merge-base.c
> > +++ b/builtin/merge-base.c
> > @@ -11,11 +11,12 @@
> >
> >  static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
> >  {
> > +     enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;
>
> Curious that only this variable, among 6 that this two-patch series
> introduces for the type, is called "flags" while all others are
> called "mb_flags".  No need to change it; the comment is mostly to
> show I did read the two patches with reasonable attention to the
> detail ;-).
>
> Will queue.  Thanks.
