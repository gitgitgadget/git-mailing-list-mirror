X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 20:48:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 01:48:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31401>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk9t2-0006Gb-56 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 02:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966620AbWKOBsM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 20:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966622AbWKOBsM
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 20:48:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56802 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966620AbWKOBsK (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 20:48:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8R00BSR1094E40@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 20:48:10 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 14 Nov 2006, Jakub Narebski wrote:
> >
> >> The git interface refactoring should be I think the cause for git 2.0.0
> >> release...
> >
> > Good idea indeed.
> 
> We need to avoid user confusion, so making a command that used
> to do one thing to suddenly do something completely different is
> a no-no.  However, I do not think it needs to wait for 2.0.0.
> We can start with a separate namespace (or even a separate
> "Improved git UI project") and introduce the "improved UI set"
> in 1.5.0 timeframe.

Dunno.  I feel this is a bit overboard.  Actually the naming problem is 
rather localized to one command, namely git-pull.  In my opinion going 
with yet another namespace which would rather add to the confusion not 
clear it.

The best way to avoid user confusion is to remove the source of the 
confusion not let it live.  In other words I think we should _fix_ 
git-pull instead of replacing it.  People are already confused about it 
so simply fixing this command will have a net confusion reduction.  Yet 
we're not talking about "suddenly doing something completely different" 
either.  If git-pull doesn't merge automatically anymore it is easy to 
tell people to use git-merge after a pull.

"You pull the remote changes with 'git-pull upstream,, then you can 
merge them in your current branch with 'git-merge upstream'."

Isn't it much simpler to understand (and to teach) that way?

Also I don't think using git-upload and git-download is much better.  
This adds yet more commands that do almost the same as existing ones but 
with a different name which is yet not necessarily fully adequate.  I 
for example would think that "download" is more like git-clone than 
git-fetch or git-pull.

Let's face it: HG got it right with pull and push and newbies have much 
less difficulty grokking it.  We screwed it by not using the most 
intuitive semantic of a pull and locking the word "pull" away is not the 
better solution given all considerations. Why just not admit it and 
avoid being different than HG just for the sake of it?


