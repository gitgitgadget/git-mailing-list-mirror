Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A761F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937741AbdLRSCK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:02:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63864 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934176AbdLRSCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:02:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44ED3C56F0;
        Mon, 18 Dec 2017 13:02:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ugbk4ikFhjaK
        V/oojaUR7J2BiH0=; b=D+7aJG9KyJGhOy3JQBqBZu9MblNWk08UCzv3xsIIGU8/
        XNOLPsl+qKPld9iRWZ+Q1WsYN56hjiZ0KX4VhGh9pXW2aWTEGAE9db2FMjWOlahT
        4pdVBtEJzP3JK8mA/qRVliE6uTgZq+AFxyrhycSXONafCxnPkT8OtNtpZvjtA28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Memhoh
        JIqGydATQh3Hlu94/W0J5MM9dKzZxSFU84CPCpBpDret4by7IbOJEzr6KQpy44Yj
        o65y84ei1NydvRkaEUW4Z/Ipp4DhdG0Rh0B1P2wE9mT0SpRuKwynHVI8W19hCAGS
        gBsBR+0Kow9HyU237Si5yR7Kjkv4XP/ZpjDCI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B53DC56EF;
        Mon, 18 Dec 2017 13:02:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8ABB4C56EC;
        Mon, 18 Dec 2017 13:02:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, peff@peff.net, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
        <20171218101334.GA20685@tor.lan>
Date:   Mon, 18 Dec 2017 10:02:02 -0800
In-Reply-To: <20171218101334.GA20685@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Mon, 18 Dec 2017 11:13:34 +0100")
Message-ID: <xmqqzi6fykx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D74668E-E41D-11E7-BFB3-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Just to confirm my missing knowledge here:
> Does this mean, that git-gui and gitk can decode/reencode
> the content of a file/blob, when the .gitattributes say so ?

These programs, when told that a file is in an encoding, read bytes
from that file and interpret that byte sequence in the given
encoding, and blits the corresponding glyphs on the screen---giving
UTF-8 out is not the primary feature of them, so I am not sure
decode/reencode is a good term to use here.
