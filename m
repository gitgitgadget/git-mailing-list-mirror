Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1991B1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbcKUS6r (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:58:47 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:34996 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbcKUS6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:58:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tMyYb6Syhz5tlJ;
        Mon, 21 Nov 2016 19:58:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 92E6E143;
        Mon, 21 Nov 2016 19:58:41 +0100 (CET)
Subject: Re: [PATCH 3/3] rebase -i: handle core.commentChar=auto
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
 <975c0002-8afe-efa6-d967-72f2a0d21169@kdbg.org>
 <xmqq37ikk762.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8b783f3d-8fda-b5cb-239f-895b10a22a73@kdbg.org>
Date:   Mon, 21 Nov 2016 19:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq37ikk762.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.11.2016 um 19:40 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> It could be written without forking a process:
>>
>> 	comment_char=${comment_char%${comment_char#?}}
>>
>> (aka "remove from the end what remains after removing the first character")
>
> Hopefully nobody would include any glob metacharacters in there,
> e.g. "core.commentchar='=*'", which would break that?

Heh. I tested a few variations, but not this one. Make it

  	comment_char=${comment_char%"${comment_char#?}"}

;)

-- Hannes

