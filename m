From: Junio C Hamano <junkio@cox.net>
Subject: Re: Storage optimization with alternates
Date: Fri, 09 Mar 2007 17:49:25 -0800
Message-ID: <7vwt1pzx3u.fsf@assigned-by-dhcp.cox.net>
References: <20070309183100.GC7052@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqiB-0005ox-FL
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767715AbXCJBt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767717AbXCJBt0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:49:26 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60960 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767715AbXCJBt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:49:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310014926.JMBH748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 20:49:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YppQ1W00f1kojtg0000000; Fri, 09 Mar 2007 20:49:25 -0500
In-Reply-To: <20070309183100.GC7052@peter.daprodeges.fqdn.th-h.de> (Rocco
	Rutte's message of "Fri, 9 Mar 2007 18:31:01 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41835>

Rocco Rutte <pdmef@gmx.net> writes:

> Is there any way I can clean up the feature repos by saying "remove
> all objects that you can reach via alternates already"?

"repack -a -d -l" ought to do that.  It repacks while excluding
the objects that are in a pack that is not local.
