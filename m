Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB451CF6E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803556; cv=none; b=Y+AUtfXC38B3S0A5hCrsBTnBhRyzrb1dtnF2ZbuAyspmOpiXAh1wT79I2oOmdqrMG0LGAoLL5OriE/xizC2mnaqlCzo/PIzHZ3Yh8zNKva/iSo9c0BWNkZx6bAQKp+R9P2aWGGF0iNZtPrlDWMSRFj4bkKddf8r9IaxiZFm9TQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803556; c=relaxed/simple;
	bh=feTYDsYUQ1sfjhUoX/ylSyfon+uhYSoKIeSDUw6Qd0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0IOTuSg15KDXVeoNmZDF+74KOyBKfeTjsqS7eEkyzIbFjSOl4RcYwHIx2FcokTMpjEpjtx55p2CjrUdvk1hiPUKPy9qtRP9DswjFFuu1ZefIfikO/A1eIB9fBbiQN5/VbWoa1HadJL7G3gfBtyvcXB99RfNwfMLLWg9x7T83pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USA+qbJV; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USA+qbJV"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-66f7a9afe43so5068135d50.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803549; x=1791408349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=obKHHYubacTh/udeRAk3lxB8+Ora4TVepZCYd0s9K2I=;
        b=USA+qbJVKjnTIY8azs7QL+zyqeCN8CQkhrBtfMDwo+xEBf/b+dDhYuJ/vz9NWtABlT
         HPtMjBayPMpZ8WW4Zq05LpH5DNH5W3bm2lF1HOkDlyktAMYtjZ9oGS2pjNXkvHbJhaQl
         HAlOZ4+KSEzOlZw3i6lySQ1x9pyfZJ5wwjC51U1ux9Ro/+0N0ZW1zA9+TOlAtE8bkC+i
         ANZCn2vye3C54EpxcN2N/FC5zw64Vlf1MeLhS0/veV07Lpk424cI1FjZKcC/ag1L5RF0
         oB4CTK6LNRcq3AHbfYkaEUOYi8B3e3VfqQ+2FdCopMtcSFrqI91mEJIfAVFTi6g4DKgE
         jjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803549; x=1791408349;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=obKHHYubacTh/udeRAk3lxB8+Ora4TVepZCYd0s9K2I=;
        b=Y/P1NN3ZZizyOoXuhz4MNK62hrdUinDBhY5NB1hNVn8ypQMY/lCsWtiWx3kohSkvQj
         TYvL5WMbZLgx7GQvVwb9T5GGYBLEpmn4ZGFL0hitCTjlIKFkHDI67zvDXFX+Jk317+oF
         fknAxWWPtZdWKv/X03Zlpel5LUqIJSal+LC9pdB8Qmj1Jeg+VPdtEWQQwz3NulZPS7+O
         J+nXFKul0miRMWLR+zVU/nVy2velXxzuYo/Sca9E8RcoCuJaoqxYM0HGBB4FmpG4+3+D
         KQkLCrIWLE055Quppbx+i7vavt+dastcw1BzvC6L866W3tGlz56RqBUVEMxFBIFb49NT
         3WNQ==
X-Gm-Message-State: AFq9FYIvV0TAJXXgoe/9SynX8VzERhdnY+cqOap665e8WocSM0y5RJKa
	zN6gyE9gcLeGAgUHdpQrt3ab2hxS6S/fTSfMOg5J6m/dWyM70r8mS6rHJq/qfbHs
X-Gm-Gg: AYBFou0Xel2os4EuiWsxVxZPfDQU8yKtk47XeTdZbzmTopTJaaEkwDCZOP3wdcv27HI
	PfyLZtdYDzS9sMBPfH02rWWsCveU/mSnSrcHxdqJNj+XkDqI5HvjqzBz0Tncsl0NaSEKhF8gGWe
	CTSkAjGy3Q3dXwyTQmxmQNHFHXkYqfOTtLVLDAx3ioWRMN/586hqiW66zDxEvYd7BUnsrV1Fzc6
	35J6+rQk+vZ8W7H7kkF2pLZ+VAX2GF9mtQmfJoFlqSA0l99bOTWZAPCR6YOAEqSWo4bPyAZYfcH
	yoyc/Jb5HtHXY9wQ3UDNwY3WTUafZuW0zFmCB6Eo1UadQogRTOxz+ygCnpywPUl+7tfKu8Z3SP2
	0lSDn0pGHPWUwY/3Pt4x9982D/58v5i0175z2mGSekuC0mw8famYEBBxr1uhC0waqfRT7PwDqeG
	sXeUD2Ia0KBck1NeaUBl2KqnorE1Aw/R6bo1KGXlfdMM8Dij2KIj8S5AehkxvNN/AYR2xtXTCOu
	PmOg06hvSbezff1b86on/5SYUljh+LP1lfYPLxhdLiNRSOAJB3Nu7gt8zbHy0Ep35FJGeCbWAfE
	MGwZJFrYzfJvQfNuk6Xr7g==
