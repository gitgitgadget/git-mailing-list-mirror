Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AA61F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeAZNZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:25:15 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:47051 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbeAZNZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:25:13 -0500
Received: by mail-qt0-f176.google.com with SMTP id o35so1133491qtj.13
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XRIvSmLdhiY6w5Rpbwlk5TQ5DBLSIjdNtEpvk0Zb07U=;
        b=Yx0zElcorERs83nG8z3uftgtp3MEeTY7RBg5wGkxpx4zUZeJ6WPPhAu0lrjj2S13Zy
         4DODIc/iPFy6OeZrK8S8e4HzZyJv6mAAIhRPOh9XVK85WaWBhdkJNy73ithpUDz/V4sZ
         Y/F9EHADynHJyAppygs8yTX8ncNk/3XVvkT8l5G6cpT/Zh3ui11qSZuFkpT1V8fDjJN7
         LM61ldl4HBth7P2JxTpjakHqrJa0DG9skWSFSDktxoZuEk9rZ9qRYnl/q6NhJPQLbCUO
         wCFsXNWWtM+2wsupTJ+up45ldoaYCl1EyTpEUxzt6rVKf0C9hSbV7F6CQNmsmSAlJJRN
         n6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XRIvSmLdhiY6w5Rpbwlk5TQ5DBLSIjdNtEpvk0Zb07U=;
        b=Jk9B1gn+USpp1uVEjofHgJM5uxsIW65oxOF1O1VME0sAwtSNbQHNEeGfvnB3RwUzZz
         FblFnRfnZwJm8I4anNiz1WE1JdCahUwss336Tu1hb9Q+5iSz/n+YAVBuGbtz2Lf8ErJ/
         rcDOIEBEqPfXp+fcvqSLuFZ4EJYY1P/cQa1G8xFBS2AcUf5If++h6b9uoelON1uHR3dq
         9/rmpFHGQSHuEnT6hBryFGc0RGJYAEvaQq/8pp7fpOgABxuG1z0Aa6f7rBK8B10/Hj4p
         WrvpL1qjd9BTI7Ko33dBfbYCLFqOzmdd1uNDgW3IP4loyg5bR0prVnMkRiBa5+Mlz3gf
         F/2w==
X-Gm-Message-State: AKwxytfZiKdtjn9Rck7ZGuSkyY7s7xy1nmGQ7q4DHg/7eXXUx8pd6wgs
        RT+KcM0osJXrMdwIV9HM7z8=
X-Google-Smtp-Source: AH8x224OFQVqnWDG4CEvRmQmYm7wzTjUwVpYj3UM5FRrHPeMKqqzt83/gzzUfiaV1OvU1kmGWKzOig==
X-Received: by 10.200.5.11 with SMTP id u11mr6759557qtg.196.1516973112787;
        Fri, 26 Jan 2018 05:25:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f129sm3345272qke.82.2018.01.26.05.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:25:12 -0800 (PST)
Subject: Re: [PATCH 04/14] packed-graph: add format document
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-5-dstolee@microsoft.com>
 <CAGZ79kap0bdpcHqLM128mc_f2aEoemRJSFUNpU2xvegtOMcTkg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5d70ca39-e844-3565-42ed-c09cb1529d34@gmail.com>
