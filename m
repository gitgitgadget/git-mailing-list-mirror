Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D87120323
	for <e@80x24.org>; Tue, 21 Mar 2017 11:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757230AbdCULqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 07:46:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:65229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757219AbdCULqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 07:46:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwJko-1c7ypJ3fpO-0187Rp; Tue, 21
 Mar 2017 12:46:35 +0100
Date:   Tue, 21 Mar 2017 12:46:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv2] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
In-Reply-To: <20170318182408.4444-1-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.20.1703211244470.3767@virtualbox>
References: <CAM0VKjknLpCyQfY+ie3sfGemwhyad3Tk-5fHdeTSz2-WTw7NoQ@mail.gmail.com> <20170318182408.4444-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-53343566-1490096795=:3767"
X-Provags-ID: V03:K0:TIMhnnUag00xdG91zY+d9IxBA6iLG7DDvn7L/uZ0ZhIaCnqG5+T
 aci/sf4l0tZl22Xc3ZcKhyO7K0JMFe4FxcGwJM4hiko1eOe6HObdTUhKKbb5mfP5PygBcGj
 sOAlmE50DfUWKAX1+0Szqb8gd0Yvmw/XQ94A2s+ifuEgqbX3X9ncTBsK0owsr4sWDvM8Tr/
 QTiKMfFEmFhHhXEoj7BEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:stUeH4cB0Ac=:LCeyV1o7o8GQQozx51MEhQ
 zQ3glHt20nupAiIHByif9wZk8giCUu3ZaTP2o/xADt+6/OyxJGVXRsXl3GYwzAQVKD3dGaI7d
 RPJc7x2UG5bLiXz2eWZ4VBy5fkFJ7+QcC4XEF77r5aBRQsZqFT/jkBEZA0XST0FZ+GaDgjrQf
 IcslaMoSpv17wB03EA61n6YQHFb3sk/+AO1y1oj3fA1RShiDdLSI7F85BX668WUxEaSyuE/Rt
 hxWOQ8UQvTdg2o3MiOCQVYG7cS2dAeX7tCTynpLiYVP1AEUD/b4XkXnyK96kVotMJVakM9gnW
 l97vd64vDjHt3T/Dq3yAWHR5OBnDGHTTbQ7aPAC2VmZmzgA9jSzivPPpXdoccttgHzCSwDiYS
 oRiYhJJPgCatLqr+0jx0mJSAZJrVt1tGnMz1eNgRbyEA6NV6U4Qru1Eu/E6+/y/xa8+IuAydm
 8uBWcJGaydAISwfD7Snwnzk1E6QLJAHZnQV4luHAUW5LT4oOrb/+TQtHG8FyZZ+rWhOB2MmLf
 uheYuJUPn252WRF7y4dnu6tUrw46k0ZbcpeCTwEnYd3Uq2tsIY1Cp14EmcQq7j6Sp9BKsaBKV
 M1vOFjBXd7HkszGiqHwYTrcb0fcIgSb05QJjPfVK7aGByy09UKGsn5dxoGFaZrEwNIjdVq7WO
 2poSQiQW0ClBGPf7NVkVHJZeyu6lOqminADVnnCbAwJOiGZG4mm28eIZ95zTn/IZvC5GMV7Te
 FKrEcEP1Mddf64rqp0uzZBzNWoGl4ur5gm2uOxBGunUtT4VbW/lMadWLEW1P1rfvPF7Rhms0B
 Vhq2g16DNxLmznSo2XJ2/9Jv8vhrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-53343566-1490096795=:3767
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 18 Mar 2017, SZEDER G=C3=A1bor wrote:

> 'git {log,diff,...} -S<...> --pickaxe-regex' can segfault as a result of
> out-of-bounds memory reads.
>=20
> diffcore-pickaxe.c:contains() looks for all matches of the given regex
> in a buffer in a loop, advancing the buffer pointer to the end of the
> last match in each iteration.  When we switched to REG_STARTEND in
> b7d36ffca (regex: use regexec_buf(), 2016-09-21), we started passing
> the size of that buffer to the regexp engine, too.  Unfortunately,
> this buffer size is never updated on subsequent iterations, and as the
> buffer pointer advances on each iteration, this "bufptr+bufsize"
> points past the end of the buffer.  This results in segmentation
> fault, if that memory can't be accessed.  In case of 'git log' it can
> also result in erroneously listed commits, if the memory past the end
> of buffer is accessible and happens to contain data matching the
> regex.
>=20
> Reduce the buffer size on each iteration as the buffer pointer is
> advanced, thus maintaining the correct end of buffer location.
> Furthermore, make sure that the buffer pointer is not dereferenced in
> the control flow statements when we already reached the end of the
> buffer.
>=20
> The new test is flaky, I've never seen it fail on my Linux box even
> without the fix, but this is expected according to db5dfa3 (regex:
> -G<pattern> feeds a non NUL-terminated string to regexec() and fails,
> 2016-09-21).  However, it did fail on Travis CI with the first (and
> incomplete) version of the fix, and based on that commit message I
> would expect the new test without the fix to fail most of the time on
> Windows.

Thank you for catching and fixing this. On Windows, I indeed get a
segmentation fault for the new test case without the patched code, and the
patch indeed fixes this.

ACK,
Dscho
--8323329-53343566-1490096795=:3767--
