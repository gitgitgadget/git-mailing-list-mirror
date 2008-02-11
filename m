From: David Madore <david.madore@ens.fr>
Subject: Re: referencing a revision at a certain date
Date: Mon, 11 Feb 2008 19:57:13 +0100
Message-ID: <20080211185713.GA16898@clipper.ens.fr>
References: <20080211180424.GA4905@clipper.ens.fr> <m3r6fje3q8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: GIT mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdqi-000783-NV
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbYBKS5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYBKS5R
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:57:17 -0500
Received: from nef2.ens.fr ([129.199.96.40]:2919 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbYBKS5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:57:16 -0500
Received: from clipper.ens.fr (clipper-gw.ens.fr [129.199.1.22])
          by nef2.ens.fr (8.13.6/1.01.28121999) with ESMTP id m1BIvD0v021693
          ; Mon, 11 Feb 2008 19:57:13 +0100 (CET)
Received: from (madore@localhost) by clipper.ens.fr (8.13.1/jb-1.1)
Content-Disposition: inline
In-Reply-To: <m3r6fje3q8.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.1.4 (nef2.ens.fr [129.199.96.32]); Mon, 11 Feb 2008 19:57:13 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73564>

On Mon, Feb 11, 2008 at 10:40:39AM -0800, Jakub Narebski wrote:
> But you can can get commit closest to given date by combining the time
> limiting with limiting number of commits, as described in "Commit
> limiting" in git-rev-list(1) and git-log(1) manpages.
> 
>   $ git log -n 1 --before=<date> <branch>
> 
> which would return first commit older than <date>, starting from
> <branch>.

OK, thanks, I guess the --before part answers my question: so to get
revision "rev" back at date "YYYY-MM-DD" (always using first parents)
I'd do

git rev-list rev -n 1 --first-parent --before=YYYY-MM-DD

as in:

git checkout "`git rev-list rev -n 1 --first-parent --before=YYYY-MM-DD`"

It's a bit of a mouthful, but it does what I want (although I still
think a syntax such as rev~@{YYYY-MM-DD} or rev~{YYYY-MM-DD} or
whatever might prove useful: I imagine I'm not the first person to
wish for something of the sort).

Thanks,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
