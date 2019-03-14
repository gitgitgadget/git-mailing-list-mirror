Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF98520248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCNMex (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:34:53 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50267 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCNMex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:34:53 -0400
Received: by mail-wm1-f50.google.com with SMTP id x7so2803452wmj.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBK+ZLV0wiptmyzD/orWumd9r6PAohsunW2mNjKHg6c=;
        b=Orisbsek63qWV0IHYGjbYBhYWzGaR3o5JXWlazFn6+TtOSzIYnk0VXkQbo51zFeG4I
         kuJL/E3j9N8lQDDWDEyAaOVf7Y0NShUztUHrWDAOSyZr1z9OUdLsGBUBPA5umgTYmHhC
         KZnfZ70enL0UsybKuxFOh2MpYv9RNb5ezixNrQ2dySmMFY7DGLpHONHnkdvF2IA1MZyH
         NcNRH8LjXRVZQNZ6W2AlHF5shInk5fEp9Jclug5glAwU+3fWkYEfQC04hwpIzgw33zsG
         iGIzFQEcKJFL7MZF3iG98xwTFJGn/wvcSk+/4qTi6zLDwbplQpUer3bsEgCkXmwop/gp
         jKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBK+ZLV0wiptmyzD/orWumd9r6PAohsunW2mNjKHg6c=;
        b=iE0otLTcdyA0ggy8MTwtueJzc3KlBreSB8XK2Em2r8OmW++a67UfXemnH0dYvtyVl7
         1+l53W+aVx6uNLCSEklLW00qEXL8lhOsOFEkgJZAQlpoZnIhzqqXQzXjWKXk0v7sg9k6
         61MD/B4tEu0OKndhxqxexxi8eAGUa/FBQWLBVIEAP24W6+uozO1alKIyM1qpHOKMGv6d
         Nf1fspoMVIW6Uph0jtL+n36ZNjGjZB2jS7rTdhPXYP018LDOjz9zeKxtXlHeSQwbUtoz
         dnp511dCosdr/iIhO0aN297koaAvHq3gNu6+vYKjYA1uqwMdUj/TSpLynCaY1Ucso0Ft
         juag==
X-Gm-Message-State: APjAAAW8vHOUuzY5AmldlnCfBwCQuOgVu9IoNWqa2JKs+JEo/PUQiSsn
        wYLv1B6cpQ5YNPYfvU35uyuDaEhSnCc=
X-Google-Smtp-Source: APXvYqwlX6eu5p4NaiMWZUlRVS2CR20XfSN7TQqN8AStf0CAjGlHUFBPhNNEIBbGu+xp6ZkOXCQucg==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr2498201wmi.104.1552566889423;
        Thu, 14 Mar 2019 05:34:49 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] gc: minor code cleanup + contention fixes
Date:   Thu, 14 Mar 2019 13:34:32 +0100
Message-Id: <20190314123439.4347-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresse Peff's comments to v1. For a couple of patches I've faked up
his SOB where I copy/pasted a comment or code from a v1 comment
verbatim. Will see if he acks that.

The main change is a better commit message in the last patch (now
7/7), and 2x new "reflog" patches to make it early exit in addition to
"gc" when there's nothing to do.

There was the "why do it at all in gc" feedback on 6/7 in v1. I've
adjusted the commit message there to justify it, but we'll see what
Peff things about it this time around...

Ævar Arnfjörð Bjarmason (7):
  gc: remove redundant check for gc_auto_threshold
  gc: convert to using the_hash_algo
  gc: refactor a "call me once" pattern
  reflog tests: make use of "test_config" idiom
  reflog: exit early if there's no work to do
  gc: don't run "reflog expire" when keeping reflogs
  reflog expire: don't assert the OID when locking refs

 builtin/gc.c         | 37 +++++++++++++++++++++++++++++--------
 builtin/reflog.c     |  7 +++++++
 refs/files-backend.c |  2 +-
 t/t1410-reflog.sh    | 17 ++++++++---------
 t/t6500-gc.sh        | 19 +++++++++++++++++++
 5 files changed, 64 insertions(+), 18 deletions(-)

Range-diff:
1:  1635c7fb22 ! 1:  e18433f9c6 gc: convert to using the_hash_algo
    @@ -11,16 +11,26 @@
         the case for SHA-256, and reading between the lines in
         hash-function-transition.txt the format is planned to be the same.
     
    -    However, we may want to modify this code for the hash function
    -    transition. There's a potential pathological case here where we'll
    -    only consider the loose objects for the currently active hash, but
    -    objects for that hash will share a directory storage with the other
    -    hash.
    +    In the future we may want to further modify this code for the hash
    +    function transition. There's a potential pathological case here where
    +    we'll only consider the loose objects for the currently active hash,
    +    but objects for that hash will share a directory storage with the
    +    other hash.
     
         Thus we could theoretically have 1k SHA-1 loose objects, and say 1
         million SHA-256 objects, and not notice because we're currently using
         SHA-1.
     
    +    So assuming that "gc" eventually learns to pack up both SHA-1 and
    +    SHA-256 objects regardless of what the current the_hash_alg is perhaps
    +    this check should be changed to consider all files in objects/17/
    +    matching [0-9a-f] 38 or 62 characters in length (i.e. both SHA-1 and
    +    SHA-256).
    +
    +    But none of that is something we need to worry about now, and
    +    supporting both 38 and 62 characters depending on "the_hash_algo"
    +    removes another case of SHA-1 hardcoding.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/builtin/gc.c b/builtin/gc.c
    @@ -30,8 +40,7 @@
      	int auto_threshold;
      	int num_loose = 0;
      	int needed = 0;
    -+	const unsigned hexsz = the_hash_algo->hexsz;
    -+	const unsigned hexsz_loose = hexsz - 2;
    ++	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
      
      	dir = opendir(git_path("objects/17"));
      	if (!dir)
