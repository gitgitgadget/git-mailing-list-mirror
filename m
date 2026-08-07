Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2774314A0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104375; cv=pass; b=cS7K/Q66QQHUSGEj6UpSK4R7l1TOWUbpn+AY/yOLvN00Ev2Uia1Wq7B4qHrZ3ATsuxvn4IFrhfb0cJCuK6UrWeXW2tqjOFp5ZtPVvE5tDVqAyE4e3DC3XKeSBTDELeeniRcuq+fkT1Ok8oy7EBlYV0sT6AmFNoBBcv1MKXMapvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104375; c=relaxed/simple;
	bh=iSf9S14Vhzot1SUKQGG+OfKXlhKg/NTo3hF6dHRffrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWkOAxhiBtdfT+ES3rkRKwGvMbBW+zYP7T6wemPF5XzxST8uLo6VMxuB7Jkc2mrHEB1mh1pgl5L7fWoR5gZ6o0x5XVGu5GdM1SyrsIe3vxRlZccabIyXSwEKRWODWGyTurQYgMiDcYqys6wTeZYoB8JDqGX0dWRMlitjHDNYmiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=hQSZxZbB; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="hQSZxZbB"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8201447e8cdso53799097b3.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786104363; cv=none;
        d=google.com; s=arc-20260327;
        b=i4GajiF0nPpwBqd6JwuMris/KMY4HHcAwFTKbLmRkoXrvN2MlrwiAw6VtKd0rHSMl8
         9KYxn+X416TE3aP98bEVSnE8QMfQQ1MrBv10+wjWQypatxwrkMxj1Jca54HPvh/W5Ue/
         KnUj07vIy11byRk7rm42/WZw1z5afKDc8qRnLRgzLMth3qpfMiMpuhQKn57h8QilFXnU
         yhsA5/0HGthDi/+P4srzUbQJdERPz0Vo+2QJR9y0/u0pwEu17q2CU/lxU+my+YuVnfuv
         hAAMbI4yNoexivb4vdNm+iGSB0WIcWTFo703totZp3FKW9tzUzz/tyRJpxTV8P49fC70
         GKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hp4qj1P88v7SVsFt3gs0TfG2o46G+ZKR4v3tEXuxeaE=;
        fh=ZjSvO0GKFWYc9yyBlBWFPLjHSM/bDLLc9RWF23y7MD4=;
        b=N/9e2U3KfCCMsbtTMJ0YUX/mR67lGthMMzAY8Id4UobSjPniEN2eVUrlQSdGgncfuU
         d9818p1W/xmscpu+I4hM9XK6HNx9RkL2aH8V5fjiOn1V/xjn/XaMmOrtJ5hnsKjedGEG
         4M9NOkMfLvIelHUhin+pPi0PQQKzoxxfEcM7nAFSb+cKN42tO7u/hm4ffkR8xox7hQwg
         ncBAczhEQD/o6lpx6lkfws8Dodhl/pVCmmTZOVEDYksCM9ui6hglLjUp1soXOISUvtZY
         fjWWmDQ8OClsvHFPUWeqbCirrH6E/O/hy8ew7kd0qla4RdGXo/LJKh2snYLngf7n56BO
         Kqxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786104363; x=1786709163; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hp4qj1P88v7SVsFt3gs0TfG2o46G+ZKR4v3tEXuxeaE=;
        b=hQSZxZbBGnjmP26Skt3qraZ9v3LrjZUbLz2vj/u0uJcuoU4gDNHCq2FUrTopWhDTZk
         PVNchgY53KW3WSfMdJXVTm25ISf3A05CgPJUE7tF8T44HCsmPySzULb0OKxPwcs9ZKe4
         dHRagRigy/8BsLE8zFvxc8UOoJik9PWZd9sYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104363; x=1786709163;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hp4qj1P88v7SVsFt3gs0TfG2o46G+ZKR4v3tEXuxeaE=;
        b=Kv6NS4CLmF7FoBaVSRMKAee+MP4tjHIDaeq0lWPwMdeTgyGBHRPWXIMDL5PPq2zUZd
         4R8MOw573U43fwlqkwrY57d7EqBgXricA9uqNCGZZPMQipmfn9YFFh+VhZsxZ1zxMlNd
         JRL9KwO5j3c9VXaCyA5Ie9gJKCaC8weIaAJW5gvQ6YkpmcIVsAGfnEIEkAm71rRi4oEc
         /x7gW9fiwpxCJVRcK07lFdSMCqVdRIJJoRLOVQTRu0oMpKd5EIvmxOP4MbUJIhfqtVXR
         gthlFZkhI9P8UhC8uL08BU+7jCXJvayVvRTn00bbNxd2AX5qyeB3pst/oFbv39Bv724U
         bo8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq/7U4R17VVJ+Q9dpVV1Vqwy+hbnkcUPBU0huYmRboNUipuFtlSpO/pVM6uH/g23zk7620=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvdej0r8Jr5cDVutYs+lR/nBl2TtYsN8M1QKTVgn68MQlmxOMZ
	/mq4Yjb2OkIy1/qxg7xgxku+zm7j3RzzPNfSiKmxd/7YmtwptJpbItGlmCaPWuiqUF+a+gG53aD
	2WQ//jo8m472Q6ox3yEGvOCR1TOG5VY/F4SmLxP7W9Q==
