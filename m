Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34751F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFAIq7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:46:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:57221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeFAIq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:46:56 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld1CS-1g6q9G1niy-00iCP3; Fri, 01
 Jun 2018 10:46:54 +0200
Date:   Fri, 1 Jun 2018 10:46:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] submodule--helper: plug mem leak in
 print_default_remote
In-Reply-To: <CAGZ79kZcjojZDoyhZovQmBLxUcMgECih4iUAYYFw4o_EeB3m2g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806011046120.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com> <20180530170302.191176-3-sbeller@google.com> <nycvar.QRO.7.76.6.1805311407140.82@tvgsbejvaqbjf.bet> <CAGZ79kZcjojZDoyhZovQmBLxUcMgECih4iUAYYFw4o_EeB3m2g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fk6etkhKrcIcoeKkgTt3+Wr7r7MakVfn1IIqpQ3EclpxZ71cgR+
 o7Kz3yLqK1lMCgQTpjN5Vf0PVRpq2IjX0Crw6KIrAuUG5YWNqhI1EKHxvM7ZdiiYrbCcPso
 W5CT4OzmwvaI/V+0h+vY8dhG3HSmo/HgJ98IOoIN8CYi9no8aF/r5WQIJVdCZajjRobnOBO
 WYp83jWWmUNrJjAZMWqpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vKArUPB7aTk=:w/RKzfxND5TohBj9UPtvYj
 Wm1hH7RfOsZrACJqp3UvvsiuUdS9wpjHZpqgsBDIvEAjPuYrUj0dunAA0FGNpKU4dpsCuouS/
 jSrQVKqikcXG6V8NumpAE76WtwQNko521oBYNxwJUavBCBJdklFecf8/sc97fDif5jA+ysyYP
 +iysx9TD0JdajPZaAH919pCpyUjN38YNtVZTVB2m0g1FpdteNeg9bu4kbFclbumjpTB3hTlKs
 sxuuMpqSF2XyML2vlL3/KZfXPgM58rz8SA+7xLX8qPtMIOX29mk1fdIMk7ro3dPpJcP2xnoSr
 AtaTDcN6qAYzb04qK5pOGtJiIDOIGsjBpsl23sNUf8qrDg6NBn1uE5PlvyyjvnLcS+PebZwQn
 ieOynnuNKtY6TnXAKH4BNovVkTYeWOvs3E8MnSXzSJ16XN9rU75hhHhYBUvw7T5mrT8iV6y48
 j9iYZ+6o9lAQGt1petR+9pJQm59MZFeMPv42HC0oNyO591nJDfC/pzK+0hNSSzwZOPi8lWPJR
 AYibJKWe4aGwG3C+G3qOKuyUf1pbgz8NsKo+AHgL/Kjuivjzpo0ww1F38+fwdKAA3rgZmAW9Q
 6vqMqvLSaLNf6rS2FIHs1bycSzG7RMja0kgVXPmnXewtad4znTQkqhj1h5A5y3pLh9nhha6mA
 a3T+XF7EtRTWnTtLdfaqkGo+ukFVfhpB0njNX//ziqD2/AvRRxXrnGgvR2S9h7Pqedx6LsGUu
 /M13YVcImAFzKUuTwL0Bv4zczS07lG22dM0GkH6bNCIB56ASC0VnYR+f5B0YGr3APXHktu8EI
 bSppGPp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 31 May 2018, Stefan Beller wrote:

> On Thu, May 31, 2018 at 5:07 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Stefan,
> >
> > On Wed, 30 May 2018, Stefan Beller wrote:
> >
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >> ---
> >>  builtin/submodule--helper.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> >> index 7c3cd9dbeba..96024fee1b1 100644
> >> --- a/builtin/submodule--helper.c
> >> +++ b/builtin/submodule--helper.c
> >> @@ -63,6 +63,7 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
> >>       if (remote)
> >>               printf("%s\n", remote);
> >>
> >> +     free(remote);
> >
> > Makes sense.
> >
> > Out of curiosity (and because a cover letter is missing): how did you
> > stumble over these? Coverity?
> 
> Yes I found them on coverity as I wanted to find out how bad their
> false positives are these days. So I looked at the most recent findings.
> 
> I somehow imagined that we could redefine the _INIT macros which
> usually lead to false positives (just alloc&UNLEAK memory instead of
> pointing them all at the same memory for _INIT), but that experiment
> did not work out.

Yes, those many, many, *many* false positives really drown out the benefit
of Coverity for me. It takes all the fun out of looking for quick bug
fixes.

Ciao,
Dscho
