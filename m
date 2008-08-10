From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sat, 9 Aug 2008 19:25:04 -0700
Message-ID: <20080810022504.GA22137@spearce.org>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at> <20080809220637.GA20963@localhost> <200808100014.13408.johannes.sixt@telecom.at> <20080809224150.GA21530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Aug 10 04:26:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS0dK-0000qh-Le
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 04:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYHJCZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 22:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbYHJCZG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 22:25:06 -0400
Received: from george.spearce.org ([209.20.77.23]:51639 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbYHJCZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 22:25:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1481F38420; Sun, 10 Aug 2008 02:25:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080809224150.GA21530@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91799>

Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Aug 10, 2008 at 12:14:13AM +0200, Johannes Sixt wrote:
> > > Currently you don't see the whole message anyways if the box is too small
> > > for the text. I find that quite annoying, especially since there are
> > > neither keys nor a scrollbar to scroll horizontally.
> > 
> > In this case, I use the middle mouse button to pan around. And then I do
> > see what I will get.
> 
> Ok, that's not bad. But nevertheless I think we should at least add a
> scrollbar.

I thought the scrollbar took up too much vertical space, so I did
not want to put in a horizontal scrollbar on a box that never should
require horizontal scrolling.  As Johannes points out...
 
> > The width of the box was chosen wisely: It takes a bit less than 80
> > columns, to leave room for quoting in emails and to avoid wrapping of git
> > log output.
> 
> Maybe I'm doing something wrong, but on my system (wish8.5) the box width
> changes with the window size, and gui.commitmsgwidth appears to be ignored.
> Even if I close and restart git gui, the old window size is kept.

That's a bug, and I now understand why you have a problem.  That box
should not be resizing itself.  Its supposed to be using a fixed
width font, and have a fixed number of columns, so you can format
a message including drawing ASCII art to explain yourself clearly
as you write a change.

I'll consider a patch that fixes the box so it doesn't resize under
8.5, but I won't apply one that applies virtual line wrapping as
then we lose the what-you-see-is-what-you-get property of the editor,
and that is a very important property for git-gui users.

-- 
Shawn.
