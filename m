Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F272220798
	for <e@80x24.org>; Fri, 13 Jan 2017 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdAMGnP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 01:43:15 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:5014 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750700AbdAMGnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 01:43:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3v0CkS50CQz5tlK;
        Fri, 13 Jan 2017 07:43:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 28751123;
        Fri, 13 Jan 2017 07:43:12 +0100 (CET)
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Jacob Keller <jacob.keller@gmail.com>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com>
 <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
 <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org>
Date:   Fri, 13 Jan 2017 07:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.2017 um 01:59 schrieb Jacob Keller:
> I think that --exclude makes sense, but the current implementation
> does not differentiate ordering, since both are merely accumulated
> into string_lists and then matched together. I'm not sure how order
> would impact things here? In the current implementation, if something
> is excluded and matched, it will be excluded. That is, exclusion
> patterns take precedence over match patterns. I think this makes the
> most sense semantically.

When you write

   git log --exclude=wip/* --branches --remotes

--exclude applies only to --branches, not to --remotes.

  When you write

   git log --branches --exclude=origin/* --remotes

--exclude=origin/* applies only to --remotes, but not to --branches.

-- Hannes

