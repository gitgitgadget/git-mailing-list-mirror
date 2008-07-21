From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Support copy and rename detection in fast-export.
Date: Mon, 21 Jul 2008 12:17:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807211207470.3305@eeepc-johanness>
References: <200807211216.01694.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsT6-0005uy-I3
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbYGUKQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbYGUKQ5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:16:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:36136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758877AbYGUKQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:16:56 -0400
Received: (qmail invoked by alias); 21 Jul 2008 10:16:55 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp016) with SMTP; 21 Jul 2008 12:16:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h4aYwImbhiXSeIFQUG+uhNSaP7ubs6m7nhO8QEX
	0Yby6qV7n5XjnE
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807211216.01694.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89331>

Hi,

On Mon, 21 Jul 2008, Alexander Gavrilov wrote:

> Although it does not matter for Git itself, tools that
> export to systems that explicitly track copies and
> renames can benefit from such information.
> 
> This patch makes fast-export output correct action
> logs when -M or -C are enabled.

I like it.

> 	I'm thinking about Git->SVN conversion, like 
> 	http://repo.or.cz/w/git2svn.git
> 
> 	The trouble with this patch is that old versions of fast-export
> 	accept -M and -C, but produce garbage if they are specified.
> 	So the only way for the users to ensure that it is supported is
> 	to check the git version (or directly test it).

Unfortunately, this is so.

> 	As a somewhat related question, in which order does fast-export 
> 	output the commits, beside topological? In particular, does it order 
> 	commits on parrallel branches (i.e. not topologically dependent) by 
> 	date?

AFAIR it obeys topological order first, and then date order, by default.  
This can be changed by --topo-order.

But before you go and try to support more options with fast-export:  Some 
options do not make sense, such as --reverse, "a...b", --skip, etc.

I do not even think we need to bother about die()ing with such options: 
the user should know what she is doing with fast-export.

Ciao,
Dscho
