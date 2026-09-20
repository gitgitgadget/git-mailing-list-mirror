Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD449481A93
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941615; cv=pass; b=flob4wZPmiKZ0D6pGvL4TdMt44wBxaqnPHEkL17JRoYCYH67097NmOIlUCN98PMYAHr4OguygHrBU746IBKOMoQiAOYBt9LNMI6rvDfM4m8RcSjjTf1mSqQVUsT1rj4B1XNNFEi2uhqXPqQfJVLsuULRsbzl73kUQPq6R4sv3yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941615; c=relaxed/simple;
	bh=LizLNOfekC0ixr1HXgT2yvXCM2xbkm9c8rvHGigrg8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU4dUxCC0HkNoroRdghhQZfK+ofmDDu0W0awNsGwHxHV9+NPetoQM26pxO0MvGx4+2uGPz3zwqeJ3f7uEsn7E+GIox4KGmkd4ulS711VGqBEIUaxdleIh6Zh/e+n8di/93Gi1DrhhJU3IlHRd1EAtGue5dTnCBMWbaLUWKmW5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixHlFKoo; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixHlFKoo"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505832so16089847b3.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 15:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789941612; cv=none;
        d=google.com; s=arc-20260327;
        b=GQ5p+MgqANyEqgbouMFUEbMoWKN0Bcgy13Lfhluk4Rr5CpXGWjudlbs6aSb8NVFGon
         dm+x2McqFIru802EE+x9AkiGwwsQwhVi6LcoHBjRI2uDreFOGl/WbcGHPFHIuj61rFxD
         PWbOSoVLeSE6kgAPqoOd6OP38kCxob2QXh6AVw9CovD7zMrFq3DtJMNwSq+nEe0N3VqS
         62Ir9VSMftMCrWqtaFUGWIHmIAOIU10ZAYZ5RoAg14YWOhxgoWo6Mx1FgDwQOe7WCIqc
         EylUY0xtyMTbh0O77Zn6lmiziMmnoeyEtbFek0KC2ir/M8HyR9cusWh6w8ndozb/5FuA
         /0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lvM/ZJYvrcoYQjqlcEuhveSD/A9XX8RG5w2vreumoBM=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=Db8DTQOeKmm205wCLE4TV22KpP2t90JgJqvGhl9nrcBIMwdbvaxP1nlI05tKSpIHf7
         1npgLcKFABg5OqBTrEqylrtC69M46P6Dg0gIhd4NHqndgKQucYVH+xczCIQsEmVzGlQo
         ApY1/fjwwF/069rR/aCyUZXQ5Bu3F2gspk2nnznQiyQcW1MzsPBvURzvDBc2CvWqo7Kz
         cSPs/zNAikobXy3rXsZhhT1yf59uVSmBgULw4TpMbRz6JwE8uqdmx3r0Lj6eg7ote5xn
         ZHCZeB37hikwbEDl9f0AvxY9e3sgPVsNZFwHL0nZDFTwuVrfFHYHLNBT8FTQInItfXD6
         HdlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789941612; x=1790546412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lvM/ZJYvrcoYQjqlcEuhveSD/A9XX8RG5w2vreumoBM=;
        b=ixHlFKoosU41ZyMm7AzD9iA5O2ZoKnVdFp4ummA93ftIud7bPnewSlyxzH37Sg0lUe
         aC7BkkcezqDNSRAxtUkf1MRsT5KY1++XZ18Agel/ueMrpzgQpzwB0lUJvkekVI01hjgV
         08AiQmsaWKXFI0hlA76NJMzAbPEPC1E5iL7XK4UEF5A4HaUMq+PLeQUA1rYe58m+mDGQ
         9M1QqRnfLFiZp7NMeSBITrxb8mzatCf1cJKzaULDK8idKSOQJzoH9INsL5uVlt7Y8TKQ
         R8DoCOEE+sNp6AsG9y0HcGpgGEYMHPahJHFKzKCCCApgckqtXSFmzjlcp8oYF6Ihyo1p
         wgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789941612; x=1790546412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvM/ZJYvrcoYQjqlcEuhveSD/A9XX8RG5w2vreumoBM=;
        b=m/kdl7lBd6QOtzxy9sShABIkkKvC8H7NIBIRZ8ja1fWGdwEm1de1azMUDGYY9w+9tR
         nAiZ6Nu8dskgLTk7GGrOZIKPBEnYp+5bGDQ+Sh2OJKx4nSIUYSnJt3BqKHRw2cLqF4Gn
         t+jr+0VtOZrsr91D/1WXALqLA59fNDMg6P5ZqURvfP0FPGauOMxxopqZDDSwDN+6TeqY
         59DemQF3LjHTtPFpxEeD92mraPbRyeetTtuy08S8EaN5BG0jrciXtopcxqjGlpPsiGRl
         LYtBN+aPHU4sc00ylCidgfE2czAFqsXJfPP9CXfuhkEc55NngIwidItuP8eQMqD+aThf
         q2fA==
