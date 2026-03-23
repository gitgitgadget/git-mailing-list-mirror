Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915213859CE
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259034; cv=none; b=ZygTvhSehodDjNdyHUtGLDTkMz5wZ8hE25ngKIN3K5IrjM/mNnDV4GMO2S+OiYoWjiUbje8dQnXygLtg4kn82ouiUenUkP3JxXFEuov32NOnr6Td/P6jqezgXTx4o8Xjec/OpTJ0Bfa9ROYAuDUfwngbUE/OWevi+jPfohamrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259034; c=relaxed/simple;
	bh=Gy9Wyg2koqWzLa5078+7n/4i+2Ty8sJQCnlJmWq+r00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCqwAX7rlMaC7zw1e7pz9al5sizmSVhnqOWcl8ov/iwGgXyaw4pJqiIAt654MwLGyTDXVbM09WQnfFM1blaU0Jmveg2ERl2gK3GOgdDNWfsYdodgIu67IzGKj1t/g16yBZL8vLanZXXXzlBYUj1r1BRkEQooEpJeZBAOIcwI0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWqJJibG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWqJJibG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so49747715ad.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774259033; x=1774863833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoIUjm7sqqgmonxKLycLbu5FLx5dNBGXAp8F22p6/yw=;
        b=WWqJJibGX8PVt4QBq8bRgB92n+6vYBUahCF9+qQ6scOgF8+5dWuvmoT4VjWraYJD1r
         IW2yMoVVsbQdhFRd6XwxZfh1DpiLANvz3vH/7QFZgkPXlRvNJHcvVCi4EI6UfqSM1del
         0lQf1BsYR/LJAHOk10fYH7noBrGis2EujaEraREVpdNphk10Q4B9mXgjSf/lVlpGInPF
         1vvertFRfcqp5vaPVNuu3xqRrZ/sYL7yykaPS4I1SmfoiCOeYL+8q55iIvCS1OP/5E+6
         xpwnvnThtu3M0bFfhtzJ+UZt14rxkjZifQ5zpeSdNpkEMJ+1iB40pC7j8icouIoxc/4s
         ng8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259033; x=1774863833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoIUjm7sqqgmonxKLycLbu5FLx5dNBGXAp8F22p6/yw=;
        b=jyMWlM2QNO+NpmSa7xq5ZTPwyuti32JbciZ9Lfj7WRHdLn2jNrFSUGrG66t9cPpg7b
         uoXXoSXXwPDXoexLEOVtgfDzblIBvAsDDx10CClRsVXNI2UFnKrFw0/KZ+TrF+JXZMkt
         N2vRMcg0ZAfS2wcA+/eFSbCMzkj8aIAEAI2FNggWhJXkylz4eTYlbdRnUsOcK6VgZ44O
         oj8epvt17GSvrlsSe/lEP/Hz9HWN0UV5lGQ3S9xm0AzC/iOXyKfHVjpQ8AjOr8uXjIV/
         X3+euhm7NywpdK4exU2C9K+8PysKYsXvj9oDQfg4eslnEHFivYC9WQVobqetXGSbpB0b
         BpZA==
X-Gm-Message-State: AOJu0YzQ+5fNKzDutgrl/4W3LFvyb7Q1ALTqluF/lKkGsmPD1Nf2b0sW
	1TnWP8TUEtlgtMAkzMThG5lgl698rJDxVdTFSzcGttc4aDcVVtIwyO93cxNbLg==
X-Gm-Gg: ATEYQzw8IML0tLaF5U9ZiccUPM25AMYmt/MV1Eg8DUOLmpSG7rPJGw5gJMuyMIDp5SD
	OZKboufz5Jlq3+gR0w/1irsaw8z/MI4HTIAiXDpApfy/kM3y6YN3mLR5D0Qb1TO5obiJiKX4gdU
	ycnaWM4+W+lWqN6OwjQRNVOd+79mYYZy1XibFyUmLcbVQoZ06L6eiTKcmozUQXEY84iV44gbNw+
	46x8fkm3JdQDGjcWQLHOJTnrA6JuPqWzE6q2apUK756Rw5slEHJnTuGvEsrkceHHX2x6DfdCdCj
	H19B7sdGceTlVfOnB9GWW2zPxr0qt0140F72klrEYqCIAEv/ReFO5DDdpNRe1gB1/x46XGjnCYH
	lUoWecaDv+LRMNLo+2T3cgi0nA/uL/SdwMySfk/JgFhOOLEv/rk5wgVXEspXG/y0dkDzYJojag/
	XLhKlhmvkL0LDESf1prJd9z53rGpvDybu7FYLgex1DQA==
