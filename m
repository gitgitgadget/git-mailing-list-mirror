Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054A1DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778321; cv=none; b=bJt5zqMb+KfR8aeaePRzXVmCGbt0MmrjEGCsuvmHTQkzd5bTRkyy5+nL3kl/4PI/MWgr/Yw8gH4TUVVqWvCUv3W2Xhdt+RDEPBKFRQyWcwUNcnRfsmhOc7LV+HjiAMl4uDiY9stlAZurp6iRP0l+xFT3IZkkVBqQsMzryEiYJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778321; c=relaxed/simple;
	bh=InwNyXEdW0kUQoD7ZDfRD5QT1sB07cezAjbQp7EDZ2g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOvVB18YuaqYzabOrozNg+XURDUqe7ASeWaAnCiyFYf6GAAQ4IdZ+OPeWPcVBr8zDDbL/rT74xcA3unKGCLRpjSbo55/hyZguUZVUGZutPod38HVtnp3+04/8CaXei1xtJXYG7SHy0Q/ukHHDBZUZM/1AVeFew3hkG4gr+gyjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=X2h3NHYT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="X2h3NHYT"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so436068139f.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778319; x=1760383119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6OO2WWxosP3JSAe4B+/csN87ZZFI/Pvope4jzhMMX0=;
        b=X2h3NHYTsqAI0mCNuoa3+noIQguMrXRu+wRR5nr8kBlAHXf/KHXuaWRKr6mpm5HvHQ
         MW1tbVCReHvDnZxJD9bRUuEtLLKJTB5Otb7ftDDtocdq0s+fwPHj31/jhnFs2yvq2K3K
         gIXITWM5GD6xg9kmPl7wd2upNv4GOfpb8lF6z265iRanO8PfvjpBrblA3ip8mxe0mUMb
         PhPpkoqbp6WasVZT5gV4RO4Z8lwAN0BdCoA+AEB9poBKTCWPPfN+z+O8DeSOwpnFpX/H
         KNsWYIRNr43n3jUgZP+A2hUI/lrftUPliKIEmZAF9Xqv0aGNCws/MWRQJNb7ImiHg4DU
         18Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778319; x=1760383119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6OO2WWxosP3JSAe4B+/csN87ZZFI/Pvope4jzhMMX0=;
        b=remPhb4DbX8WnL3RvVwNqLRoc6zWyz/heZZh8PoImlf/b6QRrFbRUiYNiH9qItPxKF
         SBGvAdcvmxiJo+GbuntNV5luf2d0Gc750/AAPDNbhlkpAc3Dy3b/NwNbjOSq/2HvISIY
         B/B+X8nOXOiRVdCJiPTMfCPiwvrdAsyvjH5QSzLEaakE6aIlw4PVKo8utwKemNW7xsJK
         52jYx0ChI2INWqCT+KiiJUyY9FC7xASD/zAC2nWbk2nX4rWAu7XgqjLFqAcWw7su9BlS
         FtFZGs4/8z3KRpTyhSh99iT7Rc3dYR67y5CinO4/5S/5Wf4xBbt1uk1X9TaAbOeCPhqV
         a0dQ==
X-Gm-Message-State: AOJu0Yx3oFAOg84sLYkh+1W1/U63QT9VueA0IHth3cDEGQNtDC+Nxdbg
	a6xnFJBTAm0MzWk8A+RO7urSUrsevNc5RH9A1hRPLdyN3XWVJlFhCrTvuYtlrEN/ZMrQZJYEVgq
	k6QX29QEOPg==
X-Gm-Gg: ASbGncuUMRzy0KqZLiQp1Lrtr0Ew1TB7nimpnMo30u1H8m56AOEjmHE2Mb3oAnuaQ7V
	r8gJsEijBN3rIr5Lw+Y6Ou4O2yB9054zGAzzNhkUloacBlFP2HwrkNa1XqVGpLQXNRv5dqU9gPL
	oP5TU8bq5QjjXMXmT78+gGlYfAhcA5SxrFDW6959vItqdVQRgDqvlFqAb9J9I71OoifxZKDXP/F
	0L7pkkUe5jS6yUcm0GDmkez0UXGv4hayvySAQzKSxWQO2+YmD0gilUR30jCw4ZNfYRZJUtHgsTJ
	USxPDVaVGfcMvmLa57bRwtaZzjGqIhm3SbfpC7TDulKYm3lnTTxyZWUuFzxPsYJGCfxTMxKO3fu
	ZQBtemjjiuHRVNfJ/rAbkehycecC+SKyNW2sA5me3o7XGx95guix+v38ghjb+MfiuyTULAQ5Ur6
	qrHU/25zxEXjsXwaomly7HMmIhAnH1ejtVJkL9+5S3LBaCqhw2iCR1JO2KI2V08Rf8YMksqHw=
