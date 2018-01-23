Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DB41F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeAWWOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44442 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbeAWWOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:14:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id t74so4775758wme.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aYTEO0/gTg9Sl/aSrWuKC6ynp3mIjU05Uty1S1biBvo=;
        b=n1oH5XNl/hMIudxsW9EqD6oRF8Gke1SNAKHfOS3J/0Q4utv2D7mQC7AMKP24pD5G1B
         KOeIs8sKJpzT2qK9ZRxnXmi6w9a9tW4DwQbCpvLNEX4JEbJz6yP3kDJaMSZs9rIoow6V
         JqzAZmpUQX+Unoh223hvMXiCo0hOiCGndOEWG3zFnGwAOCFfFOJ9Y0Teb/qiWf++K5tj
         jwLxFcSL4xsnEYDFFXz9Q21uee24c+E4WLw7lCC+1yi121NIT/SywlOZP4PGn2bTD7eV
         OYwNnPfQZ9xC9hMqcOOgdDkqJh4H9+YSD8+JD17kVBIg0MVuUL5acfg/AjUVwo7wDvbV
         +QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aYTEO0/gTg9Sl/aSrWuKC6ynp3mIjU05Uty1S1biBvo=;
        b=egYurg4M9zbraU07X+QF2EI/gikgrHr1PHulGFlJqugESLmD1rNKxEodUow+jLghWq
         0bToFzEQr0aBPUhxsb+jS2iaRoqHp9AnmP0uGYPI9ohKmKWQv7N/bA3xzFXpY29eEVXF
         g+a/ydLVZWwjwrSubMmXgsqhvIyFL/Xey39qsORm76ch8dzEL8PKUKOgcTlAKyrN0YCH
         tapL1jtRy44aFPWQUNuR0v3HcK47/8+deEK9YEJAcVmDBPV+Y8g88hBUx8eNb85+w9wG
         y//nMMWI029MWfzTcvrUfQsgEOcdTKTRWFn74xkp6fgWdcncd8VAsjMaMY4aGXi7KV2k
         1yIQ==
X-Gm-Message-State: AKwxytfWUv+gsZmsaUeS/UqEw4QKDkG2bShhPlpmCjDbjtC/T521ZkoO
        SjtJIDPIKYSUFOoVzYUxQq6NFbFY
X-Google-Smtp-Source: AH8x225vpftkRHEi6ckLIovXflxG2fMeqc25nLzuIiufiMMX5kJnWwCSnNiajYSsa/wb2cUp6Zn/XA==
X-Received: by 10.80.137.164 with SMTP id g33mr21178953edg.261.1516745646512;
        Tue, 23 Jan 2018 14:14:06 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:14:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/11] fetch: add a --fetch-prune option and fetch.pruneTags config
Date:   Tue, 23 Jan 2018 22:13:26 +0000
Message-Id: <20180123221326.28495-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
config option. This allows for doing any of:

    git fetch -p -P
    git fetch --prune --prune-tags
    git fetch -p -P origin
    git fetch --prune --prune-tags origin

Or simply:

    git config fetch.prune true &&
    git config fetch.pruneTags true &&
    git fetch

Instead of the much more verbose:

    git fetch --prune origin '+refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'

Before this feature it was painful to support the use-case of pulling
from a repo which is having both its branches *and* tags deleted
regularly, and have our local references to reflect upstream.

At work we create deployment tags in the repo for each rollout, and
there's *lots* of those, so they're archived within weeks for
performance reasons.

Without this change it's hard to centrally configure such repos in
/etc/gitconfig (on servers that are only used for working with
them). You need to set fetch.prune=true globally, and then for each
repo:

    git -C {} config --replace-all remote.origin.fetch "+refs/tags/*:refs/tags/*" "^\+*refs/tags/\*:refs/tags/\*$"

Now I can simply set fetch.pruneTags=true in /etc/gitconfig as well,
and users running "git pull" will automatically get the pruning
semantics I want.

Even though "git remote" has corresponding "prune" and "update
--prune" subcommands I'm intentionally not adding a corresponding
prune-tags or "update --prune --prune-tags" mode to that command.

It's advertised (as noted in my recent "git remote doc: correct
dangerous lies about what prune does") as only modifying remote
tracking references, whereas any --prune-tags option is always going
to modify what from the user's perspective is a local copy of the tag,
since there's no such thing as a remote tracking tag.

