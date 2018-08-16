Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7691F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389063AbeHPJut convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Aug 2018 05:50:49 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:50379 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389060AbeHPJut (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:50:49 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id DCC14673BA
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:54:27 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id C53A665DF7
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:54:27 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Thu, 16 Aug 2018 08:54:27 +0200
Message-Id: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Thu, 16 Aug 2018 08:54:25 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: non-smooth progress  indication for git fsck and git gc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'd like to point out some minor issue observed while processing some 50000-object repository with many binary objects, but most are rather small:

Between the two phases of "git fsck" (checking directories and checking objects) there was a break of several seconds where no progress was indicated.

During "git gc" the writing objects phase did not update for some seconds, but then the percentage counter jumped like from 15% to 42%.

I understand that updating the progress output too often can be a performance bottleneck, while upating it too rarely might only bore the user... ;-)

But maybe something can be done. My git version is 2.13.7 (openSUSE 42.3).

Regards,
Ulrich


