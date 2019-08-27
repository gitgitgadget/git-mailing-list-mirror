Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6131F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfH0Se0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:34:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:18273 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfH0Se0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:34:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46HyFr24cGz5tlF;
        Tue, 27 Aug 2019 20:34:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6F07049CB;
        Tue, 27 Aug 2019 20:34:23 +0200 (CEST)
Subject: Re: How to build to debug with gdb?
To:     Giuseppe Crino' <giuscri@gmail.com>
References: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1d44d8d6-6c6f-591e-dd2c-5102c9fd7d11@kdbg.org>
Date:   Tue, 27 Aug 2019 20:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.08.19 um 18:27 schrieb Giuseppe Crino':
> Hello, to debug some issues I built and installed git via
> 
> $ make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g"
> $ sudo make install
> $ git --version # git version 2.23.0.40.g4d8aada92f 
> 
> But it seems there's still some optimization going on that prevents gdb from working correctly.

That is because the command sequence above does not do what you think it
does. Didn't you notice that everything was recompiled during `sudo make
install`?

You must run

  sudo make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g" install

-- Hannes
