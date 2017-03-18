Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8A92095E
	for <e@80x24.org>; Sat, 18 Mar 2017 23:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdCRXLy (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:11:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdCRXLy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 19:11:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CC7B6301E;
        Sat, 18 Mar 2017 19:11:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s459qRPJU77x8vo0pUho/LUgst8=; b=bBlprv
        6ZES8CQDBQB/otL78nqHEaQNOyv1EThZSDV09709UhslxyhAagSCnf87Daes62qK
        T1AnqQlwVBmDccb/4ouEP1qggx2LUIGHZQsyX4HmR4kJbnJ9NugP2Zr+RrH0dQoU
        BMiVFGhDUq5zSxA0YuKmruZYHYZSm71cefM2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C5qukKlbSPUsvmWsRCKgOOVrSSjgzksu
        2WBDGkT37rDpInxFx0ly9py4asiiueoZ2zIm99cfCW3trrtXYgpNa0aSOLaFB3Ad
        hbLO3kunJygLio+L50VQjrhRufY2liohCo69TeBOJQfyldUCizIcM7krbM9D9DIV
        bGOuWVq4GJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74FD26301D;
        Sat, 18 Mar 2017 19:11:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D59B66301C;
        Sat, 18 Mar 2017 19:11:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Lang <david@lang.hm>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Is there a way to have a local version of a header file?
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
        <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
        <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
        <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
        <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc>
Date:   Sat, 18 Mar 2017 16:11:50 -0700
In-Reply-To: <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc> (David
        Lang's message of "Sat, 18 Mar 2017 15:40:08 -0700 (PDT)")
Message-ID: <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 454F4BA0-0C30-11E7-B846-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Lang <david@lang.hm> writes:

>> Ship a config.h.sample file, have a Makefile rule that is forced to
>> run before any compilation happens that checks if config.h exists
>> and then created it if missing by copying config.h.sample over, and
>> then all other source files can include config.h without having to
>> know anything about config.h.sample's existence.
>>
>> Did I miss something?
>
> There is no makefile with the arduino IDE/build system :-(

How does "the build system" you want to make it work with actually
work?  Is it incapable of "compiling" a "source file" into an
"object file" that happens to be a text using an arbitrary
"compiler"?

I was hoping that readers are imaginative enough to replace Makefile
with whatever way things are normally built with when reading my
message, and the reader can just replace "source file" with
"config.h.sample", "compiler" with "test -f config.h || cat
config.h.sample >config.h" and "object file" with "config.h".
