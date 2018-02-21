Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4ED1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeBUTpR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:45:17 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35588 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUTpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:45:16 -0500
Received: by mail-qk0-f170.google.com with SMTP id s188so3521577qkb.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+g5Kb1mPKJkSiwD/YK7Y3kxfToOW4AuN0cwbcYKzKTE=;
        b=fk2VL5RJk+E1wWuQ0z8sxtjfvknLbN4i+Wt8mwgXAEwv7zpkZYQS+8tSFaPU83NFbw
         TuwCPlZwIu7VFNKSmMjn+0b/5y7/v0Jln5i11aI8rZtzM4wWpgGJQ3NnOz1fX/hoFfya
         A7igu79H8PvNMgVOxJG4+psS9R+z/03nmnN1voeDax31jkOOcu5ivoF+nLjesKwBwN7/
         oqMBn56nEHroBZ7YWmM9b/ghJuPf7feCBhN8wnQ92XbQK3/+eujSw3RvkP6m3d+7uMzj
         /biymGyZobfohulMSUCdeKFeNx/uU6Q1qncTf7S7oBPXRLryJ1FaZmjvaW5AqxzEcMTq
         JSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+g5Kb1mPKJkSiwD/YK7Y3kxfToOW4AuN0cwbcYKzKTE=;
        b=rvy+Li7PqtCRRUC/vAwBOHeD9DJ5lFKGd1MeFGAXtA/m9zZ31we9Yt6kMgbFYGJ7Gt
         RNWyjc0UJG0YKQu8udghlhWiSDH+8932gF7ZACRrNz6XU2LNUtmSHJMvmRTDJyZJ9Ajb
         A+LiaIK7RROSjss73WDUuSbDPHC/Qod9wv2XESG+36Knt1ohqdRxRW56ZrfD087DCUPT
         H253ucgwYailswdkEL/7fWYhKD3VInbB9MG1qJfzneVL3InjdOhXWH5C8xegep5IYZe/
         4Z8pqq4oyqoIv4CTPFEMBQMPoe3W5kWKP/UY03Mk6drf2tCLHSmBkMUOGOY1eQ+MjnGE
         g7Hg==
X-Gm-Message-State: APf1xPAHKmLnYsdTu77bA0UqsEgLPzGFtxGoIRkwcnk98Knl6IYpSiuW
        9aBZOeyvx0y6I+f2Y1XvETqivo6Obj0=
X-Google-Smtp-Source: AG47ELtn6kJ538ThiGOqVgmY65ne3lBYFfaIaOrAnyr0D/cYH/esDXSLh9Ck4J4SrhAL61oCFPvYqg==
X-Received: by 10.233.237.145 with SMTP id c139mr7076570qkg.78.1519242315280;
        Wed, 21 Feb 2018 11:45:15 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v1sm8400910qtg.43.2018.02.21.11.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 11:45:14 -0800 (PST)
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
 <CAGZ79kawTtSzVV2=sNn_OFsmCbcLGhVi1pt4bVrOYfZA28E+6Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fa9754a6-2cc9-5b2e-5d53-e8acfe3a1113@gmail.com>
Date:   Wed, 21 Feb 2018 14:45:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kawTtSzVV2=sNn_OFsmCbcLGhVi1pt4bVrOYfZA28E+6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 2:23 PM, Stefan Beller wrote:
> On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> +In order to allow extensions that add extra data to the graph, we organize
>> +the body into "chunks" and provide a binary lookup table at the beginning
>> +of the body. The header includes certain values, such as number of chunks,
>> +hash lengths and types.
>> +
>> +All 4-byte numbers are in network order.
>> +
>> +HEADER:
>> +
>> +  4-byte signature:
>> +      The signature is: {'C', 'G', 'P', 'H'}
>> +
>> +  1-byte version number:
>> +      Currently, the only valid version is 1.
>> +
>> +  1-byte Object Id Version (1 = SHA-1)
>> +
>> +  1-byte number (C) of "chunks"
>> +
>> +  1-byte (reserved for later use)
> What should clients of today do with it?
> * ignore it completely [as they have no idea what it is] or
> * throw hands up in the air if it is anything other than 0 ?
>    [because clearly we will increment the version
>     or have new information in a new chunk instead of just sneaking
>     in information here?]

They should ignore it completely, which will allow using the value for 
something meaningful later without causing a version change (which we DO 
die() for). A user could downgrade from a version that uses this byte 
for something meaningful and not require a new commit-graph file.

The "commit-graph read" subcommand does output this byte, so we can 
verify that the "write" subcommand places a 0 in this position.

>
>> +CHUNK LOOKUP:
>> +
>> +  (C + 1) * 12 bytes listing the table of contents for the chunks:
>> +      First 4 bytes describe chunk id. Value 0 is a terminating label.
>> +      Other 8 bytes provide offset in current file for chunk to start.
> offset [in bytes? I could imagine having a larger granularity here,
> because chunks don't sound small.]

It is good to specify "offset in bytes".

>
>> +      (Chunks are ordered contiguously in the file, so you can infer
>> +      the length using the next chunk position if necessary.)
>> +
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
> [ so in small repos, where there are fewer than 256 objects,
> F[i] == F[i+1], for all i'th where there is no object starting with i byte]

Correct. I'm not sure this additional information is valuable for the 
document, though.

>
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
>> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>> +      This list of 4-byte values store the second through nth parents for
>> +      all octopus merges. The second parent value in the commit data stores
>> +      an array position within this list along with the most-significant bit
>> +      on. Starting at that array position, iterate through this list of int-ids
>> +      for the parents until reaching a value with the most-significant bit on.
>> +      The other bits correspond to the int-id of the last parent.
>> +
>> +TRAILER:
>> +
>> +       H-byte HASH-checksum of all of the above.
>> +
>> --
>> 2.7.4
> Makes sense so far, I'll read on.
> I agree with Junio, that I could read this documentation without
> the urge to point out nits. :)
>
> Thanks,
> Stefan

