Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2C92095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdCRSIw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:08:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751828AbdCRSIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:08:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5592A83461;
        Sat, 18 Mar 2017 14:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I2WKLsBntm28
        byCKGYiEa3yL9cE=; b=SDj5bwUI5WQyr1gZyQ9mkGbNBOjoNTDrTOZNCq833Oqw
        P2UvZHKroHsqhSlTMXdxOtQyLMNQISWcAXLDLCJIfYKapr1cIINCz+TAE4tP7cC8
        RoEOhzftxxI6HRfvPri6F+1p3XFhl/M8krKf7nMEk5JZ8l+mJ1vvNgzgCMSQcKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aZs48s
        5ZFe2dVuTLICBF4meH1MOjlGVWnjrlI5+JuAZeaLNExi9Wmc5K4dE1znLODKz0Ma
        1hLRPOUt5GimSlkAo50lAzLHWFnlHcZpRximdJMneF2BQnk72mPauYck3TjDVWVf
        h52ASvOpb6gSqpQYdoMrITlmEkru/rU0nFSKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E76883460;
        Sat, 18 Mar 2017 14:05:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A06798345F;
        Sat, 18 Mar 2017 14:05:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     David Lang <david@lang.hm>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Is there a way to have a local version of a header file?
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
        <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
        <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
        <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
Date:   Sat, 18 Mar 2017 11:05:50 -0700
In-Reply-To: <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 18 Mar
 2017 18:08:27
        +0100")
Message-ID: <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85C43680-0C05-11E7-8453-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> There might be some way I haven't thought of, in particular maybe you
> can use gitattributes to define a custom diff/merge driver that always
> reports no changes, or some ways to (ab)use the index to make git
> ignore any changes to the file.

Why does this have to be so difficult?

Ship a config.h.sample file, have a Makefile rule that is forced to
run before any compilation happens that checks if config.h exists
and then created it if missing by copying config.h.sample over, and
then all other source files can include config.h without having to
know anything about config.h.sample's existence.

Did I miss something?
