Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE9E1F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 00:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbcJUAYx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:24:53 -0400
Received: from avasout03.plus.net ([84.93.230.244]:36134 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbcJUAYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:24:52 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id y0Qp1t0020zhorE010Qqqs; Fri, 21 Oct 2016 01:24:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=DwnnDRWwDSAz6E8a4v4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t9000-addresses.sh: unexpected pases
Message-ID: <3e9bfa01-d69c-05c1-e24e-960a3add2551@ramsayjones.plus.com>
Date:   Fri, 21 Oct 2016 01:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthieu,

I have started seeing unexpected passes in this test (am I the
only one?) on the next and pu branch, which seems to be caused
by commit e3fdbcc8 ("parse_mailboxes: accept extra text after
<...> address", 13-10-2016). Thus:

  $ tail -15 ntest-out
  [15:17:44]
  All tests successful.

  Test Summary Report
  -------------------
  t9000-addresses.sh                               (Wstat: 0 Tests: 37 Failed: 0)
    TODO passed:   28, 30-31
  Files=760, Tests=13940, 484 wallclock secs ( 4.04 usr  1.30 sys + 60.52 cusr 36.76 csys = 102.62 CPU)
  Result: PASS
  make clean-except-prove-cache
  make[2]: Entering directory '/home/ramsay/git/t'
  rm -f -r 'trash directory'.* 'test-results'
  rm -f -r valgrind/bin
  make[2]: Leaving directory '/home/ramsay/git/t'
  make[1]: Leaving directory '/home/ramsay/git/t'
  $ 

I have not even looked, but I suspect that it simply requires
a change from expect_fail to expect_success, since your commit
has 'fixed' these tests ... would you mind taking a quick look?

Thanks!

ATB,
Ramsay Jones

