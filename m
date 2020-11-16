Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4427C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B74C20684
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgKPKSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:18:55 -0500
Received: from cpanel8.indieserve.net ([199.212.143.3]:57377 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgKPKSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:54 -0500
X-Greylist: delayed 3626 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 05:18:53 EST
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:41682 helo=localhost.localdomain)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1keaeY-0006iV-G5
        for git@vger.kernel.org; Mon, 16 Nov 2020 04:18:26 -0500
Date:   Mon, 16 Nov 2020 04:18:24 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Git Mailing list <git@vger.kernel.org>
Subject: can someone verify operation of "splitpatch" with a massive "git
 diff"?
Message-ID: <fc5cf6bc-aa74-d8-90b-c1789f349b8c@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  someone just handed me a several thousand line layer-wide patch, and
i'd like to pull it apart into bite-sized pieces, and i just noticed
the utility "splitpatch", but when i applied it to the patch, what i
got was *almost* right ... except that the patch snippets had the
trailing "git diff" line from the *following* patch snippet in the
file; the splitting operation clearly retained the trailing line after
the patch, rather than the leading line that actually represented the
snippet.

  is there a simple way to do this? i do have the right to go back to
the patch creator and ask him to redo the diff in a different way.
thoughts?

rday
