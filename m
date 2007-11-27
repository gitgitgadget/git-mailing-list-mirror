From: Nicolas Pitre <nico@cam.org>
Subject: Re: Removing old data without disturbing tree?
Date: Tue, 27 Nov 2007 15:06:45 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711271459520.9605@xanadu.home>
References: <20071127193955.GA16585@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7F8-0005Ai-CW
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 21:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbXK0Uk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 15:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbXK0Uk6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 15:40:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25515 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982AbXK0Uk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 15:40:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS600FGRL79D1P0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 15:06:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127193955.GA16585@old.davidb.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66258>

On Tue, 27 Nov 2007, David Brown wrote:

> An upstream tree I'm mirroring with git-p4 has decided to start checking
> in large tarballs (150MB) periodically.  It's basically a prebuild version
> of some firmware needed to run the rest of the software.
> 
> Git doesn't seem to have any problem with these tarballs (and is using a
> lot less space than P4), but I have a feeling we might start running into
> problems when things get real big.  Does anyone have experience with packs
> growing beyong several GB?

It should just work.  It was tested with artificial data sets but that's 
about it.

Now if those tarballs are actually multiple revisions of the same 
package, you might consider storing them uncompressed and let Git delta 
compress them against each other which will produce an even more 
significant space saving.


Nicolas
