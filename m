From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook script)
Date: Tue, 3 Jul 2007 10:55:52 -0400
Message-ID: <20070703145552.GG4495@spearce.org>
References: <11831937823982-git-send-email-sam.vilain@catalyst.net.nz> <1183193782172-git-send-email-sam.vilain@catalyst.net.nz> <11831937822249-git-send-email-sam.vilain@catalyst.net.nz> <11831937823756-git-send-email-sam.vilain@catalyst.net.nz> <11831937822950-git-send-email-sam.vilain@catalyst.net.nz> <11831937823588-git-send-email-sam.vilain@catalyst.net.nz> <1183193782608-git-send-email-sam.vilain@catalyst.net.nz> <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net> <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:56:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jng-00064Y-Nf
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbXGCO4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbXGCO4R
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:56:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47748 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbXGCO4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:56:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I5jnF-0007hV-Mp; Tue, 03 Jul 2007 10:55:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 03DB420FBAE; Tue,  3 Jul 2007 10:55:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51503>

Nicolas Pitre <nico@cam.org> wrote:
> And even if your developers are completely inept to the point of not 
> wanting to run 'git gc' once a week for example, or once a day if 
> they're otherwise really really productive, I'm sure you can automate 
> some of that maintenance asynchronously from a simple post commit hook 
> or something, based on the output of 'git count-objects -v'.

Yea, you need not just the loose object count but also the number
of packfiles.  git-gui suggests repacking based on loose object
count alone right now, but with us keeping fetched packfiles by
git-index-pack I found a repository on my desktop the other day
that had 30 packfiles in it.  I need to fix that in git-gui and
also add a limit based on the number of small-ish packfiles present.

BTW, I have some users that might as well be Aunt Tillie.  They
merge any branch they can find.  "Oh, look, there's a new branch
called Highly-Experimental!  I'll bet that's good for merging too!"

Asking them to also run git-gc once in a while is like asking them
to actually do their job or something...  *sighs* OK, I have to go
to work and undo that Highly-Experimental merge I found last night.
*sigh*
 
-- 
Shawn.
