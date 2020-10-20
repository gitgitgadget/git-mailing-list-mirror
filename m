Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEE8C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7222247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sxbczvlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409398AbgJTUTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:19:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56949 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391626AbgJTUTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:19:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D81EF49E9;
        Tue, 20 Oct 2020 16:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x1T7W3F6rmom22/4Q/ug/yuJ7tE=; b=sxbczv
        lYe9pIl9j0JNopVlUDl63PjCM/W8WZ5tDap/fLpItUvrjI5HfCBahfrhDIdhJW0e
        7u8ZyxhkEFFCOs6h8MLwsnhGxNSrVmJqvpPodpFHwQYdleq6/QC1Dtw3XVFalZJ7
        n4wcCuDL2m0xyb19PPNGooE4mVcdkMWZMjoh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Khr+INT3OcShOBz28XgpzPpYJlX02ZmX
        T8hqpNRm4HpyxRTj0J/M3Fo6x70eQN1jl+mbDmW4dn0B7Jua7s0iK7GdzOPeCYAs
        ItRzVQkb9hgjj9nPuqySUn5mqVeCJqAXm6oJA9iuoYsOuQWXFjl4mX9f4WFp9Z8g
        RNtAkJxFkjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65D3EF49E8;
        Tue, 20 Oct 2020 16:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A09F1F49E5;
        Tue, 20 Oct 2020 16:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
References: <20201017075455.9660-1-charvi077@gmail.com>
        <20201020121152.21645-1-charvi077@gmail.com>
        <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
Date:   Tue, 20 Oct 2020 13:19:25 -0700
In-Reply-To: <xmqqa6wgbqpq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 20 Oct 2020 13:13:53 -0700")
Message-ID: <xmqq5z74bqgi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DA5B3E4-1311-11EB-ABE3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Charvi Mendiratta <charvi077@gmail.com> writes:
>
>> Modern practice is to avoid multiple commands per line,
>> and instead place each command on its own line.
>>
>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>> ---
>
> This looks good, but I am wondering what happened between v3 and
> v4.  
>
> As you've demonstrated through the microproject that you can now
> comfortably be involved in the review discussion, I am tempted to
> suggest that we declare victory at this point and move on, but I
> don't know what the plans are for the other 4 patches (I guess we
> won't miss them that much---the micros are meant to be practice
> targets).

Actually I take it back.  This does not look good as a standalone
patch at all.  It seems to depend on something in the 5-patch
series.

Please make sure that patches you send are usable by your
recipients.

