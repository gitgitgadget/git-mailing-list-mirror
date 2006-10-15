From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] clone: the given repository dir should be relative to $PWD
Date: Sat, 14 Oct 2006 18:16:33 -0700
Message-ID: <7v7iz274zy.fsf@assigned-by-dhcp.cox.net>
References: <87ac3zqebs.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 03:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYucK-0003SW-71
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 03:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbWJOBQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 21:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbWJOBQe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 21:16:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60291 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750938AbWJOBQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 21:16:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015011633.JUAE16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 21:16:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aRGc1V00M1kojtg0000000
	Sat, 14 Oct 2006 21:16:36 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87ac3zqebs.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Sat, 14 Oct 2006 21:02:51 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28901>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> the repository argument for git-clone should be relative to $PWD
> instead of the given target directory.  The old behavior gave us
> surprising success and you need a few minute to know why it worked.
>
> GIT_DIR is already exported so no need to cd into $D. And this makes
> $PWD for git-fetch-pack, which is the actual command to take the given
> repository dir, the same as git-clone.
>
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
> ---
>
> While I'm not sure this is a feature we rely on or not, and I don't
> want to change the way people work, IMHO the old behaviour isn't
> appropriate for such higher level porcelain.
>
> The patch should be for post 1.4.3.

Well spotted.  I am fairly sure that this "clone from repository
relative to the target" is not intended behaviour.  I'd say we
should fix this before 1.4.3.

... or are there any valid reason to keep the current behaviour
that I missed?
