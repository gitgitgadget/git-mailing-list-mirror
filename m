From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 23:56:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162352400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701161514.47908.jnareb@gmail.com>
 <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
 <200701162337.32759.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xE2-00069u-BU
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXAPW4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXAPW4Q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:56:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:57848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbXAPW4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:56:15 -0500
Received: (qmail invoked by alias); 16 Jan 2007 22:56:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 16 Jan 2007 23:56:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701162337.32759.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36979>

Hi,

On Tue, 16 Jan 2007, Jakub Narebski wrote:

> Nikolai Weibull wrote:
> > On 1/16/07, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> >> But I agree that XML is serious overkill...
> > 
> > I don't know if it was clear from my first mail, but I wasn't
> > suggesting --xml as a serious alternative.  My point was that if we're
> > going to go through all the fuss of adding all these switches for
> > outputting the configuration file in some fixed format, why not go
> > with one that at least is universal in some sense (not necessarily
> > XML).  And, as Johannes already pointed out, it's very disturbing
> > having to dump a configuration file so that it is more easily read by
> > other programs.  That would suggest that the ini-based format for
> > git's configuration file is suboptimal.
> 
> No, ini-based, or rather ini-like format for git configuration
> is nice,

Exactly.

> but I think git is too forgiving in accepting input. Examples: section 
> header and key/value pair in the same line, allowing multiple quotes in 
> in value part.

But this is nice to the user!

> Well, the idea I had was to have --dump switch to git-repo-config to 
> dump init file as if it was created by git-repo-config invocations, 
> without any hand editing (canonical format).

My point still stands: if you already parse the user-friendly format, why 
not dump a parse friendly format? If it weren't for those darn non-alnums 
in the keys, out put of "git repo-config -l" would be perfectly 
acceptable.

So, how about a "git repo-config --dump" which outputs a stream of NUL 
separated keys and values? This should be really easy to "parse", and 
there are no ambiguities: No key or value can contain a NUL.

Ciao,
Dscho
