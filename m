Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4D71FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 07:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbcLaH6t (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 02:58:49 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56980 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752580AbcLaH6s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 31 Dec 2016 02:58:48 -0500
X-AuditID: 1207440d-8b7ff700000009ba-1c-58676535342c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CC.63.02490.53567685; Sat, 31 Dec 2016 02:58:47 -0500 (EST)
Received: from [192.168.69.190] (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV7whRk022312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 31 Dec 2016 02:58:44 -0500
Subject: Re: [PATCH v3 13/23] log_ref_setup(): pass the open file descriptor
 back to the caller
To:     Jeff King <peff@peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
 <20161231063211.tqsiafg3iahcuotz@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f5ced16d-61dc-ba14-7f29-88f20d4a65d2@alum.mit.edu>
Date:   Sat, 31 Dec 2016 08:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161231063211.tqsiafg3iahcuotz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqGuemh5h8HK7rEXXlW4mi4beK8wW
        Sx6+Zrb40dLD7MDi0dV+hM3jWe8eRo+Ll5Q9Pm+SC2CJ4rJJSc3JLEst0rdL4MpYeIS94J1I
        xd9Ll1kbGOcKdDFyckgImEh0bpnKCmILCVxmlDj/ULmLkQvIPssk0Xv+PAtIQlggUWLZ+x/M
        ILaIgKzE98MbGSGKDjFKrPm4mgkkwSyQIdFz5zfYJDYBXYlFPc1AcQ4OXgF7iTdTjUDCLAKq
        ElMmfAUrFxUIkbg85ygbiM0rIChxcuYTsF2cAi4Sp9a3sEKMVJf4M+8SM4QtL7H97RzmCYz8
        s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYISHLu4Px
        /zqZQ4wCHIxKPLwPbqRFCLEmlhVX5h5ilORgUhLltbRMjRDiS8pPqcxILM6ILyrNSS0G+pyD
        WUmENzohPUKINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBG5sC1ChY
        lJqeWpGWmVOCkGbi4AQZzgM0PAukhre4IDG3ODMdIn+KUVFKnFcHJCEAksgozYPrhaWUV4zi
        QK8I89qAVPEA0xFc9yugwUxAg7/GgQ0uSURISTUwuv3zzaqoSjt/XUrFNlQ4+lqLr+ByjaPS
        r6P+iIVOZN1ffzP2bN37z/01+5cu07y06PiKWT635v4pizdzXTHNSe6J+kGO0ENbN6+Zp/dC
        bzqn+YoQyabHr6/wbjBQXtaYu1LNRP3h/whW66pnm/IvdB+dftxo7ZFVrV1W0tJff4bpT7n7
        a/VKByWW4oxEQy3mouJEAHbYhdsEAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2016 07:32 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 04:12:53AM +0100, Michael Haggerty wrote:
> 
>> This function will most often be called by log_ref_write_1(), which
>> wants to append to the reflog file. In that case, it is silly to close
>> the file only for the caller to reopen it immediately. So, in the case
>> that the file was opened, pass the open file descriptor back to the
>> caller.
> 
> Sounds like a much saner interface.
> 
>>  /*
>> - * Create a reflog for a ref.  If force_create = 0, the reflog will
>> - * only be created for certain refs (those for which
>> - * should_autocreate_reflog returns non-zero.  Otherwise, create it
>> - * regardless of the ref name.  Fill in *err and return -1 on failure.
>> + * Create a reflog for a ref. Store its path to *logfile. If
>> + * force_create = 0, only create the reflog for certain refs (those
>> + * for which should_autocreate_reflog returns non-zero). Otherwise,
>> + * create it regardless of the reference name. If the logfile already
>> + * existed or was created, return 0 and set *logfd to the file
>> + * descriptor opened for appending to the file. If no logfile exists
>> + * and we decided not to create one, return 0 and set *logfd to -1. On
>> + * failure, fill in *err, set *logfd to -1, and return -1.
>>   */
>> -static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
>> +static int log_ref_setup(const char *refname,
>> +			 struct strbuf *logfile, int *logfd,
>> +			 struct strbuf *err, int force_create)
> 
> The return value is always "0" or "-1". It seems like it would be
> simpler to just return the descriptor instead of 0.
> 
> I guess that makes it hard to identify the case when we chose not to
> create a descriptor. I wonder if more "normal" semantics would be:
> 
>   1. ret >= 0: file existed or was created, and ret is the descriptor
> 
>   2. ret < 0, err is empty: we chose not to create
> 
>   3. ret < 0, err is non-empty: a real error

I don't like making callers read err to find out whether the call was
successful, and I think we've been able to avoid that pattern so far.

Another alternative would be to make ret == -1 mean a real error and ret
== -2 mean that we chose not to create the file. But that would be
straying from the usual "-1 means error" interface of open(), so I
wasn't fond of that idea either.

> I dunno. This may just be bikeshedding, and I can live with it either
> way (especially because you documented it!).

Let's see if anybody has a strong opinion about it; otherwise I'd rather
leave it as is.

Michael

