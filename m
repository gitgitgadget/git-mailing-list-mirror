Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B99C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiI3RJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI3RJM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:09:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110B114023
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:09:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D86715BEF2;
        Fri, 30 Sep 2022 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=OAIX/fvBCgUVtkNvkUZ2WzYiU
        zMs4/IxvD7gwNaLZf0=; b=ZWMYbyofbH1EDksAoMVMLaSeeKMMMvyQ5wzdW4WH1
        KxknLlt3VVLTuxbkWswwdJF4C0rmaGJUql7sXYkbXN5iEqKfEBqlkhv8n4aCMeAW
        BdPUgsIneEzfEFN5AcYMUj9+r4ed1Eu2RZLwFmOYsakR636UpSfd+JdrBJTiZM7u
        +U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 354C915BEF1;
        Fri, 30 Sep 2022 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9317415BEF0;
        Fri, 30 Sep 2022 13:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 01/35] CodingGuidelines: update and clarify
 command-line conventions
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <patch-v2-01.35-aecd3ff41f2-20220928T082458Z-avarab@gmail.com>
        <xmqqpmffv24a.fsf@gitster.g>
Date:   Fri, 30 Sep 2022 10:09:08 -0700
Message-ID: <xmqqzgegkcwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 993F9886-40E2-11ED-BD98-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>   Optional parts are enclosed in square brackets:
>> -   [<extra>]
>> -   (Zero or one <extra>.)
>> +   [<file>...]
>> +   (Zero or more of <file>.)
>
> OK.
>
>> + Use spacing around "|" token(s), but not immediately after opening o=
r
>> + before closing a [] or () pair:
>> +   Do: [-q | --quiet]
>> +   Don't: [-q|--quiet]
>> +
>> + Don't use spacing around "|" tokens when they're used to seperate th=
e
>> + alternate arguments of an option:
>> +    Do: --track[=3D(direct|inherit)]
>> +    Don't: --track[=3D(direct | inherit)]
>> +
>
> Hmph, that sounds inconsistent; I would have expected the same use
> (or omission) of space around the vertical bar.  But if that is the
> prevailing style, I won't complain about writing it down.

Perhaps in order to avoid "Huh? isn't that inconsistent?" knee-jerk
reaction, it may be a good idea to explain the reason why?

I am guessing that the difference between the two has something to
do with the desire to make it compact when it appears as a "value"
for something (signalled after a "=3D" sign), but (1) I am not sure if
you share the reasoning, and more importantly (2) I am failing to
come up with a concise way to phrase it.

Thanks.
