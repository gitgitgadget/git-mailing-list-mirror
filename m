Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FE82018D
	for <e@80x24.org>; Tue,  9 May 2017 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbdEIUnH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 16:43:07 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:42841 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdEIUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 16:43:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wMrt04Ypzz5tlF;
        Tue,  9 May 2017 22:43:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1304C42CB;
        Tue,  9 May 2017 22:43:04 +0200 (CEST)
Subject: Re: [PATCH] fixup! use perl instead of sed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
 <20170509164515.31942-1-jonathantanmy@google.com>
 <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4cb1d101-3efa-6376-64fd-2b9090d0b0c4@kdbg.org>
Date:   Tue, 9 May 2017 22:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.2017 um 19:00 schrieb Ævar Arnfjörð Bjarmason:
> Finally, you can just use -i like you did with sed, no need for the tempfile:

Nope. Some implementations of perl attempt to remove the file that it 
has just opened. That doesn't work on Windows. You have to supply a 
backup file name as in `perl -i.bak ...` :-(

> 
>      $ echo hibar >push
>      $ perl -pi -e 's/([^ ])bar/$1baz/' push
>      $ cat push
>      hibaz

-- Hannes
