Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3941FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952386AbdDYSSN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:18:13 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:4755 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948113AbdDYSSM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:18:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wCBKF503Lz5tlH;
        Tue, 25 Apr 2017 20:18:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 580DF42D2;
        Tue, 25 Apr 2017 20:18:08 +0200 (CEST)
Subject: Re: [PATCH v7 1/2] exec_cmd: expose is_executable function
To:     Brandon Williams <bmwill@google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        e@80x24.org, jrnieder@gmail.com, peff@peff.net
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <73f07d3e-b2a2-0073-8fba-6f7f51f64a7d@kdbg.org>
Date:   Tue, 25 Apr 2017 20:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170425175446.113553-1-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 19:54 schrieb Brandon Williams:
> Move the logic for 'is_executable()' from help.c to exec_cmd.c and
> expose it so that callers from outside help.c can access the function.

The function is quite low-level. IMO, run-command.[ch] would be a better 
home for it. Additionally, that would reduce the number of files that 
contain #ifdef GIT_WINDOWS_NATIVE.

-- Hannes

