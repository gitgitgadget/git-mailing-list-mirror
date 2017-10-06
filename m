Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17E21FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 00:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdJFAry (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 20:47:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbdJFAry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 20:47:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9059397C5D;
        Thu,  5 Oct 2017 20:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qv0NnZdAxFhFGpt5vsFI11UhvxM=; b=GYL+V/
        UwUqEJ+MtpSjbUB3w0k//uHQjSXSduBYs2sQ0PKEBSI00pcDiNDuKZLiee/ZUIGV
        g6X80wqAystuvhhAQI1LtXHNT2ZsKahwv2tDkdlkoiwweziEpK9SUmKbqQNyAEYg
        kZRSoaViBCqIMUjQ5g2Mwh8owpi5RjPCDxjfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tOEuSORX81VIyCY3Re21LHwgFOIDaWU2
        FqtuShRU9iFUt0e2HFJdSkI7f9QwS4GOdgr0MCVHjD+BnxJXnt6SIxSbMTOjvQmr
        aqEAWkliufELcizNA3V+nmv2a1b24+Lzxq3szifc75bWeU8kl/vrZLFbu0Cjkqwh
        SrsQa0wqTk4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8829597C5B;
        Thu,  5 Oct 2017 20:47:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04F2B97C59;
        Thu,  5 Oct 2017 20:47:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is it "core.excludesfile" or "core.excludesFile"?
References: <alpine.LFD.2.21.1710051724350.2478@localhost.localdomain>
        <CAGZ79kZof3SWE_Pyb1ADVtkfD2+9ukV+nNBgwxt6xa52Vrmk6A@mail.gmail.com>
Date:   Fri, 06 Oct 2017 09:47:51 +0900
In-Reply-To: <CAGZ79kZof3SWE_Pyb1ADVtkfD2+9ukV+nNBgwxt6xa52Vrmk6A@mail.gmail.com>
        (Stefan Beller's message of "Thu, 5 Oct 2017 14:32:16 -0700")
Message-ID: <xmqqvajt5cg8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC404ECA-AA2F-11E7-9DA0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Oct 5, 2017 at 2:25 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>>
>>   more pedantic nitpickery, but the git source/docs seems to bounce
>> all over the place as to which of those forms is the right one.
>> opinions?
>
> In the code we use all lowercase to compare (any input is converted to
> lowercase);
> in the docs we try to come up with a sufficient cameLcase to not
> confuse the user.
> In tests, I don't know?

Unless the test is about making sure that section.var and
SecTion.Var are treated the same (and section.subsection.var and
section.subSection.var are treated differently), it is preferrable
to use multiWordSection.multiWordVar in tests for consistency and
for documentation value.
