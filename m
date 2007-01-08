From: Nicolas Pitre <nico@cam.org>
Subject: Re: How git affects kernel.org performance
Date: Mon, 08 Jan 2007 09:46:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701080943191.4964@xanadu.home>
References: <20061216094421.416a271e.randy.dunlap@oracle.com>
 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
 <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <m3odpazxit.fsf@defiant.localdomain>
 <20070107203120.GA4970@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Krzysztof Halasa <khc@pm.waw.pl>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751561AbXAHOqn@vger.kernel.org Mon Jan 08 15:47:03 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751561AbXAHOqn@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3vm6-0007sS-AA
	for glk-linux-kernel-3@gmane.org; Mon, 08 Jan 2007 15:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXAHOqn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 8 Jan 2007 09:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbXAHOqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:46:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58188 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXAHOqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:46:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBK008UH11TA430@VL-MH-MR001.ip.videotron.ca>; Mon,
 08 Jan 2007 09:46:41 -0500 (EST)
In-reply-to: <20070107203120.GA4970@spearce.org>
X-X-Sender: nico@xanadu.home
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36266>

On Sun, 7 Jan 2007, Shawn O. Pearce wrote:

> Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > Hmm... Perhaps it should be possible to push git updates as a pack
> > file only? I mean, the pack file would stay packed = never individual
> > files and never 256 directories?
> 
> Latest Git does this.  If the server is later than 1.4.3.3 then
> the receive-pack process can actually store the pack file rather
> than unpacking it into loose objects.  The downside is that it will
> copy any missing base objects onto the end of a thin pack to make
> it not-thin.

No.  There are no thin packs for pushes.  And IMHO it should stay that 
way exactly to avoid this little inconvenience on servers.

The fetch case is a different story of course.


Nicolas
