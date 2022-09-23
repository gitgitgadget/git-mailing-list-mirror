Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DBC6FA86
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWVDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiIWVDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:03:22 -0400
X-Greylist: delayed 553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 14:03:18 PDT
Received: from clausfischer.com (clausfischer.com [78.46.66.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D311D0F5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:03:18 -0700 (PDT)
Received: from newton.clausfischer.com (localhost.localdomain [127.0.0.1])
        by clausfischer.com (Postfix) with ESMTP id 512948A0577
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 22:54:03 +0200 (CEST)
Received: by newton.clausfischer.com (Postfix, from userid 1000)
        id 2272239A0C76; Fri, 23 Sep 2022 22:54:03 +0200 (CEST)
Date:   Fri, 23 Sep 2022 22:54:03 +0200
From:   Claus Fischer <claus.fischer@clausfischer.com>
To:     git@vger.kernel.org
Subject: Scriptable mode for git bisect
Message-ID: <Yy4c6/jHupgThj7j@clausfischer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Dear Git maintainers,

I have looked at the manpage of git bisect but have not found
what I need:
I would like git bisect not just to report the 'bad' revision
within a bunch of text but instead either stop at the first
bad revision (the last good will then be HEAD~1) or report
it in a scriptable way, i.e.

  BADHEAD=$(git bisect run --shut-up-and-report-the-bad)

Have I overlooked anything?

***

The pourpose is to keep the source trees of two different
projects that share a few files synchronous.
My good/bad-script is a script that checks whether these
files are similar.
I want git to stop at the first change in source tree A
so that I can update source tree B with the same commit
message, then proceed to the next change in A that
changes one of those files.

Regards,

Cluas
