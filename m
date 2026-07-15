Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0240EBA9
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128943; cv=none; b=s1+EVbDeRbfrG0QYKaUw5oiQaLqgowr//dJLFwDrB4H1vdtnZPPKKQcX1PHwqF+zVXtHjnsPW5PpWmc/PSHTRT+W38dL2hgo/0CpH6NZpV7UN45+AjP75CYgbVG1rwqIj6KyBi4+T1xzmolIKOAnfy5acd7wLAb2FMJLW5OlN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128943; c=relaxed/simple;
	bh=i3qiD6rrl6og6oD+FcosH85iQMHnTGwqEsSS7xBP0n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOo8hEetwPg6ag3x5VXxup1Ae5qLcnvrPhEjrOxjYBXvBERWjMjXGUsiDGssHebrs4wUricd2kujpSpIb2GWNA3hEz31wU/U3nGeRCETg8ZWCOUkMdgltHmpMRbfQXtZrIJyrYekEQWiCPnOqBbjzKpNb2kiJwG99ko2KZFzva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEguyzgb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEguyzgb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso39493265e9.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128938; x=1784733738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Fik1m3r9Vvcg6G2qw7ZfiZ/c1fPsJX0+LfqM2Fnh/48=;
        b=iEguyzgbcEtfqHSZyVUeZXA5Cj4A/eIoF71rWQfTVjBhHSenJKexqqfMfYCvX0DTnT
         9B3FTY1D1FXaf0IASzrE8n8PsPEiMX3248/+ND9jhwzdjvmYRH8XCYkOXW+4L5AZXck6
         IopESSTtOCFy9YrCX4LuMWbS/Pd8Ukr4WrLQwPb9dTu0AjZsoMQ1muznZ1pkoxsErSme
         TBjhrMIZKVvdyQYPOBcSbswDgXnfeqDfcaUc+s5dq5x0fGZLCsL5ogpL89MJ6Uy8J7TP
         HsKWlZPNeTrjdV/05Ty6gOvdOTCnFNxI3vEiclNjPuZP9w0cv7YH0Xr3h3cWq31NgXcD
         e2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128938; x=1784733738;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fik1m3r9Vvcg6G2qw7ZfiZ/c1fPsJX0+LfqM2Fnh/48=;
        b=tXPhHWb/ppBqtIOLFwFR5YBzyD+UMHD+hus4fv3+1F90rpoNvJsEOerxkh23fxpOq5
         NKhUvZNbmbJiY/UWWF8o03orQRmElBh7QM45PU70WWtvlfY5HuP17kYkLQOm7iToxH4L
         +uSoKhdfY5g9WUqp5xX8sJQz5ivVJo9Nw8UCIpFGp5wqClpFZ2VEEui5CJweaimw6AQf
         qrBcKldm/My0nu41dWeZCZZ5Rt6spcmPIvEy7zbxrmL5DFUuMPY7EARA92pXrgsxpc33
         qW5Mzh4Tb3P9OsHBM+/2Fd5WQ3zHNX0O7+d9BYMjI3e8Oq2Vq7GRqhyGeDy22EB87KMY
         2ynw==
X-Gm-Message-State: AOJu0YyKD3rBroj4Sd2AGYDlY7y8NWM1TIKe2GXjSaUSUbe70ER42Bip
	JW8FpGZT9xLNls59Y+xYqFD81UOHPmwW1SCoKCS6oYQh+kD0XW9qDEE342HK6w==
X-Gm-Gg: AfdE7cmd55WAnW1iNmVtTYytGfXsTZgtkDT60ROOX72HRdOlRDdTrpWTyvXYLPOwvIL
	CG/Ktxpe+Wtm87p6JHqVbQuBl6htC8+bIbtBzn4pTihfDNa4LXOeLUS/2IoQrR4KcwZUJQNubvZ
	N5HdEnbRPmMh6nW984wuwti0UoUJGXwfUCbHgRMQIsBm9nl+I4uh+D7pZlm7PMizv+K63augqam
	nhWjnxXDBp1E4TBOrkdgjDgDyXQmsKT2yWBqKf2M2nAk15oZU6pflizJaKTDa3nAILdudRRYx3d
	urZJYtc0UWRvn9M9Aic+926vGUItYR56Js8+XhqA/yNA+o4lhiSeG3Z70f01NjE+shhL4m91pme
	JpjQJR6GP8vwI6egNZHIwDREEU6DAzZK4nYrUuzBC8ueYp8YXOxQ5NOR8CtDr8Cmw4tH66vdZPe
	XOfGSBAzXhmmGzBTmY
