From: Peter Kirk <peter.kirk@gmx.de>
Subject: Re: git svn rebase creates some commits with empty author, commiter and date fields
Date: Wed, 26 Nov 2008 08:36:41 +0100
Message-ID: <200811260836.48808.peter.kirk@gmx.de>
References: <200811181121.18264.peter.kirk@gmx.de> <20081125220617.GA21644@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 08:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5EyS-0004gx-QH
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 08:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYKZHgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 02:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYKZHgt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 02:36:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:43169 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbYKZHgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 02:36:48 -0500
Received: (qmail invoked by alias); 26 Nov 2008 07:36:45 -0000
Received: from mnhm-590c7231.pool.einsundeins.de (EHLO schizo.localnet) [89.12.114.49]
  by mail.gmx.net (mp038) with SMTP; 26 Nov 2008 08:36:45 +0100
X-Authenticated: #3744494
X-Provags-ID: V01U2FsdGVkX18j2olykEMjPkH3AiMX1Y8CSBmOuZvt0hagme55g6
	axkgacyCFkJb+p
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; x86_64; ; )
In-Reply-To: <20081125220617.GA21644@mayonaise>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101707>

On Tuesday 25 November 2008 23:06:17 Eric Wong wrote:
> Weird.
>
> Does this happen on other repositories you may use as well?  Do you know
> of any strange hooks or otherwise non-standard setup with the SVN
> server?
This is the only svn server I use with git-svn with, so I don't know if this 
would happen on other servers.
About "strange hooks"...there is a pre-commit hook verifying that the 
svn:eolstyle is set properly on text files, but since git > 1.6.0 can do 
"autoproperties" like svn that has never failed for me. Then there is a post-
commit hook which sends out a commit mail and scans the commit message for 
certain commands which trigger the software to be built.

Since that other post I linked was related to the "authors" file, I added a 
text file which maps all the svn users to git users, and that works (I can see 
the assigned names instead of the svn names for commits that aren't broken), 
but it hasn't helped reduce/eliminate the frequency of broken commits.

>
> Which version of the SVN perl bindings are you using?
I am using the SVN perl bindings that came with my distribution (ubuntu), the 
version string reads: 1.5.1dfsg1-1ubuntu2, might this be the problem?

Peter
