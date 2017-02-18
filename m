Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295AB201A8
	for <e@80x24.org>; Sat, 18 Feb 2017 09:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbdBRJNF (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 04:13:05 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:46679 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbdBRJNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 04:13:02 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vQPKq652Pz5tlH;
        Sat, 18 Feb 2017 10:12:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0B7D51E70;
        Sat, 18 Feb 2017 10:12:15 +0100 (CET)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
Date:   Sat, 18 Feb 2017 10:12:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.2017 um 00:21 schrieb Stephan Beyer:
> On 02/17/2017 11:29 PM, Alex Hoffman wrote:
> *   7a9e952 (bisect bad) <BAD>
> |\
> | *   671cec2 <BAD> <--- expected
> | |\
> | * | 04c6f4b <BAD> <--- found
> * | |   3915157 <GOOD>
> |\ \ \
> | | |/
> | |/|
> | * | f4154e9 (bisect good) <GOOD>
> | * | 85855bf <BAD>
> | |/
> * | f1a36f5 <BAD>
> |/
> * 1b7fb88 <BAD>
>
> The <BAD> and <GOOD> markers are set by your definition of what good and
> what bad commits are.
>
> [...]
> In other words: bisect assumes that your repo is usually in a good state
> and you have a commit that changes it to a bad state. In your case you
> have a repo that is in a bad state and you have a commit that switches
> it to a good state and later you merge a bad-state branch and you have a
> bad state again. It is not made for that use-case, I think.

Correct. The assumption of bisection is that there is only one 
transition between GOOD and BAD. By violating that assumption, anything 
can happen.

-- Hannes

