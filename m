Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398441F462
	for <e@80x24.org>; Wed, 19 Jun 2019 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFSK0R (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 06:26:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFSK0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 06:26:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so2781785wrs.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPqV6BAfRDjqkWb5da1tH2c+NJ/D+wwiJxPEoXa1W00=;
        b=LKknty8wPvLr4YrRVG6os8uIG59E03Wsz11T2LvffBrjK2YEIf5J7W8VO6r58cjMd7
         x/TnU2fSxX6gKMz7d/ZTzhaT/fTtb2jKmDdMN7iZZ0rsN+sxs1FtvWQs+Eyh9fRl9G8y
         iC0WDD2Cs1PtogFt5DgnYTCAUZBg2AKOZZ3YWMPPv29FuA1L0yr0YzsVEFXjCN/WB94x
         JNPpAhOlD4pJqJ8f9wZYlevxl1/ivkCQ4wbQV/NF7uTaB2XeKxXjg+BxycnMXitifgL6
         UODk+RtbvyNxezzXmkrrjWsF2yl7dsTpG7WBAXsovT3d9QsVNDauP95EFpw9T+wldL14
         dmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPqV6BAfRDjqkWb5da1tH2c+NJ/D+wwiJxPEoXa1W00=;
        b=dILmOwehaXyt8/f33qsDg7fHdqNILU0l9qout3mToyG8fT8EV4gMAtKzqX+b8LgF38
         +OP715klMSeiL3vy0YfG1MTSWKAQdg/DZAA07DbmS8K6+xzSqYhO5aDaN+MPqKaf2cNn
         xPG9nvZtvqR44Uob3gCqcHEYwNwirmG42SmYvjZKM58B+0yYva8SQtyNZ5DDM1CSemi8
         LJoeOvkJHlK+wzqC6R0ryEicn5CW/tiX0b4EoiUKR9QL4TrYS3SPToQqw8YOLIb8Iscm
         MyA7kLGUjPa03CmY20pcyjGaRcULRX3DayOCoKJTTgPTVJ22kJa7f6NzRssvL9QsQhKS
         pgWQ==
X-Gm-Message-State: APjAAAWinHBRMIjhonz24ODI9qfy+ev7Br3mYh48/IJIve5QejrHnOny
        n44+oB+th1Uccp2PttR6CzaygZW2
X-Google-Smtp-Source: APXvYqxNsSqrSzHm1ZH/rO4YsCvDglvKKabP3w0/D7gigttz00ju3VquNS+TSH77kJBw/Z8PjsaM0Q==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr32576583wrm.87.1560939973304;
        Wed, 19 Jun 2019 03:26:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w67sm1388054wma.24.2019.06.19.03.26.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:26:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] gc: run more pre-detach operations under lock
Date:   Wed, 19 Jun 2019 12:26:00 +0200
Message-Id: <20190619102601.24913-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <20190619094630.32557-1-pclouds@gmail.com>
References: <20190619094630.32557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the work started in c45af94dbc ("gc: run pre-detach
operations under lock", 2017-07-11).

Now we'll take the lock before we print out "Auto packing the
repository[...]", and we'll optimistically tolerate a locking failure
at that point instead of dying.

This (mostly) solves two issues:

 1) Fetching in parallel from multiple remotes (or other
    parallel/concurrent "gc --auto") would, when the need_to_gc()
    heuristic fired, emit a bunch of "Auto packing the repository in
    background" messages. See [1] for a description of a "pfetch"
    alias that can trigger such an issue. Now we'll (usually) only
    print one of these messages.

 2) Because we'd call hold_lock_file_for_update() with
    "LOCK_DIE_ON_ERROR" such concurrent "gc" would error out with
    "Another git process seems to be running[...]".

    Now we'll (usually) avoid that by saying that "gc --auto" locking
    isn't so important. We tolerate a lock failure on "gc --auto" with
    the assumption that a "gc --auto" runs frequently enough that any
    one such invocation can fail, whereas without "--auto" we'll error
    on failure to acquire the lock

