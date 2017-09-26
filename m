Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEE820281
	for <e@80x24.org>; Tue, 26 Sep 2017 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032000AbdIZTq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 15:46:56 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:29956 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031997AbdIZTqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 15:46:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y1s0Y46K8z5tlF;
        Tue, 26 Sep 2017 21:46:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F3038211E;
        Tue, 26 Sep 2017 21:46:50 +0200 (CEST)
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run
 from .gitmodules
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com
References: <xmqqshfa9doa.fsf@gitster.mtv.corp.google.com>
 <20170926185413.21209-1-sbeller@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0b69c0b0-6246-2428-b4b0-bb3ef3cb5ae7@kdbg.org>
Date:   Tue, 26 Sep 2017 21:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170926185413.21209-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.09.2017 um 20:54 schrieb Stefan Beller:
> +test_expect_success 'submodule update - command in .gitmodules is ignored' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
> +
> +	git -C super config -f .gitmodules submodule.submodule.update "!false" &&
> +	git -C super commit -a -m "add command to .gitmodules file" &&
> +	git -C super/submodule reset --hard $submodulesha1^ &&
> +	git -C super submodule update submodule &&
> +	test_path_is_missing bad

This test for a missing file is certainly a remnant from the previous 
iteration, isn't it?

-- Hannes
