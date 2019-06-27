Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BDD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0JQB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:16:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:41247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfF0JQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561626941;
        bh=BElO9u7cq6n3WbuFiZ7zjOeIxe7Oj8O7Cy8DtwPgB2I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ahvIpG7jnKgh3FGTCz0MjcjI/MlbFPbEVwZ8OG6OqntZzlW5ALiRsBhanjqelIyWc
         bkLxM9B3ibBTr+veDiHOBvg678RTCD89jsW29TBqpGw2ZPtJTemo8mszo+A4+oQR+y
         sx5CFZn/VrEUzg7GXic7/ZZRiWY2Lzfjj0eMTbVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y8F-1iZ4p01WxD-00v5YU; Thu, 27
 Jun 2019 11:15:41 +0200
Date:   Thu, 27 Jun 2019 11:16:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 0/7] grep: move from kwset to optional PCRE v2
In-Reply-To: <nycvar.QRO.7.76.6.1906261601270.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906271113090.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261601270.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1527059421-1561626963=:44"
X-Provags-ID: V03:K1:X5y9P1My8SIZqi0VyNxGKrFZsOpyQWJQW3R6dDqwDkvH8xNM3F7
 JeH7FGYDUgkpc8OJePDwTNwwprKhrA9gz2oDV0Cm/R8qedAnJhzBwF4XrvPYzWRflrcACTk
 k0U3wRw9tkoSlTpG2hgRg1FTZCEoJdq7eTcZTWcy4uZHC6kFM/RRAzA2pHD9Zsvfy3w95v0
 +J3sT3wPiPGhGTytMDfiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/VroQojQ98=:/jrn+nRa4Ik5F5RXjSN/q8
 ZIVvR6nLPGjqk06VXVkMAbk3k6YPIlGeXaBG/OPPMx6CQTNVYUypJL+1Oz9hbfKBwL7peSFCU
 mdS4+SdfoDsNbppBd/q7dMm3qTfmKRJ+ak3RffiyUAmKvRkK1RvTTOXJK21MFn2UGwApO6vqH
 vWizkARK9B6LpPUVFfXJmSrMRaaehRd3ThORFAywKuHAyFd+xtXUv6J00ODURy/EBlgS+RvLC
 T8HkAOg7iG5UhYyflxhDcdiGBxCEkGV4VyX/rbiCWcujni71TX6qF+gzT60WoLeNXuJRGW/MG
 ZQIhwFIQrKdy8tgzbK2sJu3cpFcDPVDj6nnEP/Inz9Oyv6+FHfjZqL6r0k+WrIXVoGZRGn3U4
 b5VwV/7adPqjQQtgL9yX61/JsXW8TOUvW40JG5GLjCfKA2JgGvz38KECxy1l9KL5XJoYhe+EJ
 0mdZhcWSrJpl0i0hv4VicqYJizx8LGMDgDHriLjJFaH1G9C1s3W0LvMst9dqaJBSfXxp0P5yU
 EW3ep1vSh4ykIkstoTo8mjVT+OigVeUpktwZuDYW291llLVxF74uzUObf+G+5V89QB+CpCKoX
 kdE1FtNr833uqanVdGgV0F7yOmAgBlW9M4G6b4A62xmfaGMPlsD+5h07d/tv8ugSNIArEHTIo
 4eeNW+LJSRqzkMPbFqR09ls4ePSjhlWa4XsXtR4VeC/WEXowBOhpChZFXzY9rg3kiBQ6NBjja
 pX2Y5nmQKftoo/E3WDeRmy8gBWsYA3aYQw1ff3m40MAiFkaxMfPATlfnSNWbqdNfsUmYB6Mk7
 9sTYYmGW4m072ILptqmm7J+5lFC69GR8e0k1lyGt/GcyGpkxOB0uaD3q+mXEm8rGixTau/Vza
 MfeotGMVREnCYeiNbvr1wHNZi2/Nc611zZBxbB8xZhXSvjVF8NPwWDJCyuT3MZiVCR3RcWvej
 A8Nv/cNLArkiIne4D1dWLAgdwEunXLIdvtZadx6824AMiCNJ1FUQj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1527059421-1561626963=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 26 Jun 2019, Johannes Schindelin wrote:

> On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > This speeds things up a lot, but as shown in the patches & tests
> > changed modifies the behavior where we have \0 in *patterns* (only
> > possible with 'grep -f <file>').
>
> I agree that it is not worth a lot to care about NULs in search patterns=
.
>
> So I am in favor of the goal of this patch series.

There seems to be a Windows-specific test failure:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&view=
=3Dms.vss-test-web.build-test-results-tab&runId=3D28232&resultId=3D101315&=
paneView=3Ddebug

The output is this:

=2D- snip --
not ok 5 - log --grep does not find non-reencoded values (latin1)

expecting success:
	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >actual
&&
	test_must_be_empty actual

++ git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D=C3=A9
fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top bits
not 0x80
=2D- snap --

Any quick ideas? (I _could_ imagine that it is yet another case of passing
non-UTF-8-encoded stuff via command-line vs via file, which does not work
on Windows.)

Ciao,
Dscho

--8323328-1527059421-1561626963=:44--
