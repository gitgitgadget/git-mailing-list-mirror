Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E1220467
	for <e@80x24.org>; Thu, 12 Oct 2017 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbdJLUPD (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:15:03 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:52749 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdJLUPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:15:02 -0400
Received: by mail-qk0-f177.google.com with SMTP id b15so2618585qkg.9
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E30bU0h49o89bMM2EBJGLElBWp8tCLVOuX1Xj6QOCJs=;
        b=ewpBlClKcj+9CJoUMXQ+k3sPz/s8ETEvLh6+HLNqntDCD5slupsObc0Cbvt+uwwHs6
         UKnYXppwwfrPGAQ7xGWUMqqk2bjyl02vkWT5eaO5ja7LY6Xhg/PZAp2WsyMJRkTte1T3
         HuMjWpnkBwBtQHSgNkPqLAVsXzY8WMcxG7DDATRReR+2AvcVSj69IZ6JcaIHbuuBGHzZ
         4O+YYmDqiTEABZYtA0T6F3jxgkyLXRi7olJzkU0DsMBtamuANz6C72r/sREQ524AypMN
         kVI/sRq2VJKE8/346IsBPR/TJS+agA9+aOuKpZ25BjnSpzq1ev0TczsU2q2Ket1xELgB
         1dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E30bU0h49o89bMM2EBJGLElBWp8tCLVOuX1Xj6QOCJs=;
        b=DBJwbcaUleOAIOqYprTopqP/P4/kAdY8o1T2SLBhXQmiAScjhnFaskojJ2dj2Q79yh
         29NsHX92PZ4HEKTe4j/P49ASn8CawJKagsqkCMcth2G3YfEvM9BTCynClS1aXgHgCj1f
         /aqi//oBhZXN0xKv10xmCp2qO2UYkWeYVZSLy41qNAVxiVsEoDdmkDIWCaN42Pfm8iNH
         8BooFDLTmgqUiOxTuCSNZj/3woNxiH9v/9H1yosZwqEuP3fTRfCyU154A6W8zjzJZgWX
         loX8/zE0MmKNsWkTMnV69qMoxVsVPDOUU0sto5kSUwOp/kUYPPnrqzxPyXvfqkJImtVa
         Mg4Q==
X-Gm-Message-State: AMCzsaUPg9myDUUy1O3hLwut6cYRFNyJAZkwm/Oa6fP941M/sWWYBIa4
        UTU451HCiIUCKlXqKRZWuO4=
X-Google-Smtp-Source: ABhQp+SZtJIbmon3XtFQ/YcYYPtDU4MAiG4mDPk4Dg25P3cYQhb48kTIr2qr/vfmAugAg664GgF46A==
X-Received: by 10.55.153.69 with SMTP id b66mr2251410qke.107.1507839301734;
        Thu, 12 Oct 2017 13:15:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c52sm10372850qtc.24.2017.10.12.13.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 13:15:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] Teach status options around showing ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
 <20171011133504.15049-2-jamill@microsoft.com>
 <xmqqy3oh13of.fsf@gitster.mtv.corp.google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <6a245436-dfce-fac2-3361-f9da07526ac0@gmail.com>
Date:   Thu, 12 Oct 2017 16:15:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3oh13of.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2017 10:49 PM, Junio C Hamano wrote:
> Jameson Miller <jameson.miller81@gmail.com> writes:
>
>> This change teaches the status command more options to control which
>> ignored files are reported independently of the which untracked files
>> are reported by allowing the `--ignored` option to take additional
>> arguments.  Currently, the shown ignored files are linked to how
>> untracked files are reported. Both ignored and untracked files are
>> controlled by arguments to `--untracked-files` option. This makes it
>> impossible to show all untracked files individually, but show ignored
>> "files and directories" (that is, ignored directories are shown as 1
>> entry, instead of having all contents shown).
> The description makes sense.  And it makes sense to show a directory
> known to contain only ignored paths as just one entry, instead of
> exploding that to individual files.
>
>> Our application (Visual Studio) has a specific set of requirements
>> about how it wants untracked / ignored files reported by git status.
> This sentence does not read well.  VS has no obligation to read from
> "git status", so there is no "specific set of requirements" that
> make us care.  If the output from "status" is insufficient you could
> be reading from "ls-files --ignored", for example, if you want more
> details than "git status" gives you.
>
> The sentence, and the paragraph that immediately follows it, need a
> serious attitude adjustment ;-), even though it is good as read as
> an explanation of what the proposed output wants to show.

