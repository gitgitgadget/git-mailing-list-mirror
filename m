Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438D91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 02:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeILH2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 03:28:06 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43989 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeILH2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 03:28:06 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id zuqpf5yfQjlDzzuqqfzLIt; Wed, 12 Sep 2018 03:25:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=4cJwSeBw3gWvPwq36-EA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 6/9] submodule.c: do not copy around submodule list
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180911234951.14129-1-sbeller@google.com>
 <20180911234951.14129-7-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b16af8c0-0435-0de4-ed6c-53888d6190af@ramsayjones.plus.com>
Date:   Wed, 12 Sep 2018 03:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911234951.14129-7-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA96XKyhlhZ8jOmZO64HTNHqLJa9ldAAWqWP+3LrpIvajNRUaAALYUDx2Y2A6Le/oG24l5QcHK4xyrSWMzA9wIeoj1lZevkwbO0XCmlrGxxfYTPHyoJj
 k2melGnMaEkQPyeKMrI+RYXd3MV7+eoZt6QwrjzY5z02PClQt4/IQQ0i05NzHkacwHagBx4FKsKb3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/09/18 00:49, Stefan Beller wrote:
> 'calculate_changed_submodule_paths' uses a local list to compute the
> changed submodules, and then produces the result by copying appropriate
> items into the result list.
> 
> Instead use the result list directly and prune items afterwards
> using string_list_remove_empty_items.
> 
> By doin so we'll have access to the util pointer for longer that

s/doin/doing/

ATB,
Ramsay Jones
