From: "Harald Heigl" <Harald@heigl-online.at>
Subject: Project structure of .NET-Projects using git submodule or something different
Date: Tue, 31 Jan 2012 23:41:23 +0100
Message-ID: <002401cce069$75ecc1a0$61c644e0$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsMUq-0004uD-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab2AaWsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:48:10 -0500
Received: from xserv02.internex.at ([85.124.51.102]:33591 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753786Ab2AaWsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 17:48:09 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jan 2012 17:48:08 EST
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 9753 invoked from network); 31 Jan 2012 22:41:24 -0000
Received: by simscan 1.4.0 ppid: 9744, pid: 9750, t: 0.1162s
         scanners: clamav: 0.97.3/m:54/d:14383
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 31 Jan 2012 22:41:24 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AczgZe7VXkiBdsw5S5KA6p//DAdiMw==
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189479>

Hi, I'm searching for an adequate Project-structure for our .NET-Projects,
but I think the problem isn't specific to .NET-Programs, it's more "how can
I nest submodules toghether".

Let's assume following Project structure (Dependencies and Subdependencies
are submodules and submodules of the submodules)
Project
	Dependency 1
		Dependency 2
		Dependency 3
	Dependency 4
	Dependency 2


The problem is if I want to build them I need to build 2+3, then 1, 4 and 2
again and then the project. As you may see project 2 is a submodule of
dependency 1 and also of project. I don't feel comfortable with this setup.
What do you think?
I've also thought about symlinks (though I'm mainly on Windows ), but with
symlinks I'll lose the tight coupling of git submodules by SHA1-revision.
I could also add Dependency 1-4 to my main project, not loading submodule
2-3 within  dependency 1, but then the Project-Files of .NET for dependency1
may change depending if I clone Dependency1 on its own or if I clone my
superproject.

Sometimes I have longer chains (project - submodule - subsubmodule - . ), so
it could easily be that I clone a superproject and 10 subprojects, even
though there are only 3-5 really different subprojects, rest would be
duplicates.

How would you handle this? Git submodules? Something different? 

Thanks in advance,
Harald
