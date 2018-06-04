Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9991F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeFDMoX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:44:23 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42487 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeFDMoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:44:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id j80-v6so23085759qke.9
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ckfx1HyP+necpBtslfUI5BcBnDWVmFodI3dlBbJp+Cc=;
        b=LajmuZqBJDqRoTjHqO3hnV+Ln6DrsPz8YecQ3EUTI3P3vDb+80E/a3ywWcg65/6Qjv
         HkuReC8GoD+ykc0IAWpT1s9/jB4tS0ColM+SVxcvqZwOqVJrq8r1PKYrbpDBIBWL+MSl
         xpRlkseFt+tCHMvAgFPydN8J8OhUPz6p58XcOFMb94/7uQMbqil1ZvveBt4y29bEzY2E
         gENKKDkLgo+HhshocyH1zL8xwK6AwEQrQrFHRPjzMGtKEdNzRb4RjF/CiSj9sjEVE9lq
         5v+SkcvZYX/tSR+XbHZmD5ySdqMkFZDbWQuq/vrOIs5ONHYWbT0k65BxXZ472RgqHkLM
         UwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ckfx1HyP+necpBtslfUI5BcBnDWVmFodI3dlBbJp+Cc=;
        b=rW3X2oi3pt0f+OYP6ubL97ac3Da45t8UTsuf5SSJTMwG3gFm3xpLrLGgj6324om9DM
         C7jccvwis+4aGFIMWJsHUO/MBlE58EUZKKaZz5ctdLDT5q3CSHKK77D2gicMWjZqz8H9
         wwmQ6Ig5AFbqMVjejOAKhiJUMuDwBhdbgFpfl7R2vFKIlmls5NBhYvVHhVkM9OL7ZasA
         70xjl+9qBnEfAQKRANLliCnm1WziDu1uR86VEHaBDm8WK0prKdccmHRUHZaGLw/LvukC
         mk8oKaJKoMt2+oFquQZH7mb11y439wPCqp3I8NwQ0Fiq2OTK1q2HMP29gREGYxrQOss9
         Eypg==
X-Gm-Message-State: APt69E3JZ0S5QQO8oRYlgfhavBC0AlvXGAp8ArX90LGd3l8l7egLaSYt
        gcvmhdc7MgZWSErwDCn9ZBs=
X-Google-Smtp-Source: ADUXVKLUGA6nKnCiy6bFrBtbRCTmFrSOFyZeG5kwb5nyRA1466DodMty+nyPo22nXo5s5HSKo0BEqQ==
X-Received: by 2002:a37:444c:: with SMTP id r73-v6mr15252297qka.351.1528116261050;
        Mon, 04 Jun 2018 05:44:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6990:e1e1:697d:a15? ([2001:4898:8010:0:52c6:e1e1:697d:a15])
        by smtp.gmail.com with ESMTPSA id j13-v6sm15041471qtj.23.2018.06.04.05.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 05:44:20 -0700 (PDT)
