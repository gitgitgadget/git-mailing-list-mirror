Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3DC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698AD610FD
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ1TiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:38:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57553 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1TiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:38:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49ED9154CD1;
        Thu, 28 Oct 2021 15:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=urRCN1O1LevX
        6iI0IZ5tI5Fh0hbzxQ9is8OGiv5QQ94=; b=KakYjNJk0o4o7QUZz1zWf634ZdSt
        iJDoPzbNQVNBylOnZ8qF4lmoU25NC2KbaCBQo+17U9noBu0dhSBU683R8R1rgxGa
        4CQ+3TepjIRa4mFtDzbBFMfh0llXa3ajrrianTPo9Jj+iIaMbo/KzNErVJd7N2Yt
        EJPyBOLBBV6ZJto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42AA1154CD0;
        Thu, 28 Oct 2021 15:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9793B154CCC;
        Thu, 28 Oct 2021 15:35:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
        <CAN0heSpHfCNLL3X=eLQMe6RV8mtNq3pYEZYohc4HqzfnP1tdsw@mail.gmail.com>
Date:   Thu, 28 Oct 2021 12:35:46 -0700
In-Reply-To: <CAN0heSpHfCNLL3X=eLQMe6RV8mtNq3pYEZYohc4HqzfnP1tdsw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 28 Oct 2021 20:47:21
 +0200")
Message-ID: <xmqqee85q6wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40104F6E-3826-11EC-86AF-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Thu, 28 Oct 2021 at 18:22, Jean-No=C3=ABl Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> -       It is `<unix timestamp> <time zone offset>`, where `<unix
>> +       It is `<unix-timestamp> <time-zone-offset>`, where `<unix-
>>         timestamp>` is the number of seconds since the UNIX epoch.
>
> This still effectively has a space -- it renders as "<unix- timestamp>"=
.
> You'll probably need to rewrap the lines a little to get rid of that.

Thanks for sharp eyes.  grep -e '<[^ ]*-$' Documentation/ spots only this
instance, so I'll fix it locally.


>> -** 'separator=3D<SEP>': specify a separator inserted between trailer
>> +** 'separator=3D<sep>': specify a separator inserted between trailer
>>     lines. When this option is not given each trailer line is
>>     terminated with a line feed character. The string SEP may contain
>
> s/SEP/<sep>/ ?

Also, this one.

