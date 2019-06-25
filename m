Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F104F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 16:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFYQgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 12:36:36 -0400
Received: from ikke.info ([178.21.113.177]:52156 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfFYQgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 12:36:35 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 12:36:35 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id DA1544400C6; Tue, 25 Jun 2019 18:26:58 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:26:58 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Thomas Hruska <thruska@cubiclesoft.com>
Cc:     git@vger.kernel.org
Subject: Re: Why is part of push origin output written to stderr?
Message-ID: <20190625162658.GA29877@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Thomas Hruska <thruska@cubiclesoft.com>, git@vger.kernel.org
References: <b9961c7b-dd8e-e08e-99bb-60923a05ce87@cubiclesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9961c7b-dd8e-e08e-99bb-60923a05ce87@cubiclesoft.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 08:27:20AM -0700, Thomas Hruska wrote:
> As seen from a basic 'git push origin master' where the last part of the
> output of a successful push origin is sent to stderr instead of stdout:
> 
> To host:user/something.git
>    1f57f4a..1a96eab  master -> master
> 
> I don't usually think of a successful push as being a fatal error but I
> could be very wrong.  Maybe git is trying to tell me that pushing is
> actually a mistake.

Although the name implies it's used for error output, some programs also
use stderr to output anything that is separate from the standard output
of a program.

Curl for example show progress information on stderr to not intersperse
it with the normal output of curl.

The same happens here with git. You have the regular output of git push,
but any progress update is writted to stderr.

So stderr is more treated like an additional output stream rather than
only reporting errors to stderr.

Hope this helps, Kevin

> 
> -- 
> Thomas Hruska
> CubicleSoft President
> 
> http://cubiclesoft.com/
> 
