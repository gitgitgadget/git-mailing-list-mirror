From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Thu, 01 Mar 2007 20:46:46 -0800
Message-ID: <7vps7smevd.fsf@assigned-by-dhcp.cox.net>
References: <200703011206.47213.andyparkins@gmail.com>
	<7vejo8o69o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMzfP-0003je-DH
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 05:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbXCBEqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 23:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbXCBEqs
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 23:46:48 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58013 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422887AbXCBEqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 23:46:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302044648.ONJA2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 23:46:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vgmm1W00H1kojtg0000000; Thu, 01 Mar 2007 23:46:47 -0500
In-Reply-To: <7vejo8o69o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Mar 2007 16:09:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41158>

Junio C Hamano <junkio@cox.net> writes:

> I am in favor of also using $GIT_DIR/config format even for the
> in-tree .gitattributes files.

Thinking about this a bit more, I take this "syntax" part back.
One-line-per-record format is much nicer if we want to keep this
information in .gitattributes files in-tree, especially because
the changes to them _could_ conflict, and the pathattr mechanism
needs to work with such a file left in the working tree as its
input.  I suspect the config parser would simply say "oops" and
die given a malformed input resulting from conflict markers.  It
is easy to ignore <<< === >>> lines and we would get a sensible
result.

Which automatically means that there will be no "continuation
lines".
