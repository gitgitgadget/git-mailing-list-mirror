From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 8 Jun 2008 20:30:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806082029170.1783@racer>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 21:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5QdU-0004iq-N4
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 21:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYFHTcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYFHTcL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 15:32:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:42805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753454AbYFHTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 15:32:11 -0400
Received: (qmail invoked by alias); 08 Jun 2008 19:32:09 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 08 Jun 2008 21:32:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181MK0krJU1fNJZjq/fQKHm2GiVqszJb3o/ySR0YV
	j9lgPjc0gkOeZP
X-X-Sender: gene099@racer
In-Reply-To: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84312>

Hi,

On Sun, 8 Jun 2008, Boyd Lynn Gerber wrote:

> 
> Dynamically sized arrays are gcc and C99 construct.  Using them hurts
> portability to older compilers, although using them is nice in this case
> it is not desirable.  This patch removes the only use of the construct
> in stop_progress_msg(); the function is about writing out a single line
> of a message, and the existing callers of this function feed messages
> of only bounded size anyway, so use of dynamic array is simply overkill.
> 
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
> 
> --
> Boyd Gerber <gerberb@zenez.com>
> ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
> 
> ---

Do you really want to have your mail signature in the commit message, 
particularly because...

> [...]
>
>  	clear_progress_signal();
>  	free(progress->throughput);
> -- 
> 1.5.2.4
> 
> 
> --
> Boyd Gerber <gerberb@zenez.com>
> ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

You repeat it at the end of the mail anyway?

The patch looks fine to me, though.

Ciao,
Dscho
