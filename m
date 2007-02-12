From: Nicolas Pitre <nico@cam.org>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 16:33:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702121629270.1757@xanadu.home>
References: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
 <20070212051108.GB699@spearce.org>
 <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com>
 <Pine.LNX.4.64.0702121013150.1757@xanadu.home>
 <20070212193507.GA18730@thunk.org> <7vd54f85du.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGinQ-0007DY-HV
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965407AbXBLVdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbXBLVdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:33:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49177 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbXBLVdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:33:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDD00DEXD766K00@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Feb 2007 16:33:06 -0500 (EST)
In-reply-to: <7vd54f85du.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39441>

On Mon, 12 Feb 2007, Junio C Hamano wrote:

> Older clients do not understand the more efficient packfile format 
> (delta-base-offset encoding) that can be used with recent git.  The 
> feature is not turned on by default and is controlled by configuration 
> repack.usedeltabaseoffset. Whoever does the "git repack" above should 
> make sure he does not enable it with his $HOME/.gitconfig.

Of course, if we don't care about old GIT client using HTTP transport, 
then enabling this option won't affect GIT client using the native 
protocol as the delta-base-offset encoding can be translated into the 
legacy encoding on the fly depending on the client's advertized 
capabilities.


Nicolas
