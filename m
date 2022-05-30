Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B79C433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiE3RU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiE3RU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 13:20:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8387C6A037
        for <git@vger.kernel.org>; Mon, 30 May 2022 10:20:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99D94143070;
        Mon, 30 May 2022 13:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9IaeAgcOcGLiRF5dxWS6VgipghUXBLoAhVwDOG
        gyITY=; b=AGkQ72hpG8j3sN+IU2ntIaD7VKT++Il8p2GjDKNS7WLpX0aKBnEsnZ
        dr6dKVuDvjBrSe1yL3ti6VRMGJ7xcPPn8dU/2lSgDnq+D+HzKV+INdV0/E4WGnxL
        Vf58/BpS2hrnY3nInWS0ULZ7vLGcRipeXjkTOuBXPveFZEoCOO15s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91A4314306F;
        Mon, 30 May 2022 13:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F41F214306D;
        Mon, 30 May 2022 13:20:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Excluding paths with wildcard not working with add -p
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
        <xmqqh758yz4u.fsf@gitster.g>
        <CAHd499BX_8fP=BdJW8cuZnwJFoqxrsiLCZ45Ke12MOsaj7M-Dw@mail.gmail.com>
Date:   Mon, 30 May 2022 10:20:50 -0700
In-Reply-To: <CAHd499BX_8fP=BdJW8cuZnwJFoqxrsiLCZ45Ke12MOsaj7M-Dw@mail.gmail.com>
        (Robert Dailey's message of "Sun, 29 May 2022 16:15:16 -0500")
Message-ID: <xmqqee0bx7gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB193C1E-E03C-11EC-A913-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> On Sun, May 29, 2022 at 1:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Does this command
>>
>>     git add -p -- . ':^*.cs'
>>
>> work as you expect?
>
> yes I can confirm this works.

Thanks for confirming; you helped a lot to come up with a fix that
is found at

https://lore.kernel.org/git/xmqqpmjwx8so.fsf_-_@gitster.g/


