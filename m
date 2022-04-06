Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284FC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiDFSGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbiDFSGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:06:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711D194AAC
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:41:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47DB912BBE7;
        Wed,  6 Apr 2022 12:41:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ICka5bCNfGqG
        UxCxNaywouDU3AiYe/mJ6OrsIiyab+8=; b=KnCialNZ96Y4Cl7JKZT3QyXlw6xb
        gvqjhqpQPl2qCaGXFjp5fBaeX2tadK3QOIb9aFOdCbwL8HktoG+yEOIfqLKF7/1w
        0XD/WQFLwHbAVIZFIJNvQ58h0A+jeiwXh06R2aPeOtquZ8DwkxIGnKivjDbReKMR
        ae9Kltk0Roq3qOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FDA612BBE6;
        Wed,  6 Apr 2022 12:41:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90F4412BBE3;
        Wed,  6 Apr 2022 12:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Garrit Franke <garrit@slashdev.space>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] bisect.c: remove unnecessary include
References: <20220331194436.58005-1-garrit@slashdev.space>
        <20220405114505.24389-3-garrit@slashdev.space>
        <220406.86a6cyfy4l.gmgdl@evledraar.gmail.com>
Date:   Wed, 06 Apr 2022 09:41:34 -0700
In-Reply-To: <220406.86a6cyfy4l.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 06 Apr 2022 09:50:27 +0200")
Message-ID: <xmqqfsmqyxj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C43DAA4-B5C8-11EC-B6EB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Apr 05 2022, Garrit Franke wrote:
>
>> Remove include "hash-lookup.h".
>
> Like your 3/4 it would be nice to have a "orphaned since xyz", or was i=
t
> never used etc?
>
> In these cases unlike most such C changes the compiler isn't of much us=
e
> for validation (we might be including this implicitly), so an
> explanation saying why is helpful.

Thanks for pointing it out.  I found the lack of explanation in some
but not all of the changes disturbing.
