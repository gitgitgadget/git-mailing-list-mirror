Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6809CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B31A64DD7
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBKWqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:46:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53125 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBKWqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 17:46:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A953A110C75;
        Thu, 11 Feb 2021 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CburMkW6n508
        mSx2ISDfu9w3ldg=; b=M+7TWVTxEXvLb29dTUCN2CBR4yHGg6XaImqikYK6lW/S
        vGjxVX+aaUlJ8iBpPsU2kG/Nvu1Vxt1GfDa5xwpUh+hEKxc+QI7BJ8y+2ITQzXRp
        nrkPS07h6h33bX6QXYUXTqyl8PXg2iVZZsXWYQEMeI96qXXUhVYpybJqIL9Z1FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MQx1ah
        NTugZbHaiwLcInk3z5MAUGqziZbpl9s7deF9tZgiDUPZMmDpTCBr3RrEYn1UAs2l
        9s0lKa8EokZtgtNcz7WGdCL8fjDKA99Nw9YXwTe5mIBcF3NfOfYD+7a5+Roq2jSV
        GmeM20jOMhaNzHN7F3mUHFpToVt7pNuukNmzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E27A110C74;
        Thu, 11 Feb 2021 17:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB7FE110C73;
        Thu, 11 Feb 2021 17:45:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 09/12] test libs: rename "diff-lib" to "lib-diff"
References: <20210209214159.22815-1-avarab@gmail.com>
        <20210209214159.22815-10-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2102112312400.29765@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Feb 2021 14:45:27 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102112312400.29765@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 11 Feb 2021 23:13:56 +0100
        (CET)")
Message-ID: <xmqq7dnew7eg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6C455A0-6CBA-11EB-B6D4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi =C3=86var,
>
> On Tue, 9 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> diff --git a/t/.gitattributes b/t/.gitattributes
>> index d778bfad052..dafa17c3e61 100644
>> --- a/t/.gitattributes
>> +++ b/t/.gitattributes
>> @@ -1,6 +1,6 @@
>>  t[0-9][0-9][0-9][0-9]/* -whitespace
>>  /chainlint/*.expect eol=3Dlf
>> -/diff-lib/* eol=3Dlf
>> +/lib-diff/* eol=3Dlf
>>  /t0110/url-* binary
>>  /t3206/* eol=3Dlf
>>  /t3900/*.txt eol=3Dlf
>
> Lucky coincidence that this is still sorted ;-)
>
> The patch looks good to me. Thanks!
> Dscho

Yup.  It still needs to be signed off.
