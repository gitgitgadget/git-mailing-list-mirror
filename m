Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0ED1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 18:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfDVSSj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 14:18:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:36362 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfDVSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 14:18:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 145313F4954;
        Mon, 22 Apr 2019 14:18:38 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:3443:1387:8d77:9c9b] (unknown [IPv6:2001:4898:8010:0:1d79:1387:8d77:9c9b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B77EA3F4953;
        Mon, 22 Apr 2019 14:18:37 -0400 (EDT)
Subject: Re: [PATCH 5/5] difftool: fallback on merge.guitool
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <fb7ac11439cbfd52d9181b78fdc8f8034a6b1064.1555880168.git.liu.denton@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2a521a5c-4b5d-57aa-1e91-d4ec9b190fb7@jeffhostetler.com>
Date:   Mon, 22 Apr 2019 14:18:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fb7ac11439cbfd52d9181b78fdc8f8034a6b1064.1555880168.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/22/2019 1:07 AM, Denton Liu wrote:
> In git-difftool.txt, it says
> 
> 	'git difftool' falls back to 'git mergetool' config variables when the
> 	difftool equivalents have not been defined.
> 
> However, when `diff.guitool` is missing, it doesn't fallback to
> anything. Make git-difftool fallback to `merge.guitool` when `diff.guitool` is
> missing.
> 

Is this a well-defined operation?

I mean, we're assuming here that a 3-way gui merge tool (that probably
expects 3 input pathnames and maybe a 4th merge-result pathname (and
associated titles and etc)) can function sanely when only given the
pair that a diff would have.

That is, we're assuming that the selected merge tool has a 2-way diff
mode and that the command line args for the 2- and 3-way views are
compatible.

Just a thought
Jeff


