Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBFB1F42D
	for <e@80x24.org>; Thu, 31 May 2018 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbeEaMxm (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:53:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36369 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbeEaMxi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:53:38 -0400
Received: by mail-qt0-f196.google.com with SMTP id q6-v6so27677899qtn.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u+ATtWAVEss1BpDy2E5eDZz+/D379066b/yyiKDVhuQ=;
        b=nCo1tVpFUlDeFg47Vc53mmOQ8T0okOnoqJKWOCSqcs0CEwHihwexLrB0AKKWf7e19m
         GaBLfqb765kwjCODKvKs/i1KjDgEKkuFdW8mvB5GlxFFyxWHR3qogqxwwsCxHWQYLBMe
         9DBAqhuiRJOcHtCvVKfRcxPWw1o2CMbJKJfDcC0BLNMUYXC0D+Iet4zxN9YgHOG9j+2H
         PBztkO2jyXJAQdBAaPujzuVN37/6i2jCdVFCHU0LOtH93d9DwKw262TWeBD/ZLSpr15c
         kuQWy//PQMWm14aUVNfrjPG7kULO5B7dkHOojO8rXV1saOgEb4bCZLO0naLu1aIAmmhh
         waVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u+ATtWAVEss1BpDy2E5eDZz+/D379066b/yyiKDVhuQ=;
        b=hRUec1TgpICCU/0aAmX2YKEm0/u2EMBWjnYHrwVbkw3N6YKDtAMa1ys4o+MDHdP200
         OYlC+lSonWfe4I8nkwXWHLcnz2Hxs9hoxtVsRciOXdjanHBjWGd7nTNUcYjHWJuJUpG0
         CbrEtyxs0ko993o8F8H2+KKTWPi1rSFTpEdkIsdaPfcxoJ2uYqlbP3O86d9iwEnhe5n+
         bNqRdhjz1kIQzMYrPIevinOy5CGBM2v0VwbvfgJE0Sn5gLT9q/rW6sIMyMytAqfph+qN
         GtahNO+tvKOsko+PrPnD82SK6kWD3eDEXC9vIIM07zvzBt8CK8ALIpLJs3lGCtF7krso
         QdFQ==
X-Gm-Message-State: APt69E3yUVKRgCnb9W0PoRsL3XS8fdPpC5SfRShkCuvHQ5OLrOV4WcJC
        mfvvHPnvOPxA+x4QkZM7oP0=
X-Google-Smtp-Source: ADUXVKKaPW4sDJfTGYp383zXbNd+jefbC3XZ+HNd/GFjqkMzUubZfdsm3zo2ma81PPT0MJ3LBTUOyw==
X-Received: by 2002:aed:3e06:: with SMTP id l6-v6mr6547966qtf.299.1527771217462;
        Thu, 31 May 2018 05:53:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2cb8:1b85:8d36:d4f1? ([2001:4898:8010:0:15ee:1b85:8d36:d4f1])
        by smtp.gmail.com with ESMTPSA id g57-v6sm9953528qte.52.2018.05.31.05.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 05:53:36 -0700 (PDT)
Subject: Re: [PATCH v3 10/20] commit-graph: verify objects exist
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-11-dstolee@microsoft.com> <86a7shvth6.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7876b157-6730-53ae-d1c9-102df1a16331@gmail.com>
Date:   Thu, 31 May 2018 08:53:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86a7shvth6.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/2018 3:22 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> In the 'verify' subcommand, load commits directly from the object
>> database to ensure they exist. Parse by skipping the commit-graph.
> All right, before we check that the commit data matches, we need to
> check that all the commits in cache (in the serialized commit graph) are
> present in real data (in the object database of the repository).
>
> What's nice of this series is that the operation that actually removes
> unreachable commits from the object database, that is `git gc`, would
> also update commit-gaph file.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c          | 20 ++++++++++++++++++++
>>   t/t5318-commit-graph.sh |  7 +++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index cbd1aae514..0420ebcd87 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -238,6 +238,10 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>>   {
>>   	struct commit *c;
>>   	struct object_id oid;
>> +
>> +	if (pos >= g->num_commits)
>> +		die("invalid parent position %"PRIu64, pos);
>> +
> This change is not described in the commit message.
This change should go in "commit-graph: verify parent list" which adds a 
test that fails without it. Thanks.

>>   	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
>>   	c = lookup_commit(&oid);
>>   	if (!c)
>> @@ -905,5 +909,21 @@ int verify_commit_graph(struct commit_graph *g)
>>   		cur_fanout_pos++;
>>   	}
>>   
>> +	if (verify_commit_graph_error)
>> +		return verify_commit_graph_error;
> All right, so we by default short-circuit so that errors found earlier
> wouldn't cause crash when checking other things.
>
> Is it needed, though, in this case?  Though I guess it is better to be
> conservative; lso by terminating after a batch of one type of errors we
> don't get many different error messages from the same error (i.e. error
> propagation).
>
>> +
>> +	for (i = 0; i < g->num_commits; i++) {
>> +		struct commit *odb_commit;
>> +
>> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>> +
>> +		odb_commit = (struct commit *)create_object(cur_oid.hash, alloc_commit_node());
> Do we really need to keep all those commits from the object database in
> memory (in the object::obj_hash hash table)?  Perhaps using something
> like Flywheel / Recycler pattern would be a better solution (if
> possible)?
>
> Though perhaps this doesn't matter much with respect to memory use.
>
>> +		if (parse_commit_internal(odb_commit, 0, 0)) {
> Just a reminder to myself: the signature is
>
>    int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)
>
>
> Hmmm... I wonder if with two boolean paramaters wouldn't it be better to
> use flags parameter, i.e.
>
>    int parse_commit_internal(struct commit *item, int flags)
>
>    ...
>
>    parse_commit_internal(commit, QUIET_ON_MISSING | USE_COMMIT_GRAPH)
>
> But I guess that it is not worth it (especially for internal-ish
> function).
>
>> +			graph_report("failed to parse %s from object database",
>> +				     oid_to_hex(&cur_oid));
> Wouldn't parse_commit_internal() show it's own error message, in
> addition to the one above?
>
>> +			continue;
>> +		}
>> +	}
>> +
>>   	return verify_commit_graph_error;
>>   }
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index c050ef980b..996a016239 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
>>   	git commit-graph verify >output
>>   '
>>   
>> +NUM_COMMITS=9
>>   HASH_LEN=20
>>   GRAPH_BYTE_VERSION=4
>>   GRAPH_BYTE_HASH=5
>> @@ -265,6 +266,7 @@ GRAPH_BYTE_FANOUT1=`expr $GRAPH_FANOUT_OFFSET + 4 \* 4`
>>   GRAPH_BYTE_FANOUT2=`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
>>   GRAPH_OID_LOOKUP_OFFSET=`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
>>   GRAPH_BYTE_OID_LOOKUP_ORDER=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8`
>> +GRAPH_BYTE_OID_LOOKUP_MISSING=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 4 + 10`
> All right, so we modify 10-the byte of OID of 5-th commit out of 9,
> am I correct here?
>
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -334,4 +336,9 @@ test_expect_success 'detect incorrect OID order' '
>>   		"incorrect OID order"
>>   '
>>   
>> +test_expect_success 'detect OID not in object database' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_MISSING "\01" \
>> +		"from object database"
>> +'
> I guess that if we ensure that OIDs are constant, you have chosen the
> change to actually corrupt the OID in OID Lookup chunk to point to OID
> that is not in the object database (while still not violating the
> constraint that OID in OID Lookup chunk needs to be sorted).
>
>> +
>>   test_done
> All right (well, except for `expr ... ` --> $(( ... )) change).
>

