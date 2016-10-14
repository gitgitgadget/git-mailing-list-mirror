Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDEB1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754982AbcJNQKx (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 12:10:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754482AbcJNQKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 12:10:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B8004672A;
        Fri, 14 Oct 2016 12:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JJ+hEFujXT67+3Z1h0fx3z8iOw=; b=myIdqi
        oQHK7LmVGslIVbRwSKcDr2xEJ3oGC15tVHh73aN8wwnnXTKWasQRsoBC9//nrGMg
        KEvWnhfolOz8Ja64d0UGuW+DwbnsRctvfLTmNlTts/z8CdNzmx4s5WTIQMvlc71M
        LEoZDC1NrFJq1dD5cIAAKEgjbZ6IWOKp5gwPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ElF12do85X42psmbob6nGByZsSD5f2iu
        leQSE7cCHc4Ee06goAweN1tdEJPOdDBop19TnhQOg/hhNSz2CXgu6suMvq/XuWh+
        Be7aBsaFdoYnAnDmldvWEQT9KJjoawQphNuhtqAz435ovv+DMLndiHuIE/FUr/1u
        F7IYAvMvGxg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D24C46728;
        Fri, 14 Oct 2016 12:10:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 371F546725;
        Fri, 14 Oct 2016 12:10:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
        <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610131439400.197091@virtualbox>
Date:   Fri, 14 Oct 2016 09:10:00 -0700
In-Reply-To: <alpine.DEB.2.20.1610131439400.197091@virtualbox> (Johannes
        Schindelin's message of "Thu, 13 Oct 2016 14:40:50 +0200 (CEST)")
Message-ID: <xmqqzim6zzc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC03ED6-9228-11E6-82EC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
>> >>   (merged to 'next' on 2016-10-11 at e37425ed17)
>> >>  + submodule: ignore trailing slash in relative url
>> >>  + submodule: ignore trailing slash on superproject URL
>> >>
>> >>  A minor regression fix for "git submodule".
>> >>
>> >>  Will merge to 'master'.
>> >
>> > Going by the bug report, this *may* be more than
>> > minor and worth merging down to maint as well, eventually.
>> 
>> The topic was forked at a reasonably old commit so that it can be
>> merged as far down to maint-2.9 if we wanted to.  Which means the
>> regression was fairly old and fix is not all that urgent as well.
>
> And if you merge it to `master` and `maint`,...

I'll mark it as "wait for follow-up fix" in whats-cooking.txt (on
'todo' branch) to remind myself not to merge it yet.

Thanks for reminding.

As I was mostly offline yesterday, it will take a while until I
clear my backlog on the list.

