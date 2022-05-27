Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DCC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiE0Py0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348574AbiE0PyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:54:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF213F412
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:54:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 137F9199FF5;
        Fri, 27 May 2022 11:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dO1FPpO+Kr5596T72Dds/baW7CGc7GNVE0V3P3
        5MuN8=; b=XAmmO3nHHfbn0mIcgvT8bPmIFK0SHewqBVw0YVTJYqYXzLrNBt/KgT
        8b/gWlcMbgflf8yO/3shaOFYz6ZnkoO/72U5bwfW3ZcjCjYr0Ex/FqjBgKiDqCgq
        GWl+1kaMXVqE5o1owJQdY+JARD3A1pKoErToFozv0zJfAnTYiBHgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B901199FF4;
        Fri, 27 May 2022 11:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A661C199FF1;
        Fri, 27 May 2022 11:54:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] rebase: help users when dying with `preserve-merges`
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <d0fb54105940f19809eeb5d5e156bf3889d16b0c.1653556865.git.gitgitgadget@gmail.com>
        <220526.867d687hd5.gmgdl@evledraar.gmail.com>
        <00229772-f075-0b0c-7810-7debf6b971bc@iee.email>
        <xmqq1qwgxbys.fsf@gitster.g>
        <c7667b0b-d18c-e2e4-0a9e-45367ee8ac0e@iee.email>
Date:   Fri, 27 May 2022 08:54:19 -0700
In-Reply-To: <c7667b0b-d18c-e2e4-0a9e-45367ee8ac0e@iee.email> (Philip Oakley's
        message of "Fri, 27 May 2022 13:58:27 +0100")
Message-ID: <xmqqzgj355uc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4597A6D0-DDD5-11EC-A8A5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 26/05/2022 21:42, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>>>> Make the `rebase --abort` option available to allow users to remove
>>>>> traces of any preserve-merges rebase, even if they had upgraded
>>>>> during a rebase.
>> This patch does not make it "available", though.
>
> Yes it does. Sorry if the terminology or explanation was poor (here we
> are looking at the commit message, not the user facing message?).

Sorry, you're right.  I misread the new "&&" condition in the patch.

> I hope to re-roll later next week. In general it's mainly tweaks and
> finesse.

Thanks.
