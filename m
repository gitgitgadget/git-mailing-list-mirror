From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Git does not use GIT_* envirnment vars?
Date: Fri, 27 May 2005 01:09:44 -0500
Message-ID: <200505270109.44302.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 27 08:08:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbY1C-0002WR-GZ
	for gcvg-git@gmane.org; Fri, 27 May 2005 08:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVE0GKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 02:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVE0GKN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 02:10:13 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:33673 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261883AbVE0GJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 02:09:46 -0400
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@68.21.93.207 with login)
  by smtp814.mail.sc5.yahoo.com with SMTP; 27 May 2005 06:09:46 -0000
User-Agent: KMail/1.8
Content-Disposition: inline
X-UID: 27
X-Length: 1442
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I am totally confused... This is with today's cogito pull. It does not seem
to take GIT_ environment variables, although according to debugger it puts
correct data when writing object... Anybody else seeing this?  

[dtor@anvil kernel]$ mkdir git-test
[dtor@anvil kernel]$ cd git-test/
[dtor@anvil git-test]$ git-init-db
defaulting to local storage area
[dtor@anvil git-test]$ git-write-tree
4b825dc642cb6eb9a060e54bf8d69288fbee4904
[dtor@anvil git-test]$ git-commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
test
413398e6c1b53a0993cb195209c4d0e6276bb076
[dtor@anvil git-test]$ git-cat-file commit 413398e6c1b53a0993cb195209c4d0e6276bb076
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
author Dmitry Torokhov <dtor@anvil.corenet.prv> 1117173530 -0500
committer Dmitry Torokhov <dtor@anvil.corenet.prv> 1117173530 -0500

test
[dtor@anvil git-test]$ export | grep GIT
declare -x GIT_AUTHOR_EMAIL="dtor_core@ameritech.net"
declare -x GIT_COMMITTER_EMAIL="dtor_core@ameritech.net"
declare -x GIT_COMMITTER_NAME="Dmitry Torokhov"

-- 
Dmitry
