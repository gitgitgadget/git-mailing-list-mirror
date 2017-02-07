Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30541FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 15:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbdBGPH7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Feb 2017 10:07:59 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:34882 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbdBGPH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 10:07:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 93B611E2CF8;
        Tue,  7 Feb 2017 16:07:54 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 120P562U1OMt; Tue,  7 Feb 2017 16:07:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 513C51E2F24;
        Tue,  7 Feb 2017 16:07:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YeOgCv-Q4YEl; Tue,  7 Feb 2017 16:07:54 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 1B6B31E2CF8;
        Tue,  7 Feb 2017 16:07:54 +0100 (CET)
Subject: Re: ``git clean -xdf'' and ``make clean''
To:     Hongyi Zhao <hongyi.zhao@gmail.com>, git@vger.kernel.org
References: <CAGP6PO+qD6eRkKbWAxOfiqUQw8o+dOfgwgvt_8OxHQ5ocAopEQ@mail.gmail.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <fe8595aa-0395-e948-13e9-f952541d106e@tngtech.com>
Date:   Tue, 7 Feb 2017 16:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGP6PO+qD6eRkKbWAxOfiqUQw8o+dOfgwgvt_8OxHQ5ocAopEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2017 03:17 PM, Hongyi Zhao wrote:
> Hi all,
> 
> In order to delete all of the last build stuff, does the following two
> methods equivalent or not?
> 
> ``git clean -xdf'' and ``make clean''

No, it is not equivalent.

* `make clean` removes any build-related files (assuming that the
`clean` target is properly written). To see exactly what it would do,
run `make clean -n`. Judging from your question, I think this is what
you want to do.

* `git clean -xdf` would remove any files that git does not track. This
also includes build-related files, but also any other files that happen
to be in your working directory. For example, any output from `git
format-patch` would be removed by this, but not `make clean`.
