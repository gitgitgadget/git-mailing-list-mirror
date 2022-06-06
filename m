Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD77C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 06:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiFFGBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiFFGBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 02:01:36 -0400
X-Greylist: delayed 1053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 23:01:34 PDT
Received: from mail42c45.carrierzone.com (mail42c45.carrierzone.com [216.55.147.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED533A33
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 23:01:33 -0700 (PDT)
X-Authenticated-User: steve@sprangle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=carrierzone.com;
        s=mailmia; t=1654494238;
        bh=GwsZaVvb8gl9a7X4vcaIzBskShQk8qnKbsffqq1J0Z0=;
        h=Date:To:From:Subject:From;
        b=ylmMB4H+LfcZGnf0FebgrqUAPANPfZgUoHj0WGro5MHlV1OMP5vU9Oguw3h/2hz4o
         zzBvXaliin5BVEaG0XxMWu1NANyUQlY2FYS4S2sNjFo1HyPoQHi65vqACFlpR1FomR
         EoqUjMpwPzgLiU3F9ikj3ATV7/0RNYz8Jl4owEnQ=
Feedback-ID: steve@sprangle.
Received: from [192.168.1.185] (99-87-207-26.lightspeed.irvnca.sbcglobal.net [99.87.207.26])
        (authenticated bits=0)
        by mail42c45.carrierzone.com (8.14.9/8.13.1) with ESMTP id 2565hv7A025267
        for <git@vger.kernel.org>; Mon, 6 Jun 2022 05:43:58 +0000
Message-ID: <e308be58-a399-8e5c-36a8-96d3d58caff3@sprangle.com>
Date:   Sun, 5 Jun 2022 22:43:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Steven Jonn Edlefsen <steve@sprangle.com>
Subject: git bug: Including a git repository in a directory
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH-RefID: str=0001.0A742F2A.629D941E.003D:SCFSTAT99132221,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: -4.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-Origin-Country: US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git cannot commit/push a directory with a git repository in
a sub-directory.

The sub-directory with the git repository and the directories below
are set to the “master” branch, while the directories above remain
set to the new branch.

When the top directory is committed, the sub-directory with the
git repository appears as an empty file.

Even when the subdirectory branch name is changed from master
to the new branch and the top directory is re-commited/pushed,
the same problem occurs.

When the git repository in the sub-directory is removed, e.g.
the .git file is removed, and top directory is committed/pushed,
the subdirectory has all the sub-directories and files.

Steve Edlefsen

