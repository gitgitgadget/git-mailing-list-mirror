From: Petr Baudis <pasky@ucw.cz>
Subject: Removing redundant packs
Date: Sat, 8 Dec 2007 13:50:50 +0100
Message-ID: <20071208125050.GA17478@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 13:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0z9I-0003ey-2r
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbXLHMu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 07:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbXLHMuz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:50:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47445 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbXLHMuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 07:50:55 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id C0F085A76C; Sat,  8 Dec 2007 13:50:50 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67552>

  Hi,

  before exporting whole repo.or.cz over rsync for mirroring, I would
like to clean up the worst repositories (esp. linux-2.6 repositories)
whose objects database looks absolutely horrible now.

  At the same time, I have to be careful not to prune all unreferenced
objects since they can be referenced in forks.

  How would you go about it? My idea was to do a fresh cummulative pack
of all referenced objects with

	git repack -a

and then remove packs that contain _only_ objects that are already in
the fresh pack. But I have trouble with the second step; a very naive
grep loop ran for about a day when I stopped it and it was nowhere near
the half of the packs yet. I didn't figure out how to make use of
git-pack-redundant either.

  Does anyone have any hints?

  Thanks!

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
