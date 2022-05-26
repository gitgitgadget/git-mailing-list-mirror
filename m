Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA5C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiEZUBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiEZUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:01:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE7B36C5
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:00:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BF2419EFA8;
        Thu, 26 May 2022 16:00:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PjNQdgfMOSDwRBGlbPNvXWPEVOIv0x7ipezB3q
        u4xOg=; b=qVO8kbq+5P8lO+vb+HiBorQSzYSsf5+MfJtzw8b1qU2CVfugSDggaL
        Iv/B39yikBKUUXcM2TvsCh+kzhVED3ffBmC5ZQxfhpSmMf4neCcRvaxJig+aJuiB
        sElHD4y6rN3Vfbg5haq3CJ5H70WNMlIA9FOB6DN8L7QByp/dB6A24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9470C19EFA7;
        Thu, 26 May 2022 16:00:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E04319EFA6;
        Thu, 26 May 2022 16:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: js/bisect-in-c
References: <xmqqzgj41ya2.fsf@gitster.g>
        <220526.86r14g3yya.gmgdl@evledraar.gmail.com>
        <xmqq35gwyth3.fsf@gitster.g>
Date:   Thu, 26 May 2022 13:00:53 -0700
In-Reply-To: <xmqq35gwyth3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        26 May 2022 12:38:48 -0700")
Message-ID: <xmqqo7zkxdvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CCB6052-DD2E-11EC-92E7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>>  Final bits of "git bisect.sh" have been rewritten in C.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
>>
>> This topic has outstanding regressions in CLI parsing. I.e. we'll now
>> offer to start bisection where we previously errored out on invalid
>> command usage. See my replies in that thread.
>
> Pointers?

I guess you meant this one?

https://lore.kernel.org/git/220521.86zgjazuy4.gmgdl@evledraar.gmail.com/

