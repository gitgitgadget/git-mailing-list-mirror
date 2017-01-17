Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86ED20756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbdAQTvt (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:51:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57241 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750830AbdAQTvt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:51:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 262F661ACB;
        Tue, 17 Jan 2017 14:45:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LunHQPEVrBiNf0nK/SCQeQQlS9g=; b=XQSLZf
        tXE4bidYdH9CiBA+jOUg1Y8rAXbBqKi+CzWUgy0KzcQeRTSOPocnMnS2g2RQNAdo
        OsZHiOYx6+HrFOO81Sr20zAQEyTQJiadj2cP+oG10AoEwVOKeieHrBkgq9BclzGo
        vnNwShiaWujbT1Pb7dGW4Cn2YbqkuDQmQCH4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AZU+aqaTjQUIa1etCtTQMGTaPh6WdaTT
        PmcDl6AynIMA3ysG31uf8oQf3xzfxe5Zn/5+KhCzD9U/e4mgGih+hX2vNQ/QnkZa
        8FC3flnGT6/74chUIdaP1sRmkE6wj7jw0xxM2eoIUbm27r83XYC/W577J+GnoUNZ
        +OQotFIWRyo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B87461ACA;
        Tue, 17 Jan 2017 14:45:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C45261AC9;
        Tue, 17 Jan 2017 14:45:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701161226090.3469@virtualbox>
Date:   Tue, 17 Jan 2017 11:45:41 -0800
In-Reply-To: <alpine.DEB.2.20.1701161226090.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 16 Jan 2017 12:28:49 +0100 (CET)")
Message-ID: <xmqqbmv5fp22.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8849E450-DCED-11E6-B514-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sun, 15 Jan 2017, Junio C Hamano wrote:
>
>> * js/prepare-sequencer-more (2017-01-09) 38 commits
>
> I think that it adds confusion rather than value to specifically use a
> different branch name than I indicated in my submission, unless there is a
> really good reason to do so (which I fail to see here).

I've been meaning to rename it to match yours, for the exact reason.
The only reason was I needed my time spent to deal with other
topics, and reusing the same topic name as I used very first time
was less work.  I'll find time to update it (if you are curious, it
is not just "git branch -m").

Thanks.

> The only outstanding review comments I know about are your objection to
> the name of the read_env_script() function (which I shot down as bogus),

Not the "name", but the implementation not sharing the same code
with "am" codepath even though they originate from the same shell
function and serve the same purpose.

> and the rather real bug fix I sent out as a fixup! which you may want to
> squash in (in the alternative, I can mailbomb v4 of the entire sequencer-i
> patch series, that is your choice).

I'd rather see the "make elengant" thing redone in a more sensible
way, but I feel that it is waste of my time to help you see the
distinction between maintainable code and code that happens to work
with today's requirement, so I give up, hoping that other people
will later refactor the code that should be shared after the series
lands.  I'll squash the fixup! thing in, and as I already said a few
days ago, I do not think we'd want v4 (rather we'd want to go
incremental).
