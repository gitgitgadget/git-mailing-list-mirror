Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004216;
	b=qmEs0SzyCQSkYEds+9ZonKV4bxC5ndtkk69LlQF6M619SN0po8M/5fCZy5mKBr74GX9D
	 ocyJUpYZo39BhXso50mUfMfZcqaFIwn98Hl0fGDe56t77Kg8hE/0/tsz+hVT/KfHyNhUj
	 y4GKgedI738oOinOmMnet9LScvYqBrQWq4b+YGMszAqv1ZkPZWK0hHlOTHXvRb/EWOxw7
	 1H2/c5z3xnS+Lo/mdZsZcG+YMZWTKJacyTl0Xwv5oCgy9f2lx5Vq1nzRLzuSpsU/NBtNB
	 KVoEvrH/VAnnDqlAMzDi6TTlgnfN51UkB+SXh+XYrGuTLh1dkMEMoAxkgZPO3+EUZDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ScD8jFN7jKvLEk8wdn2l5hSTnqSEusyNwpRNX1mksHc=;
	b=nHf1g0krdsEcv7X8hZK92V5UevphLZcSdWSDtvh8TgRg+Q7T0EnYZYUpEaABY50jjwUY
	 tcRNFrE4kq7RLAWI3NfHWAUbxKZa3LccnkfRTLWMrYNmyV6vuVL2rFZ1WNyes5ae3eMgj
	 F4WznWZ+AAF0evTzfXllBOiecb3ebZqsEevya3omE2yVoywyY1MpQnrE2LQ5TJXoOzg+T
	 OpTSlGHK52+HV3g11FbagDzbV/KSGe2QbpLkSUYII7cxlO8seDoLuEVCo6+j2Ep2LD7cb
	 DG47KKwKWXBlIjrxpduZ6gM1yOi8Hb9haLV/7lXL54qF4ICLQPFLjNv22LDer+6nUYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NlnKCKrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49F606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C49F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NlnKCKrm
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so4648996a12.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004214; cv=none;
        d=google.com; s=arc-20260327;
        b=pgvDAZLUXi54RzBJWPWi+75Xj79B1VUBzkSH4fP3U4SHQMVcrFfHTzdCyjT/tIlfOa
         LRsJ9W6s+tvAJaxTbIQhFIVrSlEEKlXcPR6bNHJj3ZQ0iQeKWvlTvGSiLx7TK5sZMoYQ
         L3qZD3JyXDSjLqAXESFViOAz14sWfrhLsTW4eDb8tadhKcyAyhc9LuGyS4YE4yU8w70l
         cn04/tLkCeO9hr2VFzHLWJXK6ZvFsYfSIpr8jSD8pyGbrRXiM1MUt6gdupJiwJi3/b8V
         b11DfJZwXfoEgZYT75dEH9MJBRZtnNhhyTqiNMgo3+H3J0UZWTS+qpIxEpwFEcyUXbBU
         8hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ScD8jFN7jKvLEk8wdn2l5hSTnqSEusyNwpRNX1mksHc=;
        fh=kGfL+M/I1RYNoOgsr4kecZY5tC7BNtVV70M46ws0ju8=;
        b=epEWaejsRxAuOQGX4RwZkPELxb6dx257Z/xzVRX1f1LtcBpmXpoUUrMzbRYQaF7l19
         A3zf84fRIwWsKIAp1gVMrvBKGI43U8B8oRXpN8BvJbJPIaeclf0Wsw8Gmd5rxSFBAiJW
         sb8e12cntdfVo9HTXb+wLbUPrGppiClxy/x1/As5tgGaNIv0mK757VhsupvJ9K1XpEjP
         4b9i7dXmhP/7RO8c6Z9rXQD+UFGfb+/LMh+lAjrgEb9O+oyPGWDqfmhOhKrmcqReWW6Z
         vHhYlPD4TZTDXNne8BVVZSre7JmMUfzb1fNbSfTVe0Ajh8Z6UMOxaqRDRsO8L6ClM9eu
         s+Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004214; x=1793609014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScD8jFN7jKvLEk8wdn2l5hSTnqSEusyNwpRNX1mksHc=;
        b=NlnKCKrmehP8019A37PswnMhdVCXm/ZbCPqjbJtphXkgZGWj0yS5pZ+xsg6ZloHl6K
         EyKmIIn2aPiMq2wUQQ1k0SOrlvia/PljAAcM/slh6+NPXqCjz6aoMqtABWqfrmlVciq5
         6b/SeoMHgm05tSnPRqH8FGTGIA2SH+YYB3phTRb6XQsw0Wn5Jo/cy0Iu4NH7mEncgEY7
         L2FBr5uOEDNVKJJPY3jZgPchvuB+qqhf/pd9nF4DM6re67wHyif0AEV5W34RN1fBWnAt
         s3qBo2hfxvjgeNwd4XnQ4K8gLrVO4HPRfOMvzTQMQFPJ6LzNztdff1eU0DAk0nKnB4R2
         KD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004214; x=1793609014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScD8jFN7jKvLEk8wdn2l5hSTnqSEusyNwpRNX1mksHc=;
        b=BgTqgJPluDF/Ulv/Xfc7OGbpImkm8FV80N4qZOvnE32xAnyrlPjeeezzyIzuT34XqM
         H0aGKv8YnFZI0U0Nv7aXWs2w5GNNcyDSsHuOgqIi00CKrKfQJAlxS5K0VBufBoR/15S5
         x21PkNlE59rntLj87IB8yj6+r7Tbej7teR0UjCocDgNuBisAbAZ/xMu2SvMVYCYU/H8v
         BpY3xDxoVU8OUs8WBv9nfBBEDI6VVBARN+70NUM+gzzOhQVjfXFrM630gizlZrGxRaFo
         AL7UwqQuoo2AFORCzcbo3gYQNbL7k7rx6x+QiJh2BxvXpZZYPnACD/3JPTvX4eBf6KTy
         yBiA==
