Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E02FC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 06:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29E86108F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 06:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhJ2GaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:30:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58926 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhJ2GaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 02:30:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D61BCFC5E7;
        Fri, 29 Oct 2021 02:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hlmF08YuCCFA
        ar/QsTzrsjrr1mcDMoof35RFes1i0w8=; b=bKh4Iov0o2jsQVh6Wpdckxj2JQL6
        DtyNxsSXRniuzashcRJkmJBQlAPhUk+X7GiYaR9M1Th0Ks2GiF+3emxnpkXo/0D0
        SZ2FYsAehWlpImgOr5r5CIm8pik/YBtVfw8hudczUT/gm7DkknrG9z3ZKoe+dLRP
        Tt0dJ2yDYFAH0O0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCA2FFC5E6;
        Fri, 29 Oct 2021 02:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07C2FFC5E5;
        Fri, 29 Oct 2021 02:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
Date:   Thu, 28 Oct 2021 23:27:32 -0700
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 01:20:38
        +0200")
Message-ID: <xmqq7ddwmjl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4D4D9410-3881-11EC-877A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Part 2 of the greater configurable hook saga, starting by converting
> some existing simple hooks to the new hook.[ch] library and "git hook
> run" utility.

These look mostly OK.  Other than .ignore_missing stuff, I think I
agree with the direction of the overall series.

