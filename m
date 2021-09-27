Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273DC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F2A60FF2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhI0UPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:15:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhI0UPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:15:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFF241580BA;
        Mon, 27 Sep 2021 16:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eBMtPFePVNRD
        HZk7WiSxw651kloFADDxr0x5seVpMKc=; b=JOIPEyi4c2q5ViWamya8xMOPPrNc
        XdEeMPJuYTFZIvrgfWmZmkzv6as/r6Sbq3ZQb17e+SCNCl7YJ7DJ7MLzmd+hGsZ6
        6BY64U1TM/wpwUaITaS9XRQD5P+34v/6ckalqd3Vj9XoE5AhfADeW3X+ylHrTf3p
        cmFQfIBfBGNuzgM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E91EB1580B9;
        Mon, 27 Sep 2021 16:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46D8A1580B6;
        Mon, 27 Sep 2021 16:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [PATCH v3 2/2] lazyload.h: use an even more generic function
 pointer than FARPROC
References: <20210923065251.21363-1-carenas@gmail.com>
        <20210926100512.58924-1-carenas@gmail.com>
        <20210926100512.58924-3-carenas@gmail.com>
        <xmqqk0j2q8m3.fsf@gitster.g>
        <CAPUEspif_MAg1==aNWT4q1spOFbsp0cUfr+JjPdc2RLy4F4L1A@mail.gmail.com>
Date:   Mon, 27 Sep 2021 13:13:40 -0700
In-Reply-To: <CAPUEspif_MAg1==aNWT4q1spOFbsp0cUfr+JjPdc2RLy4F4L1A@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 27 Sep 2021 11:50:33 -0700")
Message-ID: <xmqqo88dpyiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68786956-1FCF-11EC-B03A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Sep 27, 2021 at 9:35 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>>
>> > Because of the way the function declaration was done in the previous
>> > patch the order of variables that use it had to be adjusted so that
>> > it is the last variable declared, as well.
>>
>> Is it clear to everybody what this paragraph is referring to?  It is
>> not, at least to me.
>
> It is not, and it is no longer needed after the fixup was applied to
> the previous
> patch.

Ah, yes, the previous one's definition is quite awkward because you
had to omit the terminating ';' to use it.

I'll drop the paragraph with "commit --amend".

THanks.
