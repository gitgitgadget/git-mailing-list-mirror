From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: 16 gig, 350,000 file repository
Date: Mon, 22 Feb 2010 17:31:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221725380.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
 <19325.40682.729141.973125@blake.zopyra.com>
 <alpine.LFD.2.00.1002181556320.1946@xanadu.home>
 <19331.792.84192.53690@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgoE-0008En-TD
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab0BVWbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:31:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40030 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab0BVWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:31:17 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY9009ELL84E8Q0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 17:31:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <19331.792.84192.53690@blake.zopyra.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140723>

On Mon, 22 Feb 2010, Bill Lear wrote:

> On Thursday, February 18, 2010 at 15:58:42 (-0500) Nicolas Pitre writes:
> >On Thu, 18 Feb 2010, Bill Lear wrote:
> >
> >> I'm starting a new, large project and would like a quick bit of advice.
> >> 
> >> Bringing in a set of test cases and other files from a ClearCase
> >> repository resulted in a 350,000 file git repo of about 16 gigabytes.
> >> 
> >> The time to clone over a fast network was about 250 minutes.  I could
> >> not verify if the repo had been packed properly, etc.
> >
> >I'd start from there.  If you didn't do a 'git gc --aggressive' after 
> >the import then it is quite likely that your repo isn't well packed.
> >
> >Of course you'll need a big machine to repack this.  But that should be 
> >needed only once.
> 
> Ok, well they have a "big machine", but not big enough.  It's running
> out of memory on the gc.  I believe they have a fair amount of memory:
> 
> % free
>              total       used       free     shared    buffers     cached
> Mem:      16629680   16051444     578236          0      28332   14385948
> -/+ buffers/cache:    1637164   14992516
> Swap:      8289500       1704    8287796
> 
> and they are using git 1.6.6.

Hmmm. OK.

You might try:

	git repack -a -f -d --depth=200 --window=100 --window-memory=1g


Nicolas
