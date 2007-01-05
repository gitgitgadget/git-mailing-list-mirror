From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing into a repository with working directory?
Date: Fri, 05 Jan 2007 01:50:22 -0800
Message-ID: <7virfliyzl.fsf@assigned-by-dhcp.cox.net>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org>
	<7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
	<459E1B23.4060400@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 10:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2liW-0006HH-UL
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbXAEJuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXAEJuX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:50:23 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57787 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161012AbXAEJuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:50:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105095022.LVLS15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 04:50:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7Mqd1W00G1kojtg0000000; Fri, 05 Jan 2007 04:50:37 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <459E1B23.4060400@shadowen.org> (Andy Whitcroft's message of
	"Fri, 05 Jan 2007 09:32:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35988>

Andy Whitcroft <apw@shadowen.org> writes:

> Is it fishy if the working directory and index match HEAD?  If not, then
> we could detect that and allow update in that case?

That actually is what 'git-pull' does when you misconfigure and
use your current branch as the tracking branch (which is the
only reason 'git-fetch' has the --update-head-ok option that
should never be used by the end user).

We really should disallow this.
