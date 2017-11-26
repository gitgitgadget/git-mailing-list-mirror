Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBFC20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 23:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdKZXBe (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 18:01:34 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:41152 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdKZXBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 18:01:32 -0500
Received: by mail-wm0-f45.google.com with SMTP id b189so30744565wmd.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+q9QGau9YGObVsSmRI5A4MVF47ylIzx5TKnhds6uyc=;
        b=pdHuw5XSb46x9gCCK1oDpKBlhv6WlJKQRYZq9InkDDGGTh8nI9RIYpaIEOwI46tMO4
         r+fBnr4pieICSaHamWTQicoJ/PTqUv2NzVU4vfI+4i9iSgTlLMd96ZTB/JnuKkcDIcks
         Yo+gb8zN6IUcPeuaa9xA7I/ecLbCu2NgiGEE36EdLkHN5Dx6/q/czyjIx1EJFeLaH2WU
         YABvikrZrG7CrY2OQN1zN5CwxiKD11ASr/VguF/wgfexFk8cDgsCcOGTfPj6+Rn3rzxK
         4M/dEpRKj70kThohBjryjvc5UXBfKcFjN70sXAMlm8vO7T4ltJ7zd+8VR/QxXbejRfaw
         Sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+q9QGau9YGObVsSmRI5A4MVF47ylIzx5TKnhds6uyc=;
        b=UxJkh9k8TfCf49G7+TKygzBqLkkyZpY13H1hsMrI/M7jHTR+jekPLmQ47Y/I4zhuo2
         gYGv83xWNqeXd9UaH4gJcKdgTBGJer5WRdENAlQsG/jDQwIn151JUFF2tsYqLnkV2kh5
         wYzHDTJ1T/32gqirejsnopOn5XXOjCLb8OofDDRNAi/HHa+C8ao3i7vz0ilHwfrT7Hym
         AelzYBdDL+VSLmMntk+H5FjRcwPg4Qh4rVI73Rpmiqs7mOYGJzTE6GHfg5B+N/VznDNH
         wXxbhQ8/cPIUNr7RlBpuZ1mg3sg2pqgOXOR5YnhEj+kn2TY6he+ICQ5yLvHeE1oIiIRz
         BtGQ==
X-Gm-Message-State: AJaThX55ltTx8z6bnSeoJkF7tDrIXAqDOHWssrS+sbOAVxzqBJYbWK82
        M0aHN9L59x/FJXCmL4BnfOk=
X-Google-Smtp-Source: AGs4zMb1eVrE3CA4CTreLQjxKOuYvwjvhOrpAUX8DfYvGL87hasxXHPhqM9UJgZ5MB8YyYEJU+1uiw==
X-Received: by 10.28.56.6 with SMTP id f6mr16630323wma.151.1511737290856;
        Sun, 26 Nov 2017 15:01:30 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id r14sm27449898wra.71.2017.11.26.15.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 15:01:30 -0800 (PST)
Subject: [SCRIPT/RFC 2/3] git-merge-one-file--cached
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Message-ID: <d60812ab-a4d9-6d39-9624-3280ef1ccd21@gmail.com>
Date:   Sun, 26 Nov 2017 23:36:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original "git-merge-one-file" script is slightly tweaked here into 
"git-merge-one-file--cached"[*1*] to allow (still trivial) _index-only_ 
three-way file merge, not touching files inside working tree.

Proof of concept, not thoroughly tested, original content left in, 
commented out. Feel free to comment/polish.

To make it available, I guess it would be best placed beside existing 
"git-merge-one-file" script...?

Regards, Buga

[*1*] "git-merge-one-file--cached"
--- 8< ---
#!/bin/sh
#
# Copyright (c) Linus Torvalds, 2005
#
# ---
# Original "git-merge-one-file" script slightly tweaked into
# "git-merge-one-file--cached" to allow (still trivial) index-only
# three-way file merge, not touching files inside working tree.
#
# Proof of concept, not thoroughly tested, original content left in,
# commented out.
# ---
#
# This is the git per-file merge script, called with
#
#   $1 - original file SHA1 (or empty)
#   $2 - file in branch1 SHA1 (or empty)
#   $3 - file in branch2 SHA1 (or empty)
#   $4 - pathname in repository
#   $5 - original file mode (or empty)
#   $6 - file in branch1 mode (or empty)
#   $7 - file in branch2 mode (or empty)
#
# Handle some trivial cases.. The _really_ trivial cases have
# been handled already by git read-tree, but that one doesn't
# do any merges that might change the tree layout.

USAGE='<orig blob> <our blob> <their blob> <path>'
USAGE="$USAGE <orig mode> <our mode> <their mode>"
LONG_USAGE="usage: git merge-one-file $USAGE

Blob ids and modes should be empty for missing files."

SUBDIRECTORY_OK=Yes
. git-sh-setup
cd_to_toplevel
require_work_tree

if test $# != 7
then
	echo "$LONG_USAGE"
	exit 1
fi

case "${1:-.}${2:-.}${3:-.}" in
#
# Deleted in both or deleted in one and unchanged in the other
#
"$1.." | "$1.$1" | "$1$1.")
	if { test -z "$6" && test "$5" != "$7"; } ||
	   { test -z "$7" && test "$5" != "$6"; }
	then
		echo "ERROR: File $4 deleted on one branch but had its" >&2
		echo "ERROR: permissions changed on the other." >&2
		exit 1
	fi

	if test -n "$2"
	then
		echo "Removing $4"
	# else
		# read-tree checked that index matches HEAD already,
		# so we know we do not have this path tracked.
		# there may be an unrelated working tree file here,
		# which we should just leave unmolested.  Make sure
		# we do not have it in the index, though.
		# exec git update-index --remove -- "$4"
	fi
	# if test -f "$4"
	# then
		# rm -f -- "$4" &&
		# rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
	# fi &&
		exec git update-index --remove --cacheinfo "$6","$2","$4"
	;;

