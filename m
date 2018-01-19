Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF611FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeASAB1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45788 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeASABP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so210969wmi.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=80T8J45FM3LRJMdqGNt2GmapkB+My5Mteya00SltxyY=;
        b=rfQTGWHkMue9JOQU2oRQFlJ1+WR+KjpQx1+iaTJUssrcVW25riT6x9kmMLPreaDDcp
         7DRTtxEkr7B5U/fJ/HNFlSQn1MgFrI6ayPWdSqaUUdHowvBoglKYjD81KvVy/NWsJ1Vv
         HPk8BxKlXopJeD0BL1BaiGj9dxjeFiY1Ca/91kt+rynVE2BYuDEEdYOS7zrg6vGcvzkf
         TWmSS0WLi77sbww+ckG0pOo3v62yEITPZXjnRAYvn1jP1nveJF6cRiMj4qQubUgCy1jT
         VcO1PvuroCVBVkOkdfcBSfcRa51GKHHieuchyuN/FmlMNrPdOwn5HbqF5zDXoLYw2uTM
         T0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=80T8J45FM3LRJMdqGNt2GmapkB+My5Mteya00SltxyY=;
        b=tHUahwTaOjQjjaAJ7mJD7z/SYLzbQtrMlJ5IKw/6xw9oddqBbSzkWmN4uYLLfqQQb0
         59f4dbScUYFdVREmg19Hly3aK/QkG4RYdCTubJ8OlRgj0bq0Lot+Hbf9gQTQKEYb+vbz
         0XiMRINTF8Ps5KYyO4dWWv8bQzRj+jH4IaSSlpENgYSlFYHI32zu1hYLefy0ZU27eEbo
         4cmwKn3tBvysU+/vvxhWLj0qc/GzgUOD7BAOrQ03TljoWBPtMM8zyr2unDpECeUz39Kr
         bimKOD3X/m8tPU8RcHgqHKlFZmgqgENYJHWhWi/wnNTUsH0xW815O+swGuqNKXR2XSyD
         Salg==
X-Gm-Message-State: AKwxytfb23NTZmmcW/ZSosXmM/AvZnM19vXZ2mG9YsBwCTD5AVLYgQOd
        JUkeWLSbUR6qBlmhLPZ0HBs3hpFX
X-Google-Smtp-Source: ACJfBou7mXMz+Xqvb9v3YXD0LGvBbJEagaxoj5c6Zv0nOKfxla4f2wTNEeipisM0BhRGZ8+mCkfldw==
X-Received: by 10.28.247.25 with SMTP id v25mr6996755wmh.10.1516320073559;
        Thu, 18 Jan 2018 16:01:13 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 11/11] WIP fetch: add a --fetch-prune option and fetch.pruneTags config
Date:   Fri, 19 Jan 2018 00:00:27 +0000
Message-Id: <20180119000027.28898-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[WIP: This doesn't (yet) work as advertised, see further WIP note
below]

Add a --fetch-prune option to git-fetch along with fetch.pruneTags
config option. This allows for doing:

    git fetch origin -p -P

Or simply:

    git config fetch.prune true &&
    git config fetch.pruneTags true &&
    git fetch origin

Instead of the much more verbose:

    git fetch --prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'

A use-case of git which is a pain to support now is frequent pulling
from a repo which is having both its branches *and* tags deleted
regularly. At work we create deployment tags in the repo for each
rollout, and there's *lots* of those, so they're archived within weeks
for performance reasons.

Without this change it's hard to centrally configure such repos in
/etc/gitconfig (on servers that are only used for working with
them). You need to set fetch.prune=true globally, and then for each
repo:

    git -C {} config --replace-all remote.origin.fetch "refs/tags/*:refs/tags/*" "^refs/tags/*:refs/tags/*$"

Now I can simply set fetch.pruneTags=true in /etc/gitconfig as well,
and users running "git pull" will automatically get the pruning
semantics we want.

