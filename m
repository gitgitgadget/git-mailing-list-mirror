Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF41C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1545F20716
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSpOhtxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMUeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:34:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55396 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMUeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 16:34:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8C017B269;
        Thu, 13 Aug 2020 16:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=00pI6WRhCciz
        7WMovykSizvbWdE=; b=rSpOhtxfUROfb6ywLK/l9tFRnAO/IG8eAsOlQHKYdAqI
        5WjtGVQ+HqzWju9KgM5Tx+K8F3nk7YCCMyTL/Q9pQX+ysgrLlhYTQ3fsLuNPumw7
        GK64XgaJCsP4s+TNFwGuhuZ3i+uv8yWPfuiGF7dL8PS8HePoty3zsa7gHb9PzKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rfW7q7
        eWrj36epp+JX0YxHpeteWrhvtddbSUSWPIWyIiTRDpUkXdh7NH2el6XU1Pn4WojP
        ENfQKLchDosy06aY9782zwGVnX4zKrV/CykY+nI1hXdAbL7ct/+kTHi6epnJqyY9
        mjfY9sD0QBvmqtBeCDTPZlUf0Pw8Y7HgzlBRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE8517B268;
        Thu, 13 Aug 2020 16:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 435637B267;
        Thu, 13 Aug 2020 16:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as experimental
References: <20200806202358.2265705-1-martin.agren@gmail.com>
        <20200806230837.GA8085@camp.crustytoothpaste.net>
        <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
        <xmqqr1sifaeu.fsf@gitster.c.googlers.com>
        <CAN0heSqyBzW_+vWSAxV9O1XAJKmQgrhCms7mSa+hFFx35uU05w@mail.gmail.com>
Date:   Thu, 13 Aug 2020 13:34:10 -0700
In-Reply-To: <CAN0heSqyBzW_+vWSAxV9O1XAJKmQgrhCms7mSa+hFFx35uU05w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 8 Aug 2020 00:15:13
 +0200")
Message-ID: <xmqqmu2y1e0t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 583BE90A-DDA4-11EA-968D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> IOW, you question "if we go a few releases without any major issues"
>> part?  I tend to agree that for a large change like this, a few
>> releases may not be sufficiently long time for a feature that is
>> marked as experimental in big flashing red letters to get exercised
>> enough to get major issues noticed.
>
> Yeah, thanks for summarizing what I failed to express using so many
> words.
>
> I'm fully open to the idea that some people want to leave SHA-1 behind
> and that they can do it today, in some "local" sense. If those people
> are fully aware that they are guinea pigs, it might actually be ok for
> us to subject them to a few rounds of "oops, Git v2.32.0 produces data
> that v2.34.0 and later will barf on". Or at least it would be on our
> table whether we wanted to be that cavalier.
>
> Once SHA-256 repos as such are no longer experimental, I fear that we
> can only buy ourselves that leeway by introducing fiftyeleven different
> config flags for "please produce auxiliary files X even if you don't
> actually use them", "please do use X, and I'm fully expecting to trip o=
n
> them if you decide to tweak them in backwards-incompatible ways", and s=
o
> on. The alternative to buying such leeway might be to establish, pretty
> early on, a respectable set of things we support "for compatibility
> reasons".

OK, so can we resolve this one way or the other and move on?

For now, I'd vote for applying this warning patch, but with or
without such warning, it is more important to iron out those details
we fear might have to change.

Thanks.

