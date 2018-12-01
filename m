Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F261211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 01:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLAMwh (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 07:52:37 -0500
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:36060 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbeLAMwh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Dec 2018 07:52:37 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Dec 2018 07:52:36 EST
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-05v.sys.comcast.net with ESMTP
        id StvhgOXvZ7FSQSu9egxNAG; Sat, 01 Dec 2018 01:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1543627990;
        bh=ahWS4APymYcvdPMtQJ6RJxexM3kLZ/dUOVJeUf6ptJk=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=k82R109nNlcMcQbhcaEQe9WYT37MPhvG9e0G2VhDjwLkE1jMPU8uGUNx5mydg3/oI
         6dUEkFH3JfstXmhbLlRNrBkFsp6c7M9f1mDmS6dfgo6r1O+LwIatVtLSMn+7z63rj/
         GpLuMIS7WwUvieFHOxNPRT1V4yeqf0J4Y/8S0E7GROWaCOBaL57cVAKk0b8isUDS2F
         htKFcEYXzroSIoYCFfpc+zbXov7176B3SgBzZSV+U8XDBU9axhcowKINsOFoFOhhG+
         kC0D2zahXVwGL/ygn4zuGPiQHnWkJCyQ99knpoqzqv/ixGWh04YH9EyfUnZBefsCLj
         ydBMysUTvtMag==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-ch2-16v.sys.comcast.net with ESMTPSA
        id Su9Hgx2umr9M9Su9Mgj2JF; Sat, 01 Dec 2018 01:33:08 +0000
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
To:     Jeff King <peff@peff.net>, Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
 <20181121164019.GA24621@sigill.intra.peff.net>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
Date:   Fri, 30 Nov 2018 17:32:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121164019.GA24621@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJVmR4rt6/bwYUEOneWw3p4zlFSJchL4E+6Ym0aRWZkyFZ51CneNxFOD/1dpe1eyapLUQWSXv2Q0oerLgOhqIIGKy10X7DIGgS2ebdvBf5VO3UIzw/O/
 ARe2arOGMR72qqWiN2Je6CX25JBy2zSZ5EiaI4JJcjkLK9VhPKehmz1LHn4HxvIzSA4Pg7sX7orHH18JU1hC1bK5vvfLSa0Mal1BYrPZJLlKV2bi65O/jr2v
 RUw2Xpj8yo3qNyuAT6zJ66Eapg75/oUesEiJjV/CWZuy4PB698PWkm3R1C0sPyPlO3BmYzaBwiGhFeAGndXL0ZF6Oh8mw36Hqzd2LKKQwkxMhOEcUt+8uE4O
 JM1M4PZoWIHsUqJ5AYGZ3v4Wkx6ypejCO8dJ43HB1CpkWuIgtHYhN+s1/a1NVdV/gq0SZYlR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/21/2018 08:40 AM, Jeff King wrote:
> On Mon, Oct 22, 2018 at 06:13:42PM -0700, Matthew DeVore wrote:
> 
>> diff --git a/builtin/prune.c b/builtin/prune.c
>> index 41230f8215..11284d0bf3 100644
>> --- a/builtin/prune.c
>> +++ b/builtin/prune.c
>> @@ -120,6 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>>   	save_commit_buffer = 0;
>>   	read_replace_refs = 0;
>>   	ref_paranoia = 1;
>> +	revs.allow_exclude_promisor_objects_opt = 1;
>>   	repo_init_revisions(the_repository, &revs, prefix);
>>   
>>   	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
> 
> I think this line is in the wrong place. The very first thing
> repo_init_revisions() will do is memset() the revs struct to all-zeroes,
> so it cannot possibly be doing anything.

Ah of course :)

> 
> Normally it would need to go after init_revisions() but before
> setup_revisions(), but we don't seem to call the latter at all in
> builtin/prune.c. Which makes sense, because you cannot pass options to
> influence the reachability traversal. So I don't think we need to care
> about this flag at all here.
Agreed, prune.c doesn't use setup_revisions() even transitively, so we 
don't care about this flag.

> 
> Speaking of which, would this flag work better as a field in
> setup_revision_opt, which is passed to setup_revisions()? The intent
> seem to be to influence how we parse command-line arguments, and that's
> where other similar flags are (e.g., assume_dashdash).

Good idea. This would solve the problem of mistakenly believing the flag 
matters when it doesn't, since it is in the struct which is used as the 
arguments of the exact function that cares about it. Here's a new patch 
- I'm tweaking e-mail client settings so hopefully this makes it to the 
list without mangling - if not I'll resend it with `git-send-email` later.

 From 941c89fe1e226ed4d210ce35d0d906526b8277ed Mon Sep 17 00:00:00 2001
