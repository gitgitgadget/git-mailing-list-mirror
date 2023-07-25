Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC30C001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 16:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGYQuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGYQul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010421FC4
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 09:49:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 703AE30D94;
        Tue, 25 Jul 2023 12:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lWFuaOtjQz32Sb/hnwFJj7kWQbU5WU7cUPH3m
        8N8v4=; b=SBAejvCbSY5iV9zF/ETUcIJBJv9iYgo4oDZkp1KDM1MN3noiwtFL1g
        Yd5pGKWnbJxc3GXyoD3CBmBgvc0SpDKIhZTOxAwmP5nfj/Ee6g4izWfskNdCQiIJ
        yJITMPof74qDyc3v8L4FXNaFiSs5gMeKWPsDgnJYva6HKuJ9jIim0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 688BA30D93;
        Tue, 25 Jul 2023 12:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B871230D92;
        Tue, 25 Jul 2023 12:49:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Andreas Herrmann <aherrmann@suse.de>, git@vger.kernel.org
Subject: Re: [PATCH] t4002: fix test #63 (missing whitespace)
References: <20230725063516.27242-1-aherrmann@suse.de>
        <CAPig+cS8=iJD4fwvSacvWTK0WUH_DyjkQuMVP00aV+e4Q4TL3g@mail.gmail.com>
Date:   Tue, 25 Jul 2023 09:49:01 -0700
In-Reply-To: <CAPig+cS8=iJD4fwvSacvWTK0WUH_DyjkQuMVP00aV+e4Q4TL3g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 25 Jul 2023 03:10:15 -0400")
Message-ID: <xmqqwmyolywy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2902A342-2B0B-11EE-AC6B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for finding this problem and submitting a fix. You're the
> second person to do so[1].
>
> [1]: https://lore.kernel.org/git/pull.1545.git.git.1689341410476.gitgitgadget@gmail.com/
>
>> diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
>> @@ -401,9 +401,10 @@ test_expect_success 'diff-tree B A == diff-tree -R A B' '
>>  test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
>>         git diff-tree -r $tree_B $tree_A >.test-a &&
>>         git diff-tree -r -R $tree_A $tree_B >.test-b &&
>> -       cmp -s .test-a .test-b'
>> +       cmp -s .test-a .test-b
>> +'
>
> This minor style fixup could be resubmitted as a standalone patch,
> though it might be too minor to worry about.

Thanks for a quick review and encouraging words.  I do not mind a
patch with only the above hunk but of course the title and the log
message would have to be updated ;-).
