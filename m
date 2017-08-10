Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F35208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 16:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbdHJQlr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 12:41:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbdHJQlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 12:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 830758912B;
        Thu, 10 Aug 2017 12:41:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sINf+0TuuJX3iyiqffAzOcE25wU=; b=QhyZri
        ZjKNIKpmI2tGra/lgAkd7ZkfSsVh+iCxu6ywFHjqJJhUFKpUjRh7zhxty/9GT9vy
        LzsJR6nBa34g9GQevbS/ocUSKezminscWzJJJ8kgToB/UfzGAjXUWRr1pGicIvhO
        JTEOmGsSWgg6QNyRbsvHhWBKcFlSUZ85YREEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k6Y31wiZbf3zpvwGuK/HJd2pr5XKvcwy
        1Dw12Z82z5pzdXcVVWbsDeeMTOfXlNmo5xKt4HMuB8ztm0YZIm7ruLAgW3PVPSm0
        ugBQAKHKjkJN97PiV6XgFcTo1q0I6W8Papj6uVtLD1poDSUrlky6a1gpcqyGuojj
        xbTS17EYTIs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79FB88912A;
        Thu, 10 Aug 2017 12:41:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E851789128;
        Thu, 10 Aug 2017 12:41:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
        <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
        <20170808182324.GB73298@google.com>
        <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
        <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
        <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
Date:   Thu, 10 Aug 2017 09:41:41 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708101137190.11175@virtualbox> (Johannes
        Schindelin's message of "Thu, 10 Aug 2017 11:38:09 +0200 (CEST)")
Message-ID: <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA673AA6-7DEA-11E7-9C94-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 9 Aug 2017, Stefan Beller wrote:
>
>> > I am sure that something even better will be possible: a Continuous
>> > "Integration" that fixes the coding style automatically by using
>> > `filter-branch` (avoiding the merge conflicts that would arise if
>> > `rebase -i` was used).
>> 
>> I do not quite follow. Is that to be used by Junio while integrating
>> branches?
>
> I was more thinking about a bot on GitHub. "Code cleanup as a service".

I vaguely recall that there was a discussion to have SubmitGit wait
for success from Travis CI; if that is already in place, then I can
sort of see how it would help individual contributors to have the
style checker in that pipeline as well.  

I have a mixed feelings about "fixing" styles automatically, though.

