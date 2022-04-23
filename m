Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5989C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiDWQhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiDWQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 12:37:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850F2F028
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 09:34:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAF37189CF0;
        Sat, 23 Apr 2022 12:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=arriNmk2NAtMcci0DrHyvLwCIRn90VZXczGJlg
        UOKcg=; b=o0OONrxepDD3BPXDBrbgV4UVSN0mWibtn7p0bIQF2Uztd2j/BV1cS5
        fV0TqCCnq2lWHYW+ML6/7qI/XwZ74ch04LyYkFGMnRVuTwefO5lQhKhRrz8X5ZeL
        Icejsos0B8ywEKRK2DzY1O9ME3x/o3ATzfC/tHO0LUWuZAL6hUpjI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D470E189CEF;
        Sat, 23 Apr 2022 12:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CB06189CEE;
        Sat, 23 Apr 2022 12:34:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] rebase - recycle
References: <20220422183744.347327-1-eantoranz@gmail.com>
        <xmqqsfq46b4p.fsf@gitster.g>
        <CAOc6etYMyA3JWX7ZtvQoB2e66f7QVyabOrLTpwgP9XBRoipgfQ@mail.gmail.com>
Date:   Sat, 23 Apr 2022 09:34:31 -0700
In-Reply-To: <CAOc6etYMyA3JWX7ZtvQoB2e66f7QVyabOrLTpwgP9XBRoipgfQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sat, 23 Apr 2022 11:17:02
        +0200")
Message-ID: <xmqq4k2j3giw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4107B08C-C323-11EC-94C0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

>> If it is NOT even interesting and useful enough to make you want to
>> polish and perfect it, even when you were the only user, why should
>> we be interested?  Even if your userbase starts at zero (or one,
>> counting yourself), if you make it so good, other people will come
>> to you, begging you to add that to the public tool.
>
> That is on top of "let's fork this project"? That is saying something
> :-D (point taken, just in case).

Absolutely.  If you believe in it, make it so good that people come
begging you for it.  Such an attitude is another thing that helps to
convince others that what you are doing may be worth paying attention
to.

> Given your feedback, I _think_ there is a window of opportunity for
> this? Let me give it a shot. I will first try to create an equivalent
> of this technique into a per-commit basis to make a broader usecase
> and see if has an impact (performance or avoiding conflicts for
> merges). Will let you know.

Yup, if we can decide if the "recycle" short-cut is worth taking
cheaply enough, that may be ideal, as the end-user does not have to
do or know anything and get an improved behaviour.  Thanks.
