Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825F520357
	for <e@80x24.org>; Fri, 14 Jul 2017 21:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdGNVaX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 17:30:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34513 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdGNVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 17:30:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so11816161pge.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WV1D2cTBn/VMML+rhKjL/zee2+FOEWmiGMkJyxJ4/CU=;
        b=ZI5qDTPDP2McdTfY/npg+nESxzE0l5IH6EaV/RaA+o10EvJK/HwJmg14/Jas5ggCXj
         J06TMR8qr/e50aa8uqy+g+zWF2yi0VJHMk880BayOhsABvt22t2tTR/UXfKH2oH8yg4o
         U/GVq84e07LyFCdaWbB2V5hMf2aIYpbybvHRDTtxoj8MrnYO8gmg9y1vpkEL/GGHRDxu
         ZHs7/VEdL5/jvhQxKxyNDGHlPxGm5nSB/uBsokJro3A/W5n0vOdURpWz9uZzkYZ3Zlt1
         hV291oupIGA0Mw7kzGZFvrIrQC7smzPs/NfcPI9cjfsMi6AxJiwK8TdYP++Qe6obJIaY
         DcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WV1D2cTBn/VMML+rhKjL/zee2+FOEWmiGMkJyxJ4/CU=;
        b=AUfeidHO1fPkKuQgM7nSrIdQhgCnB/c2EM0uZp0wHyEwYkewo1bPpIWCtMXLuowSG6
         WyDWryNnd0gaf/hDAzgO9JoQbWIrLSafLujznnclM7fdsUk9v8jLoxpY31r0W2Vh4S5j
         QBylMNw2hVXx14ExIXU/5OQade62QcQHcUnGWyToLqOk+xehtcP6QjY6coLGk2ZQhpZS
         por9+Y+iT8bv3tI/ycyh1EubX7JgMj9CQalrHL52kwGXZoLOB4nBZQZc4BfZs4+L4/Hi
         x7AQKalKrdcUza7XWimcsbKfz8FLz58wBqCuUaYV/FtVYnNM6jorJ7YCGq5X5vLWLKRb
         TQMw==
X-Gm-Message-State: AIVw1130wpfVXqzSpfYpmzhxkrpsoRGI+37dYTrQVy5em8shx3DGFODA
        fllbep6ij/BS2V4lc+4=
X-Received: by 10.98.113.71 with SMTP id m68mr7407084pfc.220.1500067821922;
        Fri, 14 Jul 2017 14:30:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:a88b:f9f7:b07a:c72d])
        by smtp.gmail.com with ESMTPSA id p28sm23597894pfl.102.2017.07.14.14.30.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 14:30:20 -0700 (PDT)
Date:   Fri, 14 Jul 2017 14:30:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
Message-ID: <20170714213018.GK93855@aiede.mtv.corp.google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
 <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
 <20170713123951.5cab1adc@twelve2.svl.corp.google.com>
 <4d0849b0-1340-5b82-ba3c-03a1f5c42f33@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0849b0-1340-5b82-ba3c-03a1f5c42f33@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:
> On 7/13/2017 3:39 PM, Jonathan Tan wrote:

>> I know that discussion has shifted to the possibility of not having this
>> list at all, and not sending size information together with the fetch,
>> but going back to this...maybe omitting trees *is* the solution to both
>> the large local list and the large amount of size information needing to
>> be transferred.
>>
>> So the large-blob (e.g. Android) and many-blob (e.g. Windows) cases
>> would look like this:
>>
>>   * Large-blob repositories have no trees omitted and a few blobs
>>     omitted, and we have sizes for all of them.
>>   * Many-blob repositories have many trees omitted and either all
>>     blobs omitted (and we have size information for them, useful for FUSE
>>     or FUSE-like things, for example) or possibly no blobs omitted (for
>>     example, if shallow clones are going to be the norm, there won't be
>>     many blobs to begin with if trees are omitted).
>
> I'm not sure I understand what you're saying here.  Does omitting a tree
> object change the set of blob sizes we receive?  Are you saying that if
> we omit a tree, then we implicitly omit all the blobs it references and
> don't send size info those blobs?  So that the local list only has
> reachable objects?  So faulting-in a tree would also have to send size
> info for the newly referenced blobs?
>
> Would this make it more similar to a shallow clone (in that none of the
> have_object tests work for items beyond the cut point) ?

Correct.  After the server sends a promise instead of a tree object, the
client has no reason to try to access blobs pointed to by that tree, any
more than it has reason to try to access commits on a branch it has not
fetched.  This means the client does not have to be aware of those blobs
until it fetches the tree and associated blob promises.

[...]
> For the former case, if you just have a few omitted objects, then a
> second round-trip to mget their sizes isn't that much work.

For the client, that is true.  For the server, decreasing the number
of requests even when requests are small and fast can be valuable.

[...]
> I think for the latter, forcing a full promise-list on clone is just
> too much data to send -- data that we likely won't ever need.

What did you think of the suggestion to not send promises for objects
that are only referenced by objects that weren't sent?

[...]
>> What do you think of doing this:
>>   * add a "type" field to the list of promised objects (formerly the list
>>     of promised blobs)
>>   * retain mandatory size for blobs
>>   * retain single file containing list of promised objects (I don't feel
>>     too strongly about this, but it has a slight simplicity and
>>     in-between-GC performance advantage)
>
> The single promise-set is problematic.  I think it will grow too
> large (in our case) and will need all the usual lock juggling
> and merging.
>
> I still prefer my suggestion for a per-packfile promise-set for all
> of the reasons I stated the other day.  This can be computed quickly
> during index-pack, is (nearly) read-only, and doesn't require the
> whole file rewrite lock file.  It also has the benefit of being
> portable -- in that I can also copy the .promise file if I copy the
> .pack and .idx file to another repo.

Okay.

Thanks,
Jonathan
