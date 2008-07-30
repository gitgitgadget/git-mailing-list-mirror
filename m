From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 20:18:27 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807302016160.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080730082030.GA12555@cuci.nl> <alpine.LSU.1.00.0807301553030.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080730155853.GA27166@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGGs-0002a2-At
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYG3SSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbYG3SSb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:18:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:36688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbYG3SSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:18:30 -0400
Received: (qmail invoked by alias); 30 Jul 2008 18:18:28 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp014) with SMTP; 30 Jul 2008 20:18:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KC2sR4xmKX83P1gkQ0cL9NvhmqCPRw57Na1RiZJ
	CTvY5dhLj9uvwv
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080730155853.GA27166@cuci.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90824>

Hi,

On Wed, 30 Jul 2008, Stephen R. van den Berg wrote:

> Johannes Schindelin wrote:
> >On Wed, 30 Jul 2008, Stephen R. van den Berg wrote:
> >> Someone popped this question on me.
> 
> >I do not know cvs that well anymore.  So I do not know what -l does.  Care 
> >to explain?
> 
> Usage: cvs diff [-lR] [-k kopt] [format_options]
>     [[-r rev1 | -D date1] [-r rev2 | -D date2]] [files...]
>         -l      Local directory only, not recursive
> 
> It shows the diff for all files in the current directory, nothing
> deeper, nothing higher.

Okay.  This is my version of a solution:

	$ find . -maxdepth 1 -type f -print0 | xargs -0 git diff

And no, there is not an easier way.  Probably since Git has a snapshot 
based idea of the contents, i.e. it does not think that the files in a 
revision are decoupled.  Not even the ones in different directories.

Ciao,
Dscho
