Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E94F208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 05:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdHMFEF (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 01:04:05 -0400
Received: from mail-ext-sout1.uwa.edu.au ([130.95.128.72]:36977 "EHLO
        mail-ext-sout1.uwa.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdHMFEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 01:04:04 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Aug 2017 01:04:04 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A5BADS2o9Z/8+AX4JdGwEBAQMBAQEJA?=
 =?us-ascii?q?QEBhVKPBI9QAQEBAQEBBoEImEwBiwEUAQIBAQEBAQEBayiFGgQ7BgEBOIEMRIo?=
 =?us-ascii?q?iBQiqE4MRgwgBAQWEcAeDfwiDKIMHgmCIMIIKDIMSkh6OGKcRlhU2IYEKMiEIG?=
 =?us-ascii?q?BmFHDWCH2kBiVwBAQE?=
X-IPAS-Result: =?us-ascii?q?A2A5BADS2o9Z/8+AX4JdGwEBAQMBAQEJAQEBhVKPBI9QAQE?=
 =?us-ascii?q?BAQEBBoEImEwBiwEUAQIBAQEBAQEBayiFGgQ7BgEBOIEMRIoiBQiqE4MRgwgBA?=
 =?us-ascii?q?QWEcAeDfwiDKIMHgmCIMIIKDIMSkh6OGKcRlhU2IYEKMiEIGBmFHDWCH2kBiVw?=
 =?us-ascii?q?BAQE?=
X-IronPort-AV: E=Sophos;i="5.41,366,1498492800"; 
   d="scan'208";a="295232356"
Received: from f5-new.net.uwa.edu.au (HELO mooneye.ucc.gu.uwa.edu.au) ([130.95.128.207])
  by mail-ext-out1.uwa.edu.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2017 12:53:58 +0800
Received: by mooneye.ucc.gu.uwa.edu.au (Postfix, from userid 801)
        id 6DB6166002; Sun, 13 Aug 2017 12:53:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ucc.gu.uwa.edu.au;
        s=ucc-2016-3; t=1502600038;
        bh=8PJr+8NzCkt5z8PxTkpiCd9RA/B5CmvPDvoZJfWXZ6I=;
        h=Date:From:To:Subject:From;
        b=HAdZsR+GKd7A/+H0yV7lqiMRoSmO4+2Z0cfBOP/HJcHFKjQPn/gA2Rnfal84D99NQ
         L0bmXfHTsSaYwIFA5S/akQ7i2NEOaCe37gJuukNEn9sph+oKc4TiQCpQ8M9dsj3B09
         x+tTCPFNv0AhBeLZHmdHePsOw6sWgJfvhPyIfW3g=
Received: from motsugo.ucc.gu.uwa.edu.au (motsugo.ucc.gu.uwa.edu.au [130.95.13.7])
        by mooneye.ucc.gu.uwa.edu.au (Postfix) with ESMTP id 42C4666001
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:53:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ucc.gu.uwa.edu.au;
        s=ucc-2016-3; t=1502600038;
        bh=8PJr+8NzCkt5z8PxTkpiCd9RA/B5CmvPDvoZJfWXZ6I=;
        h=Date:From:To:Subject:From;
        b=HAdZsR+GKd7A/+H0yV7lqiMRoSmO4+2Z0cfBOP/HJcHFKjQPn/gA2Rnfal84D99NQ
         L0bmXfHTsSaYwIFA5S/akQ7i2NEOaCe37gJuukNEn9sph+oKc4TiQCpQ8M9dsj3B09
         x+tTCPFNv0AhBeLZHmdHePsOw6sWgJfvhPyIfW3g=
Received: by motsugo.ucc.gu.uwa.edu.au (Postfix, from userid 11251)
        id 3BDB924F94; Sun, 13 Aug 2017 12:53:58 +0800 (AWST)
Received: from localhost (localhost [127.0.0.1])
        by motsugo.ucc.gu.uwa.edu.au (Postfix) with ESMTP id 36E9524F93
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:53:58 +0800 (AWST)
Date:   Sun, 13 Aug 2017 12:53:58 +0800 (AWST)
From:   David Adam <zanchey@ucc.gu.uwa.edu.au>
To:     git@vger.kernel.org
Subject: Bug?: git archive exclude pathspec and gitattributes export-ignore
Message-ID: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I think I have a bug in git (tested 2.11.0 on Debian 8, 2.14.1 on OS X and 
2.14.1.145.gb3622a4 on OS X).

Given a repository with an export-ignore directive for a subdirectory in 
.gitattributes, `git archive` with a pathspec that excludes a different 
subdirectory produces no output file and git exits with -1 as the return 
status.

As shown:

   > git init foo && cd foo
   Initialized empty Git repository in /Users/david/src/foo/.git/
   > mkdir a b
   > touch {a,b}/somefile
   > echo "/a export-ignore" >> .gitattributes
   > git add .
   > git commit -m "Initial commit"
   [master (root-commit) 53527a7] Initial commit
    3 files changed, 1 insertion(+)
    create mode 100644 .gitattributes
    create mode 100644 a/somefile
    create mode 100644 b/somefile
   > git archive --verbose master ':(top)' ':(exclude)b*'
   .gitattributes
   > echo $?
   255

If this is intended behaviour, is there any way of achieving the goal of 
excluding a subdirectory not listed as export-ignore? Using the exclude 
pathspec ":(exclude)b" produces an empty subdirectory b in the output, 
which I would like to avoid.

This is a reduced testcase; my goal is to end up with two archives, one 
containing directory b only, and one containing everything except for 
directory b - so I can't just add 'b export-ignore' to gitattributes.

Thanks

David Adam
zanchey@ucc.gu.uwa.edu.au
