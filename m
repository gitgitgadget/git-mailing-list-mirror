Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56931F597
	for <e@80x24.org>; Mon, 18 Jun 2018 18:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935816AbeFRSsa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:48:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32913 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935677AbeFRSs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:48:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id c131-v6so9968773qkb.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pckCe129Tuxjgzb7gDvA3Iw9XjGaMPn9bZ1SxPHUs4w=;
        b=mrKwmuWlXdmCcTkVdLdr5VTI214jjLFWGQrCA/QoMaIPVEIWZmw0b8yxuoBQbWUJIY
         YEcfB21kPmc2hFgFfz9ylHgK8M9y2k5PnpX/ZLZvweq3niLUIiuCVlWVzXZX2JvIZfCA
         DF1j7qD1Jc0FFlFGm3tRJulfmoe4fN7M84JUYH2SzBuGQvtQAaGQTpHocUeUfRHzOpTc
         nq+wAKrU7YraGW4eLTFTVYpjyK3cbkhh4vxX1fV5HCOvzPBhM0ToXqfKgdGczbcjtBEP
         55ic4o9ihvq/Aun48fklYDhTOrGK19F8k4fsToPdpPHKtHfEMyXpIADYVldy/Ws0A53i
         BSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pckCe129Tuxjgzb7gDvA3Iw9XjGaMPn9bZ1SxPHUs4w=;
        b=ulQVYCZ9ToVmnMP7fy+mOukPvPMb+xX3+KBpmZGNXCvkrhhfHjXPxjdVQKYu6c5f6n
         m81Em61RvzfqBbIgCyJU1+HLxcgqaZ4PBEtaGEj+k6k7pYqeTraQxrNJr/Yo7kG84GID
         TgmLz02snEpF3PqRbfv9iUKZqmR8FKzqF4szmYKiVpF8+m728P8sHIuoT4bpKJy0QMpi
         CW8IzYtzrcW/3CSH9TPwTc3Um+27TnxwSxr0vQshdqzx0SIDxv+JvY0D3sb8XKuabvwZ
         Yp9gswBISVZzqAA1aS/1WufckaAqN4KgE6/cRx8IAp+EBcNjV+vtXYxiK/WhuSeNDyMj
         NhMQ==
X-Gm-Message-State: APt69E3Q3Do4vze834L3c3ChDzh5vtauCSAVwKDY5hsZhIvilSm8a+EY
        REI5YrtvGY2XkHnQ05g1wtE=
X-Google-Smtp-Source: ADUXVKK9g18omgjPO+xq7B3G4rk++/6M0YRjOV3IhtFs+B5ZuH/Du83VMbvghTRyqghK6ZaE/HeVGA==
X-Received: by 2002:a37:aa4d:: with SMTP id t74-v6mr9080000qke.141.1529347708686;
        Mon, 18 Jun 2018 11:48:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:486:96a1:3ab7:988c? ([2001:4898:8010:0:edbb:96a1:3ab7:988c])
        by smtp.gmail.com with ESMTPSA id m6-v6sm17243776qkm.12.2018.06.18.11.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:48:27 -0700 (PDT)
Subject: Re: [PATCH 01/23] midx: add design document
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-2-dstolee@microsoft.com>
 <CAGZ79ka4RD_E5NpEf8-7BUCcoqEc+hDrHNR+YAqT=6m5TYg7mg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e251bcff-8638-19d8-2937-0e913b19215a@gmail.com>
Date:   Mon, 18 Jun 2018 14:48:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka4RD_E5NpEf8-7BUCcoqEc+hDrHNR+YAqT=6m5TYg7mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2018 3:04 PM, Stefan Beller wrote:
> On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/midx.txt | 109 +++++++++++++++++++++++++++++++
>>   1 file changed, 109 insertions(+)
>>   create mode 100644 Documentation/technical/midx.txt
>>
>> diff --git a/Documentation/technical/midx.txt b/Documentation/technical/midx.txt
>> new file mode 100644
>> index 0000000000..789f410d71
>> --- /dev/null
>> +++ b/Documentation/technical/midx.txt
>> @@ -0,0 +1,109 @@
>> +Multi-Pack-Index (MIDX) Design Notes
>> +====================================
>> +
>> +The Git object directory contains a 'pack' directory containing
>> +packfiles (with suffix ".pack") and pack-indexes (with suffix
>> +".idx"). The pack-indexes provide a way to lookup objects and
>> +navigate to their offset within the pack, but these must come
>> +in pairs with the packfiles. This pairing depends on the file
>> +names, as the pack-index differs only in suffix with its pack-
>> +file. While the pack-indexes provide fast lookup per packfile,
>> +this performance degrades as the number of packfiles increases,
>> +because abbreviations need to inspect every packfile and we are
>> +more likely to have a miss on our most-recently-used packfile.
>> +For some large repositories, repacking into a single packfile
>> +is not feasible due to storage space or excessive repack times.
> This leads to the question how MIDX will cope with large repos or
> a large number of packs. As it is just an index and not a pack itself,
> I guess it is smaller by some orders of magnitude, such that it
> is ok for now.

