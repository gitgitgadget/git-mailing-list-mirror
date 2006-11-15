X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 15:15:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151501590.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151000460.2591@xanadu.home>
 <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
 <200611151902.16358.andyparkins@gmail.com>
 <7vr6w4lcpr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 20:15:37 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vr6w4lcpr.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31481>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRAT-0005PT-5E for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030953AbWKOUPa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030954AbWKOUPa
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:15:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55762 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030953AbWKOUP3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:15:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00AFLG9SK390@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 15:15:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Junio C Hamano wrote:

> If we had a separate Porcelain namespace (say "ng" for "new
> git") you would know "ng-commit" is not a Plumbing and when you
> are writing a Porcelain script you would stay away from using it
> in your script.

There is merit in trying to segregate porcelain vs plumbing... at least 
in theory.  In practice though I don't think this is something we should 
absolutely strive for.

Why? Because something is always going to fail the categorization.  
Sure there are commands that are pure plumbing like git-commit-tree, 
etc.  Some are pure porcelain like git-commit or git-log.  Yet we use 
git-log's output for git-shortlog.  Does it mean that git-log is 
plumbing? Also I have a script here that uses git-commit directly 
because it is so much convenient rather than futzing with the really 
bare plumbing.  I don't think git-commit should be prevented from being 
used within another script even if it is classified as porcelain.

So we have that notion of plumbing vs porcelain but in practice there is 
a whole spectrum between those two poles and I think it is a good thing.