#
# Added in one.
#
".$2.")
	# the other side did not add and we added so there is nothing
	# to be done, except making the path merged.
	exec git update-index --add --cacheinfo "$6","$2","$4"
	;;
"..$3")
	echo "Adding $4"
	if test -f "$4"
	then
		echo "ERROR: untracked $4 is overwritten by the merge." >&2
		exit 1
	fi
	git update-index --add --cacheinfo "$7","$3","$4" # &&
		# exec git checkout-index -u -f -- "$4"
	;;

#
# Added in both, identically (check for same permissions).
#
".$3$2")
	if test "$6" != "$7"
	then
		echo "ERROR: File $4 added identically in both branches," >&2
		echo "ERROR: but permissions conflict $6->$7." >&2
		exit 1
	fi
	echo "Adding $4"
	git update-index --add --cacheinfo "$6","$2","$4" # &&
		# exec git checkout-index -u -f -- "$4"
	;;

#
# Modified in both, but differently.
#
"$1$2$3" | ".$2$3")

	case ",$6,$7," in
	*,120000,*)
		echo "ERROR: $4: Not merging symbolic link changes." >&2
		exit 1
		;;
	*,160000,*)
		echo "ERROR: $4: Not merging conflicting submodule changes." >&2
		exit 1
		;;
	esac

	src1=$(git unpack-file $2)
	src2=$(git unpack-file $3)
	case "$1" in
	'')
		echo "Added $4 in both, but differently."
		orig=$(git unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
		;;
	*)
		echo "Auto-merging $4"
		orig=$(git unpack-file $1)
		;;
	esac

	git merge-file "$src1" "$orig" "$src2"
	ret=$?
	msg=
	if test $ret != 0 || test -z "$1"
	then
		msg='content conflict'
		ret=1
	fi

	# Create the working tree file, using "our tree" version from the
	# index, and then store the result of the merge.
	# git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
	# rm -f -- "$orig" "$src1" "$src2"

	if test "$6" != "$7"
	then
		if test -n "$msg"
		then
			msg="$msg, "
		fi
		msg="${msg}permissions conflict: $5->$6,$7"
		ret=1
	fi

	if test $ret = 0
	then
		merge_blob=$(git hash-object -w --path="$4" -- "$src1")
	fi
	rm -f -- "$orig" "$src1" "$src2"

	if test $ret != 0
	then
		echo "ERROR: $msg in $4" >&2
		exit 1
	fi
	# exec git update-index -- "$4"
	exec git update-index --cacheinfo "$6","$merge_blob","$4"
	;;

*)
	echo "ERROR: $4: Not handling case $1 -> $2 -> $3" >&2
	;;
esac
exit 1
