Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8982F207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966906AbcIWPup (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 11:50:45 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:35683 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966895AbcIWPuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 11:50:44 -0400
Received: from [10.1.1.70] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 5E69F300C24;
        Fri, 23 Sep 2016 17:50:41 +0200 (CEST)
To:     gitster@pobox.com (Junio C Hamano)
Cc:     anatoly.borodin@gmail.com (Anatoly Borodin), git@vger.kernel.org
In-Reply-To: <xmqqvaxm1vc3.fsf@gitster.mtv.corp.google.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Fri, 23 Sep 2016 17:50:41 +0200
Message-ID: <1mu1iqo.1gihw0m1dcenmnM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.11.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > Thanks, this is interesting; I'm having trouble understanding the tests
> > though. Some of them use rebase -p -i, but I don't understand why they
> > use -i, or why that even works in a test (i.e. why it doesn't open an
> > editor).
> 
> Upon starting up, tests dot-source t/test-lib.sh file and it
> unsets most of GIT_* environment variables to obtain a stable
> testing environment that is not affected by things that testers
> may have in their environment.
> 
> There is EDITOR=: in t/test-lib.sh, which was added in 2006 before
> GIT_EDITOR was invented.  That is the one in effect for git
> subcommands that usually interacts with editors during the test,
> unless specific tests further override it with test_set_editor
> helper.

Thanks for the explanation. So this explains why -i works at all here;
it doesn't explain why -i is used in these tests. Unless I'm missing
something, they should all work with just -p.

And I don't see any tests that do rebase -p -i and actually do something
interesting with the -i part. So my original question still remains. :-)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
