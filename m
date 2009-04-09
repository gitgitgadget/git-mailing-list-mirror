From: Jim Babka <jim@babkas.info>
Subject: git svn hangs
Date: Thu, 09 Apr 2009 11:51:34 -0500
Message-ID: <49DE2796.4090406@bestmail.us>
Reply-To: babka@bestmail.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 18:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrxVE-0003yj-Fc
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 18:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764292AbZDIQvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759397AbZDIQvf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 12:51:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:48201 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbZDIQve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 12:51:34 -0400
Received: by yw-out-2324.google.com with SMTP id 5so725165ywb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 09:51:32 -0700 (PDT)
Received: by 10.90.88.16 with SMTP id l16mr3224168agb.112.1239295892069;
        Thu, 09 Apr 2009 09:51:32 -0700 (PDT)
Received: from ?9.53.51.163? ([32.97.110.53])
        by mx.google.com with ESMTPS id 1sm608914agb.74.2009.04.09.09.51.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 09:51:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116180>

I need some help. I have tried both the native Windows git (git version 
1.6.2.2.1669.g7eaf8, coming from Git-1.6.2.2-preview20090408) and the 
git in Cygwin (git version 1.6.1.2), but I see almost the same behavior. 
I try to run the following command and see the following results:

------- From the git bash that comes with the windows git -----------
babka@CUBEARS /c/GIT
$ git svn clone -s http://wbsfsvn.austin.ibm.com/svn/wbsf .
Initialized empty Git repository in C:/GIT/.git/
Authentication realm: <http://wbsfsvn.austin.ibm.com:80> w3
Password for 'babka':
Authentication realm: <http://wbsfsvn.austin.ibm.com:80> w3
Username: babka@us.ibm.com
Password for 'babka@us.ibm.com':

babka@CUBEARS /c/GIT (master)
$ git svn clone -s --username babka@us.ibm.com 
http://wbsfsvn.austin.ibm.com/svn/wbsf .
C:\Program Files\Git\bin\perl.exe: *** WFSO timed out


babka@CUBEARS /c/GIT (master)
--------------------------
----- From Cygwin bash ----
$ git svn clone -s --username babka@us.ibm.com 
http://wbsfsvn.austin.ibm.com/svn/wbsf
Initialized empty Git repository in /cygdrive/c/GIT/wbsf/.git/
Authentication realm: <http://wbsfsvn.austin.ibm.com:80> w3
Password for 'babka@us.ibm.com':

babka@cubears /cygdrive/c/GIT
--------------

In the first case, I did forget my user name the first time, but it 
asked again and the second time I got it right. In both cases, after I 
entered the password, the command hung for a while. The first time, 
after 5 minutes, I killed the command and ran it again - that second 
time it did not prompt for the user name or password. In both cases, 
when I just let the command run, it hung for an hour or so, and then 
returned without doing anything. The only indication of any problem in 
the Windows native git was that "WFSO timed out" message. There was no 
such message on cygwin - it just hung for an hour, then returned. After 
the command finishes, the directory has nothing but a ".git" directory 
in it. None of the source code from my SVN repository is there.

I am completely stuck here. I have no useful error messages to look at, 
so there is no indication of why I'm having any problem. Can anyone help 
ne here?

By the way, here are the stats for my SVN installation (which works just 
fine):

--------------------------------------------
svn, version 1.5.5 (r34862)
   compiled Dec 23 2008, 12:42:22

Copyright (C) 2000-2008 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet 
(http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using 
Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network 
protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
----------------------------------------------

Jim Babka.
