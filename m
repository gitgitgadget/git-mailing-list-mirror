From: Jeff King <peff@peff.net>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 11:53:44 -0500
Message-ID: <20080121165343.GA12308@sigill.intra.peff.net>
References: <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGzub-00032t-5V
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbYAUQxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYAUQxr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:53:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2998 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbYAUQxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:53:46 -0500
Received: (qmail 26875 invoked by uid 111); 21 Jan 2008 16:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 21 Jan 2008 11:53:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 11:53:44 -0500
Content-Disposition: inline
In-Reply-To: <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71294>

On Mon, Jan 21, 2008 at 11:43:54AM -0500, Kevin Ballard wrote:

> I agree. Every single problem that I can recall Linus bringing up as a  
> consequence of HFS+ treating filenames as strings is in fact only a  
> problem if you then think of the filename as octets at some point. If you 
> stick with UTF-8 equivalence comparison the entire time, then everything 
> just works.

Git's data model relies on SHA-1 hashing of data, including filenames.
So at some level, git _has_ to treat data as octets, and "equivalent"
strings must be the same at the octet level (or else you lose all of the
useful properties that the hashing data model provides). You can argue
about where in the program conversion and normalization occur, but I
don't think you can get around the fact that you're going to need
to think of the "filename as octets at some point."

-Peff
