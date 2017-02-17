Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652382013A
	for <e@80x24.org>; Fri, 17 Feb 2017 09:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbdBQJz3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 04:55:29 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57084 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933846AbdBQJzL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 04:55:11 -0500
X-AuditID: 1207440d-029ff70000003721-93-58a6c879d8a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 58.4D.14113.978C6A85; Fri, 17 Feb 2017 04:55:06 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF52F.dip0.t-ipconnect.de [79.237.245.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1H9t3sh024141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Feb 2017 04:55:04 -0500
Subject: Re: [PATCH v2 00/19] object_id part 6
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3644df30-71e2-584b-ebed-ae117a5ded3f@alum.mit.edu>
Date:   Fri, 17 Feb 2017 10:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqFt1YlmEwayvhhZdV7qZLH609DBb
        tM38weTA7LH85l8mj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4MromJxdsJmr4u5ltQbG5Rxd
        jJwcEgImEm0bPrJ2MXJxCAnsYJJo3rcByjnPJLH6wnJGkCphAT2JjmMzmUBsEQEvifmPZrCC
        2EICThJf/v9mB7GZBWQl1q/4C1bPJqArsainGaieg4NXwF7i//IIkDCLgKrEknOfwFpFBUIk
        5ix8AFbOKyAocXLmExYQm1PAWWJRwwNWiJF6Ejuu/4Ky5SW2v53DPIGRfxaSlllIymYhKVvA
        yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyQ8eXcw/l8nc4hRgINRiYc3
        Y/vSCCHWxLLiytxDjJIcTEqivIumLYsQ4kvKT6nMSCzOiC8qzUktPsQowcGsJMLrchQox5uS
        WFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4OU5BtQoWJSanlqRlplTgpBm
        4uAEGc4DNHz6cZDhxQWJucWZ6RD5U4yKUuK8U0GaBUASGaV5cL2w9PGKURzoFWFeJZB2HmDq
        get+BTSYCWhwZ8RSkMEliQgpqQbGmsKkS/eSGzeK/e31Sn9inJJX++tr46Q3St4mu1gbzK5m
        ro3I++65uOKbQk9P+5ZzAUovOlc+FdMK+CayzKizMG/5wiPHvlbLiEarRQlt9Yp/J8B/9KDk
        lBuLXl98xsm74Yp99Ea7CtWt50NvLedy3Fux1snZY8/ma84SqdF+nvOfLyi8tmCNEktxRqKh
        FnNRcSIAY3KNjvoCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 03:31 AM, brian m. carlson wrote:
> This is another series in the continuing conversion to struct object_id.
> 
> This series converts more of the builtin directory and some of the refs
> code to use struct object_id. Additionally, it implements an
> nth_packed_object_oid function which provides a struct object_id version
> of the nth_packed_object function, and a parse_oid_hex function that
> makes parsing easier.
> 
> The patch to use parse_oid_hex in the refs code has been split out into
> its own patch, just because I'm wary of that code and potentially
> breaking things, and I want it to be easy to revert in case things go
> wrong.  I have no reason to believe it is anything other than fully
> functional, however.
> 
> Changes from v1:
> * Implement parse_oid_hex and use it.
> * Make nth_packed_object_oid take a variable into which to store the
>   object ID.  This avoids concerns about unsafe casts.
> * Rebase on master.

Thanks as always for working on this!

I skimmed over the patches (looking more carefully at the refs-related
ones) and left a few minor comments but didn't find anything serious.

I'm curious; what fraction of the overall convert-to-object_id campaign
do you estimate is done so far? Are you getting close to the promised
land yet?

Michael

