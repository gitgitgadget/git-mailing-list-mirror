Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E80C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiFWPdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiFWPdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:33:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A538A0
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:33:01 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7171C1A55D1;
        Thu, 23 Jun 2022 11:33:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cHc32v849jL5
        Hv+NgvANgTTAup7i4MU+hgWo1uZFq0k=; b=IsPpI6NmpV9xU9uiDqxrkQjK5N9Y
        5dtolMyzXZxtvk+ka3O8Y7jhw4lSCmt109QIKP7NTJwSmM4jA2oD6uK1q0mkFBBk
        4NWwhnCArAW9mWZJiEFMbfnOZdgKwJt/j+ltpOIsfMO2xmSYiCbcaqYq3lEpcD3L
        uu1JvLDBd+9JrM8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69B9C1A55CF;
        Thu, 23 Jun 2022 11:33:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEDBA1A55CE;
        Thu, 23 Jun 2022 11:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stephen Smith <ischis2@cox.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
References: <12011256.O9o76ZdvQC@thunderbird>
        <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
        <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
        <12092182.O9o76ZdvQC@thunderbird>
        <YrPFfk5eIX55oO8R@tapette.crustytoothpaste.net>
Date:   Thu, 23 Jun 2022 08:32:55 -0700
In-Reply-To: <YrPFfk5eIX55oO8R@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 23 Jun 2022 01:44:30 +0000")
Message-ID: <xmqqbkuj2y54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C18F3160-F309-11EC-AAF3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-06-23 at 00:45:40, Stephen Smith wrote:
>> On Tuesday, June 21, 2022 5:29:59 PM MST brian m. carlson wrote:
>> > On 2022-06-21 at 10:25:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
>> > > But the reason I'd still say "no" on the technical/UX side is:
>> > >  * The inter-op between SHA-256 and SHA-1 repositories is still
>> > > =20
>> > >    nonexistent, except for a one-off import. I.e. we don't have an=
y
>> > >    graceful way to migrate an existing repository.
>> >=20
>> > True, but that doesn't meant that new repositories couldn't use SHA-=
256.
>>=20
>> So, any idea when a graceful way to migrate a repository might show up=
?
>
> I'm hoping that my employer will give me time to work on this in the
> future.  Perhaps I'll have more to show on this closer to the last
> quarter of the year.
>
> At the moment I happen to be very busy in my personal life, so I'm not
> finding a great deal of time to code much of anything.  But if that
> changes, I'll try to get back to it.

Great ;-).  Thanks.
