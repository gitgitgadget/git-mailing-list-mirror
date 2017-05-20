Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782B5201CF
	for <e@80x24.org>; Sat, 20 May 2017 06:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdETG3Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:29:16 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:47939 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbdETG3P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:29:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wVFPj6k7Bz5tlD;
        Sat, 20 May 2017 08:29:13 +0200 (CEST)
Received: from dx.site (localhost [127.0.0.1])
        by dx.site (Postfix) with ESMTP id 2FAF342E7;
        Sat, 20 May 2017 08:29:13 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
Date:   Sat, 20 May 2017 08:28:37 +0200
Message-Id: <cover.1495261020.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.13.0.55.g17b7d13330
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small series fixes these warnings on Windows:

C:\Temp\gittest>git fetch C:\Temp\gittest
warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
From C:\Temp\gittest
 * branch            HEAD       -> FETCH_HEAD

The fix is in the second patch; the first patch is a
preparation that allows to write the fix in my preferred style.

Johannes Sixt (2):
  mingw.h: permit arguments with side effects for is_dir_sep
  Windows: do not treat a path with backslashes as a remote's nick name

 compat/mingw.h | 6 +++++-
 remote.c       | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.13.0.55.g17b7d13330

