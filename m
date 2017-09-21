Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C98F202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 17:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdIUR5c (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 13:57:32 -0400
Received: from gaveup.net ([96.126.124.22]:33546 "EHLO gaveup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbdIUR5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 13:57:31 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Sep 2017 13:57:31 EDT
Received: from gaveup.dyndns.org (cpe-69-23-106-160.new.res.rr.com [69.23.106.160])
        by gaveup.net (Postfix) with ESMTPSA id 0B046C038
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaveup.net; s=mail;
        t=1506016227; bh=MR5+MDRWs4XNMii/TL7jmv2Df2FSWEu0UMlOa0CmzBg=;
        h=Date:From:To:Subject:Reply-To:From;
        b=WOUQoQG3Up8V7kjJzeSRz8N6Us5AYDA/qnbGNru1alVWnvld3ThplBYshfrgzfeV9
         NeDBbcC8X23JBTmSHIarQdlVl0OmGbtR0g+fb21hdHQg5oSYLU1v/T08j3c00v0wJ3
         VzRQ6KvBYHQMp2tgtFfY0HvWZVwkT3tghe2BDAdU=
Date:   Thu, 21 Sep 2017 12:50:17 -0500
From:   GaveUp <gaveup@gaveup.net>
To:     git@vger.kernel.org
Subject: commit-msg hook with verbose commit flag
Message-ID: <20170921175017.GR1557@sunnydale2.internal.pylea.com>
Reply-To: GaveUp <gaveup@gaveup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --verbose flag on git-commit with a commit-msg hook the
contents of the diff are passed to the commit-msg hook.  I would have
expected the diff to have been removed since it's below the scissor
line.  Since the scissor line is removed and not visible to commit-msg
there doesn't seem to be a great way to ignore the diff contents either.
