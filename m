Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4BD207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972086AbdDYEZD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:25:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34194 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971829AbdDYEZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:25:01 -0400
Received: by mail-it0-f68.google.com with SMTP id c26so12338749itd.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Bb0QoXv9PTaOOEuAv543di8YABLknz7SFPgRZcCRiTI=;
        b=QJQ+2xZVrDPWMV+pJhKnbfZ9bUZd34xqIKZvoxGXrNERq+wPn6jT2OENswJVVvIY4h
         CQzjqNpE0SP5a3nXyNEgu6Q5x8cUbNNmW89TnIUQULRERBYhElmIRFNksI/KJN2r4WFp
         V6lOFbEIJKI4RhXsR4KD3Y3+hyxnkQoSDyZQqhrTGVyLZvNYIDsuO4RhHRJJ0CLLXvZi
         FJ25Y0J69I95TNuvC16+z+Ihr7UfBMA7x9/HCb6KGfmiu/iZnbhp4riaTOwVlvEGfoCD
         gLjnhrjowAiXvuqN3PVEuX7AwmxxaGTWoUUCZCOTv7jm+KskSHjwlJMPImKxGZQ8Ovk+
         ZgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Bb0QoXv9PTaOOEuAv543di8YABLknz7SFPgRZcCRiTI=;
        b=CorTBf/LLwc9hiRdUqEuhmLu7MsRMo+yPzQf2AG8iQokmXQZ9LpVJ29JN9tI+yBTy+
         kRL9nJ8Mvv6tUctQh9REaN5Qi1pFN5MVcn9mRqJUvSvrYzDS8cVFwRQUP/VpbeHL0295
         8cbn01/VgvEU25XnflHNlq541xAtI6VMdI+d7kXjK0CjhKpPCBsvZirKbi5xoQMZ6CSf
         50VN9Nd8Li4o06nVJ5TbZe1bYvQHjHGQA5QcS0LH9LPj4P69xHR4I5BuPC3ADvV06v2+
         xLWwV51mUtpnX0y8WlXRMlksOwVf22dur1eDqN6iTBFR7JjgqGoq3jac0uAt/ckAHQTL
         j2tw==
X-Gm-Message-State: AN3rC/6jPP5X88ZOf5g01BFgEgNr8D72BcEhOLnGoHDo1P0fFwY8KcJ8
        WxOaae06e7Ql1g==
X-Received: by 10.36.222.6 with SMTP id d6mr19457387itg.46.1493094301059;
        Mon, 24 Apr 2017 21:25:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id f87sm9052900ioj.0.2017.04.24.21.25.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 21:25:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fast-export: deletion action first
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
        <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net>
Date:   Mon, 24 Apr 2017 21:24:59 -0700
In-Reply-To: <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Apr 2017 23:29:27 -0400")
Message-ID: <xmqqfugxw1us.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Perhaps we would want a test for the case you are fixing (to be sure it
> is not re-broken), as well as confirming that we have not re-broken the
> original case (it looks like 060df62 added a test, so we may be OK with
> that).

Good suggestion.

>
>> +/*
>> + * Compares two diff types to order based on output priorities.
>> + */
>> +static int diff_type_cmp(const void *a_, const void *b_)
>> [...]
>> +	/*
>> +	 * Move Delete entries first so that an addition is always reported after
>> +	 */
>> +	cmp = (b->status == DIFF_STATUS_DELETED) - (a->status == DIFF_STATUS_DELETED);
>>  	if (cmp)
>>  		return cmp;
>>  	/*
>
> So we sort deletions first. And the bit that the context doesn't quite
> show here is that we then compare renames and push them to the end.
> Everything else will compare equal.

Wait--we also allow renames?  Rename is like delete in the context
of discussing d/f conflicts, in that it tells us that the source
path will be missing in the end result.  If you rename a file "d" to
"e", then there is a room for you to create a directory "d" to store
a file "d/f" in.  Shouldn't it participate also in this "delete
before add to avoid d/f conflict" logic?

> Is qsort() guaranteed to be stable? If not, then we'll get the majority
> of entries in a non-deterministic order. Should we fallback to strcmp()
> so that within a given class, the entries are sorted by name?

Again, very good point, especially with the existing comment in the
comparison function that explains why renames are shown last.

