From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score
 for rename detection
Date: Fri, 29 Jun 2007 11:19:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706291114090.4438@racer.site>
References: <20070628060416.GA13162@midwinter.com> <Pine.LNX.4.64.0706281340090.4438@racer.site>
 <4683FB25.3080204@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 12:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Dew-00009w-8d
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 12:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbXF2KY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 06:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbXF2KY7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 06:24:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:55166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbXF2KY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 06:24:58 -0400
Received: (qmail invoked by alias); 29 Jun 2007 10:24:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 29 Jun 2007 12:24:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M0K0c7PSM+MnzjEb1PbqsCL+XkNZDPef86jEEN9
	UaCPSBpwkwgafy
X-X-Sender: gene099@racer.site
In-Reply-To: <4683FB25.3080204@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51171>

Hi,

On Thu, 28 Jun 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > Somehow I think that this should be triggered by "--ignore-space-at-eol",
> > _and_ be accompanied by a test case.
> >   
> 
> Should --ignore-space-at-eol be an option to git-merge? Merges are where 
> this functionality matters; for simple diffs, --ignore-space-at-eol 
> actually already covers it.

Good point. However, I fail to see how the similarity detection should be 
so decoupled from the application. IOW what good is it if two files are 
rated similar if the merge cannot handle the CRLF/LF differences properly?

So two points here: since the merges are what you target, you definitely 
should mention that in the commit message. And you should make sure that 
all this trickery only kicks in when the merge has a chance to succeed.

Ciao,
Dscho
