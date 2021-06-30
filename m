Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF5C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 21:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68046146D
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhF3VVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 17:21:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56828 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhF3VVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 17:21:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2D6913B7F6;
        Wed, 30 Jun 2021 17:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oQT6VzQ1J9Ab
        8ElE+sypdonCbucSMte+E4i0BFiKxVw=; b=YPlyQKILL0FMso0jPMQ717AS1UwT
        D9iOT6VF3Gvn5sBuCNVXwMBXld4Xsne5QAkFC/BCVAcNIUwr4Hn2ZsykO8zojI2g
        TXrTxtf68KV92752fZuQrRegEbjGg3Vya/n7oQQdN2rcHM89CLXRbQpt5m+5hcRH
        yTt3w4oI7dtYJ8Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AA0C13B7F5;
        Wed, 30 Jun 2021 17:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E284C13B7F4;
        Wed, 30 Jun 2021 17:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 3/3] bundle: remove "ref_list" in favor of
 string-list.c API
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
        <patch-3.3-f1066ee1b9a-20210630T140339Z-avarab@gmail.com>
Date:   Wed, 30 Jun 2021 14:18:35 -0700
In-Reply-To: <patch-3.3-f1066ee1b9a-20210630T140339Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 30 Jun
 2021 16:06:16 +0200")
Message-ID: <xmqqfswzt5jo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BBAF9F5E-D9E8-11EB-BA2D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move away from the "struct ref_list" in bundle.c in favor of the
> almost identical string-list.c API.

Nice.
