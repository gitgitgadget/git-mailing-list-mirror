From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 18:20:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241817240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78C55.2030204@zytor.com> <ep83m2$mts$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 18:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lnk-0000QY-Oo
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbXAXRUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXAXRUo
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:20:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:40565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbXAXRUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:20:44 -0500
Received: (qmail invoked by alias); 24 Jan 2007 17:20:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 24 Jan 2007 18:20:41 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ep83m2$mts$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37660>

Hi,

On Wed, 24 Jan 2007, Jakub Narebski wrote:

> H. Peter Anvin wrote:
> 
> > Johannes Schindelin wrote:
> >> 
> >> Granted, for some things this might work. However, I would not wreak havoc 
> >> by changing the format of .git/info/refs, rather put the details you 
> >> wanted into .git/info/refs-details.
> > 
> > It's not clear to me if it would be wrecking havoc.  After all, if a 
> > format can't be expanded *at all*, there is something wrong, and adding 
> > things to the end of a line is a common structured way of expansion. 
> > Hence the original query
> 
> I don't think it can be easily expanded. .git/info/refs is meant for
> http-fetch, and it mimics git-ls-remote / git-peek-remote output.

Exactly.

> BTW. putting the info of git-for-each-ref into .git/info/refs-details
> would mean that instead of "24175 calls to git" one would need to
> read 24175 files. Perhaps the whole info needed to generate projects
> index page should be pre-generated on push (update), instead of per
> project (per repository) .git/info/refs-details

You completely lost me there. A push (update) is done as a specific user, 
who should not be able to write to a _global_ file!

Nevertheless, "24175 calls to git" is sure as hell more expensive than 
"reading 24175 files".

Plus, if we integrate the functionality to write .git/info/refs-details 
into update-server-info, you can reduce that further: it is no longer 
per-branch, but per-repo.

Ciao,
Dscho
