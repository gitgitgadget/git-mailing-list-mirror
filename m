Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F1F1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQIFK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 17 Jul 2019 04:05:10 -0400
Received: from mx3.uni-regensburg.de ([194.94.157.148]:54680 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQIFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 04:05:10 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 04:05:09 EDT
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 91B52600005B
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 09:58:07 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 7A753600004D
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 09:58:07 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 17 Jul 2019 09:58:07 +0200
Message-Id: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 17 Jul 2019 09:58:05 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Merge: "git rm bla": "bla: needs merge", but still removes
 file "bla"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I just had "an interesting case" for a merge with conflicts:
The merge re-introduced a file that had been renamed (say old one is "bla", and the new one is "foo").
After merging the changes from bla into foo, I added foo, trying to remove bla:
> git add foo
> git rm bla
bla: needs merge
rm 'bla'

The interesting part is that the file was still removed, while claiming "needs merge" before:
> git rm bla
fatal: pathspec 'bla' did not match any files

(git-2.12.3-27.14.1.x86_64 from SLES12 SP4)

Regards,
Ulrich


