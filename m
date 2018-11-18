Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF8E1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 07:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeKRR3C (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 12:29:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61854 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeKRR3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 12:29:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E50B226B02;
        Sun, 18 Nov 2018 02:09:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GLJtMyqo+exg
        s7zFbCQkcx6J+lw=; b=iwiQyoE1Z8Ec6D6bmukcgx3ej38qoAxefI2YhrimzM6O
        CYuHj+zUV4n18uXIVSPVJ8mFdFc/x2tirBOy0DgusFg9poZ0jJs731wc7ttXqXLa
        O/HrFvDSGu/ilvs/afNImYvqpGo6E+NXmhY/2xFPAdjqm47obWmqLLPO2rybx0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n3fbgk
        9/NBwL5lIjLjg4t2IOK7m4ydJIixbjpvquts3tZMzc3sFwzhFK8qi9r3Rmyo2VgL
        uPl1qpqd5krBjaX2y7D7Bu7rowJ9YABMXdEAZCgeLfrLsoKPjj3D58bZVjmH4/Dy
        NS2Nz1Xko7kqfg/kmpx2rf1Zd7CmLTjC0O8oQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDAA326B00;
        Sun, 18 Nov 2018 02:09:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F146A26AFF;
        Sun, 18 Nov 2018 02:09:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
        <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com>
        <xmqqftvzhn22.fsf@gitster-ct.c.googlers.com>
        <87ftvz1k5u.fsf@evledraar.gmail.com>
Date:   Sun, 18 Nov 2018 16:09:26 +0900
In-Reply-To: <87ftvz1k5u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 17 Nov 2018 22:14:21 +0100")
Message-ID: <xmqqsgzyg8ux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3D99B9E-EB00-11E8-BDFF-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Do you mean that you don't agree that following should always create
> both "foo" and e.g. ".git/refs/heads/master" with the same 644
> (-rw-rw-r--) mode:
>
>     (
>         rm -rf /tmp/repo &&
>         umask 022 &&
>         git init /tmp/repo &&
>         cd /tmp/repo &&
>         echo hi >foo &&
>         git add foo &&
>         git commit -m"first"
>     )
>
> To me what we should do with the standard umask and what
> core.sharedRepository are for are completely different things.

Ahh, of course.  If you put it that way, I do agree that it gives us
a valid use case where core.sharedRepository is false and the umask
of repository owner is set to 022 (or anything that does not allow
write to group or others, and allows read to group) to let group
members only peek but not touch the contents of the repository.

I think I was distracted by the mention of ore.sharedRepository in
the proposed log message.
