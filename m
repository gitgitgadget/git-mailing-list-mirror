Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B516DEB1
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026086; cv=none; b=j/tHM/3RSsE3b8nx4gQy+pB6AvAe03Y1LDIlzusiP5qpR/Kd0P6Je8BLbg1AJpRqAvuzVtH+OUgcWkng6bCj4hqFHmt5TzzODnlzR0Wdag47j4nJcPnqHs8OrRYvNBJbpx1hVLzy+LCD3esZvSscyjaLq/QU2rXy4h/TmmOOUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026086; c=relaxed/simple;
	bh=oC2dx9ojbaqwVWBt0GOLji5PaNlfZPLknRmfjX5pE24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVRT6tqXjHW35YltQ4ZSsKZm0q7unOUButC6wc10DzJuT+iAS+RA0/vNkbKfs1U6UVDxr/4sh53uZ+nLqUejdUi2KteloavnOEmWRC3y+rq2FEa0eRyWhWobeXof+CRWKaaBTUhTGQqRJJNDe8XORvJqZLf+lFZoj/7xq193PVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=XwnDjQd4; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="XwnDjQd4"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6360f986fb0so2705637d50.3
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759026083; x=1759630883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCTqMXxzkrcRxR1z7h/sRjKg9Gwmvj+uFp4pgCeY7cc=;
        b=XwnDjQd4HlMIS7TGEfbEK2jy6Pp/bNhxV81tZpvNSkn2QZ/MaDxchvhvEAtEf5UWFc
         TeOurlyKAXdIqtpeg9VycF+dcl4Oc8v4kY4IrMVaQWmtBIrUCXBRtcPDYKvsc6Q2TnJg
         qYuKt9iyfxom4EIoZifrVgZ59XR57/SF9b7dJigO1ivTxvsMTHU/Bk/qaMNyaHgMmYeb
         GUyYb5dDLIbL/rSkVShqaZZdnWG+UXLqvwMp+JhXVPZvnhLBidfMdv6KFR0FwZGARXq7
         qGnPsHf25dGcbtwUR9F5b8PKsKp7kY6jvyr3LmzcBGRZM0l1yNwOxjSpQHkLYAlhqB9G
         mTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759026083; x=1759630883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCTqMXxzkrcRxR1z7h/sRjKg9Gwmvj+uFp4pgCeY7cc=;
        b=VHfSYOxRdPJlrj5ua5abA5IaZQlTraqrRNkY306xwfs3j72LZiZgguenMY0YrhdJHw
         r2Vo+V4NR2QwS+TURb33iZDs2zrYgNcdo30ROGDZtvpSptMCS4E2wEm3gNzmbQB6RlRP
         CTfpyihVOlAuMksnea4pawLJdb4C8PmHhJ35feGh8OmdHerc/bXt1DpPQiyY2X8NxQYO
         1yPmS50QXAV2bcC4d8Mo+a3zgyy0NBAuKOiz/crVyuc/lgKGmgEdYjxOLvbFuKF5djWx
         HkOg73J1FmUIF2bRLWag8PR1wCIGHgPhQQn0g0dkRJVMmi7D7Bd4laTO0trUqJ3GEC1a
         gLPA==
X-Gm-Message-State: AOJu0YwHCDToojTtSllPVevLNr2ckuSvnhH6DJax9JdptOKfxvZKHiKh
	RwCynMy1p4qksnjjX9yT5nXQrH0Ek6/2bxkDTpsLVSuKOCN8LsQj3fsK4DBv8EhqFqg=
X-Gm-Gg: ASbGncv900prXkcHEY/FjkpQ9RfL9zttysokgKuaQZkniriSgRpNW+MIkzbleHPF1pf
	jAbNqJAH5VJJFrr58YDqs/V3s1sSOXtY4GqxBqzPsY6U0wdGAlUQzd8oZuCZXj2U31b3goNocaB
	dGiF2zRGkb+10FY3PE9B0gXRsG26cs0OT3UG6FiHx7t74h5N1FrwhmeJA+d8t7hZBjClpkOH/XY
	ilNBBRnpahwtOlx/WaMji6WhB+RB7Y+FxI7B8gUJR/IJ8mj3kJyOxTBXJAgN8LSGulUX0T2ktO2
	EmOHcYq6t1wXfcCarX5V9Lf+7nsforH61Z5lpq0G9S9xh9MMEQsb8tACSChkEgtj2Rj3EkAwAdL
	sJVcWBC1BLa4yhbX8fYX2Nnv4McaJcGL205MPAyZfbh7e6dEPlRYkFaqaXzw3tDJvMFfyLXp1YO
	ywtPBS0Ch3WnAxmze6I6jYFNC8NJO2jROv+6SN1BNlgvl2GQZCZeU2rLA=
X-Google-Smtp-Source: AGHT+IEVqgh+HYOqSAO6M43C0fW6mvtXma61IEcfFEU2dK5Sm7plaHv/z8ZVps8xCYnSC31h0l3khQ==
X-Received: by 2002:a53:720b:0:b0:635:4ece:20a4 with SMTP id 956f58d0204a3-6361a851688mr12078786d50.41.1759026083232;
        Sat, 27 Sep 2025 19:21:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393d51csm2400696276.27.2025.09.27.19.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 19:21:22 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:21:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNiblmQxtZyigbcu@nand.local>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <xmqqseg777k8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseg777k8.fsf@gitster.g>

On Sat, Sep 27, 2025 at 05:19:03PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> ... (note that this is based on the assumption
> >> that "find any remaining bugs while it is in 'next' before it hits
> >> 'master'" philosophy is working, but we have never run experiments
> >> to shorten this to say 3 days to see if we see more bugs on 'master'
> >> yet).
> > ...
> > I have a vague recollection that Google internally has their engineers
> > run a version of Git that is based on 'next'. But after spending a few
> > minutes searching through the list archives, I can't seem to find any
> > record of that.
>
> They do, but the frequency they update desktop installations is lower
> than the frequency I merge new topics to update the tip of 'next', so
> I suspect they alone would not be sufficient guinea pigs.

Good to know, and yeah, if Googlers aren't receiving 'next' updates as
frequently as the maintainer is producing them, then I don't think that
increases the risk of shortening the period for which topics cook on
'next' before graduating.

> It would lead us into ugly awkwardness when we start clarifying what
> exactly "contributor" is in the new sentence, though.  If a person,
> whom none of us have ever heard of, sends their first message to
> this list saying "Ack", does that count?  If an active developer,
> who is known to be sloppier than others, sends an "Ack" to somebody
> else's patch that was posted 3 hours before (hence there wouldn't
> have sufficient time to think through the issues), how much should
> that "Ack" weigh?
>
> Perhaps rephrasing it to "those who have helped in polishing the
> patches with their reviews and discussing the issues with the patch
> author" to tighten the language a bit may help?
>
> I dunno, as that would still give the "ack right" to a random
> noisemaker who threw a drive-by "review" that did not add much value
> to the patches, if the original author responded "Thanks" out of
> courtesy.

Good point. Having a REVIEWERS file might help with that. Perhaps that
file starts with just you on it, and then it can be expanded to form a
network of trusted reviewers over time.

Building on the "how code review is done at GitHub" thing... GitHub has
a concept of required reviewers for PRs based on what file(s) are
modified as a part of the PR via its CODEOWNERS file. I share your
feeling below that the project is not large enough to have individual
areas have separate groups of reviewers, so perhaps just a single list
is fine.

> True.  It was a strawman to invite other more realistic ideas (like
> your "positive ack required"), and was not necessarily designed to
> be workable ;-).

;-).

Thanks,
Taylor
