Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C69C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137906103C
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ1QeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:34:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54292 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhJ1QeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:34:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A64951535A5;
        Thu, 28 Oct 2021 12:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zYXN88Qp5FcV
        +eb1GACYW5JRlGD3NjLoXxjs63PY210=; b=dsdSSeMamzSdAcqS2ZBWPu97GbOh
        gs338BvkIgBBuJvZDxpjeHiaXFcN0Iw/mmQ7uJM1FBDPORRAMD5WtFhIAA8QXRp5
        kHbSI44vKe+49BCkFZ3tZvmubYYzQcfOFhiCGG39rTl6sVj1+GD+kFB/KGytvLug
        2ag3EhxW9HC2ISY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9ED2F1535A4;
        Thu, 28 Oct 2021 12:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08D591535A3;
        Thu, 28 Oct 2021 12:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org,
        carenas@gmail.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 0/2] send-email: shell completion improvements
References: <87fst7lkjx.fsf@evledraar.gmail.com>
        <20211025212707.188151-1-tbperrotta@gmail.com>
        <211026.86o87c1zry.gmgdl@evledraar.gmail.com>
        <211026.86k0i01u3c.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Oct 2021 09:31:31 -0700
In-Reply-To: <211026.86k0i01u3c.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 26 Oct 2021 02:48:02 +0200")
Message-ID: <xmqqcznpt8kc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83049150-380C-11EC-B424-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> FWIW I came up with the below on top while testing this. I think your
> patch series is fine and we should just take it as-is.
>
> This edge case of "--no" behavior isn't something we support in any
> sensible way already, so it can just be left for later.

I was kind of surprised to see --no-suppress-from was among the
completions offered by the new code (given that nothing special
cases a boolean and adds --no-$_ variant to the output), but then
found that some options are listed with "no-" prefix, which is, eh,
"Yuck" in the existing code, perhaps.

But I think this is good to take.  Let's apply it.

Thanks, both.
