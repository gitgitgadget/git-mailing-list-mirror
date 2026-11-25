Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577029;
	b=GoMAaJJEG9CH8B8YafpzaR27HXz9JPPF0R3ZVz0AQt1CjTJvU2yGDsa/m7F9hoOZHa2z
	 82fINZ8yGwbtS8cbYAE1SlnAAawFit5aYuWA3apK9ggPrkBK3cJJ9vce8QsZRiFpwxfIe
	 Ny3MXiJYoVIexL4hBU7YcjzbAEg2ako1swZCnGd3pE7qho7h38bUfuGea/2Z2Ch1ftsba
	 YvMBH05Mot/mOalU9krsLnaeImfM28IhUfRXUaqrXwaNHz09beCvkYlttHhiqm2Apc3Ht
	 Ws+NB9dx1YIYanqqucqyqQNXGmROgj/r5lR1F5RHefwaQGXKVD0AwhaDUFWhIxusK6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=D0irM1jDEKoqXJ7iTc3RqnPIf1biX34tOpuMQarI2LM=;
	b=g6Beh3wKwXl0WTpn5iQYws3Uox6Vj/Xd9230v9e30NMQuptNc50nIMOOBZ+m0uLtq9wF
	 ltiYvsSNwJjNUOvLqZfLPfRgL9CfBT2tpmHKOTSbmcarPl8Mz1PGbQfPVbtwjIYFlUMKd
	 6Cm3Y9p4HTJ0j7153GMxIGc8F4UFxQ2eGxSotjxTkEijz8+QHXuShTXnbhgWj9DmDbMQ1
	 rsn4srEipqrZuCqrF85hv139h2O0XphXSTz+dN0UqwzaGRRifNesTNDHkTBZ3j2tEe5aA
	 pV3tZqTk0CMwVZLI5a+CKNXbbOd4MzmShzXpeLUtsCmzyASyH5JBIPqh+34GeIZFtUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfejGnKO;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C3606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 03:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfejGnKO
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad1db7e31so4080036eaf.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577028; x=1796181828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D0irM1jDEKoqXJ7iTc3RqnPIf1biX34tOpuMQarI2LM=;
        b=DfejGnKOVuExPjipj45NzaF8MzpO9Kia/UA8hTcU7Drz0zzjPRFOF1wo8+eUg5ixuw
         ykWcTTsSHiSKeyakyTxZFHIVeep9rbNEeckolFxRCUYclrgRlatinPlN6MZSG4jdE4fH
         PaV690AnvwjcnbqyIpPjn52Dd4lKer2kVDCRdrbtnMmuc8sOqwToZEdpHy1P1l/HxGAx
         qedTOJCPflL1Z/H/Py4uOqFQsD2ghpiwx5xaYwgj9tX6i8xNeVjeccUSLlPbyzNMe15s
         ATg3AwXk5ZpLKLORe1jspkuZ+d9RGtCWoJ2858lHNlvOk4rZ8af89qgATN0GQFG8ibxh
         hhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577028; x=1796181828;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0irM1jDEKoqXJ7iTc3RqnPIf1biX34tOpuMQarI2LM=;
        b=tuhQbcF+jfVT5IDaiocBd9yy0hjQztn8CLipKFTqygVh+r8lmJALIfvS75KII8xXpm
         rXSSUzC8xOsYYfAmxN/7GDhbTmGJRxFjpzLfX4ea1TNBjrJuAUeyKkeeTufgmLWUntQM
         RDV6Pl1yx3u6fbqg9097XhpcBjokQxgxlroi3pDazOW1bLV5b3tqprfv2TXGRoYgJNwy
         kJAWzg+25eVOE8twhAJbFkBY4m+CYb+JQlBSeGyPFGu1fraiPpQjdIilmjweM1VQ/LQG
         jSpoaWmiYv2bCb1fI/7cqOL6WB6P7NfjCWqqzTcNJX9yrIw3dNLdutCJUvfpReUWSWqJ
         /hPg==
X-Gm-Message-State: APuU4Z/6GYMc1XdziWrPwfEcb9I28ABGrG3ga08/ms2dkP9PhonmLXpe
	LKJ3xYGuAB/cKBfN4o3h3k+zWZLdJFK6qg5Aq/xxEVhAcNnvsSZDqoR/3DY6+w==
X-Gm-Gg: AZFdTZeZKuL5+vETnAEN1D6aYeVfLZIk5/U/GQQ0/VPnC3rWhBHE2uoEMPBcF/VNDKp
	mZ8qgS53Qjb5PESs2L5ckrMKMAZOuOt8lG8c/1T/FCGC77OCIbpBi4iiD4fj2EwHdEUYI6OW3x4
	4P2mNk3diRvEMlaFk8qH570yfVoh6nGjSnqSq9e/PfwbpJWd23RHUa+XTJZ0aePWl2qJnyeIkPr
	7fyn/gZsQaK/ZnXupVHM9dNL9SSLeTHr/rfDqmPtqhS+UDgPvsVacIse3CAkt98/ZBL11XlVO0L
	SW/FjLM+yVnxrMCjKfRxmCutTB5RFC007Vrhb2c1SNAAj3XbQd1n6XPwpePBoRv0EV0Jln4XU3M
	0eDVEJs76Hxi5Ds/lid8T4v+GlsNN+w4QM0DKlkIN2BkpqNW9oRJSAZ1kUG2DtB5wCnG+YuByqu
	L7P1wIJMKj7yxA7COiwerJi2kUlzAuN4e0FZpg2RM1rA8XE8R2wEEo+oX0WQ3v2Ce11kw0SNeu1
	K+EUyYSs26UxZNHE5+lBtygmYoTvDUOuV+i1K+Gu1ORPDhgxbbExWy3tXTNyhELy6xMCwgE1Srl
	MiqHizoMBBFb99UaFrfqU00ZrjoxpyN+MCV78LMotfUuTW7DdDOCp74=
