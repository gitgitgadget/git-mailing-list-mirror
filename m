Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E801F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 04:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdKHEG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 23:06:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55454 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751109AbdKHEGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 23:06:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57C1AB9AE4;
        Tue,  7 Nov 2017 23:06:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pMyAvoiitl2hB0A15Xt0wI5mCUI=; b=r6TVkA
        wOTmgFfeH1jGl2o5oACeK2B8GSkiJUV+2jaCwhjd4gZnNGmA1Nc9NZ4ZFIC/mYbq
        VogkB5Q5Rx6vxGGLEqGFziyYV0Dv/gN0nXGciyfIKIJzNkJ00rRMXXNCLtQ6srdm
        lrJW5kyb7HBB1sLUFYcsgT78TiW4hFOzvgvDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mcKEsnBafuAJSIUXRwTOvhp5eqQQZual
        cTSWhZIyqeBoneY9qSLE9ta5GtjltB/ppxzqY5fANJiwYrZDVrli2/mLVEcfXK+L
        FggGQBKv3qDsPspu8vg3FNJ21ZjkmUN5qxdB3GYckdg2mM5EnCYy3/vu5co5TvGD
        +LxOvBWkFIU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FE5DB9AE3;
        Tue,  7 Nov 2017 23:06:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE78EB9AE2;
        Tue,  7 Nov 2017 23:06:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
References: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
        <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
        <xmqq7ev1mrdi.fsf@gitster.mtv.corp.google.com>
        <CAFA_24+bhK5i1Rbp+04+g1Zo6Z8zpmobb5DcJBEtuG1NMBZ8-A@mail.gmail.com>
Date:   Wed, 08 Nov 2017 13:06:50 +0900
In-Reply-To: <CAFA_24+bhK5i1Rbp+04+g1Zo6Z8zpmobb5DcJBEtuG1NMBZ8-A@mail.gmail.com>
        (Max Rothman's message of "Tue, 7 Nov 2017 22:30:05 -0500")
Message-ID: <xmqqvaill8h1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FF0BAFA-C43A-11E7-9760-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Rothman <max.r.rothman@gmail.com> writes:

> How about this:
>
> The bash completion script knows some options to "git log" and
> "git show" only in the positive form, (e.g. "--abbrev-commit"), but not
> in their negative form (e.g. "--no-abbrev-commit"). Adds them.

s/Adds them/Add them/; we speak as if we are giving an order to 
the codebase to "become like so" (or to the patch monkey to "make
the code so").

> Also, the bash completion script is missing some other options to
> "git diff", and "git show" (and thus, all other commands that take
> "git diff"'s options). Adds them. Of note, since "--indent-heuristic" is
> no longer experimental, adds that too.

Likewise for the two "adds".

>>> ---
>>
>> Missed sign-off?
>
> Whoops, there doesn't seem to be a way to add that separately from the
> commit message in the submitGit interface. I'll try adding it, but
> gmail might turn all the tabs into spaces, so if it does, I'll try to
> figure out how to resubmit.

I would imagine that the cleanest way is to "commit --amend" and
have submitGit see that updated/corrected copy.

Thanks.
