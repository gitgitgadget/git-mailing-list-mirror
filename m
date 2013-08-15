From: Tim Chase <git@tim.thechases.com>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Thu, 15 Aug 2013 06:12:29 -0500
Message-ID: <20130815061229.24dfe891@bigbox.christie.dr>
References: <20130814124933.77b51a04@bigbox.christie.dr>
	<20130814182657.3c03c5df@bigbox.christie.dr>
	<20130815080058.GM2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Aug 15 13:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9vSn-0000Qm-UF
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 13:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab3HOLL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 07:11:28 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:41375 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756244Ab3HOLLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Aug 2013 07:11:09 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:48703 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1V9vSO-0006vV-98; Thu, 15 Aug 2013 06:11:08 -0500
In-Reply-To: <20130815080058.GM2337@serenity.lan>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232341>

On 2013-08-15 09:00, John Keeping wrote:
> On Wed, Aug 14, 2013 at 06:26:57PM -0500, Tim Chase wrote:
> > On 2013-08-14 12:49, Tim Chase wrote:
> > > If it makes any difference, this is within a cmd.exe shell (with
> > > $PATH set appropriately so git is being found).
> > 
> > Just a follow-up, I tried it within the "bash"ish shell included
> > in the git install and got the same error regarding
> > "/tmp/report.tmp".
> 
> It seems that report.tmp is something that SVN creates and for some
> reason the svn on your system is trying to create it in a Unix style
> temporary directory.
> 
> What happens if you export TMPDIR=C:/Windows/Temp before running
> git-svn?

Still getting the same results.  I tried:

1) cmd.exe with my local temp dir:
 c:\temp> TEMPDIR=%TEMP%
 c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"

2) cmd.exe with the windows temp dir as you specify:
 c:\temp> TEMPDIR=c:\windows\temp
 c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"

3) git's bash.exe with inline variable definition:
 $ TEMPDIR=c:/Windows/Temp git svn clone "file:///x:/path/to/repo/trunk/utils/project1"

4) git's bash.exe with exported variable:
 $ export TEMPDIR=c:/Windows/Temp
 $ git svn clone "file:///x:/path/to/repo/trunk/utils/project1"

All of them died with the complaint about "/tmp/report.tmp"

Thanks for the suggestion though.  At least we've determined one
thing that *isn't* the issue ;-)

-tkc
