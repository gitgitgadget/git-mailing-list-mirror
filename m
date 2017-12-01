Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354F020954
	for <e@80x24.org>; Fri,  1 Dec 2017 13:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbdLANt4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 08:49:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:60475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752691AbdLANtz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 08:49:55 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70Td-1fGppK1boj-00wpyb; Fri, 01
 Dec 2017 14:49:51 +0100
Date:   Fri, 1 Dec 2017 14:49:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jt/diff-anchored-patience, was Re: What's cooking in git.git (Nov
 2017, #08; Tue, 28)
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712011447550.98586@virtualbox>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Br6uL0mqvcZyMumlUeZj8OsgT4MC9ZslBKMiebuKZvWVvI0rt17
 4vjGAdNCRtPszbU/VT5FPu2ISt0DFWkpTMOTqsLDwVLoUgCnBxfFg7GuFDETgKxisGaM0n8
 McaHb4NXHQGESFeO6Sw7wbzTaoHLOXE25HQCS9Y601M0b8k7vBM2gRSXcbYDda8yUu4IjeQ
 kqrj7i+3kaRq9u+OQ3j4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/KqV1XEJFm4=:PC+kHMdgfvb54TZs/av1A4
 v6MovBDgDiE0RWZJoACBqSbS6hPWoHaqzW/FbKb7tLz/7vyS8kOPwuOiNRAF6nzTUgZXvj98x
 4ooq3kPojmu/lgmO6w+z+3EZ9314dtYAcfAIwXLd5b+PkwLqkvVqDqp9ZWBl9rsf6STTjpnEe
 HtytXQDD0Ytr1PqRLBtpg7MvSak+fxkYa4as075XcyVtr167fPxBCIw28yo6K1Gl29rCs6lVV
 7ihV054SSak6I9Tz1sKSRLhHC0+s2TvDrotIW1ruA8gMgZuWlus0Tp2LfKxP7AkY5iBUr7Ytd
 8tDsDM/pNfPY6VARcVujh4Ve1K3ESUB/03ieUxyC4MuhR92YoIy0LRfOj1oHBqT1qLqjbSc4U
 6GHonErVvUbDpCAw9g2geX7XGsCRRRfoR0UOyh4QTIh/BBlyO2snmKXuJZq0+/rZXIKADY3hQ
 iN+5yf07/jpRjOE2uT/M4xv8TtFpsAuzcuIwN9lBcI7zGUi67juDK1YdHZljkdNQPpRz6PFba
 iPas5baHPZAFvMSgO9Yuu6dpzfENS7XHadDnvCndg68FCLtMKPIK8QbEw5/DAAkUptJ92ZUo8
 Z62qMe56FGW93vnPUcuE2F/yG4lLyPSX1nriRnuW9Pj6chfBQE5Vl3Xae0VMvrnZGb34izNpk
 WGmRtgAvCI+1FonHk2OiVZO02fMKu4qrER8VaW1NiVocMwOIwXhGaeet7eSGS2IKmcI9pefkK
 pwQXTMLV0qXbPzQA+UE4yhux+PAWVoMNjWE5OJJwm/yPlyFOOvCW9BbZ5EU31KM2RHSwfDPdd
 tl7yeXwrhT24ridvBgayGEGv2kZg0nMWKBbA7mNEzDkqlvZqw8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Nov 2017, Junio C Hamano wrote:

> * jt/diff-anchored-patience (2017-11-28) 1 commit
>  - diff: support anchoring line(s)
> 
>  "git diff" learned a variant of the "--patience" algorithm, to
>  which the user can specify which 'unique' line to be used as
>  anchoring points.

FWIW I am very much in favor of this feature. I often wished for something
easy to make sure that certain lines (which I know are unchanged) are not
marked as "-" and then "+". And Jonathan's design (--anchor=<prefix>)
seems sound. If need be, I can always extend it to
(--anchor-regex=<pattern>).

Ciao,
Dscho
