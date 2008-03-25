From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 10:46:46 -0300
Message-ID: <47E90246.3030509@intelinet.com.br>
References: <20080324092726.GQ8410@spearce.org> <47E8889E.6090403@intelinet.com.br> <20080325053649.GE4759@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 14:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je9Y0-0007CX-8y
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 14:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbYCYNt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbYCYNt6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 09:49:58 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1442 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754724AbYCYNt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 09:49:57 -0400
Received: (qmail 38627 invoked by uid 0); 25 Mar 2008 10:52:16 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.013538 secs); 25 Mar 2008 13:52:16 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 25 Mar 2008 13:52:16 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080325053649.GE4759@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78187>


Shawn O. Pearce escreveu:
> Hmm.  How long does C Git take for "git rev-list HEAD >/dev/null" ?
> I have thus far only tuned the lower level machinary, and there
> may still be tuning left there, but I _really_ have not tried to
> tune the plotting portion yet.
>   
I'll do that when I get back home, but I think it should be fast. At 
least gitk was showing the repo fast enough, from calling it from the 
command line and gitk stoping visible activity, I'd say around 2 or 3 
seconds.

Maybe my problem was with the plotting part. I was running on linux.

> Another thing is how many pack files/loose objects do you have?
> The loose objects are harder to access, and jgit is currently
> lacking some of the pack search tricks that C Git uses to get
> good performance.  As such all of my testing has been working on
> a fully packed repository that has exactly one packfile in it,
> with no alternates.
>   
I made a clone of it and never changed it. Don't recall making fetches 
either, so it should be in good shape. I can confirm later.

> Oversight/planned loss of feature.  I'm a strong believer of showing
> the commit message *exactly* as recorded, which means don't do
> line wrapping of it.  Things like character encoding translation
> and indenting the left side 2-4 spaces to keep it unambiguous from
> headers is fine when showing it to a human, but otherwise it should
> match what the user wrote.
>
> I forgot to offer a wrap option.  If we do enable line wrapping I
> think we should give the user a way to toggle it on/off for the
> message area viewer so that if line wrapping is enabled and its
> borking the current message (e.g. a nice pretty ASCII diagram)
> you can disable it.
>   
I understand that you guys use a lot of ASCII art and wrapping can mess 
this. But here we track more things in bugzilla and there's some 
copy&pasting going on, so wrapping makes comments more readable. 
Currently it's a toogle preference in the local toolbar menu (like the 
CVS plugin).

I left the comment on the right side because it's easy to set/unset 
wrapping for the whole viewer, and also for consistency with the CVS/SVN 
plugins, I still use them :)

My last patches also added the changed files in the left pane as text. 
The next step would be to add links. Before doing this I thought about 
adding a table there (like what you did) but I chose text with links 
because of copy&paste, I find it convenient to paste selected commit 
info into IM or email.

[]s,
Roger.
