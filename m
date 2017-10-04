Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3390B20281
	for <e@80x24.org>; Wed,  4 Oct 2017 11:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdJDLKs (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 07:10:48 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:58406 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdJDLKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 07:10:47 -0400
Received: from [::1] (port=59476 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dzhZe-0005vF-KQ
        for git@vger.kernel.org; Wed, 04 Oct 2017 07:10:46 -0400
Received: from 158.116.144.29 ([158.116.144.29]) by crashcourse.ca (Horde
 Framework) with HTTPS; Wed, 04 Oct 2017 07:10:46 -0400
Date:   Wed, 04 Oct 2017 07:10:46 -0400
Message-ID: <20171004071046.Horde.89FTNuoUz8wPxhsuejrB03G@crashcourse.ca>
From:   rpjday@crashcourse.ca
To:     git@vger.kernel.org
Subject: distinguishing between staged and unstaged content in a stash?
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday@crashcourse.ca
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


   couple (admittedly trivial) questions about stashing. first, can i
clarify that when one stashes content, a stash *always* distinguishes
between what was staged, and what was unstaged? that is, when one is
stashing, the "--keep-index" option relates to whether or not staged
changes are left in the index (and, consequently, in the working
directory as well), but that option has no effect on the final content
of the stash, yes? even if "--keep-index" is used, staged content
still ends up in the stash.

   also, is there a simple way to distinguish between the staged and
unstaged contents of a stash (or, more basically, is this even a
useful question to ask)? out of curiosity, i tried to figure out
how to do this, and came up with the following.

to see staged portion of stash@{0}:

   $ git show stash@{0}^2

to see unstaged portion:

   $ git diff stash@{0}^2 stash@{0}

it's not like i have a pressing need to do that, i was just curious
if there's a simpler way to do this, or if this is just not something
people should need to do on a regular basis.

rday



