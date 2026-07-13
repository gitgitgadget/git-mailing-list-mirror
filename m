Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3742421F0D
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948666; cv=none; b=ohxyhn3tQIIMWLPtBfuTfLfgLOCMItndwK4Giq9rrAQbp2rIsXD8iNR4P9KMAeoZXLfd2lLbuoP39WB4FRndQcWsPN6/ajjUh9GL8KmSWzHTolG0SFqyv71fPBxVNZiTs035LbeS5nxKBBdCEKJA2UCnQ70316FiwFhUv7q3HuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948666; c=relaxed/simple;
	bh=7oUf6iM78SOLmHQYmZQ/McZ5Qgy57bp30duAe5riu9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1Kb/W5tgcq+SjpevU42bwvDr+3ShUxlD0Yu6ssuQoL8Xxrr1GF4Lz1fqlHueyfJ4UCRJnPiGqvKjSmJTxETeEMqSBUIvd1Vhmk5Ta5ygm/F9s+EIeySG2YF6fT/6eLCT8uS87FGZ86/rV/7DqsmTibt18H5ArkbmpZ9AfJlKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhdjmMrn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhdjmMrn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b1710405so16479955e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948663; x=1784553463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=agBM/4OBZ1ls7mCIh7kSBVsY68Pi18ZQYxHZqg8Eaq8=;
        b=fhdjmMrnjjli/k5GKgTo7ViERNk5pqRHV2Io79P37rG2NTnGn/3XIXpRsrgXmeC+td
         r8ft+VRnAmIQZ1pu2jNfUV8+iil1FKvHjVi/CwlXKtLtV9MHvSvHlvLEibDypzxnZbzV
         WKtjYvfAOe4R3bIFNPqmxcCKRqwQ4uky6qm6L0ABBnM88/L/vEnuMYcDP6BkI/RBB4Kc
         36q3OObNk+4n44maYhqveoEEJBCPXG+UP1A1msEuhohFD7mE2czQVUTwdNyh0DvSXGdE
         rC01I3um4rtJzXaoBZdIh1Lnze7TY9vY743H8uAUvvHAAVR653qnK7RgHuQ65X1czmQb
         tO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948663; x=1784553463;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agBM/4OBZ1ls7mCIh7kSBVsY68Pi18ZQYxHZqg8Eaq8=;
        b=HoUSEQADWyBcR24duVXTMgL+03wjTP3XVM460Rmj4Irtsj3Tcj8XfI2pSDTvLTrboQ
         MZqBsNOy8kwkVuo0QY5JAlNiwzIgMbAZn3D8B/gsYpMYmfjwZdir97WzUoI07W+nH9E8
         ZxnAR1PMCdP8F4beilzhL7TjYZg2+w1wjUoL2BpKZVgBsbFFIKOBl5dXe585K+arGuqh
         7l7U4roAKJ4Vv7cybGomn9u6OGDamJUlvQTEmCFGn0x4VMjSnOaZ/bfUqOVpll0l6MSQ
         AYCo9NPVnT/66wGsii6fRtmfA0t9ailbTK91bWS5uB2e3Ss4ronA/Nc2riz3yIkcNEe5
         LTiQ==
X-Gm-Message-State: AOJu0YxHdzVU+u3JCf4ZopItpLU9ng3OJ44UhA+6I/ODWnFMqd08WWWg
	u/p7MEHDC2wF41Vp0rJp0nZk1uZEoyRh0Vi+EPLv0VUVwcCmkDyjt6CawU1Hiw==
X-Gm-Gg: AfdE7ckdb1V8oSBnWQyJQSbzi8hhOOuK9BsmAkZ9rCUa38EBnAvzGK1t7PDmzhattmm
	WBBecahBJHbIjyovizkz7viZZTr877e9+xqAQzBpyiMhgUMyWqdpNJucjyFin7ocvW232KMeeJe
	0GvmjbFKtyn7xemted+8/3oSljFRcQx/WuxtxkbC4QacQE4/dtr45pFM4VTLuXrG+lZOxXIYhb7
	BaH5AKdTJ8mn5QvPtdB/jzaqVdSZGih350OpS2Awr5WMt4ZI0mHP9co8ryK0hlSQ69r+9v1KEcw
	jGTte095rWajRmS2aovLH3sZhb6fc42cgiS2x69McEgh5GtIdgpX1B12kswF2GZR50JO/otrpwM
	fxDyfeJ5/ekt8sFBycHR/Y+mpYUKx3a4XAA2YkSnzBemu1MxSGEGZBuNG2SDjJG4khjPszCpd1t
	VOPQmN1gI7bHBAx8J9gpTOfd7sJPQ=
X-Received: by 2002:a05:600c:3143:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-493f87e9f57mr94942035e9.14.1783948662624;
        Mon, 13 Jul 2026 06:17:42 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:41 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 00/10] sequencer: do not record dropped commits as rewritten
Date: Mon, 13 Jul 2026 14:17:17 +0100
Message-ID: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
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

Thanks to everyone who commented on v1. I've squashed the fixups that
Junio had in "seen", squashed patches 8 & 9 together as suggested by
Oswald and expanded the commit message, and added Uwe's Tested-by:
trailer to the final patch. Oswald suggested extended the use of the
enum which I think is a good idea in the long-term but I punted on
that for now because I think it would be fairly invasive and this
series has enough refactoring in it already.

If a commit gets dropped because its changes are already upstream
then we should not record it as rewritten. As well as confusing any
post-rewrite hooks this means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

This series is structured as follows:

Patch 1 restores some test coverage that was lost when the default
rebase backend was changed.

Patch 2 moves a function so it can be called without a forward
declaration in Patch 11.

