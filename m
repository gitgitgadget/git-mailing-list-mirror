Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F14DE721
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401243; cv=pass; b=uxsbVnJcMwtyNymT0i5/gpDUVxwTUO6SFtSZ4JlPehcV9zMWAfBAtkNGhGKQdgjVw/i5K3PmMgNcj91mfuaEYTeEeONd9C7Fq6AyDXkDcbabVdigTydrleaUUp1B/aYS93K7wAsEPTLxC4rmQ6KWxETV/uqaa5CYMs4EdiPHd5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401243; c=relaxed/simple;
	bh=EzxCXSskmbJGZ0Qz7miykR/9WtURkVTpX3Wf/JmcepA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMOs1OMcNc1j/3Ci2LIh8yjDbua1uXSBhc/CKF4EFwHjmOtlAncgYQ7bHR3ca/PApMs1i7JqkrDL5YR5XD/adMfLkF2RJ4vDIhXjurGDUWNWKp+Q7xr7zBJJ4MYW2Qkij5YnlZwM0qXekLl8L+S/2UbVZ/1qKg8KqMoN7xN5uKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvMz9vLH; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvMz9vLH"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e49851734cso14996975ad.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 12:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791401241; cv=none;
        d=google.com; s=arc-20260327;
        b=V3PxxjFbhcFkP3ye4VoghqL9DvffebgtlN2sq35S/6gy7qANf80pZIu0qk+Z30nEXm
         +Kn59MEemMs3VwpFfVLr6VYu+IguuQswQ9qbpvekQMgyxfFdf8GcXRIlsuMEOMut+nCl
         MNR1GJoLTnQ1jj7/Jhe4k1qMuMC6rIXrqd+ga/0vIPpTEcUAL5c5gxX67XL9EYGWdq/G
         S7YuAfbm+n/fZmsveIOziKog1E8HFULFos6TbGkHxL6fleLvCbScB34I+4/rY6uzSqM4
         ASnVaQT0Z2bg0LTEJD/CU59ghlESlWoT4gFF4V34rMmutUbdiHlWp+TrPUp1HUoKYmw4
         kTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4+/WB0B1L/+Fvigrl6GjaT+G7RqKAoaHSDaVDqTwvGc=;
        fh=bzNSpxKo5LnoMuBj1zux8p/hcP2mdIHFfB1NDkOktHM=;
        b=eXYcCRWOf8NFNO4XI+yeAKIc4z2BaPhHkNN5wt+GMi41phdFoUPo/QdJ5hJvCrJp7K
         0NCKCVcv2qckrR9R+9mS1mn74DEsnkwIv0T9MrSqZEmHjNwVNG/4sz840h8+bVF+qTI0
         GbvoEfZ9oUPm/NRG6wm+dpw93Q5RawRVY7613PXayG62HN0J3uabatCnKIBP0S0MsKAr
         CV8NQeMweHrw2KtgfjDy3j8Q3KwnES9mVAzjcFOV2AXzxV/laMylOzu5o6IZnnPCld9l
         aMtIvmb3yujWISjIV5LhPBCfVWhpvIvP8NzU88g6m11/VfvAFUe/r+NSbE/ehjzIL80A
         5aTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791401241; x=1792006041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+/WB0B1L/+Fvigrl6GjaT+G7RqKAoaHSDaVDqTwvGc=;
        b=kvMz9vLHxF+I1WMJqNbz8mFjoFJyyywHMmpnEhwGiILXVrwZIBHCulnFaVgkfne80M
         CwT+G3k/ocym5iIqGGQE4s50Xy8dx+2I+7FUIICQICSu0kkaFlQr7E+llNjJKN3qi51m
         fpmUqOnV4Jdn4GoGUd03Th0dQarL0qzu/1CWyjrzVCHx8s/zoG/+bUFoQFRYyObkShxR
         Zqc0vEl2WXfmcQwJ9286wRAcbMTiom6obT72lHlRvKN+MNK1R0bZScTzM+rCFewuTPfD
         eg+RBRa3U9ZSmU0BMRFmy1019aJ/5XshNLNSG9kSN8+wt42T2Bg+Nzei3dO3uYjCjH0m
         jiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401241; x=1792006041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+/WB0B1L/+Fvigrl6GjaT+G7RqKAoaHSDaVDqTwvGc=;
        b=VKoRPMER19AGNsw9veoB54gfcysTC1U1+DQwztRp5MCjSe9+poiX3/RInkZ2OBrOfC
         qu8TOQFFvcYxhUGl7lQM+DFv0PL2o5RQc9jV6HbJlvxwuuJPujGt6ZuVTH632wXYD6N7
         H8Tg+V2oM0jiYFQJfY+vuPZzszAeQqXfIdthTu8NwHn+SHH2F+m2memGoNlzCsah2qTr
         b8NzVxSmmxLeI8jyvlYt/DpXQsK1PxzZ3KBKKj97w6baSB66NKm49lQlq58wRs2esW+N
         C6Vv+Ep67cNPjLULeF2c2zAi6qxsB8EoWDJW3R4N8xKYrhv1aZ2mHfa3077ilywQSQjd
         /2KA==
