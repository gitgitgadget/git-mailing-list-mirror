Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A2C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiHBVAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiHBVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:00:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D792FDE
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:00:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 639441AFEE5;
        Tue,  2 Aug 2022 17:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SdluWlJsD2j4
        kVHwFiWC1Q9IXXDVXi49WR3Z0blBhEY=; b=jVMp3SvyCaQzSFaaPnZjVbUloltM
        n11hgG+Hk8iUIeNKiejYJhRM2OhmK7HQOKtQv3fLohpR0qjDvPaZ1Sq/32+YZ1+M
        xnV69YDM4tI7kNwGhNUMxnWIGh3Fa32E39cBAqaEDYRXW6SzSbCmaAE0vyKtLKPe
        M+l93yQUi2BY4mo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C7571AFEE4;
        Tue,  2 Aug 2022 17:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0BAD61AFEE1;
        Tue,  2 Aug 2022 17:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220725123857.2773963-2-szeder.dev@gmail.com>
        <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
        <20220802173754.GA10040@szeder.dev>
Date:   Tue, 02 Aug 2022 14:00:09 -0700
In-Reply-To: <20220802173754.GA10040@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 2 Aug 2022 19:37:54 +0200")
Message-ID: <xmqqsfmefjja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18F02156-12A6-11ED-88AD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Dunno.  I don't like this NO_PARSEOPT thing, and instead of testing it
> I'm thinking about removing it altogether.

Sorry if this is obvious to the others, but I am confused here.

Lack of NO_PARSEOPT bit is used as a mark to say "this subcommand
takes '--git-completion-helper' option to help listing the options,
so include it in the 'git --list-cmds=3Dparseopt' output", right?  I
do not mind removing an unused or unnecessary bit at all, but what
is your plan of getting rid of the bit?  Will we make sure everybody
supports the "--git-completion-helper" option?

