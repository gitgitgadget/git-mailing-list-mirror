From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 02/40] Compile some programs only conditionally.
Date: Fri, 29 Feb 2008 21:58:11 +0100
Message-ID: <200802292158.12398.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802282130.10225.johannes.sixt@telecom.at> <alpine.LSU.1.00.0802290046180.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 21:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCJh-0006in-4r
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 21:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYB2U6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbYB2U6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 15:58:16 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:51615 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYB2U6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 15:58:15 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id B268D345DB;
	Fri, 29 Feb 2008 21:58:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7863156E3B;
	Fri, 29 Feb 2008 21:58:13 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802290046180.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75560>

On Friday 29 February 2008 01:47, Johannes Schindelin wrote:
> On Thu, 28 Feb 2008, Johannes Sixt wrote:
> > openlog() etc. is only one problem in git-daemon. It also depends on
> > SIGCHLD, a non-blocking waitpid, and a lot more. The patch that is in
> > 4msysgit.git allows only a single connection, IIRC, after which it
> > terminates. But I also think that git-daemon can be made more complete
> > on Windows, but it certainly requires a major surgery.
>
> Okay, I did not look closely enough.  But even a single-connection daemon
> is better than no daemon, no?

In principle, yes. But:

- git-fetch needs two connections if there are new tags in the source repo.

- The daemon patches in 4msysgit.git could be prettier, they certainly would 
not pass your scrutiny.

git-daemon is not my itch at this time, so I won't scratch it.

-- Hannes
