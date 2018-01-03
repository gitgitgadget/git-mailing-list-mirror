Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9931F404
	for <e@80x24.org>; Wed,  3 Jan 2018 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeACJhZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 04:37:25 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46411 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeACJhE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 04:37:04 -0500
Received: by mail-wr0-f172.google.com with SMTP id g17so904960wrd.13
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u8tZKiqh5/+aIPZbCppeIJszekW+o1ITiFhw3zdB2js=;
        b=kOK+/rgjs7hNm3seroXkL8SP1CDvNuGUgficui2aIG2kqHWBv7OMLvmPtKa5mTc75A
         cOXRWab/BbdXZ6pih9c0AR/BkDHbfKmHAe+ZSbh5tflNbSWV7ejyUy/D2Ex7wSlYg/0c
         +oTtfKlu3eiboL9vtjEa8cBRajP0dx1xFlbVqbprmk/8avy1LR6QkXTt+iu2bScL9GtA
         C3waxazrX/CzYP47EfmZbJGczUQePYbv+CQYupAgy6m6SpUKxsUxVbvQSqnWNwx5N+Qo
         lsqvfT8+bRUetnJxB1l9K1A8Di9jn671CIdNItHim1fTHDEWUwuqGbTuW6/b7siYd0F2
         Yfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u8tZKiqh5/+aIPZbCppeIJszekW+o1ITiFhw3zdB2js=;
        b=mQmYsgoANA3jDotnYdoT8svGdiG+LLOHKehV7vzjrUI1ELIDgPT4DSWoFI3ERqfM/T
         DUyxbC/1rvXAYrgxebPcs5Vxe6/AD+v2gjVaGnpd8crZstvqtnqH/aixHIzlde0cpJvM
         vbX4bs0aYt4ywbVx8vVp/DKR6rNdU1in/YqREtPiBX++7KOQJwRq0wvj1CSIlMpVsXHI
         QW83a3p/LzVl+Op3f//ZSjpyxmOxGtlUUvo0orFok9fvzxmFQkHjundcqWB5JNZs2gOw
         /x542kglu5soxhkDEfX5g1bISB5R3T4nq1cQzZt+JubT+bME2PqWIBflSmnjUHQETdmA
         nnlQ==
X-Gm-Message-State: AKGB3mLUsDQPRAKgsf/P+79Dv+y57h7L3d5tgjahaI2nV4oxettytaGI
        gDItA73taTBfIX9/qRbEv48=
X-Google-Smtp-Source: ACJfBouqyQ+K7u6qyeftIywAe1QxNxqADvUY+xE84EqI8SfeQibX7b0NKS4aTTXZKyDxpFhnNuPAhQ==
X-Received: by 10.223.160.233 with SMTP id n38mr951193wrn.45.1514972223559;
        Wed, 03 Jan 2018 01:37:03 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB59EF.dip0.t-ipconnect.de. [93.219.89.239])
        by smtp.gmail.com with ESMTPSA id x26sm304878wmc.12.2018.01.03.01.37.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 01:37:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180103053654.GA428@tor.lan>
Date:   Wed, 3 Jan 2018 10:37:02 +0100
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, gitster@pobox.com,
        patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C03FD92-FB9A-4065-9D88-0FBD268F8737@gmail.com>
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com> <20180101215959.1460-1-tboegi@web.de> <37D4996F-CC42-4D01-B15E-6287F1F5BF83@gmail.com> <20180103053654.GA428@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Jan 2018, at 06:36, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Tue, Jan 02, 2018 at 08:11:51PM +0100, Lars Schneider wrote:
>=20
> [snip]
>=20
>>> /*****************************************************************
>>> diff --git a/diff.c b/diff.c
>>> index fb22b19f09..2470af52b2 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -3524,9 +3524,9 @@ int diff_populate_filespec(struct =
diff_filespec *s, unsigned int flags)
>>> 	 * demote FAIL to WARN to allow inspecting the situation
>>> 	 * instead of refusing.
>>> 	 */
>>> -	enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL
>>> -				    ? SAFE_CRLF_WARN
>>> -				    : safe_crlf);
>>> +	int conv_flags =3D (conv_flags_eol =3D=3D CONV_EOL_RNDTRP_DIE
>>> +				    ? CONV_EOL_RNDTRP_WARN
>>> +				    : conv_flags_eol);
>>=20
>> If there is garbage in conv_flags_eol then we would not demote the =
DIE
>> flag here.
>>=20
>> How about something like that:
>> int conv_flags =3D conv_flags_eol & ~CONV_EOL_RNDTRP_DIE;
>=20
> The next version will probably look like this:
>=20
> int diff_populate_filespec(struct diff_filespec *s, unsigned int =
flags)
> {
> 	int size_only =3D flags & CHECK_SIZE_ONLY;
> 	int err =3D 0;
> 	int conv_flags =3D conv_flags_eol;
> 	/*
> 	 * demote FAIL to WARN to allow inspecting the situation
> 	 * instead of refusing.
> 	 */
> 	if (conv_flags & CONV_EOL_RNDTRP_DIE)
> 		conv_flags =3DCONV_EOL_RNDTRP_WARN;

This looks good. Sorry, I just realized that my suggestion=20
was garbage as it only disabled the bit. It did not demote=20
DIE to WARN.

One final nit:
Can we be sure that 'conv_flags_eol' is only ever used for =
CONV_EOL_RNDTRP_DIE
and CONV_EOL_RNDTRP_WARN? Maybe a solution like that would be more =
future
proof?

  if (conv_flags & CONV_EOL_RNDTRP_DIE) {
      conv_flags &=3D ~CONV_EOL_RNDTRP_DIE;
      conv_flags |=3D CONV_EOL_RNDTRP_WARN;
  }


>>=20
>> ---
>>=20
>> In general I like the patch as I think the variables are a bit easier =
to understand.=20
>> One thing I stumbled over while reading the patch:
>>=20
>> The global variable "conv_flags_eol". I think the Git coding =
guidelines
>> have no recommendation for naming global variables. I think a =
"global_conv_flags_eol"
>> or something would have helped me. I can also see how others might =
frown upon such=20
>> a naming scheme.
>=20
> I don't have a problem with "global_conv_flags_eol".
> Thank for the comments, let's wait for more comments before I send out =
V4.

Sounds good. A "global_" like prefix is not used anywhere else in Git...

- Lars=
