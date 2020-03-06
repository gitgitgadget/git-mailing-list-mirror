Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C1C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 11:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88E42073B
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 11:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d7pP5hAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFL7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:59:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:51295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgCFL7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 06:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583495979;
        bh=eldozjqnN/jMIa1I/z8H3NaiRmIro3S+BnaTEG3aTWo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d7pP5hAgogAxYlj81vh6lBjAMFxY2lnCWIz29zxplRPkuwaoEpV2DNfYiFod96tbD
         xcZV8MEZQPfvqmr/b4TXHgZLC8tMVe/4enRGjoTtv0hb3H+SAPpkKBHm7eG9gsHpYQ
         jschZUqC6ackJ2NQm3nJccNLfzjtsPywbWhKB3y8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.208]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEFvj-1j2jNe2JG9-00ABfT; Fri, 06 Mar 2020 12:59:39 +0100
Date:   Fri, 6 Mar 2020 12:59:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/2] gpg-interface: prefer check_signature() for GPG
 verification
In-Reply-To: <xmqqftem4p6y.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003061257470.46@tvgsbejvaqbjf.bet>
References: <20191127174821.5830-1-hji@dyntopia.com>        <20200304114804.19108-1-hji@dyntopia.com> <xmqqftem4p6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-700903759-1583495979=:46"
X-Provags-ID: V03:K1:Og5REA//3QJCxOCPJbZhjpbd0yek0cE8Vpw87j2SxLaPJKwe1Wf
 pUVw3FzeBpcdS1CwyD5J/k+zEVAagozTHyUYVaqHTLkg8qDCA+r2sWos2UUlpg28Do34MrX
 ZM3OcMn0Yi8s2m1cvLjn4oqmWxuP0ADVlVsyecRTzoSO0b9ZJjHzuJhhqqJSzZ/EoBoqUXN
 LNMU6q6bYSf2JS5BlsNKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rdsChLSpeC8=:D9x3eJ7Gw69OWfSQnYWojS
 0r7Ty271JjY65YPfT9DXkHdMiveRphOXMz+SFudhL4b0AZQzcRc4iRnU9tm6YWjoiLMXozsh6
 Sh4V8b3TRv9z7ewqkdcJ2WhFHvAx2DsWOl85a+oEoVgeAmzsT2rC7/ZFeMje1gnKN4Cu6mSTe
 P6Tp2oXafHhbdch4wdjLqlaTtM0rvixK1mKWzDWTqSnN7CfguXKx99QepjW3QvTDH4vvonox5
 omSwxhZmXDO5iC4xewiE9xQsOnEen0bZbZvLFsxZujNr9To3TIDogx065m79BHRhzbf9lgZjE
 5ODok6gj7FYW6to5bckqCLiiDtgBq3588xd+M6I090zn2l/WYjX1SiE37x3lOKhh/bhFcW5A4
 kbiu0yeKJ8WIBRyGD+Wfba+qt8ggRrKS5CVlq4Hz3fxd+//NitPx0LgsgjYpcRrc01//BIQYD
 yiyZfogtnCJg2g6FZQnuUquQHdG50RdS/JpShXB0zPUVapAXxTunhiwKzOqhP+xZajtfgDPBS
 dOGQb+bWtsDuWuZwZ0Kd6A8PQ84TVfDLeTlWOH3AYl2x2jHIzp0swo6hd6ka0VVKHaCHezabI
 ezxoDJN32DGB+lkFZJxNbXJwmTBjgx+2/wT6OG60zN4ZPjmPIX+DUA14X1SuC8RXLAnDYsMAh
 6T545RuTKRo8FTHhu2T4X3X+6Aw6F1PHJWIpJQ1SYaCxGhTdZl3F44hh9FSZZN1+zsUwSBejz
 l1AyyszeZGRVZ+u3sPr2Z8nI9ApUQJfL77EbRtul6Vu0AHWautjq3H6/cIHncjl6k/tTmSFmW
 PQmnMG/zZSKzlo/RylF5QNyNWDhCdyy8hSd2ae/1Kjuwqc6b+Bb8qwdTNifZE+otsDoc/HOkJ
 d0ZpOchFXUAQS28SGJy9EiLAiQFy0VzHwKkfXgW8T5+OkH4c2HCDbkYn/+rTPPK2I6e+zKHfK
 Li6xsmGIBjJpniNTfZ3tEwXL7pRQI85Mc4S0XJmB1C6zoR1obztErfjYD6uVvWsYSxSSt3c6f
 7yuLqSqXpydXBWatF0/gDTblVYyHgVuTScxUOnnFLa8oJkOhVGIwN8xyG37YnLTOOz9ZcOY3+
 Qq3hVGgaFQen4iQJgzwNUVkTOuqeJQBZWM282TcTw7HsaGLko1WREHRaLgH3o8Kldxgqae1XE
 +uGbTo9tHdVC7fCsgbRCTlJEsw43xapBD/L2fBWKZqVTuXKVMafoB9b4riXREko3gnJxDNv3c
 ZTebYsGsA2oimXlJD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-700903759-1583495979=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 5 Mar 2020, Junio C Hamano wrote:

