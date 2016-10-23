Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA96E20229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756175AbcJWJ3Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:29:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:60931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754826AbcJWJ3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:29:23 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MQNFY-1cLSMe2H9A-00Tl8n; Sun, 23 Oct 2016 11:29:13
 +0200
Date:   Sun, 23 Oct 2016 11:29:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 20/25] sequencer: refactor write_message()
In-Reply-To: <xmqqr379d82b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610231125590.3264@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de> <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de> <xmqqh986g49i.fsf@gitster.mtv.corp.google.com>
 <xmqqd1iug42f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610211343310.3264@virtualbox> <xmqqr379d82b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ynJvWVTI/dSMLRSgDaKDtTsQmm7LBngk6Ceoi0aGZ/cMJ8luGPY
 oz+oL5U+WAqzsC7jnra7r2UMLMd6y6cGcZ9kxggq+lFvF7Tc9np2TzRkX03vQoPWUzmFhWh
 CqQa1H/4hZGjg1zHFmgfAJQtgTy6JULmXAYFJMlf6aTeaWH04FM6GaGSc4ihWD270lcnW3X
 a13uD0DSM5zpQNoAzyuYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PtxyxROt7a0=:hWIv/mz9ZcIlMObNQJPNhV
 HJFUTkF/cpJoqZp8Y3xTfq6YccFiKcRi8pSPI+5y0b4Vt3y1pY6+TSzABzKRoiG13UI5gCUFt
 TWP1H/6Y5fMUPo68NHMbVp0I83pzcQSWbmoKNcS2zWF8hqHfEqfFHfnBPgRPGmxxz5vTQYxV8
 RGLL0hiaW+BBMdlTwKGraQDXXnZ9uquIWo5lOoSzVbMeas4gpnUbjNme1nZjINdksspn0dQnl
 ejBU/Yl2cwuumjPF4p/FIfuV1R18f11P2aF03X+NULB9O40HQhidoBm7UQQEidWrfHpGtJF+V
 6ZId2lhGPgkmCTdZXaimtuGvbVtt6uER8FDO0nM2OG18RJsngwAqJY+bR6W+00hwbuJTsQ2L0
 piKAV11FLgek4CybhWJ8aIGk/Pxhj+yuhdft9oBC6kMAOLJRSeNeq3f9DOdQ7WGY5y+hoJrl2
 pP/hZSWv8dSBP2VArOYN7s1d3IV7gEmer9FLlHta7J6XV6x12pWac5o2r8s/N8KoA+rzVJUCd
 kBNM5rxoMTSu10Hn4XoxafsRxyLKDGAgMOsjDbExSqfI4lL0CNIuRcu85pLNh6sJM2xK2aeQb
 q2oGr4hpo4PNi8xjRdIC/wvtS+GTEw0V86QxZ5MqH8MpSxf4JIw07QDMGtS+ynXH3dp4HsflH
 vIRxYKZ4djYFQCSr66lAbndkBNJaqtv1m5a+v/w0bbo7rqkfwEsb0NSeKVzJsRDKhp242f3Og
 q3g/M1RMpv86TRLigkr4isU+RTqyzpXmqzaPm4wYEf9lEqt/XcPd29MKCCU8qDphXqgNv+kOu
 NtjoYUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Ah, make that four steps.  The final one is:
> >> 
> >>     - add append_eol parameter that nobody uses at this step in the
> >>       series.
> >>
> >> This is a new feature to the helper.  While it is OK to have it as a
> >> preparatory step in this series, it is easier to understand if it
> >> kept as a separate step.  It is even more preferrable if it is made
> >> as a preparatory step in a series that adds a caller that passes
> >> true to append_eol to this helper...
> >
> > Done,
> > Dscho
> 
> Hmm, what has been done exactly?  I still see append_eol in v5 where
> nobody uses it yet.  Confused...

Your bullet point suggests that this change should be a separate patch. I
did that.

And since this patch series' purpose is to prepare the sequencer for the
upcoming series that teaches it to understand git-rebase-todo scripts,
this patch falls fair and square into the preparatory phase.

Ciao,
Dscho
