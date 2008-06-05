From: Eric Raible <raible@gmail.com>
Subject: Re: BUG: "git stash apply <arg>" broken, "git-stash apply <arg>" works
Date: Thu, 5 Jun 2008 11:17:05 +0000 (UTC)
Message-ID: <loom.20080605T110928-264@post.gmane.org>
References: <279b37b20806041646jc29a695w685c3e01efc0dd0b@mail.gmail.com> <alpine.DEB.1.00.0806050112550.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 13:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4DU1-0006ry-EA
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbYFELRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 07:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbYFELRY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:17:24 -0400
Received: from main.gmane.org ([80.91.229.2]:38224 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbYFELRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 07:17:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K4DT3-0003nN-9c
	for git@vger.kernel.org; Thu, 05 Jun 2008 11:17:18 +0000
Received: from adsl-67-121-115-243.dsl.pltn13.pacbell.net ([67.121.115.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 11:17:17 +0000
Received: from raible by adsl-67-121-115-243.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 11:17:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.121.115.243 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83903>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> This is most likely an issue with MSys, not Git.  As far as I know, 
> Steffen started to have a look at it, but I do not really know: I took my 
> retreat from msysGit.
> 
> Ciao,
> Dscho
> 

Not surprisingly this was exactly right, and I just posted a patch on
http://code.google.com/p/msysgit/ which fixes it.  It turns out that
command lines passed to CreateProcess() which contain '{' need to be
quoted (specifically quote_arg() needs to set 'force_quotes' to 1).

Thanks for the pointer.

- Eric