Subject: Re: [PATCH v3 18/20] commit-graph: add '--reachable' option
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-19-dstolee@microsoft.com> <86k1rhrt1u.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4dccf288-ccf1-6819-4112-00432db1ddc6@gmail.com>
Date:   Mon, 4 Jun 2018 08:44:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86k1rhrt1u.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 1:34 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> When writing commit-graph files, it can be convenient to ask for all
>> reachable commits (starting at the ref set) in the resulting file. This
>> is particularly helpful when writing to stdin is complicated, such as a
>> future integration with 'git gc' which will call
>> write_commit_graph_reachable() after performing cleanup of the object
>> database.
> Nice.
>
> The last sentence of the commit message is a bit long, though, in my
> opinion.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt |  8 ++++++--
>>   builtin/commit-graph.c             | 16 ++++++++++++----
>>   commit-graph.c                     | 32 ++++++++++++++++++++++++++++++++
>>   commit-graph.h                     |  1 +
>>   t/t5318-commit-graph.sh            | 10 ++++++++++
>>   5 files changed, 61 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index a222cfab08..dececb79d7 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in packfiles.
>>   +
>>   With the `--stdin-packs` option, generate the new commit graph by
>>   walking objects only in the specified pack-indexes. (Cannot be combined
>> -with --stdin-commits.)
>> +with `--stdin-commits` or `--reachable`.)
>>   +
>>   With the `--stdin-commits` option, generate the new commit graph by
>>   walking commits starting at the commits specified in stdin as a list
>>   of OIDs in hex, one OID per line. (Cannot be combined with
>> ---stdin-packs.)
>> +`--stdin-packs` or `--reachable`.)
>> ++
>> +With the `--reachable` option, generate the new commit graph by walking
>> +commits starting at all refs. (Cannot be combined with `--stdin-commits`
>> +or `--stdin-packs`.)
> All right (though I wonder a bit about the restriction).
>
> I think it might be a good idea to describe all of this in the usage
> string for the 'git commit-graph write', instead of using '<options>'
> placeholder, that is instead of current:
>
>    'git commit-graph write' <options> [--object-dir <dir>]
>
> use
>
>    'git commit-graph write' [--stdin-commits | --stdin-packs | --reachable]
>                             [--append] [--object-dir <dir>]
>
> or something like that.
>
>>   +
>>   With the `--append` option, include all commits that are present in the
>>   existing commit-graph file.
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 0433dd6e20..20ce6437ae 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] = {
>>   	N_("git commit-graph [--object-dir <objdir>]"),
>>   	N_("git commit-graph read [--object-dir <objdir>]"),
>>   	N_("git commit-graph verify [--object-dir <objdir>]"),
>> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
>> +	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
> All right, very straightforward.  I guess they are put in [almost]
> alphabetical order, or is there some other reasoning behind the ordering
> used (which is different from the one in the manpage)?
>
>>   	NULL
>>   };
>>   
>> @@ -24,12 +24,13 @@ static const char * const builtin_commit_graph_read_usage[] = {
>>   };
>>   
>>   static const char * const builtin_commit_graph_write_usage[] = {
>> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
>> +	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
> The same.
>
>>   	NULL
>>   };
>>   
>>   static struct opts_commit_graph {
>>   	const char *obj_dir;
>> +	int reachable;
>>   	int stdin_packs;
>>   	int stdin_commits;
>>   	int append;
>> @@ -130,6 +131,8 @@ static int graph_write(int argc, const char **argv)
>>   		OPT_STRING(0, "object-dir", &opts.obj_dir,
>>   			N_("dir"),
>>   			N_("The object directory to store the graph")),
>> +		OPT_BOOL(0, "reachable", &opts.reachable,
>> +			N_("start walk at all refs")),
> Errr... does '--no-reachable' makes sense?  Because if I am right
> currently it is supported, isn't it.

True, but the same holds for many arguments in the codebase. Just 
looking at 'git apply' as a sample, it uses OPT_BOOL for "numstat", 
"summary", "check", "index", "cached", "apply", and "no-add" (so 
"--no-no-add" works?). I think accepting "--no-reachable" is fine, since 
it will set opts.reachable = 0 and we will not use the reachable option.

>
>>   		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
>>   			N_("scan pack-indexes listed by stdin for commits")),
>>   		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
>> @@ -143,11 +146,16 @@ static int graph_write(int argc, const char **argv)
>>   			     builtin_commit_graph_write_options,
>>   			     builtin_commit_graph_write_usage, 0);
>>   
>> -	if (opts.stdin_packs && opts.stdin_commits)
>> -		die(_("cannot use both --stdin-commits and --stdin-packs"));
>> +	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
> Nice trick.
>
>> +		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
> It is a pity that parseopt API does not have direct support for mutually
> exclusive groups of boolean options, like ArgumentParser.add_mutually_exclusive_group()
> in Python's argparse.
>
> Still, you need to use what it is there.
>
>>   	if (!opts.obj_dir)
>>   		opts.obj_dir = get_object_directory();
>>   
>> +	if (opts.reachable) {
>> +		write_commit_graph_reachable(opts.obj_dir, opts.append);
>> +		return 0;
>> +	}
> Just using the option.
>
>> +
>>   	if (opts.stdin_packs || opts.stdin_commits) {
>>   		struct strbuf buf = STRBUF_INIT;
>>   		lines_nr = 0;
>> diff --git a/commit-graph.c b/commit-graph.c
>> index a33600c584..057d734926 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -6,6 +6,7 @@
>>   #include "packfile.h"
>>   #include "commit.h"
>>   #include "object.h"
>> +#include "refs.h"
>>   #include "revision.h"
>>   #include "sha1-lookup.h"
>>   #include "commit-graph.h"
>> @@ -651,6 +652,37 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
>>   	}
>>   }
>>   
>> +struct hex_list {
>> +	char **hex_strs;
>> +	int hex_nr;
>> +	int hex_alloc;
>> +};
> Is this what git-for-each-ref / git-branch / git-tag uses?
>
> Would it be possible to use for example string-list API (documented in
> string-list.h) instead?  Anyway, it looks like the use of allocation
> growing API is simple enough... though perhaps it could be made simpler
> by noticing that all strings have the same width.

