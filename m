Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACED20987
	for <e@80x24.org>; Mon, 10 Oct 2016 00:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbcJJASc (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 20:18:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47935 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcJJASb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 20:18:31 -0400
Received: from [IPv6:2607:fb90:4a5:84ad:61ac:5013:e853:d7aa] (unknown [IPv6:2607:fb90:4a5:84ad:61ac:5013:e853:d7aa])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BB00EA80C4;
        Mon, 10 Oct 2016 02:18:20 +0200 (CEST)
User-Agent: K-9 Mail for Android
In-Reply-To: <3CE95FD5-C5A9-4DE3-8B57-80B858769D1B@freedesktop.org>
References: <3CE95FD5-C5A9-4DE3-8B57-80B858769D1B@freedesktop.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: git 2.10.1 test regression in t4014-format-patch.sh
From:   Josh Triplett <josh@joshtriplett.org>
Date:   Sun, 09 Oct 2016 17:18:15 -0700
To:     Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
CC:     gitster@pobox.com, git@vger.kernel.org
Message-ID: <F069D0FD-C3CF-4F40-9338-D84E76DB310B@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 9, 2016 5:15:22 PM PDT, Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org> wrote:
>Hey Josh,
>
>Hope you're doing well.
>
>I wanted to let you know that this patch of yours, which landed in git
>2.10.1, introduced some test failures, seen on macOS.
>
>Let me know if you need any additional information to track these down.
>
>Thanks,
>Jeremy
>
>
>not ok 65 - format-patch default signature
>#	
>#		git format-patch --stdout -1 | tail -n 3 >output &&
>#		signature >expect &&
>#		test_cmp expect output
>#	
>
>not ok 132 - format-patch --base
>#	
>#		git checkout side &&
>#		git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual &&
>#		echo >expected &&
>#		echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
>#		echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git
>patch-id --stable | awk "{print \$1}")" >>expected &&
>#		echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git
>patch-id --stable | awk "{print \$1}")" >>expected &&
>#		signature >> expected &&
>#		test_cmp expected actual
>#	

Can you run the test with the option to show the expected and actual strings?

Did the testsuite run with the wrong git somehow?


