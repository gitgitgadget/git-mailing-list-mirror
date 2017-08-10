Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62E2208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbdHJR2t (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:28:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbdHJR2s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:28:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75C3B8D0CC;
        Thu, 10 Aug 2017 13:28:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=znQ05FvdOci+rbFO1A8Gf8xKuGM=; b=mnI60O
        HBL+Wo7H7fMtfeu1P12vLC9JvpeCWloOS2mItpBtERKGLclW9kUpw5BDAtA5Ox14
        qzegVyUuVZcMf7xHu2wUH1f+e0hcYNEZgq7INmfwjnNvNuavBdhJhwCRFgXpfVkS
        tn49NWrRr9MGdu5hNciCkQaP+pdcmIQUIi714=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FzYdmCIxSGYSOuH1k/g6sKNsvh5o4eur
        JlhUwCUVOlq0tkI4If2DnTiVOJyW/gVBo/TPlYzLLQdknhhPb7+hhKgqStkDbM0O
        cYAKGVA3eD0f9e9ouK3c7Qatf51F9/dxoGEel86sLQD6tdmJeYyBn+pzHRXZinUL
        Yp+LedrlBks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ED5E8D0CA;
        Thu, 10 Aug 2017 13:28:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA8668D0C7;
        Thu, 10 Aug 2017 13:28:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
        <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
        <20170808182324.GB73298@google.com>
        <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
        <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
        <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
        <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
        <20170810171545.GC73298@google.com>
Date:   Thu, 10 Aug 2017 10:28:38 -0700
In-Reply-To: <20170810171545.GC73298@google.com> (Brandon Williams's message
        of "Thu, 10 Aug 2017 10:15:45 -0700")
Message-ID: <xmqqzib749ix.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 596E551C-7DF1-11E7-BE5B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 08/10, Junio C Hamano wrote:
>
>> I vaguely recall that there was a discussion to have SubmitGit wait
>> for success from Travis CI; if that is already in place, then I can
>> sort of see how it would help individual contributors to have the
>> style checker in that pipeline as well.  
>> 
>> I have a mixed feelings about "fixing" styles automatically, though.
>
> I still think we are far away from a world where we can fix style
> automatically.  If we do want to keep pursuing this there are a number
> steps we'd want to take first.
>
> 1. Settle on a concrete style and document it using a formatter's rules
>    (in say a .clang-format file).  This style would most likely need to
>    be tuned a little bit, at least the 'Penalty' configuration would
>    need to be tuned which (as far as I understand it) is used to
>    determine which rule to break first to ensure a line isn't too long.

Yes.  I think this is what you started to get the ball rolling.
Together with what checkpatch.pl already diagnoses, I think we can
get a guideline that is more or less reasonable.

> 2. Start getting contributors to use the tool to format their patches.
>    This would include having some script or hook that a contributor
>    could run to only format the sections of code that they touched.

This, too.  Running checkpatch.pl (possibly combined with a bit of
tweaking it to match our needs) already catches many of the issues,
so a tool with a similar interface would be easy to use, I would
imagine.

> 3. Slowly the code base would begin to have a uniform style.  At
>    some point we may want to then reformat the remaining sections of the
>    code base.  At this point we could have some automated bot that fixes
>    style.

I suspect I am discussing this based on a different assumption.

I think the primary goal of this effort is to make it easier to
cleanse the new patches that appear on the list of trivial style
issues, so that contributors and reviewers do not have to spend
bandwidth and brain cycles during the review.  And I have been
assuming that we can do so even without waiting for a "tree wide"
code churn on existing code to complete.

