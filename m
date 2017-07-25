Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1DA203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbdGYAJg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 20:09:36 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34141 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbdGYAJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 20:09:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id 123so63581185pgj.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BZ6T6mC/PWKpsjMmjgeQ70nRL7xv953H3azBHN7CuE=;
        b=ugO08AlbFOhc6ayv69F/BxZe5Sk3AS6o7hipyUEL1169FOwxsQp+XX1SETrURgVY5f
         nslkUgv2AMpLVSemy+dr9e0qzU/X1pbMrh5rt/VUGmaabMbVth4zyMXnoGliN/WEFMVf
         XvQUWXVXLMa0e0beMRFzV99QcsWXIPLZLbL4/e6bSODQHVLogR7kdTyWvghHzp1FqWjZ
         QIZzPMU/nrMGg+IF4RynPqoAJiPqsWwecyNG4oJrOn6D1R4Z8emPqF+4k8PcU7AV/FgG
         vv8m0rb/ZO0ul3m0RQ1I81NuTOWaooSkiAqhvjPljZ4Q8PJcnjTwmEfRQ3FIgIkZgsxT
         IlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BZ6T6mC/PWKpsjMmjgeQ70nRL7xv953H3azBHN7CuE=;
        b=KwrinIJHzBhB5byFIeLhvLAqDKwHWZ3ceroX0ktQ9JZN3pxS0TaDVjNiIhTXgx9xU8
         IsqPrVuZvD9kLpoISH3vsj7Xg3YIZu2WfYJULdwKKuXn0DJ1tewTN+yiwvQ1o8TH+J9a
         HC84ztD62owIGJZ8fsgmUk5z9t3DooD6Oklqq1/MFd9OTcfCPRwFb7hxi8gul9E32khk
         2tHlRxkKFv1jQRcOEZiWVqAoRqTwbp0Y4lI0e9TuupXuge7xJYSjI8rEuVYBp5YfA/57
         eNy5eq8HIljZDLy08Rdcuz5tkeFpgNJG8WBx1jnS8VpyqwVevf6Nr1la5TIU/ZxuEtkH
         RkPQ==
X-Gm-Message-State: AIVw112OfuX8a7LK+bpG6uwadENQWAoA2nPrsvSbKqMjbMBKVRnV2XPW
        IwjPCJp+6L3aNhal
X-Received: by 10.84.229.8 with SMTP id b8mr18941843plk.93.1500941374463;
        Mon, 24 Jul 2017 17:09:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id i67sm20863412pfc.122.2017.07.24.17.09.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 17:09:33 -0700 (PDT)
Date:   Mon, 24 Jul 2017 17:09:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
Message-ID: <20170725000932.GE92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-9-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-9-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> The submodule subcommand 'summary' is ported in the process of
> making git-submodule a builtin. The function cmd_summary() from
> git-submodule.sh is ported to functions module_summary(),
> compute_summary_module_list(), prepare_submodule_summary() and
> print_submodule_summary().
> 
> The first function module_summary() parses the options of submodule
> subcommand and also acts as the front-end of this subcommand.
> After parsing them, it calls the compute_summary_module_list()
> 
> The functions compute_summary_module_list() runs the diff_cmd,
> and generates the modules list, as required by the subcommand.
> The generation of this module list is done by the using the
> callback function submodule_summary_callback(), and stored in the
> structure module_cb.
> 
> Once the module list is generated, prepare_submodule_summary()
> further goes through the list and filters the list, for
> eventually calling the print_submodule_summary() function.
> 
> Finally, the print_submodule_summary() takes care of generating
> and printing the summary for each submodule.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>

This is a big one, hopefully I can try to understand everything that is
happening.