It was not my intention to have this paragraph come across this
way. I meant to express the ideal format of data that our
application would like (from whatever source) as motivation for
why we are proposing these changes. I will reword this
paragraph to remove any unintended implication otherwise.

>> The reason for controlling these behaviors separately is that there
>> can be a significant performance impact to scanning the contents of
>> excluded directories. Additionally, knowing whether a directory
>> explicitly matches an exclude pattern can help the application make
>> decisions about how to handle the directory. If an ignored directory
>> itself matches an exclude pattern, then the application will know that
>> any files underneath the directory must be ignored as well.
> While the above description taken standalone makes sense, doesn't
> the "we want all paths listed, without abbreviated to the directory
> and requiring the reader to infer from the fact that aidrectory is
> shown that everything in it are ignored" the log message stated
> earlier contradict another change you earlier sent, that avoids
> scanning a directory that is known to be completely untracked
> (i.e. no path under it in the index) and return early once an
> untracked file is found in it?

My first set of changes introduced a perf optimization without
any functional changes. The perf optimization was to avoid
scanning a directory that is known to be ignored (i.e no path
under it in the index and the directory matches an exclude
pattern). It returns early once any file is found in it. Any file
found must be ignored, as it is contained in an ignored
directory.

This second set of changes is to allow optional decoupling of how
ignored and untracked items are reported.

