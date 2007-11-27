From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 00:07:41 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711262359080.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
 <20071127012518.GH14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 06:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwsfx-0001mr-K5
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 06:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXK0FHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 00:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXK0FHn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 00:07:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31506 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXK0FHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 00:07:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS500HOYFKUQK10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 00:07:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127012518.GH14735@spearce.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66166>

On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
> > (there was an alternate blob format that supported this,
> >  but it was deprecated).  Using the pack format for blobs
> > would fix this.  It would also mean blobs wouldn't need to
> > be uncompressed to get the blob type or size I believe.
> 
> The alternate format for loose objects *was* the packfile format,
> but without the packfile header or trailer as that was really
> quite unnecessary for a single object storage.

What I'm suggesting, though, is to actually create a real pack for those 
blobs where the recompression is really an issue.  all the code is 
there and only needs to be called.

In most usage cases, though, the proportion of blobs that gets copied 
directly into a pack  is minimal, and even then they don't amount to a 
lot of cycles compared to the majority of deltified objects.

(yeah, "deltified" is said to be wrong by some, but it is really 
 convenient a word.)

> I was sad when Nico removed the format in 726f852b0ed7e.  I can
> understand why he did so but I think it was a move in the wrong
> direction.

I wish I could convince you otherwise by now.


Nicolas
