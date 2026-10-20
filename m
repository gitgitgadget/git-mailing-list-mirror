Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509658;
	b=O8Za4xE9WCtRP3kQscio3qkj70mCnI3DMHrVG/Ho9Bshi86UwxcqtHcKpVsaa5+vxny0
	 FyTjCau3Ww5pv390pwgDQxk/tueIpbJp5Aui7dHQU0aUb0+h5cVKtOlqKQPlruFTTqakP
	 7bJFk4GUbTTA7PREqShR2ZMT+yERBEZTe/VfWyu4W/Jc62+UKpoJjP3kM8LYEPGOUzeiq
	 X38NnoCa+FK09gxHoakXHtgWK3ndLMTykf5XVehbwqpLsw4BrzLaDUVP2wun5s5mWZ5n7
	 e6k3ZodSbc5QBYZoTgHFSerpwpx8EU+3u87Dg+a/AmWc8ggtvqZqQPuw8nevoWLwhcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D6DJHoWxUQcbRWxQwK8Qo/NUIMN02VUranUigh2rwe4=;
	b=4OEj1j9saL8DMkpPMc21fVS6BLb3ZaSKp+ReqiNEaC0ooNgEbdpwOQyaFIhXvaem0O/T
	 i0eAdaDgn2CpEPZl5XPxE3cllAW9DGeXZn5uwEXIyMr47t0xnzSPGixsdW7dOuwQZPTRc
	 omg0cvgJ4PhUQLK1qmdQRRYNNyDEwN/gF4zLcqEeA50UI00cUJFRTmqpsHs2rRERqEK8f
	 HA8AXsh2rt4CfluSXlbc/TfONDJd35RMgQDeuFTN1dzWg+rHHMDZFBNfxKEyel32+a1dD
	 PKqSOknzs+EyML3tbppu/N/G75JVzY9MJbAXE04riRGuk9/8v8TJE1FDmjH5pMzdcjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5CR825F;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D7606A33C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD1D7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5CR825F
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2625624f8f.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509656; x=1793114456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D6DJHoWxUQcbRWxQwK8Qo/NUIMN02VUranUigh2rwe4=;
        b=O5CR825FfsDjA1Gyvv8nRQZ9BlvpGpEtYJMzW671q3zcrOvqtnXJNj/JtIvcSr2Hym
         ENxw2LDPUOUF8Bj489V5HTDZO4b8kbGYT7Cq0tpP2vdbB6o4/xzLwlpTPmAp7dIugVik
         NgZZbIWTuZJOH9NWwzJEWbvgH5Y9DWzqa33BTrLtU7qt6DnoyR4u6Kpp+uAPvi+7OESv
         xmBjJ3k3DBByZNk5JZKPrP3aWIndZdzk7OwpsVK8NVvUtm0R4jcEmyOPCs2gd7TBpLKA
         3FyYeaXypXnwweubl2kihHlg/mLBRnT+pKWzZmDN26P0H8vAWklcO1DfoSCd+4fO3umq
         R8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509656; x=1793114456;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6DJHoWxUQcbRWxQwK8Qo/NUIMN02VUranUigh2rwe4=;
        b=eMZnRJ1V8Cpx30Z1JVsJnKKCkabGfv++unoWF9a74MzlSv1bqB6NUN1D/0+Y1Hv8zT
         a7//h2AOxw+Df6qPlS+cSpAFY3aI8tCQorBXTCV/uOBxmKQgV7+f/P58fa+PHIqi1RYn
         dZrt63VpXeL8KiKEd4M0lpIauSvUNqxxdiIItMOv3ShK2HotskMPSfOcsnOhHpthkzWo
         OX7xMg5j4+7SXNrgScpYRR3xUBvodcEw9vVt/+ToWXxGPgMkLk5vweGWclAE0md+qMIA
         IvCZqiDuM9bwkCaXuLR+xYacqpOAk2ENvf8BuCmG/ZU3RQ6S2ZYnoYy2QSKtKtoXE8HK
         BhDg==
X-Gm-Message-State: AFq9FYLVie/mSxViMMVxnhDh+ZPmtMw0XM+/mKRu5TteyGg65rJlcVtA
	7bdqWCWzQfK+rFoJhSRGLoo63tNnw8aH0z1QRZAqGhRqwek3NAtN1Y2G+38WFQ==
X-Gm-Gg: AYBFou0xVrkQ/hAfAFQpRHUNvccGcEoK/zQlRipBLCEdBLbyiIkvV51RTOmOyJeqRvx
	MrVN8PJmqfB20JuaO98gBgSdLW4Ihjs9Ykk7saxjJooX0ip9Mnom++NKT2DXyhacIIVjoYeJAcV
	s4gax2gT3OD2YNi0Wj3jJ5NcZ9zhqiHSzSPCj6PmqlYOshiofPPfJBUa3LnZjkmlu5uJ2NFu0sn
	RKroOyIWmy81PC8O7T2qdHykDO5dWR3vjVqZYn2pbxOVskiiJ2egNVvO5tl3wYRWqANbLQFM4MK
	k/S5uTHiVXH0usCfv7u665lCxy+QKXjwCCumwtWFj92n1q4EwykVFqBMIrapp5n+lYjCZTWGgZl
	AXcb8vEZHxX2sxdV6s11qzcPKRwY/WFMP5An6rfyWl//DNx27WrxMiW32KNYhh9XpctfTRS34v0
	hlxsYcLT+PHve1b9fsFoLO8JfsF2pcmubz7ffgZ/z3/HkGieKdQHrJ8zw43ehN7ZUASAIpcW567
	UciHGJBD52W
