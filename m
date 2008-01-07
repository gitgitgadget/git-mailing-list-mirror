From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 13:36:45 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801071332530.3148@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzfM-0002Ni-Vx
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168AbYAGVhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760162AbYAGVhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:37:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60312 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760144AbYAGVhY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2008 16:37:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m07LajM1007813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jan 2008 13:36:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m07LajuT013363;
	Mon, 7 Jan 2008 13:36:45 -0800
In-Reply-To: <200801072203.23938.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69813>



On Mon, 7 Jan 2008, Robin Rosenberg wrote:
> 
> Indeed, but the most common SCM's detect binary files automatically, 
> either by suffix  or content analysis, so I think that is what user's expect.
> It will be right for more projects that the current behaviour.

Yeah, I suspect it's not only the "expected" behavior, but people have had 
years of getting used to the whole binary issue, and are much more likely 
to expect binary corruption than to expect to have to worry about CRLF.

And while it's true that it probably doesn't matter at all as long as you 
stay windows-only (and everything is CRLF), it's also true that (a) maybe 
you don't necessarily even know that some day you might want to cast off 
the shackles of MS and (b) even under Windows you do end up having some 
strange tools end up using LF (ie you may be using some tools that were 
just straight ports from Unix, and that write just LF).

So defaulting to (or asking) "autocrlf" at install time is probably the 
safest thing, and then people can edit their global .gitconfig to turn it 
off.

			Linus