X-Received: by 2002:a17:902:d481:b0:2ae:4948:f866 with SMTP id d9443c01a7336-2b08272f608mr116370055ad.22.1774259032603;
        Mon, 23 Mar 2026 02:43:52 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:ba2b:bc5:2170:ca7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351675esm132140555ad.14.2026.03.23.02.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:43:52 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from is_current_worktree()
Date: Mon, 23 Mar 2026 15:11:38 +0530
Message-ID: <20260323094341.880375-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9c915043-02da-4823-b4e7-d2a340c0373d@gmail.com>
References: <9c915043-02da-4823-b4e7-d2a340c0373d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 16/03/2026 16:22, Phillip Wood wrote:
> >
> >> I have been staring at this code for longer than I want to admit, and I
> >> still haven't convinced myself that this is not a change in behaviour.
> >> I think what I'm wondering about is what `is_current_worktree()` is
> >> actually intended to do. In other words, what _do_ we consider to be
> >> "current"?
> >
> > There was some discussion about that in [1] where reviewers were
> > surprised that we needed to call is_current_worktree() here. This change
> > is consistent with the rest of the patch but you're right that it is a
> > change in behavior as at the moment the "current" worktree is set by the
> > worktree that the process was started in. In practice we only ever have
> > a single struct repository instance per process so there is no practical
> > change in behavior here. At the moment, if you visit a set of submodules
> > from the superproject by forking one process per submodule each
> > submodule worktree is considered "current", but if you visit them by
> > spinning up some threads in the current process they are not considered
> > "current". That seems to me to be inconsistent as the process started by
> > the user is in the superproject in both cases.
>
> To add another example get_worktree_ref_store() checks `wt->is_current`
> to see if it should use the ref store in `wt->repo` or create a new
> store. That means that if we use `the_repository` to define the current
> worktree we'll end up opening a copy of the ref store in `wt->repo` when
> `repo != the_repository` and `wt->path` matches `wt->repo->worktree`
> when we could be using the ref store that's already open. It is a bit
> like the bug fixed by 1339cb3c47a (worktree: don't store main worktree
> twice, 2024-06-06) but for multiple repositories.
>
> I'll re-roll with a bit more description in the commit message but I'm
> going to be off the list for most of the rest of this week so it will
> probably be next week before I post a new version.
>
> Thanks
>
> Phillip
>
> > The "is_current" field was added in [1] without any discussion in the
> > commit message. It seems to have been added to stop the same branch
> > being checked out in multiple worktrees [2].
> >
> > Thanks
> >
> > Phillip
> >
> > [1] 750e8a60d69 (worktree.c: mark current worktree, 2016-04-22)
> > [2] https://lore.kernel.org/git/
> > CAJZYdzhG8h3s=Ep1fuGbam1cWhYkv0tW6tQ7pBGGj+fj6=Nrsw@mail.gmail.com/
> >
> >
> >> I would consider the worktree "current" that the Git process
> >> has been invoked in. So if I pass a repo other than `the_repository`, or
> >> if I pass a worktree that is not the one that Git has been started in,
> >> then I would expect the function to return `false`. With that naive
> >> assumption your change would be breaking the existing logic.
> >>
> >> But I have no idea whether my assumption is correct or not, as
> >> there is not really any documentation of what the function or of the
> >> `struct worktree::is_current` field. And having a look at a couple of
> >> callers doesn't really make me all the wiser.
> >>
> >> It would be great if you could shine some light on this and then also
> >> add a bit of documentation to either the function, the field, or both :)
> >>
> >> Thanks!
> >>
> >> Patrick
> >>
> >

Hi Phillip,

This may be slightly out of scope for this series. My understanding so far
has been that originally wt == NULL is used to represent the 'current worktree',
which eventually meant following the process-wide state (the_repository).
With the ongoing multi-repository work, the meaning is being changed to be
interpreted as 'the worktree associated with the repository that we are working in'.
However, in path.c there are some callers of repo_git_pathv() passing wt as 'NULL',
I know that there is not involvement of the_repository state but it would be create
less confusion if the semantics of worktrees are same everywhere. So if we replace
those NULL callers with the current worktree and update the checks of (!wt) to
(is_current_worktree(wt)), some tests are failing mostly related to refs of linked
worktrees, and I think the error is originating from this,

        if (!wt)
                adjust_git_path(repo, buf, gitdir_len);

So I am a bit confused to whether wt being NULL here could mean something else
behaviour wise ?

Best,
Shreyansh
