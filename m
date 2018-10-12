Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189021F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 07:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJLP2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 11:28:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:45179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeJLP2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 11:28:42 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAkkB-1gMjss1xcJ-00BqHi; Fri, 12
 Oct 2018 09:57:25 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAkkB-1gMjss1xcJ-00BqHi; Fri, 12
 Oct 2018 09:57:25 +0200
Date:   Fri, 12 Oct 2018 09:57:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
In-Reply-To: <xmqq7eiuwsm7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810120955090.45@tvgsbejvaqbjf.bet>
References: <20181004113015.GA30901@manohar-ssh> <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet> <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com> <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
 <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com> <xmqq7eiuwsm7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:daqCNZ+iB90xlGGwtbKStRPZlz9Op3le9IsccO1iDP4bYPiQNbf
 ZQ9Dz3G22ZpfOLqN/Prw0io5ns/D9SDpkckG2+f12O0b8wbpTMzMB1WmqZ+llEkeBYuOrn3
 5ORx/iLp4sIW0ViJ8BFENjKV9/uCfoKtSUZXazhbXjEJakBT1GseMFtnjL3P2fSLqztwKbQ
 yrLiPxKPt71UB4Pbc/GQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zdd3jtl2cvc=:YD8zM4fvzFygnSlgA1hmR8
 5JFobe87VZbcPwm6PiHBurBOtavgGeX0scriT26183ZZgt6Pv7uKUGFqSimq1j9TMP2to5JWg
 0por6gnJt79abp2thLDXfjd54zdOzzMVIVhMctf/FTf4noenMPfmyQOGuvfhOPzMaP+bkB7/i
 xPe3/0O6mWY4Uf0W/j0x87V5nJZMccb3r1FH2QM6RBRbuYAmVfbPlP5/ZV7DBddgQFf+0TA/y
 v0MckVNrhGZXi4tvhli2rz38TJQG6e5d1kkwPC4qdJYjWk3WN61Nlu++y3Gr7aI82rXz/xgYr
 o0PZ0PsJWG6F72Y+LCH9/D+d6ZWKPytH9xTvEPg6m6nfjX0jIb7V5rO4MoNtYE4+YIoYKrKmj
 /7T8oDnK4W4phdEmhIruRm7yhumkE7hXFrMQA9Mmbc9lIye90cAFDipqtCuDT56mWTN+MLAvF
 H0PhNUyGdDw1p3VFWa5v+05TfQEVYfZRAxRbunwmAEye5q37OSUEg5odqxUWZM3V7CsjV08BD
 pVE1QAdjSYG5KjiUWgr0CNn/WEiEx6QfEKfI0lTRExrwDDVn0lKImFvCfB1cgQcjd8E90hiwz
 DYJYrSYE5mkt4XWBjBKBkmj5cIqusS+152WFEY7Q7QQTb0TBAo9zJl41cK2+CIMuD85vUmRRU
 D04WE0Dre0L7zGwF5JTdkmSMaEox7dz1K0o4X/oBc0ShtQ9r95CDVb1AIJ3ZBEhmgQIAAetkc
 1QqWTzojGIRswh31sVISNevscfQOoNL0P6SSrDwGEWwusD9OJAl+BtrP1lTf93gDPBPIe0M5j
 7EpePtmWKvw18ASMwuPmE87Zea0yBn25krvUotNP53G0Vc/Rws=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 7 Oct 2018, Junio C Hamano wrote:

> And then there is an unnamed misdesigned language that has a
> regmatch() function, which takes a string that contains a regular
> expression, but somehow requires that string to begin and end with a
> slash for no justifiable reason ;-).

It makes more sense once you realize that /<regexp>/ is a very nice
syntactic construct to obtain an instance of a regular expression object,
rather than a string describing one.

In Perl it is not as obvious as in Javascript.

But in C, we do not have objects, so the way to describe a regular
expression is a string (which you have to compile into an opaque data
structure before applying it).

Ciao,
Johannes
