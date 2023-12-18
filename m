Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495F45C0C
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdzy3Ri4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534d8fcf7bso942388a12.3
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702901456; x=1703506256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abthQgDd4iU05Du8yHO2csZBwBMzKkDE8T0f7WK2+Lk=;
        b=Bdzy3Ri49AgtS92HWXjtwUbvTvSKlhHe26oozxEoHA34/tZQfazjGOvY3kyU/ISJ90
         lLyX9/+WHsauiZdkTPu1SlQeDKrgKZj3FEUufwB729uG9YmaEMY11kpM1Q7BBETZeHwm
         DrZ5wmRkjYb0FvRaznb35iArfzb2faw8QLprrj4TaPAVCLW8whIrCX4YLcQXvuPSiUfp
         kPJYo1pz+IvNdp4vpfeIe+/UnnKEIi8QS6hFaRj8WU6LwO5wK1dsXO/c2TNgqINCgT+S
         CUmKBRPrMr4RNYPWWkDYFiwWtcMffrdWsLcCMx5qDnPkpuv1RjhadCyVAh+RWoYNLsmT
         ZgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901456; x=1703506256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abthQgDd4iU05Du8yHO2csZBwBMzKkDE8T0f7WK2+Lk=;
        b=N+9hE0sHKz6yabmari07+guSWP5kjko1Cg4k/+uIC2ugoBoWybvzdSfuhTqzWqIyT8
         6G3n1qbmTfQFm7Zq9Heo2JZgRZi7NfyKGJnIp0DOfc345HX3TMZGG+4EcDHdxD4HaKtd
         7EfGKyxhf/srrufUjxGD2+mOFoncsNxIIF1F8pi/8TOQ7RFPObKMLQCMSvHe8friEf4y
         vOrplZHnI89LoeDIAe8dYz9qwD+7JpQifFtBvHWl/3LjqIwJznSiOAF08LzBlOoMwLkY
         vC9U2NAuGngoS3/4adx8W/vHsV93G/OpG65vG2BSej2JHYD5nqJBzKdkV77xyZ0Mquzy
         CUXg==
X-Gm-Message-State: AOJu0Yy6qesxiRhVeeKHyG8GEBiXKpv74AoER0jmfo9831N/iVR4kgKE
	7sX2c1bx/BpzBlCNHWfZLNR6Y8GN7jNmmA==
X-Google-Smtp-Source: AGHT+IGGy0t5YmPnuZdLnkJ6D2nMq4A2k1pEt5JexDjm01wPoSoyhkXWMSOTtrFboX9/4sWcLyKEBQ==
X-Received: by 2002:a05:6402:c89:b0:54c:4837:81f5 with SMTP id cm9-20020a0564020c8900b0054c483781f5mr7940475edb.70.1702901455618;
        Mon, 18 Dec 2023 04:10:55 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id f21-20020a50ee95000000b00553346e2cfcsm1444971edr.55.2023.12.18.04.10.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 04:10:55 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/1] revert/cherry-pick: add --show-current-patch option
Date: Mon, 18 Dec 2023 13:10:47 +0100
Message-Id: <20231218121048.68290-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
I am a lead developer of a small team and quite often I have to
cherry-pick commits (and sometimes also revert them). When
cherry-picking multiple commits at once and there is a merge conflict it
sometimes can be hard to understand what the current patch is trying to
do in order to resolve the conflict properly. With `rebase` there is
`--show-current-patch` and since that is quite helpful I would suggest
to also add this flag also to `cherry-pick` and `revert`.

Since this is my first contribution to git I am not exactly sure where
the best place for this functionality is. From my initial understanding
there are two places where to put the actual invocation of the `show`:
- Duplicate the code (with the needed adaptations) of builtin/rebase.c
  in builtin/revert.c
- Create a central function that shows the respective `*_HEAD` depending
  on the current `action`.

In this first draft I went with the second option, since I felt that it
reduces code duplication and the sequencer already has the action enum
with exactly those three cases. On the other hand I don’t really have a
good understanding of the role that this `sequencer` should play and if
this adds additional coupling that is unwanted. My current impression
is, that this would be the right place, since this looks to be the core
of the commands where a user can apply a sequence of commits and in my
opinion even if additional actions would be added, they could also fail
and so it would be good to add the `--show-current-patch` option to that
one as well.

Side note: my only C(++) experience was ~10 years ago and only for a
single university course, so my perspective is much more from a general
architecture point of view than based on any C experience, let alone in
this code base and so I would be very grateful for criticism!


Side note: The check for the `REBASE_HEAD` would not be necessary, since
that is already taken care of in the builtin/rebase.c before.
Nevertheless I opted for this check, because I would much rather require
the same preconditions no matter from where I call this function. The
whole argument parsing / option struct are very different between rebase
and revert. Maybe it would make sense to align them a bit further?
Initial observations: `rebase_options->type` is functionally similar to
`replay_opts->action` (as in "what general action am I performing? -
interactive rebase / cherry-pick / revert / ...") whereas
`rebase_options->action` is not part of the `replay_opts` struct at all.
Instead the role is taken over in builtin/revert.c by `int cmd = 0;`.
I am preparing a patch converting this to an enum, so that there are
no random chars that have to be kept in sync manually in different
places, or is that a design decision?

I looked through the mailing list archive and did not find anything
related on this topic. The only slightly related thread I could find was
in [1] by Elijah Newren and that one was talking about a separate
possible feature and how to get certain information if CHERRY_PICK_HEAD
and REVERT_HEAD were to be replaced by a different construct. I hope I
did not miss something...

Cheers
Michael

[1]:
https://lore.kernel.org/git/CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com

Michael Lohmann (1):
  revert/cherry-pick: add --show-current-patch option

 Documentation/git-cherry-pick.txt      |  2 +-
 Documentation/git-revert.txt           |  2 +-
 Documentation/sequencer.txt            |  5 +++++
 builtin/rebase.c                       |  7 ++----
 builtin/revert.c                       |  9 ++++++--
 contrib/completion/git-completion.bash |  2 +-
 sequencer.c                            | 24 +++++++++++++++++++++
 sequencer.h                            |  2 ++
 t/t3507-cherry-pick-conflict.sh        | 30 ++++++++++++++++++++++++++
 9 files changed, 73 insertions(+), 10 deletions(-)

-- 
2.43.0.77.gff6ea8bb74

