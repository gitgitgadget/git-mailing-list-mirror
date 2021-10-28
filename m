Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905EC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6475460F92
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ1T1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:27:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57972 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1T1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:27:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B585DF8C38;
        Thu, 28 Oct 2021 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Exk7NV0pVLmnkE9f7N+idj+Ha3ude7nr8UNm/o
        SiDrI=; b=rQ6ifaqVCNfSJz1w0Yq1qld2PhjFCLeWkn77dgRGLMqw0huQKbb5tv
        V8w4C1JQBn0IAL6CH2GS4YiB14aHPv+MxPmLWvQiX5ZrYwcOsSgFOkzECO2SUgD+
        Cw4PslAcUwRESdhUlQsrIJf0df6u5xEtpVBNJzwHi5FDghOD1n/Nk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC7B2F8C37;
        Thu, 28 Oct 2021 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15372F8C36;
        Thu, 28 Oct 2021 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git
 pull --no-verify"
References: <YXlBhmfXl3wFQ5Bj@pflmari>
        <YXlD5ecNSdeBSMoS@coredump.intra.peff.net> <YXlTpzrY7KFqRlno@pflmari>
        <xmqq4k92w7do.fsf@gitster.g> <YXpFTJTo0pKhM7xG@pflmari>
        <YXpZddOixrJDd//s@pflmari>
        <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
        <YXrFaJXbuSuwfhQ7@pflmari> <YXrFy9I1KPz3IZyp@pflmari>
        <xmqqv91hrt2y.fsf@gitster.g> <YXra5UgxtgVubJL/@pflmari>
Date:   Thu, 28 Oct 2021 12:25:13 -0700
In-Reply-To: <YXra5UgxtgVubJL/@pflmari> (Alex Riesen's message of "Thu, 28 Oct
        2021 19:16:21 +0200")
Message-ID: <xmqqmtmtq7dy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C70BA1DC-3824-11EC-BEB4-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> Junio C Hamano, Thu, Oct 28, 2021 18:51:17 +0200:
>> Alex Riesen <alexander.riesen@cetitec.com> writes:
>> 
>> > Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git pull --no-verify"
>> 
>> Perhaps
>> 
>>     Subject: [PATCH] pull: honor --no-verify and do not call the commit-msg hook
>> 
>> instead.
>
> Looks fine from my side. Shall I resend?

If you are OK with the updated text, then I can locally amend.
