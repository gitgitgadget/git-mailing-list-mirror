From: Thomas Neumann <tneumann@users.sourceforge.net>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 22:42:04 +0100
Message-ID: <20080107224204.55539c31@jaiman>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 22:43:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzkG-0004Bf-LM
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYAGVm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbYAGVm1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:42:27 -0500
Received: from main.gmane.org ([80.91.229.2]:51715 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbYAGVm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:42:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JBzji-0003kg-Lb
	for git@vger.kernel.org; Mon, 07 Jan 2008 21:42:22 +0000
Received: from dslb-084-058-195-057.pools.arcor-ip.net ([84.58.195.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 21:42:22 +0000
Received: from tneumann by dslb-084-058-195-057.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 21:42:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-058-195-057.pools.arcor-ip.net
In-Reply-To: <200801072203.23938.robin.rosenberg.lists@dewire.com>
X-Newsreader: Claws Mail 3.2.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69815>

> Indeed, but the most common SCM's detect binary files automatically, 
> either by suffix  or content analysis, so I think that is what user's
> expect. It will be right for more projects that the current behaviour.
as a user, I expect a SCM to only modify a file when I have explicitly
asked it to do so. Automatically conversion by guessing file types are
evil, as they _will_ go wrong, and then mess some files.
This "intelligent" file handling is a pain to use. You end up in
situations were builds work on some platforms but not on others, which
gets even more confusion with NFS home directories.

So, please do not enable core.autocrlf by default on Windows. It might
be reasonable for some projects, but not for all of them, and it will
break some projects. Perhaps a project should be able to enable (or
"suggest" it) in a repo-wide setting somehow, which would avoid the git
clone problem.

Thomas
