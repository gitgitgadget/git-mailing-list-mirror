Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED004439F62
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627211; cv=none; b=rXcxi2bAIu0mWHHeWPfmD6WZp31cyUuwc1iHo3CXAHan7QTuX5UmWwa4GMx25c9+P2fqIfNzBKCpfVembtfAuwCsuEuVL2GLbkUWvy59vGG4++tM9E9xb/1TDZWdrQzqq8EX4xEtngguOmPG0sH4flxzQlDmEqNeCcpR5dL0rZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627211; c=relaxed/simple;
	bh=O9Myz+ZimIM3RJnIXtetDP426YwFoHvB6ujFu2NOauo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gwH0fYx9WZfNjjaoctVWAnxJ/3iPDkM9L28Z4igDbucso82O958uumvl5mQ0oA2g4MVbsgk+Aw6TE/eITUALFZ2+pftQ3wvEYRKlRrzyyxnGwjFyWtazYySeseCSAhpB9ilJyGnb/vNatc4b/GQbtxQglDPY39Ch5mRuiQK5BhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1MJbJHk; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1MJbJHk"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d7a9e2eb24so292954eaf.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627207; x=1792232007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t3bRMsOu8GBCqYuv/84JosOKJBtL/2Dj3N1j4GMPWhk=;
        b=b1MJbJHk4ii20CbGCQtrrkedu/zUXdNSiEc7EoaBsd60uZ8zqXDPUdJwFAQscNxSio
         KVuuRRoDePYfwz2l7QteHM33Z6AErouyh8fS3HU1htRp4ePsV+obtx4J0OLud1KLShEi
         mxn58BdlsilFJXJfjAHlldBGaxb7p+vKyPqj5zl9jMLAbToY9+/MpOnrhUoortxhvW+z
         9N5kVRmi+LXvPVbGCIYtIk3MsvJb5frmEbX4N4gB+1Gv2/H9PnHNUPWupGDw1cJDleKK
         6VNJaEDLm0H/GCk+ti87WJcs9M6uMCaOAwfrg0ezShSm0wV0nUF38hPRqB4rwTYsnyHj
         6uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627207; x=1792232007;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3bRMsOu8GBCqYuv/84JosOKJBtL/2Dj3N1j4GMPWhk=;
        b=U00n0Dtt9XWAdG2xJ7TMC0+1HWUk+JFsjs18V8Sp6N1Cc0AlcUUaiX4re48ueMDQx1
         czKUFrflJHQdTrTs/n9FIokCrcv0P8Gvu06N08xkuzdGzfU9Eea6ICH53jdMxVKPGk9s
         uI09b3Ch//UQvPTeCVgQtanS+J2jveWNI7UjMoriq0R/hDzZopezB3xyQokFBtlsyCiM
         dMW1xIS8s9uZYJQDm+rba5rXgXqEMVMb5GLn2tZRQwgJr7iA5AehDho3I7UuFV4wpwR2
         ehAYX3gbRaL3yNuPFMgIT5pEulmY4uohdICq7cTEGCtf3CHZyYgQy7PyomWb8DiOu5YW
         YAFw==
X-Gm-Message-State: AFq9FYJiF7kgUs66rb/0Q9uEXjSTTTPKWKa7xhvE1E+lxHVrI/3j8wnu
	/9Fj0d3JXcs16Pbli9kpsIO1uNZQyh/MSyHgMUNMzE5k36DMg6G42inRE9KUnNDz
X-Gm-Gg: AYBFou2VWmzqgbEevPxmeIwv4w5FO6mkZuHMX05KlO+wLVj1qUo65c2Uzx6MSoay2Qt
	/ygL1arADp4Imi/57al3+xsWlqfvniFcmWea1z5gRuN/k9XYJB8AFsxlpUOmFfVhEPN3f9TQu2s
	F/WLguB3pWfvGZxaH7VVy59TwnBkR7zUXRdelqGuMJZJbxsnuu7fYrxXV9jJnegZMPddGNzRSKg
	sdKs0TI4aRktMReWNr6vhfPu7CSIXalbdYaFcrmy0yjuBpDVRZnZd7BoKvHhy7bSv6beDziOLz/
	eozbl07cAWIJKXsgESgyChKhSojJYBp5fGEkmylSQSYY5wRez8tPydMT5Wl42fVsRC9HIRFw63y
	nEQ2fhGTXikyyHfvMMii/GrziwLXLKgKCUBVy+hK7zUrrc/GIx11Qrodm91j+Cv2lWOqR9K1Obl
	FFh/YYG/bDWHezXOj2NWzPDjA7JGWAKFMj0ldJsR5I9I4oksV09ySS6oWEQLsc8UDtR6tXcMdOE
	DkjRMCBaBbORw==