X-Gm-Message-State: AFq9FYKZ3D3VCOAZzBKn1CR70M5QKGoi1UA8m2rLEOiTqgs0hoYuI9Yc
	/wDwrvR49ZCHHr5Vnnmz0PgviyE+l1yfi8dYwX6X8FYS/ohQpLtdhvPJpYwbVAnat3oBYMLi4gH
	ZozAqgOehEDMJgV44IbHYP+4od4PkJQ4=
X-Gm-Gg: AYBFou0OA6eiygjl36q+2eX5juGWy9ROfZBbPxlDwtcqnjtjexmLWOMeX/m57MXywFA
	RrEgoj0gBw03bPJpw5JhUh8E0Xk8KAgQteMXjbuKvBLiutTviXMWdFtWmUExGDXmUAGxNyZULso
	E14BW/oBopKiLk7Hp53NBrDsHlWM+QxJce89OXy7dWlwyRnFmo0qETpZ2W+sDdZ7MKawyWm/Yyl
	q3fISBly1F503mH2cSh4AHZ56baspfT6z5LE1psUefZFgJmYyJUNAnhISM/RHaVLBJfz6L/NLy0
	Z5Nor+2qyNjCHMVvHiLrshc3HrJt2tvfMr+7Ej2WBTiwkFN9wmMRQDJUiihYZ1uXaULWVTvAx0k
	oCU2oKXXE/PSYq18dGch8Q1IPHW4HtXHrjvAFkRuWoLeWNHTT+cJXylDCfbgTh68Xuiw//cv/2Z
	/0diUVfchMlbr+vS0yxJiSFyC6r1SOag==
X-Received: by 2002:a17:903:41c6:b0:2e6:c39:b250 with SMTP id
 d9443c01a7336-2e60c39bfd2mr21945345ad.25.1791401241059; Wed, 07 Oct 2026
 12:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Oct 2026 15:26:15 -0400
X-Gm-Features: AclHuK_1ZQfWJGe8ZQdQuC8q0FdIbofPQlwwrZ5Lp1YEgqaEFziA2O19BXWnaB8
Message-ID: <CALnO6CDBFri-MYXEg0TGF7-Oc49hf48qEQCQLYpdXKMkJzbYhw@mail.gmail.com>
Subject: Re: [PATCH 0/2] WIP: doc: add new git tutorial
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 3:40=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first draft of a tutorial which introduces Git in two parts:
>
> Part 1: Create an empty repo & make 2 commits (git init, git add, git
> commit, git status, git diff) Part 2: Push the repo to a remote host like
> GitHub or GitLab (git remote add, git push)
>
> So far we've gotten 112 comments from 22 beta testers who have tried to
> learn Git for the first using this tutorial. Most of them were able to
> finish it successfully. I'd like to avoid getting into the details of eve=
ry
> single thing in the tutorial at this stage (we're still planning to do a
> second round of feedback with the beta testers, and the beginning especia=
lly
> will likely change)
>
> There are 2 questions I'd like feedback on since they both could affect t=
he
> structure of the tutorial. I don't think either of these is a dealbreaker=
,
> since folks generally were able to finish the tutorial despite all these
> issues and said that they enjoyed it and learned a lot. But it would be
> great if there were an easy way to make the process less messy.
>
>
> question 1: create the repo on the command line, or in the forge?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> c. Just try to get users to try to figure the right way in the
> GitLab/GitHub/etc UI to actually create an empty repository that it's
> possible to just push to. This is really hard because the UIs constantly
> change.
>
>
> current solution 1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Right now we're working on Option C since it seems least bad
>
>
> question 2: How to handle authentication
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> current solution 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Right now we're solving these by:
>
>  1. Using SSH
>  2. Explaining how to set up SSH in the easiest way possible (with
>     disclaimers to check your security team's policy if applicable since =
the
>     "easiest way" may not be the best)
>  3. Giving some instructions for how to translate an HTTPS URL to an SSH =
URL

Disclaimer, I haven't read the patches yet.

Both of these approaches sound like the right one to me. Assuming
we're suggesting up-to-date key algorithms for SSH, I think that
should be fine. (Memory says ECDSA and ED22519, I think? I'm not sure
about the differences, but my regularly-used keys are the latter and
my newest is the former.)

I happen to use a somewhat convoluted "new key for each host" policy
for myself, which ends up with lots of "Host <host> IdentifyFile
<key>" in ~/.ssh/config and "Include"d files. I think separate keys
per host is a good idea, but I certainly wouldn't want to foist that
mess on new users. OTOH, even leaving an admonition "you probably want
to set up one key per host later, so consider this just a starting
point" is how such starting points become prolific use practice ;)

So, idk on that front. Probably it's over-complicated to do that here,
and point to better guides (or worry about making one externally if
none exist), leaving the admonition in.

Thanks for letting me think aloud,
Ben
