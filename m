From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 12:12:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com>
 <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com>
 <20070115112635.GA5134@localdomain> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
 <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 12:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mFL-0005UX-Ik
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXAPLMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbXAPLMs
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:12:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:55642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbXAPLMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:12:48 -0500
Received: (qmail invoked by alias); 16 Jan 2007 11:12:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 16 Jan 2007 12:12:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36927>

Hi,

On Tue, 16 Jan 2007, Junio C Hamano wrote:

> "Nikolai Weibull" <now@bitwi.se> writes:
> 
> > If we're going down this slippery slope, why not just give up and add
> > a --xml switch instead?  Readable by all...
> 
> Perhaps all except humans.
> 
> At least YAML, please...

I am _strongly_ opposed to all that rubbish. _If_ we want to use 
repo-config to preformat the config variables, we should either

1) just use "git repo-config -l" and STFU, or
2) introduce something like "--dump" which Eric implemented.

Everything else is just _complicating_ matters, and for _what_? _Nothing_ 
at all. If we use repo-config for that task, it should cater for parsing 
by _script languages_, not _users_.

I work with XML everyday. It has its uses. But this here problem is _not_ 
one of them. How silly would that be: we parse an easy-to-read format, 
munge the easy-to-handle internal data format into another "easy-to-read" 
format which is then parsed by a script language into an easy-to-handle 
internal data format? No. NO.

Ciao,
Dscho

P.S.: The more I think about it, we should just use the output of 
"repo-config -l".
