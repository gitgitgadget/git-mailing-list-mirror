Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FE62023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbdCDT7P (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:59:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752115AbdCDT7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7BBA72EC5;
        Sat,  4 Mar 2017 14:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R4/y64g/PvPP
        eOzuWDfLFOZH0Q0=; b=FHfWlS4ra6B+y84s8YLqyatBhmWFqJPiqct2xHeVX6Zz
        v2wl658vKZ06btXU4Rxb462OPp8Gx18H2do58eTPsl1A+hJS+o8GD0i0v6ejh4Cm
        nVvbJBkcLO772egOFDSo/lsVCzME1VO1QE1lAsi7ohqUDbLBjr8psI2UjtWb7+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xfJ03G
        FwGEYlabtGbKbhL7kFZcOiBLqZo6OnpSkS0D6vxO+d5RjRqsSkQzuewgZNFikhsN
        v8iOScZlo2TkhDk6emq2UctTu7gzghsAD+pglw16U2cGGWQfG0sfK+h3bOHXCiUv
        Ck7F1s6UppN8V+fWxTaSdGhH2WqgGY5ZsXyvg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF35672EC4;
        Sat,  4 Mar 2017 14:59:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EB8072EC3;
        Sat,  4 Mar 2017 14:59:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Mike Crowe <mac@mcrowe.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
        <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
        <20170302142056.GB7821@mcrowe.com>
        <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
        <20170302200356.GA31318@mcrowe.com>
        <ae2b144a-5e39-8178-5161-1d8eb673b6f0@web.de>
        <xmqq37eu2qxl.fsf@junio-linux.mtv.corp.google.com>
        <9c9eeb35-e1c1-ec46-1d85-ef6a05886880@web.de>
Date:   Sat, 04 Mar 2017 11:59:10 -0800
In-Reply-To: <9c9eeb35-e1c1-ec46-1d85-ef6a05886880@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 4 Mar 2017 07:25:52
 +0100")
Message-ID: <xmqq4lz87r01.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 096AFC54-0115-11E7-9733-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>>         enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL
>>>                                     ? SAFE_CRLF_WARN
>>>                                     : safe_crlf);
>>> +       if (size_only)
>>> +               crlf_warn =3D SAFE_CRLF_FALSE;
>>=20
>> If you were to go this route, it may be sufficient to change its
>> initialization from WARN to FALSE _unconditionally_, because this
>> function uses the convert_to_git() only to _show_ the differences by
>> computing canonical form out of working tree contents, and the
>> conversion is not done to _write_ into object database to create a
>> new object.
>
> Hm, since when (is it not used) ?

Since forever, but my statement above said "this function", which may
have confused you, where it could have said diff_populate_filespec().

Surely it is possible for somebody to diff_populate_filespec(s, 0)
and then call hash_sha1_file(s->data, s->size, "blob", ...) to write
the data into the object database to create a new object.  But that
sounds really crazy, no?

> The SAFE_CRLF_FAIL was converted into WARN here:
> commit 5430bb283b478991a979437a79e10dcbb6f20e28
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Jun 24 14:35:04 2013 -0700
>
>     diff: demote core.safecrlf=3Dtrue to core.safecrlf=3Dwarn

Yes.

> Does this all means that, looking back,  5430bb283b478991 could have be=
en more
> aggressive and could have used SAFE_CRLF_FALSE ?

That is pretty much the statement, to which you said "since when",
suspects.

> And we can do this change now?

I am not sure.  The conversion the safe-crlf code does is unsafe and
it is a disservice to users not to warn whenever we notice they are
risking information loss.  Maybe time they run "git diff" is not a
good time to warn, as they may not be actually adding the file
as-is, but if warning against information loss at "git diff" time is
important enough, the I think that should not be squelched by the
"--quiet" option, which is about "do not show the patch text
output".  It should not be taken as "do not diagnose any errors".

