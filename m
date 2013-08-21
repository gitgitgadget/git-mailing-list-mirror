From: Tim Chase <git@tim.thechases.com>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Tue, 20 Aug 2013 19:11:53 -0500
Message-ID: <20130820191153.377e93d1@bigbox.christie.dr>
References: <20130814124933.77b51a04@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 02:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBw0W-0005zS-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 02:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab3HUAKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 20:10:36 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:38917 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762Ab3HUAKf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Aug 2013 20:10:35 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:43350 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1VBw0Q-0002pQ-L1
	for git@vger.kernel.org; Tue, 20 Aug 2013 19:10:34 -0500
In-Reply-To: <20130814124933.77b51a04@bigbox.christie.dr>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232672>

On 2013-08-14 12:49, Tim Chase wrote:
>   c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"
> 
> but get various failures.  My best-effort (above) gets me as far as
> actually starting some sort of clone but it dies with
> 
> """
> Permission denied: Can't open '/tmp/report.tmp': Permission denied 
> at /usr/lib/perl5/site_perl/Git/SVN.pm line 1210
> """
> 
> PS: I don't really care much about pushing back to svn, existing
> svn branches or tags, or username mapping.  If needed, I can apply
> patches out of git which is far less painful than switching/merging
> branches in svn.  So I can be a little rough-shod with cloning the
> svn repo.
> 
> PPS: in case it matters:
> C:\work\utils\temp\ios>git version
> git version 1.8.3.msysgit.0

Just tickling this thread.  I tried John Keeping's suggestions on
setting TMPDIR to some known location, but I continue getting the same
error about "Can't open '/tmp/report.tmp': Permission denied..." both
in cmd.exe and within the bash.exe that comes with msysgit.

In additional peculiarity from my testing, if I point a true Linux
shell at the same network-mounted drive, it seems to work just fine:

  tim@host:/tmp$ git svn clone file:///mnt/svnroot/trunk/utils/project1
  tim@host:/tmp$ git --version
  git version 1.5.6.5

(yeah, that's a REALLY ancient version of git on an old Debian Lenny
box, but if *that* works, 1.8.x shouldn't have ANY trouble with it)

Any further ideas?

-tkc
