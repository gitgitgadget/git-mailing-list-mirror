Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051C91F461
	for <e@80x24.org>; Sun,  5 May 2019 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEEUMN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 5 May 2019 16:12:13 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:48754 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEEUMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 16:12:13 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 16:12:12 EDT
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E45306000055
        for <git@vger.kernel.org>; Sun,  5 May 2019 22:02:18 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id CF0BF600004E
        for <git@vger.kernel.org>; Sun,  5 May 2019 22:02:18 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Sun, 05 May 2019 22:02:18 +0200
Message-Id: <5CCF414A020000A10003108C@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Sun, 05 May 2019 22:02:18 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Surprising semantics of "git add file"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Reading the manual, I realized that "it is the way it is (it works as documented)", but to me it's surprising, meaning: I feel it's wrong:
(git-2.16.4)
I have staged several files, and then I do "git add -interactive file" to add some selected changes from file.
After that a "git diff --cached file" just shows the changes added interactively, but when I "git add file" to commit those changes), even the unstaged changes from file are committed.
I feel this is inconsistent: At least "git diff --cached file" should behave like "git commit file", meaning "git commit file" should be fixed IMHO.
Or are there any reasonable use cased for that?

Regards,
Ulrich Windl