X-Gm-Gg: AR+sD13rIADSBSikTnDEzST0pP797ttyEAzwb3pZN+zveBJhCDDxNa2w099uI8LZTqa
	eyZOhpJTqXk/u1kH0mF4LmaLOUhdAaJszmzER6BcvO8sFPtGAoOtGiUfbIJDHrBXLfzqhEQmUYJ
	3pHth/mCgEpNdIF63ypjie2Cz5870xX4LA5tBqnJgw8Svsh9JVNvsDwf3KoKjKyJl8erUns4mZp
	CplJEZlyNYwnkz+6CJZZi/8YpjlLrD00kRjhHvD+KdBhr9RzibrD+w8lTWlX2NUtbB3GRku+jhe
	N8CMHhZPqgUYfu+3Mm1TYxLtUssA+nEOjsmlkkUbqCw=
X-Received: by 2002:a05:690c:6c85:b0:814:651e:a553 with SMTP id
 00721157ae682-820224cc826mr124561027b3.28.1786104362648; Fri, 07 Aug 2026
 05:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <b655b24dc0bedbe8803da87e977684217f7d1f69.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BFJDc5t3cCj9mZBkXs+Ee+EoWUKw2p9UXq7tSGoosqMmw@mail.gmail.com>
In-Reply-To: <CABPp-BFJDc5t3cCj9mZBkXs+Ee+EoWUKw2p9UXq7tSGoosqMmw@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 14:05:51 +0200
X-Gm-Features: AUfX_mwndpdmO26rNo4paZF44DmyzqNa_TJqafmUFRkLzzCslTYGR3AyE8bucz4
Message-ID: <CAL71e4OTYDrbY-kjeJSa-iWtUN=96Q+2_vEB-_tScu_afPS6EA@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] commit-reach: remove commit-date ordering fallback
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:03, Elijah Newren <newren@gmail.com> wrote:
>
> >
> > For v1 commit-graphs where generation numbers saturate at
> > GENERATION_NUMBER_V1_MAX, introduce a topological ceiling that
> > the early exit gates compare against instead of
> > GENERATION_NUMBER_INFINITY. This ensures saturated commits are
> > treated as unordered, preventing premature termination when
> > generation values are unreliable.
>
> Should the work associated with this paragraph come earlier so 8/10
> doesn't have its weird split?

I am thinking that I am mostly happy with the sequencing of the
code changes, but aligning it with the documentation seems to be
the messy part.

I am going to spend some time on reworking the documentation
overall because I think that's the main remaining work and
feedback on the code changes seem to have slowed down to
effectively zero (which I'm happy about, though I've always
found it easier to write correct code than useful documentation,
so now the real work starts).

We could of course introduce the topo_ceiling already in patch 8,
but there would be no behavior change since gen_ordered is
disabled for v1 commit-graphs.

But let me know if you still want me to move that code change,
I don't feel too strongly about it.

> Nice seeing all the date-ordering stuff get ripped out.

Agreed, since I am new to this I have ran into multiple gotchas
when dealing with both v1 and v2, so the more we can unify the
code paths, the better. And I suppose the performance improvement
is a nice bonus (though people who still have v1 graphs and
are using the latest git version should probably just switch to v2
instead).

> Good, together with the setting of state->topo_ceiling, this fixes the
> GENERATION_NUMBER_V1_MAX issue.

I did consider making this a utility function but I realized that
this was the only part of the code where topological ordering
mattered for correctness so it was nice that I could avoid that.

> The code and tests look good, my main issue is that the documentation
> and code are not consistent at patch 08/10, so we need some way of
> correcting that.  I don't know whether that means splitting the code
> differently in patches 8 & 10, or splitting the documentation
> differently or something else.  Thoughts?

Yes, I will take a whole new stab at the documentation changes
as a whole since a lot of things have changed in the code since v1.
This potentially means a larger rewrite so it will likely take a
few days days until I am happy enough with it.

> Anyway, nicely done overall, this is nearly ready to merge; it just
> needs a few small touch-ups.

Thanks, happy to hear that!
Kristofer
