Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88CA520D18
	for <e@80x24.org>; Mon,  5 Jun 2017 23:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdFEXVD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:21:03 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36026 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdFEXVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:21:02 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so89653225pfg.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFJPTXzMwBiiNN4F3LchZN+c0iS0mD7fTFALiE/cyI0=;
        b=wLmV4QKSncnP3NGKkhQNQn7oVizgiRQHWfSaPaD+XAgvEpgvUmZ0Ne5iAraVzpRHTz
         oKo1CZiy/CTs2fYbGRuu7cvRPoh/SB4k/73XX4VVpCHRLEZX96N7p/S3996NnmBw6wz+
         GHYTCIT7ZpeWSb0BsvFWXDyEva749NDNsAST13L455cMZdBpz06HMrT83vlvchjPSTP+
         A8LjMc3jCIeLmi6PJDBdP6G4bndD7w6uToDEl3zCXkvlI7AJ+xPJasBe7vDUU4LiUaql
         aQwP4LBG0+rvPp3B+79wYG6Ub6xRqYV/StFs+EqBcWV9J8RFfKN/prFllfT9vDC3XpB7
         0ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFJPTXzMwBiiNN4F3LchZN+c0iS0mD7fTFALiE/cyI0=;
        b=jUpmCO0WN8yg93+vJ5Jl0tOtgByv83VzyP6fSv8IBSPgk9esZ9lvJY6R5f86YIAdl5
         ous3QQcKuChtszSYqCXo6agB/geKHIfPYtYmBSvWp5m+hNIIZEwf90LYjppg/6o7xPYI
         qZ53+4h1UYdwPI6SonupGA5OU/iCPtzrxKX9khhaWdWw8zPKdLmTrUqVHNXgrgo7MtSN
         s+cBuJsN9W5NT48aabpq7BUMBGNlrp10v0BUskwO0lzMix2J4OmoieNYgXLNuxvBPfLY
         0lJ3I/ycNtVGiGOLp2wfwnjw+9RNF4nP8396RuS/e3OpUn3w7qbKiYcuF7rOPHX75Gay
         3CmQ==
X-Gm-Message-State: AODbwcCLKeKV5h0lS9jaPhgIPSKWKMrPQJgLyjYSX1YrjX1rnIOo5r4H
        i9N/rkcTJbP484RH
X-Received: by 10.99.159.10 with SMTP id g10mr14339828pge.223.1496704861730;
        Mon, 05 Jun 2017 16:21:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id i17sm52449407pgn.60.2017.06.05.16.21.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 16:21:00 -0700 (PDT)
Date:   Mon, 5 Jun 2017 16:20:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     sbeller@google.com, git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH v2 1/2] submodule: port set_name_rev from shell to C
Message-ID: <20170605232059.GF40426@google.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
 <20170605202529.22959-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605202529.22959-1-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Prathamesh Chavan wrote:
> Since later on we want to port submodule subcommand status, and since
> set_name_rev is part of cmd_status, hence this function is ported. It
> has been ported to function print_name_rev in C, which calls get_name_rev
> to get the revname, and after formatting it, print_name_rev prints it.
> And hence in this way, the command `git submodule--helper print-name-rev
> "sm_path" "sha1"` sets value of revname in git-submodule.sh
> 
> The function get_name_rev returns the stdout of the git describe
> commands. Since there are four different git-describe commands used for
> generating the name rev, four child_process are introduced, each successive
> child process running only when previous has no stdout. The order of these
> four git-describe commands is maintained the same as it was in the function
> set_name_rev() in shell script.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 16 ++---------
>  2 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 566a5b6a6..3022118d1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -219,6 +219,72 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +enum describe_step {
> +	step_bare = 0,
> +	step_tags,
> +	step_contains,
> +	step_all_always,
> +	step_end
> +};
> +
> +static char *get_name_rev(int argc, const char **argv, const char *prefix)
> +{
> +	struct child_process cp;
> +	struct strbuf sb = STRBUF_INIT;
> +	enum describe_step cur_step;
> +
> +	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
> +		child_process_init(&cp);
> +		prepare_submodule_repo_env(&cp.env_array);
> +		cp.dir = argv[1];
> +		cp.no_stderr = 1;

set cp.git = 1 so that you can avoid pushing "git" onto the arg array.

> +
> +		switch (cur_step) {
> +			case step_bare:
> +				argv_array_pushl(&cp.args, "git", "describe",
> +						 argv[2], NULL);
> +				break;
> +			case step_tags:
> +				argv_array_pushl(&cp.args, "git", "describe",
> +						 "--tags", argv[2], NULL);
> +				break;
> +			case step_contains:
> +				argv_array_pushl(&cp.args, "git", "describe",
> +						 "--contains", argv[2], NULL);
> +				break;
> +			case step_all_always:
> +				argv_array_pushl(&cp.args, "git", "describe",
> +						 "--all", "--always", argv[2],
> +						 NULL);
> +				break;
> +			default:
> +				BUG("unknown describe step '%d'", cur_step);
> +		}
> +
> +		if (!capture_command(&cp, &sb, 0) && sb.len) {
> +			strbuf_strip_suffix(&sb, "\n");
> +			return strbuf_detach(&sb, NULL);
> +		}
> +	}
> +
> +	strbuf_release(&sb);
> +	return NULL;
> +}
> +
> +static int print_name_rev(int argc, const char **argv, const char *prefix)
> +{
> +	char *namerev;
> +	if (argc != 3)
> +		die("print-name-rev only accepts two arguments: <path> <sha1>");
> +
> +	namerev = get_name_rev(argc, argv, prefix);
> +	if (namerev && namerev[0])
> +		printf(" (%s)", namerev);
> +	printf("\n");
> +
> +	return 0;
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -1212,6 +1278,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"print-name-rev", print_name_rev, 0},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c0d0e9a4c..091051891 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -758,18 +758,6 @@ cmd_update()
>  	}
>  }
>  
> -set_name_rev () {
> -	revname=$( (
> -		sanitize_submodule_env
> -		cd "$1" && {
> -			git describe "$2" 2>/dev/null ||
> -			git describe --tags "$2" 2>/dev/null ||
> -			git describe --contains "$2" 2>/dev/null ||
> -			git describe --all --always "$2"
> -		}
> -	) )
> -	test -z "$revname" || revname=" ($revname)"
> -}
>  #
>  # Show commit summary for submodules in index or working tree
>  #
> @@ -1041,14 +1029,14 @@ cmd_status()
>  		fi
>  		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
>  		then
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say " $sha1 $displaypath$revname"
>  		else
>  			if test -z "$cached"
>  			then
>  				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
>  			fi
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say "+$sha1 $displaypath$revname"
>  		fi
>  
> -- 
> 2.13.0
> 

-- 
Brandon Williams
