Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465AE1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeAZNWn (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:22:43 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40199 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeAZNWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:22:40 -0500
Received: by mail-qt0-f169.google.com with SMTP id s39so1154527qth.7
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kOHXtOGYoYjBSc4Ybys9sN84+yIBegpTIrSfcbudE9c=;
        b=idlxCgQqVLVABGFeBimtocGqiNiRQELPRavdHfyegu+V3Nu4ref9YzVTelIaj5es4F
         spF0VeVzNyohxrYW6Sjivvq/hZ46w5UJc+yBVMDzWymCfiNlZHNMki8jFhR82z5EhESh
         FFO6/bdvnhsHgOFcMwuYixYqf5fXssrAAPJNTf2dAqLUTJpfhdfEJjcmJv2CjZcnD6V7
         psoM5fb+SYc6mfIyUvFVBU3mjXPkYobCgWcxfhJ0GjnNuPa6Hux+8nBCGyQ+GMyes211
         +FE33reBI3GzeTVmo0eWaN5nzktnbJ4+gu0U1w5/tu9dq3FeRi6ilHUOoMk9ck7QD2Zk
         F6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kOHXtOGYoYjBSc4Ybys9sN84+yIBegpTIrSfcbudE9c=;
        b=Nj5AcAxswX1Zg7JQF3WT5RqUpS9TBUbiFPIMdqrwDuT4TvE8blNfV4Xk4TWMj3zlzt
         Yrxwn8nq6d2/l62DeJrDa/glNKaFnxFC9OD7eoM9L4x0/7txikFAF3+0zcYsdAzHJqtm
         xoS3JDU13ShM0Hf1eoPCoeWvm2+ppbYB2oUeaX6FoCfn71/IqhES66k/2SzPhY3uuJsc
         nt8AisAVDHyGfE+dnlnZH8gGemSmC+ZrZ5JCvnftc786GvSxEoK7O+7JLuJEAj7WBCmq
         wX7K8VRpsVaV+RYnP98gqErn5XUwfdSx/Y7ZhrSxvro1qP3Yl3w158MEbm5TpilxZUEk
         XevA==
X-Gm-Message-State: AKwxyte3v7ov+m5fxJonK2QGzl1p6KIo6dFt+YD27n/wxsLkv0mRHxsf
        4rnEQ5qYVwQBpaG3v4zaDmM=
X-Google-Smtp-Source: AH8x224fr0jjika+gY83CVgqT+hsHLoSQ0OM3ande253c3mnP8A+AL9uvs4zuSW1LFvf+wO1QogfjQ==
X-Received: by 10.237.58.226 with SMTP id o89mr23515644qte.207.1516972959771;
        Fri, 26 Jan 2018 05:22:39 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v45sm5562928qtc.45.2018.01.26.05.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:22:39 -0800 (PST)
Subject: Re: [PATCH 04/14] packed-graph: add format document
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-5-dstolee@microsoft.com>
 <xmqqr2qd8ug8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkhCmmF9hPRaf7RygDuWJd3edMDiAki8CDTJw3xG6BCg@mail.gmail.com>
 <xmqqmv118tde.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c6ccbd6f-ef97-3240-7cdc-6ef7a3f95cf6@gmail.com>
Date:   Fri, 26 Jan 2018 08:22:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqmv118tde.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 5:06 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
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
> Good that this is not saying "graph format" but is explicit that it
> is about "commit".  Do the same for the previous steps.  Especially,
> builtin/graph.c that does not have much to do with graph.c is not a
> good way forward ;-)

:+1:

> I do like the fact that later parents of octopus merges are moved
> out of way to make the majority of records fixed length, but I am
> not sure if the "up to two parents are recorded in line" is truly
> the best arrangement.  Aren't majority of commits single-parent,
> thereby wasting 4 bytes almost always?
>
> Will 32-bit stay to be enough for everybody?  Wouldn't it make sense
> to at least define them to be indices into arrays (i.e. scaled to
> element size), not "offsets", to recover a few lost bits?

I incorrectly used the word "offset" when I mean "array position" for 
the edge values.

> What's the point of storing object id length?  If you do not
> understand the object ID scheme, knowing only the length would not
> do you much good anyway, no?  And if you know the hashing scheme
> specified by Object ID version, you already know the length, no?

I'll go read the OID transition document to learn more, but I didn't 
know if there were plans for things like "Use SHA3 but with different 
hash lengths depending on user requirements". One side benefit is that 
we immediately know the width of our commit and tree references within 
the commit graph file without needing to consult a table of hash 
definitions.


On 1/25/2018 5:18 PM, Stefan Beller wrote:
> git.git has ~37k non-merge commits and ~12k merge commits,
> (35 of them have 3 or more parents).
>
> So 75% would waste the 4 bytes of the second parent.
>
> However the first parent is still there, so any operation that only needs
> the first parent (git bisect --first-parent?) would still be fast.
> Not sure if that is common.

The current API boundary does not support this, as parse_commit_gently() 
is not aware of the --first-parent option. The benefits of injecting 
that information are probably not worth the complication.

On 1/25/2018 5:29 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The downside of just having one parent or pointer into the edge list
>> would be to penalize 25% of the commit lookups with an indirection
>> compared to ~0% (the 35 octopus'). I'd rather want to optimize for
>> speed than disk size? (4 bytes for 37k is 145kB for git.git, which I
>> find is not a lot).
> My comment is not about disk size but is about the size of working
> set (or "size of array element").
I do want to optimize for speed over space, at least for two-parent 
commits. Hopefully my clarification about offset/array position 
clarifies Junio's concerns here.

Thanks,
-Stolee

