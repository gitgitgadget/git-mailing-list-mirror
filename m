Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BB61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfIPSHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:07:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38758 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389924AbfIPSHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:07:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so443634pgi.5
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGDT8eB8YwrzwfAa7vwBrQjsu6O3sqK76pGWIj+jrBY=;
        b=mD2MiOiDEe/cHD3lUuMyrnOjNHFJpsR1r8fy5+VYE2tBe0L1fYsy3pzxCdWCPgzb0Y
         yD+m1Q31kVkOHT+teAYicVkxN4r6WO1r8JLp8H7+uCRu+3n1oxkvUr+zCFBDDQNZDYIy
         P0Vr2T/R8bLSLeU6Og+zmCR+kSRVcsUOZERIi8x8Sn6JQHpzvCuQ7vLz6ZNwOSOWmlck
         uOmiJ8DkmqMKIkbGxPs4AnYTYoEl0oXpvEiKUJubcSLO1H0cnRbYlmvY5xwIaRd1w6xr
         AwbcG/TPXUy+iyc/+s9PQADwaFHMk1M1VRiU6S1xugtx360ErdI+Ti5yPKrXAwN+P0CJ
         mDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mGDT8eB8YwrzwfAa7vwBrQjsu6O3sqK76pGWIj+jrBY=;
        b=LyD7U+iGr+VrqcAVDJUksj6ABw0unsnwONyqEkdX9oZZhsN13vnYe96UnjvAnHPUFC
         aoEYI2Pllb3Tud//DM0Z9sfCK2Vf5wzJASNgZIIp7cMSiocJtX9T04qdyHHrySk+eanY
         Apn0Ef28ZNuRbny2iEFTWxcVwEQLxLxXtjP4NSKSCzuxqCYo7u00DHi6dykSU2CGSDcW
         4FWKaVjxBE8YzuUBiqON8o/VreSvOVUV/NDZPAcvpeijdZrX5zNBs8A2GrSfbgDdb7V0
         UU1rXKMycOlrAg4zerov6sVlRvnSAYnlPICaDSNOJVXGJHSrpFQS0K1JBcutbZjitk44
         p1BQ==
X-Gm-Message-State: APjAAAUEShoVR41+4XCUBaUj5i0xBk7AFKyiFJeRp3UTA4kW6FiC9x38
        NvRJ+JnxOI4qFSLqwfGZfvRCXw==
X-Google-Smtp-Source: APXvYqwRYTSl20lLayKR9bjZfy2asUOo7ogw11oJV3bnDoeUFgnwIcpf3r+0ndam+VcDWljT9yr09Q==
X-Received: by 2002:a65:608e:: with SMTP id t14mr343837pgu.373.1568657268752;
        Mon, 16 Sep 2019 11:07:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id g202sm51457350pfb.155.2019.09.16.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:07:47 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:07:43 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, szeder.dev@gmail.com
Subject: Re: [RFC PATCH v3 3/3] trace2: write overload message to sentinel
 files
Message-ID: <20190916180743.GA11295@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        git@jeffhostetler.com, szeder.dev@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
 <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
 <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.09.16 08:07, Derrick Stolee wrote:
> On 9/13/2019 8:26 PM, Josh Steadmon wrote:
> > Add a new "overload" event type for trace2 event destinations. Write
> > this event into the sentinel file created by the trace2.maxFiles
> > feature. Bump up the event format version since we've added a new event
> > type.
> > 
> > Writing this message into the sentinel file is useful for tracking how
> > often the overload protection feature is triggered in practice.
> 
> Putting meaningful data into the sentinel file is valuable. It's
> important to know a bit about when and why this happened. A user
> would be able to inspect the modified time, and the directory info
> you include is unnecessary. The data you include is only for the
> log aggregator to keep valuable data around overloads.
>  
> > +`"overload"`::
> > +	This event is created in a sentinel file if we are overloading a target
> > +	trace directory (see the trace2.maxFiles config option).
> > ++
> > +------------
> > +{
> > +	"event":"overload",
> > +	...
> > +	"dir":"/trace/target/dir/", # The configured trace2 target directory
> > +	"evt":"2",		    # EVENT format version
> > +}
> That said, do we really need to resort to a new event format and
> event type? Could we instead use the "data" event with a key
> "overload" and put the target dir in the value?

Yeah, that sounds reasonable. Thanks for the suggestion.
