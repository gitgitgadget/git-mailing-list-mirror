From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 19:35:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271929480.3366@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
 <20070527033429.GY28023@spearce.org>
 <alpine.LFD.0.99.0705271110550.3366@xanadu.home>
 <20070527215245.GD28023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 28 01:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsSH0-000581-1e
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbXE0Xf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXE0Xf0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:35:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22732 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbXE0Xf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:35:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIQ00DPV46TNXC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 19:35:17 -0400 (EDT)
In-reply-to: <20070527215245.GD28023@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48598>

On Sun, 27 May 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > BTW I think the Newton-Raphson based index lookup approach should be 
> > revived at some point.
> 
> That doesn't help with 10 packfiles though, does it?

It helps irrespective of the number of pack files.  With the current 
binary search the lookup cost is O(log n).  With a Newton method this 
cost is almost O(1).  If you have 10 pack files then you may have to do 
5 separate lookups on average, but those lookups are still faster with a 
Newton method.


Nicolas
