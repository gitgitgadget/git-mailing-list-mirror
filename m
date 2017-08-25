Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B490D208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbdHYUc7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 16:32:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754744AbdHYUc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 16:32:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDAC19B1FF;
        Fri, 25 Aug 2017 16:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OezdkrFhk//jfv0dZNlAPQDgbSA=; b=G6QUNn
        85Vt+akex7gO+xDcGEwQQ9MTkpq4hQbGXjKmy55WReJmC773LBmdZ0pQBzrd9jXy
        pzI41kpCS+6YjFLWc3ZbxomG6glkby5DMhZAD384AeYE0k8puLnAe+Ts0+kt6G/1
        ZehpjniwMSJpmjOgdKXjVjjTuJaw9rjRP0bdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMEhVyd2MXwZlQNALSEx3aj1QpcG7jGy
        X0oiAvPKqBzYFRp2mDiGYglEPonG2RECuS5rtNzmoIC2ttDs5qZe3K0TwImKIWdd
        zv5/7z2Z70+0oZasR5TyJFzrY+fpex2xOMDYeLl5sKDrZyOhfSngOGWHIIaSZ+MH
        pMl7CKsXnHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B43059B1FE;
        Fri, 25 Aug 2017 16:32:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14BA29B1FD;
        Fri, 25 Aug 2017 16:32:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v3 0/4] Incremental rewrite of git-submodules
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
        <20170824195051.30900-1-pc44800@gmail.com>
        <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZwpu9YXr5gSXWQBmqhXFB7+2rFWh6zVtRoiyQORkUsdg@mail.gmail.com>
Date:   Fri, 25 Aug 2017 13:32:50 -0700
In-Reply-To: <CAGZ79kZwpu9YXr5gSXWQBmqhXFB7+2rFWh6zVtRoiyQORkUsdg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 25 Aug 2017 12:15:24 -0700")
Message-ID: <xmqqd17js80d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 913F8C10-89D4-11E7-AEA5-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 25, 2017 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks.  I'll try to queue these before I'll go offline.
>>
>> Mentors may want to help the student further in adjusting the patch
>> series to the more recent codebase; unfortunately the area the GSoC
>> project touches is a bit fluid these days.  I resolved the conflicts
>> with nd/pune-in-worktree and bw/submodule-config-cleanup topics so
>> that the result would compile, but I am not sure if the resolution
>> is correct (e.g. there may be a new leak I introduced while doing
>> so).
>>
>> Thanks.
>
> Ok, noted.
>
> Presumably I'll review your dirty merge then for this series?
> (And later parts might go on top of the new dirty merge)

In my mind, GSoC mentors are there to help the student improve as a
developer, more than they are to help improving the immediate output
of the student.  So in that sense, I was hoping that you'd teach how
to work well together with other developers, when one's topic has
interactions with topics by others.  Making sure an inevitable evil
merge is made correctly is of course needed for the current topic,
but a more important skill to learn is to avoid the need to ask an
evil merge to be made by the integrator in the first place.


