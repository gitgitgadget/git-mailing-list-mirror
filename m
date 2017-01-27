Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A02E20D0E
	for <e@80x24.org>; Fri, 27 Jan 2017 02:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbdA0CpW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 21:45:22 -0500
Received: from avasout06.plus.net ([212.159.14.18]:50346 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdA0CpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 21:45:22 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id dElF1u0030srQBz01ElGDj; Fri, 27 Jan 2017 02:45:17 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=MgygSqtNjWWgcgN_SVQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Intermittent failure of t1700-split-index.sh
Message-ID: <818851a6-c3ef-618e-4146-518fbe6bd837@ramsayjones.plus.com>
Date:   Fri, 27 Jan 2017 02:45:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

I noticed the intermittent failure of t1700-split-index.sh
(tests #17 and #18) yesterday. It failed in a full test-suite
run, but would not fail when run by hand, until I ran it
like so:

    $ cd t
    $ for i in `seq 100`; do
    > echo "== $i =="
    > ./t1700-split-index.sh -i -v || break
    > done

... when it failed on the 82nd run!

I only had a brief look in the trash directory, but I could
see that the 'twelve' file did not exist, 'eleven' did exist
and was in the index (well, git ls-files showed it), and that
there were only two '.git/sharedindex.*' files and that their
timestamps had not been changed.

I can't devote any time to looking at this further tonight
(it's 2-45am here, I'm off to bed!). Can you reproduce the
problem, or is it just me? :)

ATB,
Ramsay Jones

