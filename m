Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C351ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiISQwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiISQvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:51:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBB83ED5F
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:50:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27A4A14E508;
        Mon, 19 Sep 2022 12:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sFd4KmwrU5KdajMqQ62jSb/6TVZOGZAB0UX9e+
        aLsdU=; b=f+4mTmKvcpsUxDoowT7MCh4NncrRbFy3Tb+sXsPHhQ+5yFnz/7OCSF
        kwS2YJP/Xm9/Quc4yijfquaoKjBaA9+H8fHMZl7x/WkP8JhqcdvJ8jd2+6WBD7VV
        7wIHuKt3qasvSdU/zsnGXe17LHlC2zxcnWEgNkAz4leXVpgVU5vt0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA0014E507;
        Mon, 19 Sep 2022 12:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E2D214E504;
        Mon, 19 Sep 2022 12:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v8 2/5] fsmonitor: relocate socket file if .git
 directory is remote
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
        <CAPig+cScMtqKg2Ke8XK2FQ+XSeLRof0mvKk_uGPFC6eriUOdDw@mail.gmail.com>
Date:   Mon, 19 Sep 2022 09:50:31 -0700
In-Reply-To: <CAPig+cScMtqKg2Ke8XK2FQ+XSeLRof0mvKk_uGPFC6eriUOdDw@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 17 Sep 2022 00:13:45 -0400")
Message-ID: <xmqqy1ufb960.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CD4E26E-383B-11ED-A3BC-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Sep 16, 2022 at 9:12 PM Eric DeCosta via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +}
>> \ No newline at end of file
>
> This file probably wants a final line terminator.

definitely ;-)
