Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B804F1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 12:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756465AbeDZM7T (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 08:59:19 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:44576 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756392AbeDZM6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 08:58:43 -0400
Received: by mail-qk0-f172.google.com with SMTP id z8so9708937qki.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j7YHIz2hvGX6VWGAFD3ozgr2yC1I3oJiE7yURpkDlpQ=;
        b=gw/LvUxLiUnWQAJHssggAi21J9Oow4p1vwtCVcWVHv691gzEASFLNL/nHECtRuMKMD
         cWHhkV0qfT5SYHisUvdh3jagb2U5GXikWeXan4Pvj8yg4Kfmn0oK599h4Y1LaexVCbL+
         qwRizfT8bphgv/LvGW6B8ucPVxtV8x3t3JompDdZK6Or9m62QACmssU9CagfldNdppMM
         iK3tH8kjJS/oUnv8tQQQgs0WHiYFV/eqrvpHkHFveyfoG3zs5J7m0vzhgd3POqapJhpO
         MTZxaI+RmvO5OuuCjTP1+uBFdDpqhzs1cHfm1nuVJQxAh7lOJEHmhwIM5H3oGAyVPRd8
         eJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j7YHIz2hvGX6VWGAFD3ozgr2yC1I3oJiE7yURpkDlpQ=;
        b=Ddpnzrm6NlSePZxln5UYT5OvP/yHtGU2s1hJO7KMHW1DWnaVtSpD88V+L18rXmt8lt
         +tewa6//eeqRs4hcUto6d1sN/AJtnC+14F5t18daTGpVJXWQzFEkuaCTVQLa0IhxlXAE
         NgAe0avF3Up8wEKPcetpVale/2ci5+Xbbiph8a8VJo2v/dtSVjUtVQiyf4Cazmt82zeS
         VjGdMRuamRq04QB/a1pUxWp27yDL3ntRpHzNH7hOufZDgg/7YOToMlXSQq/irpFi+GWk
         JlZcU07kHnir2NTOdHfGMXPKI71dEmXVlIpn78ePpwGMsdDI+2PMn2236YQ/VOcJGtxV
         3O0A==
X-Gm-Message-State: ALQs6tBNnncKNuaujM7MQi4jJpI16Qaj2DQ4wD1/9o0SEY+Xb1T4a26Q
        gCMcsBMjf/fvF+HBtqsZRU4=
X-Google-Smtp-Source: AB8JxZrBV0zKSC/hkjTIwU70Yzvf9ahW59mJXROd3JCnRg7IoIPCMqE6ZmvPUblj0cDvr0QbH6Hs+Q==
X-Received: by 10.55.42.217 with SMTP id q86mr34264308qkq.180.1524747522460;
        Thu, 26 Apr 2018 05:58:42 -0700 (PDT)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id n66sm816192qkd.7.2018.04.26.05.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 05:58:41 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-4-dstolee@microsoft.com>
 <xmqqvace3d9s.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <21272fff-acf9-8641-3aa9-1d026843ff3a@gmail.com>
Date:   Thu, 26 Apr 2018 08:58:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqvace3d9s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

n 4/25/2018 10:35 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> @@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>>   		else
>>   			packedDate[0] = 0;
>>   
>> +		if ((*list)->generation != GENERATION_NUMBER_INFINITY)
>> +			packedDate[0] |= htonl((*list)->generation << 2);
>> +
>>   		packedDate[1] = htonl((*list)->date);
>>   		hashwrite(f, packedDate, 8);
> The ones that have infinity are written as zero here.  The code that
> reads the generation field off of a file in fill_commit_graph_info()
> and fill_commit_in_graph() both leave such a record in file as-is,
> so the reader of what we write out will think it is _ZERO, not _INF.
>
> Not that it matters, as it seems that most of the code being added
> by this series treat _ZERO and _INF more or less interchangeably.
> But it does raise another question, i.e. do we need both _ZERO and
> _INF, or is it sufficient to have just a single _UNKNOWN?

This code is confusing. The 'if' condition is useless, since at this 
point every commit should be finite (since we computed generation 
numbers for everyone). We should just write the value always.

For the sake of discussion, the value _INFINITY means not in the graph 
and _ZERO means in the graph without a computed generation number. It's 
a small distinction, but it gives a single boundary to use for 
reachability queries that test generation number.

>
>> @@ -571,6 +574,46 @@ static void close_reachable(struct packed_oid_list *oids)
>>   	}
>>   }
>>   
>> +static void compute_generation_numbers(struct commit** commits,
>> +				       int nr_commits)
>> +{
>> +	int i;
>> +	struct commit_list *list = NULL;
>> +
>> +	for (i = 0; i < nr_commits; i++) {
>> +		if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
>> +		    commits[i]->generation != GENERATION_NUMBER_ZERO)
>> +			continue;
>> +
>> +		commit_list_insert(commits[i], &list);
>> +		while (list) {
>> +			struct commit *current = list->item;
>> +			struct commit_list *parent;
>> +			int all_parents_computed = 1;
>> +			uint32_t max_generation = 0;
>> +
>> +			for (parent = current->parents; parent; parent = parent->next) {
>> +				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
>> +				    parent->item->generation == GENERATION_NUMBER_ZERO) {
>> +					all_parents_computed = 0;
>> +					commit_list_insert(parent->item, &list);
>> +					break;
>> +				} else if (parent->item->generation > max_generation) {
>> +					max_generation = parent->item->generation;
>> +				}
>> +			}
>> +
>> +			if (all_parents_computed) {
>> +				current->generation = max_generation + 1;
>> +				pop_commit(&list);
>> +			}
> If we haven't computed all parents' generations yet,
> current->generation is undefined (or at least "left as
> initialized"), so it does not make much sense to attempt to clip it
> at _MAX at this point.  At leat not yet.
>
> IOW, shouldn't the following two lines be inside the "we now know
> genno of all parents, so we can compute genno for commit" block
> above?

You're right! Good catch. This code sets every merge commit to _MAX. It 
should be in the block above.

>
>> +			if (current->generation > GENERATION_NUMBER_MAX)
>> +				current->generation = GENERATION_NUMBER_MAX;
>> +		}
>> +	}
>> +}
>> +
>>   void write_commit_graph(const char *obj_dir,
>>   			const char **pack_indexes,
>>   			int nr_packs,
>> @@ -694,6 +737,8 @@ void write_commit_graph(const char *obj_dir,
>>   	if (commits.nr >= GRAPH_PARENT_MISSING)
>>   		die(_("too many commits to write graph"));
>>   
>> +	compute_generation_numbers(commits.list, commits.nr);
>> +
>>   	graph_name = get_commit_graph_filename(obj_dir);
>>   	fd = hold_lock_file_for_update(&lk, graph_name, 0);
