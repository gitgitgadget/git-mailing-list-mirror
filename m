Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6FB20281
	for <e@80x24.org>; Wed, 20 Sep 2017 07:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdITHAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 03:00:53 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56039 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751341AbdITHAw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Sep 2017 03:00:52 -0400
X-AuditID: 1207440e-be1ff70000007085-f2-59c212237398
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.DF.28805.32212C95; Wed, 20 Sep 2017 03:00:51 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD8C.dip0.t-ipconnect.de [87.188.205.140])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8K70nBW012727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 20 Sep 2017 03:00:50 -0400
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior
 for empty list
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <20170920023008.GB126984@aiede.mtv.corp.google.com>
 <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
 <20170920052705.GC126984@aiede.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <124b960d-a863-18ef-54a2-b170036dfca2@alum.mit.edu>
Date:   Wed, 20 Sep 2017 09:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170920052705.GC126984@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1FUWOhRpsOuoqkXXlW4mi4beK8wW
        b28uYbRov3KUxeJ/2zs2B1aPnbPusntcvKTs8XmTXABzFJdNSmpOZllqkb5dAlfG+fPN7AXL
        uSs+nZnM3sB4jqOLkZNDQsBEYvXcf6xdjFwcQgI7mCSWznjPBOFcYJKYvrmRrYuRg0NYIEai
        ZYMASIOIgI/EvW9dzCBhZoFSiTM/IiDKpzJL3OvvZQSpYRPQlVjU08wEYvMK2EssXfCTBcRm
        EVCV+LRyLiuILSoQIdH39jI7RI2gxMmZT8BqOAUcJPb+vw1mMwuoS/yZd4kZwhaXuPVkPhOE
        LS+x/e0c5gmMArOQtM9C0jILScssJC0LGFlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+Vm
        luilppRuYoQEOd8Oxvb1MocYBTgYlXh4A6wORgqxJpYVV+YeYpTkYFIS5b3CfyhSiC8pP6Uy
        I7E4I76oNCe1+BCjBAezkghvKS9QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
        JivDwaEkwdstCNQoWJSanlqRlplTgpBm4uAEGc4DNPylAMjw4oLE3OLMdIj8KUZFKXHeRJBm
        AZBERmkeXC8sCb1iFAd6RZiXGaSKB5jA4LpfAQ1mAhqcveEAyOCSRISUVAPj3GYrP5tVJ8VV
        pl87XJgZsi41n82h/fZ8yVyb1zz3/ufJ37uV8v7atXfKgatvrMktnGfzYpXAi701jF9nr936
        sVN/S5dVycZXMbdtk96+aXku1TCbh9e44IfVc4v+OaJnHkr+XRvB1tciVf958+OzUXIHQ85N
        eigcVbXKe/42vbnvqxZ9dt5vr8RSnJFoqMVcVJwIAOkgWSUdAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 07:27 AM, Jonathan Nieder wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> If you pass a newly initialized or newly cleared `string_list` to
> `for_each_string_list_item()`, then the latter does
> 
>     for (
>             item = (list)->items; /* NULL */
>             item < (list)->items + (list)->nr; /* NULL + 0 */
>             ++item)
> 
> Even though this probably works almost everywhere, it is undefined
> behavior, and it could plausibly cause highly-optimizing compilers to
> misbehave.  C99 section 6.5.6 paragraph 8 explains:
> 
>     If both the pointer operand and the result point to elements
>     of the same array object, or one past the last element of the
>     array object, the evaluation shall not produce an overflow;
>     otherwise, the behavior is undefined.
> 
> and (6.3.2.3.3) a null pointer does not point to anything.
> 
> Guard the loop with a NULL check to make the intent crystal clear to
> even the most pedantic compiler.  A suitably clever compiler could let
> the NULL check only run in the first iteration, but regardless, this
> overhead is likely to be dwarfed by the work to be done on each item.
> 
> This problem was noticed by Coverity.
> 
> [jn: using a NULL check instead of a placeholder empty list;
>  fleshed out the commit message based on mailing list discussion]

Thanks for taking this over. This version LGTM.

> [...]
Michael
