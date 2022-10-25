Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BFC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 16:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiJYQHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYQH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 12:07:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C610182C7D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 09:07:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 293CA1D12CE;
        Tue, 25 Oct 2022 12:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S/jxYT8Aq+/J
        71s/ygICdyt4y4WAXjRvXuUQIHN0o5w=; b=NfwwkRxw3E2boaKelT/eEEbpBdud
        kN0X0fQWS0T7W723dVJHiduIqKFKVF2B9/lzQ9Ag9UWx/smAvpjt6YnxcavauDaL
        7z4Aowf54B+kEXeweaf3sChdiIzgf7DIjbRp2WC04Y4QKHRR1/gmI8gzvqP8yiGe
        C04mw/6oPLwJqPM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21B151D12CD;
        Tue, 25 Oct 2022 12:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF2BA1D12CC;
        Tue, 25 Oct 2022 12:07:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] fsck: document msg-id
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <3aec3d2c9ca65a37a367c3a7c9081bbd4cd44ae0.1666623639.git.gitgitgadget@gmail.com>
        <xmqq8rl5t9ca.fsf@gitster.g>
        <221025.86wn8ock07.gmgdl@evledraar.gmail.com>
Date:   Tue, 25 Oct 2022 09:07:22 -0700
In-Reply-To: <221025.86wn8ock07.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 25 Oct 2022 11:41:50 +0200")
Message-ID: <xmqqlep3opj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CBB5D26-547F-11ED-A879-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We'd just point the po-doc extraction at the generated *.txt, we'd need
> to re-arrange the Makefile dependencies a bit, but it shouldn't be a
> problem.
>
> The *.pot-file generation is a step that only the translation
> coordinator *needs* to run, so even if it's a manual procedure, or
> requires first building the sources...

I thought you made it more distributed to remove the coordinator's
involvement in .pot generation recently, which resulted in us not
tracking the .pot at all, no?  Now all the l10n folks need to do the
extraction?
