From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 0/4] add write-tree --missing OK, fix cogito -N options
Date: Sun, 10 Jul 2005 23:53:15 -0400
Message-ID: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:53:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpMC-0008EY-V5
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVGKDxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVGKDxQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:53:16 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:36705 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262212AbVGKDxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:53:15 -0400
Received: (qmail 17013 invoked from network); 11 Jul 2005 03:53:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=d/Sw4KclOBBzkDRGUjos+3ZRhPlMxcDbRJm4Ldf5/oql02Hovc7XAjqeqkQ3EcjD6jCjGMqw5kO5p+xBmsNg2apRIfMIhzcVpj8QM3nPVafEajPy0jV52MZo9pXX7F/S0JZ4NpK30j9k1dNMggUBHLenFPk+xQ0ihG4QQBPkjFw=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp108.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 03:53:10 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All of my patches have been applied to git and cogito except for the
first one, the patch that adds the --no-check option to
git-write-tree.  This is problematic because one of the patches that
Petr applied to cogito requires git-write-tree --no-check.

As well, there are two bugs in cg-init:  the one that Joel Becker
found, plus the -N option needs to be passed to cg-commit.

Finally, Junio suggested that the --no-check option be renamed to
--missing-ok.

These patches fix the situation up.

1/4: bugfix for cg-init ARGV
2/4: bugfix for cg-init.
3/4: add --missing-ok option to git-write-tree.
4/4: change cg-commit to use --missing-ok instead of --no-check.
