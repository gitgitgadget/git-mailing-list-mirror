Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C32D0C99
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323054; cv=none; b=IrgORFfWq5LBJQXCvFcM+edQ3I1vXd2vLRMMVoaJTGrqZb0g/AKQMdLEFzNXLZ9ynfembxdMz94KwMnXosnC3dRwvD7wFfoFHBhS6xpYQbjzGmRGtreJ+ACXFiUR9s56+NGQLlICzCej72mxsESio1VJ3B7kvHm9KQMTuwFgZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323054; c=relaxed/simple;
	bh=DLX512qwEY6YQeCiv+b0Xbh2ICC3wKb9bV3bnYs1GIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a71Zn69gmEg640SsnWGp5yCtBeBD2zhDp08IEjBay97wNKTkj7kV0dROFFNiGU8mEFxilhRnCDxsNEPcUsM6enTfM5YaGnqro2yUJaqTdTslnVV1hKyfMMvL+YtY2+2BGlJlUoZshYpPy2ycBnlEt1CYALKldEMZV0KJ7OYFoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiJmSgV1; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiJmSgV1"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso2325665a91.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771323052; x=1771927852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQPFiwTCW2jlJsucRCEby+gb84AF852Toxqq63iOGtc=;
        b=LiJmSgV1AoIqGZ5WR0S/BnnTS6fgoPboD5uq/ilmEXN7YbnPmyLejE0gj5TS1sGAW7
         qfek+3v8BQ3i8ApaO/sFOvrPoUSI31rKepQv1YN0hkBUI5B/GPbgRwBga4N4SF5I8674
         MODCSY+30M0x8XbV1qsMTMYk5nPWxwpz9c/4H3F8SAUBfJ+ooTSH+0pbNMfWuUhUAELB
         /u7y6BliklrlyOzGHv8I/u+oDxwq48jzLCqYkQPX7ONz7B3zSAjRU+Kzc8LDJtcYtcU2
         EhnYAq5utJPfp0IQtqOfia1DzqyKyXFQO3qrlCEfOhpYjg6TKteMetGWViNXshH/Pdfa
         Xeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771323052; x=1771927852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQPFiwTCW2jlJsucRCEby+gb84AF852Toxqq63iOGtc=;
        b=Sq2XXZgeK8A4DmYhhk+H2/HhpdSJMWFYUnRfUVLSGsxHr226MvwPYW3r6SnZNnXUCY
         SzQvpFOmPnZIO30z4S6QJQN7DZf5GoWBt4X1R48kL2/byjUPbesre8eDb4eZVs9drey9
         fIc8oUcBYU3rh79jrw9t7oVwtt/ZI9KE+h4FRqiAdHTWQjFdOnqpLDoSScGRRR1zuthj
         JCuIDVXhbnjaNFWwIu66ZeRU3FqNk53Keh1wpLV7T2nBgLbIyH5RBzB9CG7si7cEAE15
         gxciCbmPy3+UndDpCT07WbCKVPSHfwXW/ftg/qykOH0Oz12csDD5//q8hoslMdf4Li0V
         jn/A==
X-Gm-Message-State: AOJu0YyerwSL+Fcs3YE+seNto+VkAn9fiWg2lyOv+yJzV7/5w7Rh7/Xv
	9dZjaRmNpXzfnYNgtciZFvDEEVUTa/d5cOEzAUcO3VtkF9rCOwgze+WgIcR0kcmpptX7kw==
X-Gm-Gg: AZuq6aJiknNWrXKiDuAUS9TWlW1gm/Hqdvf6EqxkIlx01pkmCO8Ojff2yHosWUIEh+8
	J+KStiYEi2ybijIu9Dk9WetHOf+QZEQVy5eQ/UOiWAwNf3OEZxsUIdyojAcBGqbNJzqTCvBwtsN
	n1KULf35HrAy8njhrWpblIXqSjcjk4IEg4r35Fwu6t0+g4h5jNmZepWD8BRTeBQaSByP6RVkoib
	Qo2fjC29N46oeqDX1JSVwa2lZkhDuf6/I7eHCqUmfE3n+hJ721ZYM6zMDLx97mjW8/EGoAdZep3
	yXZsPo54uKLuLWUDlp9bVnTPcIIo1fkQHRiW1svUGRgSPLXFhNIlv8AUYNt47tw54TMTxG6hCeU
	Y9zbnGPBbLaEBGUllsnvfUr9AS4ax7h5tFbwbr1gXvbVCRCCpiEnA0imiegR0VPMGmksL6qW2Pu
	TAI0kPceWYGIRpvawjLmpeia2ScqvEFFg9teJ6epX0Ld+d4tRt3fAfSvdHRQY=
