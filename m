Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546AF207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdEEWdf (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:33:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:57987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbdEEWde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:33:34 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1dd4Kt3seU-00dEhO; Sat, 06
 May 2017 00:33:30 +0200
Date:   Sat, 6 May 2017 00:33:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
In-Reply-To: <CACBZZX6oTEToPPFF0LpAXBCru9_B+VcaBL=KQUjkUhNdyanF1g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705060032340.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <CACBZZX6oTEToPPFF0LpAXBCru9_B+VcaBL=KQUjkUhNdyanF1g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-515224233-1494023609=:146734"
X-Provags-ID: V03:K0:YAyw7dNIQWn8E+Qvm16ApR1OuTE0xesQzyOdAug0Hy9L5Aixhez
 r8uHCDpA7Yi7M7cOk2B3IhL1yoSxCaP58NTXbcEi6EWK05Bg+Na3/mGH7HGL3JuwmhmpoXa
 PD7GEdDlaiIRawz8UHifAzNmxyYNNGGQzs09WaUiH9SVaLfvpcXpefFBF7uzHqdM/B+INwQ
 jgMwoq9OEh9cIQb1vhs0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rl94JMbqXbs=:GC86g8wAybtoiQrVHZbt1B
 tpQF1nru4oKvKyRxA3mKRi3ZvjFFGEKfFk63B0Jibhlo3pJHRex+xsB6NiwGwC4dTT07Ze6F3
 0uAFUWP3GL/nFSEiQqbh0uLrO/akb13/psfpxpPaAgz0ME76WFcYgAbgQKFdqVz0GrP3aCU8k
 KSF60P6UDedmQd4YOlKMSVRwxvruftzse0FczcLDw2mePC1MPQC3lUs8awJ9yiNNJ57J03XWV
 9ce5fg+T8AF2KPEJ0OoZJr76tV62JpPs9+O6ESc4hvxpQAFjarCCsVXz4KToc3RJhVHX2mDeL
 l5qM2sqp5Qo4d/RPh+HTn84ZBGLc9bu/euMcu18ELhseeG0glqyfHsetZuqSdQSbMdQdteb+3
 DO1LwDpw8Nkg+RHgoUkEMtRzTIGrFpC9FO/+DxbsNASyfCzVP97oMgfG+SS9/04NlkbwaTYtS
 SReyfgklZUFkBgTjgIUEsTSq250dw0mioy4ZPrwJUNRhtgDaNokB1W2Ko5dB40UrHnXUNdD3k
 93Q+R2pUyKKOyo5/b/u9ap+skuueGgY+9RS8B3/PrYbOoX8eETEM0HiNMDgd+AcKFYQ0GMGwH
 gZylT59uV5Npej0TnPhUnzm6e7uPODxcJIIRi6IzKmZFxRgeeXwu2N3bJWV4snDOsLfhA1Ie+
 1+DJ+k+B0ZWQiEBS0NOHA+ignn/ek3kBGO5Mli+MprlhQT15mN3rkxHVSy999kyZMAiEBVYs8
 g8ofzeQaWdoSJmx0tix59PiAleDAGsUPwkSIPec74Vly27umU6rKS2Qhq2khXtm4jUd+zxD81
 8Uxan6B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-515224233-1494023609=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 5 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, May 5, 2017 at 8:43 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> > This series introduces git-add-interactive--helper (or should it be
> > called git-add--interactive--helper?) as a builtin capable of doing
> > what the Perl script's status_cmd() would do.
>=20
> The existing script is git-add--interactive.perl, so
> git-add--interactive--helper.c would be consistent with that, since
> there's no git-add-interactive command.

Actually, to be consistent with the existing git-rebase--helper example
(which is also only helping the interactive version), it should be
git-add--helper.

Ciao,
Johannes
--8323329-515224233-1494023609=:146734--
