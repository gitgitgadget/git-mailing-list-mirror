From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 11:12:20 -0800
Message-ID: <20090210191220.GT30949@spearce.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWy5M-0001dJ-TC
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbZBJTMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757038AbZBJTMW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:12:22 -0500
Received: from george.spearce.org ([209.20.77.23]:55719 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbZBJTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:12:21 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 028F038210; Tue, 10 Feb 2009 19:12:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902101226580.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109295>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> Actually, I went for the other end; I made close_pack_windows() not mind 
> the open windows (hey, it's dying anyway in my case, nobody's going to 
> write more), and the results passed verification and "git fsck --full" 
> with just a few dangling blobs and a dangling commit. So it seems to me 
> that it has to be wrong information in memory.

Like the wrong offset within the pack for the object start?

Can you compare the offsets you are getting during
unpack_delta_entry() against what verify-pack -v
shows for the same file?  They should agree, unless
we're somehow wrong in memory within fast-import.

But then, the output pack-*.idx file created when
fast-import closed the pack would be wrong too.

-- 
Shawn.
