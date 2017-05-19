Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97358201CF
	for <e@80x24.org>; Fri, 19 May 2017 04:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbdESEmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 00:42:36 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49082 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750704AbdESEmg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 May 2017 00:42:36 -0400
X-AuditID: 1207440d-de7ff70000000e33-bf-591e77b8386f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BA.A3.03635.8B77E195; Fri, 19 May 2017 00:42:34 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4J4gSJ5026894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 19 May 2017 00:42:30 -0400
Subject: Re: [PATCH 11/23] files_transaction_cleanup(): new helper function
To:     Stefan Beller <sbeller@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
 <CAGZ79kaRZB=VTe+c-M-qnkQJGQcYb0f-V0OMRuj4o6KAUvZrrA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f1f8e0a1-41cc-1a48-2744-87118e39e182@alum.mit.edu>
Date:   Fri, 19 May 2017 06:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaRZB=VTe+c-M-qnkQJGQcYb0f-V0OMRuj4o6KAUvZrrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqLurXC7S4PwqM4u1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGU3/JzAXHGKpOND5hbWB8SpzFyMnh4SAicTMvW8Zuxi5OIQE
        djBJfLl6hB0kISRwnkni2fREEFtYwFui+WEvG4gtIqAmMXPVbDaoGkaJX6tyQJqZBc4wSfy/
        tp8FJMEmoCuxqKeZCcTmFbCXONP+nhXEZhFQlbj3/xrYZlGBCImHnbvYIWoEJU7OfALWyykQ
        KLGl7RhYDbOAusSfeZegbHmJ7W/nME9g5J+FpGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3W
        LU5OzMtLLdI10svNLNFLTSndxAgJc94djP/XyRxiFOBgVOLhfbBCNlKINbGsuDL3EKMkB5OS
        KO+MALlIIb6k/JTKjMTijPii0pzU4kOMEhzMSiK84mJAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/
        IYH0xJLU7NTUgtQimKwMB4eSBK9aGVCjYFFqempFWmZOCUKaiYMTZDgP0PB0kBre4oLE3OLM
        dIj8KUZdjjn3vr5nEmLJy89LlRLnPVwKVCQAUpRRmgc3B5aeXjGKA70lzHsCZBQPMLXBTXoF
        tIQJaEnzA2mQJSWJCCmpBkY+TcNeS816h12+Jg4Z/KZTvy+cf9J8X6lkZE5p6NxHQTb/+9mv
        rt0y71i02N33Cafe7zgszV5r8fjmbBUtq9nV873kdPg2/mFytsua2r7Qas2ExqlL/Kd1FTOc
        n57+8NL7PufMo7+OK9uU/5JosalJPt2h6Oqz6rxhnrpG4Y/ET6nS+3yn2iqxFGckGmoxFxUn
        AgBHtV++KgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 07:26 PM, Stefan Beller wrote:
> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Extract function from `files_transaction_commit()`. It will soon have
>> another caller.
> 
> This sounds odd to me. Maybe it is missing words?
> of s/function/the functionality to cleanup/

This is basically the same as the standard refactoring step "extract
method", except applied to a function, not a method. I thought these
terms would be standard enough to not need further explanation, but I'll
add some more words.

Michael

