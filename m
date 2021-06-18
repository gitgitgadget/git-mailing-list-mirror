Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DDC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 06:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CCE6101A
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 06:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhFRGqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:46:18 -0400
Received: from mout02.posteo.de ([185.67.36.66]:35731 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhFRGqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 02:46:18 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0D663240101
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 08:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1623998648; bh=WAwCjrFYancCsELjdRpfoGcZCAQd8XIQTdWR4slkFLM=;
        h=Date:From:To:Cc:Subject:From;
        b=gGyOYVkQS4eTnTEAp9JQTE6s0NmZj5E/R32Z00f9b1BKpJ4PrfWp2aeEDvpGPxP3Q
         kRAmaTyZBuVm1LTacCATXdC20KH/oAwvASyWz9smg31r42vKeSjJUBYWBtxFHmDLnj
         JmLKRl0fQ7TFuujDQGJIt7qY+U1QZeyA+LMiSJU4sHP5wp+ml4dGnoWO2sS9/sWYDr
         6xPVwsOckb/xroKIoeXLlk2P45Z/9XB97DkRvB1+Wi6oj3Pd3Ha6mvYQaHIYDwdfFm
         WmK+cn4BZsMedECzhwl6YA7EkJwyZyr5VeBXEKEGO8KUqhqnGDnEZyS1lQduBeov6q
         wfrr5U3xcmKAQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G5qCB5CNFz6tmZ;
        Fri, 18 Jun 2021 08:44:06 +0200 (CEST)
Date:   Fri, 18 Jun 2021 06:44:05 +0000
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     "Tessa L. H. Lovelace" <tessa@assorted.tech>
Cc:     git@vger.kernel.org
Subject: Re: Using .gitignore symbolic links?
Message-ID: <YMxAteKYn0qf/YNj@BDZ>
References: <1623983680.3494.0@smtp.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623983680.3494.0@smtp.dreamhost.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 07:34:40PM -0700, Tessa L. H. Lovelace wrote:
> Secondly, and more personally important to me, a system administrator:
> My repositories use symbolic links to allow a single .gitignore file to 
> define my folder structure, allowing me to avoid hardcoding the 
> repo-specific folder paths into my configs.
> 
> Is there a flag to disable this new behavior?
> 
> If not, this change means I need to update dozens of files, duplicates 
> all, or completely rewrite my .gitignore files to have shyteloads of 
> arbitrary file paths in them, which I'd rather not do.

Hmm, it sounds like `core.excludesFile` described in git-config(1) could
do what you need:

  core.excludesFile
      Specifies the pathname to the file that contains patterns to
      describe paths that are not meant to be tracked, in addition to
      .gitignore (per-directory) and .git/info/exclude. Defaults to
      $XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set
      or empty, $HOME/.config/git/ignore is used instead. See
      gitignore(5).

Regards,
Robert Karszniewicz
