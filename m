From: Shawn Pearce <spearce@spearce.org>
Subject: gitweb/test/Marchen always untracked?
Date: Sat, 8 Jul 2006 14:53:22 -0400
Message-ID: <20060708185322.GA17708@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 08 20:53:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHvv-0005c3-Dw
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWGHSxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Jul 2006 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWGHSxg
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:53:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26784 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964960AbWGHSxf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 14:53:35 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FzHvc-00032e-Ss
	for git@vger.kernel.org; Sat, 08 Jul 2006 14:53:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 48D5920E482; Sat,  8 Jul 2006 14:53:22 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23496>

I'm not sure what is going on here but on my Mac OS X system
the file `gitweb/test/Marchen` is always untracked:

  [spearce@spearce-pb15 git]$ git status
  # On branch refs/heads/sp/work
  #
  # Untracked files:
  #   (use "git add" to add to commit)
  #
  #       gitweb/test/Ma=CC=88rchen
  nothing to commit
 =20
  [spearce@spearce-pb15 git]$ git-ls-files | grep chen
  "gitweb/test/M\303\244rchen"
 =20
  [spearce@spearce-pb15 git]$ ls -l gitweb/test/Ma\314\210rchen=20
  -rw-r--r--   1 spearce  spearce  17 Jul  8 14:38 gitweb/test/Ma??rche=
n

At first glance it would appear as though the file is encoded into
the tree (and thus the index) one way and the OS is reporting it
another way during a readdir.  Which is leaving me scratching my
head...

--=20
Shawn.
