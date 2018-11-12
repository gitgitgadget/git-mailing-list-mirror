Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F7F1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeKMAfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:35:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35553 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMAfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:35:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so9649885wrv.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=d9ppfpQvt4Ap1TVBPyRfYgxcCsm0gUd2Es7UEmgTPyk=;
        b=GhXgqgDKqz1hhYnOEKhoWtCpdApvAghM/vkx79dnp1cvkRxbTJhgpgOKQ+vew02Wjx
         B0EHhVk2chVfw9POoGX67SCYRc9tezPaYYt1IG1bOafGIS/aajvn/7ISpy0LNsPjjMfJ
         xU30qpWBXfHMqFT6qwOTZspKHX3zWjTNAVpRX3aYr/PSPv8SRzaQiGVa7iKcQH9E3CdA
         JYfOuY2/3RakUAQJY6/0N0DQ6oAgg+zl0X8OG60QLcIR58E1EQM6xf4WpO24spt3sORp
         oRTiuvI7iWfpobCBQJn2u+6e9uqTheJx9uLJvgiE5eDcsKSlQfCKc3Gu8IX0gpH+8D98
         kRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=d9ppfpQvt4Ap1TVBPyRfYgxcCsm0gUd2Es7UEmgTPyk=;
        b=L7rk2oSEc4/jtAPGhbxbOpDxt5albJSX2RLU1uIICzz8YGlewLi5P9NKupNWXq/VFp
         zRS2jvhfg20s5yTUZbVnPjN6LVv8cG7szKnGV0Bb59ZuzVwt2Hq/R+HFsAR5WiAmbOYM
         BR0qYUw5UfNfv6u3RYcVkgwKgTG8p2gkIbD6mcjD4uS5o4fgwCs4IWj0CZfVkw7hYMQI
         zT+VRjqNMpdWQrs9+UIc2F6UB1IedLGky6IVswGmJv50vsxeXqPdQMaoqY+t336F9xvq
         au0R7wimaw8WYUbLmQNcfGl+FxDNnPkaE9E6SEvIkc9abgQ8B9+oaEBSNW8d+X2b47oG
         3Q4w==
X-Gm-Message-State: AGRZ1gLlsLCkfZARE8FC4Ij3KttZ8N2XTo6ZF1tSWknL8aKO4e5hKyDV
        hrwUVuYe2Bf8DMl3W8t83MLv/0fW
