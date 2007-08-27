From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: .gitignore, .gitattributes, .gitmodules, =?utf-8?b?LmdpdHByZWNpb3VzPywJLmdpdGFjbHM/?= etc.
Date: Mon, 27 Aug 2007 17:22:48 +0000 (UTC)
Message-ID: <loom.20070827T190921-993@post.gmane.org>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <loom.20070827T172150-191@post.gmane.org> <86odgtou5p.fsf@lola.quinscape.zz> <20070827165416.GR1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 19:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPiIy-0000w5-E1
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXH0RXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbXH0RXH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:23:07 -0400
Received: from main.gmane.org ([80.91.229.2]:50965 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbXH0RXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:23:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPiIm-0008QA-8u
	for git@vger.kernel.org; Mon, 27 Aug 2007 19:23:00 +0200
Received: from 99.Red-80-58-205.staticIP.rima-tde.net ([80.58.205.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 19:23:00 +0200
Received: from scallegari by 99.Red-80-58-205.staticIP.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 19:23:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.58.205.99 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56864>

Petr Baudis <pasky <at> suse.cz> writes:

> 
> On Mon, Aug 27, 2007 at 05:48:34PM CEST, David Kastrup wrote:
> > Sergio Callegari <scallegari <at> arces.unibo.it> writes:
> > 
> > > Couldn't all this directory/ownership/permission tracing be easily
> > > done by using hooks?  E.g. Having a pre-status and pre-commit hook
> > > one could fire up a program/script to collect all the extra info he
> > > wants to trace and store it somewhere (typically in some traced
> > > file).  The other way round one could have a post-checkout hook and
> > > he could arrange it to fire up some program to look into the
> > > extra-info file to set up all the meta-data he wants.
> > >
> > > This would be very flexible and would permit to manage absolutely
> > > /any/ kind of the metadata leaving absolute freedom about how to do
> > > so.
> > >
> > > Am I missing something here?
> > 
> > Merging.
> 
> Fetching.
> 

Even here, I must be missing something, as I cannot see the issue.

If I need to fetch from someone who is tracing metadata, then there are 2
alternatives:

1) I am fetching only for myself and I am not interested in metadata at all.
All I need to do is to fetch. With this I will fetch a repository with
one/some extra file/files (e.g. .helper-metadata).

2) I am interested in the metadata tracing (e.g. to interact with
my origin). Then it is sufficient to first install the same set of
metadata tracing helpers as my origin and after that to do the fetch.
With this I will fetch a repository including the traced metadata files
just as above, yet these would be immediately be used by the helpers
through the hooks. For instance, as soon as anything gets checked out the
proper metadata can be applied.

Obviously, before installing any hooks, I should trust their origin.  But I
believe that if hooks get this kind of usage, rapidly we will see
the growth of trustable "standard" hooks-bundles for many tasks.
