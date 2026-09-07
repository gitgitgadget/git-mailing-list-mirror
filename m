Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4447ECF7
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798936; cv=pass; b=OZg7ONGeTi1aX6qIX6xzkCCczCccb/SnWDtc2I9c8mlxzAaO07ltXn3A70/G+SpP8y4w86cZuyzIvRAxoJ8OiZ1l6iCbRWtPInOvBOSgKhEna2uCtj7NJ6AOtuYZC6hAyHM4Nof1Zjvl5S/xNR24IYw4w6/t3sF4tcxi7llgsHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798936; c=relaxed/simple;
	bh=FJr4MKXXnc7KQ5zGHQ6Pr6WSCQq3k1WYF4y/Ud2V/nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnojISmVKugpgT2VpUDsnjf7YGF+hH/ChuIMfpaJEzW0JYsB7xWo5+82gjm5xubkQD4RZV5sYmM7rOu5/wx01oVTCHvuAYzK18RSHVTKxebLJlWID3INIOKqajcSuK6nhG4xtnNRBeV1hxmkJhodB26t5xVxjddiyuj6QRp2Cb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=yW4KDwID; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="yW4KDwID"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c744a00edso2952388d50.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798931; cv=none;
        d=google.com; s=arc-20260327;
        b=cB6TLqo8Wv3JRMIHV490llJwCR0POGoyCC06fFZDWE9JvZGDquOSEzOQIvCKTExbdx
         zHlIxb3iMdxIuye7DRcjb1YAKBCYef3nFK9rEr+9McPfC4mGpCbgca6d5pwR2yEhaLsQ
         iOMOTTPiWnfk8HleSYEo0/5gxbo0kn/hXVYlXnFV+5mWAZTqMRByfb3vmTwXFf1/X+8+
         PT04YgzAnFPFsuY7ayePcziAhgCTgwIhQ4lzSfBis2Uv5ta63kAOwC8UCB1uJqsodl79
         7ce1lli8nbn7N/9LagXmmcOPDByiDNN9kDXLO4JjpdRMimmPfj5PAnyNfxHh5cKpR5Mv
         HkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FJr4MKXXnc7KQ5zGHQ6Pr6WSCQq3k1WYF4y/Ud2V/nY=;
        fh=DODnQCqkWDdUbsQb+QVlPbHuCSEyESHAv6/EsgoeJ7A=;
        b=rAfjg+0X5qUBB5zhJ5b9abzkJFBHp07S67bmTaEXWUg4a3bqxaHpEYp7nsYgGGyqOi
         Erowg4PVmOgNODzp8Q1SsJN1ApeIzrfVzqR9ME+fvfmVxlUn7LdwoMwcr5DD7qkkIzha
         T+GnOOf2U97+CA2Suvga3E3nLI3DuLvi8Lv4SoricWdtMAdp5fKMil+FHR4UMXliSSj8
         sE+tyA2zVNnVtv5XX6rku2lWl+9V2sMGcuUHc4/GfD6rGzl5W1E65VshG30oGFMBwvzj
         02ahAs6ayOfFnTZgyH/xX6hiAejsAad2jAZlYkwWRSdTIl+g72T7ZsRkmFfofZV+yneN
         fyCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788798931; x=1789403731; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJr4MKXXnc7KQ5zGHQ6Pr6WSCQq3k1WYF4y/Ud2V/nY=;
        b=yW4KDwIDSMDuEWNwZ62jmXIXPXLbnuy8uvPQVYSRCKWKW0+2WoH32JXluY/n76YiSN
         gL80VClxKnMyPh35Z+JcCPMJ+ZW9syWkgokcUGPAqzUY9yDzKvLcONqE3FuLAqb4Bekv
         Ftv3/GOOvyQ+yhyooS8Mscsit18xGfJXX39Lf3onB59ZrmzI+RwgNLjL2Q2NqTbfSM1N
         bIpNBcVTuOMz6ygPL+ig1Rq6DY+gTwBYGf5q3fovX2qVRU8M5TqAQ5S0RK6oLa8DtEgM
         9cQUZ1TEQfqz1dHtfo+H9vgrH4jPv5+o/kRDAGNAk2VUiX4rXaBsgS3RDkYImPL/ehpi
         zyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788798931; x=1789403731;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FJr4MKXXnc7KQ5zGHQ6Pr6WSCQq3k1WYF4y/Ud2V/nY=;
        b=YuplQ+Exd5Ff1nR3urTPPprD1gV9EujKBF5AO5PPypIddIMeDylsvU9So6ucvtxJ8n
         cNxiqI5cQfJY7CjtEzqdtXeui+dDqzgpgow8Dfzq/zYZ+RbKfZ4eRv2egb3Z1MZqwpXo
         niYTEy7Om9GOoTIYT4ufgQ+BLwmPv+GcG0lrv0K8x4sCm/5MJI6WGbIpIJlsj2ka2BJj
         L3TTFq25maKKqQymrgPp9PAijEsTAHaw/EVkthT46s7T93ydQsxVAUz7ECrycojQjpC/
         Rp/A2sodi5KUp3MM64VG7PI03ogwb4b7Tx+aSTdJsMxSCf+WME6X65y6fS+SpNlKWhP3
         W3zA==
