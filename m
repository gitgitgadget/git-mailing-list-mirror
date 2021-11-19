Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45296C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8086121D
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhKSFtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:49:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhKSFtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:49:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4001110664F;
        Fri, 19 Nov 2021 00:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=unYls007WYks
        WJ/zfzBxcaUYoYLPoGkSgF1pkU9rklA=; b=K8R/4E8aOS9jol72KDcJiVnFsSyQ
        4tKhxiQGTXVKyqRjdp71aQkoBH08YOBXERm5JXVsmNyCPyR6hSzHimdaMKt5Z15g
        9/ro/Oya1rjF9vMotecXaRAEsXT+8jC3Parpff/cic2NWvMw9APvNJPoLWZYBd5h
        Ikc0Vyo/XcfVSag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 362F010664E;
        Fri, 19 Nov 2021 00:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B70310664B;
        Fri, 19 Nov 2021 00:46:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <xmqqilwpuiv4.fsf@gitster.g>
        <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
Date:   Thu, 18 Nov 2021 21:46:02 -0800
In-Reply-To: <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn> ("Aleen
 =?utf-8?B?5b6Q5rKb5paH?=
        "'s message of "Fri, 19 Nov 2021 09:45:33 +0800 (CST)")
Message-ID: <xmqqmtm0snol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBE997D2-48FB-11EC-B186-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:

>> As per https://git-scm.com/docs/SubmittingPatches#sign-off:
>>=20
>>    Please don=E2=80=99t hide your real name.
>>=20
>> I suspect your real name is not Aleen, but something with x and w in
>> it.
>>
>
> I have used "Aleen" <aleen42@vip.qq.com> as my GitHub account to
> send this pull request, but the e-mail service disgusts me that it
> is slow to send emails to the domain "vger.kernel.org". So I
> decided to use another mail service to discuss, "Aleen =E5=BE=90=E6=B2=9B=
=E6=96=87"
> <pwxu@coremail.cn> as you saw.
>
> In the open-source world, I usually signed off "Aleen" rather than
> "Aleen =E5=BE=90=E6=B2=9B=E6=96=87", and is that necessary to change?

Yes.

As the URL you were referred to explains, the sign-off procedure is
to keep track of provenance of the code, which is a more "legal"
formal requirement than just "I use this pseudonym everywhere".
When a big company comes to us, claiming that "this code is our
intellectual property stolen from us" and pointing at code added by
a patch from you, we do not want to see us in the position to have
to say "eh, somebody who uses psuedonym X signed DCO, but we do not
even know their real name".
