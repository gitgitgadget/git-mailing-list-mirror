Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854508;
	b=F1rRzVkAjnuZV1n+Wg234vyAr5D0loY0f3wb6VhWJph9lRkkjBSZilvtNfn+2Fv8f1Ld
	 19Yyr8BCd5JJynvC763d5pS6SBgakP/MbSO7mXmaA/feLivxhhucyVDWLT0FBF9Jnv3gj
	 YO23+WVAEQPU4S5oi7/E170wZfy6YyUkzXQ1CXc8iAU9I6NprnCue/g82qdi53qk9itVS
	 r4CQSY2/3R2bobqsH0TlCjh7bPNXxQrRwUyBaYbK8ZT9TylEyumroKp/evGgy+bJF3sJK
	 5MgXmMvgevMnxBt4FPplOP//AiqSknaF7wTZDIt2kvIfv6K81oJXJnfzIoSCXL2RQgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=poJfTtphoE3FebBH4FQPgLRGa6HjKfEcKWbMRwtA0Ms=;
	b=k8xQd80y6pEc5DkZ6NtsP0cE6szQUD3LS5KjRA4UzNnTQ3ATm+s7WcWUdfJmwVrJV2cO
	 RdNKZXdiQXK3Cj9MgD7D81YBmDOELajNJ+VXC3Qd54mAwReLS/vXdh8Kxj4adCBX/o+fz
	 pIHbR7GERqpXtNMsIFHP855M6oxY8wxanxEaogG9eDcuZIZ1gBZnE6ax2fNf7EsgrQl7q
	 3+S+JagBBQ3+qpCB43cWUaDMNdlGTJyTMEAg9ouaWesgrAGbMjQI2QzF2Q6/Oq0lGrIk6
	 e2anxDH0ZEMqJKO4Gd9S+4YawqMzP2jRmhfREUbodEqpaQJFuxs2vj0z2Kw2O2ZIUGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJ2tbIxu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA3606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJ2tbIxu
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9ae391a05so11723555ad.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854507; cv=none;
        d=google.com; s=arc-20260327;
        b=KoEVvtrVzH30+uprzrvbWtidhSmYMxPrzzrK3vaokga4Z/IWRH2P6rzI6oox4RflYA
         yyDuBNG3OyDoCDxQVzwuP5qVSZbl62Ih7LCq5lJANgrKtFDU4UO12WDG4rgkDCQfuA5x
         uZNyuvNJspx+8gSCmpXlPH1cfMfFRMNIBLi/7KZCfpgQJggkETaBjqCCNO7DcsVM+Lw/
         0liI4/f0uIwb0ibDpucdeiOWDcMzk1xh5N3tvXmQCVJ31/CwtSWQF+UZp3kIq9RlCzNz
         ESA8i5I5Vxrp0TWuAhxenD+lMjiulihAoUPAsO0Q7Qfy6c4O66HYSQqZxTNljJxN8wkq
         JSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poJfTtphoE3FebBH4FQPgLRGa6HjKfEcKWbMRwtA0Ms=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=N60hrLDJPTJZRAlscDzW3+Syx3uHUqIWFnehFeGd7TaJgusdG6wmqV90umjWqN3LXB
         ov7Vl8fHndtr9RsaaQ8PbmgyTTyDXA+1FjvF1n4HnW1G3YYybhW88nTrJI1rho7CXpRN
         dapOL5x47Fn3DupjU47pCj4/rvXs5/VSH2r3X2//5hkN5zRriG4Oe1pxElvVC1AhkWQs
         IiiH3ioiAuil5BRnns4thj+zh7n+Xk4q/OLesyxIPECJQS/2XkJBLMnZYGZbIXDaKVzQ
         Ih1Iw15duPskOynHF4pzM9WmZg90KIxvGwnXUnfKSm9jK/PChgnEyz8o+6GARFOOPZ9i
         SwNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854507; x=1793459307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poJfTtphoE3FebBH4FQPgLRGa6HjKfEcKWbMRwtA0Ms=;
        b=hJ2tbIxu1AlIolr1+Svy37UePMxLFcZlp72VlvbFxSzJwQIhtIWO3he/x6TTk9Ri+C
         B0JDqg9PAWuGYmmEuzcgM43I+a91GVipMDnru94heBAmEosponjo1g5DvKZOoogRRPnz
         5q/VaMQOeiuopdhCKLtcO8tN8/5GlRYViohgGpYw/RR5D//ichVFGB+B048fon4Bdmd9
         Ln9OGCJoMsd2DGD4BjVtYZylTWF4vGrItT2xKFhnq7sNSUsqNrXqdcz51h7qTLiiAlBx
         OCWAs8xn/WFPWNf+u6h0NwSKNNj14GyNenVEGgJ8EyFylzyTdM25BMK7IQeLCXWDGCbG
         BlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854507; x=1793459307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poJfTtphoE3FebBH4FQPgLRGa6HjKfEcKWbMRwtA0Ms=;
        b=idWxrdUpOcOLpTWi/M3ZViw8gAKZd0FfRLPTJzL1ONJEiCZGXbigBwBwk3k5SZYSDI
         vl/lFkoEBN2DYEvR5cXfcPsJLsunBEDY+FAa/avGo/D4vK0+jJg0oU/OqVezKmQxj9iT
         PXUF8n+VrAtb2XXtOJvX32rgxic4DO3LJX+lGtvROfTlNdV3FuVCqBID4kO0bdSEO1aX
         jzPQhejt0UjsW6vcAKG6OW8gHjatIsubA6uEc7K/8RwyygHHvikVE+KZ+jmSfOBo/kDl
         Fj1zBlucHY6iMVcvBXaDG+KF4YEdzXzgtTT6tYNRjbNbZ3rH3Mr0PjR/SlCbUrWbA6ZW
         B/1A==
