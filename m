Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C8D1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 02:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfGYCXW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 22:23:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387887AbfGYCXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 22:23:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so23872322wrr.4
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KdJnaPrElx6ZpAUay9cbhfWH3atH/uZgX+K2sJZen58=;
        b=dvQPx8EQbmscE7U/Ndjv22+Qe1YM5DRnpMIqz2GT8VrGvxLKGvXyLxlGX9rIgEh4Ws
         bwo115zxT8ZhCHcb9Ft3RTSn+GRu5mTTObMLJCb9kc06jpl+xLilI8pnD4kMv/HSscbU
         FedXcN3tYFo6mW0jmsxJigvL68CA36M55FfiU5MFbQ+EyyecMvtfSudT34w9xQ7awgrP
         wAJD5YX3mR4nFq9jms9aoHx8KAPl1GmRhEw9fBj0QUCgdmUG36a17sSFtozjIOgZssew
         KiBoV5qUgVm1mlYsD2/YkPsx1MUo/ONr0hUARNoKYaVDaujJAEcCjrxPIsnocZj3d56q
         Wslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KdJnaPrElx6ZpAUay9cbhfWH3atH/uZgX+K2sJZen58=;
        b=m+RCCknN3425tIRgmtRNMwtuxWJjJWhkJLDt4HRo5WAPpJaO9KlokANMm/UXhuDt51
         OnH9cebL5AmNknlNqJlHUCM22db6DsJV1AZLqPfbxOJ8CUK1k9hgtdYfIM75v3cDwCXM
         Se5Lw0bmxltd1KpIXpuKE52/MX3d1If21HQoN+H+nEnlxOMt9EcxcvzpBS2BC1rauf8B
         ijQsvOo4klhW0ff/YsceMBtmlCWplGUyeqfJGMzqycNSczAEqWgRbyF9gNCj3LJuganj
         tKhIL04nkR6q0q4O9K/i4bi2wm4LJnt3r53mHA+ZQlkDS5x8XQmMODXYdhA37mwLlCX3
         dVIw==
X-Gm-Message-State: APjAAAW99JhFE5mvoWOnjXDABJPaxiHqZCKhgqH70vFRN6T+PfoqIyxa
        cbn0gvUVaABfOA7lRCv3Wz7Bj/ko
X-Google-Smtp-Source: APXvYqzlrPIIGHM9RA11gUJwqVaHpFjGEiyW3A9uAaSSEFlWfAVENUPzpvEqd9P1nGCxQGrQJz+zog==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr15305611wrt.20.1564021394742;
        Wed, 24 Jul 2019 19:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm40968588wrx.84.2019.07.24.19.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:23:14 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:23:14 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 02:23:07 GMT
Message-Id: <pull.292.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/5] Create 'feature.*' config area and some centralized config parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a brand-new thread to replace ds/early-access. The discussion on
that thread was very helpful [1].

With this in mind, I propose instead a set of "feature.*" config settings
that form groups of "community recommended" settings (with some caveats). In
the space below, I'll list a set of possible feature names and the implied
config options.

First, the main two categories we've discussed so far: many commits and many
files. These two feature sets are for when your repo is large in one of
these dimensions. Perhaps there are other settings to include in these?

feature.manyFiles:
    index.version = 4
    core.untrackedCache = true

feature.manyCommits:
    core.commitGraph = true
    gc.writeCommitGraph = true
    (future: fetch.writeSplitCommitGraph = true)

Note: the fetch.writeSplitCommitGraph does not exist yet, but could be
introduced in a later release to write a new commit-graph (with --split) on
fetch.

The other category that has been discussed already is that of "experimental
features that we generally think are helpful but change behavior slightly in
some cases".

feature.experimental:
    pack.useSparse = true
    merge.directoryRenames = true
    fetch.negotiationAlgorithm = skipping

Specifically, this setting is for config values we are not sure will ever be
on by default, but additional testing is needed to be sure. This is
different than a possible 'feature.preview' setting that would include
config settings that we are committed to updating the defaults in a future
release. There are many ways we can take this idea in the future (including
more additions to these categories).

Thanks, -Stolee