X-Received: by 2002:a05:600c:3507:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a1d75f94cfmr245730595e9.14.1792509655635;
        Tue, 20 Oct 2026 08:20:55 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:20:54 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/7] stash creation: avoid unecessary index loads and refreshes
Date: Tue, 20 Oct 2026 16:20:35 +0100
Message-ID: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Junio for his comments on V2, I've fixed a typo in patch
4 and rewritten the commit message for patch 5.

"git stash push" and "git stash create" load and refresh the index
multiple times when they only need to do it once. This series removes
a number of calls to repo_read_preload_index() and refresh_index()
which reduces the number of lstat() calls on each changed path by
four for "git stash create" and eight for "git stash push". It also
removes a duplicate call to check_changes() so that when stashing
untracked files we only walk them once.

Changes since V1:
 - Added an enum for the various return values from do_create_stash()
 - Fixed typos in the commit message of patch 2 (was patch 1)
 - Removed an unnecessary index refresh and several unnecessary index
   preloads

Cover letter for V1:

"git stash push" and "git stash create" check if there are
any unstaged or uncommitted changes at startup, and then again
when they try to create the stash. This short series removes
that duplication of effort which I spotted while looking at
<20260929074222.11942-1-kazumasa.shigeta@kanamei.com>.

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-optimize-check_changes-calls%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/c46c1e377...a486a625c
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-optimize-check_changes-calls/v3


Phillip Wood (7):
  stash: use an enum for create status
  stash create: remove duplicate changes detection
  stash push: remove duplicate changes detection
  stash push: avoid duplicate calls to preload_index()
  stash create: rework temporary index creation
  stash create: remove unnecessary index load and refresh
  stash: simplify reset_tree() function signature

 builtin/stash.c | 137 ++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 75 deletions(-)

Range-diff against v2:
1:  9e27bcd676 = 1:  9e27bcd676 stash: use an enum for create status
2:  d56b7c6f67 = 2:  d56b7c6f67 stash create: remove duplicate changes detection
3:  36fc0eb913 = 3:  36fc0eb913 stash push: remove duplicate changes detection
4:  6ca7e1c567 ! 4:  a9875ba5b3 stash push: avoid duplicate calls to preload_index()
    @@ Metadata
      ## Commit message ##
         stash push: avoid duplicate calls to preload_index()
     
    -    do_stash_push() needs to load the index so it can check that any
    +    do_push_stash() needs to load the index so it can check that any
         pathspec argument refers to tracked files. To do that it calls
         repo_read_index_preload() which does not just load the index, it also
         calls preload_index() which lstat()s all the files to see which ones
5:  f799d86f52 ! 5:  de5e0c196a stash create: rework temporary index creation
    @@ Metadata
      ## Commit message ##
         stash create: rework temporary index creation
     
    -    Use create_index_from_tree() instead of reset_tree() when we create a
    -    temporary index file to stash the working tree changes. This matches
    -    what we do for "git stash push -p" and means we can avoid messing with
    -    set_alternate_index_output(). Add a new parameter to control whether
    -    the index is reset, as we need to merge the index rather than reset
    -    it so that we still detect intent-to-add entries. We do not alter the
    -    in-memory index so we can remove the call to repo_read_index_preload()
    -    which saves one lstat() call per changed path.
    +    We use reset_tree() to create the temporary index file used to stash
    +    uncommitted working tree changes. Unfortunately, reset_tree() reads
    +    the tree into the repository's in-memory index and writes the index
    +    to the repository's default index path. In this case, we read the
    +    tree that's already in the index and copy the existing stat data
    +    across, so overwriting the in-memory index should not change its
    +    contents. To write to a temporary index file, the caller has to
    +    use set_alternate_index_output(). While that writes the index to a
    +    temporary file, it updates the timestamp of the in-memory index so
    +    that the timestamp no longer represents the index file the in-memory
    +    index was read from. In practice that probably does not matter, but
    +    set_alternate_index_output() also relies on a global variable which
    +    makes the code harder to reason about.
    +
    +    Use create_index_from_tree() instead of reset_tree() so that we
    +    can create temporary index file without overwriting the in-memory
    +    index or relying on set_alternate_index_output(). This also makes
    +    the implementation consistent with the way we create the temporary
    +    index for "git stash push -p". As create_index_from_tree() does not
    +    modify the in-memory index it is clearly safe to remove the call to
    +    repo_read_index_preload() which saves one lstat() call per changed
    +    path. It would probably be safe to remove that call without moving away
    +    from reset_tree() but it is much easier to reason about now that the
    +    in-memory index is not modified when we create the temporary index file.
    +
    +    In order to use create_index_from_tree() we need to add a new
    +    parameter to control whether the index is reset, as the new caller
    +    needs to merge the index rather than reset it so that we still detect
    +    intent-to-add entries.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
6:  768d6bc7e5 = 6:  61e4ce22a0 stash create: remove unnecessary index load and refresh
7:  db53bf3b57 = 7:  a486a625c9 stash: simplify reset_tree() function signature
-- 
2.56.0.134.g299a3c16181

