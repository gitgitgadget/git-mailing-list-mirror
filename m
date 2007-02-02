From: Matt Mackall <mpm@selenic.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 10:03:17 -0600
Message-ID: <20070202160317.GX10108@waste.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702021055.49428.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 17:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD14p-0006wk-CR
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbXBBQPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbXBBQPs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:15:48 -0500
Received: from waste.org ([66.93.16.53]:56773 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945963AbXBBQPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:15:47 -0500
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l12G3H2w028937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 2 Feb 2007 10:03:18 -0600
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l12G3Hvu028935;
	Fri, 2 Feb 2007 10:03:17 -0600
Content-Disposition: inline
In-Reply-To: <200702021055.49428.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38511>

On Fri, Feb 02, 2007 at 10:55:48AM +0100, Jakub Narebski wrote:
> How Mercurial solves problem of multiple _persistent_ branches? Does it
> add pointers to commits somewhere deeper in changelog / revlog?

Each changeset may have a branch marker.

Here's branches in use with an import of mutt's CVS history:

$ hg branches
mutt-0-94                      208:b2cc0abd8fe0
HEAD                           207:a505693b54c1
mutt-0-93                      134:d59345944030
muttintl                       1:29510de8b3fc
$ hg co HEAD
176 files updated, 0 files merged, 8 files removed, 0 files unresolved
$ hg branch
HEAD
$ hg branch devel
$ hg branch
devel
$ hg branch devel

> BTW does Mercurial have tags?

Yes. Both local and revision-controlled.

> Nice to know. You compress only file deltas, or also file revision
> metadata? Do you compress manifests (trees) and commits (or at least
> commit messages) too?

All three use the same underlying storage format, so yes.

-- 
Mathematics is the supreme nostalgia of our time.
