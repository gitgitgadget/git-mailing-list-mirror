Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD9B1F859
	for <e@80x24.org>; Mon,  5 Sep 2016 03:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbcIEDyX (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 23:54:23 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48818 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752461AbcIEDyX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 23:54:23 -0400
X-AuditID: 1207440c-217ff700000008d5-02-57ccec4e3050
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 6E.74.02261.E4CECC75; Sun,  4 Sep 2016 23:53:52 -0400 (EDT)
Received: from [192.168.69.190] (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u853rkpU026816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 23:53:48 -0400
Subject: Re: [PATCH v2 05/38] refs: create a base class "ref_store" for
 files_ref_store
To:     David Turner <novalis@novalis.org>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
 <39277c75122a374b360057d6e1f6d889a90f6fb4.1473003902.git.mhagger@alum.mit.edu>
 <1473021637.6035.27.camel@frank>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c6ae77bf-e2e2-c108-648d-75b5164b7ba2@alum.mit.edu>
Date:   Mon, 5 Sep 2016 05:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473021637.6035.27.camel@frank>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqBvw5ky4we8n7BZdV7qZLBp6rzBb
        LHn4mtmie8pbRosfLT3MFjOvWlts3tzOYnHmTSOjA4fHzll32T0WbCr16Go/wubxrHcPo8fF
        S8oe+5duY/NY/MDL4/MmuQCOKC6blNSczLLUIn27BK6MR53b2At2s1d8fbqUvYHxN2sXIyeH
        hICJxJX5J5hBbCGBrYwSTS+kuhi5gOzzTBKzbzaygySEBSIlJt/6AFYkIqAmseztLzaIotWM
        Eid/TAZzmAV2MkncvLsarINNQFdiUU8zE4jNK2AvseX/c5YuRg4OFgEViTeTFUDCogIhEu3L
        1kOVCEqcnPmEBcTmBGo9cOYlI4jNLKAu8WfeJWYIW15i+9s5zBMY+WchaZmFpGwWkrIFjMyr
        GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUIigGcH47d1MocYBTgYlXh4LbTP
        hAuxJpYVV+YeYpTkYFIS5Z118GS4EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeeS+AynlTEiur
        UovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKEryVr4EaBYtS01Mr0jJzShDSTByc
        IMN5gIbrg9TwFhck5hZnpkPkTzHqciz4cXstkxBLXn5eqpQ4b+0roCIBkKKM0jy4ObDE9YpR
        HOgtYd6pIFU8wKQHN+kV0BImoCXrdp8GWVKSiJCSamBUM1t5SvmUY1rXzqrlZy2Zrs0+MyHh
        XEmI8WWF06eEZzIGdH+cX3JL8bTJwSdHppcb6cZ116+Lig2Q/f+t3vb0RacO11blQ8qStZ1T
        n/sdfXZfJDc69UtTXoM1e1604nd7pc62Rcq/bH9UcvhIXOPeE5o+9aJX6jTR/MIt/JHbr9x5
        NkNjYrISS3FGoqEWc1FxIgB6j8+aNwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/2016 10:40 PM, David Turner wrote:
> On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:
> 
>> +/* A linked list of ref_stores for submodules: */
>> +static struct ref_store *submodule_ref_stores;
> 
> I don't like the per-submodule stores being in a linked list, which
> requires a linear search.  Stefan has, I think, been doing a bunch of
> work to scale git to support on the order of thousands of submodules,
> which this potentially breaks.  What about a hashmap?

I agree it's not ideal, but this linked list is not new. Before this
patch the same code was in `files-backend.c`, and before patch [03/38]
essentially the same linked list was stored as `submodule_ref_caches`.
So this is not a regression, and I'd rather not address it in this patch
series.

CC Stefan in case he'd like to put it on his radar. Honestly, I've never
checked how often the submodule reference cache is used in real life.

Michael

