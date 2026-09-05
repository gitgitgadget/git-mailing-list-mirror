Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB6212542
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586915; cv=pass; b=UWztSVSMJMNMCi/+UZtJ4PNqiFYDanhL8kO9eGZPQJtmpRRDe4ZT2DELefMSkgBxonhNNTweg0odOod8UCM+1gVvO1qOLzZoX/Cgw8lTG9Zprf+MNnytP7AuIMZiL43owBqJS/lTxL9JHvQFDbRBk8H96+QfNmfkRdSmHJyJ0o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586915; c=relaxed/simple;
	bh=yCdTSb8aYHjq8FrZTujQH4AP6ZMEoKARy3RSBnPHoqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZM1D+wt70U84Fai7wHN7fxoRU+HHF+m1pQ1Kx5ccULPVAF7+pYjf/CXzl+muoYhCqKYFIFGCynrOwcpjpVYggCIsiXmO3tjk1Q2SKWEA5qKj3F1gdKZpxt+aGncZonEPAcqeOkAZQ36OT0LfFi5/T7hCB2kHOIuIPwGwD4S/ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=iKIjsOW1; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="iKIjsOW1"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-85aa9c1308dso15755557b3.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 22:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788586911; cv=none;
        d=google.com; s=arc-20260327;
        b=rFD4gTJl0xuJgV+65ru9bafnjNxeSzQeBOsRqmGZ62oKNfqDRL+tuOxIyS6rtrbygf
         gzMpYFcxT5Ya/4jEPg57YBJ5EQ7RGeJJI15A3yuZHnofP5nJRQ2h6aOukfOL2imQ6ddn
         QiBvG/mvWRRpQ1kBsWWnZ7HIopQMMtYjWO9ert0EhndDxamVP8b2jWdHxwR9IT6JSRth
         hNCmuwCres+cGkUmJbfuNHz46cqFbyC9I5T1IW8RO/yK4AQmrQXDuyUOpvWSkikD6SLH
         WgE7ccNs7VuMcG9K0HMuo79b8FIzhBYAyA1vVyTeGeo194eGCrrVx/dlptJ3OCD658Ws
         fM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yCdTSb8aYHjq8FrZTujQH4AP6ZMEoKARy3RSBnPHoqY=;
        fh=7Uh6Bq3GCc06IiAqCO1Pt186BjfrolaRCNK3u0cYVcw=;
        b=Odu02jL7Fk5EldJWkSvuQtQtfrQM7/XQzJVRhStLPS+YwoKU5FE/KLfxtT0fNt3gwu
         jQWDnUTMxjWc5nskcg5wPmYppW8mty9wEIe/oSBZM8QqB+tXdOD2ldkOsSoUMNOjEkWJ
         RRztOj9QPSNKx6HjTkYNIEtcpnOY/SLMS4KqhdPiOX/7+kc1+lth1CoNw4HpHe1OUAhK
         sULn/YOXhoSyE5z6JqeXWWEioSbFC87Moey5Kjh0HwAYPb1bKc1yNaPK4BWjodmuw/oK
         LPoTPvpv3qPbQgAA2EvD57oAFLLRuP8qFFC4IIuFT6OlIVDCYeMmHZNrvkkbkYTwujgZ
         sSeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788586911; x=1789191711; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCdTSb8aYHjq8FrZTujQH4AP6ZMEoKARy3RSBnPHoqY=;
        b=iKIjsOW1qEmeoTy8+vCnGV4nb1tZJ16Ih8AhoIkSR/DK/rJyLCx82ORWivPsXAKXO9
         aHYn6woBHHEOPBqxggzUI3MKjz1VVVqhbnv9AG0Ue88UVGsFZTqlsK+zDdGAQCQbEn60
         YOW8Ci/NpFfqFEkoMCDMKdtnPPBN5M5xZn4ZPeGYqlsgYm9YW0829A5MBWGIAFNIglm8
         PoLjk5cUHVKBUZXd0V7sStrMh/IKhyvgdCGNXWo9bWfc5MUNVnuKOPRBgjmsXU5OoW6I
         tq/GI/8QPg9Xg5fgTVC/GaD9W6Ij0UIDBlwGhxBYHRoh4cShuz6UO1+GxznNUrIxO/LK
         c0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788586911; x=1789191711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yCdTSb8aYHjq8FrZTujQH4AP6ZMEoKARy3RSBnPHoqY=;
        b=QlbdQz2vPMIsAcO8eoPPwo3e7/wsXCnWem97NGuCFDt0kf+UCvKfimaEUyrhXmnH2l
         VlAg81tFg//bTyikOmrNXvTp9s0uNFjUwQLYdBnlhBsf0OSgP4YjtZMY/HBQ9wmlW6TT
         umm1FtWJ9bc0TMwK2/OQdZwI3h/R0g6uMnSjLFA5/w8regus0PM9mX03x1S/AyhVGk0D
         IdMfNftQDz3fQ5vqfiCi1HsMTfAty4qkhHFoJ5+XpsrRq6s2+TINd5uScFcQdYS4TmE+
         qrQeEfHX4THbBFgEeGsukZNxPeqBJnHNj7sE+mA+phvYHp3EeO3cbE/LXRTx39wwUzWf
         QJpA==