> ---
> In this new version of patch, following changes were made:
> * the way of generating sub_sha1_src and sub_sha1_dst (abbrev of sha1_src
>   and sha1_dst resp.) were changed. Since there was no direct way of
>   abbrevating a string(sha1_dst), in this patch sha1_dst was converted first
>   to an object id (converting to sha1 was avoided) and then abbrevated using
>   find_unique_abbrev().
> * A few big if() statements were reduced.
> * for reducing the two big if() statements, a new function
>   verify_submodule_object_name() was introduced.
> * this new version also corrects a few other nits.
> 
>  builtin/submodule--helper.c | 428 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 182 +------------------
>  2 files changed, 429 insertions(+), 181 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5e84fc42d..94d6254f0 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,9 @@
>  #include "remote.h"
>  #include "refs.h"
>  #include "connect.h"
> +#include "revision.h"
> +#include "diffcore.h"
> +#include "diff.h"
>  
>  typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
>  				      void *cb_data);
> @@ -762,6 +765,430 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct module_cb {
> +	unsigned int mod_src;
> +	unsigned int mod_dst;
> +	struct object_id oid_src;
> +	struct object_id oid_dst;
> +	char status;
> +	const char *sm_path;
> +};
> +#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
> +
> +struct module_cb_list {
> +	struct module_cb **entries;
> +	int alloc, nr;
> +};
> +#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
> +
> +struct summary_cb {
> +	int argc;
> +	const char **argv;
> +	const char *prefix;
> +	char *diff_cmd;
> +	unsigned int cached: 1;
> +	unsigned int for_status: 1;
> +	unsigned int quiet: 1;
> +	unsigned int files: 1;
> +	int summary_limits;
> +};
> +#define SUMMARY_CB_INIT { 0, NULL, NULL, NULL, 0, 0, 0, 0, 0 }
> +
> +static int verify_submodule_object_name(const char *sm_path, const char *sha1)
> +{
> +	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +	cp_rev_parse.git_cmd = 1;
> +	cp_rev_parse.no_stdout = 1;
> +	cp_rev_parse.dir = sm_path;
> +	prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> +			 "--verify", NULL);
> +	argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
> +
> +	if (run_command(&cp_rev_parse))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void print_submodule_summary(struct summary_cb *info,
> +				    struct module_cb *p)
> +{

This is one large function so it may be difficult to keep track of
everything and I don't know how easy it would be to split.

> +	int missing_src = 0;
> +	int missing_dst = 0;
> +	char *displaypath;
> +	const char *sha1_abbr_src;
> +	const char *sha1_abbr_dst;
> +	struct object_id oid_dst;
> +	int errmsg = 0;
> +	int total_commits = -1;
> +	const char *sha1_dst = oid_to_hex(&p->oid_dst);
> +	const char *sha1_src = oid_to_hex(&p->oid_src);

You have these two variables which are defined as 'const char *' yet you
allocate memory for them at different points via 'xstrdup' and then
never free it.  Really what you should be trying to do is use 'struct
object_id' as much as you can instead of storing the hash in hex form.
that way you can use 'oidcmp' instead of 'strcmp' at some points in the
code.  At one point you then convert back to an oid from hex.  When you
get output from a capture_command call and then dup the hex string, what
you really should do is convert the hex  SHA1 directly to an OID and use
it in OID form as much as possible.  Then you can convert it back to a
hex string at the point of use.  It just seems clunky to pass around hex
strings instead of the OID itself.

> +	char *sm_git_dir = xstrfmt("%s/.git", p->sm_path);

This variable is never freed.

> +	int is_sm_git_dir = 0;
> +
> +	if (!info->cached && !strcmp(sha1_dst, sha1_to_hex(null_sha1))) {
> +		if (S_ISGITLINK(p->mod_dst)) {
> +			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +			struct strbuf sb_rev_parse = STRBUF_INIT;
> +
> +			cp_rev_parse.git_cmd = 1;
> +			cp_rev_parse.no_stderr = 1;
> +			cp_rev_parse.dir = p->sm_path;
> +			prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +			argv_array_pushl(&cp_rev_parse.args,
> +					 "rev-parse", "HEAD", NULL);
> +			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> +				strbuf_strip_suffix(&sb_rev_parse, "\n");
> +				sha1_dst = xstrdup(sb_rev_parse.buf);
> +			}
> +			strbuf_release(&sb_rev_parse);
> +		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> +			struct child_process cp_hash_object = CHILD_PROCESS_INIT;
> +			struct strbuf sb_hash_object = STRBUF_INIT;
> +
> +			cp_hash_object.git_cmd = 1;
> +			argv_array_pushl(&cp_hash_object.args,
> +					 "hash-object", p->sm_path,
> +					 NULL);
> +			if (!capture_command(&cp_hash_object,
> +					     &sb_hash_object, 0)) {
> +				strbuf_strip_suffix(&sb_hash_object, "\n");
> +				sha1_dst = xstrdup(sb_hash_object.buf);
> +			}
> +			strbuf_release(&sb_hash_object);
> +		} else {
> +			if (p->mod_dst)
> +				die(_("unexpected mode %d\n"), p->mod_dst);
> +		}
> +	}
> +
> +	if (is_git_directory(sm_git_dir))
> +		is_sm_git_dir = 1;
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
> +		missing_src = verify_submodule_object_name(p->sm_path,
> +							   sha1_src);
> +
> +	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
> +		missing_dst = verify_submodule_object_name(p->sm_path,
> +							   sha1_dst);
> +
> +	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
> +
> +	if (!missing_dst && !missing_src) {
> +		if (is_sm_git_dir) {
> +			struct child_process cp_rev_list = CHILD_PROCESS_INIT;
> +			struct strbuf sb_rev_list = STRBUF_INIT;
> +			char *range;
> +
> +			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
> +				range = xstrfmt("%s...%s", sha1_src, sha1_dst);
> +			else if (S_ISGITLINK(p->mod_src))
> +				range = xstrdup(sha1_src);
> +			else
> +				range = xstrdup(sha1_dst);
> +
> +			cp_rev_list.git_cmd = 1;
> +			cp_rev_list.dir = p->sm_path;
> +			prepare_submodule_repo_env(&cp_rev_list.env_array);
> +
> +			argv_array_pushl(&cp_rev_list.args, "rev-list",
> +					 "--first-parent", range, "--", NULL);
> +			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
> +				if (sb_rev_list.len)
> +					total_commits = count_lines(sb_rev_list.buf,
> +								    sb_rev_list.len);
> +				else
> +					total_commits = 0;
> +			}
> +
> +			free(range);
> +			strbuf_release(&sb_rev_list);
> +		}
> +	} else {
> +		errmsg = 1;
> +	}
> +
> +	get_oid_hex(sha1_dst, &oid_dst);
> +
> +	sha1_abbr_src = find_unique_abbrev(p->oid_src.hash, 7);
> +	sha1_abbr_dst = find_unique_abbrev(oid_dst.hash, 7);
> +
> +	if (p->status == 'T') {
> +		if (S_ISGITLINK(p->mod_dst))
> +			printf(_("* %s %s(blob)->%s(submodule)"),
> +				 displaypath, sha1_abbr_src,
> +				 sha1_abbr_dst);
> +		else
> +			printf(_("* %s %s(submodule)->%s(blob)"),
> +				 displaypath, sha1_abbr_src,
> +				 sha1_abbr_dst);
> +	} else {
> +			printf("* %s %s...%s", displaypath, sha1_abbr_src,
> +				 sha1_abbr_dst);
> +	}
> +
> +	if (total_commits < 0)
> +		printf(":\n");
> +	else
> +		printf(" (%d):\n", total_commits);
> +
> +	if (errmsg) {
> +		/*
> +		 * Don't give error msg for modification whose dst is not
> +		 * submodule, i.e. deleted or changed to blob
> +		 */
> +		if (S_ISGITLINK(p->mod_src)) {
> +			if (missing_src && missing_dst) {
> +				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
> +				 displaypath, sha1_src, sha1_dst);
> +			} else if (missing_src) {
> +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> +				 displaypath, sha1_src);
> +			} else {
> +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> +				 displaypath, sha1_dst);
> +			}
> +		}
> +	} else if (is_sm_git_dir) {
> +		struct child_process cp_log = CHILD_PROCESS_INIT;
> +
> +		cp_log.git_cmd = 1;
> +		cp_log.dir = p->sm_path;
> +		prepare_submodule_repo_env(&cp_log.env_array);
> +		argv_array_pushl(&cp_log.args, "log", NULL);
> +
> +		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
> +			if (info->summary_limits > 0)
> +				argv_array_pushf(&cp_log.args, "-%d", info->summary_limits);
> +
> +			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
> +					 "--first-parent", NULL);
> +			argv_array_pushf(&cp_log.args, "%s...%s", sha1_src,
> +					 sha1_dst);
> +		} else if (S_ISGITLINK(p->mod_dst)) {
> +			argv_array_pushl(&cp_log.args, "--pretty=  > %s",
> +					 "-1", sha1_dst, NULL);
> +		} else {
> +			argv_array_pushl(&cp_log.args, "--pretty=  < %s",
> +					 "-1", sha1_src, NULL);
> +		}
> +
> +		run_command(&cp_log);
> +	}
> +	printf("\n");
> +
> +	free(displaypath);
> +}
> +
> +static void prepare_submodule_summary(struct summary_cb *info,
> +				      struct module_cb_list *list)
> +{
> +	int i;
> +	for (i = 0; i < list->nr; i++) {
> +		struct module_cb *p = list->entries[i];
> +		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +		if (p->status == 'D' || p->status == 'T') {
> +			print_submodule_summary(info, p);
> +			continue;
> +		}
> +
> +		if (info->for_status) {
> +			char *config_key;
> +			const char *ignore_config = "none";
> +			const char *value;
> +			const struct submodule *sub = submodule_from_path(null_sha1, p->sm_path);
> +
> +			if (sub && p->status != 'A') {
> +				config_key = xstrfmt("submodule.%s.ignore",
> +						     sub->name);
> +				if (!git_config_get_value(config_key, &value))
> +					ignore_config = value;
> +				else if (sub->ignore)
> +					ignore_config = sub->ignore;

Since this is a string it may make sense to use
'git_config_get_string_const' instead of '_value', unless you had a
reason for using value the over string variant.

> +
> +				free(config_key);
> +
> +				if (!strcmp(ignore_config, "all"))
> +					continue;
> +			}
> +		}
> +
> +		/* Also show added or modified modules which are checked out */
> +		cp_rev_parse.dir = p->sm_path;
> +		cp_rev_parse.git_cmd = 1;
> +		cp_rev_parse.no_stderr = 1;
> +		cp_rev_parse.no_stdout = 1;
> +
> +		argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> +				 "--git-dir", NULL);
> +
> +		if (!run_command(&cp_rev_parse))
> +			print_submodule_summary(info, p);
> +	}
> +}
> +
> +static void submodule_summary_callback(struct diff_queue_struct *q,
> +				       struct diff_options *options,
> +				       void *data)
> +{
> +	int i;
> +	struct module_cb_list *list = data;
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		struct module_cb *temp;
> +
> +		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
> +			continue;
> +		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
> +		temp->mod_src = p->one->mode;
> +		temp->mod_dst = p->two->mode;
> +		temp->oid_src = p->one->oid;
> +		temp->oid_dst = p->two->oid;
> +		temp->status = p->status;
> +		temp->sm_path = xstrdup(p->one->path);
> +
> +		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> +		list->entries[list->nr++] = temp;
> +	}
> +}
> +
> +static int compute_summary_module_list(char *head, struct summary_cb *info)

