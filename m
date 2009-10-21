From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 18:35:42 -0700
Message-ID: <BLU0-SMTP37B36AD1D1000A723B9EBDAEBF0@phx.gbl>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
	<BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
	<alpine.LNX.2.00.0910202001050.14365@iabervon.org>
	<BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
	<alpine.LNX.2.00.0910202044150.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 03:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Q9z-0001W7-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 03:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbZJUBfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 21:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZJUBfq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 21:35:46 -0400
Received: from blu0-omc1-s6.blu0.hotmail.com ([65.55.116.17]:20909 "EHLO
	blu0-omc1-s6.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbZJUBfq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 21:35:46 -0400
Received: from BLU0-SMTP37 ([65.55.116.8]) by blu0-omc1-s6.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 18:35:51 -0700
X-Originating-IP: [66.183.8.119]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from lex.hookers.net ([66.183.8.119]) by BLU0-SMTP37.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 18:35:50 -0700
In-Reply-To: <alpine.LNX.2.00.0910202044150.14365@iabervon.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; x86_64-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2009 01:35:50.0259 (UTC) FILETIME=[D21BE430:01CA51EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130877>

On Tue, 20 Oct 2009 20:55:25 -0400 (EDT)
Daniel Barkalow <barkalow@iabervon.org> wrote:

> > Maybe, but it could also just be to create a temp local branch for
> > merging into additional branches afterward with "checkout other;
> > merge temp".   This is especially helpful when pulling from an
> > annoyingly long URL instead of from a configured remote.
> 
> Maybe it should be fine to do:
> 
> $ git fetch long-url-here master:temp
> $ git merge temp
> $ git checkout other-branch-that-also-needs-it
> $ git merge temp
> 
> But "temp" is "refs/remotes/temp", not "refs/heads/temp"?

Well that's only one example of possibile uses for fetching directly to
a local branch, perhaps as a new base of further development.  Is there
really a compelling reason to force someone to fetch into refs/remotes
and then do the extra step of checking it out locally?
 
> I think, actually, that creating or changing a local branch is really not 
> what "fetch" (or the fetch part of pull) is about. I think that just leads 
> to confusion about what's locally-controlled and what's a local memory of 
> something remotely-controlled.

Well it's a handy shortcut for several situations.  There must be a way
to protect less adroit Git users without removing functionality.

Sean
 
