Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184B81F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJZGVC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 02:21:02 -0400
Received: from outbound2n.ore.mailhop.org ([54.186.218.12]:32521 "EHLO
        outbound2n.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbeJZGVB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Oct 2018 02:21:01 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 02:21:00 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1540503036; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=ZZSI3fPnCX9kb3NXnp+waSpsuOE0A4UfrHPkV6UBQYIIWKfyEEuy5dn7oZJR3FARVKzOzpITJ8qSQ
         G4q7e/b6tBvIAzEk9paJIOsFRBEZexjHeHZkaGixKCiqHZokv5ivPOCh73cbHgLCHWkFA4ER3GTC98
         PacclzCcpCr6yxmJ7cl+cVAjsbdra/ALeTLr4ZUkw0g6+rEvosDTzK7yH/tgXWcvuPzhWdCqGLTFRf
         hQPqULlEc+j/Y28LDX0c6ynX5onWgr7+3rKOOqONg02ZyBo7SKFk/hLh8xX0n76p6NySoYaJ3zQVLN
         /3BnSVct4hVBVS9JKXXKIoirCFnIO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:subject:to:from:date:dkim-signature:
         dkim-signature:from;
        bh=y/7XIIJRcsrZ5sYSTTlw0ddfNM0VIn/XAt1GBJo644Q=;
        b=hwnFODXucdJSMdRuWoMGVByRGXwkyMcSnRY9v6h4AzDPKP9QCQKdv2w+XYFEPYciM4+ZZnCtDUlrw
         9uPKsWkEMvkyklzgMZ/Y5o0ZeL5miI+t1Aptyso5c51s3nHZ/EjpEPBRwjjdtkGPcqoKnU/Ye5hm0Y
         6N07IcX9MnzcBJs3pTQG3CBqiglRksoOZeP+Sv3p+N8D/Jcta1pdjiYYOGUR9EnOHzj81nEsJh7l5n
         zNEgQxWPqNzQNxuOa3s74zsJaJw5kv9FgiOwPcZBP3iqwMETdkEe/sw61+qNO5d/SCmgC4IH4UORUg
         G+GxD28IsDOw37Mkxa9oYH1zPT5FqcA==
ARC-Authentication-Results: i=1; outbound2.ore.mailhop.org;
        spf=softfail smtp.mailfrom=lakedaemon.net smtp.remote-ip=108.39.81.162;
        dkim=permerror header.d=lakedaemon.net header.s=mail header.a=rsa-sha256 header.b=T43pHH7B;
        dmarc=none header.from=lakedaemon.net;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:subject:to:from:date:from;
        bh=y/7XIIJRcsrZ5sYSTTlw0ddfNM0VIn/XAt1GBJo644Q=;
        b=s1kcy+iCEYzcCism9IqXk89D9vceT/KYU8Y6iI9FHffCZyZOsmqUgfK3fobKi+bWtaaIsnTdkRHdN
         JpTqgWnwdr8mWrnQJ0I+gidwSmdoyMcDQwAqvVwpNd6UoEU9OAp+Hv5kHbE4XG4Zs3Q11I3H1U/sAV
         rZ/OH0eJl5HC54xgG/78Si3o5XenqGmYg60KgSaIBqAWhwWI0DLtrBc/BdFn3sWhuV1jsr8oWx7rvG
         Ij5hFNcK17OH0L58yR6hgiC0L0HV4/a+qb874O6vMethmWInlRG5VR7vvWhdaQZygsFVuN94QHds8S
         GxQJt3v8iv+LOgPZS+7gxoVDzs14ncg==
X-MHO-RoutePath: amFjMjk5NzkyNDU4
X-MHO-User: 34353230-d89d-11e8-a630-335f030b21f2
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 108.39.81.162
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [108.39.81.162])
        by outbound2.ore.mailhop.org (Halon) with ESMTPSA
        id 34353230-d89d-11e8-a630-335f030b21f2;
        Thu, 25 Oct 2018 21:30:34 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 5CFEC80065
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 21:30:32 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 5CFEC80065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1540503032;
        bh=y/7XIIJRcsrZ5sYSTTlw0ddfNM0VIn/XAt1GBJo644Q=;
        h=Date:From:To:Subject;
        b=T43pHH7B5DpBO70nSITKAZR6k64cGCv3fxulASZPOkFwXqcowEFvUkY+qHMKjLId+
         lONdMHdMYiNIvZryBQArZbChqtypKSD8IPp+37tKNJbaiz3BmaQ/vAxEXSkOg6xkMj
         LbpWKT4DGmBEyVN3hLkX1IQV+FOir4JAH5W+oFodfnest2RfBl3phuXZtMFkK7z3FW
         qg6lxRu4qmh1J8u/rDHLSElHFQQQxAD2qeP/38IBEsiN5Llors7LhG64KC9pnbp049
         f6vlrWOb8avZFwBxJONqXzrAa8tDlrZ3JVAkWeY9WqmhnQmJZMi0oODqHFj/c5dcpQ
         Ds6Aej957Q4YQ==
