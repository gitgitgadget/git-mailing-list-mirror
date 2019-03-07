Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA7C20248
	for <e@80x24.org>; Thu,  7 Mar 2019 13:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCGNbr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 08:31:47 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:39698 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 08:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e9wJerNTeXxDhPQQ9WofsbKo+cnB3vduO3C5gKKwXNU=; b=qmhCatsjqv9CFr++Ll8B8RFH85
        ckp6Y4mxemmIc1SVbm6BkRcDJKzsm8abTSeHWY+l8tggIpdfGVbDLYO8fFA98HTp76osPI4L2vHSv
        g0KC9rgEoC4GxUKkB+BKwi/dg33lxs9+jfR9POXgY4DDihyMJmHCdjBtDAV5KC906o0kHmNDiqEVi
        1rD4uxhUfJMLypl6CoRA8a1PR3iOVHDYFhOqS8q2Y/YAkh5V26Eq6ON60XcUFk9EgiMQHNkf0lf6t
        pRlRGuXkyrCJuuD8fY38C7AaGFd0rYsSQ8bW+Ok/swcTYcj7xcxS48DWKCQmmZEaCcU7pnyBU03U0
        bRS/Ny+A==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:46402 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h1t7g-007qfg-HO
        for git@vger.kernel.org; Thu, 07 Mar 2019 08:31:45 -0500
Date:   Thu, 7 Mar 2019 08:31:43 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: worth mentioning branch "mergeOptions" from "man git-merge"?
Message-ID: <alpine.LFD.2.21.1903070825230.8072@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  reading, in various places, people asking how to globally set
options for merging, to which the standard answer is, no, you can't do
that *globally*, but you can do it on a per-branch basis with

  branch.<branchname>.mergeOptions

the most common example being to squash into master:

  git config branch.master.mergeOptions "--squash"

however, i read in "man git-config":

merge.ff
    By default, Git does not create an extra merge commit when
    merging a commit that is a descendant of the current
    commit. Instead, the tip of the current branch is
    fast-forwarded. When set to false, this variable tells Git
    to create an extra merge commit in such a case (equivalent
    to giving the --no-ff option from the command line). When
    set to only, only such fast-forward merges are allowed
    (equivalent to giving the --ff-only option from the command
    line).

where (based on a quick test i tried and, hopefully, did not screw
up), the per-branch mergeOptions value for fast-forwarding takes
precedence over the global merge.ff value.

  this is the only merge option i've noticed that has a global
settings as well as per-branch setting. is it worth putting in an
extra line or two mentioning this in the man page? that is, as long as
i've understood this correctly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
