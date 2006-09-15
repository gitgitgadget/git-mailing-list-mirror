From: Nicolas Pitre <nico@cam.org>
Subject: Re: Historical kernel repository size
Date: Fri, 15 Sep 2006 12:45:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609151232370.2627@xanadu.home>
References: <20060914142249.GK23891@pasky.or.cz>
 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
 <1158269854.5724.240.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609141742000.2627@xanadu.home>
 <1158270859.5724.244.camel@localhost.localdomain>
 <1158272651.5724.251.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609142115560.2627@xanadu.home>
 <20060915090305.GC75256@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 15 18:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOGpD-0006uc-5V
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 18:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWIOQpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 12:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWIOQpz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 12:45:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55502 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750741AbWIOQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 12:45:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5N001UJ7WHZZX0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 15 Sep 2006 12:45:53 -0400 (EDT)
In-reply-to: <20060915090305.GC75256@dspnet.fr.eu.org>
X-X-Sender: nico@xanadu.home
To: Olivier Galibert <galibert@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27091>

On Fri, 15 Sep 2006, Olivier Galibert wrote:

> On Thu, Sep 14, 2006 at 09:19:04PM -0400, Nicolas Pitre wrote:
> > Erm... Both incantations work fine fine here.
> > 
> > > -rw-rw-r-- 1 tglx ftpadmin  13600376 Sep 14 22:16 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
> > > -rw-rw-r-- 1 tglx ftpadmin 158679705 Sep 14 22:16 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack
> > 
> > And I get the same result as well.
> 
> For the curious, a 100/100 parameter gives a size of 154261771.

Right.   And then the runtime cost of extracting objects out of such a 
pack increases due to the deeper delta chain.

The average runtime cost is probably linear with the delta depth, 
something like f(x) = a*x + k.

But the size reduction follows f(x) = a/x + k.

So to say that infinite delta length does not provide infinite packing 
size reduction. Anything larger than 50 is probably not worth the 
small reduction gain.


Nicolas
