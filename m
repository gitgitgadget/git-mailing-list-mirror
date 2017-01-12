Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DE81FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 13:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbdALNpa (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 08:45:30 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:55099 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdALNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 08:45:29 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tzn8750DXz5tlJ;
        Thu, 12 Jan 2017 14:45:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 98C773A6;
        Thu, 12 Jan 2017 14:45:26 +0100 (CET)
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Jacob Keller <jacob.e.keller@intel.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
Date:   Thu, 12 Jan 2017 14:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170112001721.2534-6-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.2017 um 01:17 schrieb Jacob Keller:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-describe the `--discard` option which will allow specifying
> a glob pattern of tags to ignore. This can be combined with the
> `--match` patterns to enable more flexibility in determining which tags
> to consider.
>
> For example, suppose you wish to find the first official release tag
> that contains a certain commit. If we assume that official release tags
> are of the form "v*" and pre-release candidates include "*rc*" in their
> name, we can now find the first tag that introduces commit abcdef via:
>
>   git describe --contains --match="v*" --discard="*rc*"

I have a few dozen topic branches, many of them are work in progress and 
named wip/something. To see the completed branches, I routinely say

     gitk --exclude=wip/* --branches

these days.

It would be great if you could provide the same user interface here. The 
example in the commit message would then look like this:

    git describe --contains --exclude="*rc*" --match="v*"

(I'm not saying that you should add --branches, but that you should 
prefer --exclude over --discard. Also, the order of --exclude and 
--match would be important.)

-- Hannes