X-Received: by 2002:a17:90b:2dc7:b0:354:9b26:cdf8 with SMTP id 98e67ed59e1d1-356aab9a321mr10476212a91.10.1771323052119;
        Tue, 17 Feb 2026 02:10:52 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8c2a:3e1b:2a7b:dd15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm22273988a91.17.2026.02.17.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:10:51 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
Date: Tue, 17 Feb 2026 15:39:34 +0530
Message-ID: <20260217101016.13641-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <66b0f03a-36ab-4305-814e-6d964f5d33c4@gmail.com>
References: <66b0f03a-36ab-4305-814e-6d964f5d33c4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On 15/02/2026 08:56, Shreyansh Paliwal wrote:
> >> I've cc'd Eric for a second opinion
> >>
> >> On 13/02/2026 22:29, Junio C Hamano wrote:
> >>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >>>
> >>>> diff --git a/path.c b/path.c
> >>>> index d726537622..4ac86e1e58 100644
> >>>> --- a/path.c
> >>>> +++ b/path.c
> >>>> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
> >>>>    				   const struct repository *repo,
> >>>>    				   const struct worktree *wt)
> >>>>    {
> >>>> -	if (!wt)
> >>>> -		strbuf_addstr(buf, repo->gitdir);
> >>>> -	else if (!wt->id)
> >>>> +	if (is_main_worktree(wt))
> >>>>    		strbuf_addstr(buf, repo->commondir);
> >>>>    	else
> >>>>    		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
> >>>
> >>> This is curious.
> >>>
> >>> We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
> >>> use repo->commondir for both.  For the primary worktree, it ought to
> >>> be the same as repo->gitdir, so it should not matter, but makes me
> >>> wonder what the reason behind this difference in the original.
> >>>
> >>> We have been assuming that wt==NULL and wt->id==NULL both meant the
> >>> same thing: "we are talking about the primary worktree".  But the
> >>> code around here before this patch seems to behave differently.  Is
> >>> our assumption incorrect and are we making a mistake by conflating
> >>> these two conditions into one?
> >>
> >> My understanding is that wt==NULL means "use the current worktree" and
> >> wt->id==NULL means "this is the main worktree". That would explain why
> >> we use repo->gitdir above when wt==NULL and repo->commondir when
> >> wt->id==NULL, as repo->gitdir is the gitdir of the current worktree and
> >> repo->commondir will be the gitdir of the main worktree. If we look at
> >> the code in wt-status.c that's passing a NULL worktree it wants to know
> >> about the status of the current worktree, not the main worktree.
> >>
> >> I think that we should add a new function
> >>
> >> struct worktree *get_current_worktree(struct repository*);
> >>
> >> to worktree.c that constructs a struct worktree using repo->gitdir etc.
> >> The worktree id is the last path component of repo->gitdir when the
> >> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
> >> can use that function to get the current worktree rather than passing
> >> NULL when we call wt_status_check_{rebase,bisect} from
> >> wt_status_get_state(). We should also think about whether we should
> >> change wt_status_get_state() to take a "struct worktree*" rather than a
> >> "struct repository*" instead (I've not looked at the callers to see if
> >> that's sensible).
> >>
> >> With that, we can gradually clean up uses of wt==NULL in the rest of the
> >> codebase overtime and eventually remove support for it from worktree.c
> >> rather than having a big flag-day patch. I don't think we need to change
> >> uses of wt-id==NULL.
> >
> > Thanks a lot for clarifying. This helps solve the doubt regarding the
> > different usage of !wt and !wt->id in strbuf_worktree_gitdir(). I realize
> > we have been under the wrong assumption about what wt == NULL represents.
> >
> > But I still have a few points where I’m a bit confused,
> >
> > If wt == NULL is meant to represent the current worktree, then what role
> > wt->is_current plays in the present implementation, and if they both
> > represent the same thing then wt->is_current wouldn't make sense if wt is
> > already NULL in the case of a current worktree.
>
> wt == NULL is a shorthand that callers can use if they don't have a
> struct worktree to pass, it does not replace wt->is_current when listing
> all worktrees with get_worktrees() which returns a NULL terminated list.

Ah, yes got it.

> > Beyond representation, I’m not quite understanding on how call sites are
> > logically differentiating on whether the intent is to 'operate on the
> > worktree we are in' or 'operate on the primary one'.
>
> We're nearly always interested in the current one. The primary worktree
> is special in that it cannot be moved or deleted with "git worktree" but
> git commands generally operate on the current worktree and occasionally
> check the state of other worktrees (for example to avoid checking out
> the same branch in two different worktrees).

Hmm. Understood.

> > And I think if we included both in struct repository (r->main_wt, r->current_wt)
> > so accessing either of them would be a whole lot easier and also would
> > prevent confusion in the future.
>
> It might be worth adding the current worktree (or probably the worktree
> that the struct repository refers to) to struct repository in the future
> but I think that is outside the scope of cleaning up wt-status.c

Right.

Thanks for clearing it out :)

Best,
Shreyansh
