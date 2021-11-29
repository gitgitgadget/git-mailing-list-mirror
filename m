Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80407C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbhK2SEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:04:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63157 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbhK2SCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:02:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1A1D16D119;
        Mon, 29 Nov 2021 12:59:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aYQVPQ21U4ZgTjgYrNptvP4jBf4mf7Qb+J2JUV
        9nLgE=; b=K9+GfHKRTSjNGnJR4cHhXTR/rRKwYZcaorVKtBLtu+V3u2M0CGHea7
        QRffCAiEY/9r2t0zEEZZ/viSo9NXS9mtob3YruP9LbRGftV5I6hjIjP+T/jvtRS/
        KN+dGGSuVdJNJN2hplGN9fg4PuwErKq1Z8tgGFIgXzGCOYl6YSZEc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B799816D118;
        Mon, 29 Nov 2021 12:59:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D366B16D115;
        Mon, 29 Nov 2021 12:59:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] t1404: mark directory/file conflict tests with REFFILES
References: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com>
        <xmqq35nj8ix6.fsf@gitster.g>
        <CAFQ2z_OTc41g9YgA70W8NCWKWRaRs41EJVZFihmTiPnZFOiEEw@mail.gmail.com>
Date:   Mon, 29 Nov 2021 09:59:09 -0800
In-Reply-To: <CAFQ2z_OTc41g9YgA70W8NCWKWRaRs41EJVZFihmTiPnZFOiEEw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 29 Nov 2021 11:57:28 +0100")
Message-ID: <xmqqsfve3ksy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E258B32-513E-11EC-8C52-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Nov 26, 2021 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> And presumably, without REFFILES prerequisite, these operations
>> would be supported?  E.g. we can have 'main' branch, with 'main/1',
>> 'main/2',... refs, at the same time, with reftable?  That would be
>> quite interesting.
>
> The storage format allows D/F conflicts, but transactions are checked
> for not creating new D/F conflicts (depending on
> the value of reftable_write_options.skip_name_check).

OK.  Then once we let reffiles wither and die over time, hopefully
we can flip the bit and allow us to be in an interesting world ;-)

Nice.