X-Google-Smtp-Source: AJdET5f+QQvxXICB6UHvtczsbAdU5bZiiBq3tv4IlMY12+5UXcqmz0eriU89fzD+JNGQIZ1zUBtFLA==
X-Received: by 2002:a5d:498f:: with SMTP id r15-v6mr1117337wrq.317.1542033738535;
        Mon, 12 Nov 2018 06:42:18 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id l8-v6sm6892082wrm.88.2018.11.12.06.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 06:42:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/5] Makefile: move long inline shell loops in "install" into helper
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-2-avarab@gmail.com> <nycvar.QRO.7.76.6.1811121449080.39@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811121449080.39@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Nov 2018 15:42:16 +0100
Message-ID: <87h8gm2w8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 2 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> Move a 37 line for-loop mess out of "install" and into a helper
>> script. This started out fairly innocent but over the years has grown
>> into a hard-to-maintain monster, and my recent ad874608d8 ("Makefile:
>> optionally symlink libexec/git-core binaries to bin/git", 2018-03-13)
>> certainly didn't help.
>>
>> The shell code is ported pretty much as-is (with getopts added), it'll
>> be fixed & prettified in subsequent commits.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  Makefile         | 52 ++++++++--------------------
>>  install_programs | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 103 insertions(+), 38 deletions(-)
>>  create mode 100755 install_programs
>>
>> diff --git a/Makefile b/Makefile
>> index bbfbb4292d..aa6ca1fa68 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2808,44 +2808,20 @@ endif
>>  	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>>  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
>>  	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
>> -	{ test "$$bindir/" = "$$execdir/" || \
>> -	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
>> -		$(RM) "$$execdir/$$p" && \
>> -		test -n "$(INSTALL_SYMLINKS)" && \
>> -		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
>> -		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
>> -		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
>> -		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
>> -	  done; \
>> -	} && \
>> -	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
>> -		$(RM) "$$bindir/$$p" && \
>> -		test -n "$(INSTALL_SYMLINKS)" && \
>> -		ln -s "git$X" "$$bindir/$$p" || \
>> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>> -		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
>> -		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
>> -		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
>> -	done && \
>> -	for p in $(BUILT_INS); do \
>> -		$(RM) "$$execdir/$$p" && \
>> -		test -n "$(INSTALL_SYMLINKS)" && \
>> -		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
>> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>> -		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
>> -		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
>> -		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
>> -	done && \
>> -	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
>> -	for p in $$remote_curl_aliases; do \
>> -		$(RM) "$$execdir/$$p" && \
>> -		test -n "$(INSTALL_SYMLINKS)" && \
>> -		ln -s "git-remote-http$X" "$$execdir/$$p" || \
>> -		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
>> -		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
>> -		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
>> -		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
>> -	done && \
>
> This indeed looks like a mess...
>
>> +	./install_programs \
>> +		--X="$$X" \
>> +		--RM="$(RM)" \
>> +		--bindir="$$bindir" \
>> +		--bindir-relative="$(bindir_relative_SQ)" \
>> +		--execdir="$$execdir" \
>> +		--destdir-from-execdir="$$destdir_from_execdir_SQ" \
>> +		--flag-install-symlinks="$(INSTALL_SYMLINKS)" \
>> +		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
>> +		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
>> +		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
>> +		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
>> +		--list-execdir-git-dashed="$(BUILT_INS)" \
>> +		--list-execdir-curl-aliases="$(REMOTE_CURL_ALIASES)" && \
>>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
>>
>>  .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
>> diff --git a/install_programs b/install_programs
>> new file mode 100755
>> index 0000000000..e287108112
>> --- /dev/null
>> +++ b/install_programs
>> @@ -0,0 +1,89 @@
>> +#!/bin/sh
>> +
>> +while test $# != 0
>> +do
>> +	case "$1" in
>> +	--X=*)
>> +		X="${1#--X=}"
>> +		;;
>> +	--RM=*)
>> +		RM="${1#--RM=}"
>> +		;;
>> +	--bindir=*)
>> +		bindir="${1#--bindir=}"
>> +		;;
>> +	--bindir-relative=*)
>> +		bindir_relative="${1#--bindir-relative=}"
>> +		;;
>> +	--execdir=*)
>> +		execdir="${1#--execdir=}"
>> +		;;
>> +	--destdir-from-execdir=*)
>> +		destdir_from_execdir="${1#--destdir-from-execdir=}"
>> +		;;
>> +	--flag-install-symlinks=*)
>> +		INSTALL_SYMLINKS="${1#--flag-install-symlinks=}"
>> +		;;
>> +	--flag-no-install-hardlinks=*)
>> +		NO_INSTALL_HARDLINKS="${1#--flag-no-install-hardlinks=}"
>> +		;;
>> +	--flag-no-cross-directory-hardlinks=*)
>> +		NO_CROSS_DIRECTORY_HARDLINKS="${1#--flag-no-cross-directory-hardlinks=}"
>> +		;;
>> +	--list-bindir-standalone=*)
>> +		list_bindir_standalone="${1#--list-bindir-standalone=}"
>> +		;;
>> +	--list-bindir-git-dashed=*)
>> +		list_bindir_git_dashed="${1#--list-bindir-git-dashed=}"
>> +		;;
>> +	--list-execdir-git-dashed=*)
>> +		list_execdir_git_dashed="${1#--list-execdir-git-dashed=}"
>> +		;;
>> +	--list-execdir-curl-aliases=*)
>> +		list_execdir_curl_aliases="${1#--list-execdir-curl-aliases=}"
>> +		;;
>> +
>> +	*)
>> +		echo "Unknown option $1"
>> +		exit 1
>> +		;;
>> +	esac
>> +	shift
>> +done &&
>> +{ test "$bindir/" = "$execdir/" ||
>> +  for p in $list_bindir_standalone; do
>> +	$RM "$execdir/$p" &&
>> +	test -n "$INSTALL_SYMLINKS" &&
>> +	ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
>> +	{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
>> +	  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
>> +	  cp "$bindir/$p" "$execdir/$p" || exit; }
>> +  done;
>> +} &&
>> +for p in $list_bindir_git_dashed; do
>> +	$RM "$bindir/$p" &&
>> +	test -n "$INSTALL_SYMLINKS" &&
>> +	ln -s "git$X" "$bindir/$p" ||
>> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
>> +	  ln "$bindir/git$X" "$bindir/$p" 2>/dev/null ||
>> +	  ln -s "git$X" "$bindir/$p" 2>/dev/null ||
>> +	  cp "$bindir/git$X" "$bindir/$p" || exit; }
>> +done &&
>> +for p in $list_execdir_git_dashed; do
>> +	$RM "$execdir/$p" &&
>> +	test -n "$INSTALL_SYMLINKS" &&
>> +	ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
>> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
>> +	  ln "$execdir/git$X" "$execdir/$p" 2>/dev/null ||
>> +	  ln -s "git$X" "$execdir/$p" 2>/dev/null ||
>> +	  cp "$execdir/git$X" "$execdir/$p" || exit; }
>> +done &&
>> +for p in $list_execdir_curl_aliases; do
>> +	$RM "$execdir/$p" &&
>> +	test -n "$INSTALL_SYMLINKS" &&
>> +	ln -s "git-remote-http$X" "$execdir/$p" ||
>> +	{ test -z "$NO_INSTALL_HARDLINKS" &&
>> +	  ln "$execdir/git-remote-http$X" "$execdir/$p" 2>/dev/null ||
>> +	  ln -s "git-remote-http$X" "$execdir/$p" 2>/dev/null ||
>> +	  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
>> +done
>
> ... but so does this. I would be very surprised if these four very
> similar-looking constructs could not be refactored into a single shell
> script that is then called four times with different parameters.
>
> Something like
>
> 	#!/bin/sh
>
> 	from=
> 	while case "$1" in
> 	--no-hardlinks)
> 		NO_INSTALL_HARDLINKS=t
> 		;;
> 	--from=*)
> 		from="${1#*=}"
> 		;;
> 	*)
> 		break
> 		;;
> 	esac; do
> 		shift
> 	done
>
> 	test $# -gt 3 || {
> 		echo "Usage: $0 [--no-hardlinks] <from-dir> <to-dir> <file>..." >&2
> 		exit 1
> 	}
>
> 	fromdir="$1"
> 	todir="$2"
> 	shift
> 	shift
>
> 	for p in "$@"
> 	do
> 		$RM "$todir/$p" &&
> 		test -n "$INSTALL_SYMLINKS" &&
> 		ln -s "$fromdir/${from:-$p}" "$todir/$p" ||
> 		{ test -z "$NO_INSTALL_HARDLINKS" &&
> 		  ln "$fromdir/${from:-$p}" "$todir/$p" ||
> 		  ln -s "$fromdir/${from:-$p}" "$todir/$p" ||
> 		  cp "$fromdir/${from:-$p}" "$todir/$p" || exit; }
> 	done
>
> and then calling it using
>
> 	test "$bindir/" = "$execdir/" ||
> 	link-or-copy ${NO_CROSS_DIRECTORY_HARDLINKS:+--no-hardlinks} \
> 		"$bindir" "$execdir" $list_bindir_standalone
> 	link-or-copy --from=git$X "$bindir" "$bindir" $list_bindir_git_dashed
> 	link-or-copy --from=git$X "$bindir" "$execdir" $list_bindir_git_dashed
> 	link-or-copy --from=git-remote-http$X "$bindir" "$execdir" $list_execdir_curl_aliases
>
> That would at least DRY up this mess a bit.

I'll try for a non-RFC re-submission of this which won't have the 5/5
NO_INSTALL_BUILTIN_EXECDIR_ALIASES (for now) which'll hopefully be ready
for inclusion.

I tried to fold up some of these special cases into one thing before,
but managing the exceptions gets messier to read in my opinion than just
having some duplication.

But more to the point, between your suggestion and Junio's to do all of
this with some make construct: Yeah we should make it awesome, but I
think a logical first step for a patch series like this is to just as-is
use the existing logic we have now with some minor fixes for bugs.

We can refactor this later, I'm mainly interested in moving this over to
a *.sh first so that process is less of a mess, fixing some minor bugs,
and not getting a first iteration of improvements stuck on a much bigger
review for "I rewrote the way the whole install process works" series.
