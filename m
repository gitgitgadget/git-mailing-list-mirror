Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8481F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHBVKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:10:52 -0400
Received: from mout.web.de ([212.227.15.3]:34779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBVKw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:10:52 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw1CH-1g1c4325Of-017lKy; Thu, 02
 Aug 2018 21:18:14 +0200
Subject: [PATCH 6/6] parse-options: automatically infer
 PARSE_OPT_LITERAL_ARGHELP
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <757ca573-3954-9c31-8a7b-56a2de8e3793@web.de>
Date:   Thu, 2 Aug 2018 21:18:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JRy6rBVl6wWHvJfqGAUo67c8EmR5sESKWOFM8bIGHf6TmTqJ2WC
 K6OfrVTtaciP8rRu7zkpEGtPCwgfO7xTMPjUFItq4QIfs6iEL2c0x2RDCkkymlfBgpJ6Dm6
 5IS0Y0b0LZBF4oQxoeHtfCLQOh+mP7cxd0GXlfyRFriGzTyJ0UYyh5t9urCj0itbKTe8Qlu
 y/gKtSR+Bq7yqsExmVgvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UJlXCmVILrQ=:1IPze3zmdkUSlLTyYQCaWn
 DezDIJhAV2CE5XdiRMJAnHDFDwvj8BBvhEkFy/7q34HpfPtquHQNHUKqp70wgsY087I1y9NPD
 QXOoDp5d1J3LpwJfHDUc0oZf3AzjO+cfPJ4FBcFCFuLEi2zc8XDZqYLMTo6g3DN2p0tScH9Nc
 lH+ZIIKOC2TG/KAOiE/cov3sGm3trG6UISphvJXJLjJ7WfK0ZwlSWaIvSgIEU9lryx8WEqzso
 hFpuziUtCOQRCfO83Xk1HrFdVs72AUQPXjEgl9KtycQejjBBpJq8pQB3zFN8BWPyuXQ65snz3
 adl/uc7x35cwBKAkjeje3LVOuEoWWGj6X73pIHZ12U2/0yAxivdmG5BuhE6XccLOTqE73bhF0
 VOZqbJdhWshkEC6OOlBHhNCXcYsYpcqLJ+rVD8tLJXyP/W7ljRyKqiiM2ZGIqIzF3DJ/1PzvN
 go9H6Wxien1CtH9RPEE0hFFzUocWceH4Vt73xWrErev/ZYAskcGLN666McKnrvK7Ld4+hodje
 iQ6PGEY0/urJJpiKyUdoevv8LRuUvcS6HG77klj5DhHEVk6zNNlvVkR4WALf82RkL7NYpHCdZ
 jifCb4l3c35/zRDedabS4bqWBxblyRE9Rc6zhrso/qZjl5dWERVMGUYIoWZuh/hz6Tw3xbotJ
 DN5OBmDKwU3CaTM24nusk0r8CAeCNwHtc0sm0KyFt1xpTaw9LtFOJo4kypU7fKJbW9LLRgwZI
 19x8z3AYFY7MdGpiN884eEB6PUXKarHh6nf/q260GnBMRProE5H33QqjrWaCkvCMQw+FjtLuD
 N7dwPLL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parseopt wraps argument help strings in a pair of angular brackets by
default, to tell users that they need to replace it with an actual
value.  This is useful in most cases, because most option arguments
are indeed single values of a certain type.  The option
PARSE_OPT_LITERAL_ARGHELP needs to be used in option definitions with
arguments that have multiple parts or are literal strings.

Stop adding these angular brackets if special characters are present,
as they indicate that we don't deal with a simple placeholder.  This
simplifies the code a bit and makes defining special options slightly
easier.

Remove the flag PARSE_OPT_LITERAL_ARGHELP in the cases where the new
and more cautious handling suffices.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The patch to add PARSE_OPT_LITERAL_ARGHELP for push --force-with-lease
should be applied before this one.

 builtin/add.c          | 5 ++---
 builtin/pack-objects.c | 2 +-
 builtin/read-tree.c    | 2 +-
 builtin/send-pack.c    | 3 +--
 builtin/shortlog.c     | 3 +--
 builtin/show-branch.c  | 2 +-
 builtin/update-index.c | 2 +-
 builtin/write-tree.c   | 5 ++---
 parse-options.c        | 3 ++-
 9 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 84bfec9b73..ba1ff5689d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -304,9 +304,8 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
-	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
-	  N_("override the executable bit of the listed files"),
-	  PARSE_OPT_LITERAL_ARGHELP },
+	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
+		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
 	OPT_END(),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3a5d1fa317..b2323613bc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3112,7 +3112,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("similar to --all-progress when progress meter is shown")),
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
-		  PARSE_OPT_LITERAL_ARGHELP, option_parse_index_version },
+		  0, option_parse_index_version },
 		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
 			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ebc43eb805..fbbc98e516 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("same as -m, but discard unmerged entries")),
 		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
 		  N_("read the tree into the index under <subdirectory>/"),
-		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
+		  PARSE_OPT_NONEG },
 		OPT_BOOL('u', NULL, &opts.update,
 			 N_("update working tree with merge result")),
 		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0b517c9368..724b484850 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -180,8 +180,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK,
 		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
-		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
-		  parseopt_push_cas_option },
+		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
 		OPT_END()
 	};
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f555cf9e4f..3898a2c9c4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -269,8 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('e', "email", &log.email,
 			 N_("Show the email address of each author")),
 		{ OPTION_CALLBACK, 'w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
-			N_("Linewrap output"),
-			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			N_("Linewrap output"), PARSE_OPT_OPTARG,
 			&parse_wrap_args },
 		OPT_END(),
 	};
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f2e985c00a..9106da1985 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -673,7 +673,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
-			    PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			    PARSE_OPT_OPTARG,
 			    parse_reflog_param },
 		OPT_END()
 	};
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7feda6e271..293f59247b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -973,7 +973,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			(parse_opt_cb *) cacheinfo_callback},
 		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
 			N_("override the executable bit of the listed files"),
-			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			PARSE_OPT_NONEG,
 			chmod_callback},
 		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
 			N_("mark files as \"not changing\""),
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index c9d3c544e7..cdcbf8264e 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -24,9 +24,8 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
 			WRITE_TREE_MISSING_OK),
-		{ OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
-		  N_("write tree object for a subdirectory <prefix>") ,
-		  PARSE_OPT_LITERAL_ARGHELP },
+		OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),
+			   N_("write tree object for a subdirectory <prefix>")),
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
 		  N_("only useful for debugging"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
diff --git a/parse-options.c b/parse-options.c
index 7db84227ab..3b874a83a0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
-	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
+	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
 			s = literal ? "[=%s]" : "[=<%s>]";
-- 
2.18.0
