Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7820C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiAMUAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:00:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51808 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAMUAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 15:00:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06B59100180;
        Thu, 13 Jan 2022 15:00:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dqcWAye8sxop
        PQQCjZqSTP2Yrx8KeNyZUjxHSAXNIIY=; b=peSnGQep8DhNTt5YTOsIUgXbBpn2
        2Obas6mIKnQo4r8ueiaWC6oTcLas+UQ0WCEqfxegXdF/9WPAkuRIO2vwCiGCQVZv
        /jkaVeyAmf9ApM1F3L2ytM1E4Znnd8jtzhAeYCCdC+EXbNtqHR+mQ7m/pzYilNt0
        z6sc3CoVWzlT0yI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F216910017F;
        Thu, 13 Jan 2022 15:00:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 627FA10017E;
        Thu, 13 Jan 2022 15:00:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
        <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
        <xmqqy23jh2h3.fsf@gitster.g>
Date:   Thu, 13 Jan 2022 12:00:30 -0800
In-Reply-To: <xmqqy23jh2h3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        13 Jan 2022 11:15:04 -0800")
Message-ID: <xmqqtue7h0dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 764701B0-74AB-11EC-A1FA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Would make sense to steal the compiler version etc. details from my
>> <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventu=
ally
>> we'll be able to change this & other code back, as nobody will care
>> about that older compiler version. It worked before in the pre-image o=
n
>> a more recent xlc.
>
> If so, wouldn't it be a better option not to worry about such an old
> compiler at all from the get-go?

The above was a genuine question.  If that "nobody will care about
the old compiler" will happen only after a few years, then it may
not work to just ignore the version of xlc which might still have
a meaningful number of users.  I just am not in a good position to
judge that.

Thanks.


