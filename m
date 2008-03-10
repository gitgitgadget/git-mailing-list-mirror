From: Roger Carneiro Soares <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Branch bar in resource history.
Date: Mon, 10 Mar 2008 01:13:40 -0400
Message-ID: <47D4C384.3030703@intelinet.com.br>
References: <1204954828-3937-1-git-send-email-rogersoares@intelinet.com.br> <200803100100.28927.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dave Watson <dwatson@mimvista.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 04:16:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYYVE-0002Ot-Kn
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 04:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYCJDPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 23:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYCJDPg
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 23:15:36 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1169 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751525AbYCJDPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 23:15:36 -0400
Received: (qmail 96612 invoked by uid 0); 10 Mar 2008 00:16:37 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.364469 secs); 10 Mar 2008 03:16:37 -0000
Received: from unknown (HELO casa.com) (189.5.203.240)
  by cvxbsd.convex.com.br with SMTP; 10 Mar 2008 03:16:36 -0000
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <200803100100.28927.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76693>

Hi Robin,

> Good idea, but I wonder if we wouldn't be better off trying too keep compact
> and do this decoration in the first bar instead, either as an icon or just 
> text. I only have 15 inches of preciousss screen space. Compare to what you 
> did with the compare view in removing those unnecessary directory levels that
> really only wasted space. That was very good.
>   
My first attempt was to put the current branch name in the first bar, 
before the path, like:
[mybranch]/myproject

But from what I noticed after a little debuging, the history page API 
doesn't allow us to change this value, probably because of the "Show 
Previous Histories" where this value is also stored. We would need to 
change parent classes to make it possible.

I also tried to add the branch name as an icon, but I didn't really like 
it there. In the end I accepted to lose some space, especially because 
when I'm searching for something I end up maximizing the history page. 
And I also started thinking about other uses for it, to convince me that 
another bar there could have some use :)
. maybe put the SHA1 there, like in gitk.
. show the bar in a different color when some filter is applied to help 
avoid confusion when you don't see a commit there.
. put a trail for some common operation.

but, unless someone really sees the need for something, I'm not 
seriously considering any of it right now...

Another attempt I made was to put a vertical bar on the left, but it 
would require the installation of some extra eclipse package to write 
the text in the vertical. I saw that eclipse can also use the java 
graphics api to render things, so if people think it would be the best 
option, I can give it a try.


> Another idea would be to allow the user to filter which branches and I think
> one could combine this indicator with that functionality through e.g. a poup 
> menu. 
>   
This would be really nice :)

Some time ago I wrote a quick hack to show only the commits in the 
current branch and it's been very useful for us. It isn't implemented 
the proper way but I consider it simple and safe and others may find it 
useful too... I'll review it later and post a patch for you to decide.

> The green color on the indicator sugests something is "ok"?
>   
It was my attempt to make a branch icon following eclipse guidelines :) 
It will be more obvious when we have the "list references" icon (get a 
look on gitk: file->list references). It was intended as an icon to 
designate branch.

[]s,
Roger.
