From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3 v2] Use an external program to implement fetching
 with  curl
Date: Tue, 28 Jul 2009 17:03:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281658370.14706@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0907280207350.2147@iabervon.org>  <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de> <40aa078e0907280630p7751c3d9m639e63e7700a8819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVoDY-0004xD-NG
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 17:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbZG1PDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 11:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbZG1PDP
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 11:03:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:34998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbZG1PDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 11:03:13 -0400
Received: (qmail invoked by alias); 28 Jul 2009 15:03:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 28 Jul 2009 17:03:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TVDUEz/gTOFil7hgCHhk0Y+5SucaYKalNe3X6xD
	4p8vbzOtKZQ2vu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0907280630p7751c3d9m639e63e7700a8819@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124255>

Hi,

On Tue, 28 Jul 2009, Erik Faye-Lund wrote:

> On Tue, Jul 28, 2009 at 3:19 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > If you already start some infrastructure like this, you should go the 
> > whole nine yards and make helper functions in remote.c or transport.c 
> > that help implementing "git-remote-<protocol>" helpers.
> 
> You mean helper-helpers? :)

Not really... I meant functions that do all the stdin parsing for you, 
together with error handling, and only return proper lists of verified 
arguments in the appropriate data structure.  This functionality is likely 
to be needed by all remote helpers, that's why I would prefer to have it 
exposed as functions in libgit.a, to be reused by all the helpers.

Of course, this would not help shell scripting such helpers, but you have 
to start somewhere.  And that somewhere happens to be the http transport.

Ciao,
Dscho
