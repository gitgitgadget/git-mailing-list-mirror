Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64702C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiF0QMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbiF0QMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 12:12:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF43140F1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:11:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE5341927F3;
        Mon, 27 Jun 2022 12:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q/N9tlCgVRMf
        8Y5fM+EAQVGmIVjIx65Uo8DMXC9Mauk=; b=xxXmIa7yRv5TMk9XBwEcTwjn2AX/
        I9CF/3BoQ4q4FYptl0/HCNqhq4NoUqFmX5fcdIAmkhuz+pfwRKXEEm4QbGaia64X
        Dpr+9URVDHPaPp6P7Z5OM3whLUtSgYf/JB5p2CV0NuCYEBlZTxqiAW74aCVhoFv4
        KBEUl2UGMV21L70=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFE711927F2;
        Mon, 27 Jun 2022 12:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0891D1927F1;
        Mon, 27 Jun 2022 12:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/test-without-templates
References: <xmqq7d584hqb.fsf@gitster.g>
        <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com>
        <xmqqr13fxc5l.fsf@gitster.g>
        <220627.864k06i8im.gmgdl@evledraar.gmail.com>
Date:   Mon, 27 Jun 2022 09:11:52 -0700
In-Reply-To: <220627.864k06i8im.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 27 Jun 2022 14:29:50 +0200")
Message-ID: <xmqqbkueqe5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DCD73DF0-F633-11EC-A086-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You may disagree with some or all of those, but this series doesn't try
> to get you to agree with any of them. It's just making our tests more
> sturdy and explicit in their intent by clearly declaring which parts of
> them are relying on our default templates.
>
> So it's helping us spot issues like the one fixed in 7f44842ac19
> (sparse-checkout: create leading directory, 2022-01-21) earlier.

It's like arguing "this series is a bugfix, so what it fixes are by
definition bugs", isn't it?

> I really don't disagree with you per-se about us defining some minimum
> viable template,...

Well then it becomes debatable if it is a "bug" not to handle
missing .git/info that needs "fixing" by this series, and it also
makes it debatable if 7f44842a (sparse-checkout: create leading
directory, 2022-01-21) was also a "bugfix", or just tightening
against environment the end-user broke, no?
