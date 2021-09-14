Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE2C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2CF6112D
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhINFux (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:50:53 -0400
Received: from verein.lst.de ([213.95.11.211]:58512 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239813AbhINFuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:50:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1224767357; Tue, 14 Sep 2021 07:49:27 +0200 (CEST)
Date:   Tue, 14 Sep 2021 07:49:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Message-ID: <20210914054926.GA26190@lst.de>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 03:38:39AM +0000, Neeraj K. Singh via GitGitGadget wrote:
> NOTE: Based on Christoph Hellwig's comments, the 'batch' mode is not correct
> on Linux, since sync_file_range does not provide data integrity guarantees.
> There is currently no kernel interface suitable to achieve disk flush
> batching as is, but he suggested that he might implement a 'syncfs' variant
> on top of this patchset. This code is still useful on macOS and Windows, and
> the config documentation makes that clear.

If this series lands I can give the syncfs variant a spin.  It might not
be the best option for gt hosting services, but I think it will be very
helpful for typical developer workstations.