X-Gm-Message-State: AFuF++mTeSkBEOk5r3/cIvzDYbsJBei3fCcsJQFm/poNXFVvPssUC3Mu
	1tJX5epzZTF2e7j9kqgthyJseFSCeLdwhCqnHFSg99rzGy2C/v3c685SJiBWwJWeikWxTi1Rwq4
	NxAvPtlqlXqO3nSg9ZK7GweTO5TtnuzDjmkPo
X-Gm-Gg: AYBFou3jb3qBRG6T61Hq8Zt8CDAE2bR8UTEHjzHklY8kSlljOgnWlZFqr8dKXRC3Uks
	Ndni1PaFbcBhoWmJ4+zmGGpNEWSCSzuCKq2g7lGYleg8tNw97DPwgFLIm8WzmzthE9ZXuCBW+an
	LLUjq0qYaT2g1BkjKlvQpQsDMJdszkoiCTCCqgqxowpGY97zxm5Ql8l8TZvQom46RmfPLKI+OL0
	uZPYyLQ4FiGdT4+AXkeKBT9KoB5vzPRrYtVsK9nYtSfjE2LAPB7wtuwNdyX9M4OqIZYU3FfPhVN
	a1HO5VCpc5aAqDiME6eg1BKioHoAS0+K904/Sr/7wVWZ3L9ovsTpFpJSUrgd0ssMTSM13nI8ZFc
	MUy9Nj1WQhxK9+un9zzFGPECNWlD0G4WDqOAQXb/Qgegfhh/+8wsQSJ38wLZqpymFmo22VACFxq
	iKCMkdnBWUBDdXMyeNP/UhB3Zw8bXrHQ==
X-Received: by 2002:a05:690c:a4d3:b0:873:5bb2:6c02 with SMTP id
 00721157ae682-89734cc0539mr23790077b3.44.1789941611633; Sun, 20 Sep 2026
 15:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
In-Reply-To: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 20 Sep 2026 17:59:59 -0400
X-Gm-Features: AcwNN1WBBo_kCdeDY-h9FhFR4nSSYpqpeFa06nxOgLxQo81Lgb8rVotnWK_f4D0
Message-ID: <CALnO6CB6DSwPKffy2BBgBk3fhJZXrMaoZm-ScBwgvoGQn_cwMQ@mail.gmail.com>
Subject: Re: [PATCH] object-name: explain why <ref>~N fails in a shallow clone
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[This is not a complete review, just something I noticed]

On Sun, Sep 20, 2026 at 5:55=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Asking for a commit's ancestor with <ref>~N or <ref>^N in a shallow
> clone that does not have N commits of history locally fails with a
> bare "is not a commit" error, with no indication that the repository
> being shallow is the reason, or what to do about it.
>
> Add a hint, shown when the walk runs out of parents exactly at a
> recorded shallow boundary, explaining that history was intentionally
> truncated there. When <ref> looks like <remote>/<branch> and <remote>
> is configured, the suggested command names that remote and branch
> directly.

Here, we mention the most common "ref" cases directly, and it might
make sense to restrict this feature only to the use of refs (since we
might need such a ref to unshallow via fetch?).

> For <ref>~N it suggests the exact --deepen needed,
> accounting for any history already present instead of just N. For
> <ref>^N the suggestion is always --deepen=3D1, regardless of N:

But here=E2=80=A6

> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advi=
ce.adoc
> index 81f80a9274..5b44037fff 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -128,6 +128,10 @@ all advice messages.
>                 give directions on how to proceed from the current state.
>         sequencerInUse::
>                 Shown when a sequencer command is already in progress.
> +       shallowHistory::
> +               Shown when `~<n>` or `^<n>` cannot resolve enough ancesto=
rs
> +               because history stops at a shallow boundary, to suggest
> +               fetching more history.
>         skippedCherryPicks::
>                 Shown when linkgit:git-rebase[1] skips a commit that has =
already
>                 been cherry-picked onto the upstream branch.

=E2=80=A6and here, it's not clear to me what kinds of things trigger the hi=
nt.
The "~N" and "^N" syntax work with any commit-ish, after all!

Either way, the hint documentation should probably not show "bare"
"~N"/~^N", since that's not syntax accepted by Git. The
gitrevisions(7) manual uses "<rev>~<n>" and "<rev>^[<n>]".

Perhaps you meant "rev" instead of "ref" in the commit message? Hm.

--=20
D. Ben Knoble
