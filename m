Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C6320958
	for <e@80x24.org>; Fri, 31 Mar 2017 07:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbdCaHkT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Mar 2017 03:40:19 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:56180 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbdCaHkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 03:40:19 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Mar 2017 03:40:18 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 8F7065B272
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 09:30:38 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 2D8595B260
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 09:30:37 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Fri, 31 Mar 2017 09:30:34 +0200
Message-Id: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 14.2.2 
Date:   Fri, 31 Mar 2017 09:30:32 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Terrible bad performance for it blame --date=iso -C -C master
 -- <file>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi!

I was running "vc-annotate" in Emacs for a file from a large repository (>40000 files, a big percentage being binary, about 10 commits). For the first file the result was presented rather soon, but for a second file the command did not finish even after about 10 minutes!

The file in question is a rather short text file (124 kB), and according to git log it has one commit.

While being bored, I did an strace of the command to find out that a huge number of files is inspected.

I'm using git of openSUSE LEap 42.2 (git-2.10.2-3.1.x86_64).

Here's the stat of the process:

% cat /proc/6307/stat
6307 (git) R 6189 6307 6307 0 -1 4194304 30514692 0 1860 0 142035 6333 0 0 20 0 1 0 14519800 5850595328 391884 18446744073709551615 4194304 6038988 140726752300720 140726752293728 5549816 0 0 67108864 0 0 0 0 17 2 0 0 28211 0 0 8138160 8173100 9625600 140726752306005 140726752306072 140726752306072 140726752309227 0

Regards,
Ulrich

