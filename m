Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C356501F25
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701696; cv=none; b=PnG5WsDgqdXYqb2RiLaWJjI8RwM46g7SivFIsqB/M5fNMJJO5h2b0g6mCMx1ioOjcbKLhJ7QJCBl/a13tG3gynROFDr2W3stp4E8gjOU93S5ic3qiwTBQE8+pSOQksQF/U2yAw5rsZgdffHnZDaJth78g8crxXOD08h0dtkC+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701696; c=relaxed/simple;
	bh=J3tuKXpiDmNn/C/dwRaOpCZnJgEuF1waipE3p/kQVPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ETG7qFRQEQ1s+RXNqx9L6fV4X6WVO4F3w3K8uVFrexvV41ovQ6yWCWMLcHCBFiU6Cns6lCKrZU0h01DkEw49yPxi/bYKPmrWGziJXnC0rQM+6EzihnxhEiP7ZeE0ua3Z2iSFVhKI/4PXPTzKfGx4xG6CZFEC/ODbC9Ph/0iUa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE70WD2i; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE70WD2i"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c59695cc9so297079785a.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790701693; x=1791306493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uaDchMOCXVU0FK+T6R1LnQ5mkfS1Z4tdb3l9muKCnV0=;
        b=JE70WD2iUl1Iyns9ykYjuF+YJvuR1LBdFUXDeBCcWupRqrmiZcss2oDmiMmhXsLGNE
         qXqTjwipvJIvW14kPMJJ4co2rFESnsOe4wKfatPADZkU3CIBE43oyVYCDjGh8B2g9+nB
         8aFWybhQPB7caEULyJuzorB7OXxQ55nS9UDj2bwDJrEl+4vPW8uIzmR9Z3yk6MSFyRfx
         Q0vpcZU3WusV2Yv2sRfXL0KyoPf79sBCO+EkZSRECo/dLEttRECYSJ0E1d42ZE6y8xHw
         otI+FbDFj65wAsloTzgEick8IMSPUOT8fsuQ6eaTr5v+C/xYCYLNbwjpkh0MdWYlmulO
         mc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701693; x=1791306493;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uaDchMOCXVU0FK+T6R1LnQ5mkfS1Z4tdb3l9muKCnV0=;
        b=XLwDBXoVdz9+XeXOO/NXaIrnPAsgIRP3zll63V1yBF8Znby6b/lX0WZbagRWGhvIKk
         YpOhiM2ya2tNZiLSgNexQbZTsA4lR80u1qHek9n7xEovI4fxt5xGxH2rWxQIod9BeBR+
         qhp/g59PzhQmcF9ce8Ed7uqDuzS+58crW8t+j+wo7TX5Oab+HLghhknMhk1jrZ7vrscz
         /4fkGmcIEsQRbh0LXK/xcwtP5BSNQFjXvth8EjfE/Zg1u9+CB3XLomhJ7s8bpwuNHpIn
         xHA3fPX3LyXi/QRokvsGXxraBgX+H2UVtGYj4lCYDRPdpyk3tRXaVF5bPjji8h5WpTIp
         TAYA==
X-Gm-Message-State: AFuF++kSW1b6bu1mqkCnfMk8UZoCmx+qASB5I8l6Mi48aSxNg+2ZTcJJ
	lmtrVx4ga1fc7zyvmXRlfpcD16KXJFRDdnxGSRQWFnsaFWTKtnPAwyFLAkPrNw==
X-Gm-Gg: AYBFou12M/XAZfDmb2/FxBtaPLC547tCyH2P7T62OS1tAFvUG+Jd4/epvW7HEgWM6Vk
	yUw8YSvp4RdIqbKI2mdKBF0arbPfHFJUcgXbl/sDkz8hjo5PWtSMkdcHQi0Pn9PtkGTRH07ChkC
	+o0XZ8hhcl0qRXsHvKYFAGu9F9eIyNkAjH9CI+XTIWfPkCy7fnl1jraervt/MyvHBjDxYZwh3nf
	hM7EOlUc/xMV0sBvM7XTfwpuUULcXnXg9ZWNOpBK+CouL8MOqa000RHZFQN8fVWEjBjhLWtJpJS
	DqU+SNcB6u4coS9yyNcP9LaSpPRtL0R3HC9XA8i0VWj9JfHjM/udaVLDOI7Vb//udAV9IVPWJNQ
	1sgw9LEa6BhVNiBkqWZnWpRM4v6QiCFu1xaRIhy+FcsedPkm7QQg0jV6ac9W1JwUVXAWL/7Qe6X
	b1ET1dmPuKMgEH9Rdk6ZzxvaMBxo66ajCK3Dkw48gyvt53fvzb7SUBSqSmAYI/DPFnt8HiHLMdc
	g==
X-Received: by 2002:a05:620a:a407:20b0:93c:62b5:fc58 with SMTP id af79cd13be357-93c9fc2e241mr16294985a.62.1790701693223;
        Tue, 29 Sep 2026 10:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.92.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4601a9sm15877785a.13.2026.09.29.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:08:11 -0700 (PDT)
