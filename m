Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2B35EDD8
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770564513; cv=none; b=jInJDzMeYcDeitDWFGQVkV0EC2uUyqnSQdgTkBu6bv4pNr6OSnOojb6N2eDME029P9HNBfHm6i8iPBOCna8Ff1HjDBrJwBAkVowFuFpiYUNQvncQX41BVp7UHBhV52WkwyHaSMcFxsyljhwu6opKA8tNLx1mFnzMq3NMlbyiYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770564513; c=relaxed/simple;
	bh=A5w5aXzhRLSyZ2g8PiUPkK6dPxT2acV1scems5aB5l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l37tKBZi/UGlf2WtgvHCBuroNuIkJmZp9T1i0RWd7bfp/ByaCPEzhMKE0CwXu4TvBX9Sd8C568MxyEXcBFLAGECGJkdOYdDjRxsp/0VOFPx/yWyfI59krfLvs/rMghMBoMcCpCeqFo2Q5bGO78N4deM1axzdVI4GJagQb9vSZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsZsZxPE; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsZsZxPE"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8230d228372so2136225b3a.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770564513; x=1771169313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWWIdfHDSSpRJJV6CqlqvQUkktMWue06q6QZBEkZv2s=;
        b=YsZsZxPEismGanmwDNtb3Am1+N8aKuMlvocnfAmd+HV4F7hzuWeaL7oiB8aXSYrwZA
         bRKwuSrqh3wGckcsVGJoObjgKXA8uCdEvNN7EgnSIn9c1WM/MXjiRN1rm/m4Z2v/f1wg
         MFPaFt5hCyHL20dnpd4Jgy8JkTwyl4QYEWWGcL3d+J5H/2sOHan/QpBHaPpWtxzsV2vX
         GeYVQ8eZK+hhelueeUZexAGcVf6vcV/uCT+AJzBTwqalr6mXr1JH9dR3ysdspBtL3U0X
         3lo96kFxXDFtZ3xXliZN6d4OZDMtA7GBA/Q2qQ5UgmK1bP3s//DgqeovFSs1yp9ZkQuR
         /dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770564513; x=1771169313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWWIdfHDSSpRJJV6CqlqvQUkktMWue06q6QZBEkZv2s=;
        b=Qpt9oaNVlwxZrDYToufL+DWOm8HLy263ZP8u5IyI+ekDmRXHN4mxD5//GCz3zRRHD9
         aGgUgfl2Dk2WFg8urqjVOrCZ5kOtllgE0kABZpah80WmAiHAZJCMzh8pEh9ZqCMXN/7A
         EdM6qYJxDTTARMA1vs2vMhjmmzBvj0uC3ZFSTbK+0lBBj8cDPycCa6hzy6uHVdvIJ3fx
         ppJPRXsM13aAl0DSwE7FAOReDzBsFsy4R3oIRVCH1bursi/Y7lGj3k00CykhX35lqw73
         HMc3VY4rwpVoi4Zexz+TDW9JT1+I5et/2XOv25rLhOFzC9gKVGFGac3LmRkSFkaWDwgw
         YBZA==
X-Gm-Message-State: AOJu0YxWkb3tVsXBrKdAOjbrI5DaUVPybFHg/OF8QngMFGMzFkuYsoLt
	EATC2A912EcxYoKbbQW6NjnjZERwnYAFuARQgTXR82lukc1XRdVibSuI2RVbMJMQ
X-Gm-Gg: AZuq6aJs44Yhd44EPW+o3Kr/69KlJem6liw8lGtW0EieltOj3FZSyCKEAS9Ntlgi0YM
	8RJaQQRSKtgZQ1K8v3f5L0XQJTM6yRFuLO/1SotiPxhFRdkW4eECjQZanXu4mCrSqYR9ylGijxT
	1JsVT/oymM7KwyJmTWFv3W2ifya/7YBUUOK6BPlNwkn+bmOTLpCeYcNAXjKEC+sOn0oO2j6uqaW
	khtlGLschC34i2L8LsIHBwsOo0fgP6oitDyiu+38ewdVlsvQEbeB/zs1SLsEA8Kv89gIALEoWNc
	aC0u7ITHCeE11bhtL/i2+g8rg9FRLsD5yzOuttnNJsYEyh6Lr99fQKsb9H7NSAuO03EE0EIOyPt
	VZIDeba483VFlWdcmP3qgeD/8iydZvuo3Ou0VuhESeapHZ8V8uNYZkd7dbcDR9lDruhYosPieMF
	8a5Agehan1Kn+UYgOIxFC06kVAEgVP9tDy37mA7UDG8M9Pl5c=