X-Received: by 2002:a05:600c:c8f:b0:493:ee2d:d221 with SMTP id 5b1f17b1804b1-4951830e408mr95880365e9.31.1784128937829;
        Wed, 15 Jul 2026 08:22:17 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:17 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/9] sequencer: do not record dropped commits as rewritten
Date: Wed, 15 Jul 2026 16:21:54 +0100
Message-ID: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks to everyone who commented on v2. I've dropped patch 2 which
Andrei pointed out was pointless and tried to make the remaining
commit messages clearer as requested by Oswald.

If a commit gets dropped because its changes are already upstream
then we should not record it as rewritten. As well as confusing any
post-rewrite hooks this means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

This series is structured as follows:

Patch 1 restores some test coverage that was lost when the default
rebase backend was changed.

Patches 2 & 3 fix the return value of do_pick_commit() when an external
command fails (this is in preparation for patch 8).

Patches 4-7 try and simplify the control flow in pick_one_commit()
in preparation for patch 8.

Patch 8 changes the return type of do_pick_commit() to an enum.

Patch 9 adds a new member to the enum from patch 8 for commits that
are dropped when they become empty and uses that to stop them from
being recorded as rewritten.

Cover letter for v2:

Thanks to everyone who commented on v1. I've squashed the fixups that
Junio had in "seen", squashed patches 8 & 9 together as suggested by
Oswald and expanded the commit message, and added Uwe's Tested-by:
trailer to the final patch. Oswald suggested extended the use of the
enum which I think is a good idea in the long-term but I punted on
that for now because I think it would be fairly invasive and this
series has enough refactoring in it already.

base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-drop-notes-with-commit%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/6c3d7b735...2ef36b9ee
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-drop-notes-with-commit/v3


Phillip Wood (9):
  t3400: restore coverage for note copying with apply backend
  sequencer: be more careful with external merge
  sequencer: never reschedule on failed commit
  sequencer: remove unnecessary "or" in pick_one_commit()
  sequencer: simplify handling of fixup with conflicts
  sequencer: remove unnecessary condition in pick_one_commit()
  sequencer: simplify pick_one_commit()
  sequencer: use an enum to represent result of picking a commit
  sequencer: do not record dropped commits as rewritten

 sequencer.c                   | 124 +++++++++++++++++++++++++---------
 t/t3400-rebase.sh             |  16 ++++-
 t/t3404-rebase-interactive.sh |  11 +++
 t/t5407-post-rewrite-hook.sh  |  23 +++++++
 4 files changed, 140 insertions(+), 34 deletions(-)

