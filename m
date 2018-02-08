Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACAD1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBHVdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:33:25 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46970 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBHVdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:33:24 -0500
Received: by mail-qt0-f194.google.com with SMTP id u6so7672488qtg.13
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vQGHMtLmw2e7RvBbVIMr7GEYOJeNvrvwUqe3rQWknHU=;
        b=sf6XQ+iPLWTsbyET6Mcww5Q+1hshVCP56pveE7xG+6S0cyF9DTWDLv6epxVqHnoHWM
         ujy4QNw0/pyEuSNFMlG+5bxp3Cy67M7BjzmibSALlZW2KnD253r8WT2+az9ThusX7FUp
         dKoJF/u5Doks9LGepiiaDsbFQ+QqiVuc+xejf4NyIvQSsrZQrX9yWdh3/aCx8c3S6QOC
         M2GiivnoLIjtmPtqr1CT0puJqJHTuZWWK2fT8+N6jl5sc7xlZHyaOccqM2Q5HZvj8Hti
         NFOA0bZDoyVZFitNe9/Z9F3CKkYn7+cPomKr0QR87qaAynEN3IkVsQRLv4RvQFaBYz6D
         EuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vQGHMtLmw2e7RvBbVIMr7GEYOJeNvrvwUqe3rQWknHU=;
        b=grKYGcbM6/NmXFVE0LChaufrvjP7hhA07+anKnBeTmfh2LVeVFaurIXePDo56NJOpz
         PCfWX4jQ+IOjpFHKkzW04GkF4dyweS2I7sdSnbk/PR/P8mMHs7Hp1D3ypCncS3ig5mo7
         4telyRbeSeHsaJ69g9RVtIgqGi/TJcn8s6U016XLSJRWgexvyzqQYZv8GlPTN06dZi13
         QjoVdLPKyJIbjow9+h7Ir2ol83+WwclE/cX8YCSfAdR8/DsY7nQ56calnKXz//axzNew
         WNDlddFItzypuQh4unRlrj01bVQkTXKWGEhsIp9Bbxf4Uo4+DRrdOjPLwuBrzHW/9Iu3
         dicg==
X-Gm-Message-State: APf1xPCREtYtzfzwlmppWHipMXigNKkubw4l0/fEAb+gRa7Nf4hjpBOp
        cyy5/MYZuu/5BkcAMZlhKe6wbKAxGD8=
X-Google-Smtp-Source: AH8x225GZlD00jAZmYN+BjFZImbmZmYLNjChYVxiaALF8IbdujPnDXsqqDYI97avKr4x/Dmk0xx8gg==
X-Received: by 10.200.28.145 with SMTP id f17mr983426qtl.15.1518125603110;
        Thu, 08 Feb 2018 13:33:23 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m190sm643049qke.7.2018.02.08.13.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 13:33:22 -0800 (PST)
Subject: Re: [PATCH v3 01/14] commit-graph: add format document
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-2-git-send-email-dstolee@microsoft.com>
 <xmqq8tc3qitf.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <68287af0-a4ec-d2ab-bbcc-84326871120b@gmail.com>
Date:   Thu, 8 Feb 2018 16:33:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tc3qitf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2018 4:21 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Add document specifying the binary format for commit graphs. This
>> format allows for:
>>
>> * New versions.
>> * New hash functions and hash lengths.
> It still is unclear, at least to me, why OID and OID length are
> stored as if they can be independent.  If a reader does not
> understand a new Object Id hash, is there anything the reader can
> still do by knowing how long the hash (which it cannot recompute to
> validate) is?  And if a reader does know what OID hashing scheme is
> used to refer to the objects, it certainly would know how long the
> OIDs are.
>
> Giving length may make sense only when a reader can treat these OIDs
> as completely opaque identifiers, without having to (re)hash from
> the contents, but if that is the case, then there is no point saying
> what exact hash function is used to compute OID.
>
> So I'd understand storing only either one or the other, but not
> both.  Am I missing something?

You're right that this data is redundant. It is easy to describe the 
width of the tables using the OID length, so it is convenient to have 
that part of the format. Also, it is good to have 4-byte alignment here, 
so we are not wasting space.

There isn't a strong reason to put that here, but I don't have a great 
reason to remove it, either.

Perhaps leave a byte blank for possible future use?