Date:   Fri, 26 Jan 2018 08:25:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kap0bdpcHqLM128mc_f2aEoemRJSFUNpU2xvegtOMcTkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 5:07 PM, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> Add document specifying the binary format for packed graphs. This
>> format allows for:
>>
>> * New versions.
>> * New hash functions and hash lengths.
>> * Optional extensions.
>>
>> Basic header information is followed by a binary table of contents
>> into "chunks" that include:
>>
>> * An ordered list of commit object IDs.
>> * A 256-entry fanout into that list of OIDs.
>> * A list of metadata for the commits.
>> * A list of "large edges" to enable octopus merges.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/graph-format.txt | 88 ++++++++++++++++++++++++++++++++
> So this is different from Documentation/technical/packed-graph.txt,
> which gives high level design and this gives the details on how
> to set bits.
>
>>   1 file changed, 88 insertions(+)
>>   create mode 100644 Documentation/technical/graph-format.txt
>>
>> diff --git a/Documentation/technical/graph-format.txt b/Documentation/technical/graph-format.txt
>> new file mode 100644
>> index 0000000000..a15e1036d7
>> --- /dev/null
>> +++ b/Documentation/technical/graph-format.txt
>> @@ -0,0 +1,88 @@
>> +Git commit graph format
>> +=======================
>> +
>> +The Git commit graph stores a list of commit OIDs and some associated
>> +metadata, including:
>> +
>> +- The generation number of the commit. Commits with no parents have
>> +  generation number 1; commits with parents have generation number
>> +  one more than the maximum generation number of its parents. We
>> +  reserve zero as special, and can be used to mark a generation
>> +  number invalid or as "not computed".
>> +
>> +- The root tree OID.
>> +
>> +- The commit date.
>> +
>> +- The parents of the commit, stored using positional references within
>> +  the graph file.
>> +
>> +== graph-*.graph files have the following format:
>> +
>> +In order to allow extensions that add extra data to the graph, we organize
>> +the body into "chunks" and provide a binary lookup table at the beginning
>> +of the body. The header includes certain values, such as number of chunks,
>> +hash lengths and types.
>> +
>> +All 4-byte numbers are in network order.
>> +
>> +HEADER:
>> +
>> +       4-byte signature:
>> +           The signature is: {'C', 'G', 'P', 'H'}
>> +
>> +       1-byte version number:
>> +           Currently, the only valid version is 1.
>> +
>> +       1-byte Object Id Version (1 = SHA-1)
>> +
>> +       1-byte Object Id Length (H)
>    This is 20 or 40 for sha1 ? (binary or text representation?)

20 for binary.

>
>> +       1-byte number (C) of "chunks"
>> +
>> +CHUNK LOOKUP:
>> +
>> +       (C + 1) * 12 bytes listing the table of contents for the chunks:
>> +           First 4 bytes describe chunk id. Value 0 is a terminating label.
>> +           Other 8 bytes provide offset in current file for chunk to start.
> ... offset [in bytes/words/4k blocks?] in ...

bytes.

>
>> +           (Chunks are ordered contiguously in the file, so you can infer
>> +               the length using the next chunk position if necessary.)
>> +
>> +       The remaining data in the body is described one chunk at a time, and
>> +       these chunks may be given in any order. Chunks are required unless
>> +       otherwise specified.
>> +
>> +CHUNK DATA:
>> +
>> +       OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>> +           The ith entry, F[i], stores the number of OIDs with first
>> +           byte at most i. Thus F[255] stores the total
>> +           number of commits (N).
> So F[0] > 0 for git.git for example.
>
> Or another way: To lookup a 01xxx, I need to look at
> entry(F[00] + 1 )...entry(F[01]).
>
> Makes sense.
>
>> +
>> +       OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>> +           The OIDs for all commits in the graph.
> ... sorted ascending.
>
>
>> +       Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
>> +           * The first H bytes are for the OID of the root tree.
>> +           * The next 8 bytes are for the int-ids of the first two parents of
>> +             the ith commit. Stores value 0xffffffff if no parent in that position.
>> +             If there are more than two parents, the second value has its most-
>> +             significant bit on and the other bits store an offset into the Large
>> +             Edge List chunk.
> s/an offset into/position in/ ? (otherwise offset in bytes?)
>
>> +           * The next 8 bytes store the generation number of the commit and the
>> +             commit time in seconds since EPOCH. The generation number uses the
>> +             higher 30 bits of the first 4 bytes, while the commit time uses the
>> +             32 bits of the second 4 bytes, along with the lowest 2 bits of the
>> +             lowest byte, storing the 33rd and 34th bit of the commit time.
> This allows for a maximum generation number of
> 1.073.741.823 (2^30 -1) = 1 billion,
> and a max time stamp of later than 2100.
>
> Do you allow negative time stamps?
>
>
>> +
>> +       [Optional] Large Edge List (ID: {'E', 'D', 'G', 'E'})
>> +           This list of 4-byte values store the second through nth parents for
>> +           all octoput merges. The second parent value in the commit data is a
> octopus
>
>> +           negative number pointing into this list. Then iterate through this
>> +           list starting at that position until reaching a value with the most-
>> +           significant bit on. The other bits correspond to the int-id of the
>> +           last parent.
>> +
>> +TRAILER:
>> +
>> +       H-byte HASH-checksum of all of the above.
>> --
>> 2.16.0
>>

Thanks for the detailed comments here!
-Stolee


