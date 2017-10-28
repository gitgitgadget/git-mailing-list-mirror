Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE6520562
	for <e@80x24.org>; Sat, 28 Oct 2017 04:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdJ1ELu (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 00:11:50 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60711 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbdJ1ELt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 00:11:49 -0400
X-AuditID: 12074411-f7dff70000007f0a-21-59f403844ea3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D0.09.32522.48304F95; Sat, 28 Oct 2017 00:11:48 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S4Bj7b001357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 00:11:47 -0400
Subject: Re: [PATCH 0/2] Avoid rewriting "packed-refs" unnecessarily
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
References: <cover.1508924577.git.mhagger@alum.mit.edu>
 <CAPig+cSrjiyGUm0n5dvowjNYZMSGvb+SZJ=haTsxXi9NcThA7A@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <48b59e2b-61f8-c43a-63a7-d0fb32c9b4b7@alum.mit.edu>
Date:   Sat, 28 Oct 2017 06:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSrjiyGUm0n5dvowjNYZMSGvb+SZJ=haTsxXi9NcThA7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqNvC/CXSoP2ekkXXlW4mi4beK8wW
        P1p6mC3OvGlkdGDxeNa7h9Hj4iVlj8UPvDw+b5ILYInisklJzcksSy3St0vgyvh4fhdzwSeO
        ioaW1UwNjAvYuxg5OSQETCRmdzQzdjFycQgJ7GCS+Lf2DDOEc4FJov3UJCaQKmEBF4mVE4+z
        gdgiAtoSHzZsYgSxmQWyJN7/mQ9mCwnUSdw9N4kVxGYT0JVY1NMM1MvBwStgL7F7pghImEVA
        VeL9zcdgYVGBCIkNG/lBwrwCghInZz5hAbE5BQIl3j7/wA4xXV3iz7xLzBC2uMStJ/OZIGx5
        ie1v5zBPYBSYhaR9FpKWWUhaZiFpWcDIsopRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NE
        LzWldBMjJMAFdzDOOCl3iFGAg1GJh1ci93OkEGtiWXFl7iFGSQ4mJVHefec/RQrxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4Z3N+CVSiDclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUI
        JivDwaEkwRvHBNQoWJSanlqRlplTgpBm4uAEGc4DNDwPpIa3uCAxtzgzHSJ/itGSY9PNu3+Y
        ODZ8fwAkn8183cAsxJKXn5cqJc77GuQaAZCGjNI8uJmwhPWKURzoRWHeNJCxPMBkBzf1FdBC
        JqCFTaofQBaWJCKkpBoY57+zcE4xCL3ctO2DWZm+V0/Ye/2Xe5ee0fXdsJbP7c50xwPq0fd2
        Vhkavr3ref+RWrXFvZ/Ljv5XU5v4gaVRXYr5otyujksnzxuXrK2Rdmb8x/kkv9jT41mh1tmp
        hYyq505oSSp6TJOM2VS/rlZmd9RL1p0S3VP6CndEX3Q0O7hq2slHdrMclFiKMxINtZiLihMB
        SSsqeDMDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2017 10:10 PM, Eric Sunshine wrote:
> On Wed, Oct 25, 2017 at 5:53 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Since commit dc39e09942 (files_ref_store: use a transaction to update
>> packed refs, 2017-09-08), we've been rewriting the `packed-refs` file
>> unnecessarily when deleting a loose reference that has no packed
>> counterpart. Add some tests demonstrating this problem, then fix it by
>> teaching `files_backend` to see whether any references being deleted
>> have packed versions, and if not, skipping the packed_refs
>> transaction.
>>
>> This is a mild regression since 2.14, which avoided rewriting the
>> `packed-refs` file in these cases [...]
> 
> Should the above information (that this fixes a regression) be
> mentioned in the commit message of at least one of the patches
> (probably 2/2)? Without such context, it may not be clear to someone
> later reading those commit message -- someone who wasn't following
> this email discussion -- that this behavior had been lost and is now
> being restored.

Yes, that's a good idea. I'll send a re-roll with that change.

Michael
