X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git newbie problems
Date: Wed, 6 Dec 2006 17:19:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612061637130.20138@iabervon.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
 <457611B9.9020907@gmail.com> <7v4ps9byca.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 22:20:02 +0000 (UTC)
Cc: Graham Percival <gpermus@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v4ps9byca.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33530>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs57J-0001tA-5X for gcvg-git@gmane.org; Wed, 06 Dec
 2006 23:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937713AbWLFWTd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 17:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937725AbWLFWTc
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 17:19:32 -0500
Received: from iabervon.org ([66.92.72.58]:4116 "EHLO iabervon.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937713AbWLFWTb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 17:19:31 -0500
Received: (qmail 22353 invoked by uid 1000); 6 Dec 2006 17:19:29 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 6
 Dec 2006 17:19:29 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 5 Dec 2006, Junio C Hamano wrote:

> For new people, we recommend to:
> 
>  * make sure you were on a right branch (I think you are.  You
>    are on your 'master' branch and may not even have any other
>    branches, which is fine.)
> 
>  * make sure all your changes are committed.
> 
> before initiating a "git pull".  And after a conflicted "git
> pull", if you choose to punt,
> 
> 	$ git reset --hard
> 
> would take you back to the state before you started the pull.

If there are uncommitted changes, and there are conflicts, shouldn't it 
leave you in the state before the pull, especially if the uncommitted 
changes conflict with the merge? Git has determined that it can't present 
all of the conflicts to the user, so the user can't possibly resolve all 
of the conflicts, except by discarding new work or pushing it into the 
merge inappropriately. 

I think that a lot of new users will pull with uncommitted changes, and 
they'd benefit from just being told that you're supposed to commit first 
and then merge. It should definitely roll back perfectly to the state 
before the pull if it wasn't able to present all the conflicts, since even 
somebody who knows what's going on is going to have to roll back here.

Possibly there should even be an option (defaulting to true) which 
completely blocks "pull" with uncommitted changes. Even if the in-index 
merge works (and the working directory is entirely unneeded), it's pretty 
likely that the user would do better to be in the habit of doing it in the 
other order anyway.

	-Daniel