Updates in V2: I'm responding to Dscho's comments early, as they were very
valuable.

 * Rearranged how we are checking for the feature.* settings, so if one
   layer turns the setting on and a later layer turns it off, we do not
   adjust the defaults.
   
   
 * Switched to using enums for the non-boolean config options.
   
   
 * Placed the repo_settings struct directly in the repository struct.
   
   
 * All struct members are initialized to -1 using memset.
   
   
 * The config changes around directory rename detection is greatly
   simplified.
   
   

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Derrick Stolee (5):
  repo-settings: consolidate some config settings
  repo-settings: add feature.manyCommits setting
  repo-settings: parse core.untrackedCache
  repo-settings: create feature.manyFiles setting
  repo-settings: create feature.experimental setting

 Documentation/config.txt             |  2 +
 Documentation/config/core.txt        |  7 ++-
 Documentation/config/feature.txt     | 42 +++++++++++++++
 Documentation/config/fetch.txt       |  3 +-
 Documentation/config/gc.txt          |  4 +-
 Documentation/config/index.txt       |  1 +
 Documentation/config/merge.txt       |  3 +-
 Documentation/config/pack.txt        |  3 +-
 Makefile                             |  1 +
 builtin/am.c                         |  1 +
 builtin/gc.c                         | 13 +++--
 builtin/pack-objects.c               |  9 ++--
 builtin/update-index.c               |  7 ++-
 commit-graph.c                       |  7 +--
 config.c                             | 24 ---------
 fetch-negotiator.c                   | 26 +++++-----
 fetch-negotiator.h                   |  5 +-
 fetch-pack.c                         | 11 ++--
 merge-recursive.c                    | 15 +++---
 read-cache.c                         | 31 +++++------
 repo-settings.c                      | 78 ++++++++++++++++++++++++++++
 repo-settings.h                      | 41 +++++++++++++++
 repository.h                         |  5 ++
 t/t1600-index.sh                     | 31 +++++++++--
 t/t5552-skipping-fetch-negotiator.sh | 23 --------
 25 files changed, 274 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/config/feature.txt
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h


base-commit: 9c9b961d7eb15fb583a2a812088713a68a85f1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-292%2Fderrickstolee%2Frepo-settings%2Fhead-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-292/derrickstolee/repo-settings/head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/292

