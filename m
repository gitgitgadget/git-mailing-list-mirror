Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAD11F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfKNCTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:19:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53258 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNCTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:19:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8862A33AD;
        Wed, 13 Nov 2019 21:18:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2QkxOA1n8P43
        rnXbboKxEpvWckg=; b=tj0OMu8cDcS+Lg5COb/5+A5/pgETPh5a6InJXK2Vj1NQ
        WXXOlgx7z2uLOEYmvovFp9sLu0sBOHrl7YbfezFkIonmWjPU0Mqf0vRpVXaMGT1Q
        L1Yn23XXHhWDy2IZKX7LWjJjavAbl1516+hVKNzgIsOsn05ug4tyfSbrXQDTN4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OIWXoD
        vA1Fynqq77aSWDSLSMZu7ricCwI+e9C8966DlEb9k5ZnKG/UZRofBfNU4X+jsvIf
        qR2dHGkAc8Qv+FiCAEyWixv23kqbTjVzIvP+JGjl2gMYegnczXl/3iSYsO0ctbE2
        7BdonzEQ1IqzEtHPmCCRq6vHq41qKxDqL5gEk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF815A33AC;
        Wed, 13 Nov 2019 21:18:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A98EA33AA;
        Wed, 13 Nov 2019 21:18:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: canonicalize "value_regex" with `--type=bool[-or-int]`
References: <cover.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 14 Nov 2019 11:18:53 +0900
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 13 Nov 2019 19:54:59 +0100")
Message-ID: <xmqqeeyb9p4i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1C21490C-0685-11EA-929A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>   git config --type=3Dbool --name-only --get-regexp '^foo\.' true
> ...
> This patch series teaches `git config` to canonicalize the incoming
> "value_regex" ("true" in the example above), then canonicalize candidat=
e
> values as we go through the config. Or if you will, `git config` learns
> a brand new type of regex, corresponding to the different ways there ar=
e
> of spelling "true" and "false", respectively.

Nice ;-)

> `--type=3Dbool-or-int` gets the same treatment, except we need to to be
> able to handle the ints and regexes matching particular ints that we
> must expect.

Hmm, so I can say 1024k or 1m and that would match 1048576? =20

Doubly nice.

Looking forward to reading it thru.
