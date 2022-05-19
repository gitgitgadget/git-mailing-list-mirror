Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A88C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiESRam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiESRac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:30:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80768B36E1
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:29:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70C181156E4;
        Thu, 19 May 2022 13:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DW1CxXMfjJnp
        lYZZHBk2BhwJa+ciHXlM07tbZIsqw18=; b=Za3uc67F3Miqvnaf/NlwVXywTyXM
        SMpOnIRZjjp5Os/nb3y7Ly4X5Cilh++MGu1bLJIWftIMU42PTF1MhXERRRRFRxKV
        s61+sTDvsPa5c3rIR+m6H68aFVamGs1e1/ChERIt9B/DaFuV8xe8hFX/VTKBYlba
        po3z6NQNff6iTOQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6777F1156E3;
        Thu, 19 May 2022 13:29:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB8521156E2;
        Thu, 19 May 2022 13:29:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #05; Mon, 16)
References: <xmqq5ym4zpmn.fsf@gitster.g>
        <20220519152344.ktrifm3pc42bjruh@Carlos-MacBook-Pro-2.local>
Date:   Thu, 19 May 2022 10:29:02 -0700
In-Reply-To: <20220519152344.ktrifm3pc42bjruh@Carlos-MacBook-Pro-2.local>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 19 May
 2022 08:23:44
        -0700")
Message-ID: <xmqqa6bdph29.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E3C293A-D799-11EC-9A7C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Mon, May 16, 2022 at 10:37:04PM -0700, Junio C Hamano wrote:
>>=20
>> * cb/path-owner-check-with-sudo (2022-05-12) 4 commits
>>  - git-compat-util: allow root to access both SUDO_UID and root owned
>>  - t0034: add negative tests and allow git init to mostly work under s=
udo
>>  - git-compat-util: avoid failing dir ownership checks if running priv=
ileged
>>  - t: regression git needs safe.directory when using sudo
>>=20
>>  With a recent update to refuse access to repositories of other
>>  people by default, "sudo make install" and "sudo git describe"
>>  stopped working.  This series intends to loosen it while keeping
>>  the safety.
>>=20
>>  Will merge to 'next'?
>>  source: <20220513010020.55361-1-carenas@gmail.com>
>
> I am obviously biased, and probably confused, since this is already in =
the
> "cooking" section, but I think this is ready and should be merged to ne=
xt
> without the optional patch 4.

I agree that #4 may be subject to further discussion, but the other
three are solid enough.  Let's merge it down.

Thanks.