X-Received: by 2002:a05:6820:1795:b0:6d8:4e2e:9973 with SMTP id 006d021491bc7-6ef0f99b8b0mr3040972eaf.63.1791627207456;
        Sat, 10 Oct 2026 03:13:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.239.199])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eefc38911esm4459475eaf.1.2026.10.10.03.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:13:25 -0700 (PDT)
Message-Id: <pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 10:13:22 +0000
Subject: [PATCH v7 0/2] rerere: wait for MERGE_RR.lock, but not in auto maintenance
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>

A rebase dies at a conflict when a background "git rerere gc" holds
MERGE_RR.lock at that moment. With the first patch, rerere waits for the
lock instead of dying at once. With the second, the "git rerere gc" started
by auto maintenance does nothing while the lock is held.

For v7 I took Patrick's suggestions on patches 2 and 3. Changes since v6:

 * Patch 3, which let a command that stops at a conflict go on without
   rerere, is gone. It can come back if users still run into the lock
   (Patrick).

 * Patch 2's log message is Patrick's, plus a last paragraph on why the
   option is hidden.

 * rerere_gc() takes its own flags, enum rerere_gc_flags, with
   RERERE_GC_NOWAIT (Patrick).

 * The comment in setup_rerere() no longer says who passes RERERE_NOWAIT,
   and the one on RERERE_NOWAIT now says that setup_rerere() then returns -1
   as if rerere were disabled (Patrick).

 * "git rerere gc --skip-locked" without a held lock is a test of its own
   (Patrick).

