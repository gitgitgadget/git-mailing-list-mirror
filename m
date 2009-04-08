From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Any way to edit the file in index directly?
Date: Wed, 8 Apr 2009 04:39:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904080434240.10279@pacific.mpi-cbg.de>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com> <20090408021041.GB18244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNgE-0000Xg-3b
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760978AbZDHCgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760734AbZDHCgq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:51128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758953AbZDHCgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:36:45 -0400
Received: (qmail invoked by alias); 08 Apr 2009 02:36:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 08 Apr 2009 04:36:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+2TYIFjH+rTxMr7L2povp7fA8kZilHiUa0eT6GT
	iKjehcI3hMHdHa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090408021041.GB18244@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116025>

Hi,

On Tue, 7 Apr 2009, Jeff King wrote:

> On Wed, Apr 08, 2009 at 09:03:03AM +0800, Ping Yin wrote:
> 
> > There seems to be a patch for this ( add -e?), but i forget where to
> > find it.
> 
> "add -p" has an "e"dit option for editing the patch. I don't recall any
> way of directly editing the content.

I posted a patch for "git add --edit", which allows you to edit the _diff_ 
between the working directory and the index, and which applies the result 
using apply --recount.

But that has nothing to do with "editing the index directly".

But you might want to use a combination of "hash-object -w --stdin" and 
"update-index --cacheinfo".  IOW something like

	sha1=$(echo Hello | git hash-object -w --stdin) &&
	git update-index --cacheinfo 0644 $sha1 my-file

However, Ping, I _strongly_ suspect an X-Y problem here.  IOW I think you 
are asking about specifics of a certain _solution_, while we probably have 
a better solution for your particular _problem_.

Hth,
Dscho
