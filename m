Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27741F403
	for <e@80x24.org>; Mon,  4 Jun 2018 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeFDNJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 09:09:03 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43958 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeFDNJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 09:09:02 -0400
Received: by mail-qt0-f178.google.com with SMTP id y89-v6so14888731qtd.10
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tlyoiWu/3ZWKn0WHNP9eSRJUGKo55Mk/HYaNlHBbiLY=;
        b=ltC77mT8eyuVQD+E9QEia9yf5tZt4xMYdlp+como9suGLBY1FScVk0cFlsHWq4qGj0
         vsySvAXv5yoi1+KulVsga37yooEvUtU0bU77ssYYohlkiH2pZctyHyFtN1oEMRCRhEIt
         MuQZLOZ1t6szzFQqpdfksFw2iM3c/e/M3RJOiSvwJzLCwVS5qmEcof/nlfLwqMK7lThA
         b87S/MABFssmVMr7uxa8i1vr8SE+XDuxLYT3WhecW+0DyffzFl5VgMgQhD+EiDNRD2Uy
         uy+G5mLQjwjbs1T83uhbg/DTUff2hiSX9b82l9kz7GAHajolkVnDOKCbRbdf+iup++Tj
         F3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tlyoiWu/3ZWKn0WHNP9eSRJUGKo55Mk/HYaNlHBbiLY=;
        b=oqzzcz+4GafGqum5E2IpiFTiQ4lOp6qa5bx21K1gEKo2HNG7riSzICYdgHWwtsJbTd
         QJb46MedDwr1n96yLt5XgN+OFjm5BaNGOXPKGEW9VUQnXq33kQA3wLAa/xba80FFpfBA
         d7iImOJHKVp27TjunvR/UzZurbMSoVZDQU/dwdPuogT4WkA8upEpt4J9wly100C9Na0U
         OpbleOcqxgxST2yNvv0ZMr9GDDHDm6Oaqi6eL6sfrLLKNYiPKk4D7bbU9o9O2glx7ym0
         fJpYRa0sQPrgeA14zSkvXh/EJwmMcciW/cAxAjGl2Wyf2U1JxULMjaZxRNCm6TuUg4F0
         K9JQ==
X-Gm-Message-State: APt69E3OTTooDx+HJCjiXd+qXKbL8gCvhiseqcCzG+b+KsqOmvr+GvsD
        FerNzeat7pnIoTS0fx8Nz3Y=
X-Google-Smtp-Source: ADUXVKKvvoGJZJA2J9EL0JoJ6x6mpXeYL+RiU7y1U1q2a75D/0jCT3e6sjk8ydS/kUIBkVdAuCPGXw==
X-Received: by 2002:a0c:ca12:: with SMTP id c18-v6mr19954485qvk.62.1528117741605;
        Mon, 04 Jun 2018 06:09:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6990:e1e1:697d:a15? ([2001:4898:8010:0:52c6:e1e1:697d:a15])
        by smtp.gmail.com with ESMTPSA id o10-v6sm222136qkl.94.2018.06.04.06.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 06:09:00 -0700 (PDT)
Subject: Re: [PATCH v3 15/20] commit-graph: test for corrupted octopus edge
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-16-dstolee@microsoft.com> <86tvqltla9.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7665886b-1343-ca9d-aa41-db7a5b7d2735@gmail.com>
Date:   Mon, 4 Jun 2018 09:08:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86tvqltla9.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 8:39 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The commit-graph file has an extra chunk to store the parent int-ids for
>> parents beyond the first parent for octopus merges. Our test repo has a
>> single octopus merge that we can manipulate to demonstrate the 'verify'
>> subcommand detects incorrect values in that chunk.
> If I understand it correctly the above means that our _reading_ code
> checks for validity (which then 'git commit-graph verify' uses), just
> there were not any tests for that.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   t/t5318-commit-graph.sh | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 58adb8246d..240aef6add 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
>>   '
>>   
>>   NUM_COMMITS=9
>> +NUM_OCTOPUS_EDGES=2
>>   HASH_LEN=20
>>   GRAPH_BYTE_VERSION=4
>>   GRAPH_BYTE_HASH=5
>> @@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
>>   GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
>>   GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 8`
>>   GRAPH_BYTE_COMMIT_DATE=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
>> +GRAPH_COMMIT_DATA_WIDTH=`expr $HASH_LEN + 16`
>> +GRAPH_OCTOPUS_DATA_OFFSET=`expr $GRAPH_COMMIT_DATA_OFFSET + \
>> +				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
>> +GRAPH_BYTE_OCTOPUS=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -378,4 +383,9 @@ test_expect_success 'detect incorrect commit date' '
>>   		"commit date"
>>   '
>>   
>> +test_expect_success 'detect incorrect parent for octopus merge' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
>> +		"invalid parent"
>> +'
> So we change the int-id to non-existing commit, and check that
> commit-graph code checks for that.
>
> What about the case when there are octopus merges, but no EDGE chunk
> (which I think we can emulate by changing / corrupting number of
> chunks)?
>
> What about the case where int-id of edge in EDGE chunk is correct, that
> is points to a valid commit, but does not agree with what is in the
> object database (what parents octopus merge has in reality)?
>
> Do we detect the situation where the second parent value in the commit
> data stores an array position within a Large Edge chunk, but we do not
> reach a value with the most-significant bit on when reaching the end of
> Large Edge chunk?

There are a few holes like this, but I think they are better suited to a 
follow-up series, as this series is already quite large.

-Stolee