>
>> Signed-off-by: Jameson Miller <jamill@microsoft.com>
>> ---
>>   builtin/commit.c | 31 +++++++++++++++++++++++++------
>>   dir.c            | 24 ++++++++++++++++++++++++
>>   dir.h            |  3 ++-
>>   wt-status.c      | 11 ++++++++---
>>   wt-status.h      |  8 +++++++-
>>   5 files changed, 66 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index d75b3805ea..98d84d0277 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -118,7 +118,7 @@ static int edit_flag = -1; /* unspecified */
>>   static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>>   static int config_commit_verbose = -1; /* unspecified */
>>   static int no_post_rewrite, allow_empty_message;
>> -static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
>> +static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>>   static char *sign_commit;
>>   
>>   /*
>> @@ -139,7 +139,7 @@ static const char *cleanup_arg;
>>   static enum commit_whence whence;
>>   static int sequencer_in_use;
>>   static int use_editor = 1, include_status = 1;
>> -static int show_ignored_in_status, have_option_m;
>> +static int have_option_m;
>>   static struct strbuf message = STRBUF_INIT;
>>   
>>   static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>> @@ -1075,6 +1075,19 @@ static const char *find_author_by_nickname(const char *name)
>>   	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
>>   }
>>   
>> +static void handle_ignored_arg(struct wt_status *s)
>> +{
>> +	if (!ignored_arg)
>> +		; /* default already initialized */
>> +	else if (!strcmp(ignored_arg, "traditional"))
>> +		s->show_ignored_mode = SHOW_TRADITIONAL_IGNORED;
>> +	else if (!strcmp(ignored_arg, "no"))
>> +		s->show_ignored_mode = SHOW_NO_IGNORED;
>> +	else if (!strcmp(ignored_arg, "matching"))
>> +		s->show_ignored_mode = SHOW_MATCHING_IGNORED;
>> +	else
>> +		die(_("Invalid ignored mode '%s'"), ignored_arg);
>> +}
>>   
>>   static void handle_untracked_files_arg(struct wt_status *s)
>>   {
>> @@ -1363,8 +1376,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>   		  N_("mode"),
>>   		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
>>   		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>> -		OPT_BOOL(0, "ignored", &show_ignored_in_status,
>> -			 N_("show ignored files")),
>> +		{ OPTION_STRING, 0, "ignored", &ignored_arg,
>> +		  N_("mode"),
>> +		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
>> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
>>   		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
>>   		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>>   		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>> @@ -1383,8 +1398,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>   	finalize_deferred_config(&s);
>>   
>>   	handle_untracked_files_arg(&s);
>> -	if (show_ignored_in_status)
>> -		s.show_ignored_files = 1;
>> +	handle_ignored_arg(&s);
>> +
>> +	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
>> +	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
>> +		die(_("Unsupported combination of ignored and untracked-files arguments"));
>> +
>>   	parse_pathspec(&s.pathspec, 0,
>>   		       PATHSPEC_PREFER_FULL,
>>   		       prefix, argv);
>> diff --git a/dir.c b/dir.c
>> index 1d17b800cf..b9af87eca9 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1389,6 +1389,30 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>   	case index_nonexistent:
>>   		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>>   			break;
>> +		if (exclude &&
>> +			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
>> +			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
>> +
>> +			/*
>> +			 * This is an excluded directory and we are
>> +			 * showing ignored paths that match an exclude
>> +			 * pattern.  (e.g. show directory as ignored
>> +			 * only if it matches an exclude pattern).
>> +			 * This path will either be 'path_excluded`
>> +			 * (if we are showing empty directories or if
>> +			 * the directory is not empty), or will be
>> +			 * 'path_none' (empty directory, and we are
>> +			 * not showing empty directories).
>> +			 */
>> +			if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
>> +				return path_excluded;
>> +
>> +			if (read_directory_recursive(dir, istate, dirname, len,
>> +						     untracked, 1, 1, pathspec) == path_excluded)
>> +				return path_excluded;
>> +
>> +			return path_none;
>> +		}
>>   		if (!(dir->flags & DIR_NO_GITLINKS)) {
>>   			unsigned char sha1[20];
>>   			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
>> diff --git a/dir.h b/dir.h
>> index e3717055d1..57b0943dae 100644
>> --- a/dir.h
>> +++ b/dir.h
>> @@ -152,7 +152,8 @@ struct dir_struct {
>>   		DIR_COLLECT_IGNORED = 1<<4,
>>   		DIR_SHOW_IGNORED_TOO = 1<<5,
>>   		DIR_COLLECT_KILLED_ONLY = 1<<6,
>> -		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
>> +		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
>> +		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
>>   	} flags;
>>   	struct dir_entry **entries;
>>   	struct dir_entry **ignored;
>> diff --git a/wt-status.c b/wt-status.c
>> index 6f730ee8f2..8301c84946 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -660,10 +660,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
>>   	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
>>   		dir.flags |=
>>   			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
>> -	if (s->show_ignored_files)
>> +	if (s->show_ignored_mode) {
>>   		dir.flags |= DIR_SHOW_IGNORED_TOO;
>> -	else
>> +
>> +		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
>> +			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
>> +	} else {
>>   		dir.untracked = the_index.untracked;
>> +	}
>> +
>>   	setup_standard_excludes(&dir);
>>   
>>   	fill_directory(&dir, &the_index, &s->pathspec);
>> @@ -1621,7 +1626,7 @@ static void wt_longstatus_print(struct wt_status *s)
>>   	}
>>   	if (s->show_untracked_files) {
>>   		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
>> -		if (s->show_ignored_files)
>> +		if (s->show_ignored_mode)
>>   			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
>>   		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
>>   			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
>> diff --git a/wt-status.h b/wt-status.h
>> index 64f4d33ea1..fe27b465e2 100644
>> --- a/wt-status.h
>> +++ b/wt-status.h
>> @@ -27,6 +27,12 @@ enum untracked_status_type {
>>   	SHOW_ALL_UNTRACKED_FILES
>>   };
>>   
>> +enum show_ignored_type {
>> +	SHOW_NO_IGNORED,
>> +	SHOW_TRADITIONAL_IGNORED,
>> +	SHOW_MATCHING_IGNORED,
>> +};
>> +
>>   /* from where does this commit originate */
>>   enum commit_whence {
>>   	FROM_COMMIT,     /* normal */
>> @@ -70,7 +76,7 @@ struct wt_status {
>>   	int display_comment_prefix;
>>   	int relative_paths;
>>   	int submodule_summary;
>> -	int show_ignored_files;
>> +	enum show_ignored_type show_ignored_mode;
>>   	enum untracked_status_type show_untracked_files;
>>   	const char *ignore_submodule_arg;
>>   	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];

