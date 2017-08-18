Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8049C208D0
	for <e@80x24.org>; Fri, 18 Aug 2017 09:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdHRJYY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 05:24:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57857 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750923AbdHRJYV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Aug 2017 05:24:21 -0400
X-AuditID: 12074412-0c7ff70000000b4e-4f-5996b244eae7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 89.39.02894.442B6995; Fri, 18 Aug 2017 05:24:20 -0400 (EDT)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7I9OJqp018854
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 05:24:20 -0400
Received: by mail-io0-f174.google.com with SMTP id o9so31379907iod.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 02:24:19 -0700 (PDT)
X-Gm-Message-State: AHYfb5hisjPOfKu8bEZDMNjOXRvQbB2Ezsh1PKNEvia/ODqhNFvkBtLp
        jox/Bi7o32uj23vUEl0uMRFsctJ34Q==
X-Received: by 10.107.187.135 with SMTP id l129mr7225805iof.122.1503048259385;
 Fri, 18 Aug 2017 02:24:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Fri, 18 Aug 2017 02:24:18 -0700 (PDT)
In-Reply-To: <CAJo=hJum2boTfcXOaZVhxmbGB9Dygoc5=TM8RD2nqxo-Ahjv9g@mail.gmail.com>
References: <CAJo=hJum2boTfcXOaZVhxmbGB9Dygoc5=TM8RD2nqxo-Ahjv9g@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 18 Aug 2017 11:24:18 +0200
X-Gmail-Original-Message-ID: <CAMy9T_EKLs7vDyRi=jNH47fuCaKcxSvcpK27mKB-7P2EtdBeoQ@mail.gmail.com>
Message-ID: <CAMy9T_EKLs7vDyRi=jNH47fuCaKcxSvcpK27mKB-7P2EtdBeoQ@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1HXZNC3S4PFRaYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGVc/zyfsWC7QMWta/wNjK28XYycHBICJhLT/79j7WLk4hAS2MEk
        cah1ATNIQkjgKZPEp/MKEIk+Rok9i74zdjFyAHXkSzQ+C4QwyyRO/4oGKecVEJQ4OfMJC0Sr
        nMSrDTcYIWxviSPzZrCB2JwCgRLNTz6xgbQKCQRI/GzwAAmzCehKLOppZgKxWQRUJfa+m84I
        cVqiRO+xU+wQ4wMkWmbvA7tMWMBI4vCk/2A1IgJqEtsv9ICdzyxwiFHi7ZN5YEXMApoSrdt/
        s09gFJ6F5LxZSFILGJlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoSEr9AO
        xvUn5Q4xCnAwKvHwCiybGinEmlhWXJl7iFGSg0lJlPf3rCmRQnxJ+SmVGYnFGfFFpTmpxUDn
        cDArifC+2TAtUog3JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYJ3HUij
        YFFqempFWmZOCUKaiYMTZDgP0PAzYMOLCxJzizPTIfKnGI05rlxZ94WJY8qB7V+YhFjy8vNS
        pcR554CUCoCUZpTmwU2DpaBXjOJAzwnzGm8EquIBpi+4ea+AVjEBrTJsBVtVkoiQkmpg1H/7
        eeGBNCOPd42vdpteTN809fnWrpiyC/X7PdImu33oi2Xzlv7+eutWnxkJiWcitDKCCqLVvW+Y
        fdNfYRIuLc7Xm5r068MTjnDDH093L/fd8+zc6kY7rYu3m1Ts5t5Y8st25tbF84oXLv1n2KJe
        sKyIwftXzoXbTlP618wIk+HOdnxyYq9AgRJLcUaioRZzUXEiAITbFx8cAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 12:47 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Aug 14, 2017 at 5:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/07/2017 03:47 AM, Shawn Pearce wrote:
>>> 6th iteration of the reftable storage format.
> [...]
>>> #### index record
>>>
>>> An index record describes the last entry in another block.
>>> Index records are written as:
>>>
>>>     varint( prefix_length )
>>>     varint( (suffix_length << 3) | 0 )
>>>     suffix
>>>     varint( block_position )
>>>
>>> Index records use prefix compression exactly like `ref_record`.
>>>
>>> Index records store `block_position` after the suffix, specifying the
>>> absolute position in bytes (from the start of the file) of the block
>>> that ends with this reference.
>>
>> Is there a reason that the index lists the *last* refname that is
>> contained in a block rather than the *first* refname? I can't think of a
>> reason to choose one vs. the other, but your choice was initially
>> surprising. I don't think it matters either way; I was just curious.
>
> Yes, there is a reason. When a reader is searching the index block and
> discovers a key that is greater than their search needle, they are now
> sitting on a record with the block_position for that greater key. By
> using the *last* refname the current block_position is the one to seek
> to.
>
> If instead we used *first* refname, the reader would now have to
> backtrack to the prior index record to get the block_position out of
> that record. Or it has to keep a running "prior_position" local
> variable.
>
> Using last simplifies the reader's code.

Ah, OK. I was thinking of this as being a binary search, in which case
you *must* see both bracketing records before you are done, and the
chances are 50-50 which one you see first. But this search is a little
bit different, because the index records within a restart block have
to be scanned linearly. So it is much more likely that you see the
"before" record followed by the "after" record.

Thanks for the explanation.

Michael