X-Google-Smtp-Source: AGHT+IHcOqd104jDqTd3FgehRFXlvXsjSi4oyKLaO86GVoe8ZSNnvmoM3REyMB1QH2Z/ywHeE1ADRw==
X-Received: by 2002:a05:6602:6404:b0:911:c5f7:e4e with SMTP id ca18e2360f4ac-93b9695dbb2mr1706370739f.2.1759778318883;
        Mon, 06 Oct 2025 12:18:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a88961d74sm513607539f.22.2025.10.06.12.18.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:18:38 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:18:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 03/11] The future of history rewriting - rebase, replay and
 history (+Change-IDs)
Message-ID: <aOQWDdVn4wDeZtlH@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: The future of history rewriting
Leader: Phillip Wood
11:30am-12:00pm PT

* Number of methods of history rewriting
* What do we want the future UI and operations to look like and be easy
	 * Want good commit histories
* JJ always in Elijah's edit mode demo, always interactive rebase.
	 * Always easy to rewrite commits.
	 * Always rebase descendants
	 * Use commands instead of verbs on rebase command
	 * Git would have a hard time adopting the ‘always rebasing' model
* For new users, git rebase is too complicated for simple use cases.
	 * Top level commands to easily do common operations
			* ‘Git history'?
	 * Git history vs git replay
			* Replay is plumbing used by server.
			* History is porcelain used by user.
* Elijah - Building on rebase depends on sequencer
	 * Underpinnings more important than naming
	 * Lots of backwards compatibility assumptions
	 * Hooks and dependencies are pervasive, hard to clean up.
	 * When update-refs was added, it broke hooks
			* Don't want to keep doing that.
	 * Wants to move beyond sequencer (git history uses sequencer)
	 * Sequencer frequently updates the work tree, not desirable
	 * Git history can move to use Git replay
* A cleaner version of git history would be nice so others can try it out
	 * Git replay is lacking features needed for git history
	 * Trying landing experimental version with sequencer underpinnings
			* No promise of compatibility
* Phillip - users noticed when he broke Sequencer Hooks
	 * Disable hooks with flags?
* Way forward - land UI then iterate on underpinnings?
* Sequencer depends on shell parseable state files
	 * Lots to cleanup
* Minh - does this help solve problem of server rewriting history (ie force
	push), leaving clients with incompatible forks?
	 * Out of scope
	 * Maybe change id is the more relevant conversation
			* Conversation ended up on ChangeID
	 * Change ID loses predecessor tracking, which is more precise
			* Hard to propagate without Mercurial style logs
			* Mercurial predecessor graphs are independent of commits
	 * Change IDs would also help with first class conflicts
			* Finding range-diffs is cheaper
	 * Range-diffs used fairly widely
			* Git, rust, most mailing list flows
	 * Change IDs useful for tracking across repos, bugs, etc.
* Why are change IDs stalled in the mailing list?
	 * Disagreement on tracking predecessors
	 * Requires a protocol change
	 * Sending predecessors over protocol has lots of implications
	 * Gitster - disagreement on what it means to be a predecessor
			* Parent? Cherrypick?
	 * Brian - changeId should be deterministic. Reject non-well formed ids
			* Workflows rely on repetition
			* ChangeIds should be optional, disableable.
			* May track too much information unintentionally across commits, projects.
			* Gitster - needs to be possible to expose changeId, predecessor without
				exposing private information about private repos.
			* ChangeID exposes less than predecessors do
	 * JJ can't access predecessors from ChangeID
			* When rewriting commits, maybe we don't want the predecessor to be
				viewable (eg secret keys)
			* JJ can bump changeId when rewriting
	 * Gerrit keeps ChangeID in commit body
			* Rebase and Cherrypick don't support arbitrary key:value pairs in commit
				body
	 * ChangeID should propagate to be useful
			* Eg across mailing list
			* Can Git more generally and globally support headers in the commit?
			* ChangeID should be more 1st class than other headers.
				 * Hard for client to tell when a ChangeID should change.
	 * Recent JJ commits were pushed with ChangeIDs
			* Colleague branched off. Rewriting ids would have been useful.
			* Squashes, amends etc lead to ambiguity about which ChangeID to keep.
				 * JJ keeps the parent.
			* Gitster thinks it would be nicer for ChangeIDs to be kept even when
				there are 2.
			* When commits split, the children get 2 new ChangeIDs instead of keeping
				old one.
