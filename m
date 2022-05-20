Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E73C4321E
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352473AbiETSNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352481AbiETSNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:13:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895D18DAD7
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:13:05 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o16so6060827ilq.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YtEtuylFH1fkaVxB9UVFUUBT9YFo0jD7Od4cagTwOiE=;
        b=E8KwPg1g1SK/wd5vbVfC7seIvsLtwiOGtQ16+ifKwDYwZ1WjiabVT9bLzeoS2cRxRk
         CxF0uesWyn7qwjaaFHf0pJ8pYA5VAHOnIdJYhH2Kb5wS2145g4LflY9yVLWmQeHIEugq
         QBQLjWP/eIPtXNKGBuabJ5HCQKGHQVglbSCWXBStCqZkmHYtHV3ZlHyYOSe54Yeymn5d
         5ySrwzWUibac5tXODdt1DVuiF46oZ7vV/b2842lJhV7sPVF731wQG9sYN/28YX1YUzrO
         PWWCxjakBC8aQ5xSNlORUHb+iBsLrMTs+STFJmb24hwzy7AUXMirB9ZNvK4GRzmuseV0
         z5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YtEtuylFH1fkaVxB9UVFUUBT9YFo0jD7Od4cagTwOiE=;
        b=bVoyemNznne4DirD7n9m3/PSAwqg41jsxPSkMUPCNu/4VdmNA2++NNEJOlrM4PPuwm
         QvNaN7+qJr0oXW5tFcQP5y6jykHihKK4tQhT9qR8yr5WwvIxR/pz9R7ZDdo9E4DSp8sQ
         xgVv2DJi+33vMTuEmxgpiIJQiEijDuGcVh5d6oE7a8lZ+ggA51q2ntn7sT++r+gn07HR
         LUXbGQ96Un2/OgUS56eL4O0KOAdM0pq8OePygJB+MkQGQJYNsFl9hMi5fKrj3OovqGao
         DDWzfm1tf5ebEOqjWrWoZ+UEfXOzvUZ0RPAFxD6IOzSjF72uQRwxXz0yv8hk8qZTD1Ys
         pp5w==
X-Gm-Message-State: AOAM531qAE6+ydlPBCVsgYwcdFzusInD0r5OvGGlToGRVKN35yxUK6Hv
        vM6RWycSTIx4VW/OSJhoWHrR
X-Google-Smtp-Source: ABdhPJy6OW+yhaH/wm7tV8DawbDqfym3BewZkPCBIykbM7wVCTdzxuAY8l9jwxiqoeMe6RyYOE1YEg==
X-Received: by 2002:a05:6e02:198e:b0:2cf:4a7a:faf8 with SMTP id g14-20020a056e02198e00b002cf4a7afaf8mr5719416ilf.206.1653070385252;
        Fri, 20 May 2022 11:13:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id l37-20020a026a25000000b0032e12690b2esm853885jac.59.2022.05.20.11.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 11:13:04 -0700 (PDT)
Message-ID: <9a89398a-c5ec-d386-d554-a077fefcd46b@github.com>
Date:   Fri, 20 May 2022 14:13:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 05/10] cache-tree: implement cache_tree_find_path()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <c977001c033e8689f6d0ca52a6021bde61b1b476.1652982759.git.gitgitgadget@gmail.com>
 <xmqqczg9mg8s.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczg9mg8s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2022 4:14 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
>> +{
>> +	const char *slash;
>> +	int namelen;
>> +	struct cache_tree_sub *down;
>> +
>> +	if (!it)
>> +		return NULL;
>> +	slash = strchrnul(path, '/');
>> +	namelen = slash - path;
>> +	it->entry_count = -1;
>> +	if (!*slash) {
>> +		int pos;
>> +		pos = cache_tree_subtree_pos(it, path, namelen);
>> +		if (0 <= pos)
>> +			return it->down[pos]->cache_tree;
>> +		return NULL;
>> +	}
>> +	down = find_subtree(it, path, namelen, 0);
>> +	if (down)
>> +		return cache_tree_find_path(down->cache_tree, slash + 1);
>> +	return NULL;
>> +}
> 
> The tail recursion (and the one in the orginal) may want to be
> trivially converted to iteration with "goto".

Good idea!
 
> It is somewhat surprising that we didn't have any external interface
> to expose a sub-part of the cache_tree at all so far.  It may be
> because the API was so well designed that the abstraction did not
> have to be exposed.  I dunno.

I think the abstraction definitely fit the shape of its consumers
pretty perfectly. I wonder if having a method like this will make
us think of new ways to use the cache tree for other things.

Thanks,
-Stolee