Range-diff vs v1:

 1:  72f652b89c ! 1:  597ab7d621 repo-settings: consolidate some config settings
     @@ -64,7 +64,7 @@
      -					 NULL))
      -		return 1;
      +	prepare_repo_settings(the_repository);
     -+	if (the_repository->settings->gc_write_commit_graph == 1)
     ++	if (the_repository->settings.gc_write_commit_graph == 1)
      +		write_commit_graph_reachable(get_object_directory(),
      +					     !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
      +					     NULL);
     @@ -99,8 +99,8 @@
       
       	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
      +	prepare_repo_settings(the_repository);
     -+	if (!sparse && the_repository->settings->pack_use_sparse != -1)
     -+		sparse = the_repository->settings->pack_use_sparse;
     ++	if (!sparse && the_repository->settings.pack_use_sparse != -1)
     ++		sparse = the_repository->settings.pack_use_sparse;
      +
       	reset_pack_idx_option(&pack_idx_opts);
       	git_config(git_pack_config, NULL);
     @@ -134,7 +134,7 @@
       	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
      -	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
      -	    !config_value))
     -+	    r->settings->core_commit_graph != 1)
     ++	    r->settings.core_commit_graph != 1)
       		/*
       		 * This repository is not configured to use commit graphs, so
       		 * do not load one. (But report commit_graph_attempted anyway
     @@ -167,8 +167,8 @@
      -			version = value;
      +		prepare_repo_settings(r);
      +
     -+		if (r->settings->index_version >= 0)
     -+			version = r->settings->index_version;
     ++		if (r->settings.index_version >= 0)
     ++			version = r->settings.index_version;
       		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
       			warning(_("index.version set, but the value is invalid.\n"
       				  "Using version %i"), INDEX_FORMAT_DEFAULT);
     @@ -192,44 +192,28 @@
      +#include "config.h"
      +#include "repo-settings.h"
      +
     -+static int git_repo_config(const char *key, const char *value, void *cb)
     ++void prepare_repo_settings(struct repository *r)
      +{
     -+	struct repo_settings *rs = (struct repo_settings *)cb;
     ++	int value;
      +
     -+	if (!strcmp(key, "core.commitgraph")) {
     -+		rs->core_commit_graph = git_config_bool(key, value);
     -+		return 0;
     -+	}
     -+	if (!strcmp(key, "gc.writecommitgraph")) {
     -+		rs->gc_write_commit_graph = git_config_bool(key, value);
     -+		return 0;
     -+	}
     -+	if (!strcmp(key, "pack.usesparse")) {
     -+		rs->pack_use_sparse = git_config_bool(key, value);
     -+		return 0;
     -+	}
     -+	if (!strcmp(key, "index.version")) {
     -+		rs->index_version = git_config_int(key, value);
     -+		return 0;
     -+	}
     ++	if (r->settings_initialized)
     ++		return;
      +
     -+	return 1;
     -+}
     ++	/* Defaults */
     ++	memset(&r->settings, -1, sizeof(r->settings));
      +
     -+void prepare_repo_settings(struct repository *r)
     -+{
     -+	if (r->settings)
     -+		return;
     ++	if (!repo_config_get_bool(r, "core.commitgraph", &value))
     ++		r->settings.core_commit_graph = value;
     ++	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
     ++		r->settings.gc_write_commit_graph = value;
      +
     -+	r->settings = xmalloc(sizeof(*r->settings));
     ++	if (!repo_config_get_bool(r, "index.version", &value))
     ++		r->settings.index_version = value;
      +
     -+	/* Defaults */
     -+	r->settings->core_commit_graph = -1;
     -+	r->settings->gc_write_commit_graph = -1;
     -+	r->settings->pack_use_sparse = -1;
     -+	r->settings->index_version = -1;
     ++	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     ++		r->settings.pack_use_sparse = value;
      +
     -+	repo_config(r, git_repo_config, r->settings);
     ++	r->settings_initialized = 1;
      +}
      
       diff --git a/repo-settings.h b/repo-settings.h
     @@ -243,8 +227,10 @@
      +struct repo_settings {
      +	int core_commit_graph;
      +	int gc_write_commit_graph;
     -+	int pack_use_sparse;
     ++
      +	int index_version;
     ++
     ++	int pack_use_sparse;
      +};
      +
      +struct repository;
     @@ -257,7 +243,10 @@
       --- a/repository.h
       +++ b/repository.h
      @@
     + #define REPOSITORY_H
     + 
       #include "path.h"
     ++#include "repo-settings.h"
       
       struct config_set;
      +struct repo_settings;
     @@ -268,7 +257,8 @@
       	 */
       	char *submodule_prefix;
       
     -+	struct repo_settings *settings;
     ++	int settings_initialized;
     ++	struct repo_settings settings;
      +
       	/* Subsystems */
       	/*
 2:  e00a1be75b ! 2:  86380c7832 repo-settings: add feature.manyCommits setting
     @@ -4,7 +4,7 @@
      
          When a repo has many commits, it is helpful to write and read the
          commit-graph file. Future changes to Git may include new config
     -    settings that are benefitial in this scenario.
     +    settings that are beneficial in this scenario.
      
          Create the 'feature.manyCommits' config setting that changes the
          default values of 'core.commitGraph' and 'gc.writeCommitGraph' to
     @@ -85,15 +85,17 @@
       
      +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
      +
     - static int git_repo_config(const char *key, const char *value, void *cb)
     + void prepare_repo_settings(struct repository *r)
       {
     - 	struct repo_settings *rs = (struct repo_settings *)cb;
     + 	int value;
     +@@
     + 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     + 		r->settings.pack_use_sparse = value;
       
     -+	if (!strcmp(key, "feature.manycommits")) {
     -+		UPDATE_DEFAULT(rs->core_commit_graph, 1);
     -+		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
     -+		return 0;
     ++	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
     ++		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
     ++		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
      +	}
     - 	if (!strcmp(key, "core.commitgraph")) {
     - 		rs->core_commit_graph = git_config_bool(key, value);
     - 		return 0;
     ++
     + 	r->settings_initialized = 1;
     + }
 3:  47ae3e7d4d ! 3:  49be7a7345 repo-settings: parse core.untrackedCache
     @@ -16,10 +16,9 @@
          untracked cache and persist it.
      
          Instead of relying on magic values of -1, 0, and 1, split these
     -    options into bitflags CORE_UNTRACKED_CACHE_KEEP and
     -    CORE_UNTRACKED_CACHE_WRITE. This allows the use of "-1" as a
     +    options into an enum. This allows the use of "-1" as a
          default value. After parsing the config options, if the value is
     -    unset we can initialize it to CORE_UNTRACKED_CACHE_KEEP.
     +    unset we can initialize it to UNTRACKED_CACHE_KEEP.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -52,7 +51,7 @@
       		break;
       	case UC_DISABLE:
      -		if (git_config_get_untracked_cache() == 1)
     -+		if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
     ++		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
       			warning(_("core.untrackedCache is set to true; "
       				  "remove or change it, if you really want to "
       				  "disable the untracked cache"));
     @@ -61,7 +60,7 @@
       	case UC_ENABLE:
       	case UC_FORCE:
      -		if (git_config_get_untracked_cache() == 0)
     -+		if (r->settings->core_untracked_cache == 0)
     ++		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
       			warning(_("core.untrackedCache is set to false; "
       				  "remove or change it, if you really want to "
       				  "enable the untracked cache"));
     @@ -116,7 +115,7 @@
      +
      +	prepare_repo_settings(r);
      +
     -+	if (!(r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_KEEP)) {
     ++	if (r->settings.core_untracked_cache  == UNTRACKED_CACHE_REMOVE) {
       		remove_untracked_cache(istate);
      -		break;
      -	case 1: /* true */
     @@ -127,7 +126,7 @@
      +		return;
       	}
      +
     -+	if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
     ++	if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
      +		add_untracked_cache(istate);
       }
       
     @@ -137,39 +136,46 @@
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - 		rs->index_version = git_config_int(key, value);
     - 		return 0;
     - 	}
     -+	if (!strcmp(key, "core.untrackedcache")) {
     -+		int bool_value = git_parse_maybe_bool(value);
     -+		if (bool_value == 0)
     -+			rs->core_untracked_cache = 0;
     -+		else if (bool_value == 1)
     -+			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP |
     -+						   CORE_UNTRACKED_CACHE_WRITE;
     -+		else if (!strcasecmp(value, "keep"))
     -+			rs->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
     -+		else
     -+			error(_("unknown core.untrackedCache value '%s'; "
     -+				"using 'keep' default value"), value);
     -+		return 0;
     -+	}
     + void prepare_repo_settings(struct repository *r)
     + {
     + 	int value;
     ++	char *strval;
       
     - 	return 1;
     - }
     + 	if (r->settings_initialized)
     + 		return;
      @@
     - 	r->settings->gc_write_commit_graph = -1;
     - 	r->settings->pack_use_sparse = -1;
     - 	r->settings->index_version = -1;
     -+	r->settings->core_untracked_cache = -1;
       
     - 	repo_config(r, git_repo_config, r->settings);
     + 	if (!repo_config_get_bool(r, "index.version", &value))
     + 		r->settings.index_version = value;
     ++	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
     ++		if (value == 0)
     ++			r->settings.core_untracked_cache = UNTRACKED_CACHE_REMOVE;
     ++		else
     ++			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
     ++	} else if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
     ++		if (!strcasecmp(strval, "keep"))
     ++			r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
     ++
     ++		free(strval);
     ++	}
      +
     + 
     + 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     + 		r->settings.pack_use_sparse = value;
     +-
     ++	
     + 	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
     + 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
     + 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
     + 	}
     + 
      +	/* Hack for test programs like test-dump-untracked-cache */
      +	if (ignore_untracked_cache_config)
     -+		r->settings->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
     ++		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
      +	else
     -+		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACHE_KEEP);
     ++		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     ++
     + 	r->settings_initialized = 1;
       }
      
       diff --git a/repo-settings.h b/repo-settings.h
     @@ -179,15 +185,19 @@
       #ifndef REPO_SETTINGS_H
       #define REPO_SETTINGS_H
       
     -+#define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
     -+#define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
     ++enum untracked_cache_setting {
     ++	UNTRACKED_CACHE_UNSET = -1,
     ++	UNTRACKED_CACHE_REMOVE = 0,
     ++	UNTRACKED_CACHE_KEEP = 1,
     ++	UNTRACKED_CACHE_WRITE = 2
     ++};
      +
       struct repo_settings {
       	int core_commit_graph;
       	int gc_write_commit_graph;
     - 	int pack_use_sparse;
     + 
       	int index_version;
     -+	int core_untracked_cache;
     - };
     ++	enum untracked_cache_setting core_untracked_cache;
       
     - struct repository;
     + 	int pack_use_sparse;
     + };
 4:  63b522a858 ! 4:  86a5a0c589 repo-settings: create feature.manyFiles setting
     @@ -63,18 +63,16 @@
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - 		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
     - 		return 0;
     + 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
     + 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
       	}
     -+	if (!strcmp(key, "feature.manyfiles")) {
     -+		UPDATE_DEFAULT(rs->index_version, 4);
     -+		UPDATE_DEFAULT(rs->core_untracked_cache,
     -+			       CORE_UNTRACKED_CACHE_KEEP | CORE_UNTRACKED_CACHE_WRITE);
     -+		return 0;
     ++	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
     ++		UPDATE_DEFAULT(r->settings.index_version, 4);
     ++		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
      +	}
     - 	if (!strcmp(key, "core.commitgraph")) {
     - 		rs->core_commit_graph = git_config_bool(key, value);
     - 		return 0;
     + 
     + 	/* Hack for test programs like test-dump-untracked-cache */
     + 	if (ignore_untracked_cache_config)
      
       diff --git a/t/t1600-index.sh b/t/t1600-index.sh
       --- a/t/t1600-index.sh
 5:  da7685936f ! 5:  b8a631683a repo-settings: create feature.experimental setting
     @@ -104,16 +104,6 @@
       
       /**
        * Returns the length of the first line of msg.
     -@@
     - 	o.branch1 = "HEAD";
     - 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
     - 	o.branch2 = their_tree_name;
     --	o.detect_directory_renames = 0;
     -+	prepare_repo_settings(the_repository);
     -+	the_repository->settings->merge_directory_renames = 0;
     - 
     - 	if (state->quiet)
     - 		o.verbosity = 0;
      
       diff --git a/fetch-negotiator.c b/fetch-negotiator.c
       --- a/fetch-negotiator.c
     @@ -140,7 +130,7 @@
      -			die("unknown fetch negotiation algorithm '%s'", algorithm);
      -		}
      +	prepare_repo_settings(r);
     -+	switch(r->settings->fetch_negotiation_algorithm) {
     ++	switch(r->settings.fetch_negotiation_algorithm) {
      +	case FETCH_NEGOTIATION_SKIPPING:
      +		skipping_negotiator_init(negotiator);
      +		return;
     @@ -248,83 +238,6 @@
       
       struct path_hashmap_entry {
       	struct hashmap_entry e;
     -@@
     - 	 * there is no content merge to do; just move the file into the
     - 	 * desired final location.
     - 	 */
     -+	struct repository *r = the_repository;
     - 	const struct rename *ren = ci->ren1;
     - 	const struct diff_filespec *dest = ren->pair->two;
     - 	char *file_path = dest->path;
     --	int mark_conflicted = (opt->detect_directory_renames == 1);
     -+	int mark_conflicted;
     -+
     -+	prepare_repo_settings(r);
     -+	mark_conflicted = (r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
     - 	assert(ren->dir_rename_original_dest);
     - 
     - 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
     -@@
     - 				      struct string_list *entries,
     - 				      struct rename_info *ri)
     - {
     -+	struct repository *r = the_repository;
     - 	struct diff_queue_struct *head_pairs, *merge_pairs;
     - 	struct hashmap *dir_re_head, *dir_re_merge;
     - 	int clean = 1;
     -@@
     - 	head_pairs = get_diffpairs(opt, common, head);
     - 	merge_pairs = get_diffpairs(opt, common, merge);
     - 
     --	if (opt->detect_directory_renames) {
     -+	prepare_repo_settings(r);
     -+	if (r->settings->merge_directory_renames) {
     - 		dir_re_head = get_directory_renames(head_pairs);
     - 		dir_re_merge = get_directory_renames(merge_pairs);
     - 
     -@@
     - 				const struct diff_filespec *b,
     - 				struct rename_conflict_info *ci)
     - {
     -+	struct repository *r = the_repository;
     - 	struct rename *ren = ci->ren1;
     - 	struct merge_file_info mfi;
     - 	int clean;
     -@@
     - 	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
     - 				     o, a, b, ci);
     - 
     --	if (clean && opt->detect_directory_renames == 1 &&
     -+	prepare_repo_settings(r);
     -+	if (clean &&
     -+	    r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
     - 	    ren->dir_rename_original_dest) {
     - 		if (update_stages(opt, path,
     - 				  NULL,
     -@@
     - static int warn_about_dir_renamed_entries(struct merge_options *opt,
     - 					  struct rename *ren)
     - {
     -+	struct repository *r = the_repository;
     - 	const char *msg;
     - 	int clean = 1, is_add;
     - 
     -@@
     - 		return clean;
     - 
     - 	/* Sanity checks */
     --	assert(opt->detect_directory_renames > 0);
     -+	prepare_repo_settings(r);
     -+	assert(r->settings->merge_directory_renames > 0);
     - 	assert(ren->dir_rename_original_type == 'A' ||
     - 	       ren->dir_rename_original_type == 'R');
     - 
     - 	/* Check whether to treat directory renames as a conflict */
     --	clean = (opt->detect_directory_renames == 2);
     -+	clean = (r->settings->merge_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE);
     - 
     - 	is_add = (ren->dir_rename_original_type == 'A');
     - 	if (ren->dir_rename_original_type == 'A' && clean) {
      @@
       		opt->merge_detect_rename = git_config_rename("merge.renames", value);
       		free(value);
     @@ -342,115 +255,92 @@
       }
       
      @@
     - 	opt->renormalize = 0;
       	opt->diff_detect_rename = -1;
       	opt->merge_detect_rename = -1;
     --	opt->detect_directory_renames = 1;
     + 	opt->detect_directory_renames = 1;
     ++
     ++	prepare_repo_settings(repo);
     ++	if (repo->settings.merge_directory_renames >= 0)
     ++		opt->detect_directory_renames = repo->settings.merge_directory_renames;
     ++
       	merge_recursive_config(opt);
       	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
       	if (merge_verbosity)
      
     - diff --git a/merge-recursive.h b/merge-recursive.h
     - --- a/merge-recursive.h
     - +++ b/merge-recursive.h
     -@@
     - 	unsigned renormalize : 1;
     - 	long xdl_opts;
     - 	int verbosity;
     --	int detect_directory_renames;
     - 	int diff_detect_rename;
     - 	int merge_detect_rename;
     - 	int diff_rename_limit;
     -
       diff --git a/repo-settings.c b/repo-settings.c
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - {
     - 	struct repo_settings *rs = (struct repo_settings *)cb;
     - 
     -+	if (!strcmp(key, "feature.experimental")) {
     -+		UPDATE_DEFAULT(rs->pack_use_sparse, 1);
     -+		UPDATE_DEFAULT(rs->merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
     -+		UPDATE_DEFAULT(rs->fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
     -+		return 0;
     -+	}
     - 	if (!strcmp(key, "feature.manycommits")) {
     - 		UPDATE_DEFAULT(rs->core_commit_graph, 1);
     - 		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
     -@@
     - 				"using 'keep' default value"), value);
     - 		return 0;
     + 		free(strval);
       	}
     -+	if (!strcmp(key, "merge.directoryrenames")) {
     -+		int bool_value = git_parse_maybe_bool(value);
     -+		if (0 <= bool_value) {
     -+			rs->merge_directory_renames = bool_value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
     -+		} else if (!strcasecmp(value, "conflict")) {
     -+			rs->merge_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
     -+		}
     -+		return 0;
     + 
     ++	if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
     ++		r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
     ++	else if (!repo_config_get_string(r, "merge.directoryrenames", &strval)) {
     ++		if (!strcasecmp(strval, "conflict"))
     ++			r->settings.merge_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
      +	}
     -+	if (!strcmp(key, "fetch.negotiationalgorithm"))	{
     -+		if (!strcasecmp(value, "skipping")) {
     -+			rs->fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
     -+		} else {
     -+			rs->fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
     -+		}
     -+		return 0;
     ++	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
     ++		if (!strcasecmp(strval, "skipping"))
     ++			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
     ++		else
     ++			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
      +	}
       
     - 	return 1;
     - }
     + 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
     + 		r->settings.pack_use_sparse = value;
      @@
     - 	/* Defaults */
     - 	r->settings->core_commit_graph = -1;
     - 	r->settings->gc_write_commit_graph = -1;
     --	r->settings->pack_use_sparse = -1;
     -+
     - 	r->settings->index_version = -1;
     - 	r->settings->core_untracked_cache = -1;
     - 
     -+	r->settings->pack_use_sparse = -1;
     -+	r->settings->merge_directory_renames = -1;
     -+	r->settings->fetch_negotiation_algorithm = -1;
     -+
     - 	repo_config(r, git_repo_config, r->settings);
     + 		UPDATE_DEFAULT(r->settings.index_version, 4);
     + 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
     + 	}
     ++	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
     ++		UPDATE_DEFAULT(r->settings.pack_use_sparse, 1);
     ++		UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
     ++		UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
     ++	}
       
       	/* Hack for test programs like test-dump-untracked-cache */
     + 	if (ignore_untracked_cache_config)
      @@
     - 		r->settings->core_untracked_cache = CORE_UNTRACKED_CACHE_KEEP;
       	else
     - 		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACHE_KEEP);
     + 		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
     + 
     ++	UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
     ++	UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
      +
     -+	UPDATE_DEFAULT(r->settings->merge_directory_renames, MERGE_DIRECTORY_RENAMES_CONFLICT);
     -+	UPDATE_DEFAULT(r->settings->fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
     + 	r->settings_initialized = 1;
       }
      
       diff --git a/repo-settings.h b/repo-settings.h
       --- a/repo-settings.h
       +++ b/repo-settings.h
      @@
     - #define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
     - #define CORE_UNTRACKED_CACHE_KEEP (1 << 1)
     + 	UNTRACKED_CACHE_WRITE = 2
     + };
       
     -+#define MERGE_DIRECTORY_RENAMES_CONFLICT 1
     -+#define MERGE_DIRECTORY_RENAMES_TRUE 2
     ++enum merge_directory_renames_setting {
     ++	MERGE_DIRECTORY_RENAMES_UNSET = -1,
     ++	MERGE_DIRECTORY_RENAMES_NONE = 0,
     ++	MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
     ++	MERGE_DIRECTORY_RENAMES_TRUE = 2,
     ++};
      +
     -+#define FETCH_NEGOTIATION_DEFAULT 1
     -+#define FETCH_NEGOTIATION_SKIPPING 2
     ++enum fetch_negotiation_setting {
     ++	FETCH_NEGOTIATION_UNSET = -1,
     ++	FETCH_NEGOTIATION_NONE = 0,
     ++	FETCH_NEGOTIATION_DEFAULT = 1,
     ++	FETCH_NEGOTIATION_SKIPPING = 2,
     ++};
      +
       struct repo_settings {
       	int core_commit_graph;
       	int gc_write_commit_graph;
     --	int pack_use_sparse;
     -+
     - 	int index_version;
     - 	int core_untracked_cache;
     -+
     -+	int pack_use_sparse;
     -+	int merge_directory_renames;
     -+	int fetch_negotiation_algorithm;
     +@@
     + 	enum untracked_cache_setting core_untracked_cache;
     + 
     + 	int pack_use_sparse;
     ++	enum merge_directory_renames_setting merge_directory_renames;
     ++	enum fetch_negotiation_setting fetch_negotiation_algorithm;
       };
       
       struct repository;

-- 
gitgitgadget
