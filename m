Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B971F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHTTE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:04:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:43643 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTTEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:04:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46CgFg3py7z5tlB;
        Tue, 20 Aug 2019 21:04:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 740AA2146;
        Tue, 20 Aug 2019 21:04:22 +0200 (CEST)
Subject: Re: [PATCH v3 10/13] t4014: stop losing return codes of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <64069c0c540b109b46b2cc6c90e3b5c912aa18c5.1566285151.git.liu.denton@gmail.com>
 <20190820073130.GA32049@archbookpro.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34a613d0-2ac0-b642-b14d-59ca4ef2738e@kdbg.org>
Date:   Tue, 20 Aug 2019 21:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820073130.GA32049@archbookpro.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.19 um 09:31 schrieb Denton Liu:
> Oops, this should read
> 
> 	git_version="$(git --version >version && sed "s/.* //" <version)"

sed is not necessary. Make that

	git_version=$(git --version) &&
	git_version=${git_version##* }

-- Hannes