Why "mostly" and "usually"? There's still unaddressed caveats with
these two, respectively:

 1) The gc.pid lock is only held while the "git gc" runs. Thus a
    "pfetch" operation as described in [1] might start N jobs, one of
    which runs "gc", finishes, and then "gc --auto" finds it needs to
    run again in the context of a single (from the user's perspective)
    git command.

    I don't think that's worth dealing with. The cases where we'll
    find we need to take action "gc --auto" right after it's finished
    are rare (see e.g. [2]).

 2) There's still the unresolved race condition noted in c45af94dbc
    where we "hand off" the lock to the child process we fork under
    gc.autoDetach=true. It means we might start another "gc --auto" if
    we're so unlucky as to make the check and get the lock in the time
    the "real" earlier "gc --auto" parent/child process takes to
    "unlock() && fork() && lock()".

    Fixing that is outside the scope of this change. It's fixable by
    refactoring the lockfile.c code and daemonize() so that we'd e.g.:

      1. parent: lock() in parent, write PID to gc.pid
      2. parent: fork() the child process
      3. child: spin for X amount of time waiting until gc.pid lists
         our PID, not our parent's
      4. parent: amend the gc.pid lock to
         s/PARENT_PID/CHILD_PID/ (in-place rename(gc.pid.new,
         gc.pid)), fsync(gc.pid) and exit()
      5. child: notices updated gc.pid, proceeds with its gc. Does
         delete_tempfile(gc.pid) before exit()
      6. parent: Once lock is handed over (child trusted to poll the
         lock) exit() without delete_tempfile(gc.pid)

    Using some cross-process lock handover like that we could
    guarantee that there's never a point at which an outside process
    could get the gc.pid lock, that the PID written in the file always
    referred to a live process, and with #3 reasonably
    guarantee (aside from pathological scheduling shenanigans) that we
    don't blindly hand the PID off to a process that's already
    finished with its gc.

Testing for this new behavior is hard.

1. https://public-inbox.org/git/20170712200054.mxcabiyttijpbkbb@sigill.intra.peff.net/ (should
   be https://public-inbox.org/git/87bmopzbqx.fsf@gmail.com/ but vger
   seems to not have gotten a copy)
2. https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This patch is part of a WIP branch I have that's a bit of a mess. It's
more-gc-detach-under-lock on github.com/avar/git.git. It doesn't apply
on master because it relies on some previous test work, but for RFC
purposes I figured it was better to send it stand-alone.

But I think this sort of approach is better than Duy's proposed patch,
because...

On Wed, Jun 19 2019, Nguyễn Thái Ngọc Duy wrote:

> So let's try to avoid that. We should only need one 'gc' run after all
> objects and references are added anyway. Add a new option --no-auto-gc
> that will be used by those n-1 processes. 'gc --auto' will always run on
> the main fetch process (*).
>
> (*) even if we fetch remotes in parallel at some point in future, this
>     should still be fine because we should "join" all those processes
>     before this step.

This is what I'm trying to fix in my version of this patch. This is
only true for yours if you assume that the user is going to be
invoking "fetch" in a single terminal window, IOW that we have an
implicit global mutex of one top-level git command at a time.

Wheras mine fixes e.g. the same issue for:

    parallel 'git fetch {}' ::: $(git remote)

Ditto for you running a "git" command and your editor running a
"fetch" at the same time.

A similar "one terminal" assumption was made when changing the
auto-detach behavior in your 62aad1849f ("gc --auto: do not lock refs
in the background", 2014-05-25).

To be clear, I think that (and your patch here) would (mostly) be an
improvement. I just wonder if we can do better.

I got stuck with this WIP series of mine because while it's mostly
ready sans the 'Why "mostly" and "usually"' caveats mentioned in my
commit message, I wondered if we couldn't do much better by:

 a) Do some version of reverting your 62aad1849f, this would entirely
    get rid of this need for handing off a lock to a child (noted
    above), but as-is would have e.g. "commit" run into a *.lock.

    Is that mitigated by 4ff0f01cb7 ("refs: retry acquiring reference
    locks for 100ms", 2017-08-21)? Or could we have "gc" run in some
    "lock-less" mode where it does all the work of expiring a
    ref/reflog at a given OID, and if it changed just tries again
    without needing to *.lock it except for the brief period of
    changing the already prepared file?

 b) If we couldn't do "a" for whatever reason implement some "locking
    priority" where a not-gc command could create a file (which "gc"
    would poll) saying "I want it for real work, release it!", or
    alternatively "gc" would create "*.locked-by-gc" in addition to
    "*.lock" files, and if the "*.locked-by-gc" was seen when the
    100ms retry would kick in, we'd make that say 10 seconds instead
    of 100 ms.

 builtin/gc.c  | 19 ++++++++++++-------
 lockfile.c    |  2 ++
 lockfile.h    |  8 +++++++-
 t/t6500-gc.sh |  8 ++++----
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d12316fa48..2cd5803e86 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -391,7 +391,7 @@ static int need_to_gc(void)
 }
 
 /* return NULL on success, else hostname running the gc */
