Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D761FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 08:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932072AbdDEIJr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 5 Apr 2017 04:09:47 -0400
Received: from sirac.alma.fr ([164.177.24.217]:38302 "EHLO sirac.alma.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932065AbdDEIJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 04:09:45 -0400
X-Greylist: delayed 1893 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Apr 2017 04:09:45 EDT
Received: from localhost (localhost [127.0.0.1])
        by localhost.alma.fr (Postfix) with ESMTP id 4BAF7130003;
        Wed,  5 Apr 2017 09:35:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at alma.fr
Received: from sirac.alma.fr ([127.0.0.1])
        by localhost (sirac.alma.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dsVMUUVoBdqH; Wed,  5 Apr 2017 09:35:46 +0200 (CEST)
Received: from mail.alma.fr (srv-mail.alma.fr [172.30.1.23])
        by sirac.alma.fr (Postfix) with ESMTP id D5271130005;
        Wed,  5 Apr 2017 09:35:46 +0200 (CEST)
Received: from SRV-MAIL.alma.fr (172.30.1.23) by SRV-MAIL.alma.fr
 (172.30.1.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.544.27; Wed, 5 Apr
 2017 09:38:07 +0200
Received: from SRV-MAIL.alma.fr ([fe80::c172:69ed:574b:5afd]) by
 SRV-MAIL.alma.fr ([fe80::c172:69ed:574b:5afd%12]) with mapi id
 15.01.0544.027; Wed, 5 Apr 2017 09:38:07 +0200
From:   =?iso-8859-1?Q?R=E9mi_Galan_Alfonso?= 
        <remi.galanalfonso@almacam.com>
To:     Git Mailing List <git@vger.kernel.org>
CC:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Segfault on git for Windows
Thread-Topic: Segfault on git for Windows
Thread-Index: AdKt2g2s+n9h7ytfTvKk1LS/47qVbQ==
Date:   Wed, 5 Apr 2017 07:38:07 +0000
Message-ID: <ca311f4c1abc4460b6bc2d444916b6bf@almacam.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.9.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am unsure whether it's Windows only or not, so I'm sending here and
CCing Dscho.

At $DAYWORK, the code is versionned under SVN. Since I haven't used
SVN before and try to have a clean and bisectable history, I installed
git with the intent to manage my code locally before pushing to SVN
when I'm satisfied (I haven't tries git-svn because I have never used
it and would like to avoid screwing up the SVN repo by some mistake).

So first to setup the local repo, I wanted to add all of the code
files. So I first ran at the root of the repo:
  $ git add ./**.cpp
Which is quite a big amount of files (partly because of external
dependencies which would have been smart to exclude, but it's
done).
  $ find -type f -name "**.cpp" | wc -l
  8676
This command worked (return status is 0 and no error message).

However following `git add **.hpp` and `git status` segfault with no
additional message:
  $ git status
  Segmentation fault
I didn't try to test other commands (`git diff --cached` works
though).

$ git --version
git version 2.12.2.windows.1

This seems to be reproducible.

Sadly I won't be able to share the repo where this happens.

FWIW:
  $ git fsck
  notice: HEAD points to an unborn branch (master)
  Checking object directories: 100% (256/256), done.
  notice: No default references

Thanks,
Rémi Galan Alfonso
