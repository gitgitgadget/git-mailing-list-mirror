Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3813C20248
	for <e@80x24.org>; Sat,  9 Mar 2019 10:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCIKsO (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 05:48:14 -0500
Received: from ikke.info ([178.21.113.177]:36878 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfCIKsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 05:48:14 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 887E94400CB; Sat,  9 Mar 2019 11:48:12 +0100 (CET)
Date:   Sat, 9 Mar 2019 11:48:12 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git MUST notify user when files will be deleted or overwritten
 by command
Message-ID: <20190309104812.GA3403@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <SYXPR01MB09577F5C4555C9068B606E11DD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYXPR01MB09577F5C4555C9068B606E11DD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 10:19:03AM +0000, Dimitri Joukoff wrote:
> Hi,
> 
> As a relatively novice user of git, there have been far too many times
> that I have lost data, sometimes quite a lot.  So this proposal is about
> catering for the less experienced users and averting fits of anger and
> frustration.  The only reason my computer still works is because my
> sub-conscious mind stops me from smashing it or throwing it against a
> wall.  It seems my sub-conscious mind has a pragmatic view of the world
> and understands that whilst I may receive instantaneous satisfaction at
> the time, in the long term, the pain will be far worse, and thus
> prevents me from doing something rash.
> 

Yes, it can be very frustrating to lose things you did not intend to
lose, so making sure your tooling limits the chances of that happing is
certainly a worthwile goal.

> 
> Below is the detail of my proposal: > 
> Whenever a command is issued in git that will cause git to overwrite or
> delete *ANY* files whose current state isn't already recorded in the
> repository, git should prompt the user to confirm the operation. This
> includes untracked files as well as files that are in the 'not staged'
> and 'staged' lists.
> 
> To make the consequences of the command transparent, the confirmation
> should include a list of files that will be affected (perhaps in a
> similar way to how git status works).  The scope of the files listed
> must match the scope of the command to be executed.  No hidden changes,
> no side-effects.
> 
> Saying no to the confirmation should abort the command.
> 
> It may be useful to allow confirmation of individual files, but as a
> novice user, I can't argue this point objectively, nor reason about its
> implications and complexity.
> 
> This feature should be enabled by default whenever a clone or init
> operation are performed.
> 
> The user should be able to progressively reduce the range of commands
> and amount of confirmation interactions that take place.  The
> configuration technique could follow the already established procedure
> for other configurable data in git.  So this could be done globally for
> the user, or locally within each repository.
> 
> 
> As a novice user, there may be further useful extensions of this idea,
> about which I'm unable to reason.  So I welcome further elaboration of
> the idea discussed above.
> 
> 
> Best regards,
> Dimitri.
> 

A lot of confirmations only result in people automatically dismissing
them (confirmation saturation), missing the goal of what you intend.

Instead of asking for confirmation, it's much better to allow people to
undo these mistakes. You see the same pattern in gmail for example,
where they hardly ask you for any confirmation, but instead show an undo
button that allows you to undo the last operation. In my opinion this is
a better way to go then to add confirmations everywhere.

I know this has come up on the git mailing list more often, but I cannot
find a relevant thread at this moment.

Kevin