> Hans Jerry Illikainen <hji@dyntopia.com> writes:
>
> > This patch refactors the use of verify_signed_buffer() for GPG
> > verification to use check_signature() instead.
> >
> > Previously, both check_signature() and verify_signed_buffer() were use=
d
> > to verify signatures in various parts of Git.  However,
> > verify_signed_buffer() does not parse the GPG status message.  Instead=
,
> > it relies entirely on the exit code from GPG coupled with the existenc=
e
> > of a GOODSIG string in the output buffer.  Unfortunately, the mere
> > prescience of GOODSIG does not necessarily imply a valid signature, as
> > shown by Micha=C5=82 G=C3=B3rny [1].
> >
> > verify_signed_buffer() should be reserved for internal use by
> > check_signature() since check_signature() parses and verifies the stat=
us
> > message.  This is accomplished in this patch.
> >
> > Changes since v0:
> > * Added regression tests for log-tree and fmt-merge-msg.
> > * Fixed a bug in log-tree.c that caused "No signature" to be shown
> >   erroneously.
> > * Fixed a similar bug in fmt-merge-msg.c.
> > * Always invoke signature_check_clear() after check_signature().  The
> >   check function may touch the signature_check structure on failure.
>
> Thanks.  Will queue.  Let's cook it slower and aim for the next
> cycle.

Good call about cooking this slower: it fails both on Windows and on macOS
(see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D32672&view=
=3Dms.vss-test-web.build-test-results-tab&runId=3D101636&resultId=3D101463=
&paneView=3Ddebug
for details):

	expecting success of 6200.2 'GPG':
		git tag -s -m signed-tag-msg signed-good-tag left

	++ git tag -s -m signed-tag-msg signed-good-tag left
	error: gpg failed to sign the data
	error: unable to sign the tag
	error: last command exited with $?=3D128


Not very helpful log, I must say.

Ciao,
Dscho

>
> > [1] https://dev.gentoo.org/~mgorny/articles/attack-on-git-signature-ve=
rification.html
> >
> > Hans Jerry Illikainen (2):
> >   t: increase test coverage of signature verification output
> >   gpg-interface: prefer check_signature() for GPG verification
> >
> >  builtin/fmt-merge-msg.c  |  11 ++--
> >  gpg-interface.c          |  97 +++++++++++++++++------------------
> >  gpg-interface.h          |   9 ----
> >  log-tree.c               |  34 ++++++-------
> >  t/t4202-log.sh           | 106 ++++++++++++++++++++++++++++++++++++++=
+
> >  t/t6200-fmt-merge-msg.sh |  23 +++++++++
> >  6 files changed, 202 insertions(+), 78 deletions(-)
>
>

--8323328-700903759-1583495979=:46--
