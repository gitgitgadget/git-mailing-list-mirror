From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why git-merge-resolve in git-am?
Date: Wed, 27 Dec 2006 18:28:01 -0800
Message-ID: <7virfw3gb2.fsf@assigned-by-dhcp.cox.net>
References: <20061228014525.GC16612@spearce.org>
	<7vr6uk3h2p.fsf@assigned-by-dhcp.cox.net>
	<20061228022038.GE16612@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 03:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzl04-0006o5-BR
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 03:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWL1C2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 21:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWL1C2F
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 21:28:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34162 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885AbWL1C2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 21:28:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228022802.YFAB2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 21:28:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 42UF1W00t1kojtg0000000; Wed, 27 Dec 2006 21:28:16 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228022038.GE16612@spearce.org> (Shawn Pearce's message of
	"Wed, 27 Dec 2006 21:20:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35511>

Shawn Pearce <spearce@spearce.org> writes:

> Good reasons, but all are strictly historical.  So there's actually
> no technical reason we can't use merge-recursive here in git-am.

A very early version of recursive was unusable (it did not pay
attention to the merge base the caller gave it and tried to
always compute it by itself), but that was fixed sometime later.

I do not recall offhand C version still has that fix (I think it
does but you should double check); as long ias it honors the
merge base the caller computed, it should be Ok to replace
resolve with recursive.  Go wild.
