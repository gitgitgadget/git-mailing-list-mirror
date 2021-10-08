Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB6C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6A460F5D
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhJHV7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:59:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55245 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJHV7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:59:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73A1BE3E61;
        Fri,  8 Oct 2021 17:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m/Jn8GEMKVqVg9edieRjmWz0hHt6RDhiPK9Sjv
        XSSoQ=; b=f43LrSwEJJbuluuGi+acp/rSF11aHraKkK/iF+YeOZHe0A+oagYch0
        sP1K+FiEBXeuoF4Uv+mwyRVb/zvNNm8HCAltdkNO4cwhApZD3p4G8SsEMEfnq5Ln
        0ioMC7FzO5iBqfnckFzc5Ay4uPuxJZlWWa5zTgpp8TH8T4SXYkASk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C783E3E60;
        Fri,  8 Oct 2021 17:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 580BCE3E5F;
        Fri,  8 Oct 2021 17:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
References: <xmqqfstdr8b5.fsf@gitster.g>
        <YV5aaD418SyZqS/1@coredump.intra.peff.net>
        <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
        <87sfxdgtpu.fsf@evledraar.gmail.com>
        <YV/EnxkTvWWZ6xVD@coredump.intra.peff.net>
        <xmqqsfxbjncz.fsf@gitster.g>
        <YWCn4tpr9RWsRxvr@coredump.intra.peff.net>
Date:   Fri, 08 Oct 2021 14:57:20 -0700
In-Reply-To: <YWCn4tpr9RWsRxvr@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 8 Oct 2021 16:19:46 -0400")
Message-ID: <xmqqpmsfi3i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6778072-2882-11EC-A962-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 08, 2021 at 01:03:08PM -0700, Junio C Hamano wrote:
>
>> I usually have at least two pushout of 'seen' (one with the full set
>> of 'seen' including known-to-be-broken topic integrations, the other
>> with seen~$some_hopefully_small_number that I didn't see brekaage in
>> my local build), and then on graduation days 'next' and 'master' are
>> also updated, so 3 is cutting very close ;-)
>
> Hmm, yeah. They say "21 builds per week", which would be plenty (you
> don't push out integrations every day),

'seen' is pushed out every day (not on weekends), though.

> I'm not sure what happens when you hit the limit. If it just silently
> skips the analysis, that's fine (we'll pick up the changes the next
> day). If it causes a CI failure that nags you, that is less good. But
> probably something we could work around in the Actions commands.

Yup.
