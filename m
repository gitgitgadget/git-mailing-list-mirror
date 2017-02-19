Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF57201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 14:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdBSONR (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 09:13:17 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:49076 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbdBSONQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 09:13:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vR7yf1sPWz5tl9;
        Sun, 19 Feb 2017 15:13:13 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1B5471E6F;
        Sun, 19 Feb 2017 15:13:13 +0100 (CET)
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
 <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
 <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org>
Date:   Sun, 19 Feb 2017 15:13:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.02.2017 um 12:32 schrieb Alex Hoffman:
> The assumption that there is no transition from bad to good in the
> graph did not hold in my example and it does not hold when a feature
> was recently introduced and gets broken relative shortly afterwards.

Then you must adjust your definition of "good": All commits that do not 
have the feature, yet, are "good": since they do not have the feature in 
the first place, they cannot have the breakage that you found in the 
feature.

That is exactly the situation in your original example! But you 
constructed the condition of goodness in such a simplistic way 
(depending on the presence of a string), that it was impossible to 
distinguish between "does not have the feature at all" and "has the 
feature, but it is broken".

-- Hannes

