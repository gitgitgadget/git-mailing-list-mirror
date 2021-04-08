Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF9C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C61610F8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDHX6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:58:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58785 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHX6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:58:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 699CBB5091;
        Thu,  8 Apr 2021 19:58:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l9HZ4xY+cPEl
        fT1cAixAF+Q+aPc=; b=OczMyigtSnSzbAu/Cp6zXP7B62jPc7Ish0gN+Befi2wh
        TbgaMBboyQ7gm8S/wZ7GBK02zfwIHTZKHhcmaiUEh2ALNUsaSdM9O2gHTXWP0+Pp
        j0I1PCTXzZ3NnKaScKjNZc5kJacvf/JNPhv2eO3fEfv/zhFOpJNnMr9c7aZZhSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wd2yJc
        6FjK57ZOzwMKMYhjobBJlr31c1temPt8o5tjAvQruFXKAlaSTvkpSwAnGIMO8bV+
        ppuf6l1n0wvMZrCjkEwDzSuYO963o2xxArDN5UwOLOZAjXW/JyWfnR4/H38YYUay
        scy2oAdH1R6d/jfNBnYk9qnbVZDrEzdL+aHDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FCBEB5090;
        Thu,  8 Apr 2021 19:58:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6C00B508F;
        Thu,  8 Apr 2021 19:58:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
References: <20200416211807.60811-1-emilyshaffer@google.com>
        <20200416211807.60811-5-emilyshaffer@google.com>
        <87mtu8ifmj.fsf@evledraar.gmail.com> <xmqqv98wquqp.fsf@gitster.g>
        <87h7kgieyh.fsf@evledraar.gmail.com> <YG+Ux3UKJDa4yWUr@google.com>
Date:   Thu, 08 Apr 2021 16:58:32 -0700
In-Reply-To: <YG+Ux3UKJDa4yWUr@google.com> (Emily Shaffer's message of "Thu, 8
        Apr 2021 16:41:59 -0700")
Message-ID: <xmqqk0pcpbvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53126AD4-98C6-11EB-BE47-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Apr 09, 2021 at 12:33:42AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> On Fri, Apr 09 2021, Junio C Hamano wrote:
>> > By the way, what's this sudden interest in re-reviewing an age old
>> > topic?
>>=20
>> The thread got bumped by SZEDER in [1] and I'd read an April date
>> without noticing the year, so I see this has long-since landed,
>> nevermind :)
>>=20
>> 1. https://lore.kernel.org/git/20200416211807.60811-2-emilyshaffer@goo=
gle.com/
>
> Phew, you scared me :)

Even if it has been in the releases, the room for improvement is
still there, no?
