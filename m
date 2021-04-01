Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B8BC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69808610CB
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhDAT4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:56:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65493 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhDAT4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:56:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4131B184F;
        Thu,  1 Apr 2021 15:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2iizkxi0amBC
        BD8dnFjS9u5WdjQ=; b=OQyzwslGkhY9Utn6n4nEyEjWsuj+v1AlrPZ38EKkkPuT
        ghBDoik1KS9wF5/XgK4HMnWDCWtpl30tNnSu+FZ98Zcm8ITYokJaqeCJWLDNHUm+
        ebgdPspc1NGgjVkocpI+NCfPXVIxsJXG0KbApmioCS0+GIax1EfErnmjtwKfBQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=olG6cu
        O6Sn5pJmHl1U4TygPtL60EjgkAPccVMRLw4Ul2yx2mFVzzkmU66hqG/Uuqon8UbA
        lkiT8RP5yAU3BLqs4QJQy9PHO2wHsVdULjknYNIEaOp4b/45IneAhYbgO/Fk9TfO
        l05AKDVw1SdQzXB5agO/oOZDeviNFZAGvvSO4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA51DB184E;
        Thu,  1 Apr 2021 15:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1D53B184D;
        Thu,  1 Apr 2021 15:56:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 0/5] mktag tests & fix for-each-ref segfault
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
        <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
Date:   Thu, 01 Apr 2021 12:56:04 -0700
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 1 Apr
 2021 15:56:25 +0200")
Message-ID: <xmqqczvd3hkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B67B1B0-9324-11EB-AACC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Here's a proposed v2. We test the same case, but I thought it made
> sense to test this more exhaustively.

Let's first make a targetted fix that can be applied to maint and
below.  After that is merged to 'master', you are free to add more
tests on top, but let's avoid to have more and more topics that go
overboard.

Thanks.
