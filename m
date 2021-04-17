Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB1C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB3261354
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhDQWBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 18:01:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58239 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhDQWBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 18:01:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D551EB87C7;
        Sat, 17 Apr 2021 18:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KwdzksXVEuyz
        IwyhfIrAfBBTvsc=; b=cxV9hPJdDyhdQxPz8DqG6r5Fdd/fNtGXCeRACcjKf5pv
        uOgxoS+IPk12/oNQMpepXAzm+rJyGxEnrJz32MqnKELBgNX2KPpD5eJaKH2oL2Z+
        ow9cEEBG2t5hHMpn1NJZuV068KDgBOfh+Y9VYnuV8HG3q0LPMDgDKfkemoFJVMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Sbr+L/
        4Ctf28M8dB8aewYIgy8+ZGkdU4MCJIa1GPc/xhmj1/QunY0K+JdvIOaogKUNfQAo
        y+3Oe8hTJOGQ5079Njxn6GyISt9m0gDUKHQg6LXE6GLSV7A6WnN7qZ/hze2mJvVP
        EVnXDT5jh18QIuPxHw5yPu1/mKtjX2rfsA8AY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCABAB87C6;
        Sat, 17 Apr 2021 18:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 565E7B87C5;
        Sat, 17 Apr 2021 18:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands
 in Perl/SH
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
Date:   Sat, 17 Apr 2021 15:01:17 -0700
In-Reply-To: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 17 Apr
 2021 10:43:54 +0200")
Message-ID: <xmqqmttwbmfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6FD93E1E-9FC8-11EB-AC86-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a suggestion to write new commands in Perl or Shell to
> experiment. This advice was added in 6d0618a820a (Add
> Documentation/CodingGuidelines, 2007-11-08).

I think this needs to be rephrased to clarify that it is mainly to
allow easier prototyping.

> Since then the consensus changed to having no new such commands unless
> necessary, and existing ones have been actively migrated to C.

Well, "unless necessary" is quite an interesting word here.  There
are trade-offs, and some things are not worth spending cycles to
write in C than leaving quick hackability for developers.

Also existing ones getting migrated to C does nothing to support the
implicit claim the above sentence makes, which is "writing the first
version in C is recommended".

    If you are planning a new command, it may be easier to prototype
    by implementing it as a script, until you and others on the list
    can figure out what the semantics and end-user experience should
    be, instead of starting the initial version in C code.  Many Git
    commands started out as scripts and then later rewritten in C.

More importantly, we probably should stress that we've been very bad
at maintaining plumbing to allow such quick experimentation.  We
should encourage (or even require) developers to make the feature
they directly hacked into the Porcelain command available also to
the plumbing layer, so that those who script with plumbing commands
can also use it.

> - - If you are planning a new command, consider writing it in shell
> -   or perl first, so that changes in semantics can be easily
> -   changed and discussed.  Many Git commands started out like
> -   that, and a few are still scripts.
> -
>   - Avoid introducing a new dependency into Git. This means you
>     usually should stay away from scripting languages not already
>     used in the Git core command set (unless your command is clearly
