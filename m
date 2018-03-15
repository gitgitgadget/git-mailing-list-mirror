Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85091F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeCOPNI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:13:08 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:52947 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCOPNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:13:07 -0400
X-Greylist: delayed 2023 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Mar 2018 11:13:07 EDT
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1ewTs6-0005bz-8x; Thu, 15 Mar 2018 15:28:46 +0100
Date:   Thu, 15 Mar 2018 15:28:43 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Miklos Vajna <vmiklos@collabora.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: submodule.<name>.ignore vs git add -u
Message-ID: <20180315142843.GA2103@book.hvoigt.net>
References: <20180312155924.elxjelkcriuwjdph@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312155924.elxjelkcriuwjdph@collabora.co.uk>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 12, 2018 at 04:59:25PM +0100, Miklos Vajna wrote:
> Let's say I have a fairly simple submodule setup where I do 'git
> checkout' inside the submodule to check out a different commit, so the
> outer repo 'git diff' shows a submodule update.
> 
> In that case
> 
>         git config submodule.<name>.ignore all
> 
> makes 'git diff' or 'git commit -a' ignore the change in the outer repo,
> but not 'git add -u'.
> 
> Reading the git-config documentation if this is intentional behavior,
> I'm a bit confused. It specifies that:
> 
> - "git status" and the diff family: handle this setting
> - git submodule commands: ignore this setting
> 
> So that about 'git add -u', is it expected that it ignores this setting
> as well?
> 
> I guess either the doc should say 'git add -u' doesn't handle this
> setting or 'git add -u' should handle it. Happy to try to make a patch
> that does the later, but I though better ask first. :-)

Have a look here for a previous discussion.

https://public-inbox.org/git/20131204221659.GA7326@sandbox-ub/

I think I never got around finishing those patches, because the
discussion died and there was no reply from the original poster asking
for this.

Maybe you could have a look at my original branch and whether that would
be the behavior you expect. I had a look into porting those patches to
the current master, but there are still some test failures.

You can see and test my current WIP branch here:

https://github.com/hvoigt/git/commits/hv/fix_ignore_all_submodules_update1

Cheers Heiko
