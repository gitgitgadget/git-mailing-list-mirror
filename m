Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81111F419
	for <e@80x24.org>; Mon, 11 Dec 2017 23:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdLKX3k (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:29:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdLKX3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:29:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DF0ABB7B0;
        Mon, 11 Dec 2017 18:29:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z7/zNOb9CD6n
        PF97Re5L3qnhO0o=; b=FYrFCZl+YYyEsjVIjiyRO/+GwGjeoqn9W6MvlLiG+SzY
        Ubk/CgMaGHXeC7ArmXdPrCaLrDyyT2LgwGoL7UD5o7lSCFqsQ5XH8EWWyeLNABXo
        /fHPGnZ7YCMaq8WyOAQjVTCAJYMHB105h+IePRIBu22pWZyjpnLNyPcbdL5F+BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qch8oA
        RDA9dGM3Rt93n3P8v2a12Al2C0AI48Slo8UeWwdW0fiXdAUsXMEsUYlR33QWuBpg
        BdJWZ46mly2tAhR+anZ4sLdSWpa886PadUFCcucioqfzB1+dgOHxCHuFYHsEA8LU
        I0KPVlFzQX7tfcE+ZyE0kJPN5cAB0lACTbInE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 837AFBB7AF;
        Mon, 11 Dec 2017 18:29:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9256BB7AC;
        Mon, 11 Dec 2017 18:29:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129195430.10069-1-avarab@gmail.com>
        <20171210211333.9820-1-avarab@gmail.com>
Date:   Mon, 11 Dec 2017 15:29:36 -0800
In-Reply-To: <20171210211333.9820-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 10 Dec 2017 21:13:33 +0000")
Message-ID: <xmqqefo04zdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 277DDE16-DECB-11E7-9797-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I don't know what I was thinking when I wrote this, but this logic
> should be fully robust, and I've confirmed that all tests pass
> with/without an Error.pm installed globally.

Thanks.  Will queue and drop the revert from 'pu'.


