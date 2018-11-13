Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CBA1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbeKNGTD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 01:19:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGTD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 01:19:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so1895631wrt.13
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13YL4DxiyS7Z8KHCpH39lTIEGjUwAr1AFJg7SwK+v8M=;
        b=Qw6JBhoK0/EVLp9+suVinJ4kQmrv5a47zheYnXa55hl1it3kRfoEimxq/ss1lQW7y1
         CYrh7O1mCDaeqClcn5hqBWCun/lQvnlTtKaQG6TeuxaDN7/rZLile217WAgHmoqanGMr
         u4xnhDirrq0toUY/6gj9zvn/qHQ/B/8+JN7zCxI6Nh9dl9C61GEbqR77V/hFwt6dii0w
         mFiDKeNG7i3Y7zMYU/e5tAw0vLso5rcxSWpLilQYgpEuRA3QjS8XlvtyEEtfz3Uq4Vi+
         vJEzLgBMoFukPBI2/S7um39Rxdd8ifqwDyk1Jjrk2jWWXtw+JqF9xHc40uvbU2dOsuy8
         jX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13YL4DxiyS7Z8KHCpH39lTIEGjUwAr1AFJg7SwK+v8M=;
        b=QBZ0zwBUJFgdzrIdHzjCTCcgTKeHBuWUNTsEn8zzP7BBi374w2kmXbYp9YVQXm+gxt
         ow2Ntqqr73OT46jBx9wOnlQZRCya31YqXqEtqII2AZIaJTst8+ammZ0EnaTAUjRtutos
         8HidSWCay032iSISYFoR5ZCztEdbnCa0cCT1LlwRGKLRyurrjW+mBqVeoqMRf/4ZBtiz
         WI4RMIKDz8n+YnmHVuz/jLGLqxiu5xetyYdNF28PcLKs7j/qGCaq7nai4oYLGy5qkzDu
         P5HJ2UF9dJM8JswLkxJvtZNLx6ZGPxvLYQHLl0vfb0ubnKGxpWlvWodZtQnjoOoHK26e
         vDtA==
X-Gm-Message-State: AGRZ1gIkq+pz0g5S4M6J5Lprcvy80/InTRRge6u6KlQN6+/+7FnTzRlY
        GwPTEC1DKT9zzcLmaYgzWnL2UddBtYk=
X-Google-Smtp-Source: AJdET5dPuLRakEewJsjsmYyOA0FgF43PNiOtNdoVNJV7YZ3OwqVj327LBRrgCWzDIRimCgkvYqRnqA==
X-Received: by 2002:adf:ffc9:: with SMTP id x9-v6mr6306991wrs.73.1542140354978;
        Tue, 13 Nov 2018 12:19:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l17-v6sm13953357wrb.86.2018.11.13.12.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:19:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] index-pack: add ability to disable SHA-1 collision check
Date:   Tue, 13 Nov 2018 20:19:10 +0000
Message-Id: <20181113201910.11518-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181030184331.27264-1-avarab@gmail.com>
References: <20181030184331.27264-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new core.checkCollisions setting. On by default, it can be set
to 'false' to disable the check for existing objects in sha1_object().

As noted in the documentation being added here this is done out of
paranoia about future SHA-1 collisions and as a canary (redundant to
"git fsck") for local object corruption.

