From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Wed, 01 Aug 2007 16:21:04 -0700
Message-ID: <7vtzri3kpr.fsf@assigned-by-dhcp.cox.net>
References: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
	<S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org>
	<85ejimrjb2.fsf@lola.goethe.zz>
	<7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGNV9-000492-5J
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXHAXVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXHAXVH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:21:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47860 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbXHAXVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 19:21:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801232103.LHO1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 19:21:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WnM41X0061kojtg0000000; Wed, 01 Aug 2007 19:21:04 -0400
In-Reply-To: <7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 01 Aug 2007 16:18:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54499>

Junio C Hamano <gitster@pobox.com> writes:

> It is not just "won't apply".  What if GIT_DIR had spaces (which
> is fine) and single-quotes in it?  Wouldn't it percolate down to
> $@ because it becomes the leading directory of the temporary
> file name?  And you quote '"$@"' and eval it, now what happens?

Ah, I spoke too fast.  It is fine --- the shell that actually is
doing the eval then interpolates "$@".  Clever.
