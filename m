From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone: Error meaningfully on failed HTTP fetches of HEAD
Date: Wed, 11 Apr 2007 17:24:44 -0700
Message-ID: <7vwt0imoc3.fsf@assigned-by-dhcp.cox.net>
References: <11763291192402-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbn7L-0003OG-Bk
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161425AbXDLAYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbXDLAYs
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:24:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50469 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161429AbXDLAYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:24:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412002445.LPGU1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 20:24:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m0Ql1W00A1kojtg0000000; Wed, 11 Apr 2007 20:24:45 -0400
In-Reply-To: <11763291192402-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Thu, 12 Apr 2007 10:05:19 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44290>

Martin Langhoff <martin@catalyst.net.nz> writes:

> A common problem when cloning over http is that the repo has
> a symlink for HEAD, and apache refuses to serve symlinks by
> default.
>
> Without this patch, the clone succeeds as a "bare" and "HEADless"
> clone, but does not give any indication that things have gone
> wrong.
>
> A bare clone that fails to fetch HEAD will still complete
> "successfully". I'm not sure if that's expected/desired. Is a
> HEADless repo valid in any situation?

You would get "fatal: Not a git repository".  Why not default to
'master' (if found) and issue a warning?
