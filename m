Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B57C207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbdECUkV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:40:21 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33934 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdECUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:40:19 -0400
Received: by mail-io0-f178.google.com with SMTP id k91so25703672ioi.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UOADE7djA/PRJ5IlPsKvm5mbljlJzK8qGHUpvA0HsDg=;
        b=MCIKpRfg+K0/Wwf5rmocDg2TeC4R8bhrJxX5w/bKn76oXfYvtQ8Q0cD0DxCPyRrZgw
         6Hqd/uJI/LUCdrIG9mIG05kJP3O9FYLHzO2VO/vNi08vfE1ocKbxx23jrbmhF6CbDovG
         VHVImrsm7wqwPRKD2fgsH7sFiE5K3RKw7syjNPOfLQxD7DE/MmnQht2w//iXLKC1alKu
         5Ww7mdwKkdxpiW+Ll+s0KMNb+nbY3Sussn5seuonZ4JJxAp5SJl8c/iZeLIw3N8F4Iel
         1R2YQxWB+RIsIk6zDxpuCMLFTdACEefAkvWKUnaB+hrXQ9qw7E0hyeWrSdgJdabUO/h3
         /fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UOADE7djA/PRJ5IlPsKvm5mbljlJzK8qGHUpvA0HsDg=;
        b=k2XOWhtLBeK1AV5UMdVY2X0qmpdWKwzSIkgBXcqg7wXqDJRdUwNZTmc7m7INJqSxcY
         T0EpQ3TLIxdIH8balKG2/VyvYzpJeSxPJQm6EcLMQV19y9KTxI4ZNq6UEUgdJett3VrZ
         nBrlBOgSwM+g1C4obbxchoOt66v9IzX9PDepmKBcrEts3bhtBw9L8HHbkx3iIo6AJPgX
         5pryQXtOtlF+3cPmeChNBGcgxi/YC481EhoYA/RywxIYIFpDBCdQxZfKcaLQ9E3JFDzG
         aLBcwwBq21qvtQwyS/lJYDQaJ7I8chg7I3KLsIcpGk9fD3Ris508y9dVQjHPc5o8fAIU
         Dqnw==
X-Gm-Message-State: AN3rC/6UdvrXLQjx22+awHnNHIiSdE0eGfX7WWIZYwP+nafyptYnCoNC
        Wwkrc0s/M4TVZWxof/KjDA==
X-Received: by 10.107.19.90 with SMTP id b87mr35756392ioj.7.1493844010891;
        Wed, 03 May 2017 13:40:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:146e:121e:61e5:84b5])
        by smtp.gmail.com with ESMTPSA id i39sm410711iod.31.2017.05.03.13.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 13:40:09 -0700 (PDT)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <2b1b504a-07c9-81b3-fed2-e9c029a5b284@google.com>
Date:   Wed, 3 May 2017 13:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/2017 09:38 AM, Jeff Hostetler wrote:
>
>
> On 3/8/2017 1:50 PM, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>>
>> [RFC] Partial Clone and Fetch
>> =============================
>> [...]
>> E. Unresolved Thoughts
>> ======================
>>
>> *TODO* The server should optionally return (in a side-band?) a list
>> of the blobs that it omitted from the packfile (and possibly the sizes
>> or sha1_object_info() data for them) during the fetch-pack/upload-pack
>> operation.  This would allow the client to distinguish from invalid
>> SHAs and missing ones.  Size information would allow the client to
>> maybe choose between various servers.
>
> Since I first posted this, Jonathan Tan has started a related
> discussion on missing blob support.
> https://public-inbox.org/git/CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com/T/
>
>
> I want to respond to both of these threads here.
> -------------------------------------------------

Thanks for your input. I see that you have explained both "storing 
'positive' information about missing blobs" and "what to store with 
those positive information"; I'll just comment on the former for now.

> Missing-Blob Support
> ====================
>
> Let me offer up an alternative idea for representing
> missing blobs.  This is differs from both of our previous
> proposals.  (I don't have any code for this new proposal,
> I just want to think out loud a bit and see if this is a
> direction worth pursuing -- or a complete non-starter.)
>
> Both proposals talk about detecting and adapting to a missing
> blob and ways to recover -- when we fail to find a blob.
> Comments on the thread asked about:
> () being able to detect missing blobs vs corrupt repos
> () being unable to detect duplicate blobs
> () expense of blob search.
>
> Suppose we store "positive" information about missing blobs?
> This would let us know that a blob is intentionally missing
> and possibly some meta-data about it.

