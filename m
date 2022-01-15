Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43CC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiAOAuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:50:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53491 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOAuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:50:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 697C716B503;
        Fri, 14 Jan 2022 19:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=38Rx8O+pFzgU
        jPbp2sH2wVuwjMODjVzHgv8ENKObXDE=; b=X4pJ/HVzTsQ93Dotjx+jOL/9MKrd
        zVYd4QANXODrCAMbPBG/FSMODoTSI1OYmsr/1NYuriDUmHTvV2eLpzbCMcLbeLPY
        k2w60QwbcCQIchE9+VPKl/LFb2BV+Rr0aURWoc76zjXTICmGlGgHxrHeseXNWB70
        pKPEakwSyppn1pk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62E8916B502;
        Fri, 14 Jan 2022 19:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2ECC16B500;
        Fri, 14 Jan 2022 19:50:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
        <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
        <220115.86pmotrgjo.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 16:50:05 -0800
In-Reply-To: <220115.86pmotrgjo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 15 Jan 2022 01:13:48 +0100")
Message-ID: <xmqqr1996cw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 153A6E14-759D-11EC-BA6A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But we should really be recommending use of -- or --end-of-options
> whenever possible, as it can be hard to know in Git's CLI whether
> options after args are accepted or not.

Way before doing so, we should recommend the "options and then args"
order.  Users do not have to know which subcommands accepts options
after args.
