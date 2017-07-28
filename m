Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E413120899
	for <e@80x24.org>; Fri, 28 Jul 2017 06:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdG1GH2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 02:07:28 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64167 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751631AbdG1GH0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jul 2017 02:07:26 -0400
X-AuditID: 12074411-95fff70000000acb-26-597ad49c58c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CD.E7.02763.C94DA795; Fri, 28 Jul 2017 02:07:24 -0400 (EDT)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com [209.85.223.181])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6S67NvF004987
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 02:07:24 -0400
Received: by mail-io0-f181.google.com with SMTP id l7so87233636iof.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 23:07:24 -0700 (PDT)
X-Gm-Message-State: AIVw1111RZxG3GTCsAwnGivern4l2dxWmEVa5Z4lT5raPtmUjOqQjbYp
        E5NJcYMlnTe3IXHzmoVwaATFfCV4hw==
X-Received: by 10.107.174.138 with SMTP id n10mr7387094ioo.331.1501222043675;
 Thu, 27 Jul 2017 23:07:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 27 Jul 2017 23:07:22 -0700 (PDT)
In-Reply-To: <xmqqlgn9mzww.fsf@gitster.mtv.corp.google.com>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <xmqq8tj9okzv.fsf@gitster.mtv.corp.google.com> <20170727182854.wxjvjs2x746n3x2t@sigill.intra.peff.net>
 <xmqqlgn9mzww.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 27 Jul 2017 23:07:22 -0700
X-Gmail-Original-Message-ID: <CAMy9T_GP1SRigZHonC8PTPn4RoKGwa31ZTCT04C+d0ks6k8jxA@mail.gmail.com>
Message-ID: <CAMy9T_GP1SRigZHonC8PTPn4RoKGwa31ZTCT04C+d0ks6k8jxA@mail.gmail.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1J17pSrSYK6ERdeVbiYHRo/Pm+QC
        GKO4bFJSczLLUov07RK4Ml6/uM9U0ClXcf5LD0sD4z/xLkZODgkBE4l/HZ3sXYxcHEICO5gk
        HvSehnKeMkmc6HrNCuH0MUpsX3sLyOEAasmX2LGuHqK7VGLDlA/MIDavgKDEyZlPWEBsIQE5
        iVcbbjCClAsJeEvsvuQOEuYUsJa42NHCAjFyFZPEgQUPwXrZBHQlFvU0M4HYLAKqEkcWr2SC
        WJUo8XY11PgAidUbVjCDhIUFgiS+XNYHCYsIqElMbDsENpJZYBazxIG7/9lBEswCmhKt23+z
        T2AUnoXkullIUgsYmVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASw4A7G
        GSflDjEKcDAq8fA++FgZKcSaWFZcmXuIUZKDSUmUd5JpRaQQX1J+SmVGYnFGfFFpTmrxIUYJ
        DmYlEd7gDVWRQrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd7Ky0CN
        gkWp6akVaZk5JQhpJg5OkOE8QMPzQWp4iwsSc4sz0yHypxiNOa5cWfeFiWPKge1fmIRY8vLz
        UqXEebNBSgVASjNK8+CmwZLQK0ZxoOeEeb1AqniACQxu3iugVUxAqyY2VYKsKklESEk1MCbU
        XPsbmj21ZNKJxETWf6vbt3wQMw7fYrzAWal6493GJT3WETn6HOlP2qr+9rzPXDBtxf3HE6Ni
        LvLeqLTkvjVN6xarnsCsiVs1pvbrqrZ39Pc6/sx7tagoT0/fkG3CK5/pP+65XjjjpHg04aK+
        cazFNwP7xR1ul5Pnut+4vEmd8daXgq9fdimxFGckGmoxFxUnAgA5YdNBHQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jul 27, 2017 at 10:19:48AM -0700, Junio C Hamano wrote:
>>
>>> Makes sense.  Makes me wonder why we need a separate .new file
>>> (instead of writing into the .lock instead), but that is a different
>>> issue.
>>
>> It comes from 42dfa7ece (commit_packed_refs(): use a staging file
>> separate from the lockfile, 2017-06-23). That commit explains that we
>> want to be able to put the new contents into service before we release
>> the lock. But it doesn't say why that's useful.
>
> By being able to hold the lock on packed-refs longer, I guess
> something like this becomes possible:
>
>  * hold the lock on packed-refs
>  * hold the lock on loose ref A, B, C, ...
>  * update packed-refs to include the freshest values of these refs
>  * start serving packed-refs without releasing the lock
>  * for X in A, B, C...: delete the loose ref X and unlock X
>  * unlock the packed-refs

Hmmm, I thought that I explained somewhere why this is useful, but I
can't find it now.

The code even after this patch series is

Prepare:
1. lock loose refs
Finish:
2. perform creates and updates of loose refs, releasing their locks as we go
3. perform deletes of loose refs
4. lock packed-refs file
5. repack_without_refs() (delete packed versions of refs to be deleted)
6. commit new packed-refs file (which also unlocks it)
7. release locks on loose refs that were deleted

This is problematic because after a loose reference is deleted, it
briefly (between steps 3 and 5) reveals any packed version of the
reference, which might even point at a commit that has been GCed. It
is even worse if the attempt to acquire the packed refs lock in step 4
fails, because then the repo could be left in that broken state.

Clearly we can avoid the second problem by acquiring the packed-refs
lock during the prepare phase. You might also attempt to fix the first
problem by deleting the references from the packed-refs file before we
delete the corresponding loose references:

Prepare:
1. lock loose refs
2. lock packed-refs file
Finish:
3. perform creates and updates of loose refs, releasing their locks as we go
4. repack_without_refs() (delete packed versions of refs to be deleted)
5. commit new packed-refs file (which also unlocks it)
6. perform deletes of loose refs
7. release locks on loose refs that were deleted

But now we have a different problem. pack-refs does the following:

A. lock packed-refs file
B. read loose refs
C. commit new packed-refs file (which also unlocks it)
Then, for each loose reference that should be pruned, delete it in a
transaction with REF_ISPRUNING, which means:
D. lock the loose reference
E. lock packed-refs file
F. check that the reference's value is the same as the value just
written to packed-refs
G. delete the loose ref file if it still exists
H. unlock the loose reference

If a reference deletion is running at the same time as a pack-refs,
you could have a race where steps A and B of a pack-refs run between
steps 5 and 6 of a reference deletion. The pack-refs would see the
loose reference and would pack it into the packed-refs file, leaving
the reference at its old value even though the user was told that the
reference was deleted.

If a new packed-refs file can be activated while retaining the lock on
the file, then a reference update could keep the packed-refs file
locked during step 6 of the second algorithm, which would block step A
of pack-refs from beginning.

I have the feeling that there might be other, more improbably races
lurking here, too.

The eternal problems with races in the files backend is a main reason
that I'm enthusiastic about the reftable proposal.

Michael
