Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5514C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D8A2177B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 06:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=venomvendor.com header.i=@venomvendor.com header.b="nqAE3hPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372245AbgJWGMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 02:12:12 -0400
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:45859 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S372238AbgJWGML (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Oct 2020 02:12:11 -0400
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 02:12:11 EDT
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 00ED2215C7B
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 23:48:52 -0600 (MDT)
Received: from md-38.webhostbox.net ([199.79.62.205])
        by cmsmtp with ESMTP
        id VpwZkkGPWwNNlVpwZk28Jz; Thu, 22 Oct 2020 23:48:51 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Jt3fUvwC c=1 sm=1 tr=0
 a=Bpy5dV53tekZqmOq0UNv1A==:117 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=kj9zAlcOel0A:10:nop_charset_1 a=afefHYAZSVUA:10:nop_rcvd_month_year
 a=zsiWmCa7vi8A:10:endurance_base64_authed_username_1 a=Oz2jWl6hAAAA:8
 a=XyYvwBculomvFs-0DnwA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=ggmITrCB5u4A:10:uccc_2email_address a=yBF3cylG60AhLRQPkmnV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=venomvendor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M6rwh6jF3U96J39x+bbgQUAkf2U62MaoKlJS8SB608Q=; b=nqAE3hPZqZxoJLaWGlGwDMiDnA
        RQR8X94tktf9j5NeJTxhNa7VGLFMRaQEDgqJYrjyLGT0ol+RsZKSk+l9BrKnNooPZ2CEHHQAS9uMg
        ML+jDpL1pdsKzp7XQ6E5WFVS4I2/ozAdxEvedQWtcTVGnpI/i+HgJbWb9NtAyLaeZKL7GDt1wA9bh
        P3FoqK2lFtdyy5UayWfl4sIm85wELoNSW+bCHRQGFntH12JbaHNhhr6Qa26dQeKoe0pDbKwk8OZDk
        tCbqm/t71kxVGlhxheSSLZh5zKARQnj1iA7AvfgcDv1NYjlkLCdxZOUn3sJA0GfiY2DlvlC0Mlawp
        wijZRhDA==;
Received: from md-38.webhostbox.net ([199.79.62.205]:27460)
        by md-38.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <info@venomvendor.com>)
        id 1kVpwZ-003CsH-6u
        for git@vger.kernel.org; Fri, 23 Oct 2020 05:48:51 +0000
MIME-Version: 1.0
Date:   Fri, 23 Oct 2020 11:18:51 +0530
From:   VenomVendor <info@venomvendor.com>
To:     git@vger.kernel.org
Subject: committer-date-is-author-date flag removes email in "Commit"
Reply-To: info@venomvendor.com
Mail-Reply-To: info@venomvendor.com
Message-ID: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
X-Sender: info@venomvendor.com
User-Agent: Roundcube Webmail/1.3.15
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-38.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - venomvendor.com
X-BWhitelist: no
X-Source-IP: 199.79.62.205
X-Source-L: Yes
X-Exim-ID: 1kVpwZ-003CsH-6u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: md-38.webhostbox.net [199.79.62.205]:27460
X-Source-Auth: venom4dy
X-Email-Count: 1
X-Source-Cap: dmVub200ZHk7dmVub200ZHk7bWQtMzgud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

committer-date-is-author-date flag removes email in "Commit"


What did you do before the bug happened? (Steps to reproduce your issue)
* Create empty repo using `git init`
* Make few commits, at least two
* execute `git log --format=fuller`
* Notice the log, with "Author", "AuthorDate", "Commit", "CommitDate"
* Note, "Commit"
* execute `git rebase --committer-date-is-author-date HEAD~1`
* execute `git log --format=fuller`
* Note, email from "Commit" is empty <>


What did you expect to happen? (Expected behavior)
* Email must not be removed.

What happened instead? (Actual behavior)
* email got removed/replaced with empty `< >`

What's different between what you expected and what actually happened?

Expected:
```
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:05 2020 -0200
Commit:     VenomVendor <info@VenomVendor.com>
CommitDate: Thu Oct 22 19:41:05 2020 -0200
```

Happened (Missing email in Commit)
```
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:05 2020 -0200
Commit:     VenomVendor <>
CommitDate: Thu Oct 22 19:41:05 2020 -0200
```

Anything else you want to add:

```
$ cd ~

$ mkdir committer-date-is-author-date-bug

$ cd committer-date-is-author-date-bug

$ git --version
git version 2.29.0

$ git init
Initialized empty Git repository in 
~/committer-date-is-author-date-bug/.git/

$ git log --format=fuller
fatal: your current branch 'master' does not have any commits yet


$ TEXT=1; echo "${TEXT}" > sample.txt && git add . && git commit -m 
"${TEXT}"
[master (root-commit) 20731cb] 1
  1 file changed, 1 insertion(+)
  create mode 100644 sample.txt


$ TEXT=2; echo "${TEXT}" > sample.txt && git add . && git commit -m 
"${TEXT}"
[master e3d8ce8] 2
  1 file changed, 1 insertion(+), 1 deletion(-)


$ TEXT=3; echo "${TEXT}" > sample.txt && git add . && git commit -m 
"${TEXT}"
[master 30f2b84] 3
  1 file changed, 1 insertion(+), 1 deletion(-)


$ git log --format=fuller
commit 30f2b84e360d2ea79fe3355b5fbfa5cdb401c65f (HEAD -> master)
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:05 2020 -0200
Commit:     VenomVendor <info@VenomVendor.com>
CommitDate: Thu Oct 22 19:41:05 2020 -0200

     3

commit e3d8ce88ea25b14cf2840ccd41cebc8f68663b8e
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:02 2020 -0200
Commit:     VenomVendor <info@VenomVendor.com>
CommitDate: Thu Oct 22 19:41:02 2020 -0200

     2

commit 20731cb051e42dd5435dec4157aa58203e5fc60d
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:40:59 2020 -0200
Commit:     VenomVendor <info@VenomVendor.com>
CommitDate: Thu Oct 22 19:40:59 2020 -0200

     1


$ git rebase --committer-date-is-author-date HEAD~2
Current branch master is up to date, rebase forced.
Successfully rebased and updated refs/heads/master.


$ git log --format=fuller
commit be24ee5cd9b76b0f11599b4f8af2609f6c5f3b06 (HEAD -> master)
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:05 2020 -0200
Commit:     VenomVendor <>
CommitDate: Thu Oct 22 19:41:05 2020 -0200

     3

commit c45d01b6969281d11fc78f60cb0c4d830f216892
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:41:02 2020 -0200
Commit:     VenomVendor <>
CommitDate: Thu Oct 22 19:41:02 2020 -0200

     2

commit 20731cb051e42dd5435dec4157aa58203e5fc60d
Author:     VenomVendor <info@VenomVendor.com>
AuthorDate: Thu Oct 22 19:40:59 2020 -0200
Commit:     VenomVendor <info@VenomVendor.com>
CommitDate: Thu Oct 22 19:40:59 2020 -0200

     1
```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Mon Aug 31 22:12:52 
PDT 2020; root:xnu-6153.141.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.2)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

-VenomVendor
