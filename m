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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D671F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 07:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJHHni (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 03:43:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:54915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfJHHnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570520609;
        bh=qsjc5uvSgUTN4PcYKxT1FQEU5XhYR0YGr5hTF6CPraA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N4Xy6FZp+j/l762pRhe1QcOZR76NWf4bnWY4Ms1j86HYIhs29UWsYqVKzBV/rF/Ri
         HhdMTjeDN9ycvys+dyHlcnFxHDQeK4YKWtJhmq+uQhVT2VLVRqktDHTfEXtQrEzpsu
         8HScyOhd1Q7WccISl7XTPqAR4Rw63PAcvIidfrz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1iEQlp2JFk-003LyJ; Tue, 08
 Oct 2019 09:43:29 +0200
Date:   Tue, 8 Oct 2019 09:43:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
In-Reply-To: <xmqqh84knd7l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910080943100.46@tvgsbejvaqbjf.bet>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de> <20191007134831.GA74671@cat> <xmqqh84knd7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U1p3GSaFpUhSXir54bw4CeHJMx3D3/1tP+K2rRYlmhx7VxciLQv
 ZCglIdHO4Df5czTLvipbmfcqp+uyZFqMFDzS9lcl0ArPlUD1iFHbjAcmhNaASnNhHR2RecU
 VJN8ZyxBtKVXyCyFX6iPYvg49EsHNXUi6ABBY+9R1jbwq6vjciish7+/p6hs6bczSTHf4YB
 r7BSW1zXnahU747ms3P8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2KJcg2cCUJY=:yB/CWfcJcmw/qPTVOGdpQd
 1IGR9Rr8ELuiK/7NM8j6/u20f28AfZDfB2QiRsGU5NIWCEy3Ff/bMAaAMR1Z0hHj0kYWVCFuV
 Yv4czq9BisT4LEJZaRC3hpZZtbr4W5qZePJK0TrpzZ52qgVKnXu2jKywgV74aHz0gFZLxMquo
 Q9kHgCDJZcPzSUzioWcNfOrbUCdj2t1A/8pPC80ALB6+Voqe7sC17gPZHzHNqU5AKFbwetVBk
 dk06onwKi3mvOTkSStfBH1lnnFpFHHbgAObTnM3wB6q9bh/E0yK4RI3iYTolrdWR9FN1OdjF4
 euJJW2eyANKEzEyMPyd/fb61mgnck/wFOx35NK+825Kpf1Q8y9B0kXR4VzzV/Z2FyY2xoWtgP
 rhA2g1ExuFHacdvFVx2yHU3p70TiU3mUfUqkG6YQjFJGEJ2dXgHCv2fmDlOvwYLeqe6evRL6G
 NsUh/R0ogRMw4VWz6VDr5r5qiKtHoBLh1qHNZ5DKg57E+qU1mmBSqnDsvz5DOok+abRF1oMs6
 QQOONhOrNPovWEFflin/cyP8+kUby03yhzKjv73b+df2OLJq4iQWsGH6pOKKbD593x0EjuugG
 BF01xtNrUdQMMXLRctMgWadsnr+ZYcfu4HRQUQ5Pa/aDJwcGHrTcaRo1n8ejf8L7F2z4yvubr
 mfcQ4DdwxF2aIokU9lpmKUjTJQ6Vv5QPPM5Pi0Zqy45MznSbYL0C/ugzjUXsm5SurPUKFNcFC
 1LOlRvY2WV7I3cn8kziOIayJwdIzvOTgAzcqUvZPjfMa3YijzC/qe8U0ihsn0FCodc80KtHuS
 oAxIY7OMOHiQQTPGFQpAgJ5gB7OfTzBORfEX3kCCccYiDAl6MKkN/Ab0Nxl+4+ydoKnplFAkO
 bt1/7WYLPS6KzZdhu/pCs6PxKXUdiSaxBzgZZmB6PhWzPIxOEjhdT5ZPZzI0nJOW9vdmzwhFE
 AR1f91+lm4Yz/jQP0DhhOSmo9lTmcJoD4PjOE4qRvKtyhNe/Q0RyQtE4rrQOu3tLd3Kv649AP
 zWWrVeDYwebZdS/q5zvQXIcspFEa/eG1yjzwhzthXUQq1BU36CLnursrAEebql2LodCBuY5gD
 1IGemut1+dyg6JEaaEKjn8hirBYg8Dwg/OYaRR5NIdlPSbmfjZCuSGURz5Ldcbc18+a+hXoAn
 zodRTWOPh6fHDok3wJIxc1FQjlmEVWubtgFcnt0A3SB90fGznfdLRU0w6auVCmuMvF+4tjW+v
 g09I5V312ngMyaueverXHG2T47JdOQW1ok4Us1o6V5QsjTHwWM45raWSDKRw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Oct 2019, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > We can however rely on 'patch.def_name' in that case, which is
> > extracted from the 'diff --git' line and should be equal to
> > 'patch.new_name'.  Use that instead to avoid the segfault.
>
> This patch makes the way this function calls parse_git_diff_header()
> more in line with the way how it is used by its original caller in
> apply.c::find_header(), but not quite.
>
> I have to wonder if we want to move a bit of code around so that
> callers of parse_git_diff_header() do not have to worry about
> def_name and can rely on new_name and old_name fields correctly
> filled.
>
> There was only one caller of the parse_git_diff_header() function
> before range-diff.  The division of labour between find_header() and
> parse_git_diff_header() did not make any difference to the consumers
> of the new/old_name fields.  They only cared that they do not have
> to worry about def_name.  But by calling parse_git_diff_header()
> that forces the caller to worry about def_name (which is done by
> find_header() to free its callers from doing so), range-diff took
> responsibility of caring, which was suboptimal.  The interface could
> have been a bit more cleaned up before we started to reuse it in the
> new caller, and as this bug shows, it may be time to do so now, no?
>
> Perhaps before returing, parse_git_diff_header() should fill the two
> names with xstrdup() of def_name if (!old_name && !new_name &&
> !!def_name); all other cases the existing caller and this new caller
> would work unchanged correctly, no?

FWIW I totally agree.

Ciao,
Dscho
