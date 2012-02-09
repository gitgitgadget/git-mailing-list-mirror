From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: ANNOUNCE: Git for Windows 1.7.9
Date: Thu, 09 Feb 2012 08:45:19 +0100
Message-ID: <4F33798F.2010908@atlas-elektronik.com>
References: <CABNJ2GJ-Jtpg=HsB9TmvLskmB9xXSeshHXz8V9koJfvMp5WNvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <blees@dcon.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 08:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvOpu-0004fR-EL
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 08:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab2BIHyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 02:54:08 -0500
Received: from mail96.atlas.de ([194.156.172.86]:10797 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab2BIHyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 02:54:07 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Feb 2012 02:54:06 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id DD9E510060;
	Thu,  9 Feb 2012 08:45:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id 8tfxpx4p2Zdj; Thu,  9 Feb 2012 08:45:20 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu,  9 Feb 2012 08:45:20 +0100 (CET)
Received: from [10.200.54.97] (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 5FA7927180;
	Thu,  9 Feb 2012 08:45:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <CABNJ2GJ-Jtpg=HsB9TmvLskmB9xXSeshHXz8V9koJfvMp5WNvA@mail.gmail.com>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190277>

Am 01.02.2012 12:23, schrieb Pat Thoyts:
> This release brings the latest release of Git to Windows users.
> 
> Pre-built installers are available from
> http://code.google.com/p/msysgit/downloads/list
> 
> Further details about the Git for Windows project are at
> http://code.google.com/p/msysgit/

I'm getting errors from 'git repack -Ad' with this version on Windows XP:

$ /bin/git repack -Ad
Counting objects: 147960, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (35552/35552), done.
Writing objects: 100% (147960/147960), done.
Total 147960 (delta 110699), reused 147960 (delta 110699)
Deletion of directory '.git/objects/01/' failed. Should I try again? (y/n)
Deletion of directory '.git/objects/05/' failed. Should I try again? (y/n) n
Deletion of directory '.git/objects/07/' failed. Should I try again? (y/n) n
Deletion of directory '.git/objects/0c/' failed. Should I try again? (y/n) n
Deletion of directory '.git/objects/10/' failed. Should I try again? (y/n)
....


A bisection pointed me to this commit (https://github.com/msysgit/git/commit/19d1e75):

 "Win32: Unicode file name support (except dirent)"

When I reset "/git" to this commit and recompile, 'git gc' and 'git repack -Ad'
don't raise this error anymore.

Any ideas ?


Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: To save trouble later, Joe named his cat Roadkill Fred
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
