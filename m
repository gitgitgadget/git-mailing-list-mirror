Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE491F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBHQUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:37 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40043 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeBHQUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:32 -0500
Received: by mail-wm0-f49.google.com with SMTP id v123so11042749wmd.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DKojrFGPZP95lCIG9S25bxwUpGD+31p+JnJDQIglURU=;
        b=gjS3R22Av6XH7f2fAvMdI6susgrVyFR47cVp2INc6OCXLm/wu2AlwOoHfNGAyjaJv0
         1t2vA8TKqYAGR4siYHK/hq5oBLD23B2y5eP4rBmkBDx6agSVtYKu+ItjjCT1d/tS1DuS
         c5K8AZimExTBbfUAjzy+byBEyRhkHuW/ou3Id8Uxv2YZG/FFX9BGItjJi5qsF/QWtK9L
         X1uQzYvqWKGAxOuSMczGa8N/33PKuB+dASuZh3ZSFlLNppAo9051hYLT8lsbdOQ/3fXG
         dssgFQWJ4wW8SRR8R1BbjPaVclXkbLl37rJbrKyEFiRh10QtXxXDU1IB5TRQLegJYSHY
         Tnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DKojrFGPZP95lCIG9S25bxwUpGD+31p+JnJDQIglURU=;
        b=RDYoWMCQJi90zacjHdsBTEBkaFBQsInlfHMTMnmu1kEy4pRA1BSfSYCBqBVQ+Fr5PP
         tNwUtu0yGLrNok9b7B2K1Tt5jQ85yauCCk9pnT1xVKlPMMJ4t6+INIFDkjRaoSuvULty
         dULVvcw++okTSA40XErj5hOaYXivJc7ZSwdPstLUOCXwqtGRbjazUii4x0HZ/hV6VnAO
         /UuXANURB1/luBUy2wOS9lYsm2kxI8a+DIYRuDg47+jIZS4Rlsv2IJ55MTxXzX3YhCrk
         smi7w8sbRaoiHHsmUVz7B6TCJMqaW/Ys7EvcPnSPXQstyhepo9MVTedGdst12eSzbnuL
         7cvQ==
X-Gm-Message-State: APf1xPAkouuSaGyns1a0dGcrNeetcjQYe+1vABszsbAqDPdNy74vOcYp
        pDqFXQyZRZTv56Z08yfcJNgT9yS3
X-Google-Smtp-Source: AH8x224qaAXU/LqyZnA4RdpmYrUf9xJ8VNGjmA0Dh5iavmHU4/0O83Gskn9ewg4HH3n/vd/Szq1xHw==
X-Received: by 10.28.148.214 with SMTP id w205mr1522461wmd.67.1518106830107;
        Thu, 08 Feb 2018 08:20:30 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/17] fetch: add a --fetch-prune option and fetch.pruneTags config
Date:   Thu,  8 Feb 2018 16:19:35 +0000
Message-Id: <20180208161936.8196-17-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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

    git fetch --prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'

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

    git -C {} config --replace-all remote.origin.fetch "refs/tags/*:refs/tags/*" "^\+*refs/tags/\*:refs/tags/\*$"

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

Ideally add_prune_tags_to_fetch_refspec() would be something that
would use ALLOC_GROW() to grow the 'fetch` member of the 'remote'
struct. Instead I'm realloc-ing remote->fetch and adding the
tag_refspec to the end.

The reason is that parse_{fetch,push}_refspec which allocate the
refspec (ultimately remote->fetch) struct are called many places that
don't have access to a 'remote' struct. It would be hard to change all
their callsites to be amenable to carry around the bookkeeping
variables required for dynamic allocation.

All the other callers of the API first incrementally construct the
string version of the refspec in remote->fetch_refspec via
add_fetch_refspec(), before finally calling parse_fetch_refspec() via
some variation of remote_get().

It's less of a pain to deal with the one special case that needs to
modify already constructed refspecs than to chase down and change all
the other callsites. The API I'm adding is intentionally not
generalized because if we add more of these we'd probably want to
re-visit how this is done.

