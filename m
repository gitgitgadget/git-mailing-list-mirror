X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Stop telling users we are 'defaulting to local storage
 area'.
Date: Thu, 14 Dec 2006 21:18:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
References: <20061214230902.GA26506@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 02:18:44 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061214230902.GA26506@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34460>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2eo-0002Zc-Uj for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964997AbWLOCSj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWLOCSj
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:18:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44916 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964997AbWLOCSi (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:18:38 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA00D7MMF1SQA0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 21:18:37 -0500 (EST)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn O. Pearce wrote:

[...]
> It also breaks from our normal behavior of not printing
> anything if the command was successful.

Before everybody starts believing  everybody agrees with this I'll have 
to throw a tile in the pond.

I really don't think this is a good rule.

NOte that I'm not against commands that are silent by default.  I really 
think that git-add should remain silent on success by default when 
successful.

But the rule of thumb should be about the importance of the action 
performed by the command.  git-add is a less important command than 
git-init-db or git-commit _conceptually_.  You can do multiple git-add 
in whatever order, even repeatedly, and it won't change the outcome.  
It is "conceptually lightweight".  But git-init-db is really important.  
Without it you just can't do anything. It should give the user the 
impression that something did actually happen, especially since this is 
the git comand any new git user is most likely to use first.  Saying 
back "git repository initialized" tells the user "OK you can start now".  
Saying nothing might just leave the user wondering if everything is 
actually fine.


