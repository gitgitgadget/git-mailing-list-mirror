Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078D6200B9
	for <e@80x24.org>; Thu, 24 May 2018 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034564AbeEXTcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:32:31 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:36129 "EHLO
        7.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034514AbeEXTca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:32:30 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2018 15:32:30 EDT
Received: from player728.ha.ovh.net (unknown [10.109.120.8])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5D934B18A3
        for <git@vger.kernel.org>; Thu, 24 May 2018 20:54:48 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 9DC7454009C;
        Thu, 24 May 2018 20:54:43 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
From:   Kevin Bracey <kevin@bracey.fi>
Message-ID: <88f96a35-6368-de24-60ed-ad015f16f127@bracey.fi>
Date:   Thu, 24 May 2018 21:54:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523173523.GB10299@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 754071464854655197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrgeekgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/2018 20:35, Jeff King wrote:
> There's more discussion in the thread at:
>
>    https://public-inbox.org/git/1366658602-12254-1-git-send-email-kevin@bracey.fi/
>
> I haven't absorbed it all yet, but I'm adding Junio to the cc.

Just to ack that I've seen the discussion, but I can't identify the 
code's reasoning at the moment. My recollection is that I accepted while 
coming up with the algorithm that it might err slightly on the side of 
false positives in the display - there were some merge cases I was 
unable to fully distinguish whether or not the merge had lost a change 
it shouldn't have done, and if I was uncertain I'd rather show it than not.

The first commit was not originally intended to alter behaviour for 
anything other than --full-history, but later in the chain there was 
specific consideration into tracking the path to the specified "bottom" 
commit. It may be that's part of what's happening here.

Kevin




