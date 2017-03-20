Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142CC20323
	for <e@80x24.org>; Mon, 20 Mar 2017 05:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdCTFzN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 01:55:13 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:34929 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdCTFzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 01:55:12 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7AA26D56A1BC5;
        Mon, 20 Mar 2017 05:55:07 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 20 Mar 2017 05:55:09 +0000
Received: from PUMAIL01.pu.imgtec.org (192.168.91.250) by
 HHMAIL-X.hh.imgtec.org (10.100.10.113) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 20 Mar 2017 05:55:09 +0000
Received: from [192.168.91.23] (192.168.91.23) by PUMAIL01.pu.imgtec.org
 (192.168.91.250) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 20 Mar
 2017 11:25:07 +0530
Subject: Re: [PATCH 2/2] grep: fix builds with with no thread support
To:     Brandon Williams <bmwill@google.com>
References: <20170317182403.GA110341@google.com>
 <20170317184155.128674-1-bmwill@google.com>
 <20170317184155.128674-2-bmwill@google.com>
CC:     <git@vger.kernel.org>, <gitster@pobox.com>
From:   Rahul Bedarkar <Rahul.Bedarkar@imgtec.com>
Message-ID: <91e0c631-1ce3-e76c-325b-fde0123c54b1@imgtec.com>
Date:   Mon, 20 Mar 2017 11:25:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170317184155.128674-2-bmwill@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.91.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Saturday 18 March 2017 12:11 AM, Brandon Williams wrote:
> Commit 0281e487fd91 ("grep: optionally recurse into submodules")
> added functions grep_submodule() and grep_submodule_launch() which
> uses "struct work_item" which is defined only when thread support
> is available.
>
> The original implementation of grep_submodule() used the "struct
> work_item" in order to gain access to a strbuf to store its output which
> was to be printed at a later point in time.  This differs from how both
> grep_file() and grep_sha1() handle their output.  This patch eliminates
> the reliance on the "struct work_item" and instead opts to use the
> output function stored in the output field of the "struct grep_opt"
> object directly, making it behave similarly to both grep_file() and
> grep_sha1().
>
> Reported-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/grep.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>

It works for me.

Tested-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>

Thanks,
Rahul
