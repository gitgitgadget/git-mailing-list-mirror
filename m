Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B3221FB4
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790994559; cv=pass; b=HALWaE9Q/au14dLC4GRJK5iv7gvbCStZhELISTE4n5s6BSr/24hidPsY62kriylv+bwPSpxmpywhxP92CXABh8mB8+PRVgWOz7modDoZBFDlAc8C8NuiZEG839/M3wrSZfiENDJcAiEan6NF92NkydEHpjhDwkGW+RRIk352JE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790994559; c=relaxed/simple;
	bh=Jwm54tPjIxR9ijqMcV1WtAoHzAPlculq387E8G5bkCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBhdOk7yGGFHzD/k4AP0sQXO4EU6qFD2jFTpTMsSHleuN8mcnj8ZM9F0fam8Cky0biTrXBmHsLRkNQwgPdnnuw/RRt90iA5i1YBqRs71fa79NJXmYYdSuCxb/u5OzjA3Zh/NumzmuSLqeMIT9HpbsaIsM9Zm0R4SWlM1EN4DA6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daEYg6ql; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daEYg6ql"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-887fb6c0ad1so57136b3a.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 19:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790994557; cv=none;
        d=google.com; s=arc-20260327;
        b=MpHFIAPMZze5Pb5jX4adUn6O/EO2qXaUh4eY6kfyZNKeDiG5Hr5q8ddluAL6dIMFWN
         tpXn4Uv9SkVhTL0MHtymZP1ve0my94+edx+WGl1MErW33xStcGON5l3PwjZvTCEXZyPC
         namEFtwBvbjmWthxzAx3ZPha13Axy8tuu1SzLmQf7W59FT5aM0tlJId/5kiVMZeNIEtv
         d/8jGIzdTmYsc/atA9RYrOrqJJHy/706uQ1RyCfd1tCZbQZGGq4JgGJ0ohizvU/G4ocZ
         /YNsr03r+ZP07PHUqnTTkGI6BdPTaRp0FoqtYzttMKjX6IP80KhiKkWLRNohS75gRCfH
         8yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FlPAulwmWkyz1yahlv2f08wQUUAS4uyz3bf+eAFUR+E=;
        fh=7Fa4QKZvLZw7SLKmBePNd1gJS64alS5VKEqBnIcJaxQ=;
        b=JwIIRE2EDKeSEg0xuYe10D1ZNQMjcFZl5bWlr25vb75jnrrIFUosfPrQfh6GncWqoo
         JkF0um7GKvp0P76OzBrvQX496gEuHqjsPlT/RVkRmBW+4NMPJEDC5zjq7tiRRRlRB80S
         9A1z7dF1Zaad3VrBqVpICEqHFdgmjK73CGGyCfPobdEYFZiNcZgQbIYUoqqzwkXGB8y5
         b609ulK4K6j5cVgTTwIKWfr862rIKLz6Rdm+zpF72JRtt23GtQfFLB+RfXmOZHIxF00u
         ntgvOx/iSjx6K6pzrW1Pq8sCfCIfZgcLBwSSz/9xHoSUOC1VQHdF+ockUDEja8i9ZIxg
         KNHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790994557; x=1791599357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FlPAulwmWkyz1yahlv2f08wQUUAS4uyz3bf+eAFUR+E=;
        b=daEYg6qlmdGl7wXp/3oFoRkKVLTjAdK4ayKH99VScCkaerIfwXL8ZaXln4h+g/M5ZM
         2EcHq+zdU8/e0Ew2zC8PcvJXXBoblZT4l++asiAp+vxj0++ACREp2/DzxwIqurnGl3vQ
         E8e+oyhjXGm7R2OGi0Hk033P4TT09rm5e35Rnxaq2BB9LAe7Tizcbz7Md2sHYpyZasW2
         PoHlTTWczniYvHvOqXX+ZOdVlN0bdUAeu7hY4MYUHbVWYnhIE3vw9A5Ab334xOYTnT4Q
         oln874ASMvm/lgOAU6LMb+YyJzuj5zm9jW5Tmgbd7rDdsBV1q3ZqxDhuIDBnPxXtQ+TA
         qflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790994557; x=1791599357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FlPAulwmWkyz1yahlv2f08wQUUAS4uyz3bf+eAFUR+E=;
        b=AnrEtNg39Amc0i+Mgx4BYKrbbGO3KmUKcm+u1LNFMQ6C0mQvYfwePWqynzXTvZ8wdX
         5iTOX0/eV7XpNda/LB7wIq9990Oi3BjlAmHMq7uuRfvVpaooXCjFxWrkU4+19eip8H0H
         ddKvxFUZrCSEM0ErHaz9893CthDZr8QS3DN2LFelUQNI4McpNzrARYSym+Ie727t9SVq
         QeV7YbvH6U4CsqTClkh3WIaki/fbjLXeVa9eEqOB5xjwDYRyz3xV39OBMAf3f4tllwQY
         wiki1nDMjENRJaSnfftmU7op9sHjmZIL0Q85mBAEV6R65PlIMs9Z0+Dym/NBJaw3kAtb
         bT8Q==
