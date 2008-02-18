From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 17:43:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181739450.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org> <47B9A354.7070905@catalyst.net.nz> <alpine.LSU.1.00.0802181624490.30505@racer.site>
 <47B9B35B.7040200@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRA2C-00088K-1W
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYBRRnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYBRRnX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:45990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752060AbYBRRnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:43:22 -0500
Received: (qmail invoked by alias); 18 Feb 2008 17:43:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 18 Feb 2008 18:43:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u6aRA96juWd8ryLAue308/gAsLWpi4AqlROQvfe
	Kp0FCHmJCnPCo3
X-X-Sender: gene099@racer.site
In-Reply-To: <47B9B35B.7040200@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74321>

Hi,

On Tue, 19 Feb 2008, Martin Langhoff wrote:

> Johannes Schindelin wrote:
>
> > Note that for this reason, only the "File:" output -- which does not 
> > show slashes, but only the basenames -- is used to match the files.  
> > We need the full path in the git repository, though, to apply the 
> > patches.
> 
> Yes - that's ugly. We have a couple of options
> 
>  - Run cvs status once per directory we touch. Use -l tomake it
> non-recursive. It will be a tad slower/chattier.

I think that my approach is a bit faster: make lists with unique 
basenames.  In the most common case, there will be only one list, I 
suspect.

>  - Parse the 'Repository revision:' line to find out what path on the
> server matches our repo 'root'.

I am not so sure.  It _should_ be reconstructible by CVS/Repository + 
dirname + basename, but I guess that it makes us susceptible to other CVS 
breakages.  Whereas I think that we will be fine, relying on the basename 
in the File: line.

> > Thanks.  I am confident that I will have posted another version by the 
> > time you come around to review it.
> 
> Great! Careful, you might end up enjoying Perl ;-)

Heh.  I always said that I like Perl, because it's easier to tell who's 
an expert, than for, say, Python.  Unfortunately, that means that it is 
easy to see that I am not an expert myself :-(

Ciao,
Dscho