The MIDX file is only slightly larger than the union of the IDX files 
for those packfiles.

>> +The multi-pack-index (MIDX for short) stores a list of objects
>> +and their offsets into multiple packfiles. It contains:
>> +
>> +- A list of packfile names.
>> +- A sorted list of object IDs.
>> +- A list of metadata for the ith object ID including:
>> +  - A value j referring to the jth packfile.
>> +  - An offset within the jth packfile for the object.
>> +- If large offsets are required, we use another list of large
>> +  offsets similar to version 2 pack-indexes.
>> +
>> +Thus, we can provide O(log N) lookup time for any number
>> +of packfiles.
> This sounds great for the lookup case!
> Though that is for the repo-read case.
> Let's read on how the dynamics of a repository are dealt with,
> e.g. integrating new packs into the MIDX, or how we deal with
> objects in multiple packs.
>
>> +
>> +Design Details
>> +--------------
>> +
>> +- The MIDX is stored in a file named 'multi-pack-index' in the
>> +  .git/objects/pack directory. This could be stored in the pack
>> +  directory of an alternate. It refers only to packfiles in that
>> +  same directory.
> So there is one and only one multi pack index?
> That makes the case of preparing the next MIDX that contains more
> pack references more interesting, as then we have to atomically update
> that file.

There is only one, but we can make the file incremental without changing 
this name similar to how the split index works.

>
>> +- The core.midx config setting must be on to consume MIDX files.
> Looking through current config options, I would rename this to a more
> suggestive name. I searched for the core.idx counterpart that enables
> idx files -- it turns out that is named pack.indexVersion.
>
> So maybe pack.MultiIndex ? That could start out as a boolean as in this
> series and then evolve into a version number or such later.

I'll use that name and rename this file to 
Documentation/technical/multi-pack-index.txt

>
>> +- The file format includes parameters for the object ID hash
>> +  function, so a future change of hash algorithm does not require
>> +  a change in format.
>> +
>> +- The MIDX keeps only one record per object ID. If an object appears
>> +  in multiple packfiles, then the MIDX selects the copy in the most-
>> +  recently modified packfile.
> Okay. That answers the question from above. Though this is just the tie
> breaking decision and not a hard limitation? (i.e. we could change this
> this later to that pack that has e.g. shortest delta chain for that object or
> such)

This is a soft requirement. It is an easy thing to track at the moment. 
We can compute the MIDX without opening a packfile, for instance.

>
>> +- If there exist packfiles in the pack directory not registered in
>> +  the MIDX, then those packfiles are loaded into the `packed_git`
>> +  list and `packed_git_mru` cache.
> Not sure I understand the implications of this?
> Does that mean we first look at the multi index and if an object is not
> found, we'll search linearly through all packs that are not part of the
> MIDX? That would require the MIDX to be kepot up to date reasonably
> to be useful.

If you add a packfile to the pack directory, you can immediately start 
consuming it. You do not need to wait for the MIDX to be updated. The 
more asynchronous these auxiliary data structures (MIDX, commit-graph) 
can be, the better. This is in direct contrast to the reachability 
bitmap which is useless without its corresponding packfile.

>
>> +- The pack-indexes (.idx files) remain in the pack directory so we
>> +  can delete the MIDX file, set core.midx to false, or downgrade
>> +  without any loss of information.
> In the future will it be possible to have no .idx files and just have the .midx?
> (I guess that depends on the strategy of how to integrate new packs into
> the MIDX?)

This may be part of a future plan, but we need to know a user will never 
set pack.multiIndex to false if they deleted their IDX files.

>> +- The MIDX file format uses a chunk-based approach (similar to the
>> +  commit-graph file) that allows optional data to be added.
> ... or the index files v2 (or reftable files)? Sure, you are most familiar with
> commit-graph files, but others may find it easier to have some older
> file formats to relate to.

