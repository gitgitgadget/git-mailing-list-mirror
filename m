Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169561F424
	for <e@80x24.org>; Mon, 18 Dec 2017 19:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbdLRTSb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 14:18:31 -0500
Received: from mout.web.de ([212.227.15.3]:65431 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935172AbdLRTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 14:18:28 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5Jip-1fDKgT22n9-00zYab; Mon, 18
 Dec 2017 20:18:22 +0100
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
Date:   Mon, 18 Dec 2017 20:18:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171218151043.GA9449@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:N7BNAf4GaOEIHidFv2eMHXMB48yZjvinIoit22/qZO7DPfH+y/p
 TF55nhrPOIyJwVKyE/+F58/pcsfRuliFthxdjXe2qQg0hPLXgSGkaDHLVS/UU0o5wInFI0W
 Ro0bUHzqkABO8V60pvMnFdoOrUvC4lOjKJsZGlDhYdkL/r1LyJ5p6L/OkY3owzhMFBgjDFf
 wxDEAzDTaq15q2udNfAaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qefV3qY5NV8=:31DHe4Y1ydAAHvuc2Zgofm
 6Mh6mFJUrF/ph/xlTOk+OfebKB2uXYPQ/IDanOz2Vb0aq5RWNW8fQpmqeNxfY8dq9Xe5+Mgca
 LSRSmjLkEI0aiOjsDF1uOE/MjvEWsFGdu7evLWVef02tY8IH7ZyFittpaFKO8nfkvAwybOjPi
 EuIGDw2StzHEz9zdp5Dfcw6bGhVSnMBJjlx9a3aPAO4Q2G090rePpOiyF1SWRCHIcY3YIJ91i
 Id/HcyqS1IlKNmTU5UVJukXS7gljsFu/vVXhELcvx3T2P9wTggK0OIzZ8VMjVHGjNUdXXEjHA
 u0z39Tf1LQP8lPU9NH00PYZHjcbkkAv40eolwiPalCAE1+6kKDulUkHWHwsub8Q/We6oxhAWt
 n1dNwLWixD/YtTEfgyL+BhPQqyX1EOnfHd6P2MbNUCMAVzHyorLaQYFnW7hlQCl83SAR/8MJ2
 FZEuqY4gTROTvC6zPXvsyKGDIj/KrTRwY1vFU0elqr0qOns+9T2JZon7SrGJg2/0yA/bUE5lO
 VbO++2zrlvpMvehX7USYnMyhAQBs5f0PX34tWE2hZhFOxE5ECb3OCNIWi1QQ+oEpR1Xi1BVlp
 /E2nW4JjzM2+odXcwXodoVp7VSIBkXwFtoi89t3FFweCJoW8PJV3n0UDLrfVJOatiylS4mSYU
 KUhPkHqI994aSnwVtx/GyEghI9GUjwWn5hTTu9xbs+PgoLcJRZH/yym6MHYUM9vAy2KQrc4Z3
 guyOy0BE55L2t5REipH9kj8kpfNcH/KbNUVzSRdX4bDtyVbrxb13WtPS6dAvNSivnm0LSuqK6
 HIg0FkGxZO+NxiHugAvSO/2SHmOekK7cLAG3NbCzGmq47FeBfc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.12.2017 um 16:10 schrieb Jeff King:
> On Sat, Dec 16, 2017 at 01:12:16PM +0100, René Scharfe wrote:
> 
>> prepare_revision_walk() allows callers to take ownership of the array of
>> pending objects by setting the rev_info flag "leak_pending" and copying
>> the object_array "pending".  They use it to clear commit marks after
>> setup is done.  This interface is brittle enough that it requires
>> extensive comments.
>>
>> Provide an easier way by adding a function that can hand over the array
>> to a caller-supplied output parameter and converting all users of the
>> flag "leak_pending" to call prepare_revision_walk_extended() instead.
> 
> I think this is _better_, but it's still kind of a funny interface.
> 
> The root of the matter is that the revision-walking code doesn't clean
> up after itself. In every case, the caller is just saving these to clean
> up commit marks, isn't it?

bundle also checks if the pending objects exists.

> Could we instead have an interface like:
> 
>    revs.clear_commit_marks = 1;
>    prepare_revision_walk(&revs);
>    ...
>    finish_revision_walk(&revs);
> 
> where that final function would do any cleanup, including clearing the
> commit marks. I suspect there are other small bits that get leaked
> because there's not really any "destructor" for a revision walk.
> 
> It's not as flexible as this whole "make a copy of the pending tips"
> thing, but it keeps all of the details abstracted away from the callers.
> 
> Alternatively:
> 
>> +`prepare_revision_walk_extended`::
>> +
>> +	Like prepare_revision_walk(), but allows callers to take ownership
>> +	of the array of pending objects by passing an object_array pointer
>> +	as the second parameter; passing NULL clears the array.
> 
> What if we just got rid of this function and had callers do:
> 
>    object_array_copy(&old_pending, &revs);
>    prepare_revision_walk(&revs);
>    ...
>    clear_commit_marks_for_object_array(&old_pending);
> 
> That sidesteps all of the memory ownership issues by just creating a
> copy. That's less efficient, but I'd be surprised if it matters in
> practice (we tend to do one or two revisions per process, there don't
> tend to be a lot of pending tips, and we're really just talking about
> copying some pointers here).

This was done before I added the leak_pending flag.

t5502 and t5571 have test cases with ca. 1000 pending objects, t5551
and t5541 with ca. 2000, p5310 more than 8000.  That's just a few KB.

I don't know if there can be real-world use cases with millions of
entries (when it would start to hurt).

Why does prepare_revision_walk() clear the list of pending objects at
all?  Assuming the list is append-only then perhaps remembering the
last handled index would suffice.

René