See my "Re: [BUG] git remote prune removes local tags, depending on
fetch config" (87po6ahx87.fsf@evledraar.gmail.com;
https://public-inbox.org/git/87po6ahx87.fsf@evledraar.gmail.com/) for
more details.

[WIP: This doesn't actually work, since the implementation is to just
pretend that 'refs/tags/*:refs/tags/*' was supplied on the
command-line, we'll consequently stop fetching any branches, since we
don't use the default refspec found in .git/config anymore

I'm not familiar enough with this code and the refspec machinery to
know if this argument injection is crazy, and how to tell it to *also*
do whatever it's doing by default]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 15 +++++++++++++++
 Documentation/fetch-options.txt | 15 ++++++++++++++-
 builtin/fetch.c                 | 37 ++++++++++++++++++++++++++++++++++---
 remote.c                        |  2 ++
 remote.h                        |  1 +
 t/t5510-fetch.sh                |  1 +
 6 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f27af5760..476175ef8d 100644
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
@@ -2945,6 +2953,13 @@ remote.<name>.prune::
 	remove any remote-tracking references that no longer exist on the
 	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
+
+remote.<name>.pruneTags::
+	When set to true, fetching from this remote by default will also
+	remove any local tags that no longer exist on the remote (as
+	if the `--prune` option was given on the command line in
+	conjunction with the `refs/tags/*:refs/tags/*` refspec).
+	Overrides `fetch.prune` settings, if any.
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
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b34665db9e..57669a000c 100644
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
+		 N_("prune local tags not found on remote")),
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
@@ -1270,6 +1283,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	static const char **refs = NULL;
 	struct refspec *refspec;
 	int ref_nr = 0;
+	int j = 0;
 	int exit_code;
 
 	if (!remote)
@@ -1288,10 +1302,27 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			prune = PRUNE_BY_DEFAULT;
 	}
 
+	if (prune_tags < 0) {
+		/* no command line request */
+		if (0 <= gtransport->remote->prune_tags)
+			prune_tags = gtransport->remote->prune_tags;
+		else if (0 <= fetch_prune_tags_config)
+			prune_tags = fetch_prune_tags_config;
+		else
+			prune_tags = PRUNE_TAGS_BY_DEFAULT;
+	}
+
+	if (argc > 0 || prune_tags) {
+		size_t nr_alloc = st_add3(argc, prune_tags, 1);
+		refs = xcalloc(nr_alloc, sizeof(const char *));
+		if (prune_tags) {
+			refs[j++] = xstrfmt("refs/tags/*:refs/tags/*");
+			ref_nr++;
+		}
+	}
+
 	if (argc > 0) {
-		int j = 0;
 		int i;
-		refs = xcalloc(st_add(argc, 1), sizeof(const char *));
 		for (i = 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				i++;
@@ -1301,8 +1332,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 						    argv[i], argv[i]);
 			} else
 				refs[j++] = argv[i];
+			ref_nr++;
 		}
-		ref_nr = j;
 	}
 
 	sigchain_push_common(unlock_pack_on_signal);
diff --git a/remote.c b/remote.c
index 4e93753e19..9eb6d24009 100644
--- a/remote.c
+++ b/remote.c
@@ -391,6 +391,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prune"))
 		remote->prune = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prunetags"))
+		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index 1f6611be21..04d7994cbf 100644
--- a/remote.h
+++ b/remote.h
@@ -47,6 +47,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int prune_tags;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 18280df4fc..1a822861e0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -617,6 +617,7 @@ test_configured_prune () {
 test_configured_prune unset unset unset unset kept   kept   ""
 test_configured_prune unset unset unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset unset unset pruned kept   "--prune"
+test_configured_prune unset unset unset unset pruned pruned "--prune --prune-tags" # WIP: broken, see commit msg
 test_configured_prune unset unset unset unset kept   pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*'"
 test_configured_prune unset unset unset unset pruned pruned \
-- 
2.15.1.424.g9478a66081

