Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42531F404
	for <e@80x24.org>; Mon,  2 Apr 2018 13:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbeDBNJd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 09:09:33 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45735 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeDBNJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 09:09:32 -0400
Received: by mail-qt0-f175.google.com with SMTP id f8so15410857qtg.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3dThsWagHwSbm5chr9vRRETGuSuQ0AqZHaG8jB08eyQ=;
        b=a1lcmutZtrArc4YOmB07bV4wBq1yHLn+GlMjTZSt6bKxYP+5W+e949A4PkMsDHN6kd
         1/lwMARpZQ5wOXDS7yI+4c36ynPNGw64RMWKEJpG4tbaqZgh/RnM5sAoTiUaSKkqM5gM
         19SEwB6E6ik/sbtwhpAAo+h6QrZkiCq/4iO3FNJPNwt/WMVXy2CUiUpbnDfRqqiRuYg6
         rfsOXXL7SPjREEWUd0xtKc4+38ypCaX42lXeyA2jZmrEGTuXu+DcEUy2HgIdJ+UYhHDt
         AuDK/EbZYFtEIRCUE+g36TvMgtOUKF0nQKqOaCnLHjBqwk2Y3OOh4e7Oa0GU2iO8hUa7
         IhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3dThsWagHwSbm5chr9vRRETGuSuQ0AqZHaG8jB08eyQ=;
        b=nBB+Rhdn8KNYog2MyAZo40NPk4JUqxs6Uh+yRqmCheFv9qzZAdmB4+37d6LRCXAhlO
         8239fYM1qvu7jsKZ4LfqWIjAEB9a3onOh2tyO1bpCT3qIled5bRRk6oqLQEWXWEDrUGp
         n2Q32d4iA9TO9OSb4lHxqhwOXo3ZxjpW1Iz/PLqkvDU64DDcS1VJvOpfNp/dIn4nZfvp
         /UlPLSa/psy589xuz8R/0EqD1QhO7k1cs5QMGDXFgtk1ibUkEBjS/jYMxVHx8DDjvHD1
         /5OmoEUI3BH3DAhj/hdJldv040hV7ldRQICKbj6AgY8uPAiR3JYtMyUNURESv9KZ9jAm
         NiVw==
X-Gm-Message-State: ALQs6tAgoNTQJQDOl9XisFDOIj4+RISOGulaXB04JxmjtT0A4IXKCLkQ
        B+9jd7CXWcAzhC8gRqejP+M=
X-Google-Smtp-Source: AIpwx4+Owzj5vJXsa61NQByHmkJMmNJEiuIMOWjlwXcnJM2s8cViELFAuKBxPjqO8cWK7xoD6SuqUg==
X-Received: by 10.200.2.153 with SMTP id p25mr14307699qtg.229.1522674571468;
        Mon, 02 Apr 2018 06:09:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n30sm276353qtb.93.2018.04.02.06.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 06:09:30 -0700 (PDT)
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
 <86370hk84x.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <433a2523-d04a-08bb-d128-6c8e578916fa@gmail.com>
Date:   Mon, 2 Apr 2018 09:09:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <86370hk84x.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2018 9:25 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +== graph-*.graph files have the following format:
> What is this '*' here?

No longer necessary. It used to be a placeholder for a hash value, but 
now the graph is stored in objects/info/commit-graph.

>
> [...]
>> +  The remaining data in the body is described one chunk at a time, and
>> +  these chunks may be given in any order. Chunks are required unless
>> +  otherwise specified.
> Does Git need to understand all chunks, or could there be optional
> chunks that can be safely ignored (like in PNG format)?  Though this may
> be overkill, and could be left for later revision of the format if
> deemed necessary.

In v6, the format and design documents are edited to make clear the use 
of optional chunks, specifically for future extension without increasing 
the version number.

>
>> +
>> +CHUNK DATA:
>> +
>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>> +      The ith entry, F[i], stores the number of OIDs with first
>> +      byte at most i. Thus F[255] stores the total
>> +      number of commits (N).
> All right, it is small enough that can be required even for a very small
> number of commits.
>
>> +
>> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>> +      The OIDs for all commits in the graph, sorted in ascending order.
>> +
>> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> Do commits need to be put here in the ascending order of OIDs?

Yes.

> If so, this would mean that it is not possible to add information about
> new commits by only appending data and maybe overwriting some fields, I
> think.  You would need to do full rewrite to insert new commit in
> appropriate place.

That is the idea. This file is not updated with every new commit, but 
instead will be updated on some scheduled cleanup events. The 
commit-graph file is designed in a way to be non-critical, and not tied 
to the packfile layout. This allows flexibility for when to do the write.

For example, in GVFS, we will write a new commit-graph when there are 
new daily prefetch packs.

This could also integrate with 'gc' and 'repack' so whenever they are 
triggered the commit-graph is written as well.

Commits that do not exist in the commit-graph file will load from the 
object database as normal (after a failed lookup in the commit-graph file).

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
>> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>> +      This list of 4-byte values store the second through nth parents for
>> +      all octopus merges. The second parent value in the commit data stores
>> +      an array position within this list along with the most-significant bit
>> +      on. Starting at that array position, iterate through this list of int-ids
>> +      for the parents until reaching a value with the most-significant bit on.
>> +      The other bits correspond to the int-id of the last parent.
> All right, that is one chunk that cannot use fixed-length records; this
> shouldn't matter much, as we iterate only up to the number of parents
> less two.

Less one: the second "parent" column of the commit data chunk is used to 
point into this list, so (P-1) parents are in this chunk for a commit 
with P parents.

> A question: what happens to the last list of parents?  Is there a
> guardian value of 0xffffffff at last place?

The termination condition is in the position of the last parent, since 
the most-significant bit is on. The other 31 bits contain the int-id of 
the parent.

Thanks,
-Stolee

