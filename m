Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD7C2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 15:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdIHPIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 11:08:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61212 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750842AbdIHPIX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 11:08:23 -0400
X-AuditID: 1207440e-be1ff70000007085-73-59b2b26437b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 41.36.28805.462B2B95; Fri,  8 Sep 2017 11:08:20 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88F8HKQ007191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 11:08:19 -0400
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
References: <20170904200504.15249-1-t.gummerer@gmail.com>
 <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
 <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
 <xmqqvaku10gj.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ab0c4064-6eaa-c298-a26d-58fc83e4574f@alum.mit.edu>
Date:   Fri, 8 Sep 2017 17:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqvaku10gj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1E3ZtCnSYN0dWYuuK91MFg29V5gt
        7kxrZLe4sPo2uwOLx+QJV9k9ds66y+5x8ZKyx+dNcgEsUVw2Kak5mWWpRfp2CVwZJ6efYyyY
        KlUx62A3WwPjTZEuRk4OCQETiY3tH1i7GLk4hAR2MElsO36FBcI5zyRx9PFzZpAqYQEniQ1P
        P7OD2CICahIT2w6BFTELzGKUeHhvLRNExyNGiS/zGsGq2AR0JRb1NDOB2LwC9hLHP+0Es1kE
        VCSaXrxiA7FFBSIk+t5eZoeoEZQ4OfMJC4jNKWAtMev6M7AaZgF1iT/zLjFD2OISt57MZ4Kw
        5SWat85mnsAIdAJC+ywkLbOQtMxC0rKAkWUVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5m
        iV5qSukmRkio8+1gbF8vc4hRgINRiYfXInhjpBBrYllxZe4hRkkOJiVRXpmeTZFCfEn5KZUZ
        icUZ8UWlOanFhxglOJiVRHhnbATK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
        ZGU4OJQkeKeDNAoWpaanVqRl5pQgpJk4OEGG8wAN9wUbXlyQmFucmQ6RP8WoKCXOKwGSEABJ
        ZJTmwfXCUtErRnGgV4R5OUGqeIBpDK77FdBgJqDBJc83gAwuSURISTUwFk4rTowKXyDi8VQt
        8JWipaaE2tdwxy2h7nwmq5g1E31MH/7uyoy/fifmyhy+0odalfrVDWEFc2Umcv5YV/542aaP
        biZ5c1KmiU74dTLA40EFA/PFilyP5CO7vy54Wmimc0ub/0rM4223T106Pe/Am98c+7tLrU3Y
        5DMCpKZ6n9vXeVks1jhEiaU4I9FQi7moOBEAfUI2+yADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 02:46 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I did just realize one thing: `ref_transaction_update()` takes `flags`
>> as an argument and alters it using
>>
>>>         flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
>>
>> Perhaps gcc is *more* intelligent than we give it credit for, and is
>> actually worried that the `flags` argument passed in by the caller
>> might *already* have one of these bits set. In that case
>> `ref_transaction_add_update()` would indeed be called incorrectly.
>> Does the warning go away if you change that line to
>>
>>>         if (new_sha1)
>>>                 flags |=REF_HAVE_NEW;
>>>         else
>>>                 flags &= ~REF_HAVE_NEW;
>>>         if (old_sha1)
>>>                 flags |=REF_HAVE_OLD;
>>>         else
>>>                 flags &= ~REF_HAVE_OLD;
>>
>> ? This might be a nice change to have anyway, to isolate
>> `ref_transaction_update()` from mistakes by its callers.
> 
> I understand "drop HAVE_NEW bit if new_sha1 is NULL" part, but not
> the other side "add HAVE_NEW if new_SHA1 is not NULL"---doesn't the
> NEW/OLD flag exist exactly because some callers pass the address of
> an embedded oid.hash[] or null_sha1, instead of NULL, when one side 
> does not exist?  So new|old being NULL is a definite signal that we
> need to drop HAVE_NEW|OLD, but the reverse may not be true, no?  Is
> it OK to overwrite null_sha1[] that is passed from some codepaths?
> 
> ref_transaction_create and _delete pass null_sha1 on the missing
> side, while ref_transaction_verify passes NULL, while calling
> _update().  Should this distinction affect how _add_update() gets
> called?

There are two functions under discussion:

* `ref_transaction_add_update()` is the low-level, private function that
uses the `HAVE_{NEW,OLD}` bits to decide what to do.

* `ref_transaction_update()` (like
`ref_transaction_{create,delete,verify}()`) are public functions that
ignore the `HAVE_{NEW,OLD}` bits and base their behavior on whether
`new_sha1` and `old_sha1` are NULL.

Each of these functions has to support three possibilities for its SHA-1
arguments:

1. The SHA-1 is provided and not `null_sha1`—in this case it must match
the old value (if `old_sha1`) or it is the value to be set as the new
value (if `new_sha1`).

2. The SHA-1 is provided and is equal to `null_sha1`—in this case the
reference must not already exist (if `old_sha1` is `null_sha1`) or it
will be deleted (if `new_sha1` is `null_sha1`).

3. The SHA-1 is not provided at all—in this case the old value is
ignored (if `old_sha1` is not provided) or the reference is left
unchanged (if `new_sha1` is not provided).

Much of the current confusion stems because
`ref_transaction_add_update()` encodes the third condition using the
`REF_HAVE_*` bits, whereas `ref_transaction_update()` and its friends
encode the third condition by setting `old_sha1` or `new_sha1` to `NULL`.

So `ref_transaction_update()` *does* need to set or clear the `HAVE_NEW`
and `HAVE_OLD` bits as I sketched, to impedance-match between the two
conventions.

It's a shame how much time we've wasted discussing this. Maybe the code
is trying to be too clever/efficient and needs a rethink.

Michael
