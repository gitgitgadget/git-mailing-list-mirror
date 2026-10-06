Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFE3A7848
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280999; cv=pass; b=KtlHbGsHTIBQcIJEuhQ2IC2qt79y69f8JPz73vOwRNvpmJQ7GXK1mHuHBMz44EZfc8MBe6u+V8J//2PeWzUaf4P1Wo1g3Dv5LfIvYek8eiNV7qZRch7jyVO65P1SuxFE6QtzjOYI43G3e2PY0FlzrWDu/KOk1OLHu+7wZIcA9Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280999; c=relaxed/simple;
	bh=zYYuVU1E/r6DdMNqTp8PaqNsOZ2eGgYYq14RFn8GDDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5w3iFxvwEIwhrQHpWfAEH2ODounn9cwEKeZyXr9w0FdgU1NcVYO9YSHYPcNSeCXULAAsKe6iYnANBtZw1IzpIyOxXANNsFW1tjWZbsHgl7S0cDhwJKLiyPyucwZsfS1ZDGRIBiwbI7ydW2EFubJLzjiPvUv6Fcx3mvQ7Z4rRts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=VD4i5RSo; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="VD4i5RSo"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6767d92cde6so317921d50.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 03:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791280996; cv=none;
        d=google.com; s=arc-20260327;
        b=S2clUEujRgu9FPTxR6Gg2PCxB4j1TwUGBmfbMtMXPbRkviA4zfJrGbAaAicwsEIs02
         OpokumMVHZSastiBZvW/vtTYyWzomwBb6gkmj+y3v66gRsV5CyJPwe1qjalxW23BMHf9
         +eqJze5Zne2J7x5tsucbrkxusFqpn3nbNDtQCQ95lIYqztiFVpt5+TYYmA+yRx/scGfU
         tOvVjcTBuhwxQ509JhXgS+Am6rCgG655wRYtb9I3Yb9L+DddumdDWIkZ4NhvYYPDVABI
         ph4LdKhOqVDYObNzjazIEavZmRBCrAilKpGQqd9U87KOUOpmC2Dh8Af3Nc6gHhDHGaDz
         zGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3JMDYL8l40oMBOm5zl+9RvmOS5tb+way2/UYlKYnvCo=;
        fh=KJA8Pg7JgkuF/QAqwomwfot2qrkQBqLt4vAKZ0YeNxs=;
        b=Pgbzuy2PjQ8GeHEpUJVcMy49UjOT5D7vkuIbmAhKTcUFT8LtgWv5ZokD5HW8YCU+OV
         OEWyifg8vdb5qiuA7fek/BzT3h6B1BxizRyEbP+NbezkDvk3JfXfrvGSkIf6d6Z4fU/c
         pX5KdYJSavRzhhlbl56zDG4cGGxj96cyxHWCGbKu6xEcTr7+3BQ+LClZHJiuHlDoOOpY
         0+Wt/hMzjuXw5UjTNLdJQlusxC2hIEV94MvNF0lVOfW1c8oeQOYXLWq9bWUgInQxy0Ma
         RdKLAh2UpuCgQVN8fD7x2eBkLr9nzOmWbAkP/Ur+US7quRBqlRXQq4QvXb1WovgzkbmW
         V+uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791280996; x=1791885796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3JMDYL8l40oMBOm5zl+9RvmOS5tb+way2/UYlKYnvCo=;
        b=VD4i5RSo9ueossB1Z9Jxg+Tpq8VBwKpJjSocneczwAvoZqlny/rpnNJuVag1brSGqs
         RYviQsf0J4gDsxlO6IYa0abUkG+DBPPsK/T7t9QJAKN8v3PpQ4dTlwGCptY4k9s/d7G0
         eVWMviCTsWPUTc9dbnVQfJ5QD3MVXRm8Of63A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280996; x=1791885796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3JMDYL8l40oMBOm5zl+9RvmOS5tb+way2/UYlKYnvCo=;
        b=PsGnZTauvDHlniEkfU7J5KLWyJpsseO1h9KYNk+vJfXfuwFMGS8SD2Mo/vaOiaM9n0
         BKvzXd76V+cyJ1RZ1iYJdUZU0Li/Boic9g7b4vWU4sD2x4/Gm2nrFDerv8Y0wagjcnFI
         fmiGeALFCGwBgwSBMUHUxkNqJeXr8A/QzhSC09+gy/BHlLkUBF3AywinYkXF6YHsiPd8
         7pjB3LA3OQFVgcGbOouWIhw1XnLNgXkvV/2Lq2ycGh+3dZkVkrxJiCI2wbokhbBrlgyY
         qT5ktxLEqBttEH//7LhFkOpfZo2rw7yfJr3TYhqr+tG6kiHUKBfQreKL6KBO2a4//mWh
         +gNg==
