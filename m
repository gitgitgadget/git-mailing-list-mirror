Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A35D1F461
	for <e@80x24.org>; Mon, 13 May 2019 22:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEMWet (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:34:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64515 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:34:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 350AF15C503;
        Mon, 13 May 2019 18:34:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wKVzPS85EzAe
        bSBr4NMz1aIMzFU=; b=xBHzD68ejyUhH4hTEf46iSsUmToTDEvkcgxNM4hafSPN
        TYjJcOdkn/A23hKK5RlwdLHgyZy2cRblJ6zkAOZB/GBmMV0ydT+CJbonrvybZRBI
        7tHkLVOiKB824oV7CB1Yv4n0sO2Su0lqLJO0h1K8q76FGKa6qgYwBMc0y6u0SiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JBrZF+
        W9Bf3Ym0Ep4n2l2/Nog91r/6iBPEw7uYHmEg0TPO6U940mAxY73JJRTwXwIstOtj
        jfW5T4NPKAdjTJpqcoSEr2SW2JnYXDGSSuLCTIcQS9sHWtK/E4hC7swDVJ17De8l
        R82suiuEMAyAM4wZc45jxTjHE+IUoxX4JWsKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CB2715C502;
        Mon, 13 May 2019 18:34:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9567815C4FF;
        Mon, 13 May 2019 18:34:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc0
References: <xmqqef52baih.fsf@gitster-ct.c.googlers.com>
        <87pnomvvml.fsf@evledraar.gmail.com>
Date:   Tue, 14 May 2019 07:34:46 +0900
In-Reply-To: <87pnomvvml.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 14 May 2019 00:26:42 +0200")
Message-ID: <xmqq1s12asqh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 503B4DD8-75CF-11E9-80CD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> -CC lkml & git-packagers.
>
> Some suggestions for fixes in RelNotes & last-minute observations:

Thanks.

>>  * "git stash" has been rewritten in C.
>
> I just noticed that stash.useBuiltin added in 90a462725e ("stash:
> optionally use the scripted version again", 2019-02-25) doesn't have
> docs like rebase.useBuiltin d8d0a546f0 ("rebase doc: document
> rebase.useBuiltin", 2018-11-14).

Yeah, that may be a good low-hanging fruit to pick.
