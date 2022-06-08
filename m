Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94057C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 16:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbiFHQJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbiFHQJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 12:09:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A881F700E
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:09:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5942D12D503;
        Wed,  8 Jun 2022 12:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wPpLlA7xoW4/MfYOLpS3FdeeXMohJcMveIKKLo
        eVKvU=; b=Vuo/sRaM66G3dETw8YZuSrbwJPrN+AMwrwOslZUlHTkrZBPWLnDWCG
        WK5AZp700oeNC7Jt2PmuD5IB69h7dvmij3LjauZGGEO7uBaQJnb/Fk1K0290Q41I
        9CBHwPAHau3z6X0X868By1bYpwc8jchCyuV7PQxppuKBkEXaABDRw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E02712D502;
        Wed,  8 Jun 2022 12:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9941F12D4FF;
        Wed,  8 Jun 2022 12:09:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] ls-files.c: add --only-object-name option
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
        <220606.86zgipvg7e.gmgdl@evledraar.gmail.com>
        <CAOLTT8Sz3q2db1fRcHp7Exnarw4sMCnUfAF6bot+pwYxmXJjiw@mail.gmail.com>
Date:   Wed, 08 Jun 2022 09:09:24 -0700
In-Reply-To: <CAOLTT8Sz3q2db1fRcHp7Exnarw4sMCnUfAF6bot+pwYxmXJjiw@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 8 Jun 2022 22:38:47 +0800")
Message-ID: <xmqq7d5rrvbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF1423A-E745-11EC-8A86-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> But in any case shouldn't this be called --name-only to go with "git
>> ls-tree"'s version of this? Or is there some subtle difference I'm
>> missing...?
>
> Eh, git ls-tree --name-only will only show file paths, so maybe
> --only-object-name will be better than --object-name-only in git
> ls-files.

Yeah, it is not "--name-only" which is about paths, but
"--object-name-only" would be more correct but it is a tad long.

I think ls-tree learned "--object-only" for that fairly recently.
When in doubt, always check the documentation of a similar command
for inspiration.

Thanks.
