Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044DA201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdBTMj1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:39:27 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49885 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751893AbdBTMj0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 07:39:26 -0500
X-AuditID: 12074411-4d7ff700000005a9-55-58aae34427ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BB.72.01449.443EAA85; Mon, 20 Feb 2017 07:38:29 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KCcQQt029360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 07:38:27 -0500
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from
 files_downcast()
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com>
 <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
 <CACsJy8AZ27O-pxTqHOzYXRBuyv8dkxdGJ_5Z0u3eaxkNdnaEYA@mail.gmail.com>
 <c4265faf-a04a-552b-fd72-1631a220f788@alum.mit.edu>
 <CACsJy8ChAwwPawTrq4gqZqAO3k6PrgzzvceVFjbJmxkE0Rn8SQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ded1a8c2-1792-b755-9ce3-923762c29d62@alum.mit.edu>
Date:   Mon, 20 Feb 2017 13:38:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ChAwwPawTrq4gqZqAO3k6PrgzzvceVFjbJmxkE0Rn8SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqOv6eFWEwe0GFYuuK91MFg29V5gt
        +pd3sVksefia2aJ7yltGi5lXrS02b25ncWD32DnrLrvHh49xHgs2lXp0tR9h87h4Sdlj/9Jt
        bB6fN8kFsEdx2aSk5mSWpRbp2yVwZRz8+J+x4D53xbfbe1gaGA9wdjFyckgImEjs39XD0sXI
        xSEksINJYlb/HijnPJPE+8bVLCBVwgKxEsd7rrCD2CICShJvOrYxQxR1MkvM7TrKDuIwC8xi
        kri4dxEbSBWbgK7Eop5mJhCbV8Be4vONBawgNouAqsSHzROYQWxRgRCJOQsfMELUCEqcnPkE
        bBunQKDEqTlXwGxmAXWJP/MuMUPY8hLb385hnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qrm5uY
        mVOcmqxbnJyYl5dapGuql5tZopeaUrqJERLwgjsYZ5yUO8QowMGoxMOrMXNlhBBrYllxZe4h
        RkkOJiVR3jtLVkUI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF9cxkox5uSWFmVWpQPk5LmYFES
        5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4H3+EKhRsCg1PbUiLTOnBCHNxMEJMpwHaLj5I5Dh
        xQWJucWZ6RD5U4yKUuK8T0CaBUASGaV5cL2whPSKURzoFWHeSyBVPMBkBtf9CmgwE9Dgmx4r
        QQaXJCKkpBoYvV7cYxGSS33Vcuj75V8pLq36R4v2uE5IMln4+cm5045G5vO6+N699fTVefTv
        /t4joWoOuwOfdRzpfZXjetFkybZNHJXNy0TrvQ2jTXPuGSrvd9U9IKX030Zw9qYHlZML3ZaL
        su52mPiIfV1oT+mJwGevt9/q31//7GbftqwTm2rKzti3GKRMVWIpzkg01GIuKk4EAP9ipTkj
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20/2017 01:33 PM, Duy Nguyen wrote:
> On Mon, Feb 20, 2017 at 7:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 02/20/2017 01:21 PM, Duy Nguyen wrote:
>>> On Mon, Feb 20, 2017 at 7:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> [...]
>>>> These limitations, I think, imply that submodule references have to be
>>>> treated as read-only.
>>>
>>> Behind the scene submodule does add_submodule_odb(), which basically
>>> makes the submodule's odb an alternate of in-core odb. So odb access
>>> works. I was puzzled how submodules could by pass odb access at the
>>> beginning only to find that out. technical/api-ref-iteration.txt also
>>> mentions that you need to add_submodule_odb(), so I think it's
>>> deliberate (albeit hacky) design.
>>
>> That's interesting. I didn't know it before.
>>
>> But I still don't think that means that reference writing can work
>> correctly. If I try to set a submodule branch to an SHA-1 and I verify
>> that the SHA-1 points to a valid commit, how do I know that the commit
>> is in the same submodule that holds the reference?
> 
> Good point. So will the new flag be "read_only" (no reference to
> submodule), or "submodule"? This flag will be passed in at ref-store
> init time and kept in files_ref_store.

I haven't checked carefully whether there are other operations that
don't work and/or don't make sense for submodules. If not, then
`read_only` would also be a fine name for the flag.

Michael