For the history of SHA-1 collision checking see:

 - 5c2a7fbc36 ("[PATCH] SHA1 naive collision checking", 2005-04-13)

 - f864ba7448 ("Fix read-cache.c collission check logic.", 2005-04-13)

 - aac1794132 ("Improve sha1 object file writing.", 2005-05-03)

 - 8685da4256 ("don't ever allow SHA1 collisions to exist by fetching
   a pack", 2007-03-20)

 - 1421c5f274 ("write_loose_object: don't bother trying to read an old
   object", 2008-06-16)

 - 51054177b3 ("index-pack: detect local corruption in collision
   check", 2017-04-01)

As seen when going through that history there used to be a way to turn
this off at compile-time by using -DCOLLISION_CHECK=0 option (see
f864ba7448), but this check later went away in favor of general "don't
write if exists" logic for loose objects, and was then brought back
for remotely fetched packs in 8685da4256.

I plan to turn this off by default in my own settings since I'll
appreciate the performance improvement, and because I think worrying
about SHA-1 collisions is insane paranoia. But others might disagree,
so the check is still on by default.

Also add a "GIT_TEST_CHECK_COLLISIONS" setting so the entire test
suite can be exercised with the collision check turned off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now that the v2 where I peeled of this patch (just the tests) has
landed here's a re-submission of the core.checkCollisions knob.

As noted in
https://public-inbox.org/git/878t1x2t3e.fsf@evledraar.gmail.com/ and
related messages this has a great impact on performance, and I'm
already using this in production, and for the reasons explained there
j ust having the loose object cache isn't enough in some scenarios.

Jeff: What do you think about the order of these going in & about the
config knob for the loose cache that I suggested in the E-Mail above?

I think it makes the most sense for this to land first, and to re-roll
the loose cache with a config knob & change to the docs here
explaining the trade-offs between the two settings and why you
would/wouldn't use them in combination.

 Documentation/config/core.txt | 68 +++++++++++++++++++++++++++++++++++
 builtin/index-pack.c          |  7 ++--
 cache.h                       |  1 +
 config.c                      | 20 +++++++++++
 config.h                      |  1 +
 environment.c                 |  1 +
 t/README                      |  3 ++
 t/t1060-object-corruption.sh  | 33 +++++++++++++++++
 t/t5300-pack-object.sh        | 10 ++++--
 9 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..1f5c891ccf 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -88,6 +88,74 @@ core.untrackedCache::
 	properly on your system.
 	See linkgit:git-update-index[1]. `keep` by default.
 
+core.checkCollisions::
+	When missing or set to `default` Git will assert when writing
+	a given object that it doesn't exist already anywhere else in
+	the object store (also accounting for
+	`GIT_ALTERNATE_OBJECT_DIRECTORIES` et al, see
+	linkgit:git[1]).
++
+The reasons for why this is on by default are:
++
+--
+. If there's ever a new SHA-1 collision attack similar to the
+  SHAttered attack (see https://shattered.io) Git can't be fooled into
+  replacing an existing known-good object with a new one with the same
+  SHA-1.
++
+Note that Git by default is built with a hardened version of SHA-1
+function with collision detection for attacks like the SHAttered
+attack (see link:technical/hash-function-transition.html[the hash
+function transition documentation]), but new future attacks might not
+be detected by the hardened SHA-1 code.
+
+. It serves as a canary for detecting some instances of repository
+  corruption. The type and size of the existing and new objects are
+  compared, if they differ Git will panic and abort. This can happen
+  e.g. if a loose object's content has been truncated or otherwise
+  mangled by filesystem corruption.
+--
++
+The reasons to disable this are, respectively:
++
+--
+. Doing the "does this object exist already?" check can be expensive,
+  and it's always cheaper to do nothing.
++
+Even on a very fast local disk (e.g. SSD) cloning a repository like
+git.git spends around 5% of its time just in `lstat()`. This
+percentage can get much higher (up to even hundreds of percents!) on
+network filesystems like NFS where metadata operations can be much
+slower.
++
+This is because with the collision check every object in an incoming
+packfile must be checked against any existing packfiles, as well as
+the loose object store (most of the `lstat()` time is spent on the
+latter). Git doesn't guarantee that some concurrent process isn't
+writing to the same repository during a `clone`. The same sort of
+slowdowns can be seen when doing a big fetch (lots of objects to write
+out).
+
+. If you have a corrupt local repository this check can prevent
+  repairing it by fetching a known-good version of the same object
+  from a remote repository. See the "repair a corrupted repo with
+  index-pack" test in the `t1060-object-corruption.sh` test in the git
+  source code.
+--
++
+Consider turning this off if you're more concerned about performance
+than you are about hypothetical future SHA-1 collisions or object
+corruption (linkgit:git-fsck[1] will also catch object
+corruption). This setting can also be disabled during specific
+phases/commands that can be bottlenecks, e.g. with `git -c
+core.checkCollisions=false clone [...]` for an initial clone on NFS.
++
+Setting this to `false` will disable object collision
+checking. I.e. the value can either be "default" or a boolean. Other
+values might be added in the future (e.g. for selectively disabling
+this just for "clone"), but now any non-boolean non-"default" values
+error out.
+
 core.checkStat::
 	When missing or is set to `default`, many fields in the stat
 	structure are checked to detect if a file has been modified
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..4a3508aa9f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -791,23 +791,24 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 {
 	void *new_data = NULL;
 	int collision_test_needed = 0;
+	int do_coll_check = git_config_get_collision_check();
 
 	assert(data || obj_entry);
 
-	if (startup_info->have_repository) {
+	if (do_coll_check && startup_info->have_repository) {
 		read_lock();
 		collision_test_needed =
 			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
 		read_unlock();
 	}
 
-	if (collision_test_needed && !data) {
+	if (do_coll_check && collision_test_needed && !data) {
 		read_lock();
 		if (!check_collison(obj_entry))
 			collision_test_needed = 0;
 		read_unlock();
 	}
-	if (collision_test_needed) {
+	if (do_coll_check && collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
diff --git a/cache.h b/cache.h
index ca36b44ee0..a5f215f1fc 100644
--- a/cache.h
+++ b/cache.h
@@ -863,6 +863,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int check_collisions;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/config.c b/config.c
index 2ffd39c220..641d0c537f 100644
--- a/config.c
+++ b/config.c
@@ -1354,6 +1354,14 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkcollisions")) {
+		if (!strcasecmp(value, "default"))
+			check_collisions = 1;
+		else
+			check_collisions = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
@@ -2310,6 +2318,18 @@ int git_config_get_index_threads(void)
 	return 0; /* auto */
 }
 
+int git_config_get_collision_check(void)
+{
+	static int checked_env = 0;
+	if (!checked_env) {
+		int v = git_env_bool("GIT_TEST_CHECK_COLLISIONS", -1);
+		checked_env = 1;
+		if (v != -1)
+			check_collisions = v;
+	}
+	return check_collisions;
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index a06027e69b..4c6f6d9ae4 100644
--- a/config.h
+++ b/config.h
@@ -251,6 +251,7 @@ extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
 extern int git_config_get_index_threads(void);
+extern int git_config_get_collision_check(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/environment.c b/environment.c
index 3465597707..4a55a1f05f 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
+int check_collisions = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
diff --git a/t/README b/t/README
index 242497455f..1862a30279 100644
--- a/t/README
+++ b/t/README
@@ -348,6 +348,9 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_CHECK_COLLISIONS=<boolean> excercises the
+core.checkCollisions=false codepath.
+
 Naming Tests
 ------------
 
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 4feb65157d..87e395d2ba 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -117,6 +117,7 @@ test_expect_failure 'clone --local detects misnamed objects' '
 '
 
 test_expect_success 'fetch into corrupted repo with index-pack' '
+	sane_unset GIT_TEST_CHECK_COLLISIONS &&
 	cp -R bit-error bit-error-cp &&
 	test_when_finished "rm -rf bit-error-cp" &&
 	(
@@ -127,4 +128,36 @@ test_expect_success 'fetch into corrupted repo with index-pack' '
 	)
 '
 
+test_expect_success 'repair a corrupted repo with index-pack' '
+	sane_unset GIT_TEST_CHECK_COLLISIONS &&
+	cp -R bit-error bit-error-cp &&
+	test_when_finished "rm -rf bit-error-cp" &&
+	(
+		cd bit-error-cp &&
+
+		# Have the corrupt object still and fsck complains
+		test_must_fail git cat-file blob HEAD:content.t &&
+		test_must_fail git fsck 2>stderr &&
+		test_i18ngrep "corrupt or missing" stderr &&
+
+		# Fetch the new object (as a pack). The transfer.unpackLimit=1
+		# setting here is important, we must end up with a pack, not a
+		# loose object. The latter would fail due to "exists? Do not
+		# bother" semantics unrelated to the collision check.
+		git -c transfer.unpackLimit=1 \
+			-c core.checkCollisions=false \
+			fetch ../no-bit-error 2>stderr &&
+
+		# fsck still complains, but we have the non-corrupt object
+		# (we lookup in packs first)
+		test_must_fail git fsck 2>stderr &&
+		test_i18ngrep "corrupt or missing" stderr &&
+		git cat-file blob HEAD:content.t &&
+
+		# A "gc" will remove the now-redundant and corrupt object
+		git gc &&
+		git fsck
+	)
+'
+
 test_done
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 410a09b0dd..ca109fff84 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -481,18 +481,22 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
 '
 
 test_expect_success 'make sure index-pack detects the SHA1 collision' '
+	sane_unset GIT_TEST_CHECK_COLLISIONS &&
 	(
 		cd corrupt &&
-		test_must_fail git index-pack -o ../bad.idx ../test-3.pack 2>msg &&
-		test_i18ngrep "SHA1 COLLISION FOUND" msg
+		test_must_fail git index-pack -o good.idx ../test-3.pack 2>msg &&
+		test_i18ngrep "SHA1 COLLISION FOUND" msg &&
+		git -c core.checkCollisions=false index-pack -o good.idx ../test-3.pack
 	)
 '
 
 test_expect_success 'make sure index-pack detects the SHA1 collision (large blobs)' '
+	sane_unset GIT_TEST_CHECK_COLLISIONS &&
 	(
 		cd corrupt &&
 		test_must_fail git -c core.bigfilethreshold=1 index-pack -o ../bad.idx ../test-3.pack 2>msg &&
-		test_i18ngrep "SHA1 COLLISION FOUND" msg
+		test_i18ngrep "SHA1 COLLISION FOUND" msg &&
+		git -c core.checkCollisions=false -c core.bigfilethreshold=1 index-pack -o good.idx ../test-3.pack
 	)
 '
 
-- 
2.19.1.1182.g4ecb1133ce

