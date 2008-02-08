From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 00:38:56 +0100
Organization: glandium.org
Message-ID: <20080208233856.GA31593@glandium.org>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site> <20080208220356.GA22064@glandium.org> <alpine.LSU.1.00.0802082234170.11591@racer.site> <20080208225024.GA26975@glandium.org> <alpine.LSU.1.00.0802082312520.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 00:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNcoG-0000Um-8J
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 00:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758735AbYBHXi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758732AbYBHXi0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 18:38:26 -0500
Received: from vuizook.err.no ([85.19.215.103]:57352 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712AbYBHXiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 18:38:25 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNcoP-0006Xo-2f; Sat, 09 Feb 2008 00:39:23 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNco4-0006P0-RQ; Sat, 09 Feb 2008 00:38:56 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802082312520.11591@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73173>

On Fri, Feb 08, 2008 at 11:14:40PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Feb 2008, Mike Hommey wrote:
> 
> > On Fri, Feb 08, 2008 at 10:34:55PM +0000, Johannes Schindelin wrote:
> > 
> > > On Fri, 8 Feb 2008, Mike Hommey wrote:
> > > 
> > > > Also note that the http transport uses info/http-alternates for 
> > > > http:// urls. By the way, it doesn't make much sense that only 
> > > > http-fetch uses it.
> > > 
> > > I think it does make sense: nobody else needs http-alternates.
> > 
> > If you're setting an http-alternate, it means objects are missing in the 
> > repo. If they are missing in the repo and are not in alternates, how can 
> > any other command needing objects out there work on the repo ?
> 
> The point is: if you have a bare repository on a server that uses 
> alternates, that path stored in info/alternates is usable by git-daemon.  
> But it is not usable by git-http-fetch, since that does not have a 
> git-aware server side.  So if you want to reuse the _same_ bare repository 
> _with_ alternates for both git:// transport and http:// transport, you 
> _need_ to _different_ alternates: one being a path on the server, and 
> another being an http:// url for http-fetch.

But nothing prevents you from only setting an http-alternate. Also not
http-fetch can deal fine with info/alternates if it contains relative
paths.

Mike
