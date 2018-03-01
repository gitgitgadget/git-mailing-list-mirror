Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9B21F404
	for <e@80x24.org>; Thu,  1 Mar 2018 14:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031565AbeCAO27 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 1 Mar 2018 09:28:59 -0500
Received: from elephants.elehost.com ([216.66.27.132]:24724 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031397AbeCAO2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 09:28:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w21ESbrN053250
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Mar 2018 09:28:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'demerphq'" <demerphq@gmail.com>
Cc:     "'Eric Wong'" <e@80x24.org>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Git'" <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com> <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir> <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net> <000501d3b0a4$29162a80$7b427f80$@nexbridge.com> <CANgJU+VYkmUhJT=CHQ4HTqoV4gWhr9P4-65BfrY-RWgwJJhEUA@mail.gmail.com> <20180301073629.GC31079@sigill.intra.peff.net>
In-Reply-To: <20180301073629.GC31079@sigill.intra.peff.net>
Subject: RE: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Thu, 1 Mar 2018 09:28:31 -0500
Message-ID: <001d01d3b169$95f4b0c0$c1de1240$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJEpadERfpX5LkwuayU7lmWnKekrgHW5ptIArDwK6kB6BkubwJEbisnAR6VsxoCg3sX4gJMApEJAnNK9haiUNie0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 1, 2018 2:36 AM, Jeff King wrote:
> On Wed, Feb 28, 2018 at 05:51:14PM +0100, demerphq wrote:
> 
> > I would look into putting it into a module and then using the PERL5OPT
> > environment var to have it loaded automagically in any of your perl
> > scripts.
> >
> > For instance if you put that code into a module called Git/DieTrap.pm
> >
> > then you could do:
> >
> > PERL5OPT=-MGit::DieTrap
> >
> > In your test setup code assuming you have some. Then you don't need to
> > change any of your scripts just the test runner framework.
> 
> That's a clever trick.
> 
> It's not clear to me though if we just want to tweak the programs run in the
> test scripts in order to get test_must_fail to stop complaining, or if we
> consider the unusual exit codes from our perl-based Git programs to be an
> error that should be fixed for real use, too.

I'm living unusual exit code IRL all the time. So "fixed for real", is what I'm looking for. So if we were to do that, where is the best place to insert a fix - my original question - that would be permanent in the main git test code. Or perhaps this needs to be in the main code itself.

Cheers,
Randall