Make 'head' a 'const char *' since you aren't modifying it in the
function.

> +{
> +	struct argv_array diff_args = ARGV_ARRAY_INIT;
> +	struct rev_info rev;
> +	struct module_cb_list list = MODULE_CB_LIST_INIT;
> +
> +	argv_array_push(&diff_args, info->diff_cmd);
> +	if (info->cached)
> +		argv_array_push(&diff_args, "--cached");
> +	argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
> +			 NULL);
> +	if (head)
> +		argv_array_push(&diff_args, head);
> +	argv_array_push(&diff_args, "--");
> +	if (info->argc)
> +		argv_array_pushv(&diff_args, info->argv);
> +
> +	git_config(git_diff_basic_config, NULL);
> +	init_revisions(&rev, info->prefix);
> +	gitmodules_config();
> +	rev.abbrev = 0;
> +	precompose_argv(diff_args.argc, diff_args.argv);

What's the purpose of the precompose call?

> +
> +	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> +					 &rev, NULL);
> +	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = submodule_summary_callback;
> +	rev.diffopt.format_callback_data = &list;
> +
> +	if (!info->cached) {
> +		if (!strcmp(info->diff_cmd, "diff-index"))
> +			setup_work_tree();
> +		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +			perror("read_cache_preload");
> +			return -1;
> +		}
> +	} else if (read_cache() < 0) {
> +		perror("read_cache");
> +		return -1;
> +	}

