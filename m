Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4431FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 08:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbdBIIPP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 03:15:15 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61191 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751926AbdBIIPO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 03:15:14 -0500
X-AuditID: 1207440c-07dff70000000a44-43-589c22ade100
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.EB.02628.DA22C985; Thu,  9 Feb 2017 03:05:01 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1984xtR009025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 03:05:00 -0500
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs
 from another worktree
To:     Junio C Hamano <gitster@pobox.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170208113144.8201-3-pclouds@gmail.com>
 <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
 <xmqqpoirsvin.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3ac5517a-aa82-7078-91a5-e182e1faed1a@alum.mit.edu>
Date:   Thu, 9 Feb 2017 09:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoirsvin.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqLtWaU6EwZm9KhZdV7qZLBp6rzBb
        dE95y+jA7LFz1l12j4uXlD0+b5ILYI7isklJzcksSy3St0vgynjTd461YIp2xcE5HYwNjGeV
        uhg5OSQETCS2337I1MXIxSEkcJlR4vSsJ+wQznkmif33DzKDVAkLJEu8W3mdFcQWEVCTmNh2
        iAWi6ASjxK6fG9lAEswCaRJrt8wCa2AT0JVY1NPMBGLzCthL7Ht3BSzOIqAicWjZZxYQW1Qg
        RGLOwgeMEDWCEidnPgGLcwpYS6y/0MEOMVNPYsf1X6wQtrzE9rdzmCcw8s9C0jILSdksJGUL
        GJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEKc8Oxm/rZA4xCnAwKvHw
        VljOjhBiTSwrrsw9xCjJwaQkyhvxHyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHe/3JwIId6U
        xMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO9TRaBGwaLU9NSKtMycEoQ0
        EwcnyHAeoOHcSiDDiwsSc4sz0yHypxgVpcR5E0GaBUASGaV5cL2wJPKKURzoFWFecZAqHmAC
        gut+BTSYCWjw9dOzQAaXJCKkpBoYi9v2y//v+Xr558sVKybnMleW/P0d9v7H8iAzweBKLVmt
        7Pp0N5GIpvwjmVdcdB6d6NGWeuHMU/Y/qfrTIUbH5WL65zPkXW4zvzdYUCrn7HGT/QrLFeVJ
        95tjfLtWuCdv3MOu88bvzZ3Ujw8y5fNm3hR+F7f/eOevL/PbuOT7JcrOdMifP1mrxFKckWio
        xVxUnAgA44tLwf0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 07:55 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> There are two meanings of the concept of a "ref store", and I think this
>> change muddles them:
>>
>> 1. The references that happen to be *physically* stored in a particular
>>    location, for example the `refs/bisect/*` references in a worktree.
>>
>> 2. The references that *logically* should be considered part of a
>>    particular repository. This might require stitching together
>>    references from multiple sources, for example `HEAD` and
>>    `refs/bisect` from a worktree's own directory with other
>>    references from the main repository.
>>
>> Either of these concepts can be implemented via the `ref_store` abstraction.
>> ...
>> The `ref_store` that you want here for a worktree is not the worktree's
>> *logical* `ref_store`. You want the worktree's *physical* `ref_store`.
>> Mixing logical and physical reference stores together is a bad idea
>> (even if we were willing to ignore the fact that worktrees are not
>> submodules in the accepted sense of the word).
> 
> I am not quite sure what mental model you are suggesting as a
> preferred solution.  We can
> 
>  - represent a set of refs stored for a particular worktree
>    (i.e. HEAD, refs/bisect, and refs/worktree/<name>, iirc), as
>    bunch of ref_stores;
> 
>  - represent a set of refs shared across a set of worktrees that
>    share the primary one, as another ref_store;
> 
>  - a caller who wants to get a "logical" view of a single worktree
>    user can pick one of the first kind and union that with the
>    second one, and represent the result as a (synthetic) ref_store.
> 
> The third one is "stitching together from multiple sources".  By
> "mixing logical and physical is a bad idea", do you mean that the
> same abstraction "ref_store" should not be used for the first two
> (which are physical) and the third one (which is logical)?  Do you
> want to call the first two "physical_ref_store"and the last one
> "ref_store" and keep them distinct?

The existing `ref_store` abstraction, I think, is capable of
representing either kind of reference store. The stitching together to
get the "logical" view of a worktree should probably happen within the
refs code rather than forcing callers to deal with it. But yes, I think
that code should put together a compound `ref_store` object that
delegates to multiple underlying `ref_store` objects as you've described.

Which kind of `ref_store *` you have in your hand would depend on where
you got it. If you call the hypothetical `get_submodule_refs()`
function, you would get a `ref_store *` representing the references that
are logically visible from that submodule. There might be a separate
`get_worktree_specific_refs()` that returns a `ref_store *` representing
the worktree-specific references physically stored for the worktree. But
maybe the latter is not even necessary; see below.

> For the purpose of anchoring objects in the object store shared by
> multiple worktrees, we can either iterate over all the ref_stores
> of the first two kind, or iterate over all the ref_stores of the
> third kind for all worktrees.  The latter of course is less
> efficient as the enumeration
> 
> 	for worktree in all worktrees:
> 		for ref in get_ref_store(worktree)
> 			mark tip of ref reachable
> 
> will work on all the shared refs multiple times, but as an
> abstraction that may be simpler.  The alternative of working at the
> physical level would be more efficient
> 
> 	for worktree in all worktrees:
> 		for ref in get_ref_store_specific_to_worktree(worktree):
> 	        	mark tip of ref reachable
> 	for ref in get_ref_store_shared_across_worktrees():
>         	mark tip of ref reachable
> 
> but this consumer now _knows_ how the logical ref_store of a
> worktree is constructed (i.e. by combining the two ref_stores),
> which appears as a layering violation.
> 
> I am however not sure if these issues are what you are driving at,
> and what exact design you are suggesting.

Reachability is a special case, because it needs all of the references
that refer to a particular object store, even though the reference names
might overlap. I personally think that reachability roots should be
requested via a new refs API call separate from `for_each_rawref()` (or
whatever is used now). Internally it would be implemented much like your
second "efficient" algorithm, but the implementation would be within the
refs code, and the caller could remain ignorant of those details.

Externally, it might not even want to pass the caller the real reference
names (I assume that callers mainly only use the reference names for
diagnostic messages). For example, it might want to report references
`HEAD` and `refs/bisect/bad` in worktree `foo` under the pseudonyms
`worktree/foo/HEAD` and `worktree/foo/refs/bisect/bad`, so that they can
be distinguished from any homonyms in the main repo and in other
worktrees. If you ask for the reachability roots while in a worktree, it
would either automatically crawl up to the main repository and across to
sibling worktrees to get the full set of reachability roots, or maybe it
would refuse to run at all (if we want to require such commands to be
executed from the main repo).

I don't know exactly who would be the consumers of the reachability
roots, so maybe there are some problems with this suggestion.

Michael