Patches 3 & 4 fix the return value of do_pick_commit() when an external
command fails (this is in preparation for patch 9).

Patches 5-8 try and simplify the control flow in pick_one_commit()
in preparation for patch 9.

Patch 9 changes the return type of do_pick_commit() to an enum.

Patch 10 adds a new member to the enum from patch 9 for commits that
are dropped when they become empty and uses that to stop them from
being recorded as rewritten.

base-commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-drop-notes-with-commit%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/6c3d7b735...c89234dd9
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-drop-notes-with-commit/v2


Phillip Wood (10):
  t3400: restore coverage for note copying with apply backend
  sequencer: move definition of is_final_fixup()
  sequencer: be more careful with external merge
  sequencer: never reschedule on failed commit
  sequencer: remove unnecessary "or" in pick_one_commit()
  sequencer: simplify handing of fixup with conflicts
  sequencer: remove unnecessary condition in pick_one_commit()
  sequencer: simplify pick_one_commit()
  sequencer: use an enum to represent result of picking a commit
  sequencer: do not record dropped commits as rewritten

 sequencer.c                   | 154 +++++++++++++++++++++++-----------
 t/t3400-rebase.sh             |  16 +++-
 t/t3404-rebase-interactive.sh |  11 +++
 t/t5407-post-rewrite-hook.sh  |  23 +++++
 4 files changed, 155 insertions(+), 49 deletions(-)

Range-diff against v1:
 1:  65af2ac07a2 =  1:  65af2ac07a2 t3400: restore coverage for note copying with apply backend
 2:  02670f57e7d =  2:  02670f57e7d sequencer: move definition of is_final_fixup()
 3:  16fba1e823b !  3:  3d79362332c sequencer: be more careful with external merge
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     +					opts->xopts.nr, opts->xopts.v,
      					common, oid_to_hex(&head), remotes);
     +		/*
    -+		 * If the there were conflicts, try_merge_command() returns 1,
    ++		 * If there were conflicts, try_merge_command() returns 1,
     +		 * any other no-zero return code means that either the merge
     +		 * command could not be run, or it failed to merge.
     +		 */
 4:  3ffd06d6509 !  4:  fc89e77c6e8 sequencer: never reschedule on failed commit
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
      			*check_todo = 1;
      		}
     +		/*
    -+		 * If "git commit" failed to run than res == -1 but we dont
    ++		 * If "git commit" failed to run then res == -1, but we don't
     +		 * want reschedule the last command because the picking the
     +		 * commit was successful.
     +		 */
 5:  cb286ac70d7 !  5:  26eef6c0958 sequencer: remove unnecessary "or" in pick_one_commit()
    @@ Commit message
     
         If error_with_patch(..., res, ...) succeeds then it returns "res", if
         it fails then it returns -1. This means that or-ing the return value
    -    with "res" is pointless the result is the same as the return value.
    +    with "res" is pointless as the result is the same as the return value.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
 6:  1585d47e2ea =  6:  26dc48951ce sequencer: simplify handing of fixup with conflicts
 7:  4386ca67d10 =  7:  71ed717d322 sequencer: remove unnecessary condition in pick_one_commit()
 8:  f51751fa3ec !  8:  e8b7fa4c59e sequencer: simplify pick_one_commit()
    @@ Commit message
         sequencer: simplify pick_one_commit()
     
         Unless we're rebasing all we do in pick_one_commit() is call
    -    do_pick_commit() and return its result. Simplify the code by returing
    +    do_pick_commit() and return its result. Simplify the code by returning
         early if we're not rebasing so that we don't have to continually call
         is_rebase_i() in the rest of the function. Note that there are a couple
         of conditions that do not call is_rebase_i() but they check for either
         an "edit" or a "fixup" command, both of which imply we're rebasing.
    +
    +    The only block that does not return early is the one guarded by
    +    "!res". Move the return into that block to make it clear that after
    +    recording the commit as rewritten all we do is return from the function.
     
         As the conditional blocks are all mutually exclusive (either the
         conditions are mutually exclusive, or an earlier conditional block
         that would match a later one contains a "return" statement) chain
         them together with "else if" to make that clear.
    +
    +    While we could remove "res" from the conditions below "if (!res)"
    +    they are left alone because, when we start using an enum in the next
    +    commit, it makes it clear that these clauses are handling cases where
    +    there are conflicts.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ sequencer.c: static int pick_one_commit(struct repository *r,
      		record_in_rewritten(&item->commit->object.oid,
      				    peek_command(todo_list, 1));
     -	if (res && is_fixup(item->command)) {
    ++		return 0;
     +	} else if (res && is_fixup(item->command)) {
      		return error_failed_squash(r, item->commit, opts,
      					   item->arg_len, arg);
    @@ sequencer.c: static int pick_one_commit(struct repository *r,
      		int to_amend = 0;
      		struct object_id oid;
      
    +@@ sequencer.c: static int pick_one_commit(struct repository *r,
    + 		return error_with_patch(r, item->commit, arg, item->arg_len,
    + 					opts, res, to_amend);
    + 	}
    +-	return res;
    ++
    ++	BUG("Unhandled return value from do_pick_commit()");
    + }
    + 
    + static int pick_commits(struct repository *r,
 9:  2541a4d6e3d <  -:  ----------- sequencer: return early from pick_one_commit() on success
10:  e4050ead27f =  9:  4fb641afb3c sequencer: use an enum to represent result of picking a commit
11:  26551f2687b ! 10:  c89234dd949 sequencer: do not record dropped commits as rewritten
    @@ Commit message
         when rewording a fast-forwarded commit.
     
         Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
    +    Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## sequencer.c ##
-- 
2.54.0.200.gfd8d68259e3

