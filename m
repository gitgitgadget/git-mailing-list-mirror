From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fast-import
Date: Mon, 05 Feb 2007 23:06:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 05:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEHbJ-0003p7-UV
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 05:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbXBFEGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 23:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXBFEGc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 23:06:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbXBFEGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 23:06:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD00055MWQNLDB2@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Feb 2007 23:06:24 -0500 (EST)
In-reply-to: <20070206023111.GB9222@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38807>

On Mon, 5 Feb 2007, Shawn O. Pearce wrote:

> I'm particularly interested in feedback on the documentation,
> so I am attaching it below.
> 
[...]
> 
> The time of the change is specified by `<time>` as the number of
> seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> written in base-10 notation using US-ASCII digits.  The committer's
> timezone is specified by `<tz>` as a positive or negative offset
> from UTC, in minutes.  For example EST would be expressed in `<tz>`
> by ``-0500''.

I think this is quite error prone, demonstrated by the fact that we 
screwed that up ourselves on a few occasions.  I think that the frontend 
should be relieved from this by letting it provide the time of change in 
a more natural format amongst all possible ones(like RFC2822 for 
example) and gfi should simply give it to parse_date().

Otherwise I think this is pretty nice.


Nicolas