X-Received: by 2002:a05:6a20:c890:b0:35b:b508:b99f with SMTP id adf61e73a8af0-393aeeadaeemr7795513637.1.1770564512908;
        Sun, 08 Feb 2026 07:28:32 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:d5ba:a3e5:9117:b044])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e406asm10370994a12.22.2026.02.08.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:28:32 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Sun,  8 Feb 2026 20:55:39 +0530
Message-ID: <20260208152811.73213-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq4inrahti.fsf@gitster.g>
References: <xmqq4inrahti.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
> >> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >> 
> >> > -int wt_status_check_rebase(const struct worktree *wt,
> >> > -			   struct wt_status_state *state)
> >> > +int wt_status_check_rebase(struct repository *r,
> >> > +	 			const struct worktree *wt,
> >> > +			    struct wt_status_state *state)
> >> 
> >> Funny indentation.
> >
> > my bad, will fix it.
> >
> >> 
> >> Besides, should we adding a yet another repository parameter to the
> >> function?  The worktree wt knows what repository it belongs to.
> >> 
> >> > -int wt_status_check_bisect(const struct worktree *wt,
> >> > +int wt_status_check_bisect(struct repository *r, 
> >> > +			   struct worktree *wt,
> >> >  			   struct wt_status_state *state)
> >> 
> >> Same comment about "r" vs "wt->repo" applies here.
> >
> > Actually adding another repository parameter to both of these functions
> > is needed because of the calls like wt_status_check_rebase(NULL, state)
> > and wt_status_check_bisect(NULL, state) from wt_status_get_state().
> > In the case where wt is NULL, accessing wt->repo can lead to issues.
> 
> But stopping thought at that point is not a reasonable thing to do,
> immediately after you notice that wt is sometimes NULL.  It merely
> means that unconditionally dereferencing wt->repo without thinking
> is not good enough, doesn't it?
> 
> And what is the case where worktree is NULL?  What are we doing with
> worktree set to NULL?  Is it when secondary worktrees do not come
> into the picture at all and you can safely use the_repository?
> 
>     ... goes and looks ...
> 
> Ahh, I think the real culprit that needs cleaning up is the worktree
> API, where they pass NULL to mean "the primary worktree that has its
> .git/ directory at its natural place".  So it may not necessarily be
> the_repository we are dealing with.  There is *no* such client code
> right now, but we could imagine that a program that starts in a
> repository visits the primary worktree of another repository and
> asks the worktree status there, and once such a client code appears,
> we need to be able to say "we are dealing with the primary worktree
> for this repository".
> 
> In the longer run, I think we should fix the worktree API so that
> even for the primary worktree we will always have a non-NULL "struct
> worktree" object, perhaps with its .id member set to NULL to signal
> that it is the primary worktree, so that we do not have to have this
> strange "we must pass repository redundantly even though we are
> passing worktree" API elsewhere.  Not just this code you are making
> worse, path.c:worktree_git_path() already is a victim of this
> misdesign of the worktree API.  It has "if wt is given, then the r
> parameter should be the same as wt->repo" nonsense, which we
> wouldn't have had to have if we had a worktree object even for the
> primary worktree,  Look at how ugly that code is, and weep X-<.
> 
> And the same misdesign of the worktree API has caused your [1/3] to
> pass 'r' but yet still depend on the_repository, which you had to
> fix in [2/3], in this function.
> 
> So, I dunno.  If you are ambitious, you may want to clean up the
> worktree API before this series.  Alternatively you may be able to
> punt on the parts of the wt-status that interact with worktree API,
> and move the rest of wt-status less dependent on the_repository, but
> I am not sure.

Thank you very much for the detailed explanation and for pointing towards
the bigger picture.

From what I have understood, the worktree being NULL refers to the
primary worktree (as it does not indicate which repository so it means in
respect to the_repository). So if we want to access the primary worktree
of a specific repository or even the local repository, NULL does not carry
enough information.
And obviously, using NULL as primary worktree introduces extra checks and
measures as we saw in the previous discussion.

I would be very interested (and the more logical step) to fixing worktree api
first, and then revisiting the wt-status series on top of that, once the API
makes it possible to rely on wt->repo without the NULL risks.

So a possible in the worktree api cleanup approach could be,

* Make primary worktree as an instance of struct worktree but seperate
it by having a marker like id = NULL.

* Add this primary worktree in the struct repository (e.g. repo->primary_wt).

* Update/add functions, then find places that currently pass NULL
and convert them to use primary worktree object instead.

Let me know if I have the right understanding with this, and also would love
to hear more guidance on the direction with this worktree api cleanup. Thanks.

Best,
Shreyansh
