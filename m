From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn dcommit fail
Date: Thu, 05 Jul 2007 00:11:24 -0700
Message-ID: <468C999C.60701@midwinter.com>
References: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 09:11:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6LUt-0004Mw-Q1
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 09:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbXGEHLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbXGEHLZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 03:11:25 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:38101
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1756168AbXGEHLY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 03:11:24 -0400
Received: (qmail 11133 invoked from network); 5 Jul 2007 07:11:24 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=hZfc2pn++VWhGRsrZ9LIHGA8nntdEL5qNRpPVpWMV6yKgXMh+i1wfSlRVdWNz974  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 5 Jul 2007 07:11:23 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51662>

Dongsheng Song wrote:
> After some merge operation,

git-svn doesn't support nonlinear history in any of the official 
releases, though there will be some support in the next release (you can 
try it out by grabbing the latest version from git.git's master branch). 
If you don't want to run a prerelease version of git, you need to avoid 
doing non-squash merges into branches that you are going to check into 
an svn repository.

Squash merges (git merge --squash) work fine, though. They will be 
recorded in your history as a regular commit, not a merge, so git-svn 
won't be confused by them.

-Steve
