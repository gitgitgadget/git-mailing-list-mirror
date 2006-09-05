From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Tue, 05 Sep 2006 14:26:50 -0700
Message-ID: <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net>
References: <20060905184611.GB14732@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 23:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiR5-0002BN-03
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 23:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWIEV0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWIEV0U
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 17:26:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5561 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751375AbWIEV0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 17:26:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905212617.NVTW6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 17:26:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JlSJ1V00G1kojtg0000000
	Tue, 05 Sep 2006 17:26:18 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060905184611.GB14732@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Tue, 5 Sep 2006 21:46:11 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26487>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> Hi,
>
> This feature was useful with importing https://openib.org/svn/gen2 .
>
> Sasha
>
> This add '-S' option. When specified svn-import will try to parse
> commit message for 'Signed-off-by: ...' line, and if found will use
> the name and email address extracted at first occurrence as this commit
> author name and author email address. Committer name and email are
> extracted in usual way.
>
> Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>

Thanks.

I do not think the first signed-off-by is necessarily the author
of the change, so we are risking miscrediting (or misblaming) a
wrong person.  Having said that, using the committer information
has the same miscredit problem, so this change might be Ok, but
I am not sure if it adds much improvement.

I will wait for an ack/nack from somebody who use svnimport and
know it well.

BTW, I do not appreciate the first six lines of your message
being _before_ the proposed commit log message.  Please have it
between "---\n" (that comes immediately after your own
"Signed-off-by:") and the diffstat, like this:

        This add '-S' option. When specified svn-import will try to...
        ... in usual way.

        Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
        ---

          Hi,

          This feature was useful with importing https://openib.org/svn/gen2 .

          Sasha

         git-svnimport.perl |   31 ++++++++++++++++++++-----------
         1 files changed, 20 insertions(+), 11 deletions(-)

         diff --git a/...
