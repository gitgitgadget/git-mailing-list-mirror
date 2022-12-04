Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE3C4321E
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 15:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLDPwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 10:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLDPwU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 10:52:20 -0500
X-Greylist: delayed 168 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Dec 2022 07:52:18 PST
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80BC13D16
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 07:52:18 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 74CAD48E;
        Sun,  4 Dec 2022 16:49:28 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id C58A2280021C; Sun,  4 Dec 2022 16:49:27 +0100 (CET)
Date:   Sun, 4 Dec 2022 16:49:27 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Message-ID: <20221204154927.GF33204@zira.vinc17.org>
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
 <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
 <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
 <a97758b5-dfdc-9a24-654b-8846a9feb45d@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a97758b5-dfdc-9a24-654b-8846a9feb45d@dunelm.org.uk>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.9+50 (c79959e1) vl-149028 (2022-11-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-04 15:13:52 +0000, Phillip Wood wrote:
> On 02/12/2022 17:01, Vincent Lefevre wrote:
> > First, one issue is that this is not documented (I was not aware of
> > the notion of trailers, well, at least concerning a special handling
> > by Git).
> 
> They are mentioned in the documentation for 'git commit' see the --signoff
> and --trailer options. The main reference is 'git interpret-trailers'

This issue occurs with "git cherry-pick -x", so that one could expect
documentation there. Since I don't use trailers (this was a false
positive), I wouldn't have the idea to look at the --trailer
documentation.

> > Then perhaps there should be some configuration to define which
> > tokens are allowed (or forbidden) for trailers. For instance,
> > I would say that "Note" is too common in log messages to be
> > regarded as a trailer token.
> 
> There are some safeguards when looking for trailers (see the
> interpret-trailers man page) I think you have been unlucky here, I don't
> remember this being reported before. I've cc'd Christian who knows more
> about trailers than I do to see if he has anything to add.

I think that what could be interesting there is a
trailer.<token>.separators option (assuming that one can
use an empty list of separators to disable a token), but
that doesn't exist.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
