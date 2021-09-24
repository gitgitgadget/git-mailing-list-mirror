Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9CC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A53561164
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348050AbhIXSSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:18:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50416 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348026AbhIXSSm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:18:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E5AD166CE5;
        Fri, 24 Sep 2021 14:17:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KAqpoBP8TUMK
        61IjicUAZ8mVLM6KizZNBqBt+L/JEZ8=; b=wBmkEUIg/cgaln37q0o4df6V3bKE
        xFYSYwEbbw5lrRE7lT8XGyKF0Emv2Ngn9iEa43Uirj/WUEqUIJyUI1ppxKdJofJs
        ExgFcTTmlVAJThuLwlBCzHE0o3dZgvdFdsRU5cuXs5S2LWlxIDIgkqsXyjojlaBI
        v4xDWI4PWRR0JH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29D6F166CE4;
        Fri, 24 Sep 2021 14:17:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65698166CE3;
        Fri, 24 Sep 2021 14:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Subject: Re: [PATCH 2/3] ls-remote: remove documentation for custom -h option
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
        <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
        <patch-2.3-32b8dbecfe0-20210924T164820Z-avarab@gmail.com>
        <20210924171113.GA3311029@szeder.dev>
Date:   Fri, 24 Sep 2021 11:17:05 -0700
In-Reply-To: <20210924171113.GA3311029@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Fri, 24 Sep 2021 19:11:13 +0200")
Message-ID: <xmqqbl4hvnxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9FF5790A-1D63-11EC-A759-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Sep 24, 2021 at 06:51:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> The custom handling of the "-h" option was broken in
>> ba5f28bf79e (ls-remote: use parse-options api, 2016-01-19), first
>> released with Git v2.8.0. We've been promising that it's a synonym of
>> --head, but it's not.
>>=20
>> We could make this work again by supplying the
>> PARSE_OPT_NO_INTERNAL_HELP flag to parse_options(), but if we were
>> writing this command today we wouldn't make this an exception. Since
>> it's been such a long time let's just remove this rather than
>> restoring the exception to "-h" handling.
>
> This breaks the case when '-h' is used in combination with a remote:

Yes, I think I covered this in my response to Ignacy.  Perhaps =C3=86var
can read it before rerolling this series.

Thanks.
