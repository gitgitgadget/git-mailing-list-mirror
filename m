Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EEC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C92206F5
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BSrXY71H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDCVZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:25:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64327 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 17:25:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05D53B3B0E;
        Fri,  3 Apr 2020 17:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1waL2NXtqSoq
        0dY4vE4+eF0CSHs=; b=BSrXY71HHLXKTzLwD6Up78pSsHMfqOGAwXdCS0MHKc80
        522u3U4+QBz2KM9X6y9k2PGSJ+dIMDscL8Id/0yCn7HU0mVCmmjdR3FGxG0CIkjk
        qVYx8+aCP2qyxek9XfLt9iTsumu1AqTEjQx+bAB2kqDUlXIzTQUk45fo2S3qW6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yUw8JB
        23NbWXJKS/d1Z7Qcrhvps4/oQzfZ1eZGAAP4aAwq8EwmJAyxQM5qkqv3osBGv6hx
        2CoIqtpQWOj/SU+lQo8Sr5F77WdiXBgB4p5wQZJ/6xBpOopEEGfIx5RNqWZuML9l
        oyltEYR/+AyCAS+iE9nzX6H1LT+cCIOz/QuyA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F206AB3B0D;
        Fri,  3 Apr 2020 17:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7406B3B0A;
        Fri,  3 Apr 2020 17:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     number201724 <number201724@me.com>, git@vger.kernel.org
Subject: Re: The closing bracket is missing.
References: <8d439c14-6b39-bbb7-a558-61c1e79ff1f3@me.com>
        <20200403202709.GC6369@camp.crustytoothpaste.net>
Date:   Fri, 03 Apr 2020 14:25:49 -0700
In-Reply-To: <20200403202709.GC6369@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 3 Apr 2020 20:27:09 +0000")
Message-ID: <xmqqzhbsxnvm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B141230A-75F1-11EA-A4D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-04-03 at 02:39:10, number201724 wrote:
>> command-list.h:53:69: error: expected =E2=80=98}=E2=80=99 before =E2=80=
=98;=E2=80=99 token
>> =C2=A0=C2=A0 53 |=C2=A0 { "git-apply", N_("Apply a patch to files and/=
or to the index"),
>> 0};
>>=20
>> command-list.h=C2=A0 The closing bracket is missing. In the master bra=
nch.
>
> I don't see this behavior when compiling on my system, which is a Debia=
n
> sid/amd64 system.  Can you tell us a little more about your system and
> its version, including what shell is being used for /bin/sh, how you're
> building (with make or with configure), and anything else that might be
> relevant?

Good suggestion.  As this is a generated file, we can have issues
with the different behaviour in the commands used in the toolchain
to create it.
