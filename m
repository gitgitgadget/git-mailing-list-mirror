Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753A81F731
	for <e@80x24.org>; Fri,  2 Aug 2019 15:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfHBPL0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 11:11:26 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:11435 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHBPL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 11:11:26 -0400
Received: from [87.165.18.83] (helo=[192.168.2.6])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htZDH-0002IL-EB; Fri, 02 Aug 2019 17:11:23 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <20190731171956.GA26746@sigill.intra.peff.net>
 <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
 <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
 <ed45493e-2a99-1137-cdf1-9a14b9c3bf7e@syntevo.com>
 <nycvar.QRO.7.76.6.1908021641200.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <b736296c-c964-6096-bf36-99d31ccf8fee@syntevo.com>
Date:   Fri, 2 Aug 2019 17:11:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908021641200.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.08.2019 16:47, Johannes Schindelin wrote:

 > and definitely does *not* want to write a file.

In this case it can use `--paths-file -`, which means stdin.

> Zilch. So I find the advice you received, let's say, interesting.

I understood that `--paths-file` is suggested to avoid possible
stdin collisions in high-level commands.

It seems that only plumbing commands accept --stdin for paths now.

Both me and you are now trying to address high-level commands, which is
new. This explains why grep doesn't currently find `--paths-file`.

The approach sounds reasonable to me as a long-term strategy:
1) Won't require rework if someone wants file instead
2) stdin is still supported for those who want it
3) There's a way to avoid potential collisions in stdin
