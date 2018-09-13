Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7EE1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIMWve (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 18:51:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMWvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 18:51:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so7172249wre.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I3nSwCZoCPYa9MaCs34oqG3hAi18jM4/1YUPdKJGOpo=;
        b=ckFWohA3PSNpSJspMK6ZBCJL+XznZF021LYHyK/OBXX8PQQHugauzmfPHVmQJUzQPb
         4EILu9cfOKrZQGCbSLsvyXqnahYgSvQ1voGaMSbo+aRpi7EYhtw8G2yfMHN1Er8XIF9y
         w4cH7uHR7VWX4u2E07G85btqhczfL0Gs+qJ78nuhJAOxoDuXimglb4I/tcEIkhZyC98Z
         U8R1vagW6Jh/wz2pvIjwigM8110Coou5NskB8vu7Sud4IlL/NlBm88bnBGVRE2VP0e/f
         sOqTDrNMAdRMhd0ES6ZKZszu27p1BLDF284lVkPq2Wany7VB/eYMSUQpIeX5CrDQMsVp
         cyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I3nSwCZoCPYa9MaCs34oqG3hAi18jM4/1YUPdKJGOpo=;
        b=c7Aeaj6TiEKlxhS5I+dBzl8ttsAFhhvlNRBQDV0zJztZ1KtWEFSybUgEiu+bPPUUu5
         bwZ07KrLvL1PYraoa6t4p5O+jJsurEg/5xUW/WIKsIAMnW4Bxury4G7tNjeQLZhZBggg
         184VrwjF0iUh/O6Z+hEN9V9xSckMprvK+CPJR7mFCNZYqTSxjUSE+YWl2k3GrbZANtgG
         5FN34712U6B1IP6osSWth5nYD0qAc3A7H8G6nZMDTrqe7uirD/s3ab95UNzAVHVcbNix
         nLQhnmYAOR0MSnV4XlfHQLCHIhfo/9YzO7+GhKEXJ/ROUW3w4UOeCr6Ek9ObfKhvca7p
         risA==
X-Gm-Message-State: APzg51CtGPnkquXEFymGREyTCrkedE77OSlxQar+rSLTDR712IT3YC/1
        af1zHmxAf8vpZmlnbX7DSjI=
X-Google-Smtp-Source: ANB0VdaSak0Xm0h1qgc+CkePRiL0zJ/OAio0Q7iIcm/+Px51xa62mkQ+EcLVQEXQgBDB+v0iEwveDg==
X-Received: by 2002:a1c:7412:: with SMTP id p18-v6mr6578062wmc.49.1536860461420;
        Thu, 13 Sep 2018 10:41:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z13sm6119591wrw.19.2018.09.13.10.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 10:40:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] contrib: add coverage-diff script
References: <pull.40.git.gitgitgadget@gmail.com>
        <pull.40.v2.git.gitgitgadget@gmail.com>
        <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Sep 2018 10:40:59 -0700
In-Reply-To: <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 13 Sep 2018
        07:56:44 -0700 (PDT)")
Message-ID: <xmqqzhwlfg7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> We have coverage targets in our Makefile for using gcov to display line
> coverage based on our test suite. The way I like to do it is to run:
>
>     make coverage-test
>     make coverage-report
>
> This leaves the repo in a state where every X.c file that was covered has
> an X.c.gcov file containing the coverage counts for every line, and "#####"
> at every uncovered line.
>
> There have been a few bugs in recent patches what would have been caught
> if the test suite covered those blocks (including a few of mine). I want
> to work towards a "sensible" amount of coverage on new topics. In my opinion,
> this means that any logic should be covered, but the 'die()' blocks in error
> cases do not need to be covered.
>
> It is important to not measure the coverage of the codebase by what old code
> is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
> After creating the coverage statistics at a version (say, 'topic') you can
> then run
>
>     contrib/coverage-diff.sh base topic
>
> to see the lines added between 'base' and 'topic' that are not covered by the
> test suite. The output uses 'git blame -c' format so you can find the commits
> responsible and view the line numbers for quick access to the context.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  contrib/coverage-diff.sh | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100755 contrib/coverage-diff.sh
>
> diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
> new file mode 100755
> index 0000000000..0f226f038c
> --- /dev/null
> +++ b/contrib/coverage-diff.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +# Usage: 'contrib/coverage-diff.sh <version1> <version2>
> +# Outputs a list of new lines in version2 compared to version1 that are
> +# not covered by the test suite. Assumes you ran
> +# 'make coverage-test coverage-report' from root first, so .gcov files exist.

I presume that it is "from root first while you have a checkout of
version2, so .gcov files for version2 exist in the working tree"?