From: Matthew DeVore <matvore@google.com>
Date: Fri, 30 Nov 2018 16:43:32 -0800
Subject: [PATCH] revisions.c: put promisor option in specialized struct

Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
it was in rev_info, it was unclear when it was used, since rev_info is
passed to functions that don't use the flag. This resulted in
unnecessary setting of the flag in prune.c, so fix that as well.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
  builtin/pack-objects.c |  7 +++++--
  builtin/prune.c        |  1 -
  builtin/rev-list.c     |  6 ++++--
  revision.c             | 17 ++++++++++++-----
  revision.h             |  4 ++--
  5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..b22c99f540 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3084,14 +3084,17 @@ static void record_recent_commit(struct commit 
*commit, void *data)
  static void get_object_list(int ac, const char **av)
  {
  	struct rev_info revs;
+	struct setup_revision_opt s_r_opt;
  	char line[1000];
  	int flags = 0;
  	int save_warning;

  	repo_init_revisions(the_repository, &revs, NULL);
  	save_commit_buffer = 0;
-	revs.allow_exclude_promisor_objects_opt = 1;
-	setup_revisions(ac, av, &revs, NULL);
+
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.allow_exclude_promisor_objects = 1;
+	setup_revisions(ac, av, &revs, &s_r_opt);

  	/* make sure shallows are read */
  	is_repository_shallow(the_repository);
diff --git a/builtin/prune.c b/builtin/prune.c
index e42653b99c..1ec9ddd751 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,6 @@ int cmd_prune(int argc, const char **argv, const 
char *prefix)
  	save_commit_buffer = 0;
  	read_replace_refs = 0;
  	ref_paranoia = 1;
-	revs.allow_exclude_promisor_objects_opt = 1;
  	repo_init_revisions(the_repository, &revs, prefix);

  	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3a2c0c23b6..c3095c6fed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -362,6 +362,7 @@ int cmd_rev_list(int argc, const char **argv, const 
char *prefix)
  {
  	struct rev_info revs;
  	struct rev_list_info info;
+	struct setup_revision_opt s_r_opt;
  	int i;
  	int bisect_list = 0;
  	int bisect_show_vars = 0;
@@ -375,7 +376,6 @@ int cmd_rev_list(int argc, const char **argv, const 
char *prefix)
  	git_config(git_default_config, NULL);
  	repo_init_revisions(the_repository, &revs, prefix);
  	revs.abbrev = DEFAULT_ABBREV;
-	revs.allow_exclude_promisor_objects_opt = 1;
  	revs.commit_format = CMIT_FMT_UNSPECIFIED;
  	revs.do_not_die_on_missing_tree = 1;

@@ -407,7 +407,9 @@ int cmd_rev_list(int argc, const char **argv, const 
char *prefix)
  		}
  	}

-	argc = setup_revisions(argc, argv, &revs, NULL);
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.allow_exclude_promisor_objects = 1;
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);

  	memset(&info, 0, sizeof(info));
  	info.revs = &revs;
diff --git a/revision.c b/revision.c
index 13e0519c02..221ba79594 100644
--- a/revision.c
+++ b/revision.c
@@ -1791,7 +1791,8 @@ static void add_message_grep(struct rev_info 
*revs, const char *pattern)
  }

  static int handle_revision_opt(struct rev_info *revs, int argc, const 
char **argv,
-			       int *unkc, const char **unkv)
+			       int *unkc, const char **unkv,
+			       int allow_exclude_promisor_objects)
  {
  	const char *arg = argv[0];
  	const char *optarg;
@@ -2151,7 +2152,7 @@ static int handle_revision_opt(struct rev_info 
*revs, int argc, const char **arg
  		revs->limited = 1;
  	} else if (!strcmp(arg, "--ignore-missing")) {
  		revs->ignore_missing = 1;
-	} else if (revs->allow_exclude_promisor_objects_opt &&
+	} else if (allow_exclude_promisor_objects &&
  		   !strcmp(arg, "--exclude-promisor-objects")) {
  		if (fetch_if_missing)
  			BUG("exclude_promisor_objects can only be used when 
fetch_if_missing is 0");
@@ -2173,7 +2174,8 @@ void parse_revision_opt(struct rev_info *revs, 
struct parse_opt_ctx_t *ctx,
  			const char * const usagestr[])
  {
  	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
-				    &ctx->cpidx, ctx->out);
+				    &ctx->cpidx, ctx->out,
+				    /*allow_exclude_promisor_objects=*/0);
  	if (n <= 0) {
  		error("unknown option `%s'", ctx->argv[0]);
  		usage_with_options(usagestr, options);
@@ -2340,9 +2342,12 @@ int setup_revisions(int argc, const char **argv, 
struct rev_info *revs, struct s
  	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
  	struct argv_array prune_data = ARGV_ARRAY_INIT;
  	const char *submodule = NULL;
+	int allow_exclude_prom_objs = 0;

-	if (opt)
+	if (opt) {
  		submodule = opt->submodule;
+		allow_exclude_prom_objs = opt->allow_exclude_promisor_objects;
+	}

  	/* First, search for "--" */
  	if (opt && opt->assume_dashdash) {
@@ -2391,7 +2396,9 @@ int setup_revisions(int argc, const char **argv, 
struct rev_info *revs, struct s
  				continue;
  			}

-			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+			opts = handle_revision_opt(revs, argc - i, argv + i,
+						   &left, argv,
+						   allow_exclude_prom_objs);
  			if (opts > 0) {
  				i += opts - 1;
  				continue;
diff --git a/revision.h b/revision.h
index 7987bfcd2e..7d6e050569 100644
--- a/revision.h
+++ b/revision.h
@@ -161,7 +161,6 @@ struct rev_info {
  			do_not_die_on_missing_tree:1,

  			/* for internal use only */
-			allow_exclude_promisor_objects_opt:1,
  			exclude_promisor_objects:1;

  	/* Diff flags */
@@ -297,7 +296,8 @@ struct setup_revision_opt {
  	const char *def;
  	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
  	const char *submodule;	/* TODO: drop this and use rev_info->repo */
-	int assume_dashdash;
+	int assume_dashdash : 1;
+	int allow_exclude_promisor_objects : 1;
  	unsigned revarg_opt;
  };

-- 
2.20.0.rc1.387.gf8505762e3-goog
