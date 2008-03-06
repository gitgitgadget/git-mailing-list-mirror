From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 3/3] Teach git-fetch to exploit server side automatic tag following
Date: Wed, 5 Mar 2008 23:53:00 -0500
Message-ID: <20080306045300.GN8410@spearce.org>
References: <20080304032740.GC16462@spearce.org> <alpine.LSU.1.00.0803041512040.22527@racer.site> <20080305055659.GD8410@spearce.org> <alpine.LSU.1.00.0803051220360.18836@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 05:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX86y-00078q-8R
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbYCFExH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbYCFExF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:53:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35488 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYCFExE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 23:53:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JX865-0005sn-Hx; Wed, 05 Mar 2008 23:52:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 13B4420FBAE; Wed,  5 Mar 2008 23:53:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803051220360.18836@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76328>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 5 Mar 2008, Shawn O. Pearce wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  
> > > - should followtags not be the default?
> > 
> > No.  Absolutely not.
> > 
> > The client may not want tag objects from this remote.  It might not want 
> > those tags for all sorts of reasons.  Maybe they are doing a one-shot 
> > pull.  Maybe they don't trust this remote.  Maybe they trust this remote 
> > but this remote is famous for 192M tags containing PDFs of photo images 
> > of build logs printed out on paper, then photographed on a wood table 
> > and finally scanned in at 600 dpi.
> 
> Sorry, I meant to say: "should the followtags feature not be on by default 
> in the circumstances where we would follow tags anyway"...
> 
> Maybe you do that, but I did not see it.

Nope.  followtags should be on if the client wants tags, and off if
the client does not want tags.  Its that simple.  There's no reason
for the client to disable followtags if the server will actually
support it, as disabling it when you do have tags to follow will
only cost you extra net latency.

-- 
Shawn.