Range-diff against v2:
 1:  65af2ac07a2 !  1:  c4705066ee0 t3400: restore coverage for note copying with apply backend
    @@ Metadata
      ## Commit message ##
         t3400: restore coverage for note copying with apply backend
     
    -    Now that the merge backend is the default we have lost coverage for
    +    Now that the merge backend is the default, we have lost coverage for
         "git rebase --apply" copying notes. Fix this by replacing "-m" with
         "--apply" as the previous test which uses the default backend now
         checks the merge backend.
 2:  02670f57e7d <  -:  ----------- sequencer: move definition of is_final_fixup()
 3:  3d79362332c !  2:  947bb77e44f sequencer: be more careful with external merge
    @@ Commit message
     
         If an external merge strategy cannot merge (for example because it
         would overwrite an untracked file) it exits with a non-zero exit
    -    code other than 1. This should be treated differently to a merge
    -    with conflicts which is signalled by an exit code of 1 because as
    -    the merge failed we need to reschedule the last pick. The caller
    +    code other than 1. This should be treated differently from a merge
    +    with conflicts, which is signaled by an exit code of 1, because, as
    +    the merge failed, we need to reschedule the last pick. The caller
         expects us to return -1 in this case. Also reschedule without trying
         to merge if the commit message cannot be written as that prevents us
         from successfully picking the commit.
 4:  fc89e77c6e8 =  3:  bff5f319e91 sequencer: never reschedule on failed commit
 5:  26eef6c0958 =  4:  e785433ad3d sequencer: remove unnecessary "or" in pick_one_commit()
 6:  26dc48951ce !  5:  134d8f7e935 sequencer: simplify handing of fixup with conflicts
    @@ Metadata
     Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Commit message ##
    -    sequencer: simplify handing of fixup with conflicts
    +    sequencer: simplify handling of fixup with conflicts
     
         Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
    -    2023-09-06) introduced an early return when res == -1, so if we enter
    -    this conditional block then res is positive. After the last couple
    -    of commits the only possible positive value is 1 so we can simplify
    -    the code by removing the conditional call to intend_to_amend() and
    -    call it error_with_patch() instead.
    +    2023-09-06) introduced an early return when res == -1, so if
    +    we enter this conditional block then res is positive. After the
    +    last couple of commits the only possible positive value is 1. That
    +    means we can simplify the code by removing the conditional call to
    +    intend_to_amend() and have error_failed_squash() request that it is
    +    called in error_with_patch() instead.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
 7:  71ed717d322 =  6:  e3091dee633 sequencer: remove unnecessary condition in pick_one_commit()
 8:  e8b7fa4c59e !  7:  7c1642b0a49 sequencer: simplify pick_one_commit()
    @@ Metadata
      ## Commit message ##
         sequencer: simplify pick_one_commit()
     
    -    Unless we're rebasing all we do in pick_one_commit() is call
    +    Unless we're rebasing, all we do in pick_one_commit() is call
         do_pick_commit() and return its result. Simplify the code by returning
    -    early if we're not rebasing so that we don't have to continually call
    +    early if we're not rebasing so that we don't have to repeatedly call
         is_rebase_i() in the rest of the function. Note that there are a couple
         of conditions that do not call is_rebase_i() but they check for either
         an "edit" or a "fixup" command, both of which imply we're rebasing.
     
         The only block that does not return early is the one guarded by
         "!res". Move the return into that block to make it clear that after
    -    recording the commit as rewritten all we do is return from the function.
    +    recording the commit as rewritten, all we do is return from the
    +    function.
     
         As the conditional blocks are all mutually exclusive (either the
         conditions are mutually exclusive, or an earlier conditional block
 9:  4fb641afb3c !  8:  0a146d57266 sequencer: use an enum to represent result of picking a commit
    @@ Metadata
      ## Commit message ##
         sequencer: use an enum to represent result of picking a commit
     
    -    Rather than using an integer where -1 is an error, 0 is success and
    -    1 means there were conflicts use an enum. This is clearer and lets
    +    Rather than using an integer where -1 is an error, 0 is success and 1
    +    indicates there were conflicts, use an enum. This is clearer and lets
         us add a separate return value for commits that are dropped because
         they become empty in the next commit.
     
10:  c89234dd949 !  9:  2ef36b9ee5a sequencer: do not record dropped commits as rewritten
    @@ Commit message
     
         If a commit gets dropped because its changes are already upstream
         then we should not record it as rewritten. As well as confusing any
    -    post-rewrite hooks this means we end up copying the notes from the
    +    post-rewrite hooks, it means we end up copying the notes from the
         dropped commit to the commit that was picked immediately before the
         one that was dropped.
     
    -    While we do not want to record the dropped commit is rewritten, if
    +    While we do not want to record the dropped commit as rewritten, if
         it is the final commit in a chain of fixups then we need to flush
         the list of rewritten commits. The behavior of an "edit" command
         where the commit is dropped is changed so that "rebase --continue"
-- 
2.54.0.200.gfd8d68259e3

