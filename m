Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D12C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1320064F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhBCBXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:23:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59197 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhBCBXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:23:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50C0C113521;
        Tue,  2 Feb 2021 20:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gOv8UE71aTgr
        rK0OLzBwypgRcsA=; b=xUG7w8mmCIVv9kWvI4EI0RnAZrYNZkVO1t6XEyB2UXau
        2T+HxGcB81zkciKkiIAN9AXSnxuoTjxi0huSphFBfPfKLNwODpYliux571RBy0F4
        efP6Hk4+rXqWR+T7fm0/rrPTa7Xv90wn8ezCRRodP9+muYy5U+A97B3jgRHORo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AqfEM/
        DVK+lMaqJRCs8hWQPRiOsZtZEXshQ85XImgXREmL99Fc9Q37yQuvun+wrU33cpPu
        AbgdGSuZrWxb/HDRrZJzPiOHVEYUHT7McoIqsCpRy+1Ty/JMLFVr7x0vnQviArmh
        ig/nQjmyW/Y0JN5WNB5IDQnVeSo4u6ytHjRvo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A13C113520;
        Tue,  2 Feb 2021 20:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9290611351F;
        Tue,  2 Feb 2021 20:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <YBn3ndkwo9qvXHFr@danh.dev>
Date:   Tue, 02 Feb 2021 17:22:51 -0800
In-Reply-To: <YBn3ndkwo9qvXHFr@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 3 Feb 2021 08:08:45 +0700")
Message-ID: <xmqqbld2djx0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57343196-65BE-11EB-A480-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2021-01-30 16:00:56-0800, Junio C Hamano <gitster@pobox.com> wrote:
>> * mr/bisect-in-c-4 (2021-01-26) 7 commits
>>  - bisect--helper: retire `--check-and-set-terms` subcommand
>>  - bisect--helper: reimplement `bisect_skip` shell function in C
>>  - bisect--helper: retire `--bisect-auto-next` subcommand
>>  - bisect--helper: use `res` instead of return in BISECT_RESET case op=
tion
>>  - bisect--helper: retire `--bisect-write` subcommand
>>  - bisect--helper: reimplement `bisect_replay` shell function in C
>>  - bisect--helper: reimplement `bisect_log` shell function in C
>>=20
>>  Piecemeal of rewrite of "git bisect" in C continues.
>>=20
>>  Will merge to 'next'.
>
> I think the bisect_log still haven't added back the:
>
> 	We are not bisecting
>
> as addressing in gohp6kv9bml9qc.fsf@gmail.com

OK, I'll put it on hold and wait for a proper fix-up patch.

Thanks.
