Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB3B1F576
	for <e@80x24.org>; Mon, 29 Jan 2018 11:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeA2L3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 06:29:45 -0500
Received: from brain.meldce.com ([178.62.52.251]:51958 "EHLO brain.meldce.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeA2L3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 06:29:44 -0500
Received: from [10.19.35.21] (unknown [2.121.255.169])
        by brain.meldce.com (Postfix) with ESMTPSA id 02BC520116
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 11:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 brain.meldce.com 02BC520116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bytes.nz; s=mail;
        t=1517225377; bh=shTk6dPKysXW424JQL/lL4EYDLa/TSKNV2m9bsYqmD0=;
        h=From:Subject:To:Date:From;
        b=PQ8eQSzaQv4AoCWoDPs2NmWX9JYIRvKSOfTkGkfq+nLE6XUGPhHq23Wb8o6eq1KUo
         fKKjbQnXyReHtq01dqZYDHjDMWCjbL5kSEXBA16Idb8sP4pJEHFZOtdnim4o0BwVRQ
         f3hc3xhioIHQuTRLjEcuLeju8TfoNCtV+/8jQXxbGvyQbPwEcA6VdkCsI3aw2nXMQ2
         vX+/timnCczhGURFMvmhIEb4q4YJDBsB4x5PY55qPwHbAUKUHgFzWxW1ihYuaZojJ1
         EFX1HlNfB17zM86ZigZQfdRwdmxqNXVlUlMI0y2dsRZScIALqPDLo9OzXVsMpmq+Be
         E482fBHkRW8Cw==
From:   Jack F <jack@bytes.nz>
Subject: Missing ? wildcard character in gitignore documentation
To:     git@vger.kernel.org
X-Priority: 4 (Low)
Message-ID: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
Date:   Mon, 29 Jan 2018 11:29:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have just noticed that the documentation for gitignore is missing
documentation on using the ? to match any single character. I have
included a example below with git version 2.14.1.

|11:05:09 j ~/Development/ls-ignore [master] $ git status On branch
master Your branch is up-to-date with 'origin/master'. nothing to
commit, working tree clean 11:05:11 j ~/Development/ls-ignore [master] $
cat .gitignore *~ node_modules yarn* 11:05:21 j ~/Development/ls-ignore
[master] $ touch test.swo 11:05:31 j ~/Development/ls-ignore [master]?1
$ git status On branch master Your branch is up-to-date with
'origin/master'. Untracked files: (use "git add <file>..." to include in
what will be committed) test.swo nothing added to commit but untracked
files present (use "git add" to track) 11:05:35 j
~/Development/ls-ignore [master]?1 $ echo "*.sw?" >> .gitignore 11:05:40
j ~/Development/ls-ignore [master]≠1 $ cat .gitignore *~ node_modules
yarn* *.sw? 11:05:51 j ~/Development/ls-ignore [master]≠1 $ git status
On branch master Your branch is up-to-date with 'origin/master'. Changes
not staged for commit: (use "git add <file>..." to update what will be
committed) (use "git checkout -- <file>..." to discard changes in
working directory) modified: .gitignore no changes added to commit (use
"git add" and/or "git commit -a")|



Noticed it when checking an npm package (ignore) that uses the
documentation (https://git-scm.com/docs/gitignore) to determine its
functionality. It is documented in
https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository#Ignoring-Files

Cheers.

From,
Jack

https://bytes.nz
https://keybase.io/bytesnz

