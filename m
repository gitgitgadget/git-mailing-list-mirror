From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Mon, 12 Mar 2007 08:24:19 +0100
Message-ID: <45F50023.9030403@dawes.za.net>
References: <45F4F58D.2010701@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 12 08:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQetO-00081n-I8
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 08:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbXCLHYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 03:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbXCLHYX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 03:24:23 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:60604 "EHLO
	spunkymail-a15.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965238AbXCLHYW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2007 03:24:22 -0400
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a15.dreamhost.com (Postfix) with ESMTP id B54C87F024;
	Mon, 12 Mar 2007 00:24:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <45F4F58D.2010701@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42012>

Rogan Dawes wrote:
> Hi folks,
> 
> I am trying to use git to track the Spring Rich Client project's SVN 
> repository, along with some local changes. I am using git 1.5.0.3 as 
> packaged by Cygwin, on Windows XP SP2.
> 
> The repo's URL is:
> 
> <http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/trunk/spring-richclient> 
> 
> 
> I start the import using:
> 
> git svnimport -v $url
> 
> and then wait (and wait and wait). For some reason, revision 5 takes 
> over an hour to complete, from version 4. The repo is not substantial 
> (when it eventually fails on rev 102, the unpacked repo is only 148kB).
> 
> In addition, it does not complete the import successfully.
> 
> Eventually (I left it running while I slept), it crashes on rev 102 with 
> the following message:
> 
> Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Committed change 102:/ 2004-08-03 04:53:31)
> Merge parent branch: ab10f9f06566e0fbdb3ee57d7489b53567f313d3
> Commit ID 722f84d2578f84a1b64904b0b425e02c0397c40e
> Writing to refs/heads/origin
> DONE: 102 origin 722f84d2578f84a1b64904b0b425e02c0397c40e
> RA layer request failed: REPORT request failed on 
> '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': REPORT of 
> '/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': 200 OK 
> (http://spring-rich-c.svn.sourceforge.net) at /usr/bin/git-svnimport 
> line 955
> 
> Any ideas what might be going on? Or suggestions for debugging this 
> further?
> 
> Many thanks
> 
> Rogan
> 
> P.S. It also looks like Rev 4-5 takes quite a long time under Linux as 
> well, from initial analysis.

Another data point:

I ran it on a Linux server I have access to, and it got further (rev 
147), but still failed. The error message was different, though:

Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 147:/ 2004-08-12 18:23:53)
Merge parent branch: 1f053b959bdee167f328cf98116179358d80fef9
Commit ID ef57373cfd1ef6ddf797a4b5ea66de6465391789
Writing to refs/heads/origin
DONE: 147 origin ef57373cfd1ef6ddf797a4b5ea66de6465391789 at Mon Mar 12 
06:40:47 2007
RA layer request failed: REPORT request failed on 
'/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': REPORT of 
'/svnroot/spring-rich-c/!svn/bc/1001/trunk/spring-richclient': Could not 
read response body: connection was closed by server. 
(http://spring-rich-c.svn.sourceforge.net) at 
/home/rdawes/bin/git-svnimport line 955

Rogan
