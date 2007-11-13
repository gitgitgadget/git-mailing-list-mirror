From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 08:53:41 +0100
Message-ID: <20071113075341.GN2261MdfPADPa@greensroom.kotnet.org>
References: <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
 <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0711122238330.2786@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711122309270.2786@woody.linux-foundation.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irqau-0005q4-4i
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXKMHxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXKMHxo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:53:44 -0500
Received: from psmtp08.wxs.nl ([195.121.247.22]:42184 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbXKMHxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:53:44 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JRF00MY6PXIGD@psmtp08.wxs.nl> for git@vger.kernel.org; Tue,
 13 Nov 2007 08:53:42 +0100 (MET)
Received: (qmail 27436 invoked by uid 500); Tue, 13 Nov 2007 07:53:41 +0000
In-reply-to: <alpine.LFD.0.9999.0711122309270.2786@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64763>

On Mon, Nov 12, 2007 at 11:16:08PM -0800, Linus Torvalds wrote:
> On Mon, 12 Nov 2007, Linus Torvalds wrote:
> > 
> > I think the real problem is that "TREECHANGE" has the wrong polarity. It 
> > should default to always being set, and then we could actively clear it 
> > when we do the work to say "it's the same tree". Instead, we default it to 
> > being the same (which triggers parent rewriting), and only later may we 
> > notice that it wasn't the same.
> 
> So, maybe the proper solution is to say "commits are assumed to be 
> different to their parents, but we have an explicit bit saying TREESAME 
> when we find them to be the same".

FWIW, I like it.

I had basically the same patch in my git-rewrite-commits series
(except that I called it "PRUNED" instead of "TREESAME"), but I
don't think I even sent it to the list, because I was told there
was no use.

skimo
