Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972261FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbcIDJUb (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 05:20:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58580 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbcIDJU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 05:20:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u849JIYZ006619
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 4 Sep 2016 11:19:18 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u849JJcR004507;
        Sun, 4 Sep 2016 11:19:19 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
        <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
        <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
        <20160830205151.k6ufhfzl6gh4uuog@sigill.intra.peff.net>
        <CACBZZX4NyjkK0Nf1JVGFRhc0xnLYg2YX6ctO5OxK3Pi60r5KaA@mail.gmail.com>
        <alpine.DEB.2.20.1608311227150.129229@virtualbox>
        <CACBZZX6exynt_9_wVtEN19HQt_rPJdo5Ck3jujdQ-hLdMAGdmg@mail.gmail.com>
        <alpine.DEB.2.20.1608311702440.129229@virtualbox>
        <CACBZZX56fjJZydnBrWUYtU6V3xyQyaLL4MYzVVF0yD4dRdducw@mail.gmail.com>
        <alpine.DEB.2.20.1609021406340.129229@virtualbox>
        <vpq8tva1cou.fsf@anie.imag.fr>
        <alpine.DEB.2.20.1609040952110.129229@virtualbox>
Date:   Sun, 04 Sep 2016 11:19:19 +0200
In-Reply-To: <alpine.DEB.2.20.1609040952110.129229@virtualbox> (Johannes
        Schindelin's message of "Sun, 4 Sep 2016 09:55:39 +0200 (CEST)")
Message-ID: <vpqoa44xbs8.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 04 Sep 2016 11:19:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u849JIYZ006619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1473585563.60289@LoZ/jeWG/zXyzSwdJnM+xA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 2 Sep 2016, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Hi Ævar,
>> >
>> > On Fri, 2 Sep 2016, Ævar Arnfjörð Bjarmason wrote:
>> >
>> >> This might be me missing the point, and I'm really just trying to be
>> >> helpful here and make "prove" work for you because it's awesome, but
>> >> as far as just you running this for development purposes does any of
>> >> this SVN stuff matter? I.e. you can build Git itself not with
>> >> Strawberry, but just use Strawberry to get a working copy of "prove".
>> >
>> > Yes, the SVN stuff matters, because of the many t9*svn* tests (which, BTW
>> > take a substantial time to run). So if I run the test suite, I better do
>> > it with a perl.exe in the PATH that can run the SVN tests. Otherwise I
>> > might just as well not bother with running the entire test suite...
>> 
>> Maybe something like
>> 
>> \path\to\strawberry-perl\perl.exe \path\to\prove ...
>> 
>> without changing the PATH would work. I wouldn't call that convenient
>> though.
>
> Wouldn't Perl-specific environment variables set by Strawberry Perl (such
> as PERL_PATH bleed through to the spawned child processes?
>
> We're dancing around the issue, really. Rather than piling workaround on
> workaround with no end in sight, I think it is time to admit that using
> prove(1) on Windows is just not a good solution for the problem to re-run
> failed tests.

I didn't re-add Ævar's disclaimer, but my message was really not
intended to be an objection to your patch, just a (not necessarily good)
idea in case you or someone else on windows wanted to give one more
chance to prove.

I'm all for adding "make failed". Actually, we could even make the
feature more discoverable by echoing "You may run 'make failed' to
re-run failed tests" at the end of the tests when one of them failed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