X-Gm-Message-State: AFq9FYKMl0n4ALblbn7rqy8kj8jU2PFfugivqWL+WcZDoVaV/rkcL7KR
	slkHrDzmkpcA2MEhtwp3flka+3WY+hzUJ+VJd3+YZik50fKX5frmIN8IZv/rQnsgRnVoWaWTDQH
	1K631Ec1jZcZ+gwAGCKnrqG1jDef5YQk=
X-Gm-Gg: AYBFou2zxV+Mf/fR6Gg5wZ2qNzRwoyzDY+PnhicKcFFRQ2zL70xC7gxRE6344SbWJ1z
	B7Bvafh6KfNhMOeRsHws3A37tSizu2Wlu92XYmUPKkzWr8N3dIjrjzTmtwYxw6nZhEXcdb4ygnZ
	8kINY+c9LmbnpYSAKSreA/g06muzjpuUoMLtqr2jZxghKJ1+aXotKa+z3OrEoyLJBgUbdID2MbC
	+uVChmpqDJv43tnGpZqOaU3Hg7U7gLgMwb2MZ1r6p4khXGELAevphMcHCYyx9B6HFPFymiPpqLo
	ie7moYAdlEqPvfj1UyNKt0ZFq6Y9UHng2Iuhdlr/xiy8LXqgi08Q8ovNRZMGUkEi9rA/Bvy3q/4
	bQ1/6Av1IANeK/Nsvmy82mJsh4Oih0Vhyd/k4GD5x8VvReJuoUkAnfjJDumRnUfLBwQQwpvIQbo
	4K1DnqxgyagwYvKaebQy92qmBxS43I9cvY6BrUoZshylRdlfLDNXsT
X-Received: by 2002:a17:903:3884:b0:2e6:51c3:89b with SMTP id
 d9443c01a7336-2ea9ca7e32emr11897235ad.4.1792854507148; Sat, 24 Oct 2026
 08:08:27 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:08:15 -0400
X-Gm-Features: AclHuK827j8rFdcQNulVOnZY5zMdTf1rl15f8xWqM_ulAmxYHElN8OkZjOKGm0w
Message-ID: <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:43=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a per-remote config variable, remote.<name>.refmap, that provides
> the default value for --refmap the same way remote.<name>.fetch
> already provides the default refspecs to fetch. Like --refmap itself,
> it only maps refs that are actually being fetched, so it has nothing
> to do when there is nothing explicit to fetch, on the command line or
> via remote.<name>.fetch.
>
> A refspec-less fetch with a refmap configured but nothing else to say
> what to fetch falls back to the same defaults as a remote with no
> refspec or refmap at all. Only an explicit --refmap given on the
> command line with no command-line refspec to go with it is still
> rejected, since that combination is a plain mistake to type, unlike a
> remote.<name>.refmap configured on its own. A remote.<name>.fetch
> that is also configured is used as before.

A bit wordy in the 2nd paragraph (and LLM-tasting), but=E2=80=A6 :shrug:

>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

>  int remote_find_tracking(struct remote *remote, struct refspec_item *ref=
spec)
>  {
> -       return refspec_find_match(&remote->fetch, refspec);
> +       if (remote->fetch.nr)
> +               return refspec_find_match(&remote->fetch, refspec);
> +       return refspec_find_match(&remote->refmap, refspec);
>  }

I think this appeared in v2 a bit open-coded, then was refactored in
v3, but I haven't seen any comment on it? I might just be missing
some.

Anyway, let me think aloud about this. At first glance, we can't
fallback to refmap if fetch *fails* to find refspec. Should we or not?
I'm not sure.

remote.h says this procedure does "For the given remote, reads the
refspec's src and sets the other fields." Ok, and glancing at
refspec_find_match the idea is that "refspec" input is a query (with a
src or dst) and we find the matching entry and fill out the input's
fields.

So=E2=80=A6 I assume the usual idea would be that refmap is a "superset" of
the fetch refspec, since I might want to map refs that I don't
normally fetch. (Or it might be disjoint, if none of the mappings
apply to my usual fetches.) But that means that remote_find_tracking()
won't be able to find entries for the mapped refs that aren't part of
my "normal" fetches? Are there downstream consequences of that? I'm
not sure, I haven't looked at how else remote_find_tracking is used.

Could that affect, for example, --delete-merged?

--=20
D. Ben Knoble
