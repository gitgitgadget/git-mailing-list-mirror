Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A16C63697
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FB322240
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 21:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lZYRm2ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgKPVTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:19:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57831 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgKPVTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 16:19:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A6F4F6918;
        Mon, 16 Nov 2020 16:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0mjjozRIBeO/
        3Zx6PG6g/8kVeo4=; b=lZYRm2obzRuo2gwZRQD3fXZ3tC7NE0LtyRILLAwHno5X
        yTOlhRyNeJmTEDNQe27KMqV05+5Igs/kn6R+Xw6/DzPAZPFLK0KvT4YGvbEBXgrA
        pApCNipzl3XyyQus9bD8bmZyjE65yoHNDS3LstQTyvmZbzzSjoYhnEFFRnbAWs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hWc2T9
        VC9rVWee2UJ+YVDKMx/FRwMMRR1An20ReSix2dUtPUksgmxzwIAJvcMQp+qpkY1j
        csWyPcagFoseTQUO6uCVN7RJcARvsxGCBpWK//WQ0WCSwBP5l1ExZ3rgWB9kzAIa
        83hjTCe9uwFsII9/RPBo+7/YMUg3/zon2gsmQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 101DAF6917;
        Mon, 16 Nov 2020 16:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 401DAF6916;
        Mon, 16 Nov 2020 16:19:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/3] parse-remote: remove this now-unused library
In-Reply-To: <20201114122132.4344-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 14 Nov 2020 13:21:32 +0100")
References: <20201112203155.3342586-1-gitster@pobox.com>
        <20201114122132.4344-4-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 16 Nov 2020 13:19:16 -0800
Message-ID: <xmqq4klp80ff.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62F77934-2851-11EB-83ED-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The previous two commits removed the last use of a function in this
> library, but most of it had been dead code for a while[1][2]. Only the
> "get_default_remote" function was still being used.

Yup.  ... still being used, but now it is gone.

> Even though we had a manual page for this library it was never
> intended (or I expect, actually) used outside of git.git. Let's just
> remove it, if anyone still cares about a function here they can pull
> them into their own project[3].
>
> 1. Last use of error_on_missing_default_upstream():
>    d03ebd411c ("rebase: remove the rebase.useBuiltin setting",
>    2019-03-18)
>
> 2. Last use of get_remote_merge_branch(): 49eb8d39c7 ("Remove
>    contrib/examples/*", 2018-03-25)
>
> 3. https://lore.kernel.org/git/87a6vmhdka.fsf@evledraar.gmail.com/

I am not sure why we even need reference [3] here. =20

Isn't it another mailing list article where you express your opinion
"they can dig our old version and copy it to their project", which
is the same statement you are making in this proposed log message?

Are we saying "we said the same thing on the list before, which is
stronger truth than the claim in this proposed log message"?

The removal of unused file is quite welcome.

Thanks.