X-Gm-Message-State: AFuF++k/xZhYzyT+oZc8rCmvHioGxiScO+rVfGATVpdQH3U4rBqzrXXx
	ZjoWNKGUA0UgaF+rOwvQrJdcxw2h2Lih2FFufYX7P2k1gwwbMGN+KqWd2QuQSDaElS7K2OCbWxA
	r4nt2cQIxbQ5uYTEJ9uStlcOD2qPSygY+GZRTabB03A==
X-Gm-Gg: AYBFou3Fg7luB2SbDO0lMzzsZZBrWCy+/Z5bhBbJ2FCohQH76PR+3qtS1MvlPkt6CfA
	kwywIXxlkykFDsySHBVew5OZWDncmE3YHgAo7lUTT8PmKpZRQyR3XpATjGe1ipL4k5nnd/ul4Js
	cDhzoGBe8V1kDjFN/13tD9mAD49dZXoJeIs2VxHtlK3g2LCzOrgh40A2qnm21lZ1WuTGWhXG+mD
	CD6oqRQqsmRrA68OwQsOrPTVTd+cyMYz5FZ2KCsuz6ZJfWCaN7ZtKJ0GUNIarlYXgsTYlo5KLFb
	y0uDXr6YxfPwUIMGJTtLTcs41z1m9NWVSlAt7SbnaIPWc7yw+0wyt/X20ZM2TsuYzrWaEJpyE5/
	sf10=
X-Received: by 2002:a05:690e:2599:b0:66f:c1be:a668 with SMTP id
 956f58d0204a3-66fc1bead79mr3944116d50.90.1788798931178; Mon, 07 Sep 2026
 09:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
 <ap5yVFNEFm2vdP1B@pks.im>
In-Reply-To: <ap5yVFNEFm2vdP1B@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 18:35:20 +0200
X-Gm-Features: AcwNN1WXduIkQXZcBzYRJINXJ2ejTOqh7FHOALId5SxITRR2N6X_x7PSCja52R0
Message-ID: <CAA0xjtqy3jOPWAGL9Cr0B+VnHAkZF0=cVCxKNqMiVJpfbdpomA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is done
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 07/09/2026 10:14, Patrick Steinhardt wrote:
> This paragraph just doesn't parse for me, it's really hard to tell what
> it even wants to say.

Sorry, I'll rewrite it. What I meant: the apply backend runs auto
maintenance from finish_rebase() when it is done. The merge backend,
cherry-pick and revert create their commits in process and never run
it themselves. It only runs when they spawn a command that runs it
anyway: "git commit" for an edited message or a resolved conflict,
"git merge" for an octopus merge or a custom strategy in "rebase -r",
or a git command in an exec. So a clean sequence never runs it, and
one with conflicts runs it after each resolution, in the middle of the
sequence.

> Besides moving stuff around to prep for the next commit, what does this
> change? Like, do we now run the command in cases where we didn't before?
> And if so, what are the consequences of doing so?

Yes. After this patch every sequence that finishes runs it at the end,
like a "git commit" or an apply backend rebase does. The next patch
stops the runs in the middle, so it ends up as one run per sequence.
The case that changes is a sequence with no conflict to resolve and no
message to edit. Such a sequence never ran it at all, so its loose
objects waited for the next commit. It is the same
"git maintenance run --auto --detach" as after a commit, so it runs in
the background and does nothing unless a threshold is met. I'll put
that in the message.

> It's surprisingly many sites where you add the call to
> `run_auto_maintenance()`. My hope was that there is a single exit path
> somewhere that is used by both the "apply" and "merge" strategy that we
> could adapt to unify when exactly we run auto-maintenance across both
> backends.

There is none inside the sequencer. run_specific_rebase() calls
finish_rebase() for the apply backend only,
"merge backend cleans up after itself" as the comment there says.
Sequences end inside pick_commits(), and a single cherry-pick or
revert never creates sequencer state at all and returns straight to
builtin/revert.c. That is where the three sites come from.

I could instead do what the apply backend already does. am.c skips
maintenance in rebasing mode and leaves it to rebase.c. If the
sequencer leaves it to its callers the same way, run_specific_rebase()
runs it for the merge backend too, once its state directory is gone,
and run_sequencer() in builtin/revert.c runs it for cherry-pick and
revert. Every entry into the merge backend returns through
run_specific_rebase(), --continue and --skip included, so nothing is
missed. The sequencer then never runs it, the change is in the two
builtins only, and the rule is short: the command runs it once when it
is done, and nothing it spawns does. Is that what you had in mind?

Thanks,
Thomas