X-Received: by 2002:a05:6820:1517:b0:715:205e:4b72 with SMTP id 006d021491bc7-71b3956e487mr11145574eaf.24.1795577027652;
        Tue, 24 Nov 2026 19:23:47 -0800 (PST)
Received: from [127.0.0.1] ([172.169.255.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c51sm10787770eaf.3.2026.11.24.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:23:46 -0800 (PST)
Message-Id: <pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 03:23:42 +0000
Subject: [PATCH v2 0/2] sequencer: save the null OID for an unborn branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Wonseok Oh <wonseok_oh@korea.ac.kr>

When "git cherry-pick" picks multiple commits onto an unborn branch, it
saves an uninitialized object ID in .git/sequencer/head, so "--abort"
behaves unpredictably. Patch 1 saves the null OID there. Patch 2 makes
.git/sequencer/abort-safety hold the null OID for an unborn branch as well,
instead of leaving it empty, as Phillip suggested.

Changes since v1:

 * Reworded patch 1's commit message, as Phillip and Junio suggested.
 * Reworked patch 1's test, as Junio suggested. The first pick now succeeds,
   so HEAD is born before the sequence stops, as described in the commit
   message. The test checks both error messages and verifies that
   .git/sequencer/head holds $ZERO_OID. It can still pass by luck if the
   stack happens to be zeroed.
 * Added patch 2, as Phillip suggested.

Wonseok Oh (2):
  sequencer: clear saved HEAD OID when picking onto an unborn branch
  sequencer: save the null OID in abort-safety on an unborn branch

 sequencer.c                     | 16 +++++++++-------
 t/t3510-cherry-pick-sequence.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)


base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2317%2Fmarinelay%2Fcherry-pick-unborn-abort-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2317/marinelay/cherry-pick-unborn-abort-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2317

Range-diff vs v1:

 1:  7933c657b6 ! 1:  7c0fe312f1 sequencer: reset saved HEAD OID when picking onto an unborn branch
     @@ Metadata
      Author: Wonseok Oh <marinelay7@gmail.com>
      
       ## Commit message ##
     -    sequencer: reset saved HEAD OID when picking onto an unborn branch
     +    sequencer: clear saved HEAD OID when picking onto an unborn branch
      
     -    When picking multiple commits, "git cherry-pick" stores the current HEAD
     -    in .git/sequencer/head for "--abort" to return to. If the branch is
     -    unborn, repo_get_oid() fails and leaves the object ID uninitialized,
     -    but sequencer_pick_revisions() saves it anyway instead of clearing it
     -    to the null OID that sequencer_rollback() checks for to report
     +    When picking multiple commits, "git cherry-pick" saves the current HEAD
     +    in .git/sequencer/head so "--abort" can return to it. An unborn branch
     +    has no commit to return to, so cherry-pick is expected to save the null
     +    OID instead. Only then can sequencer_rollback() refuse "--abort" with
          "cannot abort from a branch yet to be born".
      
     -    As a result, "--abort" errors out with "Could not parse object" in my
     -    master build, while in Debian's 2.47.3 build the uninitialized memory
     -    happened to hold the last picked commit's OID and moved the new branch
     -    there.
     +    However, sequencer_pick_revisions() does not handle this case. On an
     +    unborn branch, repo_get_oid() fails to resolve HEAD, and the function
     +    saves the uninitialized 'oid' to .git/sequencer/head. As a result,
     +    "--abort" is not guaranteed to refuse the abort as intended (e.g., the
     +    saved 'oid' may point to a random commit, and "--abort" then moves the
     +    branch there).
      
     -    Clear the object ID to the null OID when HEAD cannot be resolved, and
     -    add a test.
     +    This bug was introduced in 0f974e2124 (cherry-pick: allow to pick to
     +    unborn branches, 2016-06-06). Before that, picking onto an unborn
     +    branch was refused.
     +
     +    Clear 'oid' with oidclr() when HEAD cannot be resolved, so that the
     +    null OID is saved.
      
          Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
      
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'allow skipping commit but
       	test_cmp expect advice
       '
       
     -+test_expect_success 'cannot abort a cherry-pick sequence on a new history' '
     ++test_expect_success 'cannot abort a cherry-pick sequence started on an unborn branch' '
      +	pristine_detach initial &&
      +	git checkout --orphan new_disconnected_seq &&
      +	git reset --hard &&
     -+	test_must_fail git cherry-pick base..anotherpick &&
     -+	test_must_fail git cherry-pick --abort 2>advice &&
     -+	test_grep "cannot abort from a branch yet to be born" advice &&
     -+	test_must_fail git rev-parse --verify HEAD
     ++	test_must_fail git cherry-pick initial picked 2>err &&
     ++	test_grep "could not apply .* picked" err &&
     ++	echo $ZERO_OID >expect &&
     ++	test_cmp expect .git/sequencer/head &&
     ++	git rev-parse HEAD >expect &&
     ++	test_must_fail git cherry-pick --abort 2>err &&
     ++	test_grep "cannot abort from a branch yet to be born" err &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
 -:  ---------- > 2:  14e015ba24 sequencer: save the null OID in abort-safety on an unborn branch

-- 
gitgitgadget
