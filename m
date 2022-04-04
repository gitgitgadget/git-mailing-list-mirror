Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE808C388F3
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379746AbiDDVUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379036AbiDDQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 12:21:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69630BC0B
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 09:19:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7789611591B;
        Mon,  4 Apr 2022 12:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1Fl62o08d/pRgMYTMUigIE0phqi3E7uC1+Tst
        aqqNY=; b=Oa3jAjf7p+Y0/xYMnI7CFUa2Rc3GM7q9EOFkd39Qss5YR51ostue66
        E46JwBXkNLZ6OGUyJHlhdQddLD58oJ8DW/OsWisMQKvxVdscpBLFRDfkqdMy61Ug
        kizDH6PGhToQGnTO19vRsu6LV7Q7ODeGpDJiMb5TSEMFy5py6ON8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F6EA11591A;
        Mon,  4 Apr 2022 12:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C96DB115919;
        Mon,  4 Apr 2022 12:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
References: <20220330190956.21447-1-garrit@slashdev.space>
        <xmqq5ynv6rb4.fsf@gitster.g>
        <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
        <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
        <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
        <xmqqsfqx28dv.fsf@gitster.g>
        <220401.86y20pnofb.gmgdl@evledraar.gmail.com>
        <xmqqtubcyeow.fsf@gitster.g>
        <f39ae520-a370-a1c5-7dcc-1b7bba4306bf@slashdev.space>
Date:   Mon, 04 Apr 2022 09:19:51 -0700
In-Reply-To: <f39ae520-a370-a1c5-7dcc-1b7bba4306bf@slashdev.space> (Garrit
        Franke's message of "Mon, 4 Apr 2022 09:18:17 +0200")
Message-ID: <xmqqbkxgstw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EEE5870-B433-11EC-9FB4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garrit Franke <garrit@slashdev.space> writes:

> On 01.04.22 18:02, Junio C Hamano wrote:
>
>> I do not think one extra level of "unknown option", even with hint,
>> is worth the trouble.  If we want to cater to those who expect "-h"
>> to be more special than random "-<some single letter>", we should go
>> all the way and make "-h" truly supported.  If we do not, they can
>> read "git help git" just like those who wonder what "git -X" means.
>
> From what I gathered, we all agree that adding the "-h" shorthand is a
> good addition to the UI. Given that the "-v" option is understandably 
> controversial, I could cut it from this patch.
>
> Thoughts?

I do not care too deeply, and it is the most time efficient to just
take the last patch as-is.  Nobody would care they used "git -h" or
"git -v" only once and learned to use "git help" and "git version"
anyway ;-)