X-Received: by 2002:a05:690e:1908:b0:66f:c1bc:c098 with SMTP id 956f58d0204a3-6768360b57cmr1459492d50.96.1790803548902;
        Wed, 30 Sep 2026 14:25:48 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm264063d50.20.2026.09.30.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:25:48 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 0/4] stash: clean up index-mode test merge
Date: Wed, 30 Sep 2026 17:24:37 -0400
Message-ID: <cover.1790803471.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This small patch series fixes a bug reported by Eli Barzilay in the
interaction between autostashing, staged index entries, and
stash.index=true.

The first patch is an incidental cleanup, and the second re-arranges one
line to make the change easier. The third adds missing test coverage
(which catch breakages from prior incorrect rounds of this series). The
fourth fixes a test interaction with another in-flight topic. The last
holds the interesting bits.

Changes in v5:
• Rebase on synthetic merge for the test interaction with t5520
  (dropping old 4/5) [59d1ce1b6e (Merge branch 'tb/t5520-reflog-expire'
  into dk/stash-apply-index-incore, 2026-09-29)]
• Fix handling of tri-state merge_result.clean

Changes in v4:
• Drop merge verbosity changes altogether. I was going to
  save-and-restore, but when looking at the index-merge test case (more
  below) closer, I noticed that "git apply --cached" reports conflicts
  on stderr. That is, "git stash apply --index" would report conflicts,
  and silencing the merge takes that away. So instead let's leave the
  configured verbosity alone.
• Only copy resulting index merge tree OID when successful
• Fix interaction with t5520 (new patch 4/5)
• Squash test from 3/5 into 5/5, since it requires actually merging
  trees. I've elected to keep it a separate test for now (contrary to
  Phillip's suggestion) since it's written and working. Adapting
  existing tests requires quite a bit more digging into implicit context
  assumptions ;)

Changes in v3:

• Change conflict label for current index
• Fix memory leak of merge_result
• Fix order of trees to make the correct merge (cherry-pick)
    • New test (3/5) to validate this
• Fix test in 4/5 to assert more details of expected state

Changes in v2:

• Do give branch labels for the incore merge, although they are never
  seen (and clarify commit message as a result, also keeping the
  merge-ort asserts). Phillip was right: without those, we do segfault
  on conflicts.
• Use the ui merge options to keep the same diff algorithm.
• Use merge_finalize instead of clear_merge_options, and reuse the
  options between merge calls if they are already initialized.
• Add a new 2/4 to simplify merge options initialization.
• Add a new 3/4 with a test case for conflicted index merges.

v1: <cover.1789853192.git.ben.knoble@gmail.com>
v2: <cover.1790168285.git.ben.knoble@gmail.com>
v3: <cover.1790425008.git.ben.knoble@gmail.com>
v4: <cover.1790684309.git.ben.knoble@gmail.com>

[1/4] builtin/stash: remove unused header
[2/4] stash: prepare merge options earlier
[3/4] t3903: test failed "stash apply --index"
[4/4] builtin/stash: merge index in-core

 builtin/stash.c  | 94 +++++++++++++-----------------------------------
 t/t3903-stash.sh | 42 ++++++++++++++++++++++
 t/t7600-merge.sh |  9 +++++
 3 files changed, 76 insertions(+), 69 deletions(-)

Diff-intervalle contre v4 :
1:  6a165c4df4 = 1:  d8f4c36459 builtin/stash: remove unused header
2:  35b64ae321 = 2:  8e99033ef0 stash: prepare merge options earlier
3:  7b0b317ce0 = 3:  ee28d0a840 t3903: test failed "stash apply --index"
4:  2ac371d2dc < -:  ---------- t5520: don't expire reflogs where it matters
5:  e21b832a6e ! 4:  ca3de1d4a3 builtin/stash: merge index in-core
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     +			merge_incore_nonrecursive(&o, merge_base, head, merge,
     +						  &result);
     +
    -+			if (!result.clean) {
    ++			if (result.clean < 0) {
    ++				merge_finalize(&o, &result);
    ++				return error(_("index merge failed"));
    ++			} else if (!result.clean) {
     +				merge_finalize(&o, &result);
      				return error(_("conflicts in index. "
      					       "Try without --index."));

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
prerequisite-patch-id: 601853fa5478b0dbfb260ba02632418e90338219
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

