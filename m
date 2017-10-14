Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B647B1FF32
	for <e@80x24.org>; Sat, 14 Oct 2017 15:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbdJNPBZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Oct 2017 11:01:25 -0400
Received: from ikke.info ([178.21.113.177]:35272 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753806AbdJNPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Oct 2017 11:01:25 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 4BB4B44039D; Sat, 14 Oct 2017 17:01:23 +0200 (CEST)
Date:   Sat, 14 Oct 2017 17:01:23 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>,
        git@vger.kernel.org
Subject: Re: Can I remove multiple stashed states at a time?
Message-ID: <20171014150123.GA28038@alpha.vpn.ikke.info>
References: <CAC2JkrLm3QCNW1t-Yju-sA=9Tbv8hH1AHZUEDux8kSG9mkG5wg@mail.gmail.com>
 <20171013173522.vprwjwprhnoiyajy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171013173522.vprwjwprhnoiyajy@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 01:35:22PM -0400, Jeff King wrote:
> On Fri, Oct 13, 2017 at 11:58:12AM +0900, 小川恭史 wrote:
> 
> You can also just do:
> 
>   for i in 1 2 3; do
>      git stash drop $i
>   done
> 

Doesn't stash 2 become stash 1 after the first drop, and the same for 3,
resulting in dropping stash 1, 3 and 5?

So something like

  for i in 3 2 1; do
      git stash drop $i;
  done

Or leave $i out altogether.
