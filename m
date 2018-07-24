Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162321F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeGXKFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:05:39 -0400
Received: from mout.web.de ([212.227.17.12]:51421 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbeGXKFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:05:39 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1gQoFX1SkW-00lZKd; Tue, 24
 Jul 2018 11:00:07 +0200
Date:   Tue, 24 Jul 2018 11:00:05 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/1] t7406: avoid failures solely due to timing issues
Message-ID: <20180724090005.GA25260@tor.lan>
References: <pull.12.git.gitgitgadget@gmail.com>
 <xmqqr2jt6a5b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2jt6a5b.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Zb8HqqCe1Fp57OOhA8JM+fdAZk7DsV6OHDuTALJLNDoloznXGo2
 Y9g2NYVdcN6/vznThuBObUYgnANHVyu/SqNRt00SCXtrkEXsjY6caIfZfMg+IhZi8birAG2
 X+rDsI8UKCSGxam6bG7riL+Ej58i9CBaO+wvsTJVqDDwrRHuMV/GBsTF9MKnkY6N/PGYODh
 yd451jTnLBIp+2TJgi7bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+lHNYi1Rx8w=:bKJrJo9GledMQGQs6smQl4
 Tfn0/vf95dMnKeea56OTypAeRjzz9dyFtLslygQ8Zy/6vzYHW9aKCbQkNm0paGQ/xYPnh1iqC
 H7BSJZx3NtGSorKNFLv+CaDwqNDNR6DOiS3vI4oG2pLa9pi2HOZSJnryLvU4a4faRfegGYVJC
 TjxBPk0weJE7vrcjYt2JWw94gS/l3pslaq6mRkjybbcn6qva7gVvp1pL0vyj/vqphmX/sMxp8
 JV6wGWf08XgQ2jzDt3k80v1zDEwdrLurIql3InwAxV8LLP2HIe7zhplwJlg19nG7ZN4cfiV1a
 Ax9gJvSp0QJ6DcDa/9tuJ6EKco/9J+DubMpn+Lp5rdLBJxMthDGaeLHI6Nk0M+YmpEqkMsZDu
 IdrnBVj6IPAHwb2ZSKnfmOfJ7j4t8/gSPruKCkNGf7fD87etP7108p+7lSTHx4usMiUmxXkni
 s+jP4FXAgK85+ofK7KCksNPTZNjA8MrP2TzgCPly8iPVtkxdyhMQQmIvIf03cQJXQuSff+Wrt
 QKXQbCn5+xYCtj4FAyIT/mB+5dwvhmQvZix6zluVEuiZkGY5YqjiABWHU4pK/cPCD+w9FThqv
 qHDak+XEJ+d3okaU9rw/g7UE/ZPyjv5vUoXEbAdCIoVresH8Z5x5JdVUaeWXHlJJzx23BjwQ8
 lnq0LHRBW6A+XdI6vk+kKrS8xwDpYwEpv1wLwKz3SI18WvhI9F3U/Z358J+DCnQPVV/jpV2Ww
 FNTee1bu8ZNx8uMwuveQcwJ6lAd+gFPGJRzibDRe9/NAqaVUMAv32XI53JA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:10:24PM -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This fixes a regression test that produces false positives occasionally: https://git-for-windows.visualstudio.com/git/_build/results?buildId=14035&view=logs
> >
> 
> [jc: forwrding to Torsten for <208b2ede-4833-f062-16f2-f35b8a8ce099@web.de>]

Yes,
thanks for a "fantastic fast fix" and the integration.

I downloaded and tested it OK (under MacOS) this morning.