I'm not understanding this hunk of code.  Why are you using
read_cache_preload in one part and read_cache in another?  also if you
could use read_index instead of read_cache that would be great.  We want
to reduce the number of cache macros that are used and replace them with
the 'index' flavor.

> +
> +	if (!strcmp(info->diff_cmd, "diff-index"))
> +		run_diff_index(&rev, info->cached);
> +	else
> +		run_diff_files(&rev, 0);
> +	prepare_submodule_summary(info, &list);

'list' has a bunch of allocated entries which need to be freed here.

> +
> +	return 0;
> +
> +}
> +
> +static int module_summary(int argc, const char **argv, const char *prefix)
> +{
> +	struct summary_cb info = SUMMARY_CB_INIT;
> +	int cached = 0;
> +	char *diff_cmd = "diff-index";
> +	int for_status = 0;
> +	int quiet = 0;
> +	int files = 0;
> +	int summary_limits = -1;
> +	struct child_process cp_rev = CHILD_PROCESS_INIT;
> +	char *head;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	struct option module_summary_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> +		OPT_BOOL(0, "cached", &cached, N_("Use the commit stored in the index instead of the submodule HEAD")),
> +		OPT_BOOL(0, "files", &files, N_("To compares the commit in the index with that in the submodule HEAD")),
> +		OPT_BOOL(0, "for-status", &for_status, N_("Skip submodules with 'all' ignore_config value")),
> +		OPT_INTEGER('n', "summary-limits", &summary_limits, N_("Limit the summary size")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper summary [<options>] [--] [<path>]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_summary_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (!summary_limits)
> +		return 0;
> +
> +	cp_rev.git_cmd = 1;
> +	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> +			 argc ? argv[0] : "HEAD", NULL);
> +
> +	if (!capture_command(&cp_rev, &sb, 0)) {
> +		strbuf_strip_suffix(&sb, "\n");
> +		if (argc) {
> +			argv++;
> +			argc--;
> +		}
> +	} else if (!argc || !strcmp(argv[0], "HEAD")) {
> +		/* before the first commit: compare with an empty tree */
> +		struct stat st;
> +		unsigned char sha1[20];

Use a 'struct object_id' here.  There's no reason to use sha1's 20 char
arrays anymore.  If you need to use a call that takes an unsigned char
array you can always pass oid.hash.  This limits the amount of
conversion we'll have to do later.

> +		if (fstat(0, &st) < 0 || index_fd(sha1, 0, &st, 2, prefix, 3))

What's the reasoning behind the fstat and index_fd call?  Not saying
they aren't needed I just need more context to understand whats going
on.

> +			die("Unable to add %s to database", sha1);
> +		strbuf_addstr(&sb, sha1_to_hex(sha1));
> +		if (argc) {
> +			argv++;
> +			argc--;
> +		}
> +	} else {
> +		strbuf_addstr(&sb, "HEAD");
> +	}
> +
> +	head = strbuf_detach(&sb, NULL);

So head is a 'char *' and it is never freed.  You should free it at the
end of this function to prevent memleaks.

> +
> +	if (files) {
> +		if (cached)
> +			die(_("The --cached option cannot be used with the --files option"));
> +		diff_cmd = "diff-files";
> +		head = NULL;

If you are assigning NULL here make sure that you free head first as you
could have allocated memory which head is already pointing to.

> +	}
> +
> +	info.argc = argc;
> +	info.argv = argv;
> +	info.prefix = prefix;
> +	info.cached = cached;
> +	info.for_status = for_status;
> +	info.quiet = quiet;
> +	info.files = files;
> +	info.summary_limits = summary_limits;
> +	info.diff_cmd = diff_cmd;

You aren't doing the '!!' trick here like you did in the other patches.
Any reason for that?

> +
> +	return compute_summary_module_list(head, &info);
> +}
> +

-- 
Brandon Williams