>
>> +The Git commit graph stores a list of commit OIDs and some associated
>> +metadata, including:
>> +
>> +- The generation number of the commit. Commits with no parents have
>> +  generation number 1; commits with parents have generation number
>> +  one more than the maximum generation number of its parents. We
>> +  reserve zero as special, and can be used to mark a generation
>> +  number invalid or as "not computed".
> This "most natural" definition of generation number is stricter than
> absolutely necessary (a looser definition that is sufficient is
> "gennum of a child is larger than all of its parents'").  While I
> personally think that is OK, some people who floated different ideas
> in previous discussions on generation numbers may want to articulate
> their ideas again.  One idea that I found clever was to use the
> total number of commits that are ancestors of a commit instead (it
> is far more expensive to compute than the most natural gennum, but
> doing so may help other topology math, like "describe").

It is more difficult to compute the number of reachable commits, since 
you cannot learn that only by looking at the parents (you need to know 
how many commits are in the intersection of their reachable sets for a 
two-parent merge, or just walk all of the commits). This leads to a 
quadratic computation to discover the value for N commits.

I define it this rigidly now because I will submit a patch soon after 
this one lands that computes generation numbers and consumes them in 
paint_down_to_common(). I've got it sitting in my local repo ready for a 
rebase.

>
>> +CHUNK LOOKUP:
>> +
>> +  (C + 1) * 12 bytes listing the table of contents for the chunks:
>> +      First 4 bytes describe chunk id. Value 0 is a terminating label.
>> +      Other 8 bytes provide offset in current file for chunk to start.
>> +      (Chunks are ordered contiguously in the file, so you can infer
>> +      the length using the next chunk position if necessary.)
> Aren't chunks numbered contiguously, starting from #1, thereby
> making it unnecessary to store the 4-byte?
>
> How does a reader obtain the length of the last chunk?  Ahh, that is
> why there are C+1 entries in this table, not just C, so that the
> reader knows where to stop while reading the last one.  Does that
> mean that this table looks like this?
>     
>      { 1, offset_1 },
>      { 2, offset_2 },
>      ...
>      { C, offset_C },
>      { 0, offset_C+1 },
>
> where where (offset_N+1 - offset_N) gives the length of chunk #N?

This is correct.

>
>> +  The remaining data in the body is described one chunk at a time, and
>> +  these chunks may be given in any order. Chunks are required unless
>> +  otherwise specified.
>> +
>> +CHUNK DATA:
>> +
>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>> +      The ith entry, F[i], stores the number of OIDs with first
>> +      byte at most i. Thus F[255] stores the total
>> +      number of commits (N).
>> +
>> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>> +      The OIDs for all commits in the graph, sorted in ascending order.
>> +
>> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
>> +    * The first H bytes are for the OID of the root tree.
>> +    * The next 8 bytes are for the int-ids of the first two parents
>> +      of the ith commit. Stores value 0xffffffff if no parent in that
>> +      position. If there are more than two parents, the second value
>> +      has its most-significant bit on and the other bits store an array
>> +      position into the Large Edge List chunk.
>> +    * The next 8 bytes store the generation number of the commit and
>> +      the commit time in seconds since EPOCH. The generation number
>> +      uses the higher 30 bits of the first 4 bytes, while the commit
>> +      time uses the 32 bits of the second 4 bytes, along with the lowest
>> +      2 bits of the lowest byte, storing the 33rd and 34th bit of the
>> +      commit time.
>> +
>> +  Large Edge List (ID: {'E', 'D', 'G', 'E'})
>> +      This list of 4-byte values store the second through nth parents for
>> +      all octopus merges. The second parent value in the commit data stores
>> +      an array position within this list along with the most-significant bit
>> +      on. Starting at that array position, iterate through this list of int-ids
>> +      for the parents until reaching a value with the most-significant bit on.
>> +      The other bits correspond to the int-id of the last parent. This chunk
>> +      should always be present, but may be empty.
> I am not convinced about the value of these 4-byte section IDs.
>
> They are useless unless you define what should happen when a reader
> sees a block of data with an unknown ID; presence of these IDs given
> an impression that you allow a reimplementation to reorder the
> sections unnecessarily, especially when all of these are required
> anyway, making the canonical reader implementation unnecessarily
> complex, no?
>

One reason to have chunks is to be simple: we have a clear table of 
contents at the beginning of the file and can immediately navigate to 
portions of the file we care about. The chunk order also doesn't matter 
for the purpose of the format.

The true value they present is flexibility: We can extend the v1 format 
to include extra metadata in a chunk and insert it anywhere in the 
format. If there is some extra information that would be beneficial for 
graphs (say, a de-duplicated author list) then we could extend the 
format to be v1-compatible.

BUT: I do notice now that load_commit_graph_one() will die() if seeing a 
chunk id it doesn't recognize, so that should be fixed if we keep this 
chunk model. We should be able to read "v1.1" files if they have extra 
chunks (but ignore that data).

Thanks,
-Stolee
