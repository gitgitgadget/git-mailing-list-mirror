From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Sat, 30 Dec 2006 20:24:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612302020060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612181329480.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4596B837.8030108@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 20:24:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0joP-000063-Hu
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 20:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWL3TYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWL3TYG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 14:24:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:58962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030293AbWL3TYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 14:24:03 -0500
Received: (qmail invoked by alias); 30 Dec 2006 19:24:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 30 Dec 2006 20:24:02 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
In-Reply-To: <4596B837.8030108@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35627>

Hi,

On Sat, 30 Dec 2006, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > 
> > Here you have to check first, if len > 3. Strictly speaking, there should 
> > not be any line coming in which is shorter than 42 bytes. But I was 
> > recentely bitten by such an assuption...
> > 
> > Overall, I like it. I even have the impression that this could actually 
> > open a way to build in fetch instead of relying on a POSIX conformant and 
> > fast shell for such a central part of git.
> 
> is there any chance of this going in GIT 1.5.0 ? It's not in the rc0 
> release.

Um.

$ git grep -e exclude-existing v1.5.0-rc0
v1.5.0-rc0:builtin-show-ref.c:          if (!strcmp(arg, "--exclude-existing"))
v1.5.0-rc0:builtin-show-ref.c:          if (!strncmp(arg, "--exclude-existing=", 19))
v1.5.0-rc0:git-fetch.sh:                git-show-ref --exclude-existing=refs/tags/ |

The last line means that it _is_ in v1.5.0-rc0. (BTW it is the commit 
tags/v1.5.0-rc0~84, which I found by "git log v1.5.0-rc0 git-fetch.sh | 
git name-rev --tags --stdin | less".)

Ciao,
Dscho
