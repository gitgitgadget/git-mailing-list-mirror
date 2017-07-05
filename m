Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B8D202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdGER4q (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:56:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35505 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdGER4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:56:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so14751964pgc.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bzmLp8V0W3ifwWs61wDg3luOnL6y/YigCxHTX2FC7kc=;
        b=avEEax5cFuxE2jKuxmtw+EwOE/dFXmR+q54k0jiVdIB+tUoE2LdWE+nYHkENfmhISl
         Jmux7w8RZxDbo/CT43jSh+5kVNGefB2Nn0ABX3ThLGkBhuzeehxyMeEbygK7T7eOksgP
         NP7wBJGJytOXOLmx0yU/nyl3myNCVZ+6xkqj2BAvi69cTIufC+KpOclcEMW2iJLUS7ID
         RHasv+2fyEaJBh4ZdnqbioFDKRofkhkjjcN6nrPGGHgxnYztQhstr7U1VlP6x7dSZkRm
         wFNt2MZcYg/+kI8djPItPVcjyFmVYuMUFkuTwU8Ar1MZDe7iERdrLCZNFaqg0d3VapIx
         2A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bzmLp8V0W3ifwWs61wDg3luOnL6y/YigCxHTX2FC7kc=;
        b=Yz9SMzH7/NisFswPNPMMSOLNrYfsqmxo1LOfWAH4/LWSEjIDr+QWeOpkP0VjTqprNm
         Jxd1z2nVWByAYfRRMcv3blSRBls5tAwE8kJ1+dicatBmplgXsZLKORUj6idn/xIUQ9cF
         SweVQ7uX1J9gGr0k64grtiGyBP6jOApClpGwiKCYERk7SjbuernKwsi53ozQ/0O1CGvp
         ArjXfIx1KuA6iLxdUilW20l9nwEkvdJzMVs5Z+7+2STNFigAHoO0Qzqsbxgj+YyQsfaD
         kWA7rC9XXNc7Y1DeKXoN4S4o8KpDQWFzeICREZHU7AMPmynAclLLZe2c+KSM2t48Mukf
         b2IQ==
X-Gm-Message-State: AIVw111e79PQksrVuYnNp/3WOOSrXDQ5V8/EPL5vKF1PlMW+eM/5lj+m
        QgKOa2qTaHEBcQ==
X-Received: by 10.98.56.195 with SMTP id f186mr21607088pfa.199.1499277404589;
        Wed, 05 Jul 2017 10:56:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id u194sm47629464pgb.24.2017.07.05.10.56.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 10:56:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
Date:   Wed, 05 Jul 2017 10:56:42 -0700
In-Reply-To: <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Jul 2017 04:00:36 -0400")
Message-ID: <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since its inception, the general strategy of the reflog-walk
> code has been to start with the tip commit for the ref, and
> as we traverse replace each commit's parent pointers with
> fake parents pointing to the previous reflog entry.
>
> This lets us traverse the reflog as if it were a real
> history, but it has some user-visible oddities. Namely:
>
>   1. The fake parents are used for commit selection and
>      display. So for example, "--merges" or "--no-merges"
>      are useful, because the history appears as a linear

s/useful/useless/ perhaps?

>      string. Likewise, pathspec limiting is based on the
>      diff between adjacent entries, not the changes actually
>      introduced by a commit.
> ...
> This commit adds several expect_failure tests, to show how
> the tool ought to behave.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

> diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
> new file mode 100755
> index 0000000000..bb847f797d
> --- /dev/null
> +++ b/t/t1414-reflog-walk.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +
> +test_description='various tests of reflog walk (log -g) behavior'
> +. ./test-lib.sh
> +
> +test_expect_success 'set up some reflog entries' '
> +	test_commit one &&
> +	test_commit two &&
> +	git checkout -b side HEAD^ &&
> +	test_commit three &&
> +	git merge --no-commit master &&
> +	echo evil-merge-content >>one.t &&
> +	test_tick &&
> +	git commit --no-edit -a
> +'

Mental note: logically, what we want to see in the log are:

    master:  one-->two
    side:                one-->three-->(evil)
    HEAD:    one-->two-->one-->three-->(evil)

where the middle one in HEAD is "switching from master to side".

> +test_expect_failure 'pathspec limiting handles merges' '
> +	sed -n "1p;3p;5p" expect.all >expect &&
> +	do_walk -- one.t >actual &&
> +	test_cmp expect actual
> +'

OK (it was a bit tricky to see why the topmost one should, but the
evilness of the merge makes it eligible).

> +test_expect_failure '--parents shows true parents' '
> +	# convert newlines to spaces
> +	echo $(git rev-parse HEAD HEAD^1 HEAD^2) >expect &&

I saw something related to this nearby this morning.  Good thinking
to add a comment on this 'echo' ;-).

> +	git rev-list -g --parents -1 HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'walking multiple reflogs shows both' '
> +	{
> +		do_walk HEAD &&
> +		do_walk side
> +	} >expect &&
> +	do_walk HEAD side >actual &&
> +	test_cmp expect actual
> +'

I somehow find this one a bit iffy.  

The order that commits appear in the "walk from HEAD and side at the
same time" may want to be different from what this test expects.
"rev-list --since=3.days -g master next", for example, would want to
refrain from reading the reflog of 'master' for all 90 days before
switching to the reflog of 'next', no?

All others I did not comment on and omitted from quoting make sense
to me.

Thanks.
