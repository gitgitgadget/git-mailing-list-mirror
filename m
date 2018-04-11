Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620B21F404
	for <e@80x24.org>; Wed, 11 Apr 2018 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDKNCT (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 09:02:19 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:46325 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbeDKNCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 09:02:18 -0400
Received: by mail-pg0-f51.google.com with SMTP id t12so738868pgp.13
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X1Tr9vXnZ4JHC+tJq3XS/U8BpPcYViIQzGWJBdRwf4c=;
        b=FPJUpiL19YZPI8Zo8bOeyfBwTkZ6U1SvkJH52j5uerpSi0PYrvGhFgzy63902QHaZT
         +SXjdT6KZl52nkfvydJM33g0kX6GZyoQIGTMad6CruukSZan2aPsAA+/vOUrpm6F1aNp
         CrSFVcA7cWi60C11VsygygAassy9rfZ617j3QLvs0wPmcx75MKqzBI4U3PFDoQ4prOoA
         omchOCwKAU7Yg7Dp0qeaRMU3R2W009cdo09o10oYQyUamizypxIanJdmYX8+W60bOqmf
         awHA9v7Y15/llyNqfl5PJ367ydC66zr2cBTZztkuEVciCLeKEGmTo73v6TJh+YIBsDS3
         7dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X1Tr9vXnZ4JHC+tJq3XS/U8BpPcYViIQzGWJBdRwf4c=;
        b=TmCmctUYw/Ilg77C8JrS774z5LXUx+lN09qiWqJ9JN4+K/E+orfUfk6TOnl8USKTAa
         0Oxcr79Bs5Z5/pEnelZafg5KmLSYLL1SJt0y+SRdEWz7HzecdRlcL1nH8SFnFPR7AkSD
         GQBN0sBvdwjfu2ww51h/QOOZyWhzlcPr+qC/uGpRBzfjIGoXuC0szKoKqE/63UVw2K1c
         Fhl3z3orbntLSYuggVzpwwacmFNpOCWGN52uicQg6svlk/a/w8I+pDJ93cE6qI/SpWyV
         s+Ke047jb4VVbpCsxbim/NkKMQywVMU/tenWT0gShmryltYzIILNPF0F0vVH6GsQUKBz
         X2IQ==
X-Gm-Message-State: ALQs6tBzSBeU1fFbeEvJ6Kl+jWexqaTgE/ZS2bNYyyjzZ0ZEn843HuOR
        QxhjFmj8PCTb1TeM+BIGEnQ=
X-Google-Smtp-Source: AIpwx48aiqoJBZqUqUDxjc3/RiFz55IkU9cuK61y1T+UDkC0J4FHE7qPNyTHPLPkTyCGQvdqQY0Uow==
X-Received: by 10.99.136.194 with SMTP id l185mr3452231pgd.419.1523451737293;
        Wed, 11 Apr 2018 06:02:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b73sm2914007pga.62.2018.04.11.06.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 06:02:16 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] commit-graph: compute generation numbers
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-5-dstolee@microsoft.com>
 <xmqqa7uazc9e.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ba7d27f-ce65-7f2c-601a-1bea3274104e@gmail.com>
Date:   Wed, 11 Apr 2018 09:02:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7uazc9e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 10:51 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> +		if ((*list)->generation != GENERATION_NUMBER_INFINITY) {
>> +			if ((*list)->generation > GENERATION_NUMBER_MAX)
>> +				die("generation number %u is too large to store in commit-graph",
>> +				    (*list)->generation);
>> +			packedDate[0] |= htonl((*list)->generation << 2);
>> +		}
>
> How serious do we want this feature to be?  On one extreme, we could
> be irresponsible and say it will be a problem for our descendants in
> the future if their repositories have more than billion pearls on a
> single strand, and the above certainly is a reasonable way to punt.
> Those who actually encounter the problem will notice by Git dying
> somewhere rather deep in the callchain.
>
> Or we could say Git actually does support a history that is
> arbitrarily long, even though such a deep portion of history will
> not benefit from having generation numbers in commit-graph.
>
> I've been assuming that our stance is the latter and that is why I
> made noises about overflowing 30-bit generation field in my review
> of the previous step.
>
> In case we want to do the "we know this is very large, but we do not
> know the exact value", we may actually want a mode where we can
> pretend that GENERATION_NUMBER_MAX is set to quite low (say 256) and
> make sure that the code to handle overflow behaves sensibly.

I agree. I wonder how we can effectively expose this value into a test. 
It's probably not sufficient to manually test using compiler flags ("-D 
GENERATION_NUMBER_MAX=8").

>
>> +	for (i = 0; i < nr_commits; i++) {
>> +		if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
>> +		    commits[i]->generation != GENERATION_NUMBER_ZERO)
>> +			continue;
>> +
>> +		commit_list_insert(commits[i], &list);
>> +		while (list) {
>> +...
>> +		}
>> +	}
> So we go over the list of commits just _once_ and make sure each of
> them gets the generation assigned correctly by (conceptually
> recursively but iteratively in implementation by using a commit
> list) making sure that all its parents have generation assigned and
> compute the generation for the commit, before moving to the next
> one.  Which sounds correct.

Yes, we compute the generation number of a commit exactly once. We use 
the list as a stack so we do not have recursion limits during our 
depth-first search (DFS). We rely on the object cache to ensure we store 
the computed generation numbers, and computed generation numbers provide 
termination conditions to the DFS.

Thanks,
-Stolee
