Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC685274658
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966660; cv=pass; b=oH1tSxnMZaeUX0NMyA8Z12BzqzvSw1K1KnJVOcGK9z1CRialDTPgC4u7K4fK0bMZp8k9FgCCYlJLBPiCYAezf3eRKc6a+OaBxwCazCDgx0vuRBvje4tYMnxm6JIT3Ldu2H3pS/ua/V6KcgNF6Lt61qNrPi5W4+Qw8C8aCMfpUf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966660; c=relaxed/simple;
	bh=xg2n14lmoxfMAQfalC4Wb4BCOXsofzXnvVGoGrDg/I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCgGCXlWRhO/Kch0cY6tbW5lNbBgsHjHCNJ6cNlne+IgADWWjQH1KmrAjPWUwNoCv9oxS3RsUmuHfEOWxDt0spEZqFHQwRoh0pgMowYfmakgu4AxSCyxkl0NGBTDlf0CFhQXkHalU4N6J2Y0Mv1LKr1hiN6IdbUlfGzJDRC22r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX844vhM; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX844vhM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso5206175a12.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 11:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783966657; cv=none;
        d=google.com; s=arc-20260327;
        b=H4mmg7R/E5ZqaE0UaavH1ovAJ3xQ6X+59AkaYmTWQrrOuy3sRF1ZhVmuYWmkHcNp9q
         NgmxGx+TrHKCyCW9uaMa3gAgBo6Dwwl7fsB2aBe/oq4WlU9Yaq/xjHi3xPbxE7uJxY/H
         EEY0dSW4ejNs2y8ViH9QBRhJNSX/7MP0aILVSfjfhDoRDj5KxslcxRSDxlK3xUV9BsqN
         oJnCXQQrlxDr85c+i819mpc0pZT5xy3+04AsGbqQxR61LnlxQBnRVNIrGQKwMtk+mMix
         Nc0z2TFm+3KPtQKMBBv54uVbAtoWHYS6ww1sq1/5XpAXiJDa0R+0myj6P50lQAD0C+Jv
         diHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Apa40k/Ep3i731BtOcplS3+42uAIyyEKBjEYjXwMhyY=;
        fh=GTRuk7DqIb9BLEyiri833Vi0n1Qmysyugj4MEx7SGvY=;
        b=ZEyiX1hVvoqG05g6ewVxtfcJSUB7hy4ZZS/gICXYNRpbkyeolPKnT1NbJfmN4VhUU7
         dYmjJeiJfMjARN1BiL8p0RpqbdcRiodp3tPWWHrr334bAwAH8vN6k0EdxM9/K+Xvk77b
         Kf4k6Z2nwjdWr3qRGnU8RO6okpxGhp+wQuYKUrzGhV9rLEe64lPI+/8fOrr+jjksCkIe
         0SNV11w3qxyvLaplcKb8XtnfNGsscwE9PSFV1cJhplEkIUlUqz+OOla77N+u326Wzc+3
         CfKj4VvM+o+IxDU5cL0Ol5SVaM9ywV1ke/LlhQGaZ9JGvfrHSYIn5j7Jmhvm1z1qmVME
         dmcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783966657; x=1784571457; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Apa40k/Ep3i731BtOcplS3+42uAIyyEKBjEYjXwMhyY=;
        b=CX844vhMEt1UT3ZNNreXe0U4Hybx8oplLb66t2uEjmbPGG+AZQV9nwrwGfn72mbG4x
         uPYRMTlBwimZNUvZsk0xZ89M0dFNL5XIvu3+/84y1xKFWf/q3ZQ9SyikTnyVGz2u3iF9
         yFnuVNMn82jbavORBXahfv1nItLKbPPexfWy9xNNLpBEUEmSpbeaIoqdp+H7A7chrbB3
         zBGgTiew/HsTLXNZ5PItoqgqo64Vybt/rutjzPhDUNfZKZqBEc4WJ/pI2FXjeBt8IQn2
         PqGy4k1cSKyvjhNwK1Mn/7A2y6mPrH0OTZNuLeLTlqZ+vTSFnRjhAbL5Y8N52bZecSKh
         CL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966657; x=1784571457;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Apa40k/Ep3i731BtOcplS3+42uAIyyEKBjEYjXwMhyY=;
        b=qLti4l9IXqiyvYvu/90X8PgKp2JIM1VrEYkTjvaAYKBl81+aaK2lbAWXSJav28Y9qH
         X8npjHWukhbrnIG3bNxtWLlV+OkRJfX1pvy+noBvDqKPg16/muoiEdqp12LxpFSHZs7b
         lUl26OzvtGr20CVm1PAlfBI75XyakrcsJ6NKXgLaFE1QeP+SkS11aOb1JvJ/Lx59B246
         UqjjSd3EDl64K1Xir/ZUgsww1x4ZV2A/6GUI6kushbTvWylLcQCJAAqZTk9hdOab0E4f
         Yc9nP6eZVa4ExIfdJ+tpqNFDOB6pSOBxZ11AEKxNNWFbbOVqdHmMn1KLn4rLkGN0chTF
         QC4g==
