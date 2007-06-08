From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: how to properly import perforce history...
Date: Fri, 8 Jun 2007 16:22:36 -0400
Message-ID: <20070608202236.GJ25093@menevado.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 22:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwkyn-0007PY-5c
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 22:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968877AbXFHUWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969242AbXFHUWj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 16:22:39 -0400
Received: from pivsbh1.ms.com ([199.89.64.101]:62995 "EHLO pivsbh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966874AbXFHUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 16:22:38 -0400
Received: from pivsbh1.ms.com (localhost [127.0.0.1])
	by pivsbh1.ms.com (Postfix) with ESMTP id 5AF885071
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 16:22:37 -0400 (EDT)
Received: from ny16im01.ms.com (unknown [144.14.206.242])
	by pivsbh1.ms.com (internal Postfix) with ESMTP id 39D494F69
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 16:22:37 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im01.ms.com (Sendmail MTA Hub) with ESMTP id l58KMaE04074;
	Fri, 8 Jun 2007 16:22:36 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l58KMa7V013535; Fri, 8 Jun 2007 16:22:36 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49496>


Very new to git.  Was hoping this would be much more straightforward and I'm
assuming I'm just missing something fundamentally easy.

I'm using git-p4import.py which came with my release of git.

I have a small project I'd like to move from perforce to git ( 111 files, 165
revisions ).

I've used a number of different approaches to do this, all of them resulting
in my files being deleted.

1)
$ git init
$ git-p4import //depot/path master

bombs out with missing .git/index

2)
$ p4 sync ...
$ git init
$ git add .
$ git commit
$ git-p4import --stitch //depot/path

This imports all the comment history, but deletes all of my files!!

3)
$ p4 sync ...
$ git init
$ git add .
$ git commit
$ git-p4import //depot/path new
### new branch with no files, but all my files in master
$ git checkout master
$ git merge new
### Now I see it deleting all of my files, but it pulls in all of the history. 


NOTE:  All of the commits pulled in have no file information associated with
them...


What am I missing?


Thanks

--Kevin
