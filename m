Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8F4C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07DC23444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbhAGV0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:26:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57863 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAGV0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:26:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31D25AB0B9;
        Thu,  7 Jan 2021 16:25:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kW1DFhx2lTFMd+e8jBd8eoVDDsY=; b=rHOWc1
        1VLbQGYih+Uxp9++Slk5UXAf5l6OEXIt/tp1KubT+VqUfkpM/fYu4yPdQIfd4hSH
        ACUu4BN+MnxLXhV6kXfvVHDr3PbTMIuIxATrovgZ+1M+3hVsOE9IYm/GuqzIMMf3
        XqkyN+Q+q6y/8DKEf/4XUTH9NP4ZQpOuC/mGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UVz5A7UDcWWu3LM0mWoj1GEaGVEogKRi
        TCpTm3MKey4inlYihHDGdtM40BCAJNmZnqfeq9lxdt4XdD+11GdjtVOHwSVnhZ4k
        0JRtG4iEVEzO+DHMWTxWgc5nrbMXUo9mr5U3uA1bQeSDLcdFxTv0OiOqX3jaKGoj
        LPC89OXR6qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28B6AAB0B8;
        Thu,  7 Jan 2021 16:25:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99C3BAB0B7;
        Thu,  7 Jan 2021 16:25:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
        <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
        <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
        <87wnwordzh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Jan 2021 13:25:23 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 7 Jan 2021 17:20:22 +0100
        (CET)")
Message-ID: <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAD248D4-512E-11EB-BFD3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would not call that a fix. As mentioned, I could not come up with a way
> to Cc: Junio only when appropriate in a way that wouldn't surprise new
> users. So yes, I disabled the auto-Cc:ing, with no appropriate
> replacement.
>
>> I.e. now users need to explicitly add "cc: gitster@pobox.com" to the
>> description, no? So isn't in the same as for us who use the
>> format-patch/send-email flow in this regard?
>
> Right. And that is... intuitive? If you have to read the manual, the
> design is broken.

Let's step back and think when a patch submitter wants to CC
anybody.  People explicitly Cc area experts when touching certain
part of the codebase, so that they can ask for their input.  People
also explicitly Cc the maintainer when they see the reviewers
reached a consensus that it is a good idea to apply the patch.
These CC has value only because they came from conscious decision
by the submitter---they actively asks for help and that nudges the
recipient of CC to help them.

Even without such Cc:, stakeholders (both area experts and the
maintainer) often notice noteworthy patches and discussions, so
between having CC that is thrown around freely without thought and
crowds recipient's inbox and not having such thoughtless CC at all,
the latter is vastly preferred.  The former just diminishes the
value of Cc that are added manually by thoughtful people.  

In short, "now users need to explicitly add" is a GOOD thing.  

The best is to have only thoughtful CC, the second best is not to
have automated CC at all, and the worst is always throw automated CC
to hurt others who try to make CC mean something by making judicious
use of it.

Having said all that.

We may not be able to automate the thinking part to decide when
submitter may want to get help, but an automation can help by giving
the submitter cues and clues when to ask for help and from whom.

Is there a point in the end-user experience flow, starting at the
time when they push their proposed change to their repository, throw
a pull request at GitHub, say "/submit", and then GGG finally sends
out a patch e-mail, where the GGG machinery can inspect the change
and give the user (preferrably before the user says /submit) a hint
that says "you may want to add Cc: to these people in such and such
case, and if you think the situation falls into these cases, tell me
so by saying /submit-with-suggested-cc instead of the usual
/submit"?

And "these people" may include those who touched the affected code
within the past 6 months, and it may also include the maintainer
when the pull request is in its second or later iteration.

Thanks.
