Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFC51FD99
	for <e@80x24.org>; Sat, 27 Aug 2016 02:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754782AbcH0CfD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 22:35:03 -0400
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:46908 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754241AbcH0CfC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Aug 2016 22:35:02 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Aug 2016 22:35:02 EDT
Received: from atl4mhob21.registeredsite.com (atl4mhib21.registeredsite.com [209.17.115.115] (may be forged))
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u7R2Trxl014673
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 22:29:53 -0400
Received: from mailpod.hostingplatform.com ([10.30.77.36])
        by atl4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id u7R2TpXd082455
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 22:29:51 -0400
Received: (qmail 4356 invoked by uid 0); 27 Aug 2016 02:29:51 -0000
X-TCPREMOTEIP: 73.89.103.237
X-Authenticated-UID: porter@devrts.com
Received: from unknown (HELO ?192.168.1.14?) (porter@devrts.com@73.89.103.237)
  by 0 with ESMTPA; 27 Aug 2016 02:29:50 -0000
To:     git@vger.kernel.org
From:   Brett Porter <porter@devrts.com>
Subject: stable as subset of develop
Message-ID: <57C0FB1D.9070206@devrts.com>
Date:   Fri, 26 Aug 2016 22:29:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In a small group, develop is the branch where all fixes/additions/... from topic
branches are merged rather dynamically. Thorough testing of commits may lag behind,
but when we think one is a pretty good commit we want to identify it as (at least
relatively) the latest stable. We could tag it, but we would like these stable commits to
be a branch in the sense that each commit points back to a previous commit.

Merging from a development branch commit to stable isn't quite what we want. It seems
more like:

   checkout the new good development commit
   change HEAD to the head of the stable branch
   git add --all
   git commit
   (maybe tag the new commit with the hash of the chosen development commit)

Will that work (one thing beyond my current understanding is if there are index complications)?
Other ideas?

This could help with applying successively more intense testing over time and chase down
where problems arose.
