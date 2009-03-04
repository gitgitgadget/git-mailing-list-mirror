From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Clarify the "cannot lock existing info/refs" error
Date: Wed, 4 Mar 2009 20:28:53 +0100
Message-ID: <20090304192853.GA10567@localhost>
References: <1236181026-15385-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lex2L-0000JC-3u
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 20:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZCDToU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZCDToT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 14:44:19 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:14723 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbZCDToS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 14:44:18 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2009 14:44:18 EST
Received: from darc.dyndns.org ([84.154.68.174]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Mar 2009 20:29:01 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Lewlx-0002rw-8v; Wed, 04 Mar 2009 20:28:53 +0100
Content-Disposition: inline
In-Reply-To: <1236181026-15385-1-git-send-email-johnflux@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Mar 2009 19:29:01.0589 (UTC) FILETIME=[78E8DC50:01C99CFF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112240>

On Wed, Mar 04, 2009 at 03:37:06PM +0000, John Tapsell wrote:
> -fprintf(stderr, "Error: cannot lock existing info/refs\n");
> +error("cannot lock existing info/refs on remote server\nPerhaps the
> server is currently busy, or your ~/.netrc file is not configured
> correctly.");

In my experience this is usually caused by http-push crashing and leaving
stale locks behind until it times out after 10 minutes. I don't think we
should speculate here unless we can narrow down the error condition.
