Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD939C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbiFCNaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbiFCN36 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:29:58 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35325EB2
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:29:58 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f7so6536516ilr.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sMTXo63PyMLC+vi2y1q2lhIgap5bKHoIdJvEKZ/H7sA=;
        b=VPLQ3FK25edigHoQGXCuonlG19g2UNSdCEKMZR8n5qcSBMLEOP2MmtVRu+sWRbk01b
         5/N/9rUv2jJEBQjF63qpeZBn/G+khm8qhJAuMLTg4fUoYywrHcR/rwdbCYC0eK4uUVil
         yL8K1eE+0w5cfiVevjnFQMVgflIuGk6VbVJ+Q3mhDJf1pjawDcnjP5ki79iWykQ05MET
         K17r1wbfKVqIKv8GUJ0OLAddbfOjt6OC4cB1c0OzcQr0NzByYmGDJPKWM7SN5RkhhVVh
         YMZV7ZH4G8jKy94SZH6rNJ5Ee+h5kSJUan/jqur9NgonHvz4Zucktuy3fq4OiE21i+u7
         DPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sMTXo63PyMLC+vi2y1q2lhIgap5bKHoIdJvEKZ/H7sA=;
        b=SVo+M6nkJXBpm663d4OLsMllSvo7ncy4LbHVod+krpKx/7uHV92CqcaNLdW3fRimTA
         KD8ZoRdRuoewOy1jsS6xz52bI2sJqP/s6mXJhS4WY6dDlNr0V/ag9kXNU3TOzv15DKk8
         PdlqP+EaJ6OFMWbHfR93eeyQ3cjuHE4sRHjLISOByvN6slPiclgjqY3ovU7a/e7ZMwoo
         9jbu+aFs9cmlisuvGlP8cAE479tNmXkKH+rZAdbDk9ru/2tcLcz5rlKvj99BwTtTF9xn
         JOts9Vp7K07q8sVS5uSs6pse7kiqVKtYT1YkqIBW8jBXTMfBrxy6R2NxshPZ+Ype9YiP
         E2/A==
X-Gm-Message-State: AOAM530gS+pBEPxyK0JQOS2tKNaQs5CAgZ9zLNLyP2fS8FS+hRlUhHsV
        2DChWg6EC3pU6MFqFSECDoUB
X-Google-Smtp-Source: ABdhPJzz9udK6MJdydJHL3Gzxse72CpucoIlYTl28OYtO8yo24mpRVmLEXH6TE7Y2Xz8YqMh0hygiw==
X-Received: by 2002:a05:6e02:d4b:b0:2d3:b2a6:e94b with SMTP id h11-20020a056e020d4b00b002d3b2a6e94bmr5721107ilj.135.1654262997502;
        Fri, 03 Jun 2022 06:29:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e12d:e22a:252a:6357? ([2600:1700:e72:80a0:e12d:e22a:252a:6357])
        by smtp.gmail.com with ESMTPSA id j14-20020a92200e000000b002d191911e59sm2770331ile.52.2022.06.03.06.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:29:57 -0700 (PDT)
Message-ID: <394c054e-e1d2-41a5-a655-2ad3cb7219e0@github.com>
Date:   Fri, 3 Jun 2022 09:29:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] commit,shallow: unparse commits if grafts changed
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        bagasdotme@gmail.com
References: <20220323210803.1130790-1-jonathantanmy@google.com>
 <20220602231145.310564-1-jonathantanmy@google.com>
 <220603.86k09yxf4z.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220603.86k09yxf4z.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2022 5:30 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 02 2022, Jonathan Tan wrote:
> 
>> diff --git a/commit.c b/commit.c
>> index 59b6c3e455..1537ea73d0 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -120,6 +120,17 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid)
>>  		       commit_graft_oid_access);
>>  }
>>  
>> +static void unparse_commit(struct repository *r, const struct object_id *oid)
>> +{
>> +	struct commit *c = lookup_commit(r, oid);
>> +
>> +	if (!c->object.parsed)
>> +		return;
>> +	free_commit_list(c->parents);
>> +	c->parents = NULL;
>> +	c->object.parsed = 0;
>> +}

This looks good. I took a quick inventory of 'struct commit' and
agree that this is all we need. There is no need to clear the date
or maybe_tree members. The commit_graph_data slab might have some
information if there were no grafts before (but are now), but the
existence of grafts should clear the commit-graph already and stop
that slab from being used.

>>  int register_commit_graft(struct repository *r, struct commit_graft *graft,
>>  			  int ignore_dups)
>>  {
>> @@ -145,6 +156,7 @@ int register_commit_graft(struct repository *r, struct commit_graft *graft,
>>  			(r->parsed_objects->grafts_nr - pos - 1) *
>>  			sizeof(*r->parsed_objects->grafts));
>>  	r->parsed_objects->grafts[pos] = graft;
>> +	unparse_commit(r, &graft->oid);
>>  	return 0;
>>  }
>>  
>> @@ -253,8 +265,10 @@ void reset_commit_grafts(struct repository *r)
>>  {
>>  	int i;
>>  
>> -	for (i = 0; i < r->parsed_objects->grafts_nr; i++)
>> +	for (i = 0; i < r->parsed_objects->grafts_nr; i++) {
>> +		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
>>  		free(r->parsed_objects->grafts[i]);
>> +	}
>>  	r->parsed_objects->grafts_nr = 0;
>>  	r->parsed_objects->commit_graft_prepared = 0;
>>  }
> 
> Are we going to have the same issue with tags, c.f. parse_tag() and
> there being no unparse_tag()?
> 
> (I don't know offhand, just asking)

Grafts are only on commits. You cannot replace what a tag is pointing
at with a graft. Replace-objects is a different thing and changes it at
the OID level (and I don't think this can happen during the process
without concurrent external changes to the filesystem).

Thanks,
-Stolee
