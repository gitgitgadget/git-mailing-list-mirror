Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E8C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 14:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKOlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJKOk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 10:40:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FE651A2B
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 07:40:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 848EE1A2D31;
        Tue, 11 Oct 2022 10:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2Y8L8SmdVFUG
        oWrmyuZaMtR4s5nlyokrSAk4MSwLjRo=; b=Tnth5+G3xZxvMFu/9Cf1KrgP929n
        q+bcYdE8NIaHw+YzzDlMWvKRYUu1px0+xB20tMO4q9QpXzhlZKHkt1Qa2mUl85xK
        ONrww0BP+60qEzOYyB5n9eXzycR3VmSuHJEHTIn9UrYkmJBhO4/lp5zN+RF/4gG/
        vai8/5pCfSWK1SE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D5281A2D2C;
        Tue, 11 Oct 2022 10:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FD7D1A2D2B;
        Tue, 11 Oct 2022 10:40:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
References: <xmqqr0zkipva.fsf@gitster.g>
        <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
        <cb9f8321-d9e6-6f80-a590-a9ad49c7f557@jeffhostetler.com>
        <221011.86lepmo5dn.gmgdl@evledraar.gmail.com>
Date:   Tue, 11 Oct 2022 07:40:48 -0700
In-Reply-To: <221011.86lepmo5dn.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 11 Oct 2022 14:52:11 +0200")
Message-ID: <xmqqlepmwhhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B301F6A4-4972-11ED-8BEE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Per Junio's "That's nice to learn, indeed." in
> <xmqqo7uoh1q0.fsf@gitster.g> it seems to have had that intended effect
> on him.

I was commenting on the goal, i.e. you "may still be missing some
context here, maybe there's a plan to ...", and I meant that the
plan of the overall effort is something that is nice to learn before
going further.  I was not endorsing the method you are taking to
achieve that goal, though.

FWIW, I find my code sent in as a comment easier to read than my
prose alone for any topic, but that is only because it is "my" code
is easy to read for "me".  I am sure others would find it
unnecessary burden to figure out what the alternative/replacement I
send out intends to do and why it does so in the way it does, and
would rather appreciate if I explained these things in prose that is
easy to understand and rich in "why", which alternative/replacement
code would solely lack.  Code snippet helps illustrate points on
"how", but is often a poor replacement for proper explanation
because it is a bad medium to convey "why".

Same would apply to your code.  For others, including me, it often
is a lot of work to figure out what your code is trying to do, and
more importantly why it does what it tries to do in the way it does.

After all, when you are having hard time communicating why you want
to do things differently from the patch author in prose, code
snippet would probably be the worst primary medium to do so, because
it is full of "how exactly" with little "why".