X-Forwarded-Encrypted: i=1; AKwUvBwFVEJoCabD0N7Bi/BbWziEpUpafSg2pFjlMxB6YvnNfzZ3UZQJHnjwRJWmp2MbxsvZTSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdNpm0zY9G+PN7mWDaoLoO+dvauZZuJEseT5Gzgt/VCowiHoey
	I5lo7IzyS21wjsary63mFad9rr2cAVJPRK7gq8GCkv5L1BXLMTqLq53qJ6Y6OrichYeAjrf0DTr
	NkZjt/UH62tgrUy7fb0/y4lzOx7HRHI10vlm7eHtFITAJO7ns+rGKJbzUhw==
X-Gm-Gg: AYBFou057jZKCvPGNB6iJQaY42O2cFdzKjX+XT1ujlB3jAUdwfxMWPm9WW97lSlx5MA
	M+bjsQhjppuqakY74KTF7lJc7BeDBgoaoL3kQVKvvXoi+XvGRWOtWWgW8dVf1EU797+Fs8eIa7/
	OVneQtSvp0B7CC9UXAGq7AtZsF0Hpf1sUNXNvzpwGMMzmCxlGpmmTugZo8aZ5QLm1GpfLkKaUqy
	1zaZGA27jzBzLXewyhfNi8CgvRnQ6rIton0LGfvLA7yDEiE/5BHQRBrFiFxScJ+mZ6dwuU7lxUK
	gclX17f4VIrPwgelNmbPvyQjRDESD7d4SQXHc5729tzjk3MaLWPaCyc=
X-Received: by 2002:a05:690e:1919:b0:677:bcd1:82a7 with SMTP id
 956f58d0204a3-678fce03b20mr373621d50.46.1791280995766; Tue, 06 Oct 2026
 03:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com> <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
 <asNY7SfEohsOSf0J@pks.im> <xmqqece4j6t4.fsf@gitster.g> <asSOJVUTS3BMq6kS@pks.im>
In-Reply-To: <asSOJVUTS3BMq6kS@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 6 Oct 2026 12:03:03 +0200
X-Gm-Features: AclHuK9Mx7Y_ofiXpZFb8sWuc5dqfVpVrpC7UuOUsRNxOSMA_Wg4JsmPnU9GNhc
Message-ID: <CAL71e4PzQJz16BvP=zaVoS25R1ezai1R9UBZ2XDhNSYFYEpknA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: describe connectivity checking
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 07:59, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Oct 05, 2026 at 12:17:27PM -0700, Junio C Hamano wrote:
> >
> > This is totally outside the topic of documentation updates, but it
> > makes me wonder if we should pay attention to connectivity roots
> > other than refs (like index entries) that we use when we run fsck.
>
> Hmm, I'm not sure. I guess performance of the connectivity check is
> typically an issue on the server side only, much less so on the client
> side. And the server would of course typically not even have an index
> entry at all. Same for reflogs, at least in many setups.
>
> I also wonder whether that'd really speed things up if we add more data
> sources. At GitLab we typically have the problem that we have too many
> connectivity roots with refs alone, and that is making the whole check
> painfully slow in some repositories. So adding more connectivity roots
> to it would probably be counterproductive.

I have some followup work in this area (but I want to keep focus)
and it's indeed true that number of refs used as seeds is also an
important part of the problem.

I see connectivity and reachability as two separate things,
though the current implementation has an invariant based on
reachability implying (e.g. requiring) connectivity.

I think we could build up a stronger connectivity invariant
for the common case, where we can cheaply check if an object
is connectivity-closed regardless of its reachability state.

One idea is to utilize the fact that MIDX maps out a very
specific set of packs, so we could compute which set of packs
form a connectivity closure (and cheaply update that information
as the MIDX changes).

Another idea would be to dynamically load refs as seeds
in parallel with walking the graph.  This creates a tradeoff
between how many objects we need to check and how many refs
we need to load (if we load fewer refs we just need to walk
further to reach common ground).

Sorry, this is a bit hand-wave:y but my point is that I think
regardless of how this is followed up to solve the bigger
problems, I think optimizing the object-tree traversal is a
useful first step.

Thanks,
Kristofer
