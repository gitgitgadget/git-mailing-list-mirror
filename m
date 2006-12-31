From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: SIGSEGV in merge recursive
Date: Sat, 30 Dec 2006 18:13:55 -0800 (PST)
Message-ID: <308309.87460.qm@web31805.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:14:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qD3-00015x-GD
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWLaCN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWLaCN4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:13:56 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:42146 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932672AbWLaCN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Dec 2006 21:13:56 -0500
Received: (qmail 87546 invoked by uid 60001); 31 Dec 2006 02:13:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ZqM/EG/l4NOpdJQ+/ft3g0DEB0nK6jxrZecVjUung5cAdcHE72sensf4bKPK+MBO3QW06B5ZwufSvvnFlU4/hK4M440le0L9g5xk3HOWpBw4uXJcCbPKni5/KhdEp3dehukFkmTYg5nfBMFvgEiRQG0l7QlGSX96jvJjz5e42bs=;
X-YMail-OSG: uyRzqJgVM1lok2ftNMKf2empmZfXrSDbdkjKmxUcgqOwtET7fqrqkn6wvyLjYDoxUO27L3plO96DDumZuY.x8OYtUzgT97Lign0r8N.2Em7rrGGZOPgsqN7N1GWLqh1AO9lWnVbi5BHa2.2PpxC9iLSLkRby_p.5ytWn8h_Di6Uz.WnirHx1BP2t
Received: from [71.84.31.238] by web31805.mail.mud.yahoo.com via HTTP; Sat, 30 Dec 2006 18:13:55 PST
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35651>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Besides, Alexandre hit an interesting bug, which is not at all easy to 
> reproduce (except with three 70k files which I don't want to include in 
> the test set). Since Alexandre provided _examples_ where I can _reproduce_ 
> the problem, I will be working on that bug, and not yours.

After compiling and installing "master" I was able to do the pull/merge.
The only conflict was in .gitignore, and it was that same conflict that
was causing the segfault.  Normally (99% of the time) I pull
"next" into branchA (git-upstream), then I pull branchA into branchB (git-lt-work).
Both have various fixes, but I normally install and use branchB (git-lt-work).

It appears that that fix was in "next" which I hadn't already merged, and running
with an old "next" didn't allow me to the the "merge" since the fix for it was
in the "next" I was trying to merge...

Thus I needed to install "master" as is ("next" as is, would've worked just
as well), which contains the fix for the merge, so that I can merge the
branch which contains the fix ("next"/branchA).

I tested this and tried the exact same merge, with the newly merged and installed
branchB/git-lt-work, and it did work.

So it's all good now.  Thanks!
   Luben