-static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
+static const char *lock_repo_for_gc(int force, pid_t* ret_pid, int die_on_error)
 {
 	struct lock_file lock = LOCK_INIT;
 	char my_host[HOST_NAME_MAX + 1];
@@ -401,13 +401,17 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	FILE *fp;
 	int fd;
 	char *pidfile_path;
+	int flags = die_on_error ? LOCK_DIE_ON_ERROR : LOCK_QUIET_ON_ERROR;
 
 	if (xgethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
 	pidfile_path = git_pathdup("gc.pid");
-	fd = hold_lock_file_for_update(&lock, pidfile_path,
-				       LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&lock, pidfile_path, flags);
+	if (fd < 0) {
+		assert(!die_on_error); /* should die in unable_to_lock_die() */
+		return pidfile_path;
+	}
 	if (!force) {
 		static char locking_host[HOST_NAME_MAX + 1];
 		static char *scan_fmt;
@@ -533,7 +537,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int auto_gc = 0;
 	int quiet = -1;
 	int force = 0;
-	const char *name;
+	const char *name = NULL;
 	pid_t pid;
 	int daemonized = 0;
 	int keep_base_pack = -1;
@@ -599,6 +603,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
+		if (lock_repo_for_gc(force, &pid, 0))
+			return 0;
 		if (!quiet) {
 			if (detach_auto)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
@@ -616,8 +622,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 				/* Last gc --auto failed. Skip this one. */
 				return 0;
 
-			if (lock_repo_for_gc(force, &pid))
-				return 0;
 			gc_before_repack(); /* dies on failure */
 			git_test_sleep("GIT_TEST_GC_SLEEP_PRE_FORK");
 			delete_tempfile(&pidfile);
@@ -644,7 +648,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		string_list_clear(&keep_pack, 0);
 	}
 
-	name = lock_repo_for_gc(force, &pid);
+	if (!pidfile)
+		name = lock_repo_for_gc(force, &pid, 1);
 	if (name) {
 		if (auto_gc)
 			return 0; /* be quiet on --auto */
diff --git a/lockfile.c b/lockfile.c
index 8e8ab4f29f..2a86d3a656 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -173,6 +173,8 @@ int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
 				      int flags, long timeout_ms)
 {
 	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
+	if (flags & LOCK_QUIET_ON_ERROR)
+		return fd;
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
diff --git a/lockfile.h b/lockfile.h
index 9843053ce8..dc366d70cc 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -135,10 +135,16 @@ struct lock_file {
 
 /*
  * ... this flag can be passed instead to return -1 and give the usual
- * error message upon an error.
+ * error message upon an error, or ...
  */
 #define LOCK_REPORT_ON_ERROR 4
 
+/*
+ * ... just be quiet and let the caller handle it by checking the
+ * return return value.
+ */
+#define LOCK_QUIET_ON_ERROR 8
+
 /*
  * Usually symbolic links in the destination path are resolved. This
  * means that (1) the lockfile is created by adding ".lock" to the
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 363ca18980..4dea98f1c3 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -175,14 +175,14 @@ test_racy_gc_auto () {
 	"
 }
 
-test_racy_gc_auto failure false N/A N/A N/A
+test_racy_gc_auto success false N/A N/A N/A
 for fork_works in true false
 do
 	for sleep_before_fork in 0 1
 	do
 		for sleep_before_fork_no_lock in 0 1
 		do
-			test_racy_gc_auto failure true $sleep_before_fork $sleep_before_fork_no_lock $fork_works
+			test_racy_gc_auto success true $sleep_before_fork $sleep_before_fork_no_lock $fork_works
 		done
 	done
 done
@@ -204,8 +204,8 @@ test_racy_faked_gc_auto () {
 		test_line_count = 0 errors
 	"
 }
-test_racy_faked_gc_auto failure true
-test_racy_faked_gc_auto failure false
+test_racy_faked_gc_auto success true
+test_racy_faked_gc_auto success false
 
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
-- 
2.22.0.rc1.257.g3120a18244

