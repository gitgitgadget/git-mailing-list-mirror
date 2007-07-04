From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Wed, 04 Jul 2007 11:42:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707041127130.26459@xanadu.home>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
 <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net>
 <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
 <468AE462.1040202@vilain.net> <Pine.LNX.4.64.0707040155240.4071@racer.site>
 <468B3B42.2040103@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 17:42:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6703-0006wh-6N
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 17:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbXGDPmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbXGDPmZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 11:42:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35884 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbXGDPmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 11:42:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKN00D35VMMM720@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Jul 2007 11:42:22 -0400 (EDT)
In-reply-to: <468B3B42.2040103@vilain.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51620>

On Wed, 4 Jul 2007, Sam Vilain wrote:

> Johannes Schindelin wrote:
> >>>> 1. Do you agree that some users would want their git repositories to be
> >>>> "maintenance free"?
> >>> I'm not so sure.
> >> Well, no offence, but I think you should withhold from voicing a
> >> fundamental concern as this, because you're not one of its target users.
> > Let's put it this way. A lot of car drivers would probably agree that it 
> > is a Good Thing (tm) if their car automatically went to get gas, before it 
> > ran out of it. Less hassle, right?
> > 
> > Yes, except if your car decides to get gas when you are already late, 
> > speeding, trying to catch your plane.
> 
> Ok, but if you're only packing a few hundred objects it usually won't
> matter because it is fast enough that you hardly notice.

... in which case you might as well keep them loose too.

> And if you don't like it, you turn it off, or don't turn it on.

You seem to forget the maintenance cost of having this in the Git 
distribution.  When something is merged in, it has to be maintained and 
kept working.  Given the complexity of your proposal weighted against 
the relative benefits I remain unconvinced.

Yet you didn't state what exactly is the issue you're trying to solve.  
If it is only to avoid running "git gc" occasionally then this clearly 
isn't a benefit worth the cost.

If, instead, you implement it as a post-commit or post-receive hook 
meant for contrib/hooks/ then I wouldn't have any issue with that.


Nicolas
