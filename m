Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E853D20966
	for <e@80x24.org>; Fri,  7 Apr 2017 06:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbdDGGc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 02:32:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57917 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbdDGGcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 02:32:25 -0400
Received: (qmail 30578 invoked by uid 109); 7 Apr 2017 06:32:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 06:32:24 +0000
Received: (qmail 32393 invoked by uid 111); 7 Apr 2017 06:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 02:32:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 02:32:22 -0400
Date:   Fri, 7 Apr 2017 02:32:22 -0400
From:   Jeff King <peff@peff.net>
To:     diguazhixiu@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] Issue with branch -avv command
Message-ID: <20170407063222.hh2mifjidq5vrxfg@sigill.intra.peff.net>
References: <CAFQrz2EXJY=f6Yn0SHn0fZf61=hJQFb6t8LO+Dryw0HVf_s0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQrz2EXJY=f6Yn0SHn0fZf61=hJQFb6t8LO+Dryw0HVf_s0rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 01:08:23PM +0800, diguazhixiu@gmail.com wrote:

> Hi, all,
> 
> I have a problem when I use command 'git branch -avv', the result is
> like  below:
> 
>   my_test_branch                        d67ab86 fix some problem
> * master                                     27c4e0b [origin/master]
> Add new file
>  See merge request !146g within bucketsa824 Merge branch 'master' into 'master'
>   pref                                           060cac2 Fix bug
>   remotes/origin/HEAD                 -> origin/master
>   remotes/origin/my_test_branch d67ab86 fix some problem
>   remotes/origin/master               27c4e0b Add new file
>  See merge request !146g within bucketsa824 Merge branch 'master' into 'master'
> 
> The message ' See merge request...'  take the place of branch name, so
> I have to user 'git branch -a'
> to see the corresponding branch name.
> 
> Now, is my usage wrong? or is this a problem?

Do you perhaps have a commit at the tip of the branch that has a
carriage-return in it? Try piping the output through "cat -A" and look
for "^M" in the output.

-Peff
