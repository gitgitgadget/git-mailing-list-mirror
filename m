Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A36F1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 19:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeAaTMt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 14:12:49 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:55183 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeAaTMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 14:12:47 -0500
Received: by mail-wm0-f49.google.com with SMTP id i186so1184052wmi.4
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pKJcKN/eSFwHgfrLSSzuani7F0hOLGndIKO+8cAn6TE=;
        b=O0vkIKbpHDfUUiHTGJpVuMitXP9Ot8iLwgC/v1COUwZuuQCnoTx7s8t6/usDleuAAU
         Zc2BqVe1Avz+RcgxlEADTNSX8ivVuenB3RlgQDz+3oiY6ztTz/vgLMZIbeqcxkBG9JAa
         24aULALwxEBAFB3hMRMOH6CrTpCqEZV356wodov/OmLDRUX20FMb2Fd4r0yru7YQeDYB
         gTJD3TUvVguP03Rq/F25q4Q+pHSYBnm3BJRBCdBcgi0Mo3bfLnOimA+jBmMkpwwytGwf
         EuGWR+d07PUpIEvAnaFSKdvC3cf7xE+Q1Z2EjCjznD+txVHxxEYkhmBKyaVGg+ErMGfl
         3xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pKJcKN/eSFwHgfrLSSzuani7F0hOLGndIKO+8cAn6TE=;
        b=EplZWIvrEO0y0F0MOMtAQGZ+Ymvx/st0yRlw1lVpIjusvqE4CToNqucjLuAQnRXNuF
         glW6T9/P9ulNtHPsqg4mPMJ5Gvxtctlg52EL61xgI/kjczxaToelP99/675muzE+CFOW
         6lwgMgMtZ/bk0DwmplIYfVY4jSoZwCPt2hFOjaPsb1J0TpRC8wF7E3YKYqDs82Ndi+DW
         PXsMKYsGUewf1RUgAESX8iAwdM2FprQZhQRqCT/XZZCggSXT8MLaxygWkdRtyiysqqwb
         UGbEfLZ7vFeDu0brb626LzhiSgGhPTuj3Rid4rGDZT1x9nk/1yFvpYTzCLKSl2SAdy/K
         /vLw==
X-Gm-Message-State: AKwxytdZ/fEd6DJIHg32ErXvok4o33tWnq13AdBS1bdmRCGbISrtlT7t
        AN9fh+AxCP9Jl7dGznKw6eo=
X-Google-Smtp-Source: AH8x225o95EocnykxiUeg0RsRjf02fJr7StaDcKDSpuyKnOtoTU+qgvsQPfxn03ZgnItXMch7JnxWw==
X-Received: by 10.28.55.81 with SMTP id e78mr26241771wma.50.1517425966404;
        Wed, 31 Jan 2018 11:12:46 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id j126sm5065943wmj.1.2018.01.31.11.12.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jan 2018 11:12:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqfu6nrowm.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 31 Jan 2018 20:12:44 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <57086A32-6A2A-4B66-A355-10408C9FE0B0@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201908.9398-1-tboegi@web.de> <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com> <396FBDFA-606F-41D9-988C-D6886089BC15@gmail.com> <xmqqfu6nrowm.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jan 2018, at 22:56, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 30 Jan 2018, at 21:05, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> tboegi@web.de writes:
>>>=20
>>>> +	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, =
"SHIFT-JIS")) {
>>>> +		char *re_src;
>>>> +		int re_src_len;
>>>=20
>>> I think it is a bad idea to=20
>>>=20
>>> (1) not check without CONV_WRITE_OBJECT here.
>>=20
>> The idea is to perform the roundtrip check *only* if we=20
>> actually write to Git. In all other cases we don't care
>> if the encoding roundtrips.
>>=20
>> "git checkout" is such a case where we don't care as=20
>> noted by Peff here:
>> =
https://public-inbox.org/git/20171215095838.GA3567@sigill.intra.peff.net/
>>=20
>> Do you agree?
>=20
> I am not sure why this is special cased and other codepaths have "if
> WRITE_OBJECT then die, otherwise error" checks, so no, I do not
> agree with your reasoning, at least not yet.

The convert_to_git()/encode_to_git() machinery is used in two different
kinds of code paths:

Some code paths actually write to the Git database (indicated by the=20
CONV_WRITE_OBJECT flag). I consider these the "critical/important" code=20=

paths and I don't want to tolerate any encoding errors in these cases as=20=

the errors would be "forever" in the Git database. That's why I call=20
die() on errors for these cases to abort whatever we are doing.=20

Other code paths do not write to the Git database (e.g. during "git=20
checkout" we use the code to ensure that we are moving away from the=20
exact state that we think we are moving away). In these code paths I am=20=

less concerned about encoding errors. I also don't want to abort the=20
operation (e.g. "git checkout") in these cases. That's why I only inform
the user about the problem with an error message.

The encoding round-trip check can be expensive. That's why I decided=20
initially to only execute the check in the "critical/important"=20
write-to-Git-database situations (CONV_WRITE_OBJECT flag!). I also=20
decided to run it only if the "SHIFT-JIS" encoding is used as this was
the only encoding that I could find which reportedly does not round-trip
with UTF-8 (although I was not able to replicate the round-trip=20
problems).=20

I want to change the current implementation as follows:

I want to check the round-trip encoding only if the the environment=20
variable "GIT_WORKING_TREE_ENCODING_ROUNDTRIP_CHECK" is set. This way
a user can check the round-trip if necessary for *any* encoding. I
don't want to make it a git config because that setting should only=20
rarely be used for debugging purposes.

Performing the round-trip check every time is not necessary from my=20
point of view because it can be expensive and I was not able to generate
a test case which *does not* round-trip without triggering any other
iconv error.

- Lars=