I specifically mean that we have a "table of contents" describing the 
list of chunks. IDX v2 relies on a fixed ordering of the tables, and the 
offsets are computed by consuming the last fanout value (number of 
objects). Also, I'm not sure how to add optional data (data that can 
safely be ignored by an earlier version of Git) to an IDX without 
incrementing the version.

>> +Future Work
>> +-----------
>> +
>> +- Add a 'verify' subcommand to the 'git midx' builtin to verify the
>> +  contents of the multi-pack-index file match the offsets listed in
>> +  the corresponding pack-indexes.
>> +
>> +- The multi-pack-index allows many packfiles, especially in a context
>> +  where repacking is expensive (such as a very large repo), or
>> +  unexpected maintenance time is unacceptable (such as a high-demand
>> +  build machine).
> Supposedly maintenance (git gc) can be run in the background without
> interfering with day-to-day life, how is the regeneration of commit graph
> or MIDX files impacting the work here?

Assuming infinite RAM and disk, then yes we could not interfere with 
daily life. A big problem we see is that users frequently don't have the 
disk space to store a second copy of their packfiles on disk, even if we 
could organize a new packfile in reasonable time.

The MIDX is only invalid when a packfile it references is deleted.

The commit-graph is never invalid, except if a commit is deleted by GC. 
But even in that case, how did we "see" the commit ID? As long as we 
don't access these commits, the commit-graph feature doesn't violate 
expectations and can be generated asynchronously with a GC and repack.

>
>>      However, the multi-pack-index needs to be rewritten
>> +  in full every time. We can extend the format to be incremental, so
>> +  writes are fast. By storing a small "tip" multi-pack-index that
>> +  points to large "base" MIDX files, we can keep writes fast while
>> +  still reducing the number of binary searches required for object
>> +  lookups.
> So we can have multiple MIDX files? How would that work? Would there
> be a chunk that refers to other MIDX files?

We can have an optional chunk that refers to a list of "base" MIDX 
files. We then load that full list into multiple 'midxed_git' structs, 
and iterate through the list. VSTS keeps this list to a maximum length 
of 3 (LARGE, Medium, tiny) and merging files as necessary.

>
>> +- The reachability bitmap is currently paired directly with a single
>> +  packfile, using the pack-order as the object order to hopefully
>> +  compress the bitmaps well using run-length encoding. This could be
>> +  extended to pair a reachability bitmap with a multi-pack-index. If
>> +  the multi-pack-index is extended to store a "stable object order"
>> +  (a function Order(hash) = integer that is constant for a given hash,
> This stable object order doesn't fly well with integrating new packs?

When you integrate new packs, the lexicographic order changes as the new 
objects are inserted into the list. However, if we track a separate 
integer value (order[obj]) associated with the object, and keep that 
constant, we can track a stable order for an object across multiple 
generations of MIDX files. New objects are assigned order values larger 
than the previous order values. We can select a "good" ordering of the 
new objects as we extend the list.

This requires a new chunk in the file format. It also helps to store the 
reverse-lookup lex[i] which provides the lexicographic position of the 
object 'obj' with stable-order order[obj] == i.

I'm being intentionally vague in this document to hint towards a 
valuable feature without giving robust details of something that may 
never get built. But, I do think this is one feature of the MIDX that 
would be of the most value for services that use Git as a server 
process, as it allows the reachability bitmap to be set to this stable 
order instead of a single pack order. This is speculation on my part, as 
I don't know how such servers are maintained in the background.

>
>> +  even as the multi-pack-index is updated) then a reachability bitmap
>> +  could point to a multi-pack-index and be updated independently.
>> +
>> +- Packfiles can be marked as "special" using empty files that share
>> +  the initial name but replace ".pack" with ".keep" or ".promisor".
>> +  We can add an optional chunk of data to the multi-pack-index that
>> +  records flags of information about the packfiles. This allows new
>> +  states, such as 'repacked' or 'redeltified', that can help with
>> +  pack maintenance in a multi-pack environment. It may also be
>> +  helpful to organize packfiles by object type (commit, tree, blob,
>> +  etc.) and use this metadata to help that maintenance.
>> +
>> +- The partial clone feature records special "promisor" packs that
>> +  may point to objects that are not stored locally, but available
>> +  on request to a server. The multi-pack-index does not currently
>> +  track these promisor packs.

