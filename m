Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913CC4321E
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiB1Snk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbiB1Sm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:42:58 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79639689
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:39:32 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46F3C182903;
        Mon, 28 Feb 2022 13:39:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XAg7Y75FV0UxfWXeJ/dn4lxXQ7/5YhXyRmazdL
        gANDU=; b=RvqAbWVIUQuwSY7vIwmUmFvgsdmC728YXmzZlMLI/HJxpma9l2PyJx
        pnMk5aXCO9fKZbVm0GWZowYG2MM5ELMYU59a0lemVlKFYmv59yBAAN0cDfs2rcAK
        +tyXIso7VNwaetc3EXpQCNMmJMJW4Zib2cibuq16Js1GHG/yRYT2o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FED6182902;
        Mon, 28 Feb 2022 13:39:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1D4A182901;
        Mon, 28 Feb 2022 13:39:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 23/30] t/helper/test-chmtime: skip directories on
 Windows
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <6cba1d950b013410ecc6ffc15bfcba02c51d6de2.1644612979.git.gitgitgadget@gmail.com>
        <CAPMMpogycjDdoFR2kzLypb48LSQW_vU=yaeaMKdM1Thd+J3DUg@mail.gmail.com>
        <73a47838-2f9e-dccb-9aaf-6eb143906d36@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 10:39:28 -0800
In-Reply-To: <73a47838-2f9e-dccb-9aaf-6eb143906d36@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 28 Feb 2022 12:49:58 -0500")
Message-ID: <xmqqv8wy25un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3884CAC-98C5-11EC-8F9D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/28/22 4:43 AM, Tao Klerks wrote:
>> Random follow-up on this: in message/patch
>> 76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com
>> I propose a fix to this issue. If accepted, that fix (and related
>> changes to rely
>> more heavily on chmtime in t7063) will cause *this* change to cause test
>> failures.
>> If that patch is accepted, this commit will simply need to be
>> dropped
>> as far as I understand.
>> 
>
> Thanks for the note.  Yes, with your change we should be able to
> drop or revert this commit.

That sounds nice.  The fewer differences among platforms we have to
maintain, the easier.
