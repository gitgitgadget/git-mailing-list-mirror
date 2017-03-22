Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F01B2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbdCVWsD (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:48:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64363 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753637AbdCVWsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:48:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A67937D481;
        Wed, 22 Mar 2017 18:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jsvBbSBhtF1qlhYXRiR2/apeYvc=; b=wGRI3l
        MgnvZOWfSjxDpc8LSB9WM8nWnhyGqIOfu2cPOZ1T78U0y2h/aqezNJnP9yhSzOkS
        QiMR6hh3ZD6t2DwzrlVPpJDR3lfEMUcwYwglQc7dIENnreB8hQXQ94n9D6ma8zMa
        VDOzjML3sEA2gmThqyWxynMoXPz9DWYBJEOY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bG57aUOtYX7gieSds+qi21faDRQgP0QI
        JasWOnKZXXi5UhVBNZ/IJues9g5yOfuTMsEV6W7BA1sKzTKe9wDLcUKp20Xop4SH
        qsNGqkg9636x2XbtRjI3EDlyu1yhZKHejQmHAkGoiZtsXNbadKbwXrEt4iYaDl1/
        JkXJVMwkjKA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A00887D480;
        Wed, 22 Mar 2017 18:47:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12BCC7D47E;
        Wed, 22 Mar 2017 18:47:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-4-gitster@pobox.com>
        <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
        <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
        <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
        <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
        <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
        <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
Date:   Wed, 22 Mar 2017 15:47:57 -0700
In-Reply-To: <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Mar 2017 18:41:24 -0400")
Message-ID: <xmqqh92lgc82.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98F2D1E0-0F51-11E7-89C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OTOH, we could perhaps make the rule "ignored unless %(gpg) formatters
> are used". Which would be backwards-compatible and safe for old formats,
> and work correctly for new ones.

Yup, that is a very sensible escape hatch that we can use later.

Thanks.
