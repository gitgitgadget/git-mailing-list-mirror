From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sat, 25 Jul 2009 20:19:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907252017060.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlqn-0007mz-6M
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbZGYSTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZGYSTk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:19:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:45784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236AbZGYSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:19:40 -0400
Received: (qmail invoked by alias); 25 Jul 2009 18:19:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 25 Jul 2009 20:19:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JdClLFryJCPDU/oBgZUB3OOQfpF3fCsHiFClr7F
	unC8n6sDAU9Ad7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124032>

Hi,

On Sat, 25 Jul 2009, Daniel Barkalow wrote:

> transport_get() can call transport_shim_init() to have list and
> fetch-ref operations handled by running a separate program as:
> 
>  git shim-<something> <remote> [<url>]
> 
> This program then accepts, on its stdin, "list" and "fetch <hex>
> <name>" commands; the former prints out a list of available refs and
> either their hashes or what they are symreefs to, while the latter
> fetches them into the local object database and prints a newline when done.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> This is similar to, but different from, my git-vcs-* stuff; this one 
> expects the helper to be able to look up sha1s for refs efficiently, and 
> to be able to fetch objects directly into the local object database 
> without fast-import. On the otherhand, it should be sufficiently general 
> to allow arbitrary methods for moving the data around.

I wonder if this cannot be integrated into the git-vcs stuff; after all, 
they do pretty much the same things, except that the vcs helpers are 
pretty dumb, and the shim helpers are not as dumb.

I could imagine that the name of the helper could reveal its capability to 
act as a shim helper: git-vcs-shim-http

Ciao,
Dscho
