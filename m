Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBE11F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdHLIE3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:04:29 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:56321 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdHLIE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 04:04:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xTvXn6hdMz5tlG;
        Sat, 12 Aug 2017 10:04:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 31B0F2079;
        Sat, 12 Aug 2017 10:04:25 +0200 (CEST)
Subject: Re: [PATCH] tree-walk: convert fill_tree_descriptor() to object_id
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <d1e4b270-4f8b-85e4-b6fd-09657720bed2@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fb99b685-327a-1c01-52d6-f0a1d106544c@kdbg.org>
Date:   Sat, 12 Aug 2017 10:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d1e4b270-4f8b-85e4-b6fd-09657720bed2@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.2017 um 09:14 schrieb René Scharfe:
> -	Initialize a `tree_desc` and decode its first entry given the sha1 of
> -	a tree. Returns the `buffer` member if the sha1 is a valid tree
> -	identifier and NULL otherwise.
> +	Initialize a `tree_desc` and decode its first entry given the
> +	object ID of a tree. Returns the `buffer` member if the sha1 is
> +	a valid tree identifier and NULL otherwise.

There is another mention of "sha1" in the rewritten text. Intended or an 
oversight?

> -#define ENTRY_SHA1(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid->hash : NULL)
> -	buf0 = fill_tree_descriptor(t+0, ENTRY_SHA1(n + 0));
> -	buf1 = fill_tree_descriptor(t+1, ENTRY_SHA1(n + 1));
> -	buf2 = fill_tree_descriptor(t+2, ENTRY_SHA1(n + 2));
> +#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid : NULL)
> +	buf0 = fill_tree_descriptor(t + 0, ENTRY_OID(n + 0));
> +	buf1 = fill_tree_descriptor(t + 1, ENTRY_OID(n + 1));
> +	buf2 = fill_tree_descriptor(t + 2, ENTRY_OID(n + 2));
>   #undef ENTRY_SHA1

This whould be #undef ENTRY_OID.

-- Hannes
