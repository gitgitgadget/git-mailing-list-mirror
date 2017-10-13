Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C2A20372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755985AbdJMAhb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:37:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753286AbdJMAha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F303FAF454;
        Thu, 12 Oct 2017 20:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GEEm9ifKe+oo5KF11LTHW84Hd/w=; b=AOJe8O
        b2kSHXFQj+5gv2482whN+nWbq4jDg490K7Bp/nstBJyZ76oLfzhMam2hO97B6n1W
        iS9/+VpcQNK2shmWngeiFSHnVUgmMflh0uuyh8jhaLaBc/nTmcsSIhsc4oa7HKpm
        kXKFXqUsW1BQMoxlUwRjHEr9Q3O4j9qiZIzDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FPq5nmgujy2Gw/c7TSueT7dA9yzpxeCU
        ZIUoX7cXu5o/B8JEiP2VNfIYVBP31lGj7qTX7QpXot2GYGdsNOoaH2Uutm4ubazf
        fUrpmX9DclPqick1TOg+93zcOGReJfBZ6Gbpz3eCgxcBB3ub7cGDAccHpZJmkihK
        BV0Sbbb5Rm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAC7EAF452;
        Thu, 12 Oct 2017 20:37:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A232AF451;
        Thu, 12 Oct 2017 20:37:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        christian.couder@gmail.com, peff@peff.net,
        thais.dinizbraz@gmail.com
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
        <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
        <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
        <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com>
        <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
Date:   Fri, 13 Oct 2017 09:37:28 +0900
In-Reply-To: <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
        (Marius Paliga's message of "Thu, 12 Oct 2017 16:59:47 +0200")
Message-ID: <xmqq1sm7yjav.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B174B226-AFAE-11E7-846A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> Thank you for your coments and explanation.
>
> Just one thing:
>
>>  - After parse_options() returns to cmd_push(), see if push_options
>>    is empty.  If it is, you did not get any command line option, so
>>    override it with what you collected in the "from-config" string
>>    list.  Otherwise, do not even look at "from-config" string list.
>
> The idea is that there are default push options (read from config) that are
> always sent to the server and you can add (not overwrite) additional by
> specifying "--push-option".

I can imagine that sometimes giving a base from a configuration and
then adding more for specific invocation may be useful.  

But I do not think of any --command-line-option and config.variable
pair whose configured value cannot be overriden by the command line
option; we should strive to avoid making --push-option a special
case that the users need to aware of, and more importantly, users
other than you who expect the more usual "command line overrides"
behaviour should get that.

Your "I wanted to accumulate, so I made so and made it impossible to
override" won't fly as a justification.  The default should be
"command line overrides", and if you need a way to allow command
line to add without overiding, that should be added as an optional
feature.

	[alias]
		mypush = push --push-option=foo --push-option=bar

may give you a set of push-options that are always in effect (they
are not even "by default") and cannot be overriden.

