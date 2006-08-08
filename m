From: Shawn Pearce <spearce@spearce.org>
Subject: Since when is a tag a commit?
Date: Mon, 7 Aug 2006 22:12:51 -0400
Message-ID: <20060808021251.GA19548@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 08 04:13:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAH5c-0002oR-Iw
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 04:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHHCM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 Aug 2006 22:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHHCM7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 22:12:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26028 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751185AbWHHCM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 22:12:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GAH5J-0004MY-9w
	for git@vger.kernel.org; Mon, 07 Aug 2006 22:12:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0E0DB20FB77; Mon,  7 Aug 2006 22:12:51 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25057>

Current `next`:

  [spearce@pb15 git]$ git cat-file commit v1.4.1
  tree 34c8f9c263c1c20592d3f56c3d86bea322577155
  parent 6631c73685bea3c6300938f4900db0d0c6bee457
  author Linus Torvalds <torvalds@osdl.org> 1151691633 -0700
  committer Junio C Hamano <junkio@cox.net> 1151803695 -0700
  ...

Uhhh, that's a tag.  I know it is:

  [spearce@pb15 git]$ git cat-file tag v1.4.1
  object 0556a11a0df6b4119e01aa77dfb795561e62eb34
  type commit
  tag v1.4.1
  tagger Junio C Hamano <junkio@cox.net> 1151818415 -0700
  ...

And I know its not a tree:

  [spearce@pb15 git]$ git cat-file tree v1.4.1
  100644 .gitignore{?MX~=C4=83????y?v?X?u100644 COPYINGo?...

So it better not be a blob:

  [spearce@pb15 git]$ git cat-file blob v1.4.1
  fatal: git-cat-file v1.4.1: bad file

What the heck is going on?  Since when did git cat-file happily
consider a tag to be a tag, a commit and a tree?  Its that
intentional that we're peeling back the object to the requested type?

--=20
Shawn.
