From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 22:58:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192256480.5731@racer.site>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org>
 <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMeK-0001gO-VW
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 23:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbYASW6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 17:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbYASW6Y
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 17:58:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:54684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752900AbYASW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 17:58:23 -0500
Received: (qmail invoked by alias); 19 Jan 2008 22:58:21 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 19 Jan 2008 23:58:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZBJ5pkJfZHIGg+DS0Y+gcBA9MWl4kP0ctKTPVzp
	6HzFyOW8ZkUoNl
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71138>

Hi,

On Sat, 19 Jan 2008, Linus Torvalds wrote:

> On Sat, 19 Jan 2008, Dmitry Potapov wrote:
> > 
> > Actually, there is, if you care to do something. You can write a 
> > wrapper around readdir(3) that will recodes filenames in Unicode 
> > Normal Forms C.
> 
> If somebody wants to do this, then readdir() isn't the only place, but 
> yes, readdir() is one of the places.
> 
> I suspect that if we were to just do the "turn into NFC on readdir() on 
> OS X", that might actually be good enough to hide most of the problems.

I think a better approach would be to try to match the name to what we 
have in the index.  Then we could implement case-insensitivity and MacOSX 
workaround at the same time.

Ciao,
Dscho
