From: Gerrit Pape <pape@smarden.org>
Subject: git branch --track and remote branches with / in the name
Date: Tue, 5 Jun 2007 09:04:04 +0000
Message-ID: <20070605090404.24707.qmail@b58755fd627261.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 11:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvUxG-0004sK-DG
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143AbXFEJDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761905AbXFEJDp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:03:45 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:48876 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757143AbXFEJDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:03:45 -0400
Received: (qmail 24708 invoked by uid 1000); 5 Jun 2007 09:04:04 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49171>

Hi, the --track option to git branch or git checkout doesn't work for
remote branches that contain a slash in the name:

 $ tail -n6 .git/config
 [remote "origin"]
         url = /tmp/repo
         fetch = +refs/heads/*:refs/remotes/origin/*
 [branch "master"]
         remote = origin
         merge = refs/heads/master
 $ git branch -r
   origin/HEAD
   origin/b
   origin/foo/b
   origin/master
 $ git branch --track b origin/b    
 Branch b set up to track remote branch refs/remotes/origin/b.
 $ git branch --track foo/b origin/foo/b
 $ tail -n6 .git/config
 [branch "master"]
         remote = origin
         merge = refs/heads/master
 [branch "b"]
         remote = origin
         merge = refs/heads/b
 $ 

Regards, Gerrit. 
