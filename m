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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2F81F462
	for <e@80x24.org>; Thu, 25 Jul 2019 18:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfGYSWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 14:22:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:48343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGYSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 14:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564078932;
        bh=TUwyHnNu+/T9ZRzeDwVa+0xb36fhYSV8a8O8+f4wIZY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bvZv8XmV9vReCH5pshRRK1r47m99ydjgGOhfjrXkwtKFq+Kq21V+soULvbWfoe5/4
         hzvHnNCTjSls065/rRRKdZG50FbW52cRszGN57myezD/pnuo5rfqeHq7GISulHr7l4
         dIsnaGFwhx/QeUN/IdqYcpmvMf0hRktSsqs9cRKk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jMS-1idzbr3pTQ-00wTIV; Thu, 25
 Jul 2019 20:22:12 +0200
Date:   Thu, 25 Jul 2019 20:22:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
In-Reply-To: <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet>
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
 <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com> <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet> <87lfwn70nb.fsf@evledraar.gmail.com> <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
 <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-904959252-1564078930=:21907"
X-Provags-ID: V03:K1:jlUD2/gaEknpqtof4UogRY42t4tO7enLuRTi16LoWClp4x//sun
 dZ3mbceQ/Enm+lfut7SyQ8EGmVUnJJ/FyKuzLtIoKvMP8T98mACQMd5bjUlGvaMqzj9kxvT
 ExEsoFeYNCbrXYhFlMmS0EUjpKWuSLBtSHLjsaLzTvgfogQmBX8fSF0WlLY5WOJQNyJSYMn
 EPOdgXaBF7s++d4QC9SFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wmcpEyrgCI0=:Mut2Q8pnCACBNks530NDvd
 QOQJd6D9KYsDWR3rdA0sFNpL+fu7c4cmK1xdAoXZTcIMEB8xfvvZyin25F/Vsj/VOPYbMvIIL
 uC3RWTigTAd06S7wtL7qIgmFIMHxKMYfSpX2ynxIFYVpZuuYPMRxSqr3wwEwkoOMFh9jRAgle
 xWh+IK4F6SNzUg3jeEZf8HOEidCg4MvuQpeBxdfhn/F5q90rpLgf1f+AF2wj1yLfIozYSxb52
 64+4p77/AzQg9n9xC+CLWPExRG6MpmtrHVHTyDEgLZTXZqpR5z9Sk2vv/NOQHD0RGcFccR+H1
 xTtVpXGeyIQw86LvMjqn9z8iHsGijAYv33hCidlRS3vU6uj3rg2kvufqWHE5FRb9pnEYRo95B
 2GBxKlg05khPm6U2omBByI603lpRIBrmAdfdPhlfYGvCL44RR1x05fJZWvLx+3h6nTABRzT4W
 8N09YlGdAsMOYGHfEEUCTLNuvs61RfO1lVB8IcS1oBsTfpm5yW/4faLj0+LaPWi5QjyLM0yu/
 nRTGa2CwmocBcsNblQW5JoGShG97cy3w0jmN2uGo+CKWPnCSZ6kHiaVS6dWtgrDgUuvgx4B9+
 sm+sIgZichNd/San0lQGklqT77m5d3xJDFahD998wt4cosbvbChwzmwX9ClvbhFzjyqPZIHim
 4V5++A4CBfX/M/KKeCxdoB7YRKg1MNKdFwcewZryjDgzzwgYrA7F0PKL11nYmnNXq/Ya7e5Yy
 6d7aH5G/XhLlmcLk5Yg+NZdwggGt88LKrkeijE/5iqO7RsI1UJymNOu/xyYam2K1urmNowm6X
 GiCDwss1LvfUeWjXqQYNsChVIJVbplKdEZYbCJSBrC9pf+Jd5MxwHWPkYFNsUbFDV6f3MhiuF
 niNWfUeGQc1qJljJIREI4Rp5i2ekWwXX9iO9MKVV7UDu+rIau6GZdBL6wDz3Ntqm7I6ATHByV
 DynrQi708PdCffyn3gr0eeQCKXLtWalHBdbC385NqLJjoKpS/UJFVUmoVSo7MAVvFZqjLCTSY
 0PLZJ+DZ06iMOABBjUdOt8x76lB3zRnpEA6cVC3ADS7HuxsodIO/V8fF0RCbU96o5Bip8mcHV
 Jf9Po97R3QS9zMDo9Y1+OMcqgtigh82u4QS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-904959252-1564078930=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 25 Jul 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> OK, in short, barfing and stopping is a problem, but that flag is
> >> not the right knob to tweak.  And the right knob ...
> >>
> >> >  1) We're oversupplying PCRE2_UTF now, and one such case is what's =
being
> >> >     reported here. I.e. there's no reason I can think of for why a
> >> >     fixed-string pattern should need PCRE2_UTF set when not combine=
d
> >> >     with --ignore-case. We can just not do that, but maybe I'm miss=
ing
> >> >     something there.
> >> >
> >> >  2) We can do "try utf8, and fallback". A more advanced version of =
this
> >> >     is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthrea=
d)
> >> >     does. I was thinking something closer to just carrying two comp=
iled
> >> >     patterns, and falling back on the ~PCRE2_UTF one if we get a
> >> >     PCRE2_ERROR_UTF8_* error.
> >>
> >> ... lies somewhere along that line.  I think that is very sensible.
> >
> > I am glad that everybody agrees with my original comment on ab/no-kwse=
t
> > where I suggested that we should use our knowledge of the encoding of
> > the haystack and convert it to UTF-8 if we detect that the pattern is
> > UTF-8 encoded,...
>
> Please do not count me among "everybody", then.  I did not think
> that =C3=86var meant to iconv the haystack when I wrote the message you
> are responding to, but if that was what he meant, I would not have
> said "very sensible".

Okay, but in that case I cannot agree with your assessment that it is
very sensible.

If we're already deciding to paper over things, I'd much rather prefer
the simpler patch, i.e. Carlo's.

Ciao,
Dscho

--8323328-904959252-1564078930=:21907--