X-Forwarded-Encrypted: i=1; AKwUvByJJBIDRRUn9feRsIjutdy2OMICLlpcHoPNIvzEZ4abqCUj7bvILOSLfzVuXI/q0gcUgjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBY79jcrIoyIUUr+vvCOExSyxVN5qxHDl0IDURkreGGvjmZsTl
	tMIxm4X9/bvlEUnhpXnOgBLGZVLPyDxlKpUFAt4hqc969je4OYaRSvY4aNOVvA3wGDP2yIBf6/N
	zL2IE7IpsJHBPEMlQerX1tJww8N745jA=
X-Gm-Gg: AYBFou0i16ov9E5sw6zXE4Pv0/rdeyF1zBpnDrEoLeE8psy7Y4/VYKorHFTe7K9RTYo
	amma7erxjdy/Ya9K+yhXXdJUEnfdQDrUU1d6jJFZDxbXgGYizWSO6l6vmhMijeKAMUB7Vtiwf1A
	GiVGhKc+cG093sY9ruH3zgn9Ol2XCsr+dExscV0aupYQP0psRZQxHsogQ3kD8xUQraqwSflK5sa
	JS6xza7Cm6jKyLmVwm51hbY4n0lG8b7nl8QTPWcDNFnoPzGwIL3yisYgXa3Ww05jlgn32Kqsi7z
	W5MpJuRFedAxWrwWBRbJk05oZnh/lqwKhxIKYoCmOxrs39bCvtlvyOz00YASf33Jk0dEpnzneEN
	unEb3yMIR7UeaEt/3SpGh+o3bB3iEUxkZoinJW1v4GdVwicsBkp0Hq0iYXwD9JJxaM2dZ+PaSwQ
	==
X-Received: by 2002:a05:6a00:1c86:b0:882:26ea:cd56 with SMTP id
 d2e1a72fcca58-88c63e6f923mr969765b3a.35.1790994557090; Fri, 02 Oct 2026
 19:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com> <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com>
In-Reply-To: <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 2 Oct 2026 22:29:05 -0400
X-Gm-Features: AclHuK_n4D_X5kPJBF4dIJLMO1XsCrBae76fMejwyp66Y17a7DENsStH5HADpGU
Message-ID: <CALnO6CC+h1y=Fu438nm4cd0K-dfPVYq9MqX_+k8fxBU60ot8KA@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 1:40=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> Thanks for the review!
>
> >>  * I wrote that git commit does the same thing as git merge --continue
> >>    during a git merge , but I'm not sure if that's always true.
> >
> > See also discussion in
> > https://lore.kernel.org/git/CABPp-BEQSx4m3BcT28CpVGCtsH75+x3gmv4OJz_ecL=
VLx+kBWg@mail.gmail.com/T/#t
>
> Wow, that's a very interesting read. I'm more informed than I was before
> I read it but also at the same time more confused :). It makes me think
> that "git commit does the same thing as git merge --continue" is maybe
> not true but also I don't know what the difference might be.
>
> I've put an item on my TODO list to remove
> `git commit does the same thing as git merge --continue`" and to try to
> replace it with a more vague sentence that I guess says you can use
> either command without being so specific on whether they are exactly
> the same.

For now I would say the subtleties in that conversation really make me
lean towards the following:

- "git <thing> --continue" is, for most users in most cases, the right
thing to do. It's what "git status" recommends and will practically
never do anything surprising (?).
- However, it may not always be exactly what you *want*---and you'll
usually know when you want to go "outside" the normal sequencer and
commit directly (because you'll have understood some nuanced details
about what can happen).

For merge it may be the case that they're the same, I suppose (I'm
genuinely not sure), but I would prefer to simplify folks' paths by
recommending one of the few uniform interfaces we have :)
