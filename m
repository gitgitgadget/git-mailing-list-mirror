Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E249DC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07AF60F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhH0VT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:19:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50561 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhH0VTx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:19:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCD24EF08E;
        Fri, 27 Aug 2021 17:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=X47tzXcGRe9T
        u7VS9iMojw/L+w9olTKOFHXWSzyb3I8=; b=feFwXX2lN5i7Jd34Ly6gERT83+yO
        VXkEf44ESJCRZrZoKrdET2uiibycYF/4+XJt1qq92k4vQvF91nkcvCom/VWYbBEQ
        3afP5/XTv++52Yjx/mwseip89CoFHK/IAkYc8FlZdPnyo04xqRDDz1vBPHhWJ2yj
        LbF70YjetgQclzg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4817EF08D;
        Fri, 27 Aug 2021 17:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29E3EEF08C;
        Fri, 27 Aug 2021 17:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] archive: convert queue_directory to struct object_id
References: <bfdb36fc-3b92-fe62-e928-dc235cede31d@web.de>
        <YSlN0+ZCpDqoem9J@camp.crustytoothpaste.net>
Date:   Fri, 27 Aug 2021 14:18:52 -0700
In-Reply-To: <YSlN0+ZCpDqoem9J@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 27 Aug 2021 20:40:51 +0000")
Message-ID: <xmqqk0k6a8n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61542BC6-077C-11EC-810E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-08-27 at 19:59:16, Ren=C3=A9 Scharfe wrote:
>> Pass the struct object_id on instead of just its hash member.
>> This is simpler and avoids the need to guess the algorithm.
>
> Seems reasonable.

I guess this is about the oidread() you added at the end of the
function, so I'd take the above as your Acked-by ;-)

Thanks, both.  Will queue.

