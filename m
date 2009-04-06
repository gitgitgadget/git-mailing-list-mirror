From: Nicolas Pitre <nico@cam.org>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 06 Apr 2009 12:55:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904061245111.6741@xanadu.home>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
 <20090406144047.GE23604@spearce.org>
 <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqs8Z-0006E1-PA
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbZDFQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZDFQzy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:55:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37897 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZDFQzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:55:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO00ESOV0Y7GP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 12:55:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115855>

On Mon, 6 Apr 2009, Klas Lindberg wrote:

> In the remote tree, the unnamed reference is either available or it
> isn't. If someone made an unnamed reference unreachable and then
> garbage-collected it, well so be it. Just tell the user that the
> reference can't be found and may in fact not exist at all and you're
> done. No exhaustive search necessary.

Why can't you simply fetch the remote from its branch tip and then 
figure out / checkout the particular unnamed reference you wish locally?

> I may later want to use that revision of the manifest to perform a 
> checkout on every component listed by the manifest. At that point I 
> expect all the work trees to have exactly the contents they "should" 
> have for that old version of the manifest. It's all about affordable 
> reproducibility.

Unlike with CVS/SVN, you don't need anything from the remote if you want 
to checkout an old version.  In particular, there is no need for you to 
only fetch that old version from the remote.  You just fetch everything 
from the remote and then checkout the particular old version you wish.  
There is just no real advantage to limit yourself to some old version 
from the remote repository because that's what you want locally.  Sure 
you might be getting more data than needed, but usually not that much 
due to git's good delta compression making extra versions almost free.


Nicolas
