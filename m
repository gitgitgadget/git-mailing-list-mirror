Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB196C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C526D6100C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhGTUCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:02:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54165 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhGTTjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:39:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CF16D38F8;
        Tue, 20 Jul 2021 16:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zi4v6g4J1o5R
        F4+KCnvFyuV/2wF/KDLWpjp7hr4VXO8=; b=ZjMYT51ZMf/ZnTRt587YE5lb1Yt6
        Nx1AD1rNc0DAI8aKNwvyT6i5WYFZXJiLsWnNLLjHfDsXVdBN/MojrdZtM16N4Cep
        Qqe/y05tq8fGGHOZ0P8wfXuF5+pv+hnfqAlBUjEdeHHtp4jdPoK8qH1yrkQ3Uiot
        wr367gBzk5vfkWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05676D38F7;
        Tue, 20 Jul 2021 16:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E268D38F6;
        Tue, 20 Jul 2021 16:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
        <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
Date:   Tue, 20 Jul 2021 13:19:36 -0700
In-Reply-To: <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Jul
 2021 16:20:26 +0200")
Message-ID: <xmqqo8awhh5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEE44D54-E997-11EB-9DB1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +Revisions must accompanied by reference names to be packaged in a
> +bundle, since the header of the bundle is in a format similar to 'git
> +show-ref'.

This may be an improvement in the way how the description refers to
"show-ref", but we do not have to say anything about "show-ref" ;-)

The reason we should give readers why they must give refs while
creating a bundle, I think, is because the only way to access the
contents of the bundle is to fetch refs from it, and the refs given
to the command when the bundle was created becomes the refs that can
be fetched from the bundle.

Thanks.

