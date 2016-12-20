Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79F71FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 20:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933517AbcLTUM6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 15:12:58 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:62345 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934807AbcLTUM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 15:12:57 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tjpqJ20H7z5tlQ;
        Tue, 20 Dec 2016 21:12:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D45142226;
        Tue, 20 Dec 2016 21:12:27 +0100 (CET)
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Stefan Beller <sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
 <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org>
 <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f14ee492-8297-c8ec-f80f-f8f24caf91e1@kdbg.org>
Date:   Tue, 20 Dec 2016 21:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2016 um 20:23 schrieb Stefan Beller:
> In a reroll I'll drop this patch and instead introduce
> a function `char *get_child_command_line(struct child_process*);`, which
> a caller can call before calling finish_command and then use the
> resulting string
> to assemble an error message without lego.

That sounds a lot better, thank you. Note though, that the function 
would have to be called before start_command(), because when it fails, 
it would be too late.

I have to ask, though: Is it so much necessary to report the exact 
command line in an error message? If someone is interested in which 
command failed, it would be "sufficient" to run the command under 
GIT_TRACE=2.

-- Hannes

