Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135AEC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37FC20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDGSsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:48:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:55262 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgDGSsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:48:22 -0400
IronPort-SDR: ZQKoJyrXpiZYyUL4id/aIH8gkf3j/9E8pIwCdIcR16C1FOaNbkadmGf4xtLFcQuyJKUO//Os3e
 yWuSwLO7X7Ow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:48:22 -0700
IronPort-SDR: Q9FaBv0hXjSzGcYDTY6LZILTgCJbymyHklYvW0YdZLJgDBkogSTL2OGhWJsSV1TBrCHhWcPg5K
 ub8enyVVipPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="275195981"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2020 11:48:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jLtGq-00GV8f-07; Tue, 07 Apr 2020 21:48:24 +0300
Date:   Tue, 7 Apr 2020 21:48:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     git@vger.kernel.org
Cc:     andy.shevchenko@gmail.com
Subject: subtle bug in git-am
Message-ID: <20200407184823.GA3932679@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

What I would like to do is to apply patch from one repository to another with
same files but *different directory structure*.

When I try to change directory in the target repo to the folder of files, I run
git-am -p5 my_cool_patch.patch.

Instead of the expected result (files and their contents is the same!) I got
fileXXX is not in index.

So, I think this is a bug, because -p<n> use in git-am makes little to no sense
without above feature.

Perhaps I didn't understand something.
Please, advise.

$ git version
git version 2.25.1


-- 
With Best Regards,
Andy Shevchenko


