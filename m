Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC142C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhLTUr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:47:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51209 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhLTUrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:47:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1139316FD3E;
        Mon, 20 Dec 2021 15:47:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+MFlcSYlJeLx
        KMv0T8aTqlbFhx3RBfxNCqCYypLsEjM=; b=Dag4ujQQFNO1zZFKyn43FGNj0Yqg
        bofQ5VbVA4LP7wBvJuulGl8gZ/c2kmmoVT0Z5NsdXjDt9R8Ivw26r3aaDjy2PRL/
        6LuyiOHc5XNd7MSb+9mEJsvIozgBCvC/8XUc4nZjAMX9TXCaLlju+JJFr4z7Zzp4
        BhC6DAclNg70Mhk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A00016FD3D;
        Mon, 20 Dec 2021 15:47:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BCE516FD28;
        Mon, 20 Dec 2021 15:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] grep/pcre2: factor out literal variable
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
        <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
Date:   Mon, 20 Dec 2021 12:47:15 -0800
In-Reply-To: <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 18 Dec 2021 20:53:15 +0100")
Message-ID: <xmqqv8zjuhpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04E3C978-61D6-11EC-9BB7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Patterns that contain no wildcards and don't have to be case-folded are
> literal.  Give this condition a name to increase the readability of the
> boolean expression for enabling the option PCRE2_UTF.

Makes sense.  Quite a lot.

Thanks.
