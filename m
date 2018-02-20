Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48871F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeBTUgi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Feb 2018 15:36:38 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37137 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTUgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:36:37 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1KKaZfo087945
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 15:36:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] Worktree prune complains about missing path
Date:   Tue, 20 Feb 2018 15:36:30 -0500
Message-ID: <005301d3aa8a$80521c70$80f65550$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0047_01D3AA60.058C27D0";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIJ8l7pfDfsDj9GgxhoQvkhLfGo6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I’m a bit confused about this, as I thought I understood worktrees :(.

/home/randall/nsgit/test/test dir.mytest/dest git worktree list
/home/randall/nsgit/test/test dir.mytest/dest: git worktree list
/home/randall/nsgit/test/test dir.mytest/dest     4e901ca [master]
/home/randall/nsgit/test/test dir.mytest/dest.wt  4e901ca [dest.wt]

/home/randall/nsgit/test/test dir.mytest/dest: find . -name dest.wt
./.git/logs/refs/heads/dest.wt
./.git/refs/heads/dest.wt
./.git/worktrees/dest.wt
/home/randall/nsgit/test/test dir.mytest/dest/.git: cd worktrees/dest.wt
/home/randall/nsgit/test/test dir.mytest/dest/.git/worktrees/dest.wt: ls
HEAD  ORIG_HEAD  commondir  gitdir  index  logs

/home/randall/nsgit/test/test dir.mytest/dest/.git/worktrees/dest.wt: cat
gitdir
/home/randall/nsgit/test/test dir.mytest/dest.wt/.git

/home/randall/nsgit/test/test dir.mytest/dest/.git/worktrees/dest.wt: ls
HEAD  ORIG_HEAD  commondir  gitdir  index  logs

/home/randall/nsgit/test/test dir.mytest/dest/.git/worktrees/dest.wt: cd
../../../..
/home/randall/nsgit/test/test dir.mytest: rm -rf dest.wt
/home/randall/nsgit/test/test dir.mytest: cd dest
/home/randall/nsgit/test/test dir.mytest/dest: git worktree prune -v
Removing worktrees/dest.wt: gitdir file points to non-existent location

It seems like one or two situations are a problem:
1) I’m using a full path for the worktree. 
2) There’s a blank in my path – deliberate… tests, yanno.

This is git 2.16.2. Could anyone shed some light on this?

Cheers,
Randall


