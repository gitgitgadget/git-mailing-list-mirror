From: Nicolas Pitre <nico@cam.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 14:26:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091417490.28181@xanadu.home>
References: <11760951973172-git-send-email-nico@cam.org>
 <20070409171925.GS5436@spearce.org>
 <Pine.LNX.4.64.0704091059240.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hayaa-0004au-If
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXDIS1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbXDIS1J
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:27:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14452 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbXDIS1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:27:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8004LFTWISSF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 14:26:42 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704091059240.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44060>

On Mon, 9 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 9 Apr 2007, Shawn O. Pearce wrote:
> > 
> > I like this series.  I haven't had time to test it myself yet,
> > and probably won't be able to do so before Junio merges it into a
> > pu or next release.  But it looks OK on a first read.
> 
> Me too.. I just wonder whether it should have some more test coverage:
>  - force v2 index by default

Easy enough.  That's what I did for testing of course.  And I'd hope it 
would be always on by default eventually.  The only reason why it is not 
on by default is because of old clients with dumb protocols.

>  - force a mode where a random smattering of index entries are done using 
>    64-bit notation (even if they obviously won't need the high 33 bits)

That could be achieved with an additional criteria, like the offset's 
LSB value which should be pretty random.

Once Junio merges the series in a branch of its own, we could have a 
separate patch not in that branch that simply forces those features on 
in branch 'next'.  People would only need to remenber not publishing 
repos with that version using dumb protocols.


Nicolas
