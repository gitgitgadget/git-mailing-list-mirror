Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AA81FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdBIOFP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 09:05:15 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54570 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751625AbdBIOFN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 09:05:13 -0500
X-AuditID: 12074412-5f5ff700000009b5-23-589c76c9ec63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E7.AA.02485.9C67C985; Thu,  9 Feb 2017 09:03:53 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19E3pcf024760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 09:03:52 -0500
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs
 from another worktree
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170208113144.8201-3-pclouds@gmail.com>
 <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
 <CACsJy8Diy92CNbJ1OBn893VFFrSsxBFWSyQHjt_Dzq9x7jfibQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <4bea30e9-9724-0a71-e9da-d79ad8accd28@alum.mit.edu>
Date:   Thu, 9 Feb 2017 15:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Diy92CNbJ1OBn893VFFrSsxBFWSyQHjt_Dzq9x7jfibQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqHuybE6EwYz98hZdV7qZLBp6rzBb
        dE95y2ixeXM7iwOLx85Zd9k9Fmwq9bh4Sdnj8ya5AJYoLpuU1JzMstQifbsEroy2xqUsBc1K
        FU23/rA0MP6T6mLk5JAQMJF4t3kSYxcjF4eQwGVGicm3DjBDOOeZJGa17WQCqRIWSJZ4t/I6
        K4gtIqAk8aZjG1TRPUaJxrsn2UAcZoE2Rommlc/BqtgEdCUW9TSDdfMK2EucaHvGBmKzCKhI
        tJ48zgxiiwqESMxZ+IARokZQ4uTMJyxdjBwcnAKBEnPuW4KEmQXUJf7Mu8QMYctLbH87h3kC
        I/8sJB2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI2Art
        YFx/Uu4QowAHoxIPb4Xl7Agh1sSy4srcQ4ySHExKoryyBXMihPiS8lMqMxKLM+KLSnNSiw8x
        SnAwK4nw7s0DyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfA+KwVq
        FCxKTU+tSMvMKUFIM3FwggznARr+F6SGt7ggMbc4Mx0if4pRUUqcNxwkIQCSyCjNg+uFpZVX
        jOJArwjzfgGp4gGmJLjuV0CDmYAGXz89C2RwSSJCSqqBUcXCLD7u+7Wl25xuT620krbbFiNm
        6bE/oWO/Kltf/aMTVRJ9zflfEjdPXH9i7ppF71WU2Se9MjlraFiidzbw39nd4ZHnE7XnrGZt
        j5ZsltrMOutxKMeqNf3L1B/XTaja7mW80OqCoKb8lsfqv9gKtxRvs7t6RVfxzKfIJbqnuo5U
        RJv/9fR7pcRSnJFoqMVcVJwIANzPX+8GAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 12:59 PM, Duy Nguyen wrote:
> On Thu, Feb 9, 2017 at 1:07 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> It is unquestionably a good goal to avoid parsing references outside of
>> `refs/files-backend.c`. But I'm not a fan of this approach.
> 
> Yes. But in this context it was more of a guinea pig. I wanted
> something simple enough to code up show we can see what the approach
> looked like. Good thing I did it.
> 
>>
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
>>
>> The `ref_store` for a submodule should represent the references
>> logically visible from the submodule. The main program shouldn't care
>> whether the references are stored in a single physical location or
>> spread across multiple locations (for example, if the submodule were
>> itself a linked worktree).
>>
>> The `ref_store` that you want here for a worktree is not the worktree's
>> *logical* `ref_store`. You want the worktree's *physical* `ref_store`.
> 
> Yep.
> 
>> Mixing logical and physical reference stores together is a bad idea
>> (even if we were willing to ignore the fact that worktrees are not
>> submodules in the accepted sense of the word).
>>
>> ...
>>
>> I think the best solution would be to expose the concept of `ref_store`
>> in the public refs API. Then users of submodules would essentially do
>>
>>     struct ref_store *refs = get_submodule_refs(submodule_path);
>>     ... resolve_ref_recursively(refs, refname, 0, sha1, &flags) ...
>>     ... for_each_ref(refs, fn, cb_data) ...
>>
>> whereas for a worktree you'd have to look up the `ref_store` instance
>> somewhere else (or maybe keep it as part of some worktree structure, if
>> there is one) but you would use it via the same API.
> 
> Oh I was going to reply to Stefan about his comment to my (**)
> footnote. Something along the this line
> 
> "Ideally we would introduce a new set of api, maybe with refs_ prefix,
> that takes a refs_store. Then submodule people can get a ref store
> somewhere and pass to it. Worktree people get maybe some other refs
> store for it. The "old" api like for_each_ref() is a thin wrapper
> around it, just like read_cache() vs read_index(&the_index). If the
> *_submodule does not see much use, we might as well kill it and use
> the generic refs_*".
> 
> If I didn't misunderstood anything else, then I think we're on the same page.
> 
> Now I need to see if I can get there in a reasonable time frame (so I
> can fix my "gc in worktree" problem properly) or I would need
> something temporary but not so hacky. I'll try to make this new api
> and see how it works out. If you think I should not do it right away,
> for whatever reason, stop me now.

Sounds good. A couple of hints and points to remember:

* I think `struct ref_store *` should remain opaque outside of the refs
  code.

* The virtual function interface embodied in `struct ref_storage_be`
  isn't meant to be an external interface (i.e., don't just expose it
  and have external callers use it directly).

* One important distinction between the main reference store and
  submodule reference stores is that we know the object store for
  the former but not the latter. That implies that some operations
  are, or should be, impossible for submodules (e.g., anything that
  involves looking up objects, including peeling refs). However, we
  *do* know the object store for linked worktrees. So they don't have
  to be as dumbed-down as submodule ref stores. (This might be
  irrelevant if you don't need any additional features for your
  current purposes.)

Also, I just sent my submodule-hash patch series to the mailing list in
case you want to build on that.

Michael

