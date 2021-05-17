Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E4C43600
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7164B61285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhEQTaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:30:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55545 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhEQT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:29:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EBB913E0C0;
        Mon, 17 May 2021 15:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dWvdKFwfLmrt
        su0tSiABc2Cn+KbPKS0c2FZj6AKLsH0=; b=waq9yssA+X/8g6DGuUg+9ZU1ne+w
        xg+D1JJ57wz3bKFmYR+3seFGiHctxVMnkLIL3IvK/cOndSku2x5ZXHXU1WBx42pC
        5AIBWAIgIKkzP2HFt/H6n4CNf9wmjcyqSXQq6S2MLO+GO59Tb2ADspffSSrZ+wu8
        Lt8mqFL7MDu8GLM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37E9B13E0BF;
        Mon, 17 May 2021 15:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7651113E0BB;
        Mon, 17 May 2021 15:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
References: <60a046bd83001_f4b0f20861@natae.notmuch>
        <87tun1qp91.fsf@evledraar.gmail.com>
Date:   Tue, 18 May 2021 04:28:34 +0900
In-Reply-To: <87tun1qp91.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 17 May 2021 18:48:04 +0200")
Message-ID: <xmqqlf8d6ty5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 135688D2-B746-11EB-8902-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This looks much better.
>
> I wonder a good follow-up (hint, hint! :) would be to have
> exec_man_man() and exec_man_cmd() in builtin/help.c set this depending
> on color.ui (so we'd do it by default with "auto").
>
> Then e.g. "git help git" would look prettier than "man git".

As long as color.man.ui can be used to override the blanket
color.ui, I think it is a good idea.
