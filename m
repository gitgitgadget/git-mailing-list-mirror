From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: speeding up git-svn when directories are copied?
Date: Mon, 23 Apr 2007 16:16:01 +0200
Message-ID: <20070423141601.GA5797@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:16:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfzL1-0005mP-7h
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXDWOQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbXDWOQK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:16:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2828 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbXDWOQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 10:16:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HfzKj-0001ZK-00; Mon, 23 Apr 2007 15:16:01 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45323>

When importing a whole repository, git-svn currently takes a _lot_ of
time. Almost all of it seems to be spent getting the full text of each
and every file when a tag or new branch is created.

If I remember correctly (but it was quite a while since I looked at
it), git-svnimport didn't ask the Subversion server for all the files;
it just noticed when the server said that a new directory was a copy
of an old directory, which makes them just as fast as any other commit
that doesn't change a gazillion files. (I've had an import running for
a few hours now, and have checked on it about a dozen times; every
single time, it was importing a new tag or branch. This suggests that
making these go as fast as regular commits would speed up the import
by more than a factor 10.)

Have you looked at doing this with git-svn? If it's not on your to-do
list, I might take a stab at it at some point. But I only speak the
copy-n-paste dialect of perl, so I'll need to find a largish block of
uninterrupted time first. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
