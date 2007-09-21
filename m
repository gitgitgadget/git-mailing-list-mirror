From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 09:22:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
 <Pine.LNX.4.64.0709211208440.28395@racer.site>
 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYiT3-0005gW-Qk
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbXIUNWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXIUNWo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:22:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30539 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXIUNWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 09:22:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JOP005W9ZTSY3K0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Sep 2007 09:22:40 -0400 (EDT)
In-reply-to: <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58848>

On Fri, 21 Sep 2007, Peter Stahlir wrote:

> This is was I was looking for. My motivation is whether it is possible
> to run a system, for example Debian on a computer on top of gitfs,
> and then have a huge mirror on it, for example a complete 252GB
> Debian mirror as space efficient as possible.
> 
> I wonder how big a deltified Debian mirror in one pack file would be. :)

It would be just as big as the non gitified storage on disk.

The space saving with git comes from efficient delta storage of 
_versioned_ files, i.e. multiple nearly identical versions of the same 
file where the stored delta is only the small difference between the 
first full version and subsequent versions.  Unless you plan on storing 
many different Debian versions together, you won't benefit from any 
delta at all. And since Debian packages are already compressed, git 
won't be able to compress them further.

So don't waste your time.


Nicolas