2:  ced972826d ! 2:  54e4bce91c gc: refactor a "call me once" pattern
    @@ -10,6 +10,7 @@
         "prune_reflogs" variables, so let's not leave the reader wondering if
         they're being zero'd out for later use somewhere else.
     
    +    Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/builtin/gc.c b/builtin/gc.c
    @@ -19,6 +20,11 @@
      
      static void gc_before_repack(void)
      {
    ++	/*
    ++	 * We may be called twice, as both the pre- and
    ++	 * post-daemonized phases will call us, but running these
    ++	 * commands more than once is pointless and wasteful.
    ++	 */
     +	static int done = 0;
     +	if (done++)
     +		return;
-:  ---------- > 3:  82f87db134 reflog tests: make use of "test_config" idiom
-:  ---------- > 4:  c79608dbbb reflog: exit early if there's no work to do
3:  599772f2bd ! 5:  c47dedab58 gc: don't run "reflog expire" when keeping reflogs
    @@ -5,10 +5,18 @@
         Don't redundantly run "git reflog expire --all" when gc.reflogExpire
         and gc.reflogExpireUnreachable are set to "never".
     
    -    I'm being careful to not repeat the issue fixed in
    -    8ab5aa4bd8 ("parseopt: handle malformed --expire arguments more
    -    nicely", 2018-04-21). We'll die early if the config variables are set
    -    to invalid values.
    +    An earlier change taught "git reflog expire" itself to exit early
    +    under this scenario, so in some sense this isn't strictly
    +    necessary. Reasons to also do it here:
    +
    +     1) Similar to 8ab5aa4bd8 ("parseopt: handle malformed --expire
    +        arguments more nicely", 2018-04-21). We'll die early if the config
    +        variables are set to invalid values. We run "pack-refs" before
    +        "reflog expire", which can take a while, only to then die on an
    +        invalid gc.reflogExpire{Unreachable,} configuration.
    +
    +     2) Not invoking the command at all means it won't show up in trace
    +        output, which makes what's going on more obvious.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
4:  c127265828 ! 6:  55dd203a04 reflog expire: don't assert the OID when locking refs
    @@ -2,35 +2,39 @@
     
         reflog expire: don't assert the OID when locking refs
     
    -    The locking protocol for reflogs involves getting a *.lock file on the
    -    loose ref[1] (even if the actual ref is packed). This isn't needed to
    -    expire the reflog, and needlessly results promotes reference update
    -    contention to hard errors in e.g. "gc".
    -
         During reflog expiry, the cmd_reflog_expire() function first iterates
    -    over all known references, and then one-by-one acquires the lock for
    -    each one to expire its reflog. By the time it gets around to
    -    re-visiting the references some of the OIDs may have changed.
    +    over all reflogs in logs/*, and then one-by-one acquires the lock for
    +    each one to expire its reflog by getting a *.lock file on the
    +    corresponding loose ref[1] (even if the actual ref is packed).
    +
    +    This lock is needed, but what isn't needed is locking the loose ref as
    +    a function of the OID we found from that first iteration. By the time
    +    we get around to re-visiting the reference some of the OIDs may have
    +    changed.
     
    -    This has been the case ever since "reflog expire" was initially
    -    implemented in 4264dc15e1 ("git reflog expire", 2006-12-19). As seen
    -    in that simpler initial version of the code (and the same is the case
    -    before this change) we subsequently use the OID to inform the expiry,
    -    but never needed to use it to lock the reference associated with the
    -    reflog.
    +    Thus the verify_lock() function called by the lock_ref_oid_basic()
    +    function being changed here would fail with e.g. "ref '%s' is at %s
    +    but expected %s" if the repository was being updated concurrent to the
    +    "reflog expire".
     
    -    Thus the verify_lock() function would fail with e.g. "ref '%s' is at
    -    %s but expected %s" if the repository was being updated concurrent to
    -    the "reflog expire".
    +    By not passing the OID to it we'll try to lock the reference
    +    regardless of it last known OID. Locking as a function of the OID
    +    would make "reflog expire" exit with a non-zero exit status under such
    +    contention, which in turn meant that a "gc" command (which expires
    +    reflogs before forking to the background) would encounter a hard
    +    error.
     
    -    This made "reflog expire" exit with a non-zero exit status, which in
    -    turn meant that a "gc" command (which expires reflogs before forking
    -    to the background) would encounter a hard error in such a scenario.
    +    This behavior of considering the OID when locking has been here ever
    +    since "reflog expire" was initially implemented in 4264dc15e1 ("git
    +    reflog expire", 2006-12-19). As seen in that simpler initial version
    +    of the code we subsequently use the OID to inform the expiry (and
    +    still do), but never needed to use it to lock the reference associated
    +    with the reflog.
     
    -    If we instead lock the reference without considering what OID we last
    -    saw it at, we won't encounter user-visible contention to the extent
    -    that core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs:
    -    retry acquiring reference locks for 100ms", 2017-08-21).
    +    By locking the reference without considering what OID we last saw it
    +    at, we won't encounter user-visible contention to the extent that
    +    core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs: retry
    +    acquiring reference locks for 100ms", 2017-08-21).
     
         Unfortunately this sort of probabilistic contention is hard to turn
         into a test. I've tested this by running the following three subshells
-- 
2.21.0.360.g471c308f928

