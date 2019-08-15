Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7037F1F45C
	for <e@80x24.org>; Thu, 15 Aug 2019 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfHOOP2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 10:15:28 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36835 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731849AbfHOOP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 10:15:28 -0400
Received: by mail-qt1-f172.google.com with SMTP id z4so2484387qtc.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gT+VfxeU1Ii7tbNfX05PaHznOHjQRIE7EN6qSWMYk7o=;
        b=iVTUcDiDjqNiFR6p878ts+uIAXpxCxxqtjbGvHSt8N+4iKXOHKZHi1dSqE90gaV6jm
         EILZktxPi/vKvc7/wgMnKo6/evfspCmau5X7QSQ2eqnj2kIZ/Nau7v2Tzt79gRlUtmg+
         9+sjAfOkskXpELCYuGOEJNhm7kIIpMukcw8O+ATsqDDPCMMXym14q83ibxw8KDQmBhln
         QdwjPnY/kOegutxpP4M+j/6trZzpsFFqQId645IDGRIYXw5mpMIvFKjWCmTKvavjNmnP
         SOxKNX75CCPg6/udoffuPF3iU+z/Mwu9esPiPEYNqv/Cz4xDUJMySlOg5ey8QKNMJvjf
         9ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gT+VfxeU1Ii7tbNfX05PaHznOHjQRIE7EN6qSWMYk7o=;
        b=mQb2XudoD5iVuMNXTUdO5W/jaz5gKFtDr38KjfRQc1aDbS2WIGR0cBklxRQUSI8cWG
         TvRyw31trqjri/KPbO94DZcBFR0hMA98GaGsMMjPIP+FYBNs6/Fq/5jORDMb3NIP72j5
         jlCsQHYijutgPjMCDEIUxRQHnKSSfeTjVqLqqTocFaqfIEjgA2Za8hkJ0Zoieff2UbpG
         MzT3GQahUokJjhJbNhK3sv56+cD2TxKZHT/KzJXi6hSyz0wq0gsK30NG7fgnRI1yGDOJ
         EXtr4SJ0O20xdpCqXEE8cxEDsbfDP7H66h1BwnP2IAe2JiLS3NJSRo+1RHJEBiMsOqTE
         xudg==
X-Gm-Message-State: APjAAAVmWHKTEMv0EJFdS+K3KKmrAShLdxhbOpn1YwZHTXPTBPQVUBFa
        kD79564yGj+Y9eZji4wJobOeKeRuqLY=
X-Google-Smtp-Source: APXvYqzbPmpr6qyz7PqkLoDvYnJiK+XgBPNlE+NW43y0HGvSjM8GvtUphRMVLbnlYYolkFKOWlrvjw==
X-Received: by 2002:ac8:31dc:: with SMTP id i28mr4214214qte.226.1565878526219;
        Thu, 15 Aug 2019 07:15:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:ed24:dbd9:c5f5:be34? ([2001:4898:a800:1010:9e5a:dbd9:c5f5:be34])
        by smtp.gmail.com with ESMTPSA id h26sm1608730qta.58.2019.08.15.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 07:15:25 -0700 (PDT)
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20190815023418.33407-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
Date:   Thu, 15 Aug 2019 10:15:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190815023418.33407-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2019 10:34 PM, Emily Shaffer wrote:
> Make it easier for users who encounter a bug to send a report by
> collecting some state information, intended to be viewed by humans
> familiar with Git.

This is an excellent idea! VFS for Git has a similar "diagnose" command
that collects logs, config, and other details (like packfile sizes and
loose object counts). That has been a critical tool for supporting users.

> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Also, teach Git to write
> down its own version, the version of some of its dependencies, the
> operating system information, the effective gitconfig, the configured
> hooks, and the contents of $GIT_DIR/logs. Finally, make sure Git asks
> the user to review the contents of the report after it's generated.
> 
> If users can send us a well-written bug report complete with system
> information, a remote we may be able to clone, and a reflog showing us
> where the problem occurred, we can reduce the number of questions and
> answers which must travel between the reporter and the Git contributor.
> 
> Users may also wish to send a report like this to their local "Git
> expert" if they have put their repository into a state they are confused
> by.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> There are some things I'm not certain about from this patch, I'd
> appreciate feedback.
> 
>  - Do we want to advertise the Git mailing list for bug reports?

That is possible. Isn't there another mailing list for git users?

