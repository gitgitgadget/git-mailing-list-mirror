Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20C01F85A
	for <e@80x24.org>; Tue,  3 Jul 2018 20:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeGCU4W convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 3 Jul 2018 16:56:22 -0400
Received: from mail.redfish-solutions.com ([66.232.79.143]:47610 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752620AbeGCU4V (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Jul 2018 16:56:21 -0400
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 16:56:21 EDT
Received: from macmini.redfish-solutions.com (macmini.redfish-solutions.com [192.168.1.38])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id w63KeqBv002479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 3 Jul 2018 14:40:52 -0600
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Better interoperability with Bitkeeper for fast-import/-export
Message-Id: <E37C3A33-489B-4FEB-9170-097514B41317@redfish-solutions.com>
Date:   Tue, 3 Jul 2018 14:40:50 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I tried to import into git a repo that I was working on (because it just seemed easier), but when I tried to export the repo back out after making my changes I found it choking on a few things.

It was explained to me (by the Bitkeeper folks) that git meta-data doesn’t accurately track file moves…  If a file disappears from one place and reappears in another with the same contents, that’s assumed to be a move.

Given that “git mv” is an explicit action, I’m not sure why that wouldn’t be explicitly tracked.

But I’ve not looked too closely under the covers about how git represents stuff, so maybe there’s more to it than I’m assuming.

During an export using “-M” and “-C”, Bitkeeper complained:

fast-import: line 'R ports/winnt/libntp/nt_clockstuff.c ports/winnt/ntpd/nt_clockstuff.c' not supported

so I tried removing those two options, and it got further, this time stalling on:

fast-import: Unknown command: tag ntp-stable

I like git, mostly because I’ve used it a lot more… and I like the GitHub service.  I use Bitkeeper because a few projects I work on are already set up to use it and it’s not my call whether it’s worth the effort to make the conversion or live with it.

So… this is an appeal for both to play better together.

What’s involved in getting git to track file/directory moves/renames so that it’s palatable to Bitkeeper?

Thanks,

-Philip