Date:   Thu, 25 Oct 2018 21:30:32 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     git@vger.kernel.org
Subject: git filter-branch --filter-renames ?
Message-ID: <20181025213032.GD24185@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

I recently needed to extract the git history of a portion of an existing
repository.  My initial attempts using --subdirectory-filter, subtrees,
etc weren't as successful as I'd hoped.

The primary reason for my failures were due to the fact that this
particular source repository has seen a lot of code movement and renames
in-place.  As a result, filters such as subdirectory filter failed to
keep commits prior to the renames.

So, long story short, I've attached below a hacked together script (yes,
it's sad when one writes a script to call a script :-/) that solves the
problem for me.

My hope is that some other poor sob in my position discovers this
script, uses it and moves on.  If enough people think it's useful
despite the cornercases [1], I'd be happy to work on integrating it into
filter-branch.

thx,

Jason.

[1] Namely that if two different files held the same full-path name at
different times in the source repo, you'll get some errant commits in
the history.

------------------->8--------------------------------------------------
#!/bin/bash
#
# git-filter-renames: Similar to --subdirectory-filter but tracks renames
#
# Basic use:
#  $ git clone path/to/source_repo dest_repo
#  $ cd dest_repo
#  $ git tags | xargs git tag -d # ours are signed, so would fail to verify
#  $ git remote remove origin
#  $ git gc --aggressive --prune=now --force
#  $ git fsck
#  $ git-filter-renames.sh "[PREFIX] " fileA subdirB/ fileC subdirD/subdirE ...
#  $ rm -rf .git/refs/original
#  $ git gc --aggressive --prune=now --force
#  $ git fsck

DEBUG=1

if [ $# -le 1 ]; then
	echo >&2 "Usage:"
	echo >&2 "    ${0##*/} '[subj prefix] ' fileA fileB dir1 sub/dir2"
	echo >&2 ""
	exit 1
fi

if [ $DEBUG == 1 ]; then
	rm -rf /tmp/git-filter-renames-*
fi

TMP_DIR="`mktemp -d /tmp/git-filter-renames-XXXXXX`"

PREFIX="${1}"
shift

# take in the list of files to preserve
# note: directories are recursed
echo -n "" >$TMP_DIR/user_list.txt
for arg in $*; do
	if [ -d "$arg" ]; then
		find $arg -type f >>$TMP_DIR/user_list.txt
	elif [ -f "$arg" ]; then
		echo "$arg" >>$TMP_DIR/user_list.txt
	else
		echo >&2 "What the hell is '$arg'?"
	fi
done

echo -n "" >$TMP_DIR/trace_list.txt
while read fn <&4; do
	while read ofn <&5; do
		echo "^$ofn\$"
	done 5< <(git log --format=format: --follow --name-only -- "$fn" | \
		  sed -e '/^$/d' | sort -u)
done 4< <(cat $TMP_DIR/user_list.txt) | sort -u >>$TMP_DIR/trace_list.txt

# stage the filter script
cat >$TMP_DIR/filter.sh <<EOF
git ls-files | \\
	grep -vf $TMP_DIR/trace_list.txt | \\
	xargs -r git rm -qrf --ignore-unmatch
EOF
chmod +x $TMP_DIR/filter.sh

# stage the msg filter script
cat >$TMP_DIR/msg_filter.sh <<EOF
sed -e "1 s/^/$PREFIX/"
EOF
chmod +x $TMP_DIR/msg_filter.sh

# do the filtering
echo >&2 "Doing filtering"
git filter-branch --prune-empty -f --index-filter "$TMP_DIR/filter.sh" \
	--msg-filter "$TMP_DIR/msg_filter.sh" \
	HEAD
# cleanup
if [ $DEBUG == 0 ]; then
	rm -rf $TMP_DIR
fi