X-Gm-Message-State: AFq9FYKlqsUt3rgc+cPYmfbUCcLzx3SRfbqW1Tz6Dd5tXFSJbvqHCnyn
	cuMOsi2EXENw9o/gNtdgxmKEldG9qA4OOn0LoumkgoZ2Pk3x20iy0/6m+/kgX0KFH4LjoFCfbjf
	hhBDADyOHdkv5vMrMiU+od42f+eiUAQ8=
X-Gm-Gg: AYBFou2LVt16Yg96yD+nOe8AZ8zSIkr0lcxwaaLSNiFYp6H/vOKgh1W2zkc3tpsDeBp
	2zNIXVmdbQ54PnTJrmzHE2H5sgctp+QJhX5De4ZxOAgMUH+DdhjmSL9uiCFQbSr5fW+Y50kBvHy
	hosHhrhGSRmR2tps0iPsKeULU4x0EI9ItQ8DWOpo0MmOMX0QdFDapjt3ptQqgKYu9XHlzncWfZ7
	8eKo6dcodOrNyRvtlU2mIu/UsBEVgP+OLNSRUsPNZu3fqPEozZqV2Yh8X2M0C3xZvm9v/7iDw9R
	JZOQC4ugUhCNaLkXfNN57KAiT4MSJ1l0XT3A5I9VgXlagJQ7f0pi3bYhjHCc8wxQlD9c3my090b
	WIxBEPRfGTlWyhLEZVLBcTMCJsWELg4KIc7h+v+S7zOK2pYLnSJI6jJgaNTpzf/59fpaiHA==
X-Received: by 2002:a05:6402:13cb:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b4602e0052mr3642917a12.20.1793004213890; Mon, 26 Oct 2026
 01:43:33 -0700 (PDT)
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
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com> <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
 <8ffe4cb4-fd89-4086-945b-735316e6d501@app.fastmail.com> <CAHwyqnVs3+ebj25fkTmeRjDTJsJQh9ECNYMy1xU_yJLDdDeAaQ@mail.gmail.com>
 <6568dd11-ea74-4e50-912f-a589356cf6b6@app.fastmail.com>
In-Reply-To: <6568dd11-ea74-4e50-912f-a589356cf6b6@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 10:42:55 +0200
X-Gm-Features: AclHuK_Eoa40vMHbyVXZYSgkurLrpzrRvpj3z_J9ylTqtmyqUdAhFOAdqwh6Dtg
Message-ID: <CAHwyqnUrxRLRJBmV4r+1A8kcUmG9S7v38tX5bDAMCVok+83hag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] reflog: add --historical-branch to name the branch
 of each entry
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	GiGiGa <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:40=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Oct 25, 2026, at 21:22, Harald Nordgren wrote:
> > On Sun, Oct 25, 2026 at 9:18=E2=80=AFPM Kristoffer Haugsbakk
> > <kristofferhaugsbakk@fastmail.com> wrote:
> >> >
> >> >[snip]
> >
> > Thanks! But maybe not worth reviewing this code now considering that
> > we don't know if we will even do any of this now?
>
> I think reviewing can be about the author and the other person
> learning something.
>
> In this case I remembered that part of the code from
> skimming previously.

I appreciated it, I just didn't want you to waste your time!


Harald
