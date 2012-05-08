From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Large repo and pack.packsizelimit
Date: Tue, 08 May 2012 17:52:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205081751011.21030@xanadu.home>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
 <20120508203137.GA15707@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205081709010.21030@xanadu.home>
 <20120508212012.GA20044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: th.acker66@arcor.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 23:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRsKo-00043S-VX
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 23:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab2EHVwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 17:52:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24598 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab2EHVwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 17:52:38 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3Q00BH44RPP070@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2012 17:52:37 -0400 (EDT)
In-reply-to: <20120508212012.GA20044@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197427>

On Tue, 8 May 2012, Jeff King wrote:

> On Tue, May 08, 2012 at 05:13:13PM -0400, Nicolas Pitre wrote:
> 
> > > This should be fixed in git. Unfortunately, I don't know that it is as
> > > trivial as just splitting the incoming stream; we would also have to
> > > make sure that there were no cross-pack deltas in the result.
> > 
> > IMHO this is the wrong fix.  The pack size limit was created to deal 
> > with storage media with limited capacity.  In this case, the repack 
> > process should be told to limit its memory usage, and pack-index should 
> > simply be taught to cope.
> 
> Hmm, you're right. I was thinking it helped to deal with memory
> addressing issues for 32-bit systems, but I guess
> core.packedGitWindowSize should be handling that. IOW, the 10G packfile
> should work just fine for normal access.
> 
> However, the OP did say he got an "out of memory" error during the
> clone. So maybe there is a problem to be fixed in index-pack there.

Was the OOM on the remote side (pack-objects) or on the local side 
(index-pack) ?


Nicolas
