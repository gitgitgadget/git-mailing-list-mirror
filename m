Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD911FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 00:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbdBDAzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 19:55:55 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:40852 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdBDAzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 19:55:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id BC82E1E2D79;
        Sat,  4 Feb 2017 01:55:51 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7zDzaAHyCDEu; Sat,  4 Feb 2017 01:55:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 7AEC01E2D87;
        Sat,  4 Feb 2017 01:55:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qnnf0q2slexO; Sat,  4 Feb 2017 01:55:51 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-206-133.dynamic.mnet-online.de [185.17.206.133])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 05E2F1E2D79;
        Sat,  4 Feb 2017 01:55:50 +0100 (CET)
Subject: Re: BUG: "git checkout -q -b foo origin/foo" is not quiet
To:     Kevin Layer <layer@known.net>, git@vger.kernel.org
References: <CAGSZTjKywt28Pq7S+Hidi0XeseDxUAMEorrspZQ6jb50yic3+g@mail.gmail.com>
 <CAGSZTjLrdYJHixsUz0ha6=E263Z-vQuA11Oq=UNSVZfOmHkRuA@mail.gmail.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <3bd29833-8fb2-5097-f735-6a3f61e678bf@tngtech.com>
Date:   Sat, 4 Feb 2017 01:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGSZTjLrdYJHixsUz0ha6=E263Z-vQuA11Oq=UNSVZfOmHkRuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2017 10:36 PM, Kevin Layer wrote:
> Note that git version 1.8.3.1 is quiet and does not print the
> "tracking remote" message.

So what you are saying is, that git v1.8.3.1 *is* quiet, but v1.7.1 is
not? Sounds like a fixed bug to me.

I also checked with the latest version and it did not print anything
when used with -q.


You seem to urgently need quiet branch creation. Have you thought about
dumping unwanted output in the shell? E.g. in bash

$ git whatever >&/dev/null
