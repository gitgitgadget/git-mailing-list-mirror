Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B701FAA8
	for <e@80x24.org>; Tue, 16 May 2017 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbdEPVlM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 17:41:12 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32991 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbdEPVlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 17:41:11 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so82325504pgb.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=n1xhDcWvPCeKkAZamnTuFyuWvF84FhtIs7gXyRoQ75A=;
        b=GiW7VChhoe2RfePWFEJlKMc8eJOzN+SfmLOQqnu28EK0qUckrXIDJpR5PXOWqVrW//
         rcwwtwUfiElEpdrXCAskjU/Gs07bIp1iR8p/yafTSuPL0oFHOBMf+FzZMMTcNHjB10DX
         QQPlzDFjZZ6jv8hifWx80aWB5CXkcMk0RRCJQu571VkdrOnMJo8xPJcpGytnbQs35qGj
         AMov/8RwREPKSAIXDPnde/owaai+LdMuczDxEZjvDZKYAPWKsnqvB3yF9e0Cvl6qANmF
         lLeeh2q2laa44hkxpEHU79p/6ozt5iGgdz/LgzsrnGfiyOnNSUDQ8Zu+iYlm9s+Kvrxr
         KUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=n1xhDcWvPCeKkAZamnTuFyuWvF84FhtIs7gXyRoQ75A=;
        b=gD0QaQVE+RVQI4leZaCmtlck/C7UarWqQfhvl7gg4cWyrsmXu//FrXpWioglIgRs8f
         cxFo6Bn9F3F4leNIwx+5jrMtXLhjCIAwqKEBPnom3sZIMkFwV7rN9hdM1OlJ2ExgVXBJ
         TuV6OWq+D6TzrIFKOMrgtqMMg4bVMzOJNhqsrew7KbkA/RLOxwhXeYHdaHbRnfAKOMbi
         d+N0u6CeBXhRdLLMgtigfBP3WgaQEkNS7PwgDOZaOWCpYMo4jOMEXHECnguLX3EILtzK
         M2D0lIIFe2LcZhgykrB0acyMqBk9xHYZlv48oFVqK2ZfkFWwGVXOBC16KFRWrbRmZPYt
         GyYQ==
X-Gm-Message-State: AODbwcDzdy/EJM3hVVWWidhmefrw1NlYOgBYLjChcq+UNkJpQlXjs0T6
        umsGcqB39oke4aF2
X-Received: by 10.84.217.218 with SMTP id d26mr107740plj.47.1494970870975;
        Tue, 16 May 2017 14:41:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9572:8006:bb1a:9123])
        by smtp.gmail.com with ESMTPSA id v64sm35321pfk.86.2017.05.16.14.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 14:41:09 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <473c4b47-06a7-cb55-6d67-e335fa5b5a5b@google.com>
Date:   Tue, 16 May 2017 14:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170515191347.1892-3-benpeart@microsoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not very familiar with this part of the code - here is a partial review.

Firstly, if someone invokes update-index, I wonder if it's better just 
to do a full refresh (e.g. by deleting the last_update time from the index).

Also, the change to unpack-trees.c doesn't match my mental model. I 
notice that it is in a function related to sparse checkout, but if the 
working tree changes for whatever reason, it seems simpler to just let 
the hook do its thing. As far as I can tell, it is fine to have files 
overzealously marked as FSMONITOR_DIRTY.

On 05/15/2017 12:13 PM, Ben Peart wrote:
> diff --git a/cache.h b/cache.h
> index 40ec032a2d..64aa6e57cd 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -201,6 +201,7 @@ struct cache_entry {
>  #define CE_ADDED             (1 << 19)
>
>  #define CE_HASHED            (1 << 20)
> +#define CE_FSMONITOR_DIRTY   (1 << 21)
>  #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
>  #define CE_CONFLICTED        (1 << 23)
>
> @@ -324,6 +325,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  #define CACHE_TREE_CHANGED	(1 << 5)
>  #define SPLIT_INDEX_ORDERED	(1 << 6)
>  #define UNTRACKED_CHANGED	(1 << 7)
> +#define FSMONITOR_CHANGED	(1 << 8)
>
>  struct split_index;
>  struct untracked_cache;
> @@ -342,6 +344,8 @@ struct index_state {
>  	struct hashmap dir_hash;
>  	unsigned char sha1[20];
>  	struct untracked_cache *untracked;
> +	time_t last_update;
> +	struct ewah_bitmap *bitmap;

Here a bitmap is introduced, presumably corresponding to the entries in 
"struct cache_entry **cache", but there is also a CE_FSMONITOR_DIRTY 
that can be set in each "struct cache_entry". This seems redundant and 
probably at least worth explaining in a comment.

> +/*
> + * Call the query-fsmonitor hook passing the time of the last saved results.
> + */
> +static int query_fsmonitor(time_t last_update, struct strbuf *buffer)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char date[64];
> +	const char *argv[3];
> +
> +	if (!(argv[0] = find_hook("query-fsmonitor")))
> +		return -1;
> +
> +	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
> +	argv[1] = date;
> +	argv[2] = NULL;
> +	cp.argv = argv;
> +	cp.out = -1;
> +
> +	return capture_command(&cp, buffer, 1024);
> +}

Output argument could probably be named better.

Also, would the output of this command be very large? If yes, it might 
be better to process it little by little instead of buffering the whole 
thing first.

> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state* istate);

Space before * (in the .h and .c files).

