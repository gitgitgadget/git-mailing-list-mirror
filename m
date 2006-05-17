From: Pavel Roskin <proski@gnu.org>
Subject: Re: Merge with local conflicts in new files
Date: Wed, 17 May 2006 03:47:32 -0400
Message-ID: <1147852052.31879.50.camel@dv>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	 <7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160605161611p4c9ddbc0v@mail.gmail.com>
	 <7vu07p35xn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Santi <sbejar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 09:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgGkv-00008C-Js
	for gcvg-git@gmane.org; Wed, 17 May 2006 09:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWEQHri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 03:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWEQHri
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 03:47:38 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:8601 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750764AbWEQHrh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 03:47:37 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgGkq-00082x-16
	for git@vger.kernel.org; Wed, 17 May 2006 03:47:36 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgGkm-0005jh-K6; Wed, 17 May 2006 03:47:32 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu07p35xn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20165>

Hello, Junio!

On Tue, 2006-05-16 at 16:28 -0700, Junio C Hamano wrote:
> Santi <sbejar@gmail.com> writes:
> 
> > 2006/5/17, Junio C Hamano <junkio@cox.net>:
> >>  - You have not told git that these files matter.
> >
> > For me it is the other way, all my files matter but git can do
> > whatever it wants with the ones it controls.
> 
> You really do not mean that.
> 
> If you told git a file matters, and have local modifications to
> the file in the working tree that you have not run update-index
> yet, merge and apply should be careful not to overwrite your
> changes that is not ready while doing whatever thing they have
> to do.  And they are careful, because you have told git that
> they matter, and the way you tell git that they matter is to
> have entries for them in the index.

I'm afraid this approach, while understandable from the technical
standpoint, could prevent git from ever becoming a version control
system that "just works" without any porcelains.

I know a person who refuses to use any version control.  If he
encountered this situation, he would never try any version control
again.

After all, we are talking about files in the _working_ directory.  It's
not merely a transient appendix to the repository.  git is not the only
player here.  If a file doesn't "belong" to git, it belongs to its
"supreme commander", i.e. the user, and should be approached with utmost
care.

Merging a branch should not cause an irreparable loss of user data.  The
same applies to other commands.  Exceptions can be made for commands
that are specifically meant to clean user data, for commands with
special options (e.g. --force or --hard), and for the files explicitly
marked as transient (e.g. in .gitignore).

-- 
Regards,
Pavel Roskin