I thought about this (see "Some alternative designs" in [1]), listing 
some similar benefits, but concluded that "it is difficult to scale to 
large repos".

Firstly, to be clear, by large repos I meant (and mean) the svn-style 
"monorepos" that Jonathan Nieder mentions as use case "A" [2].

My concern is that such lists (whether in separate file(s) or in .idx 
files) would be too unwieldy to manipulate. Even if we design things to 
avoid modifying such lists (for example, by adding a new list whenever 
we fetch instead of trying to modify an existing one), we would at least 
need to sort their contents (for example, when generating an .idx in the 
first place). For a repo with 10M-100M blobs [3], this might be doable 
on today's computers, but I would be concerned if a repo would exceed 
such numbers.

[1] <20170426221346.25337-1-jonathantanmy@google.com>
[2] <20170503182725.GC28740@aiede.svl.corp.google.com>
[3] In Microsoft's announcement of Git Virtual File System [4], they 
mentioned "over 3.5 million files" in the Windows codebase. I'm not sure 
if this refers to files in a snapshot (that is, working copy) or all 
historical versions.
[4] 
https://blogs.msdn.microsoft.com/visualstudioalm/2017/02/03/announcing-gvfs-git-virtual-file-system/

> 1. Suppose we update the .pack file format slightly.
>    () We use the 5 value in "enum object_type" to mean a
>       "missing-blob".
>    () We update git-pack-object as I did in my RFC, but have it
>       create type 5 entries for the blobs that are omitted,
>       rather than nothing.
>    () Hopefully, the same logic that currently keeps pack-object
>       from sending unnecessary blobs on subsequent fetches can
>       also be used to keep it from sending unnecessary missing-blob
>       entries.
>    () The type 5 missing-blob entry would contain the SHA-1 of the
>       blob and some meta-data to be explained later.

My original idea was to have sorted list(s) of hashes in separate 
file(s) much like the currently existing shallow file; it would have the 
semantics of "a hash here might be present or absent; if it is absent, 
use the hook". (Initially I thought that one list would be sufficient, 
but after reading your idea and considering it some more, multiple lists 
might be better.)

Your idea of storing them in an .idx (and possibly corresponding .pack 
file) is similar, I think. Although mine is probably simpler - at least, 
we wouldn't need a new object_type.

As described above, I don't think this list-of-hashes idea will work 
(because of the large numbers of blobs involved), but I'll compare it to 
yours anyway just in case we end up being convinced that this general 
idea works.

> 2. Make a similar change in the .idx format and git-index-pack
>    to include them there.  Then blob lookup operations could
>    definitively determine that a blob exists and is just not
>    present locally.
>
> 3. With this, packfile-based blob-lookup operations can get a
>    "missing-blob" result.
>    () It should be possible to short-cut searching in other
>       packfiles (because we don't have to assume that the blob
>       was just misplaced in another packfile).
>    () Lookup can still look for the corresponding loose blob
>       (in case a previous lookup already "faulted it in").

The binary search to lookup a packfile offset from a .idx file (which 
involves disk reads) would take longer for all lookups (not just lookups 
for missing blobs) - I think I prefer keeping the lists separate, to 
avoid pessimizing the (likely) usual case where the relevant blobs are 
all already in local repo storage.

> 4. We can then think about dynamically fetching it.
>    () Several techniques for this are currently being
>       discussed on the mailing list in other threads,
>       so I won't go into this here.
>    () There has also been debate about whether this should
>       yield a loose blob or a new packfile.  I think both
>       forms have merit and depend on whether we are limited
>       to asking for a single blob or can make a batch request.
>    () A dynamically-fetched loose blob is placed in the normal
>       loose blob directory hierarchy so that subsequent
>       lookups can find it as mentioned above.
>    () A dynamically-fetched packfile (with one or more blobs)
>       is written to the ODB and then the lookup operation
>       completes.
>       {} I want to isolate these packfiles from the main
>          packfiles, so that they behave like a second-stage
>          lookup and don't affect the caching/LRU nature of
>          the existing first-stage packfile lookup.
>       {} I also don't want the ambiguity of having 2 primary
>          packfiles with a blob marked as missing in 1 and
>          present in the other.

With my idea, the second-stage lookup is done on the list of missing 
hashes; there is no division between packfiles.

> 5. git-repack should be updated to "do the right thing" and
>    squash missing-blob entries.
>
> 6. And etc.
