Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9B611BD
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJUSlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:41:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58943 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUSly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:41:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F186B167266;
        Thu, 21 Oct 2021 14:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mlbFfF6c+uyD
        Ho9Jp12djbOGaRCsH4GkJzu+96TUses=; b=CZiK9vn9ms9aJjflco6CmJKmuUiS
        dJTSvhSyyuJRbEW+qg8V6tjolwgARsftuGpBpVrphL8I7M98Yi/RVYS1KQi83FuW
        cGDz+b/axNsOq7L7K5ivVIu+9AY1NvdZXFk+w5GslLxvSTR4W1OGdvcJ1edE2hBy
        ZrD/cHALSaJ6NJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9F27167265;
        Thu, 21 Oct 2021 14:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5437D167264;
        Thu, 21 Oct 2021 14:39:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 10/11] pack-bitmap-write.c: don't return without
 stop_progress()
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Oct 2021 11:39:34 -0700
In-Reply-To: <211021.86ee8emx57.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Oct 2021 13:31:13 +0200")
Message-ID: <xmqqpmrykys9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D23D812-329E-11EC-A72B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Looks good :) Just a note that this is in
> "ab/only-single-progress-at-once" already in case you didn't spot it.
>
> That series is marked for "next?" (with a question mark) by Junio in th=
e
> latest what's cooking, so *hint* *hint* for any last minute review :)

I wonder if it would help contributors if we give them a simple rule
to follow before sending their patches out:

 - You develop on an appropriate base (either on maint, or master,
   or a merge of selected topics in flight you absolutely have to
   depend on) as usual.

 - You test merge the result to 'seen' and to 'next'.  If you do not
   get heavy conflicts and the tests pass, you are OK.

 - Otherwise, you study what is conflicting, and should review it
   before you submit your topic.

Without understanding what others are doing in the same area, it is
hard to make productive use of your time to develop new things, and
if you are reading others' work in the same area anyway, it would be
a minimum additional cost to write about what you learned in their
work.
