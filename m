Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A4C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiBYR1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiBYR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:27:08 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF522BD47
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:26:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98D7818B566;
        Fri, 25 Feb 2022 12:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8MwIz3URkaxu
        aUGc4avS6900yP6XSZq/R8k36HOpXy4=; b=cvUT+kFPjI6LygbjVXPdzQIN7oRZ
        haiIQ9Tq2kUAqxgP4J2OT7Hmi5m4f0eBRKhowF0scUCjvXiv36gRAKiCs55pB25K
        JHBb2CuRQ0+7SDZ9a8gvcoVtbdQgrXm+PlhdfXrSdq7Mmiq2lEhM09lHxaIqA9DR
        EBd4VLHWHtUjmUg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91E6D18B565;
        Fri, 25 Feb 2022 12:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09EDF18B563;
        Fri, 25 Feb 2022 12:26:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH v2] switch: mention the --detach option when dying due
 to lack of a branch
References: <20220224064710.2252637-1-alexhenrie24@gmail.com>
        <xmqqv8x4m6jn.fsf@gitster.g>
        <220225.86h78n88gb.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Feb 2022 09:26:32 -0800
In-Reply-To: <220225.86h78n88gb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 25 Feb 2022 12:57:01 +0100")
Message-ID: <xmqq1qzqg8mv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 138AFED8-9660-11EC-87DE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +	test_i18ngrep ! "try again with the --detach option" stderr
>>> +'
>>
>> OK, we try to be consistent with other tests in the file, and leave
>> s/test_i18n// to a file-wide clean-up outside the topic.
>
> FWIW that's not the case here. This is the first use of test_i18ngrep i=
n
> this file.

Oh, thanks for pointing it out---I remembered that somebody gave a
similar suggestion and blindly assumed that there are other
instances already.  If so, picking, between grep and test_cmp,
whichever requires the least amount of boilerplate code is fine by
me.

Thanks.
