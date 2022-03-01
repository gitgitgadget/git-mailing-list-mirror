Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA0DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiCASH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiCASH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:07:28 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B955DE4E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:06:46 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23EFE1122D3;
        Tue,  1 Mar 2022 13:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TD0xbsSnoedO
        UjG1jqYntKXotaMgB8Wi0pEkzBbaJp8=; b=qzJEDV3OIqf4gooyyRtStuZefXKn
        zu+m5rZQnZR1Zg1qBr6VLl4l7T7JIv5AnFm77ZnRf1aoTNeqtMkoYg6M5Q4b2dVL
        IeP5OPy1j7/dmHr3Mjj1ze6i5qCNoxvDP+PkeXL+5pu00n6soMakIwUonxKzamNL
        lcdUfuN1gd5VAe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B5401122D1;
        Tue,  1 Mar 2022 13:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 717961122CF;
        Tue,  1 Mar 2022 13:06:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #07; Fri, 25)
References: <xmqqee3q73e1.fsf@gitster.g>
        <CAPMMpojgTcp7qGmpK0vm8_WTOaSJ6r=NBa3sEO0EC7XRBF_dXg@mail.gmail.com>
        <220228.8635k35chr.gmgdl@evledraar.gmail.com>
        <CAPMMpohJsZahwzhstoqxPZz=UbJ_7+vrUQZbk0DOrGFJ4Xq-nw@mail.gmail.com>
Date:   Tue, 01 Mar 2022 10:06:42 -0800
In-Reply-To: <CAPMMpohJsZahwzhstoqxPZz=UbJ_7+vrUQZbk0DOrGFJ4Xq-nw@mail.gmail.com>
        (Tao Klerks's message of "Tue, 1 Mar 2022 12:56:52 +0100")
Message-ID: <xmqqfso1r1hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 59EBCF2E-998A-11EC-AE2B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Mon, Feb 28, 2022 at 2:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>>
>> Perhaps something like this:
>>
>>     The performance of the "untracked cache" feature has been improved=
 in
>>     common cases where "--untracked-files=3D<mode>" and
>>     "status.showUntrackedFiles" were combined. This change benefits Wi=
ndows
>>     users using it in conjuction with the "fsmonitor feature in partic=
ular.
>>
>> Perhaps adding:
>>
>>     There's an obscure case where the performance is now worse, but it=
's
>>     thought not to matter.
>>
>
> I really like it, thx! I would change "combined" to "aligned", and litt=
le else:
>
>    The performance of the "untracked cache" feature has been improved i=
n
>    common cases where "--untracked-files=3D<mode>" and
>    "status.showUntrackedFiles" were aligned. This change benefits Windo=
ws
>    users using it in conjunction with the "fsmonitor" feature in partic=
ular.
>    There's an obscure case where the performance is now worse, but it's
>    thought not to matter.

Overly long for a topic summary, with value judgements that I'd
prefer to omit.  What (you think) is "common" does not help us make
a stronger case.  I've never said I agree "it's thought not to
matter" at all.  Just stick to the known facts.

