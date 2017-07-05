Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601E0202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 22:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbdGEWpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 18:45:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35654 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdGEWpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 18:45:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so334710pgc.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p+JmVGYm0yQ52wSQJYm5Wb+OBYREZERptbZRy4RQcZs=;
        b=NCPcyy9KdDiDksHUU64l/t2RBUFwjenLFCrz33cg+9J5RrfFW5sl4uFJHfzRLgo4AA
         c55dIGANnv77GLxCWhF1dKF+am3xqM503hVdLR6tOu7DErJ6sXvnKM1pI8TXCGfoLtor
         l0zz17XPR+LrywSqrQuB5ULx3zPp/SzYPyyDKNDjbJgY2UiyRbA9P8ebeVQDCA3NyCdc
         13MOqIiSvqJmL+ABLfDVHGSmSLzUP/qH29UjKMCHOjLsiP3wk0NVJDpO0F1uXVq1DZsM
         P4lbimsmmkK5NhsU48TqBgKx+vCyI/SJfQ9E3l2HhbWD60Zcwek6HZJjX+oE1Ld91Sy6
         yuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p+JmVGYm0yQ52wSQJYm5Wb+OBYREZERptbZRy4RQcZs=;
        b=A0m94R+1GBkfXCIDG7+rsMIrmaNH+pCKv17n2g3KLgTQyWAzAItz6MKXw4oXad21XL
         VLjAim/pGkZwTSexPsrA5Hq8bdjLHiWmT9KlIWmciDyiq0wNRxVlx7XlfNRrtCSnluup
         ynaDgMUkMLMyKO1i+qgqm32wCBH7COejD8OYQ8JRA7P28VoCiLjRm+lu89fxsU/v70y8
         yUvbdP/Qp01ar5UPYGvSnR/uMAy7kP6n7w3tW7yFoDYgI3uODN4meoiIke5PhdlisEwd
         mtqQlhTO7QYi1xYmf1AfwGgNjvq6ySdiTnk4QLgTCqjfaZvCtMk+nMyvcXVOLYXm/Xnu
         CFsA==
X-Gm-Message-State: AIVw1108WkpQh3ZmE+dbdzwN2f/9JooHt9V93ZVfmYCLxmFlaJJ5O/3m
        NpQFClG+jw2nnQ==
X-Received: by 10.98.137.81 with SMTP id v78mr7523862pfd.9.1499294704538;
        Wed, 05 Jul 2017 15:45:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id e189sm258214pfe.100.2017.07.05.15.45.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 15:45:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
        <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
        <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
Date:   Wed, 05 Jul 2017 15:45:03 -0700
In-Reply-To: <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Jul 2017 17:27:57 -0400")
Message-ID: <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +test_expect_failure 'walking multiple reflogs shows both' '
>> > +	{
>> > +		do_walk HEAD &&
>> > +		do_walk side
>> > +	} >expect &&
>> > +	do_walk HEAD side >actual &&
>> > +	test_cmp expect actual
>> > +'
>> 
>> I somehow find this one a bit iffy.  
>> 
>> The order that commits appear in the "walk from HEAD and side at the
>> same time" may want to be different from what this test expects.
>> "rev-list --since=3.days -g master next", for example, would want to
>> refrain from reading the reflog of 'master' for all 90 days before
>> switching to the reflog of 'next', no?
>
> I did make the ordering intentional. We process each reflog sequentially
> in turn. I don't think it would be wrong to interleave them by date, but
> I actually think it's useful for somebody who switches that behavior to
> consciously update the test. Maybe it's worth calling out in the commit
> message.
>
> I stopped short of actually documenting and guaranteeing that behavior
> to the user. I don't know how comfortable we would be changing it later.

I somehow feel that the "showing all entries from HEAD and then
showing all from side" is simply a buggy behaviour.  I do not think
our users would terribly mind if we changed it later.  But I may be
missing the reason why (sometimes?) the sequential behaviour may be
useful.

> (As an aside, I also prowled through the documentation looking for any
> guarantees we make to the user about the fake-parent thing, but I
> couldn't find any. So I considered its user-visible effects an unwanted
> side effect of the implementation).

Yes, I think the corner cases you documented here in these tests are
not something we desired to have in the first place.  Rather they
are merely fallouts from the hackyness of the implementation.