See my "Re: [BUG] git remote prune removes local tags, depending on
fetch config" (87po6ahx87.fsf@evledraar.gmail.com;
https://public-inbox.org/git/87po6ahx87.fsf@evledraar.gmail.com/) for
more background info.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt               | 14 +++++++
 Documentation/fetch-options.txt        | 14 ++++++-
 Documentation/git-fetch.txt            | 47 +++++++++++++++++++++++
 builtin/fetch.c                        | 32 ++++++++++++++--
 contrib/completion/git-completion.bash |  2 +-
 remote.c                               | 14 +++++++
 remote.h                               |  3 ++
 t/t5510-fetch.sh                       | 69 ++++++++++++++++++++++++++++++++++
 8 files changed, 190 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f27af5760..e254bfd531 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1401,6 +1401,14 @@ fetch.prune::
 	option was given on the command line.  See also `remote.<name>.prune`
 	and the PRUNING section of linkgit:git-fetch[1].
 
+fetch.pruneTags::
+	If true, fetch will automatically behave as if the
+	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
+	if not set already. This allows for setting both this option
+	and `fetch.prune` to maintain a 1=1 mapping to upstream
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
index 9f5c85ad96..8631e365f4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -73,7 +73,19 @@ ifndef::git-pull[]
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
+	a shorthand for providing the explicit tag refspec along with
+	`--prune`, see the discussion about that in its documentation.
 +
 See the PRUNING section below for more details.
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 18fac0da2e..574206d139 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -148,6 +148,53 @@ So be careful when using this with a refspec like
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
+`refs/tags/*:refs/tags/*` declared in the refspecs of the remote. This
+can lead to some seemingly strange interactions:
+
+------------------------------------------------
+# These both fetch tags
+$ git fetch --no-tags origin 'refs/tags/*:refs/tags/*'
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
+Another special case of `--prune-tags` is that
+`refs/tags/*:refs/tags/*` will not be implicitly provided if an URL is
+being fetched. I.e.:
+
+------------------------------------------------
+$ git fetch <url> --prune --prune-tags
+------------------------------------------------
+
+Will prune no tags, as opposed to:
+
+------------------------------------------------
+$ git fetch origin --prune --prune-tags
+------------------------------------------------
+
+To prune tags given a URL supply the refspec explicitly:
+
+------------------------------------------------
+$ git fetch <url> --prune 'refs/tags/*:refs/tags/*'
+------------------------------------------------
+
 OUTPUT
 ------
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a7705bc150..55a0fc37be 100644
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
@@ -1265,7 +1278,7 @@ static int fetch_multiple(struct string_list *list)
 	return result;
 }
 
-static int fetch_one(struct remote *remote, int argc, const char **argv)
+static int fetch_one(struct remote *remote, int argc, const char **argv, int prune_tags_ok)
 {
 	static const char **refs = NULL;
 	struct refspec *refspec;
@@ -1288,6 +1301,19 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			prune = PRUNE_BY_DEFAULT;
 	}
 
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
+	if (prune_tags_ok && prune_tags && remote_is_configured(remote, 0))
+		add_prune_tags_to_fetch_refspec(remote);
+
 	if (argc > 0) {
 		int j = 0;
 		int i;
@@ -1368,7 +1394,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
-		result = fetch_one(remote, argc, argv);
+		result = fetch_one(remote, argc, argv, 1);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
 		for (i = 0; i < argc; i++)
@@ -1386,7 +1412,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
-			result = fetch_one(remote, argc-1, argv+1);
+			result = fetch_one(remote, argc-1, argv+1, argc == 1);
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
index 356c123e3e..d670eed4c4 100644
--- a/remote.c
+++ b/remote.c
@@ -104,6 +104,17 @@ static void add_fetch_refspec(struct remote *remote, const char *ref)
 	remote->fetch_refspec[remote->fetch_refspec_nr++] = ref;
 }
 
