Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9CC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8098B2076E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEUIINkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHEUEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:04:12 -0400
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:60717 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgHEQgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:36:37 -0400
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 12:36:34 EDT
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 97AE12F0DC;
        Wed,  5 Aug 2020 12:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=msThXjG0oDnb
        VgpkGdxop9dfugQ=; b=mEUIINkwCcQhPq0hk/3aKCcWvGTVbHQcp0+x9wq4xwWk
        WoYjRJH6Bk90VY02zMhjCZgbCtKD/DCaWOtPB/3GthqYBuMhqdl+cEWyp/dsjBg6
        uMusWt8R712F0n1M1Hag5QSLQOFBY6seZI8OwD36Ui91Jt3EfxDx5Y8j8+pEe80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xujXND
        qFqnMj6aspev35gf3oFQr2t7qrkZ3OTYh89qkIo+Kq/hZw02QK8e4XfipwOi+wN8
        jRPJCyXWOb0E0RoK/q3GTYMxQVMJ+h51AvlrSWCxgQV17pMvKHrCj05zcMbt3sXw
        3Iv0jTdWL24JZxE0i9g7QiU/sh4LcpcWAMeKI=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 7BA352F0DB;
        Wed,  5 Aug 2020 12:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 984FCDD681;
        Wed,  5 Aug 2020 12:12:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Ed Maste <emaste@freebsd.org>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH RESEND] Update .mailmap
References: <xmqqy2muqddg.fsf@gitster.c.googlers.com>
        <20200805065408.1242617-1-martin.agren@gmail.com>
        <87eeolo9v9.fsf@linux-m68k.org>
        <CAN0heSoa=Y1HMaZD=eQYD8uphrm+VRZe9yD+8voNuWPetHm83w@mail.gmail.com>
Date:   Wed, 05 Aug 2020 09:12:37 -0700
In-Reply-To: <CAN0heSoa=Y1HMaZD=eQYD8uphrm+VRZe9yD+8voNuWPetHm83w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 5 Aug 2020 09:09:48
 +0200")
Message-ID: <xmqq5z9xoyve.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B6191D8-D736-11EA-A0CD-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> (Dropping Jiang Xin's huawei address. It bounces.)
>
> On Wed, 5 Aug 2020 at 09:00, Andreas Schwab <schwab@linux-m68k.org> wro=
te:
>>
>> On Aug 05 2020, Martin =C3=85gren wrote:
>>
>> > --- a/.mailmap
>> > +++ b/.mailmap
>> > +Andreas Schwab <schwab@linux-m68k.org> <schwab@suse.de>
>>
>> Neither of them are more recent.
>
> Thanks, I'll take that as a Nak and drop your entry from the patch.
>
> Martin

FWIW, I do not know the reason why Andreas said the above, but there
are folks who contribute to the same project (not limited to this
one) sometimes as an individual and sometimes as an employee of a
corporation, and want to differenciate which commit is which by
using different author names.  So migrating old and defunct
addresses to the current and working one may be appreciated by the
contributors, but we shouldn't make it a goal to have only one
canonical form per one physical person.  That won't work.

Thanks.