X-Gm-Message-State: AFuF++k0AKISOPCczRXHamfMwnhCnoeGJZN9hVjpE6f1ZaYGW/vy0R6c
	oYfF4q6pEnd2GtmJaWwo53o2QwJdOPBlM9nzRJfQ/QomlxBFnCZxdz/OL5xNf5SeW+TTpuqo06C
	HL11rgoL7WGaoH5bgQaiaY2FhIc7jMldphzSBztcxVg==
X-Gm-Gg: AYBFou0OomY5dtWR+Att9t8z6o+Fg5sRw6eAghgmO9/dbmtuq70ifMuAosjw+DOlFpG
	6k5AIYF5sP2ZhaVNaNIVdUXQGHsL9EG6wrI4PKaFUR45aGgc7SCkIaI9LGcpjzFtLdgSmI9wML9
	gfzn6NPe2MAIbo2AYht52hhWpcuZW2Cfb8Ww9TMxQrbszBwss8lfFuDEKYByecASJT6riWv1G/j
	YQ0SzrWTwcFZLagx1eHvLk3aADMnDdeF4tvaStc9E0u5u9UNUwICre/8KZl6gJKvT3HMTnnwIkP
	ec8LOdqvVMQxv1AHw0shBNWsnW+Gd+5Nkv97XI1MmoZdUiQE6+UIZa/TEsxX4jlJymswC2l/T6p
	rais=
X-Received: by 2002:a05:690c:e3e2:b0:81f:a9e8:f7ef with SMTP id
 00721157ae682-87125447517mr52893127b3.1.1788586911037; Fri, 04 Sep 2026
 22:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com> <xmqq4ig44ywy.fsf@gitster.g>
In-Reply-To: <xmqq4ig44ywy.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sat, 5 Sep 2026 07:41:38 +0200
X-Gm-Features: AcwNN1XJv9AaW_uche0lab_VEm4Fe8TInQkGccER6IpvVbnKcYTXX8J3BkgIZnk
Message-ID: <CAA0xjtqF_60kKC_B=-=AkBSG0ZiFd_uSjzCZ4Bup8Pvg1_uALQ@mail.gmail.com>
Subject: Re: [PATCH v3] rerere: keep a background gc from killing a rebase
To: gitster@pobox.com
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 04/09/2026 21:08, Junio C Hamano wrote:
>> semantics of core.packedRefsTimeout, then warn and go on without
>> rerere: a lost recording or replay is nothing next to a rebase that
>> cannot continue.
>
> Perhaps it is just the way the above three lines is stated and what
> the code actually does may not be problematic, but I am not sure if
> that is what the latter half of the above sentence is trying to say.

No, it's what the code does. Once the timeout is up, the conflicted
step goes on without recording the preimage, and the resolution the
user makes after that is lost, as you say.

The rebase that cannot continue is the one from the message's first
paragraph. It dies inside rerere, which do_pick_commit() runs before
error_with_patch() writes the state "git rebase --continue" needs, so
I traded the recording for a rebase that survives. You've convinced
me that's the wrong trade.

So in v4 every caller waits rerere.lockTimeout and then fails as it
does today, and only "git rerere gc" gives up at once. That drops the
RERERE_LOCK_OR_DIE flag and the hunks in the callers, and it takes
back what I said in my reply to your other mail about merge and
commit going on without rerere.

A gc that outlasts the timeout still stops the rebase where it does
today. With the gc giving way whenever it comes second and the
sequencer series keeping a rebase's own commits from starting one,
that should be rare. Whoever would rather wait it out can set
rerere.lockTimeout to -1, but I'd keep the default finite so a lock
left behind by a crash fails like every other lock instead of
hanging. Writing the stop state before rerere runs would let such a
rebase continue, which I can look at separately.

Thanks,
Thomas