Thomas Bachem (2):
  rerere: wait for MERGE_RR.lock before giving up
  rerere: add "gc --skip-locked" for auto maintenance

 Documentation/config/rerere.adoc | 10 ++++
 builtin/gc.c                     |  4 +-
 builtin/rerere.c                 | 10 +++-
 rerere.c                         | 38 ++++++++++++---
 rerere.h                         | 11 ++++-
 t/t4200-rerere.sh                | 79 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           | 25 +++++++++-
 7 files changed, 165 insertions(+), 12 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v6:

 1:  3dc3d02f12 = 1:  3dc3d02f12 rerere: wait for MERGE_RR.lock before giving up
 2:  2ef141410a ! 2:  0002881196 rerere: add "gc --skip-locked" for auto maintenance
     @@ Metadata
       ## Commit message ##
          rerere: add "gc --skip-locked" for auto maintenance
      
     -    Since the previous commit, "git rerere gc" waits for MERGE_RR.lock
     -    like every other command that takes it, and fails only if the wait
     -    times out. That suits a user who runs it by hand and wants to know
     -    when nothing was pruned. But the user did not ask for the gc that auto
     -    maintenance starts after a commit, and the next commit starts another
     -    one.
     +    Starting with the preceding commit, processes that want to acquire
     +    the rerere cache's MERGE_RR.lock by default know to wait up to one
     +    second until that lock has been released. This is a sensible default
     +    for many commands that happen to write rerere entries, as we would
     +    otherwise die immediately when the lock is taken by another process.
      
     -    So add "--skip-locked", with which "git rerere gc" quietly does
     -    nothing while the lock is held, and pass it from
     -    "git maintenance run --auto" and "git gc --auto". Only these two need
     -    the option, so hide it and leave it undocumented, like the
     -    "--skip-foreground-tasks" that "git maintenance run" passes to
     -    "git gc". A run without it, from the command line or a maintenance
     -    schedule, still waits for the lock and fails if the wait times out.
     +    But for repository maintenance it's a bit more complicated, as there
     +    are two cases that we have to care about. When the user explicitly
     +    asks us to garbage collect rerere entries via `git rerere gc` they
     +    probably want us to try our best to perform this operation. It's thus
     +    sensible to wait for the lock and then die if we weren't able to
     +    acquire it.
      
     +    But we also prune rerere entries as part of auto-maintenance, which is
     +    only executed on a best-effort basis anyway. Delaying the whole
     +    operation to acquire the lock is somewhat heavy-handed, and neither
     +    does it make sense to die in case we haven't been able to garbage
     +    collect rerere entries as that would impede other housekeeping tasks.
     +    Furthermore, it's totally fine to skip the operation when the rerere
     +    cache is locked already, as we will retry during the next run anyway.
     +
     +    But we do not have an easy way to tell `git rerere gc` to skip the
     +    operation in case the cache is locked already. Add a new
     +    "--skip-locked" flag to plug that gap and have auto-maintenance pass
     +    that flag.
     +
     +    Only auto-maintenance needs that flag, so hide it, like the
     +    "--skip-foreground-tasks" flag that `git maintenance run` passes to
     +    `git gc`.
     +
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
     @@ builtin/rerere.c: int cmd_rerere(int argc,
       	} else if (!strcmp(argv[0], "gc"))
      -		rerere_gc(the_repository, &merge_rr);
      +		rerere_gc(the_repository, &merge_rr,
     -+			  skip_locked ? RERERE_NOWAIT : 0);
     ++			  skip_locked ? RERERE_GC_NOWAIT : 0);
       	else if (!strcmp(argv[0], "status")) {
       		if (setup_rerere(the_repository, &merge_rr,
       				 flags | RERERE_READONLY) < 0)
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       		/*
       		 * Another process may hold the lock for a while, e.g.
       		 * "git rerere gc" while it prunes rr-cache, so wait for
     --		 * it instead of dying right away.
     -+		 * it instead of dying right away.  The gc of an automatic
     -+		 * maintenance run does not wait, since skipping one of
     -+		 * its runs costs nothing.
     + 		 * it instead of dying right away.
       		 */
      +		if (flags & RERERE_NOWAIT) {
      +			lock_flags = 0;
     @@ rerere.c: out:
       }
       
      -void rerere_gc(struct repository *r, struct string_list *rr)
     -+void rerere_gc(struct repository *r, struct string_list *rr, int flags)
     ++void rerere_gc(struct repository *r, struct string_list *rr,
     ++	       enum rerere_gc_flags flags)
       {
       	struct string_list to_remove = STRING_LIST_INIT_DUP;
       	DIR *dir;
     @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
       	struct strbuf buf = STRBUF_INIT;
       
      -	if (setup_rerere(r, rr, 0) < 0)
     -+	if (setup_rerere(r, rr, flags) < 0)
     ++	if (setup_rerere(r, rr,
     ++			 (flags & RERERE_GC_NOWAIT) ? RERERE_NOWAIT : 0) < 0)
       		return;
       
       	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
     @@ rerere.h: struct repository;
       #define RERERE_AUTOUPDATE   01
       #define RERERE_NOAUTOUPDATE 02
       #define RERERE_READONLY     04
     -+/* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
     ++/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
      +#define RERERE_NOWAIT       010
       
       /*
     @@ rerere.h: const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
       int rerere_remaining(struct repository *, struct string_list *);
       void rerere_clear(struct repository *, struct string_list *);
      -void rerere_gc(struct repository *, struct string_list *);
     -+void rerere_gc(struct repository *, struct string_list *, int);
     ++
     ++enum rerere_gc_flags {
     ++	/* Skip the operation in case the MERGE_RR.lock is already taken. */
     ++	RERERE_GC_NOWAIT = (1 << 0),
     ++};
     ++
     ++void rerere_gc(struct repository *, struct string_list *,
     ++	       enum rerere_gc_flags flags);
       
       /*
        * Check whether garbage collection for rerere entries is needed, which is
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	>.git/MERGE_RR.lock &&
      +	git rerere gc --skip-locked 2>err &&
      +	test_must_be_empty err &&
     -+	test_path_is_file $rr2/preimage &&
     ++	test_path_is_file $rr2/preimage
     ++'
     ++
     ++test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
     ++	mkdir -p $rr2 &&
     ++	echo Hello >$rr2/preimage &&
     ++	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
      +
     -+	rm .git/MERGE_RR.lock &&
      +	git rerere gc --skip-locked &&
      +	test_path_is_missing $rr2/preimage
      +'
 3:  cd018289bb < -:  ---------- rerere: go on at a conflict when the lock stays busy

-- 
gitgitgadget
