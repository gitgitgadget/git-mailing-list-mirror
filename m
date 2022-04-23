Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAC1C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiDWQu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiDWQu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 12:50:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D471DDB25
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 09:47:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC6AC110106;
        Sat, 23 Apr 2022 12:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F+rSmbEs+bvj
        L3Pv/WIc6YnspSYrhogk5syrxy9j8zY=; b=TAYVCEYAv4PeiILpdATgoQu0k+TV
        gN8S7Vr+DykleaOksZ8XdfuUmZKljqW3JstdX2urJTas5UHsDm+89nvGGMp3dlb2
        cdDeZDrRfC7XKD9dzKUZTnDAwEqZTW/0MZN1+B8tzfMlYLG/hEOk4B1SQZVqE7Xo
        kdCcrNwqXaXYFKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3981110105;
        Sat, 23 Apr 2022 12:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51E01110104;
        Sat, 23 Apr 2022 12:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Hurst <tom@hur.st>
Subject: Re: Corrupt name-rev output
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
        <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
        <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
        <340c8810-d912-7b18-d46e-a9d43f20216a@web.de>
Date:   Sat, 23 Apr 2022 09:47:56 -0700
In-Reply-To: <340c8810-d912-7b18-d46e-a9d43f20216a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 22 Apr 2022 20:44:40 +0200")
Message-ID: <xmqqzgkb21c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20D2A3BA-C325-11EC-A560-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] Revert "name-rev: release unused name strings"
>
> This reverts commit 2d53975488df195e1431c3f90bfb5b60018d5bf6.
>
> 3656f84278 (name-rev: prefer shorter names over following merges,
> 2021-12-04) broke the assumption of 2d53975488 (name-rev: release unuse=
d
> name strings, 2020-02-04) that a better name for a child is a better
> name for all of its ancestors as well, because it added a penalty for
> generation > 0.  This leads to strings being free(3)'d that are still
> needed.

Nicely described.

Thanks.
