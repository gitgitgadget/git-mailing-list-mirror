Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3AC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 21:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiDKVMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiDKVMO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 17:12:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0390E186E7
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:09:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DA181885F9;
        Mon, 11 Apr 2022 17:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MDeHFmQXDamr
        kbYRTWu/tk5FdiYDC4PMtmdimPflmoA=; b=DwrQRf3EXyHguNgWoQCY/benCQyq
        Gh78vLq2Amr8tJFOOdDxzbcPF1sxGI5nQ/xdYuUF6QBAlHOhpFIwWPZrwEqqjGG3
        OiAN6eXqR4cVN2JMH2H49d/uXQWugluXwirIUHy/6HmTSRORXoN2HMtBRwzoFZhD
        mlTH/qM9Blc2IG4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65B7B1885F8;
        Mon, 11 Apr 2022 17:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDD0C1885F7;
        Mon, 11 Apr 2022 17:09:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Christian Couder <christian.couder@gmail.com>,
        jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Subject: Re: Make commit messages optional
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
        <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
        <220408.86r167bxra.gmgdl@evledraar.gmail.com>
        <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
        <220411.865ynfkj7r.gmgdl@evledraar.gmail.com>
        <xmqq4k2zjyb0.fsf@gitster.g> <20220411181819.GF163591@kunlun.suse.cz>
Date:   Mon, 11 Apr 2022 14:09:54 -0700
In-Reply-To: <20220411181819.GF163591@kunlun.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Mon, 11 Apr 2022 20:18:19 +0200")
Message-ID: <xmqq1qy3gwd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCC958FC-B9DB-11EC-9715-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

>> In any case, "--allow-empty-messages" exists, and that is where we
>> draw the line.  We will not bend over backwards beyond it.
>
> Isn't special-casing the empty message bending over backwards to some
> other influence instead?

Not at all.

Even though the low level plumbing commands try to be accomodating
to people with different tastes, the Porcelain layer is opinionated
itself, and tries to give defaults that encourage good development
practice to interactive users.  There is no need for some other
influence---we chose to reject creating commits with empty messages
to prevent mistakes that novices may find hard to recover from,
and that's final.



