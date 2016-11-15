Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313472021E
	for <e@80x24.org>; Tue, 15 Nov 2016 21:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbcKOVxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 16:53:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:55370 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932407AbcKOVxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 16:53:50 -0500
Received: from [192.168.178.43] ([88.70.147.72]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbVT-1cf01k1ti7-00aBfI; Tue, 15
 Nov 2016 22:53:43 +0100
Subject: Re: [PATCH v15 04/27] bisect--helper: `bisect_clean_state` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1a82-dc1c5b57-3e93-4996-87e7-4a1d83cb5817-000000@eu-west-1.amazonses.com>
 <13aa642a-2272-c5b8-4a30-382ab5e73b98@gmx.net>
 <xmqq37istoay.fsf@gitster.mtv.corp.google.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <827c5f88-dcdd-2fa0-5461-77f29be87783@gmx.net>
Date:   Tue, 15 Nov 2016 22:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq37istoay.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:AYVbLYHcEF+o5yhozMFFk5JIxHV9Ki+1l/2QjtuJ+mSVva0ibpK
 ORVgxx1OY801Zx2XBtekpxHjCVpLLpICXqF80LcBqlsdP8qJ3bsqfVXGkNr6JB2IYo96AWY
 /Xw7Z+sEpvIyo9j9qbRft8P00wgIb/rbDMDgW1jzg0XN0irQZR/YJrRs/SACYgTLOW1o6rG
 DMFG9PTCxTcct7uUuM9/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLzz9E9LObg=:XGXYhqhfZD2Fx85UaFSR3p
 ZugXzskOquAxTeHieZHB4rzf8SE2GGDsmyJ74lrmaXp8UN4/U3I4PQCV4+LMEuhXpLRBzDABI
 ouhVF3+C/HKJFVdz2fL4iAEe3Zifld+19RjaEjGi9yMtk5ZJ+VVxDcyEzaZiZnqZqYX2a60ni
 g0U0gqjXO+Vl70df7DYVItV+BQ27pqAgpdbgKK8EEUHGNiZvDpvOlIZwM5KmgUuRirl9JkL/L
 GDnwgAP8McJVEgRwquoU4/ZnBTM0Hlg0TYAbfkLROSuXhbwcc8YH2dzzjFt/PBDaRuMZ6lL0i
 Fub94/La7Ndgf/wnrSDhjVTrgoLwCb/ivJ2Mm0zkFqUHTYi3kCyhFn7L0mgj6euOBbwnQbS3c
 Hkc/MZhlTgtmDvtkX6lKiG89+M49j/Ab4IQAzyX/eX/2I8INJPUJIcIFRIDZQHz2kQOkquI5A
 MtXBe0y6YxdDX5lfbeDi640+pStte0Mx/G7Y2jph47ckX0ZgHq01ReatQ9JvcrNndkXOaQWYx
 3SsR1kXrX9ZxalUwSzN9hiqFzEm0fshXyJB7SwTMaKq1wtm6j8aeq4lU9HJdk4orgUcIwMKOt
 A9rjJk/BiutIihXjyzqqwaE6EqnnuJbDGX8vrwesvVulpRV7RWv06OHXj1Vsl2WQTgI3JO6by
 HgR3ze2hP0ScRL21iRst5GtX/6BtafDvVSbkJFCP2VVEPBykOxNeop5NvwR3JnZo9FSDZLree
 PwZip2hY1jFqpjm8bpt6WEc2aChyFWt273sSwCdM9lbImCBKQ17AwtwdFFbzAyvwM1DGrerZc
 Qy0vLco
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2016 10:40 PM, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
>>> +int bisect_clean_state(void)
>>> +{
>>> +	int result = 0;
>>> +
>>> +	/* There may be some refs packed during bisection */
>>> +	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>>> +	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
>>> +	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
>>> +	result = delete_refs(&refs_for_removal, REF_NODEREF);
>>> +	refs_for_removal.strdup_strings = 1;
>>> +	string_list_clear(&refs_for_removal, 0);
>>
>> Does it have advantages to populate a list (with duplicated strings),
>> hand it to delete_refs(), and clear the list (and strings), instead of
>> just doing a single delete_ref() (or whatever name the singular function
>> has) in the callback?
> 
> Depending on ref backends, removing multiple refs may be a lot more
> efficient than calling a single ref removal for the same set of
> refs, and the comment upfront I think hints that the code was
> written in the way exactly with that in mind.  Removing N refs from
> a packed refs file will involve a loop that runs N times, each
> iteration loading the file, locating an entry among possibly 100s of
> refs to remove, and then rewriting the file.

Great, that's the reply I wanted to hear (and that I've considered but
wasn't sure of) ;)
[I did not want to dig into the sources and check if delete_refs() does
something smarter than invoking delete_ref() on each item of the list.]

~Stephan
