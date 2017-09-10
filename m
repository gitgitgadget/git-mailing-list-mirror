Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588611FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 07:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdIJHkA (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 03:40:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751279AbdIJHj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 03:39:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2755BAC653;
        Sun, 10 Sep 2017 03:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jqVH2J12vKsK
        HLs6hLoCBdYTg3M=; b=xu8v1Yjx1PqIwYwPxzJdofjJKVXxhZi9j52Ykhwuca7O
        nirzJGxJ4Ek7OvcsV1FngpGuvA3j2itN/IEWpZzuCuZX39TwPkCXcFWcBXiqX6TD
        59rtHKZLNTDNpbzuqdEYktUdL5mkNoL3z1qexS4LlRVmANsDC8njKwS42LO2554=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LZnEkA
        elTLPvCBAoeBzon3gXWtNodsuAcrzPDweSuqJZvLZY/r1WaeOQ4Y2Tnnf0a3mLn5
        u2ndY1gIYrCxCGHGxp/OSquQ2HgYjoHEdvtOQrCj4HpqzU1hsXAcaBbqxliUrJwA
        P7MVevOgUq1ORfHP21pRQzBuUIeTwobLgTMHE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20928AC652;
        Sun, 10 Sep 2017 03:39:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8688AAC650;
        Sun, 10 Sep 2017 03:39:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 34/34] wt-status: release strbuf after use in wt_longstatus_print_tracking()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830182018.21390-1-l.s.r@web.de>
        <xmqqmv6761xk.fsf@gitster.mtv.corp.google.com>
        <33aecb28-e930-f500-3452-3899d1116d9f@web.de>
Date:   Sun, 10 Sep 2017 16:39:57 +0900
In-Reply-To: <33aecb28-e930-f500-3452-3899d1116d9f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 10 Sep 2017 08:27:30 +0200")
Message-ID: <xmqqd16zxar6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F131082-95FB-11E7-B299-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 06.09.2017 um 21:51 schrieb Junio C Hamano:
>> Rene Scharfe <l.s.r@web.de> writes:
>>=20
>>> If format_tracking_info() returns 0 only if it didn't touch its strbu=
f
>>> parameter, so it's OK to exit early in that case.  Clean up sb in the
>>> other case.
>>=20
>> These two "if"s confuse me; perhaps the first one is not needed?
>
> Yes, removing it looks like the best way to make that sentence clearer.
> Another would be to replace "only if" with "then".

Either makes it understandable. Thanks.
