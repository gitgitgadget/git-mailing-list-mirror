Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59724C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173F364F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCQSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:02:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62386 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhCQSBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:01:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F97A36B3;
        Wed, 17 Mar 2021 14:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=revyBgq9BtJ+
        PGYcCMCc2qPRR0c=; b=ERkl1adZs8n11TtDB8iNt5Eefo+dzK2+1yYM4PBzH6jy
        zrFbdeCSlYzvSndC1nkRSiHM/9I1MNbVjyOvSlZooIhxcE1qGCiWCGQI/VbRqN+s
        zAAHXA97WqqhDzAZ2FgGmd65iALhf2xB0y3slyVAKlLYQGAU/FEhLzUbTbH2X3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xajrT5
        5bIM5ZRShLsZbBl/LpUuNHOOfrP7RhrwLep43uugr8e8g3Wv87CROl8IibSdbSt2
        Ss1fG6Teys9Ms0UXnw70+6U62xcu0J7900yy5Ps8oUWfPfXTcFoae2yWQTigsfTN
        ReWBgCNkfGktMp6EV62ZkVibDFOP+5uEyzf8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F853A36B2;
        Wed, 17 Mar 2021 14:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55A96A36B1;
        Wed, 17 Mar 2021 14:01:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
References: <cover.1615856156.git.liu.denton@gmail.com>
        <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
        <87mtv2dk18.fsf@evledraar.gmail.com>
Date:   Wed, 17 Mar 2021 11:01:47 -0700
In-Reply-To: <87mtv2dk18.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Mar 2021 13:47:15 +0100")
Message-ID: <xmqq1rcdy7zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D7DB2856-874A-11EB-9C43-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +	./check-sort.perl '\t\{ "[^"]*",' <git.c
>
> This last one you can IMO be done better as (or if we want to be more
> anal, we could make git die on startup if it's not true):
>    =20
>     diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>     index 5679e29c62..5bd2ebceca 100755
>     --- a/t/t0012-help.sh
>     +++ b/t/t0012-help.sh
>     @@ -77,6 +77,11 @@ test_expect_success 'generate builtin list' '
>             git --list-cmds=3Dbuiltins >builtins
>      '
>     =20
>     +test_expect_success 'list of builtins in git.c should be sorted' '
>     +       sort builtins >sorted &&
>     +       test_cmp sorted builtins
>     +'

"LANG=3DC LC_ALL=3DC sort ..."

I like this 100% better than the original ;-)