See my "Re: [BUG] git remote prune removes local tags, depending on
fetch config" (87po6ahx87.fsf@evledraar.gmail.com;
https://public-inbox.org/git/87po6ahx87.fsf@evledraar.gmail.com/) for
more background info.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt               | 14 ++++++++++++++
 Documentation/fetch-options.txt        | 15 ++++++++++++++-
 Documentation/git-fetch.txt            | 27 +++++++++++++++++++++++++++
 builtin/fetch.c                        | 32 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 remote.c                               |  5 ++++-
 remote.h                               |  3 +++
 t/t5510-fetch.sh                       | 30 ++++++++++++++++++++++++++++++
 8 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f27af5760..ae86455876 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1401,6 +1401,14 @@ fetch.prune::
 	option was given on the command line.  See also `remote.<name>.prune`
 	and the PRUNING section of linkgit:git-fetch[1].
 
+fetch.pruneTags::
+	If true, fetch will automatically behave as if the
+	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
+	if not set already. This allows for setting both this option
+	and `fetch.prune` to maintain a 1=1 mapping to upstrem
+	refs. See also `remote.<name>.pruneTags` and the PRUNING
+	section of linkgit:git-fetch[1].
+
 fetch.output::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See section
@@ -2945,6 +2953,12 @@ remote.<name>.prune::
 	remove any remote-tracking references that no longer exist on the
 	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
+
+remote.<name>.pruneTags::
+	When set to true, fetching from this remote by default will also
+	remove any local tags that no longer exist on the remote if pruning
+	is activated in general via `remote.<name>.prune`, `fetch.prune` or
+	`--prune`. Overrides `fetch.pruneTags` settings, if any.
 +
 See also `remote.<name>.prune` and the PRUNING section of
 linkgit:git-fetch[1].
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9f5c85ad96..dc13bed741 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -73,7 +73,20 @@ ifndef::git-pull[]
 	are fetched due to an explicit refspec (either on the command
 	line or in the remote configuration, for example if the remote
 	was cloned with the --mirror option), then they are also
-	subject to pruning.
+	subject to pruning. Supplying `--prune-tags` is a shorthand for
+	providing the tag refspec.
++
+See the PRUNING section below for more details.
+
+-P::
+--prune-tags::
+	Before fetching, remove any local tags that no longer exist on
+	the remote if `--prune` is enabled. This option should be used
+	more carefully, unlike `--prune` it will remove any local
+	references (local tags) that have been created. This option is
+	merely a shorthand for providing the explicit tag refspec
+	along with `--prune`, see the discussion about that in its
+	documentation.
 +
 See the PRUNING section below for more details.
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 18fac0da2e..cdde6c50df 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -148,6 +148,33 @@ So be careful when using this with a refspec like
 `refs/tags/*:refs/tags/*`, or any other refspec which might map
 references from multiple remotes to the same local namespace.
 
+Since keeping up-to-date with both branches and tags on the remote is
+a common use-case the `--prune-tags` option can be supplied along with
+`--prune` to prune local tags that don't exist on the remote, and
+force-update those tags that differ. Tag pruning can also be enabled
+with `fetch.pruneTags` or `remote.<name>.pruneTags` in the config. See
+linkgit:git-config[1].
+
+The `--prune-tags` option is equivalent to having
+`+refs/tags/*:refs/tags/*` declared in the refspecs of the
+remote. This can lead to some seemingly strange interactions:
+
+------------------------------------------------
+# These both fetch tags
+$ git fetch --no-tags origin '+refs/tags/*:refs/tags/*'
+$ git fetch --no-tags --prune-tags origin
+------------------------------------------------
+
+The reason it doesn't error out when provided without `--prune` or its
+config versions is for flexibility of the configured versions, and to
+maintain a 1=1 mapping between what the command line flags do, and
+what the configuration versions do.
+
+It's reasonable to e.g. configure `fetch.pruneTags=true` in
+`~/.gitconfig` to have tags pruned whenever `git fetch --prune` is
+run, without making every invocation of `git fetch` without `--prune`
+an error.
+
 OUTPUT
 ------
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a85c2002a9..0c898e64a8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -38,6 +38,10 @@ static int fetch_prune_config = -1; /* unspecified */
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
+static int fetch_prune_tags_config = -1; /* unspecified */
+static int prune_tags = -1; /* unspecified */
+#define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
+
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
 static int progress = -1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
