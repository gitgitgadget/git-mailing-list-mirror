From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Tue, 4 Mar 2008 15:51:31 -0800
Message-ID: <20080304235131.GA27590@herod.dreamhost.com>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWhQn-00061y-TP
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbYCEAXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbYCEAXs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:23:48 -0500
Received: from judo.dreamhost.com ([66.33.216.100]:49716 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbYCEAXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:23:47 -0500
X-Greylist: delayed 1809 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 19:23:47 EST
Received: from smarty.dreamhost.com (smarty.dreamhost.com [208.113.175.8])
	by judo.dreamhost.com (Postfix) with ESMTP id 16DD7176C1A
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 15:53:38 -0800 (PST)
Received: from herod.dreamhost.com (herod.dreamhost.com [208.113.239.72])
	by smarty.dreamhost.com (Postfix) with ESMTP id 142D5EE275;
	Tue,  4 Mar 2008 15:51:32 -0800 (PST)
Received: by herod.dreamhost.com (Postfix, from userid 130321)
	id 02FF760311; Tue,  4 Mar 2008 15:51:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47CD78C9.80003@viscovery.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76158>

On Tue, Mar 04, 2008 at 05:28:57PM +0100, Johannes Sixt wrote:
> But there is also another complication: The size parameter of the system's
> vsnprintf must not count the trailing NUL, i.e. the buffer must actually
> have space for one extra byte, whereas the POSIX version must count NUL.

FYI, rsync's configure script has a check for both those problems.  It
sets HAVE_C99_VSNPRINTF if vsnprintf() works right.  If that fails,
rsync uses its own lib/snprintf.c implementation (that I believe comes
from Samba).  That file could be included in git, if desired.

..wayne..