+void add_prune_tags_to_fetch_refspec(struct remote *remote)
+{
+	int nr = remote->fetch_refspec_nr;
+	int bufsize = nr  + 1;
+	int size = sizeof(struct refspec);
+
+	remote->fetch = xrealloc(remote->fetch, size  * bufsize);
+	memcpy(&remote->fetch[nr], tag_refspec, size);
+	add_fetch_refspec(remote, xstrdup(TAG_REFSPEC));
+}
+
 static void add_url(struct remote *remote, const char *url)
 {
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
@@ -174,6 +185,7 @@ static struct remote *make_remote(const char *name, int len)
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
+	ret->prune_tags = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	ret->name = xstrndup(name, len);
@@ -392,6 +404,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prune"))
 		remote->prune = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prunetags"))
+		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index 80fea6dd11..271afe1bab 100644
--- a/remote.h
+++ b/remote.h
@@ -47,6 +47,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int prune_tags;
 
 	const char *receivepack;
 	const char *uploadpack;
@@ -299,4 +300,6 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
 
+void add_prune_tags_to_fetch_refspec(struct remote *remote);
+
 #endif
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 501d15dd42..6f3ab7695a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -592,6 +592,15 @@ test_configured_prune_type () {
 			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
 		fi
 
+		if test "$fetch_prune_tags" = 'true' ||
+		   test "$remote_origin_prune_tags" = 'true'
+		then
+			if ! printf '%s' "$cmdline" | grep -q refs/remotes/origin/
+			then
+				new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
+			fi
+		fi
+
 		cmdline="$new_cmdline"
 	fi
 
@@ -705,6 +714,66 @@ test_configured_prune true  true  unset unset kept   pruned \
 test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
+# --prune-tags on its own does nothing, needs --prune as well, same
+# for for fetch.pruneTags without fetch.prune
+test_configured_prune unset unset unset unset kept kept     "--prune-tags"
+test_configured_prune unset unset true unset  kept kept     ""
+test_configured_prune unset unset unset true  kept kept     ""
+
+# These will prune the tags
+test_configured_prune unset unset unset unset pruned pruned "--prune --prune-tags"
+test_configured_prune true  unset true  unset pruned pruned ""
+test_configured_prune unset true  unset true  pruned pruned ""
+
+# remote.<name>.pruneTags overrides fetch.pruneTags, just like
+# remote.<name>.prune overrides fetch.prune if set.
+test_configured_prune true  unset true unset pruned pruned  ""
+test_configured_prune false true  false true  pruned pruned ""
+test_configured_prune true  false true  false kept   kept   ""
+
+# When --prune-tags is supplied it's ignored if an explict refspec is
+# given, same for the configuration options.
+test_configured_prune unset unset unset unset pruned kept \
+	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
+test_configured_prune unset unset true  unset pruned kept \
+	"--prune origin +refs/heads/*:refs/remotes/origin/*"
+test_configured_prune unset unset unset true pruned  kept \
+	"--prune origin +refs/heads/*:refs/remotes/origin/*"
+
+# Pruning that also takes place if s!origin!<file:// url of remote>!,
+# or otherwise uses the file://-specific codepath. However, because
+# there's no implicit +refs/heads/*:refs/remotes/origin/* refspec and
+# supplying it on the command-line negate --prune-tags the branches
+# will not be pruned.
+test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "name"
+test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "link"
+test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
+test_configured_prune_type unset unset unset unset kept   kept   "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
+test_configured_prune_type unset unset unset unset kept   kept   "--prune --prune-tags origin" "link"
+test_configured_prune_type unset unset true  unset pruned pruned "--prune origin" "name"
+test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
+test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
+test_configured_prune_type unset unset unset true  kept   pruned "--prune origin" "link"
+test_configured_prune_type true  unset true  unset pruned pruned "origin" "name"
+test_configured_prune_type true  unset true  unset kept   pruned "origin" "link"
+test_configured_prune_type unset  true true  unset pruned pruned "origin" "name"
+test_configured_prune_type unset  true true  unset kept   pruned "origin" "link"
+test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
+test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
+
+# When all remote.origin.fetch settings are deleted a --prune
+# --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
+# tags, but not tracking branches, will be deleted.
+test_expect_success 'remove remote.origin.fetch "one"' '
+	(
+		cd one &&
+		git config --unset-all remote.origin.fetch
+	)
+'
+test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "name"
+test_configured_prune_type unset unset unset unset kept kept   "origin --prune --prune-tags" "link"
+
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
 	test_commit oneside &&
-- 
2.15.1.424.g9478a66081