X-Forwarded-Encrypted: i=1; AHgh+RoISJrAWCjY/+gzaaqWQjvo8KuTvM3/1/vVYo8e17h2IhSerlB9wxLp5nMZ9ZQVI3k/Kdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIdWxdIiabFs1NLDfKnZ7TIQAc+nZs/nk3YnF2+ZSXy0okQa+
	WZZ8qd7OkloTyBoOp/m7cauJYAKdn4oU5tcxlE4SMsSIYycLZlVRwzShmwUXZUA5YFgynrRqh/f
	cJHq5TAtJDCGPuXKnQ8/KzXIPSHr9JXs=
X-Gm-Gg: AfdE7ckhipLc1waQyd2BWnoHydD73rM3v+iHPCxxobPwlGTky1cCGZgjnLg5hu9SYWC
	Yvzmgm+PxzztERsBcfECTL5yOdIsTAyuxdzzfXnR4r17Q5jABsRvKGK/KIv+1bDjiF+BGgsOrE4
	ltd54G0FCaki4l5iYyAz+6dNm899qSiC8emRvJ0GOEPzInIr0hVAWhzhWLouGRGldB2t/mqWPF0
	a5u2cUI+ZbJzrDrDC1Y+BwLi2LzHm57m+/SsiciapSWwtzApvRvoPrPS7lBqChHPdmWexhz
X-Received: by 2002:a05:6402:2694:b0:698:3b7c:7e39 with SMTP id
 4fb4d7f45d1cf-69c5f248622mr4166265a12.35.1783966656802; Mon, 13 Jul 2026
 11:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com> <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
 <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
 <5212d968-6121-466c-8225-36b4bad6b211@gmail.com> <279e6d69-191b-437a-b1b1-ecd879343f3d@gmail.com>
In-Reply-To: <279e6d69-191b-437a-b1b1-ecd879343f3d@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 13 Jul 2026 20:17:00 +0200
X-Gm-Features: AUfX_mzmQJZJ76rHbXNS3_ndM-Pdfem0-q0Dn8rcpIUGe_v-q8HFAp6ugP-uuv4
Message-ID: <CAHwyqnUKSD=G1jkdc6n5mVA-NvCgL+c9zCEW_Lr8OBP5q2fKkw@mail.gmail.com>
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> >> This exposes something that I don't love about this feature,
> >
> > by "this feature" do you mean "git branch --delete-merged"?
> >
> >> which is
> >> that when using a pushDefault (like we do in the tests with 'git
> >> config remote.pushDefault fork') if not adding a special case for the
> >> main/master branch (like 'git config branch.main.pushRemote origin'),
> >> then it will get cleaned up as a forked branch.
> >
> > Oh, so because the default push remote is not "origin" we need to
> > override that for the branches that we do push to "origin". That's a
> > pain, but even if we did add a special case for the default branch, it
> > would not protect other branches like "next" and "seen".
>
> Thinking about this a bit more, rather than protecting branches where
> $branch@{push} == $branch@{upstream}, perhaps we should be protecting
> branches that are merged into their upstream but
>
>      git push branch.$branch.remote $branch
>
> would update $branch@{upstream}. So we'd apply the push refspec to the
> branch name, then apply the fetch refspec to that and check the result
> did not match the name of the upstream branch.
>
> Does that make sense?

This makes a lot of sense and fixes my major gripe. Seems very
possible to implement as well, I'll give it a shot.

Are you done with the rest of your review so I can push out the next version?


Harald