Message-Id: <pull.2243.v2.git.1790701691022.gitgitgadget@gmail.com>
In-Reply-To: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 17:08:10 +0000
Subject: [PATCH v2] t5520: don't expire reflogs where it matters
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git merge" saves any uncommitted changes with "git stash" before it
tries a merge strategy. When the strategy does not handle the merge,
it restores them with "git stash apply --index". If some of the
changes are staged, that runs "git reset", which writes an entry to
the reflog of HEAD. The autostash tests in this script run eight such
merges.

An upcoming change makes "git stash apply --index" merge the index
in-core, so it no longer runs "git reset" and those entries go away.
Another makes the default "merge" backend of "git rebase" run auto
maintenance when it finishes. Together, they change when auto
maintenance expires all reflogs, which it does once a hundred entries
in the reflog of HEAD are due to expire.

With both, the expiry comes at the end of the "git pull --rebase" in
the "--rebase with rebased upstream" test. The "git pull --rebase -f"
in the next test looks for the fork point in the reflog of
refs/remotes/me/copy, but as the test suite dates every reflog entry
to 2005, the expiry has emptied that reflog. Pull then finds no fork
point, so the rebase also replays copy-orig, the commit "copy" was
rewound from, and it conflicts.

Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
expire reflogs where it matters, 2026-02-24) did for the rebase tests,
so that the test no longer depends on where the expiry falls.

Reported-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    t5520: don't expire reflogs where it matters
    
    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
    
    Changes since v1: only the commit message, rewritten along the points
    Phillip raised on Ben's copy of this patch:
    https://lore.kernel.org/git/3547f4aa-649a-4f46-868c-0e50dfa69466@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2243

Range-diff vs v1:

 1:  1d8d6ed7f1 ! 1:  6699f3782e t5520: don't expire reflogs where it matters
     @@ Metadata
       ## Commit message ##
          t5520: don't expire reflogs where it matters
      
     -    The "--rebase -f with rebased upstream" test computes its fork point
     -    from the reflog of refs/remotes/me/copy, and the entry it needs is
     -    the one that the fetch of the test before it wrote. Like every reflog
     -    entry the suite writes after test_tick, it is dated 2005, so the
     -    first "git reflog expire --all" after that fetch removes it. Pull
     -    then finds no fork point and rebases onto the merge head with the
     -    merge head as the upstream, and the rewound commits come back as a
     -    conflict.
     +    "git merge" saves any uncommitted changes with "git stash" before it
     +    tries a merge strategy. When the strategy does not handle the merge,
     +    it restores them with "git stash apply --index". If some of the
     +    changes are staged, that runs "git reset", which writes an entry to
     +    the reflog of HEAD. The autostash tests in this script run eight such
     +    merges.
      
     -    Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
     -    default, 2026-02-24) auto maintenance runs that expiry once the reflog
     -    of HEAD holds a hundred entries it would remove, the default of
     -    maintenance.reflog-expire.auto. Which run crosses the threshold
     -    depends on the entries and maintenance runs before it, so the script
     -    passed by chance: a stash topic that no longer runs "git reset" from
     -    "stash apply --index" and a rebase topic that runs auto maintenance
     -    at the end of "git rebase" together move the expiry between the two
     -    tests.
     +    An upcoming change makes "git stash apply --index" merge the index
     +    in-core, so it no longer runs "git reset" and those entries go away.
     +    Another makes the default "merge" backend of "git rebase" run auto
     +    maintenance when it finishes. Together, they change when auto
     +    maintenance expires all reflogs, which it does once a hundred entries
     +    in the reflog of HEAD are due to expire.
      
     -    Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
     -    matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
     -    as well, which expires reflogs on its own, where turning off the auto
     -    trigger of the reflog-expire task alone would not.
     +    With both, the expiry comes at the end of the "git pull --rebase" in
     +    the "--rebase with rebased upstream" test. The "git pull --rebase -f"
     +    in the next test looks for the fork point in the reflog of
     +    refs/remotes/me/copy, but as the test suite dates every reflog entry
     +    to 2005, the expiry has emptied that reflog. Pull then finds no fork
     +    point, so the rebase also replays copy-orig, the commit "copy" was
     +    rewound from, and it conflicts.
     +
     +    Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
     +    expire reflogs where it matters, 2026-02-24) did for the rebase tests,
     +    so that the test no longer depends on where the expiry falls.
      
          Reported-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: D. Ben Knoble <ben.knoble@gmail.com>


 t/t5520-pull.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..bc818605a5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -35,6 +35,12 @@ test_pull_autostash_fail () {
 }
 
 test_expect_success setup '
+	# Commit dates are hardcoded to 2005, and the reflog entries will have
+	# a matching timestamp. Maintenance may thus immediately expire
+	# reflogs if it was running.
+	git config set gc.reflogExpire never &&
+	git config set gc.reflogExpireUnreachable never &&
+
 	echo file >file &&
 	git add file &&
 	git commit -a -m original

base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
-- 
gitgitgadget
