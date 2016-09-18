Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631012070F
	for <e@80x24.org>; Sun, 18 Sep 2016 19:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759519AbcIRTXA (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 15:23:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:55358 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755737AbcIRTW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 15:22:57 -0400
Received: from virtualbox ([99.48.236.64]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MM0bQ-1be16l0nxE-007kKO; Sun, 18 Sep 2016 21:22:51
 +0200
Date:   Sun, 18 Sep 2016 21:22:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
In-Reply-To: <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609182118380.129229@virtualbox>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>        <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com> <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:93tit3XzaLAZkn/z3X9eUTq32BFgfyYSEgB5L8siHNNny/JFjTK
 JusuFv7iqiL6kWWWlXbLDIUdl0vMy4Yjpkpp6totqWRZ+9et5DRtCayA/rwV3xeIcszulk/
 WDThjcjQ1NZvDeiRxDCOqy/nOg/aN4zZl459R/vziliJLXjWXPw9nIQUgTJotOuGv5XOODr
 4ulR1z2jVP3MLepEl7d6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lrIXJAF7gXY=:mFSj397xXUi63mqLKI4MmI
 uA/LhKuqdGg0Aphb6V7VFfAnUZcLQ4Dljsu+VrkKlR5nat8k3iDqjqRSOcIjkIlfDc/n+iJCj
 Qw37+wFpilJPYv/ofttwRVwg8XxOAlmRGTpenhbtDkjN3OWpIAUGfm+H2vUq1LDIF+nTbvZTU
 tZTa4MY4q6Q8f5Jr7yYK12xCLKMdyyirlRRnf58Fvg0LeA4JNd8XKySKY+X6BV2uVuZ9z95iH
 p33x+Yc99cGXR7F5dCv+ac/Gsydl2koog2M+9HLivKG4oEUQJwUx16jRbbZmt1F8DegkH48Az
 9ZF41Uqwvrzp+e41j/TvQgsI1gx5U0VTETQzo0Fp6+KNgJ4V9cYLSu0DBuHRIArc6lqpYuFPq
 zuC9KY4ln0NYjypdyz4kwsVhs040ubupuAzJrI8Y723MX4k3P0yqhb9UFAfTovYgRhfwdb+NC
 lwhv3H50928uZzt+yxWS8CmBoraUhJMYkdVkGiv227bTg8u2GpTUkSx5DpzmFtcike7KDQvL8
 hoFp/4ObQKKIXswwEt10PSLM0g9QZtCktD2TvUbdBAqMlbLr21WvuAG3roIydl19dv692AoAJ
 k7OXaz+sSUghFXDzpXQ/LpjSNx8ACHwgi8nMrz1pSUUXScNa5x0lcBf0DYYO7d75TLhpz1xR1
 mfWDYtx/znCc3Ho4dDuy0St3NcDjx9JOtalMIrXH4ojDz/2wfGK2/zz5/HD23fJDQS7UrKmnw
 /dNe3xZ2lKLEgl62Tzp0bAv4l3J/dc0zwX3o16BucUCDQCMoizhmUGkojKmbKoh8x7/t56Io5
 H6vQXvG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 16 Sep 2016, Junio C Hamano wrote:

> Kevin Wern <kevin.m.wern@gmail.com> writes:
> 
> > Add option RUN_COMMAND_NO_STDOUT, which sets no_stdout on a child
> > process.
> >
> > This will be used by git clone when calling index-pack on a downloaded
> > packfile.
> 
> If it is just one caller, would't it make more sense for that caller
> set no_stdout explicitly itself?

Taking a step back, maybe it is not such a good idea to swallow the output
in all cases, including the error cases?

Maybe the best course of action is to hide stdout/stderr by default but
show it in case of a non-zero exit code, i.e. using
https://public-inbox.org/git/6383b7afcdeb6c999862aa32ba437997f2dd3d4e.1472633606.git.johannes.schindelin@gmx.de/ ?

Ciao,
Dscho
