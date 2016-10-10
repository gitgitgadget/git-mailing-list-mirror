Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9659820989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbcJJTXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:23:14 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:13421 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751100AbcJJTXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:23:13 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.101])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3st8wX6wMrz5tqV
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 21:15:40 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3st8tr01N3z5tlB;
        Mon, 10 Oct 2016 21:14:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3768F52E5;
        Mon, 10 Oct 2016 21:14:11 +0200 (CEST)
Subject: Re: git 2.10.1 test regression in t3700-add.sh
To:     Junio C Hamano <gitster@pobox.com>
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
 <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
 <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
 <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
 <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>,
        t.gummerer@gmail.com, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dddae1eb-347c-a285-0699-31f30eb924d8@kdbg.org>
Date:   Mon, 10 Oct 2016 21:14:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 19:41 schrieb Junio C Hamano:
> I also notice that the problematic test uses "chmod 755"; don't we
> need POSIXPERM prerequisite on this test, too, I wonder?

Good point. Without POSIXPERM the test demonstrate that, since chmod 755 
is basically a noop, the following add --chmod=-x does not leave an x 
bit in the index when there was none there in the first place. I think 
it does not hurt to keep the test even though it does not quite test the 
same thing as on POSIXPERM enabled systems.

-- Hannes

