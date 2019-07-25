Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3108D1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGYJs1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:48:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:58471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564048098;
        bh=69MH+Zx5+P9GIduONgsdxYsMmWXVMu5D8G6eH84W1uw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i62JuyyVxZp2gOtAY2wxzF3VDqGpy4JmscaCU2Sp4kWqqCawIakLFSkHlPV8yxeRR
         LCqMN5+gwGvLdobfKVH2BRVClSLXfSVALZEP29R520VVk2Gl5hzh2fhWDIL9S5hrhN
         U/GQjm4fcV4wxhBsGTlB8oCUfP9Qk7k+37GXYE/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1i4npN3FLQ-00N8Og; Thu, 25
 Jul 2019 11:48:17 +0200
Date:   Thu, 25 Jul 2019 11:48:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
In-Reply-To: <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
 <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com> <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1282362113-1564048097=:21907"
X-Provags-ID: V03:K1:tmn2wNaaqpVkgDYw7qqXn+Vnifg9t4IoOOV27WjBQciWWgMwcR9
 n3y7TfksF/Y5m1PVVSQ9qtgI2dOEB2N9HmZqNpg+RzDEqG5a47yybwPQjZEkbq2vOLzOfp6
 qyjlZnJm6Xw0CWHZJfvBTG6i2+VDvXHEmA2Am71s46FJVHPKbdBO1FwgwpGfKwGr9Ap7JxG
 eSk6/P/BX/YdP52m83eRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10Y6lYOyzvg=:rJ5DtYwIP8zQsGnnjeXch4
 cWhmNbn0qfBZQpqzfgdfXCmUImKfoiaRxnCAlkofqFO9MCmxgpmhxil7iCH+YeftxI/m6/k04
 jcaC8NSl8SI8l4n3Ay/8seh+cJ7+jC57wQqchsevB+wu+ORqEHPQatv14vISKLkVQj4e7egFA
 2Kzbz0za18Oy4I6UMXtLID6M03iOgE0wRPcxYCcfP+UoteGdxSaIB3/upgcCNPiF5EtTkTtsQ
 XHF5mt6kdNfYoW8yKTKlCaZTuk+5q38lNfDKsnVNh3dFn+Q+H03zImc1AADJoVnwBJyb87ohz
 xYiqewULuCBl4UAVDcgdeMiA194ivOFgoQ7Ym+7H0/sNMHrb+53enaRMymSo3mtwTWHZeBxbU
 +6W00vmb0l1wTwLOSHzJSJQ22gxgwPefB7zBTC/x8S2IMuDV+xLyBsZH0UBEEpzPDc+7AF0bh
 jY03/vQmP6tsOIfFImbVvbNwEar+jllg/fsj4dSP4J0oskQUrUXRD7nK9eTFHFPtTovrQ1ahx
 0eCbyTLh8WBTsxjO/isRdMqdYpIBnejVUBVriPM+pIayQx9y/bec/O+p+6+cmbJUEr13F4QXv
 tlDU8+asBTi73LCbvBy8WxKrzcNGzhtFWiwZs0y02zp7LAToGKWdWIOUMOxAVqprWbiApSBFi
 uNbb6+6Dlu5hCWtF2F1CE2vvoC4wjWSLTtZQ0DR4uQXsucxFOkXqbhQqzaffZK5weyGfQhoV+
 52Z7ZIoGLFKLcBl4HwSkBI8AWqWf2AuaPyhn/sUOINInTsD4QrQAnb7MHeCjKXSFGpl2Q3Sly
 Z07MTWC2mnjzeq6wHf4+RZt2E9mMLgOr1frjI0T0lJT3wP77GVNtRXMbFXdYuwOP5FBkQ3CIM
 TV9Zwq8DdvLBT+cEPtXUmff2YTJFx4d0o/6988ZqjzZSo1KdT/RYT4Poy4m02tftj+wMiaN38
 2/jkOF5bobnuh4+SpybHBhI4pOjLntAshPu9h0wdNyfxS8fqe0IzDVYCehMpyfr4itfNv4uiy
 NMruWegz9AIUZFrb3wokJ38GLI9iSWR/3KG3Zz0g2AQYY92QwSInHmho0Rl+xGhe9fbHYvhME
 Tquk2EIyrUrXar3uEHGpxdL+ferBBTca3dB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1282362113-1564048097=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 24 Jul 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > The PCRE2_NO_UTF_CHECK flag means "I have checked that this is a valid
> > UTF-8 string so you, PCRE, don't need to re-check it".
>
> OK, in short, barfing and stopping is a problem, but that flag is
> not the right knob to tweak.  And the right knob ...
>
> >  1) We're oversupplying PCRE2_UTF now, and one such case is what's bei=
ng
> >     reported here. I.e. there's no reason I can think of for why a
> >     fixed-string pattern should need PCRE2_UTF set when not combined
> >     with --ignore-case. We can just not do that, but maybe I'm missing
> >     something there.
> >
> >  2) We can do "try utf8, and fallback". A more advanced version of thi=
s
> >     is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthread)
> >     does. I was thinking something closer to just carrying two compile=
d
> >     patterns, and falling back on the ~PCRE2_UTF one if we get a
> >     PCRE2_ERROR_UTF8_* error.
>
> ... lies somewhere along that line.  I think that is very sensible.

I am glad that everybody agrees with my original comment on ab/no-kwset
where I suggested that we should use our knowledge of the encoding of
the haystack and convert it to UTF-8 if we detect that the pattern is
UTF-8 encoded, and then pass the PCRE2_UTF flag only when applicable
(i.e. when we know that either needle or haystack is non-ASCII, and then
making sure that we convert to UTF-8 whenever necessary).

Okay, that came over a bit more sarcastic than I originally intended,
but if you try to filter that out, I think that is still the better
solution than to paper over the issue.

After all, PCRE2_MATCH_INVALID_UTF is only marginally better than what
Carlo suggested. _Marginally_. Not really worth considering, in my mind,
even.

> Let's make sure this gets sorted out soonish.

I agree,
Dscho

--8323328-1282362113-1564048097=:21907--
