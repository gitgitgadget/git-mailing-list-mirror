Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDFDC433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 12:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0D52225E
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438880AbgLLMxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 07:53:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54551 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgLLMxe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 07:53:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 988EF970C9;
        Sat, 12 Dec 2020 07:52:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=a9kpP2OmgcnRZFvRovxO+lhrUoY=; b=UW7P7pbP5R4KiCHwRwsY
        bhhw+Uh/FKUtmyMx1Bk6X7MBYl30IOyMMmLL851vh5W7mBGk4bJiLa0yZOfDLIoU
        dz7Wv6h9/kw1xXBRYhd8/gwwFLCyHDlsD3TN+Yqff+spzmnBPdJG2icO8/sINtRu
        EB/rk/ZjOoAJ9MOhlV+PsHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=le+RUToDX1PFYyiQbP9IV6nEeLJn98pmZos+x8HK0a7Apr
        hJFLnLm74BpS8ONrhzFNuFCmj52RIKmlnZWsKuYBLUUS3FF/b4jdlHrh3nFGzbXR
        s2mFG35du3hu8lGp64PIph9IIKSc8TMPyH3Rybr864aCD2v/vU3te5OPtVJ8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90A74970C8;
        Sat, 12 Dec 2020 07:52:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18FF7970C7;
        Sat, 12 Dec 2020 07:52:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
Date:   Fri, 11 Dec 2020 18:50:14 -0800
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <xmqqo8j0io39.fsf@gitster.c.googlers.com>
        <CAMP44s0uyxs4p+HJ5ZDrrKJs9wQW4tSCZzPonpvP=FcTGCcxSA@mail.gmail.com>
Message-ID: <xmqqv9d7faot.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F18D0566-3C78-11EB-8134-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> But that's not what I was referring to here.
>
>> I do not know if others on the list agree, though.
>
> This is what I was referring to. Initially there seemed to be some
> interest, and suddenly that interest disappeared.

Perhaps most of them are happy enough with the current behaviour.

Perhaps nobody cares strongly enough to say what they want to see,
as they fear that by speaking up they would be drawn into a
discussion that is needlessly hot and unpleasant.

>> I do agree that there is no agreement on the behaviour in the
>> endgame.
>
> See? I disagree.
>
> I think the endgame is clear. How we get there is where there's no agreement.

What you want as the endgame may be clear to you.

But I do not think there is clear concensus among people on the
list.

>> In principle, I am in favor of disabling the more
>> dangerous half of the "git pull" command for those who haven't
>> configured anything.  But I can understand those who do not want
>> that behaviour, as the fallout would be quite big.
>
> And who is that? Did anyone in the list express that they did not want
> that behavior?

I thought that you at least saw Dscho's reaction to the breakage
caused by "future" patch in response to one of the recent What's
cooking reports.  Doesn't that count "anyone on the list express"?

I am starting to feel myself that "don't do anything if this is not
a fast-forward" may be something that would have been great if we
had it from day one but is no longer a feasible default with
existing users, to be quite honest, so you can count my 20% as
another example.
