Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF8A20370
	for <e@80x24.org>; Fri,  6 Oct 2017 02:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdJFCB7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 22:01:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751395AbdJFCB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 22:01:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76D569902B;
        Thu,  5 Oct 2017 22:01:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=40uBJE44W9YF
        DEawFOnEs9ynEDs=; b=eo3gJ9kBlVsZ4UqxOJKIGzO0PiJmh2tgEwWnGuTl1bjY
        mU9rlm8A3wtg2GQoYwsGB8ETCUhT1HvzeF1hLaG5hcCroanDHNBQI9ff38cpFqSU
        fcmXkHvOnMNnpHS+TY4LvLWFWruv3tTT41w89gq+Pgx6iJUEJHKr7o9YmBwOzqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=E20FlJ
        BAUwBsG8SwaLxLTDMZ4RP9WOltEOgH1NCO+j3Przg6HKfBonEVSBH39m4MxDBDYk
        LBoauOmRuzgHXnpMprJiz0MczJRpnGHHsp6DeauM3asmaxGP48gd7Vd5EFI+vZ/f
        VfXVu73GacH+S7esCJq1BkQxL+5k65D025xKg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB6699029;
        Thu,  5 Oct 2017 22:01:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B11849901A;
        Thu,  5 Oct 2017 22:01:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/12] read-cache: leave lock in right state in `write_locked_index()`
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
        <cover.1507228170.git.martin.agren@gmail.com>
        <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
Date:   Fri, 06 Oct 2017 11:01:43 +0900
In-Reply-To: <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 5 Oct 2017 22:32:13
 +0200")
Message-ID: <xmqqefqhyqyg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4DC0C8F6-AA3A-11E7-B6AB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> v2: Except for the slightly different documentation in cache.h, this is
> a squash of the last two patches of v1. I hope the commit message is
> better.

Yeah, it is long ;-) but readable.

Thanks.