@@ -64,6 +68,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.prunetags")) {
+		fetch_prune_tags_config = git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "submodule.recurse")) {
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -126,6 +135,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
+	OPT_BOOL('P', "prune-tags", &prune_tags,
+		 N_("prune local tags no longer on remote and clobber changed tags")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
@@ -1212,6 +1223,8 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "--dry-run");
 	if (prune != -1)
 		argv_array_push(argv, prune ? "--prune" : "--no-prune");
+	if (prune_tags != -1)
+		argv_array_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
 	if (force)
@@ -1315,6 +1328,22 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	return exit_code;
 }
 
+static void maybe_add_prune_tags_refspec(struct remote *remote)
+{
+	if (prune_tags < 0) {
+		/* no command line request */
+		if (0 <= remote->prune_tags)
+			prune_tags = remote->prune_tags;
+		else if (0 <= fetch_prune_tags_config)
+			prune_tags = fetch_prune_tags_config;
+		else
+			prune_tags = PRUNE_TAGS_BY_DEFAULT;
+	}
+
+	if (prune_tags)
+		add_fetch_refspec(remote, xstrdup("+refs/tags/*:refs/tags/*"));
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -1368,6 +1397,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
+		maybe_add_prune_tags_refspec(remote);
 		result = fetch_one(remote, argc, argv);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
@@ -1386,6 +1416,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
+			if (argc == 1)
+				maybe_add_prune_tags_refspec(remote);
 			result = fetch_one(remote, argc-1, argv+1);
 		}
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..4ecd0d4d7a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1468,7 +1468,7 @@ __git_fetch_recurse_submodules="yes on-demand no"
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags --all --prune --dry-run --recurse-submodules=
-	--unshallow --update-shallow
+	--unshallow --update-shallow --prune-tags
 "
 
 _git_fetch ()
diff --git a/remote.c b/remote.c
index 4e93753e19..d8716643cb 100644
--- a/remote.c
+++ b/remote.c
@@ -95,7 +95,7 @@ static void add_push_refspec(struct remote *remote, const char *ref)
 	remote->push_refspec[remote->push_refspec_nr++] = ref;
 }
 
-static void add_fetch_refspec(struct remote *remote, const char *ref)
+void add_fetch_refspec(struct remote *remote, const char *ref)
 {
 	ALLOC_GROW(remote->fetch_refspec,
 		   remote->fetch_refspec_nr + 1,
@@ -173,6 +173,7 @@ static struct remote *make_remote(const char *name, int len)
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
+	ret->prune_tags = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	ret->name = xstrndup(name, len);
@@ -391,6 +392,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prune"))
 		remote->prune = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prunetags"))
+		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index 1f6611be21..df6dca24d4 100644
--- a/remote.h
+++ b/remote.h
@@ -47,6 +47,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int prune_tags;
 
 	const char *receivepack;
 	const char *uploadpack;
@@ -133,6 +134,8 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
+void add_fetch_refspec(struct remote *remote, const char *ref);
+
 extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 struct ref *alloc_ref(const char *name);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 840fd5ef02..1bca9d0bd2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -662,6 +662,36 @@ test_configured_prune true  true  unset unset kept   pruned \
 test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
+
+# --prune-tags on its own does nothing, needs --prune as well, same
+# for for fetch.pruneTags without fetch.prune
+test_configured_prune unset unset unset unset kept kept     "--prune-tags"
+test_configured_prune unset unset unset unset kept kept     "origin --prune-tags"
+test_configured_prune unset unset true unset  kept kept     ""
+test_configured_prune unset unset unset true  kept kept     ""
+
+# These will prune the tags
+test_configured_prune unset unset unset unset pruned pruned "--prune --prune-tags"
+test_configured_prune unset unset unset unset pruned pruned "origin --prune --prune-tags"
+test_configured_prune true  unset true  unset pruned pruned ""
+test_configured_prune unset true  unset true  pruned pruned ""
+
+# Check that remote.<name>.pruneTags overrides fetch.pruneTags as with
+# remote.<name>.prune and fetch.prune
+test_configured_prune false true  false true  pruned pruned ""
+test_configured_prune true  false true  false kept   kept   ""
+
+# When --prune-tags is supplied it's ignored if an explict refspec is
+# given, same for the configuration options.
+test_configured_prune unset unset unset unset pruned kept \
+	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
+test_configured_prune unset unset true  unset pruned kept \
+	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
+test_configured_prune unset unset unset true pruned  kept \
+	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
+
+test_configured_prune true unset true unset pruned pruned   ""
+
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
 	test_commit oneside &&
-- 
2.15.1.424.g9478a66081