I should use the string-list API for more than just this list of 
strings. I'll add a new commit that replaces the `const char **` 
parameters from write_commit_graph(), then this commit becomes much simpler.

>
>> +
>> +static int add_ref_to_list(const char *refname,
>> +			   const struct object_id *oid,
>> +			   int flags, void *cb_data)
>> +{
>> +	struct hex_list *list = (struct hex_list*)cb_data;
>> +
>> +	ALLOC_GROW(list->hex_strs, list->hex_nr + 1, list->hex_alloc);
>> +	list->hex_strs[list->hex_nr] = xcalloc(GIT_MAX_HEXSZ + 1, 1);
>> +	strcpy(list->hex_strs[list->hex_nr], oid_to_hex(oid));
> Wouldn't it be better to use strdup or xstrdup instead of
> xcalloc+strcpy?
>
>> +	list->hex_nr++;
>> +	return 0;
>> +}
>> +
>> +void write_commit_graph_reachable(const char *obj_dir, int append)
>> +{
>> +	struct hex_list list;
>> +	list.hex_nr = 0;
>> +	list.hex_alloc = 128;
>> +	ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
>> +
>> +	for_each_ref(add_ref_to_list, &list);
>> +
>> +	write_commit_graph(obj_dir, NULL, 0, (const char **)list.hex_strs, list.hex_nr, append);
> Where do we free the allocated data and allocated strings?  If they are
> cleaned by process exit, perhaps they need to be UNLEAK-ed?
>
>> +}
>> +
>>   void write_commit_graph(const char *obj_dir,
>>   			const char **pack_indexes,
>>   			int nr_packs,
>> diff --git a/commit-graph.h b/commit-graph.h
>> index 71a39c5a57..9a06a5f188 100644
>> --- a/commit-graph.h
>> +++ b/commit-graph.h
>> @@ -46,6 +46,7 @@ struct commit_graph {
>>   
>>   struct commit_graph *load_commit_graph_one(const char *graph_file);
>>   
>> +void write_commit_graph_reachable(const char *obj_dir, int append);
>>   void write_commit_graph(const char *obj_dir,
>>   			const char **pack_indexes,
>>   			int nr_packs,
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 4941937163..a659620332 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -205,6 +205,16 @@ test_expect_success 'build graph from commits with append' '
>>   graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
>>   graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
>>   
>> +test_expect_success 'build graph using --reachable' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git commit-graph write --reachable &&
>> +	test_path_is_file $objdir/info/commit-graph &&
>> +	graph_read_expect "11" "large_edges"
>> +'
> All right, here we check that commit-graph has expected features (11
> commits, and large_edges optional chunk).
>
> Perhaps we could also check that different equivalent ways of creating
> serialized commit graph file produce byte-for-byte identical file?
>
>> +
>> +graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
>> +graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
> All right, this supposedly tests that behavior does not change whether
> we are using or we are not using the commit-graph feature... but I have
> just noticed that raph_git_two_modes() uses `git -c core.graph=true`;
> shouldn't it be `git -c core.commitGraph=true`?

WOW good catch. I've sent a patch to fix that immediately, as these 
tests are not doing what they should (verify the core.commitGraph 
setting does not change the output of the walk).

>
>> +
>>   test_expect_success 'setup bare repo' '
>>   	cd "$TRASH_DIRECTORY" &&
>>   	git clone --bare --no-local full bare &&

