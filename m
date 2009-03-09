From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Move push logic to transport.c
Date: Mon, 9 Mar 2009 12:57:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903091230430.19665@iabervon.org>
References: <alpine.LNX.1.00.0903082046280.19665@iabervon.org> <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de> <alpine.LNX.1.00.0903091200150.19665@iabervon.org> <alpine.DEB.1.00.0903091711180.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgioK-0000a9-3S
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbZCIQ5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbZCIQ5L
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:57:11 -0400
Received: from iabervon.org ([66.92.72.58]:49119 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZCIQ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:57:10 -0400
Received: (qmail 10263 invoked by uid 1000); 9 Mar 2009 16:57:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 16:57:07 -0000
In-Reply-To: <alpine.DEB.1.00.0903091711180.6358@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112718>

On Mon, 9 Mar 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 9 Mar 2009, Daniel Barkalow wrote:
> 
> > On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> > 
> > > On Sun, 8 Mar 2009, Daniel Barkalow wrote:
> > > 
> > > > It doesn't convert http-push or the rsync transports, largely 
> > > > because I don't have test setups for rsync or webdav to make sure 
> > > > that they're still working.
> > > 
> > > $ ls t/*http-push*
> > > t/t5540-http-push.sh
> > > 
> > > $ git grep -n test.*rsync t/
> > > t/t5510-fetch.sh:195:test_expect_success 'fetch via rsync' '
> > > t/t5510-fetch.sh:206:test_expect_success 'push via rsync' '
> > > t/t5510-fetch.sh:217:test_expect_success 'push via rsync' '
> > > 
> > > It should be just a matter of installing an apache and rsync.
> > 
> > And configuring them suitably, yes. That's the part I haven't previously 
> > done.
> 
> If you have to configure apache (or rsync) for the test to run properly, 
> we have a serious bug in our test suite.  Please share the output in that 
> case.

rsync: failed to connect to 127.0.0.1: Connection refused (111)
rsync error: error in socket IO (code 10) at clientserver.c(104) [receiver=2.6.9]
fatal: Could not run rsync to get refs

I mean, I won't need to do anything really special in the configuration, 
but I do need to have rsyncd running giving access to that directory 
without any funny mapping on localhost.

The apache test does, in fact, run its own server, so that should be easy 
enough (although I do need to install an apache with mod_dav.so, which I 
don't have handy).

	-Daniel
*This .sig left intentionally blank*
