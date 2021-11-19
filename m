Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE66C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D37B6112E
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhKSQ5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:57:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56853 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhKSQ5L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:57:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 189E4158494;
        Fri, 19 Nov 2021 11:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JRKeHCa1QOJw
        Cke2QBX72RRdhdXYRgIZBoXl0Oo/H3A=; b=GDhLgo3/1MnTv8kZAxFf3m78Y3nw
        cFmWJjr3zE6Ux8qkcq4shJTQb+DgM+XmI7wtAXJvuQ+o2nm34yczvYA2xOxxTfLC
        h63oNOKxHmlzdCh3c8q37MWL7bXtIFbEbt2zaHVqvpI0tgPvwbhuS/qPL63Sxbu7
        HgYJziCWplG0G9A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 110DA158493;
        Fri, 19 Nov 2021 11:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EB52158492;
        Fri, 19 Nov 2021 11:54:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <xmqqilwpuiv4.fsf@gitster.g>
        <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
        <xmqqmtm0snol.fsf@gitster.g>
        <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn>
Date:   Fri, 19 Nov 2021 08:54:06 -0800
In-Reply-To: <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn> ("Aleen
 =?utf-8?B?5b6Q5rKbCeaWhyIncw==?= message of "Fri, 19 Nov 2021 15:23:18
 +0800 (CST)")
Message-ID: <xmqqr1bcqe6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F66B2A2-4959-11EC-9A26-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:

>> Yes.
>>=20
>> As the URL you were referred to explains, the sign-off procedure is
>> to keep track of provenance of the code, which is a more "legal"
>> formal requirement than just "I use this pseudonym everywhere".
>> When a big company comes to us, claiming that "this code is our
>> intellectual property stolen from us" and pointing at code added by
>> a patch from you, we do not want to see us in the position to have
>> to say "eh, somebody who uses psuedonym X signed DCO, but we do not
>> even know their real name".
>
> I know it, and as I said before that gitgitgadget need PR creators to
> sign off user name of GitHub account, according to the DCO check. I can
> confirmed that "Aleen" and "Aleen =E5=BE=90=E6=B2=9B=E6=96=87" are both=
 the real name of mine,
> the committer. I can use the account aleen42@vip.qq.com to confirm this=
.

Can somebody from GGG land help this user?  I _think_ the easiest
workaround (other than not using GGG and sending e-mail in the old
fashioned way) is to commit and sign-off under the real name, and
push under whatever GitHub username to throw a GGG pull request,
which GGG should be able to take, as I have seen users forward other
authors commits just fine.


