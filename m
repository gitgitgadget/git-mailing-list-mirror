Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638B520966
	for <e@80x24.org>; Fri,  7 Apr 2017 08:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbdDGIYT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 04:24:19 -0400
Received: from 5.itsy.de ([188.40.84.14]:54909 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754874AbdDGIYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 04:24:16 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 79E3764474
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 10:24:14 +0200 (CEST)
Subject: Re: problem with backslash in directory name
References: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
From:   Joachim Durchholz <jo@durchholz.org>
To:     git@vger.kernel.org
Message-ID: <06bad45d-ad0b-aafe-47e8-172e44ab69cc@durchholz.org>
Date:   Fri, 7 Apr 2017 10:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.2017 um 08:30 schrieb Jeff King:
> Probably it's "read" which does backslash expansion, but nothing else.
> Just grepping git-submodule.sh, some of the "read" calls should probably
> be "read -r"

http://wiki.bash-hackers.org/commands/builtin/read has this to say:

> Essentially all you need to know about -r is to ALWAYS use it. The
 > exact behavior you get without -r is completely useless even for weird
 > purposes. It basically allows the escaping of input which matches
 > something in IFS, and also escapes line continuations. It's explained
 > pretty well in the POSIX read[1] spec.

[1] 
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html#tag_20_109

(That's the kind of stuff that makes me shy of using shell scripts - 
always yet another surprise in waiting...)
