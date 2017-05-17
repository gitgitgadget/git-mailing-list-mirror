Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B011201A7
	for <e@80x24.org>; Wed, 17 May 2017 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbdEQPBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 11:01:48 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50191 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751398AbdEQPBr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 11:01:47 -0400
X-AuditID: 12074411-cc7ff70000003efd-de-591c65d8afb7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BB.23.16125.8D56C195; Wed, 17 May 2017 11:01:44 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HF1fa0009968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 11:01:42 -0400
Subject: Re: [PATCH 07/23] ref_store: take `logmsg` parameter when deleting
 references
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <b26ccc03a7e72dfa30467db81e9210dd621516e2.1495014840.git.mhagger@alum.mit.edu>
 <20170517131204.m564xy7i3ywietsl@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4632308e-3f75-0d18-d0f8-c94af0d852c6@alum.mit.edu>
Date:   Wed, 17 May 2017 17:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517131204.m564xy7i3ywietsl@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1L2RKhNpcPqVlsXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujEf9u5kKZvJWHJz3nLGB8StnFyMnh4SAicSvSROYuhi5OIQE
        djBJ7NixjAXCOccksfbQKVaQKmGBCIneefPYQWwRAVmJ74c3MkIUHWKU+PzjIFiCWWATk8TW
        s/YgNpuArsSinmYmEJtXwF5izf8PYDUsAqoSZx80sIDYokBDH3buYoeoEZQ4OfMJWJxTwEVi
        zt3DzBAz1SX+zLsEZctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFy
        Yl5eapGuqV5uZoleakrpJkZIoAvuYJxxUu4QowAHoxIPb0SATKQQa2JZcWXuIUZJDiYlUd79
        D6QjhfiS8lMqMxKLM+KLSnNSi4Fe52BWEuHNiQMq501JrKxKLcqHSUlzsCiJ8/ItUfcTEkhP
        LEnNTk0tSC2CycpwcChJ8F5IAWoULEpNT61Iy8wpQUgzcXCCDOcBGs6RCjK8uCAxtzgzHSJ/
        ilFRSpx3KUizAEgiozQPrheWiF4xigO9IsybC1LFA0xicN2vgAYzAQ1uBvmIt7gkESEl1cC4
        cY3ro8CdGcbqfsaZvE1t+6PD8qYH/uLK3tReZxY6adER82XHFjYWNzYcPz03mX/doikfZyxX
        8je8U/t5fbP5tHexDx3F+FcvPF/tznC6iL2i8s77Gbq5WrGn3+3MNQvyfJgy9SGT1N6/f7oc
        GkquFz6dsfP+ob/nGnrvtnA9qb6xaF95r0ahEktxRqKhFnNRcSIAYiXLSx8DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:12 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:30PM +0200, Michael Haggerty wrote:
> 
>> Just because the files backend can't retain reflogs for deleted
>> references is no reason that they shouldn't be supported by the
>> virtual method interface. Let's add them now before the interface
>> becomes truly polymorphic and increases the work.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/fetch.c                |  2 +-
>>  builtin/remote.c               |  4 ++--
>>  refs.c                         | 11 ++++++-----
>>  refs.h                         | 12 +++++++-----
>>  refs/files-backend.c           |  4 ++--
>>  refs/refs-internal.h           |  2 +-
>>  t/helper/test-ref-store.c      |  3 ++-
>>  t/t1405-main-ref-store.sh      |  2 +-
>>  t/t1406-submodule-ref-store.sh |  2 +-
>>  9 files changed, 23 insertions(+), 19 deletions(-)
> 
> Having carried a similar patch in GitHub's fork for many years (because
> we maintain an audit log of all ref updates), I expected this to be
> bigger. But I forgot that we did 755b49ae9 (delete_ref: accept a reflog
> message argument, 2017-02-20) a few months ago, which already hit most
> of the ref-deleting callers. This is just making the plural
> delete_refs() interface match.
> 
> I think your reasoning above is sound by itself, but that gives an added
> interface: we are making the delete_ref() and delete_refs() interfaces
> consistent.

I think you meant s/interface/justification/, in which case I agree with
you and I'll mention it in v2. I also noticed that the parameters are
named inconsistently. I'll fix that too.

Michael