> +V1=$1
> +V2=$2
> +
> +diff_lines () {
> +	while read line
> +	do
> +		if echo $line | grep -q -e "^@@ -([0-9]+)(,[0-9]+)? \\+([0-9]+)(,[0-9]+)? @@.*"

As you know you are reading from diff output, you do not have to be
so strict in this if condition.  It's not like you try to carefully
reject a line that began with "@@" but did not match this pattern in
the corresponding else block.

"read line" does funny things to backslashes and whitespaces in the
payload ("read -r line" sometimes helps), and echoing $line without
quoting will destroy its contents here and in the line below (but
you do not care because all you care about is if it begins with a
dash).

> +		then
> +			line_num=$(echo $line \
> +				| awk 'match($0, "@@ -([0-9]+)(,[0-9]+)? \\+([0-9]+)(,[0-9]+)? @@.*", m) { print m[3] }')
> +		else
> +			echo "$line_num:$line"
> +			if ! echo $line | grep -q -e "^-"

If a patch removes a line with a solitary 'n' on it, possibly
followed by a SP and something else, such a line would say "-n
something else", and some implementation of "echo -n something else"
would do what this line does not expect.  A safer way to do this,
as you only care if it is a deletion line, is to do

	case "$line" in -*) ;; *) line_num=$(( $line_num + 1 ));; esac

Also you can make the echoing of "$line_num:$line" above
conditional, which will allow you to lose "grep ':+'" in the
pipeline that consumes output from this thing, e.g.

	case "$line" in +*) echo "$line_num:$line";; esac

iff you must write this in shell (but see below).

> +			then
> +				line_num=$(($line_num + 1))
> +			fi
> +		fi
> +	done

I have a feeling that a single Perl script instead of a shell loop
that runs many grep and awk as subprocesses performs better even on
Windows, and it would be more readable and maintainable.

perl -e '
	my $line_num;
	while (<>) {
		# Hunk header?  Grab the beginning in postimage.
		if (/^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/) {
			$line_num = $1;
			next;
		}

		# Have we seen a hunk?  Ignore "diff --git" etc.
		next unless defined $line_num;

		# Deleted line? Ignore.
		if (/^-/) {
			next;
		}

		# Show only the line number of added lines.
		if (/^\+/) {
			print "$line_num\n";
		}
		# Either common context or added line appear in
		# the postimage.  Count it.
		$line_num++;
	}
'

or something like that, given that you seem to only need line
numbers in new_lines.txt anyway?

> +}
> +
> +files=$(git diff --raw $V1 $V2 \
> +	| grep \.c$ \
> +	| awk 'NF>1{print $NF}')

Do we need these other commands in the pipe?  How is this different
from, say,

	git diff --name-only "$V1" "$V2" -- \*.c

?

> +for file in $files
> +do
> +	git diff $V1 $V2 -- $file \
> +		| diff_lines \
> +		| grep ":+" \

I think you meant to match "^<linenum>:+<added contents>" you are
echoing out in the above helper function, but this will find a
removed line that happens to have colon followed by a plus (which is
not all that uncommon in a patch to a shell script).

> +		| sed 's/:/ /g' \

Turning "<linenum>:+<added contents>" to "<linenum> +<added contents>"
with this, so that the next "awk" can show <linenum> only?  Then you
do not need 'g' at the end.  I see you use 'g' in many sed scripts
for uncovered_lines.txt, and I suspect most of 'g's you do not mean.

> +		| awk '{print $1}' \

Then we get a list of $line_num here?

> +		| sort \

This is sorted textually, which goes against intuition because these
lines are all line numbers, but it is done so that you can run
"comm" on it later and "comm" requires us to feed lines sorted
textually.

> +		>new_lines.txt

If I were writing this part, I'd probably write a small Perl script
that takes output from 'git diff "$V1" "$V2" -- "$file"' and then
reduces it to a list of line numbers for newly introduced lines.
Then pipe it to "sort >new_lines.txt" to match what we see below.

> +	hash_file=$(echo $file | sed "s/\//\#/")
> +	cat "$hash_file.gcov" \
> +		| grep \#\#\#\#\# \
> +		| sed 's/    #####: //g' \
> +		| sed 's/\:/ /g' \
> +		| awk '{print $1}' \
> +		| sort \
> +		>uncovered_lines.txt

Do not cat a single regular file into a pipe.  Write pipe at the end
of the line, not the beginning of next line.  Do not grep into sed.
Do not feed sed into sed unless needed.

Without knowing what the above is trying to do, but just
mechanically translating, I'd get something like this:

	sed -ne '/#####/{
		s/    #####: //g
		s/:.*//
                p
	}' "$hash_file.gcov" |
	sort >uncovered_lines.txt

> +	comm -12 uncovered_lines.txt new_lines.txt \
> +		| sed -e 's/$/\)/' \
> +		| sed -e 's/^/\t/' \
> +		>uncovered_new_lines.txt

;-)  This creates something like

	1)
	2)
	3)

out of a list of numbers.  Cute.

> +	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \
> +		echo $file && \
> +		git blame -c $file \
> +			| grep -f uncovered_new_lines.txt
> +
> +	rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt
> +done
> +