I could see a patch added on top of this for git-for-windows/git that
changes the instructions to create issues on GitHub.

>  - Which config options should we filter to avoid accidentally receiving
>    credentials?

The remote URLs are pretty sensitive. Not only do users sometimes put passwords
or PATs into their URLs, the literal name of the repo could be a secret.

>  - At the moment, the test is trying to check "everything we thought we
>    would populate got populated" - that seemed to me like it would hold
>    up best to changes to the set of information being collected. But
>    maybe there's something more robust we can do.
> 
> And of course, if there are suggestions for other things to include in
> the report I'm interested in adding.
> 
> An example of the output can be found here:
> https://gist.github.com/nasamuffin/2e320892f5c2147e829cbcf5bd0759a2
> 
> Thanks.
>  - Emily
> 
>  .gitignore                      |  1 +
>  Documentation/git-bugreport.txt | 48 ++++++++++++++++++
>  Makefile                        |  1 +
>  command-list.txt                |  1 +
>  git-bugreport.sh                | 86 +++++++++++++++++++++++++++++++++
>  t/t0091-bugreport.sh            | 41 ++++++++++++++++
>  6 files changed, 178 insertions(+)
>  create mode 100644 Documentation/git-bugreport.txt
>  create mode 100755 git-bugreport.sh
>  create mode 100755 t/t0091-bugreport.sh
> 
> diff --git a/.gitignore b/.gitignore
> index 521d8f4fb4..b4f5433084 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -25,6 +25,7 @@
>  /git-bisect--helper
>  /git-blame
>  /git-branch
> +/git-bugreport
>  /git-bundle
>  /git-cat-file
>  /git-check-attr
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> new file mode 100644
> index 0000000000..c5f45bbee8
> --- /dev/null
> +++ b/Documentation/git-bugreport.txt
> @@ -0,0 +1,48 @@
> +git-bugreport(1)
> +================
> +
> +NAME
> +----
> +git-bugreport - Collect information for user to file a bug report
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git bugreport' [-o | --output <path>]
> +
> +DESCRIPTION
> +-----------
> +Captures information about the user's machine, Git client, and repository state,
> +as well as a form requesting information about the behavior the user observed,
> +into a single text file which the user can then share, for example to the Git
> +mailing list, in order to report an observed bug.
> +
> +The following information is requested from the user:
> +
> + - Reproduction steps
> + - Expected behavior
> + - Actual behavior
> +
> +The following information is captured automatically:
> +
> + - Git version (`git version --build-options`)
> + - Machine information (`uname -a`)
> + - Versions of various dependencies
> + - Git config contents (`git config --show-origin --list`)
> + - The contents of all configured git-hooks in `.git/hooks/`
> + - The contents of `.git/logs`
> +
> +OPTIONS
> +-------
> +-o [<path>]::
> +--output [<path>]::
> +	Place the resulting bug report file in <path> instead of the root of the
> +	Git repository.
> +
> +NOTE
> +----
> +Bug reports can be sent to git@vger.kernel.org.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index f9255344ae..69801a1c45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -606,6 +606,7 @@ TEST_PROGRAMS_NEED_X =
>  unexport CDPATH
>  
>  SCRIPT_SH += git-bisect.sh
> +SCRIPT_SH += git-bugreport.sh
>  SCRIPT_SH += git-difftool--helper.sh
>  SCRIPT_SH += git-filter-branch.sh
>  SCRIPT_SH += git-merge-octopus.sh
> diff --git a/command-list.txt b/command-list.txt
> index a9ac72bef4..be5a605047 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -54,6 +54,7 @@ git-archive                             mainporcelain
>  git-bisect                              mainporcelain           info
>  git-blame                               ancillaryinterrogators          complete
>  git-branch                              mainporcelain           history
> +git-bugreport                           ancillaryinterrogators
>  git-bundle                              mainporcelain
>  git-cat-file                            plumbinginterrogators
>  git-check-attr                          purehelpers
> diff --git a/git-bugreport.sh b/git-bugreport.sh
> new file mode 100755
> index 0000000000..2200703a51
> --- /dev/null
> +++ b/git-bugreport.sh

At first I was alarmed by "What? another shell script?" but this command should
prioritize flexibility and extensibility over speed. Running multiple processes
shouldn't be too taxing for what we are trying to do here.

> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +
> +print_filenames_and_content() {
> +while read -r line; do
> +	echo "$line";
> +	echo "========";
> +	cat "$line";
> +	echo;
> +done
> +}
> +
> +generate_report_text() {
> +
> +	# Generate a form for the user to fill out with their issue.
> +	gettextln "Thank you for filling out a Git bug report!"
> +	gettextln "Please answer the following questions to help us understand your issue."
> +	echo
> +	gettextln "What did you do before the bug happened? (Steps to reproduce your issue)"
> +	echo
> +	gettextln "What did you expect to happen? (Expected behavior)"
> +	echo
> +	gettextln "What happened instead? (Actual behavior)"
> +	echo
> +	gettextln "Anything else you want to add:"
> +	echo
> +	gettextln "Please review the rest of the bug report below."
> +	gettextln "You can delete any lines you don't wish to send."
> +	echo
> +
> +	echo "[System Information]"
> +	git version --build-options
> +	uname -a
> +	curl-config --version
> +	ldd --version
> +	echo
> +
> +	echo "[Git Config]"
> +	# TODO: Pass this through grep -v to avoid users sending us their credentials.
> +	git config --show-origin --list
> +	echo

Config options to consider stripping out:

	*url*
	*pass* (anything "password" but also "sendmail.smtppass")

> +	echo "[Configured Hooks]"
> +	find "$GIT_DIR/hooks/" -type f | grep -v "\.sample$" | print_filenames_and_content
> +	echo

Remove the sample hooks, but focus on the others. Will this look like garbage if a hook
is a binary file?

> +
> +	echo "[Git Logs]"
> +	find "$GIT_DIR/logs" -type f | print_filenames_and_content
> +	echo

As mentioned before, I've sometimes found it helpful to know the data shape for the object
store. Having a few extra steps such as the following could be nice:

	echo "[Loose Objects]"
	for objdir in $(find "$GIT_DIR/objects/??" -type d)
	do
		echo "$objdir: $(ls $objdir | wc -l)"
	done
	echo

	echo "[Pack Data]"
	ls -l "$GIT_DIR/objects/pack"
	echo

	echo "[Object Info Data]"
	ls -lR "$GIT_DIR/objects/info"
	echo

	echo "[Alternates File]"
	echo "========"
	cat "$GIT_DIR/objects/info/alternates"
	echo

That last one will collect information on the commit-graph file, even if it is an
incremental file.

> +
> +}
> +
> +USAGE="[-o | --output <path>]"
> +
> +SUBDIRECTORY_OK=t
> +OPTIONS_SPEC=
> +. git-sh-setup
> +. git-sh-i18n
> +
> +basedir="$PWD"
> +while :
> +do
> +	case "$1" in
> +	-o|--output)
> +		shift
> +		basedir="$1"
> +		shift
> +		continue
> +		;;
> +	"")
> +		break
> +		;;
> +	*)
> +		usage
> +		;;
> +	esac
> +done
> +
> +
> +# Create bugreport file
> +BUGREPORT_FILE="$basedir/git-bugreport-$(whoami)-$(hostname)-$(date -Iminutes)"
> +
> +generate_report_text >$BUGREPORT_FILE
> +
> +git_editor $BUGREPORT_FILE
> +
> +eval_gettextln "Your new bug report is in \$BUGREPORT_FILE."
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..6eb2ee4f66
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +
> +test_description='git bugreport'
> +
> +. ./test-lib.sh
> +
> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +check_all_headers_populated() {
> +	while read -r line; do
> +		if [$(grep $HEADER_PATTERN $line)]; then
> +			read -r nextline
> +			if [-z $nextline]; then
> +				return 1;
> +			fi
> +		fi
> +	done
> +}
> +
> +test_expect_success 'creates a report with content in the right places' '
> +	git bugreport &&
> +	check_all_headers_populated <git-bugreport-* &&
> +	rm git-bugreport-*
> +'
> +
> +test_expect_success '--output puts the report in the provided dir' '
> +	mkdir foo/ &&
> +	git bugreport -o foo/ &&
> +	test -f foo/git-bugreport-* &&
> +	rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +	test_must_fail git bugreport --false 2>output &&
> +	grep usage output &&
> +	test ! -f git-bugreport-*
> +'
> +
> +test_done
> 

I think this is a great start, and I'll take some time later to try it out.

Thanks,
-Stolee
